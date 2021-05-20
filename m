Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21038B264
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhETPD0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 11:03:26 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:13357
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231330AbhETPDZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 11:03:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG8gaTfE5ta+G9LrjGMv1JXFKDrXnaKXGD9sMEwoiMu/f1tG0cTbyFwzZdVzfdoWJlukR1JVRUcBGZX3kxeLjn236jgMmFEp/jqfNV5chmf7n/fqPUnrWgav0jYFhbU43KQaoQDXBwpnzSXWWBhYOdV5nYb0rTY1tEySYoyrRWOqVJ4bzcf7ZZm51MIDjkWx9KdIsrrJ4tPQX4DXcW/A8mw2PR5BB7Fr0bVZ2Ke7eTPV3YPD6QQRLTnpJoeWMBt0+s0CZL0gvKpzT/ZTUT6UkOXON7M9qm9NlAhdqRo6qFRXj+r5NJnqoaJu914oqWMM2SCOtodjswLTFuh2WyQIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEJgi3eWAbp0TXWqSBwk0EvUI5v+f5iJ0yqIjpAf8/A=;
 b=i1WLtAEFdN0J2JoJN2hsUYpn/6KyGjRHTrm3lctIzlyL+tn+fOxst68bBA2fYsOw0wnzGoE6V8gDsRzEK4FIDEdBaHSfVfcs8Fka+W/xXlH+i5F0flhkuAFxEaJoYw3sMTksP7b7s/PR8hCnrYBmUggvUjtpmmisNpUOOMPOW45aR1It4+y+MM0f8Iwyzd/8cpKWk3tnmadJ5nB/S+Sz31q4OHODYP0N47ymktBAxUabg7705v2vAYlsJ0tiZ8OqgisOUl0xhciyf/AoXIal8KtSSZCcmLw1h4rlNQIbkWYwQZ+j3RjUJgMeGTwPZef+6aIQ8c9VYKlH9pogtZIypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEJgi3eWAbp0TXWqSBwk0EvUI5v+f5iJ0yqIjpAf8/A=;
 b=WVhSozNYXQiFUhjKt4gbLeujR37kpC1Tj8C/ydwuI8jjKJ0s33HQ4qJLWFL/aDSrMhvrgzlKIcUJKJOHWJ63paGDIqIGb+W+vvGUMloawzVfr94yXMVfeJgx4ooVlGOKEzLlkI4eJGGOEWhHaVLojZ+ljBHuyLAePWYcc6LlkDXi2gvLIXM3ZnuCGvJ2/1rZjMQ92p2ED1k0yxJs1DV5QEJjvAKc947yqEGSTxNYMvE6JCQYUnop860j7DfKPr9KFyyKp/uJFG7meWQvFIFQMeS+HeK6G+sySm0DFRR3VgcgtN5Vd+AOPaOfviGRAIHjjBFEbDegbKYTAAE6qYMBUQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 15:02:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 15:02:03 +0000
Date:   Thu, 20 May 2021 12:02:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Evgenii Kochetov <evgeniik@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sergey Gorenko <sergeygo@nvidia.com>
Subject: Re: [PATCH rdma-next 0/2] Add support to SQD2RTS transition
Message-ID: <20210520150201.GA2734122@nvidia.com>
References: <cover.1620641808.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1620641808.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:208:23e::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Thu, 20 May 2021 15:02:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljkBV-00BTHV-PV; Thu, 20 May 2021 12:02:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3bba526-5858-421f-343c-08d91ba039e7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4009B072AC34D6222CDD446DC22A9@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgkZ9wC8EvzpmXaTOlgTMTaWUgQrhJ1O7BWHlstpHCd3V3Ku2Lqfl7yiczxVhutu8EdiwoIqUiqhBGhfhv7/Q/NrF8ZvGcI2f6Pgj+NLKktZA4VJEEzHO0ftFs2JFkX/pHDrHCWUPbGhjOEktXb+z5WHw8Y4a/3y3DVp02H3/sRKzrFCU+fkd77qJA/A88+8UD/InQ2wUC/EcOFO+QxS7BWcGW2ZN5zOekV4qC7uG2XqJdn9jQxQJwpA3OKAKRP4NhJMabLjVD1H2h7XqdqnzRDInhKd17H8384E5IsDqnwuu5+erzV2iFBV+EGD1gFN93yR7NAozRzx6B5V22bSSNZztS3pbdFcKsupoixEAaP/Z+NPY72W6BWkeSm25DEO4lpaf+Ve0XSpoY7QffCH8MhrAIAw1CVMuPeZ/BtgevXrPm345QKIAfLo44qUCNwLQasbmWX7ItDeBwglR1zgOuQUwkv6TBtWVZzRVHJCal+J+IBMlErQVk9oVY4Rf1YnRDAa2P7WEAybAi10v6Ge2AnsGLSPWKPrcgK3lYAoR/j8DEj6Tl6Po3mDch6KC4WmWgQx6dYw+ruG0I4WAersVWNHT4i3kM/mAxdSYL9eFtc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(9746002)(8676002)(9786002)(8936002)(478600001)(86362001)(26005)(38100700002)(2906002)(186003)(66556008)(5660300002)(316002)(54906003)(1076003)(6916009)(66946007)(66476007)(33656002)(107886003)(36756003)(4326008)(4744005)(2616005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iivOlTdq7CqiVGFiW7Asi+wdY4o0W/E0rcrldkQRE/kN7zZ8JZNYBtj5W9/E?=
 =?us-ascii?Q?Lj7myB2xWJLc5dWL9FS3eGRGWC28Sfjt5iqsxPJElBgoT+lXvk7+AcAj4tDg?=
 =?us-ascii?Q?9nzFMMOxXkIiHTQ70+DyWJbJycZf56/a38PfEKfKEIdhdFd74tufXQJ/6FSJ?=
 =?us-ascii?Q?Q7akqFvfug3icYyDC0zoWYVCLTtsA4voa6AlQnF3NnRdjZO/6AmyQqybxuyL?=
 =?us-ascii?Q?xtvsJGw1jZZNBlGwVkWtMM8UpSFBx1BRQ5bGH0bUXRLIZEdQgOiHeIjldMH7?=
 =?us-ascii?Q?mMnXONh+0u4T3Yap2GLgqFhoBH83nWnpx8tkQL7J93XNPJFeAvyn3U2m6whd?=
 =?us-ascii?Q?gFDOgiYdytKRR/DEpcP7KTgllJ8/dg3Cxkol2AZQx/7yF7o0h9zkyNxb0dVy?=
 =?us-ascii?Q?mUTp6v26nNT+iZnn3HvdQd0YAU9BffClu+Fjrtr8cwsj6e763bm6LIVK1XQU?=
 =?us-ascii?Q?GP1gJ2sMTr2JKHVVSQOypkvC68s51q+EHXMlRSWAXBeu7pDeulSBuPHqe/Ty?=
 =?us-ascii?Q?jfY/1e+a6isQBtur5Qwm9OlJbOgLYPRPEyciOivckqlYwew6cIjJD1AzsYKY?=
 =?us-ascii?Q?rm+eFIurHIRtw5MPmRsC6qPsOOWYaZh2iFShAkt+PKSttrfQvZZGIB7qZwf3?=
 =?us-ascii?Q?Uz9pkoXR0nHkxC7ZIblC739QsTUJl2vDvHM3HayTXmM1ZvtrFPouYrSZajpH?=
 =?us-ascii?Q?MpPW0Tk39eVeZRTgCFY9Ymb/K7LWJNWCxzwJV5XyGDEYoet2UcxYuemN3lR7?=
 =?us-ascii?Q?BYVqJ92sIE//GIRjDUjc2CC12MVenjqkAzOAySUshCl0kY59LMZTWU4Z6+BE?=
 =?us-ascii?Q?y2HNt1Uv/o4efwCKoasAM6ygq0y9uHrFF6CXi/MV7wAyjAVKQReDJb57DWtJ?=
 =?us-ascii?Q?eC+18GB7IsaHEVFb5HkFoslnyL/3MT8FsBOEvn6dX5xusG0h0o++ZDxrzcd6?=
 =?us-ascii?Q?RhojX8GREFqd/NsBcz0572gJwe5zPgrRHqHWUTxWdluSDWRr+lFoABUtPRdQ?=
 =?us-ascii?Q?zrf4fP8q6AoV+c9wkdAjOFF2Y2RV3+NXWenFhaoxZUzDtFgSJCGFHSPbGA+5?=
 =?us-ascii?Q?6yX80XpbhUZfMLrmG/Pg5d53l+3toL4vu+0TGdOWqQLM5Kxdkaycb3JpXMZn?=
 =?us-ascii?Q?6nFkBHcgNcNQrwzRhsejv73KWRxb26mtA4xydWNtU5+EBKePR1zPw5w/HKK2?=
 =?us-ascii?Q?VhYWrF4ZsHW+hmFhlgWSR2w9U4dYzsUHRPAdyO9Z6nRI3J0UE1pHp6YuOZho?=
 =?us-ascii?Q?4IWeTGbe9dVqY5vM/aP8w6ZdXTm5FxyV47rIrOh9YJarDl9CbgwTXICRKbob?=
 =?us-ascii?Q?fOSwN39b63ThKXG//GBfUxS3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bba526-5858-421f-343c-08d91ba039e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:02:03.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMYYXlHAc84WUAuui2FHfyRsx53rTioW51QxUaeFleAtYazITpfnxze9utoYO3Ny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 01:23:31PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The IBTA specification allows SQD2RTS QP transition, however the mlx5_ib
> driver didn't have needed implementation. 
> 
> This patchset from Sergey adds the needed functionality for this modify QP
> transition state and adds extra flag to mark supported kernel.
> 
> Thanks
> 
> Sergey Gorenko (2):
>   RDMA/mlx5: Support SQD2RTS for modify QP
>   RDMA/mlx5: Add SQD2RTS bit to the alloc ucontext response

Applied to for-next, thanks

Jason
