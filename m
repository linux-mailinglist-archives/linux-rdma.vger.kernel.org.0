Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFF322CE32
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 20:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgGXS4z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 14:56:55 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16081 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgGXS4z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 14:56:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1b2eea0000>; Fri, 24 Jul 2020 11:56:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Jul 2020 11:56:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 Jul 2020 11:56:54 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jul
 2020 18:56:49 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 24 Jul 2020 18:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu1VwIQgEGkeXuQaXpEC7jy6W5UkqZ9eTl7BP+viVPKHQCInQP1FRetf6VoRynvNZ4zFvadhKuCkTf87CA52JibSm8gvQrSYo/be38BLRJx+zx/mUfjy+emnUOkKScP5F+wBJCFvL37Jw5AREAS+4DUqyUmF9WJG3Su1Dc/WwMhHrP1oX4oKm4+HpVvzQihWiYNaWhWleQIxDUiqllMDntbeA5FgBhAShw4h14fwa3SGrVDt//1dhIQzzN7pOF99PxWeiZeyjI97M/axFgRTDbyebP6sprO3qGuvpuLXQoCiN1YvsCFkfiHt+s9uVopLpfY5Uy+ptyBy+91Lf84AJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnacKiGrMhlpGV1uk4NADBQnjYPYmO2cU44GyRl5VdY=;
 b=go025MBJIy0H3iVspukG9o1f19uuUIxmbDp4JafSN2Il6difc8EnXot6ZpW0F+wCmoasHxvJh4qWq/MFiepJDtjSiFPpfT6gDupSjeKw4BL5ngjQVnqLeEwwuEBNcjBI4zzRPmbsO0f9ta8y6S2zZJAUeyOZA2ahRb5/emIxzDlo4YcjDlKmqiNOVTFwTYlecZ7Z8inQhKbf/3cH7BlzTeb8Q7frG+pCVrWcP1Cua4Q1rvOzmQKpqgmPE4Z/qwsodxLOgLEPPWPTRsyR5L1Hzf1SCSnoDPOzt+9DdZ4zKCt+XEG2O/XX8Ml2EEwokoodIYPt3dZ2gjtJCbQIr2Xg+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.26; Fri, 24 Jul
 2020 18:56:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 18:56:47 +0000
Date:   Fri, 24 Jul 2020 15:56:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Allow SQ modification
Message-ID: <20200724185646.GA3648923@nvidia.com>
References: <20200716105416.1423826-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200716105416.1423826-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:208:134::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:208:134::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 18:56:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jz2sA-00FJGh-C9; Fri, 24 Jul 2020 15:56:46 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9b94890-962a-43c6-b251-08d830035106
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-Microsoft-Antispam-PRVS: <DM6PR12MB293715F77E6EB56C5596DC1EC2770@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dmvlSRb6oT0TLnpwdoJy5HHP7qSCL17z0LfzuAiLwJxWClmOmnU/3Sw2Em2b/gphN5C6f2/zhS4zeIv+O2NELm+wIo16BkMSy4eSY3RoKQ45t6bwgzKfle4kUTEBrYhdd3bB4AaxQk1m6PNoCr3XSMiGDpI3X1nKB1KY2oRMTNrL5PvL86zZVj+gSTtGSQUG/5DQYe0ckWDiMGyqS6Wc9EKDn9tQaR2IC5curoA6XPRmpzr31kboIJMu8gWFgRU1/er96AAClJj+ZF1vghSYo66PE+OQstJ5Gb6cgmzLP8o8hnDvhlFdtHAbpjS511K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(33656002)(5660300002)(26005)(2616005)(316002)(9786002)(54906003)(4744005)(8936002)(426003)(9746002)(86362001)(2906002)(4326008)(1076003)(66556008)(478600001)(6916009)(36756003)(8676002)(186003)(66946007)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1JFfxZzKAPqTKgtBIxdmYQx6qrAs8zy+7FLkQ3Wp5tY0XmQ3to8/qs1vAn5EKjP7KHE2G0Fbt5LkkuC/L7FWqM029AxTXadfw39bKQq7mFBZ24dnEe80XH7u0ydNc/hhR/mybYHaUl4CSmAxwzQJJ9lTJOuHk0GiNDHUNbIEJcxMf6CljuDhmJZOfdHbibIg36vNoBFXi9j+QP7ZtinbOndYL7zq7b8c+A8xv8GJkqSNjUqHz0GYiDQWiwyrTHVaWrH2+ZgSvZWVP0Y6HSHdyERB3/8BlaAGrb5p/b/dcgAQrrOhqx1YJ3FPNNrzj/taFzHR/uNJN28y8jPhB7z3vgFCPgGsyE4eq6l732RI6+57liuubAIO6eszh9urDvJVCCfyDn90JJj220L93g6IbwaRKt8mmpSDjRAkB+qeg4UCGgCjGFPeVjpuJM0Qdrb14HVI2p5Ex0wzx4ZqZISNM9A9z5WrXKbIW04ukRj8XZc=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b94890-962a-43c6-b251-08d830035106
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 18:56:47.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7vP0NmIQDJ3rwA/Rcg43kzzwKKvt922Fmjl8xmCi8yJ5j0M6nOuS2AX/VjVNIOU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595617002; bh=BnacKiGrMhlpGV1uk4NADBQnjYPYmO2cU44GyRl5VdY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=alSjKLEcK1mrmOQTgVKOKxaYPPMsK9DLHWH4HgIitHTKt7T7+ZnF2cPHfBtjjD6PP
         Yowf9tkR2IYsi0TwV0QQh2Ksx3i3l4pOiOK46snaKJA+qgfCpoiZi3J92TXhx7o33N
         MjmQlTE8FmLE7w5VqsN+4WRhjbCOY2ekY4Ez2yAnZ7WeKqHpHBwiVZK+qPOWZGdMls
         fJaRlOiw7xL+D+4n3AQ6e0ubfFdsd5ZBhBuiTv9lUC0WYAL9n9CvI7U/4wmUsL4iwP
         oaHcVn1HPOlAiJjpTsFoKtW7ye72FLZ9+WE1ENC+SF4H9CZV6nxxvEpMFDEhrZ5vKz
         vqZjvTswXOMtw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 16, 2020 at 01:54:16PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Currently SQ is set to ready state when the RAW QP is modified to init.
> When TIS is modified, e.g. to change the lag_tx_affinity, then SQs which
> are already in ready state will not be affected.
> 
> Open window to modify the SQ behavior by set the SQ as ready only when
> QP was modified to RTS.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Reviewed-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Applied to for-next, thanks

Jason
