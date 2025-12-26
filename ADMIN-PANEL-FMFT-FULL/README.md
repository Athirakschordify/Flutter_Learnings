# FMFT Admin Panel

A premium, full-featured Admin Dashboard built with **React**, **Vite**, **Shadcn UI**, and **Redux Toolkit**. This project provides a modern, responsive interface for managing users, dashboards, and other administrative tasks.

## 🚀 Features

- **User Management**: View, add, edit, and delete users
- **Dashboard Analytics**: Interactive charts and data visualization using Recharts
- **Authentication**: Secure login with Redux state management and localStorage persistence
- **Dark/Light Mode**: Theme switching with global theme provider
- **Responsive Design**: Mobile-friendly UI built with Tailwind CSS
- **Form Validation**: Robust validation using Zod and React Hook Form
- **API Integration**: Axios-based API client with interceptors
- **Mock Data Support**: For development and prototyping

## 🛠️ Tech Stack

- **Frontend**: React 18, Vite
- **Styling**: Tailwind CSS, Shadcn UI
- **State Management**: Redux Toolkit
- **Routing**: React Router DOM
- **Forms**: React Hook Form, Zod
- **Charts**: Recharts
- **Icons**: Lucide React
- **HTTP Client**: Axios
- **Build Tool**: Vite
- **Linting**: ESLint

## 📋 Prerequisites

- Node.js (version 16 or higher)
- npm or yarn

## 🏁 Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd admin-panel-fmft-full
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Start the development server**:
   ```bash
   npm run dev
   ```

4. **Open your browser** and navigate to `http://localhost:5173`

## 📜 Scripts

- `npm run dev` - Start the development server
- `npm run build` - Build the project for production
- `npm run preview` - Preview the production build locally
- `npm run lint` - Run ESLint for code linting

## 🏗️ Project Structure

```
src/
├── api/              # API services and mock data
│   ├── apiClient.js  # Axios instance configuration
│   ├── authService.js
│   ├── dashboardService.js
│   ├── mockData.js
│   └── userService.js
├── assets/           # Static assets
├── components/       # Reusable UI components
│   ├── Sidebar.jsx
│   ├── ThemeProvider.jsx
│   └── TopBar.jsx
├── hooks/            # Custom React hooks
├── layouts/          # Layout components
│   └── AdminLayout.jsx
├── pages/            # Page components
│   ├── Dashboard.jsx
│   ├── Login.jsx
│   └── Users.jsx
├── store/            # Redux store and slices
│   ├── index.js
│   └── auth/
│       └── authSlice.js
├── utils/            # Utility functions
├── App.jsx           # Main app component with routing
├── index.css         # Global styles
└── main.jsx          # App entry point
```

## 🏗️ Technical Architecture

### 🛡️ Security & Auth
- **Redux State**: Managed via `authSlice.js` with persistence in `localStorage`.
- **Protected Routes**: Custom routing logic in `App.jsx` prevents unauthorized access.
- **Form Validation**: Type-safe validation using **Zod** and **React Hook Form**.

### 📡 API Layer
- **Axios Instance**: Configured in `src/api/apiClient.js` with global interceptors.
- **Service Pattern**: Domain-specific logic is encapsulated in `userService.js`, `dashboardService.js`, etc.
- **Mock Data**: Accessible via `src/api/mockData.js` for rapid prototype development.

### 🎨 Design System
- **Tailwind CSS**: Utility-first styling with custom tokens in `tailwind.config.js`.
- **Shadcn UI**: Accessible and beautifully styled components (cards, inputs, tables).
- **Dark Mode**: Native support with a global `ThemeProvider`.

## 🚀 Deployment

1. **Build the project**:
   ```bash
   npm run build
   ```

2. **Deploy the `dist` folder** to your hosting service (e.g., Vercel, Netlify, AWS S3).

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 Development Guidelines

### Comments & Documentation
- **JSDoc Style**: Use JSDoc comments for all exported services and complex functions.
- **Commit Messages**: Follow standard conventional commits for clarity.

### Theming
- Always use CSS variables (e.g., `text-primary`, `bg-background`) to ensure components work in both Light and Dark modes.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

- **Your Name** - [Your GitHub](https://github.com/yourusername)

## 📞 Contact

For questions or support, please contact [your-email@example.com]
