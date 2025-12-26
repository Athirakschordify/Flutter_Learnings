import { useSelector, useDispatch } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { useEffect } from 'react';
import { logoutUser, checkSession } from '@/store/slices/authSlice';
import { showAlert } from '@/lib/sweetalert';
import { TOAST_MESSAGES } from '@/constants';

export const useAuth = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const { user, isAuthenticated, loading, error } = useSelector((state) => state.auth);

    useEffect(() => {
        if (isAuthenticated) {
            dispatch(checkSession());

            const interval = setInterval(() => {
                dispatch(checkSession())
                    .unwrap()
                    .catch(() => {
                        showAlert.error(TOAST_MESSAGES.SESSION_EXPIRED);
                        dispatch(logoutUser());
                        navigate('/');
                    });
            }, 5 * 60 * 1000);

            return () => clearInterval(interval);
        }
    }, [isAuthenticated, dispatch, navigate]);

    const logout = async () => {
        await dispatch(logoutUser());
        showAlert.success(TOAST_MESSAGES.LOGOUT_SUCCESS);
        navigate('/');
    };

    return { user, isAuthenticated, loading, error, logout };
};
