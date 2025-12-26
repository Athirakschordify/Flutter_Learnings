import Swal from 'sweetalert2';

const defaultConfig = {
    confirmButtonColor: '#8b5cf6',
    cancelButtonColor: '#6b7280',
    reverseButtons: true,
};

export const showAlert = {
    success: (message, title = 'Success!') => {
        return Swal.fire({
            ...defaultConfig,
            icon: 'success',
            title,
            text: message,
            confirmButtonText: 'OK',
            timer: 3000,
            timerProgressBar: true,
        });
    },

    error: (message, title = 'Error!') => {
        return Swal.fire({
            ...defaultConfig,
            icon: 'error',
            title,
            text: message,
            confirmButtonText: 'OK',
        });
    },

    warning: (message, title = 'Warning!') => {
        return Swal.fire({
            ...defaultConfig,
            icon: 'warning',
            title,
            text: message,
            confirmButtonText: 'OK',
        });
    },

    info: (message, title = 'Info') => {
        return Swal.fire({
            ...defaultConfig,
            icon: 'info',
            title,
            text: message,
            confirmButtonText: 'OK',
        });
    },

    confirm: (message, title = 'Are you sure?') => {
        return Swal.fire({
            ...defaultConfig,
            icon: 'question',
            title,
            text: message,
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No',
        }).then((result) => result.isConfirmed);
    },

    confirmDelete: (message, title = 'Delete?') => {
        return Swal.fire({
            ...defaultConfig,
            icon: 'warning',
            title,
            html: `<p style="color: #dc2626;">${message}</p>`,
            text: 'This action cannot be undone!',
            showCancelButton: true,
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'Cancel',
            confirmButtonColor: '#dc2626',
        }).then((result) => result.isConfirmed);
    },

    loading: (message = 'Please wait...') => {
        return Swal.fire({
            ...defaultConfig,
            title: message,
            allowOutsideClick: false,
            allowEscapeKey: false,
            showConfirmButton: false,
            didOpen: () => {
                Swal.showLoading();
            },
        });
    },

    toast: (message, icon = 'success') => {
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
        });

        return Toast.fire({ icon, title: message });
    },
};
