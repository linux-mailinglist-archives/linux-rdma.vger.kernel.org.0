Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CE87D5844
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbjJXQ3M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 12:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJXQ3L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 12:29:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEE9AC;
        Tue, 24 Oct 2023 09:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VphV8SuaMVP7rj5Cq9toOjfQYoRK5ZrE6yvuVv7tS/vLIkW531GH+C4ZRRdz6Zbl8MicG7VPnzEUn+6X0qfxQBUOdZl8Idn2fxH3Ek1cxS7fVdGqq2/nIRDYEAVk+39kVUpHKirXhHfnHM66Sdf+C+vjymwWDc0rKTBkKUeuMzHDFXSX0T056MirwVygXgf8qKETgODuJGkC4+/pta6IbYHR7pHoP58lMamaY98tm+fZSb8k6SwuNuN66C6CwCZU4xP8xuG5PPNZ5lUsn21GgcYOLT2ionIkZWyXbCnYre7BDRM38jEWmZBkR/E6uqYAA6QphoZdHQmfAz0Gnif08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98tUsS069zVjIY6n9XGNQiNbXweySNhRfvFo7wYw+Kk=;
 b=PXcE6pqnO2zGrQHzoGHPluoK/RMHKYZ6aPKSwcIxOkTZZ4WqIDL/ePGgTzF9eNoIqNoPAPCgkTwM5ZiYvyZb7AIwcrc9Q3cUUlYl42ONZH4jwv6zCye9Oiq8VrwU6Z843Jz7mlzqLropUkWi628NG8GceQT7ihua8PCMuNYYJpRibWZz+zV3GsQF/e2uT17BkhuA0hh4ZgMZYMQsNSwuEBtDlpobUrUiilP5zymXY9rfV0yPBMTPg2w6HD+DIv2gxcaz9v5vEW0PS40ZDuyNsDtc3BEatIkNa7k5i0QzCrgul8DBTaak87kGPmjliirjiZXu6vwktgS55C6XUz+Uvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=hisilicon.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98tUsS069zVjIY6n9XGNQiNbXweySNhRfvFo7wYw+Kk=;
 b=KkS9vhGXk34l7gCESHxyrLFrtF3fITdx2ZYn+hDINAtHQ7XX5Cidq9GcEK4nLueAp5qIJhd1W4pjP6+FNaALcGm18Ve48EcU9Y0C5NB6Tq24Xs6/HlLj0CxXfEBiZJXsbCuNH1Pivo5v7/GImuKAwtKABH6q6S5ZY0zXt6b3MRNNECBqDrIYms9/BKm4Vg21SkOf+HGL7jIvwh5T9ZLEKR0f5tRf6p0WSXd/o6SGYCzrobdd7d8k+t+s/Pk0wKiCmH8lE5ef7nDYEg/5sUyLhJCgvFPRGQV+573/w6ClkqYLFPvRCMalzAeGRmO+yrHnf7n1PC/N54eihvyFnfxalQ==
Received: from SN7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::23)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 16:29:06 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::88) by SN7P222CA0029.outlook.office365.com
 (2603:10b6:806:124::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 16:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 16:29:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 24 Oct
 2023 09:28:52 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 24 Oct
 2023 09:28:49 -0700
References: <20231023112217.3439-1-phaddad@nvidia.com>
 <20231023112217.3439-4-phaddad@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.3
From:   Petr Machata <petrm@nvidia.com>
To:     Patrisious Haddad <phaddad@nvidia.com>
CC:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: Re: [PATCH v2 iproute2-next 3/3] rdma: Adjust man page for rdma
 system set privileged_qkey command
Date:   Tue, 24 Oct 2023 18:09:05 +0200
In-Reply-To: <20231023112217.3439-4-phaddad@nvidia.com>
Message-ID: <87zg0856io.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f458bea-e33e-437e-9c28-08dbd4ae578e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxEs2wb051KT/koFhZn30oN7Wo4tDo3d2cYlU/3Ich2JYwPqi7xGRoGBXGZe+VbZ7tVckyR2syRt/Tng3UdZ20gloZmST2/BcdAWoRCzd/0VA3TTo74hWrowyX38t1uwJ25Dx+nnvqY+OlEohTYsRV74ynqmd9fQCkuk0ll5E3M2bzv9/vSeNXLcJchDekwcsINzkBVlvm52puhsuFm8taKe562UeZK127JGjtdNVrct60ItmX8+5II3qhplECqHWYv7xaM9PEdjI6PH9hVYYsXEK6OKlaFTtRVNIeHNX3pFT4mT2jZ3V1xDMEhqtRkIunuVd7/156Dzoq+BfMz6HpUhQuetY+sk707FiqO14+HznBtadrxPkepuOKcljMGLiHMMWf66wjKDQt7Lwp94apSKbWsvDGVe0Lfkci9GyTUA3/gSD4FEcpcdvkcR2HV6dbTOHPTiR2shJfRwpMN8d8KdYk8onr6vZ0ZH2dUNvE3k6dz9Cr2Qo43dMnGblNIIow8TN8d/howVrhl8WLk0gIIiqCNKL8RgSn0UiuVuZXl4x+fjZW6Kj1XTH/szXdVL/B9R8p8j++MrUbNqM17iY2NI7+RtRKpmBs7oPGubGz5apJeFNseU04SCbRmPC10MzgH2yRwlUAGRZX9SEVBpibUVTUEGvrTFObwcoJu+dxHQiaMivpnPafDW2HPnhAqcSsKrXNXKobGDUaXxPZL+9Xo7jsJsSa3iNtNihVezv/knLh/2KMxZ++c1eY0AoKkE
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(26005)(478600001)(426003)(336012)(40480700001)(6666004)(86362001)(316002)(37006003)(6636002)(40460700003)(54906003)(70586007)(70206006)(36756003)(36860700001)(47076005)(16526019)(2616005)(107886003)(356005)(7636003)(2906002)(83380400001)(8936002)(8676002)(4326008)(6862004)(82740400003)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:29:06.0012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f458bea-e33e-437e-9c28-08dbd4ae578e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Patrisious Haddad <phaddad@nvidia.com> writes:

> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> ---
>  man/man8/rdma-system.8 | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/man/man8/rdma-system.8 b/man/man8/rdma-system.8
> index ab1d89fd..a2914eb8 100644
> --- a/man/man8/rdma-system.8
> +++ b/man/man8/rdma-system.8
> @@ -23,16 +23,16 @@ rdma-system \- RDMA subsystem configuration
>  
>  .ti -8
>  .B rdma system set
> -.BR netns
> -.BR NEWMODE
> +.BR netns/privileged_qkey
> +.BR NEWMODE/NEWSTATE

What is this netns/priveleged_qkey syntax? I thought they are
independent options. If so, the way to express it is:

	rdma system set [netns NEWMODE] [privileged_qkey NEWSTATE]

Also, your option is not actually privileged_qkey, but privileged-qkey.

>  .ti -8
>  .B rdma system help
>  
>  .SH "DESCRIPTION"
> -.SS rdma system set - set RDMA subsystem network namespace mode
> +.SS rdma system set - set RDMA subsystem network namespace mode or privileged qkey mode
>  
> -.SS rdma system show - display RDMA subsystem network namespace mode
> +.SS rdma system show - display RDMA subsystem network namespace mode and privileged qkey state

Maybe make it just something like "configure RDMA system settings" or
whatever the umbrella term is? The next option will certainly have to do
something, this doesn't scale.

Plus the lines are waaay over 80, even over 90 that I think I've seen
Stephen or David mention as OK for iproute2 code.

>  .PP
>  .I "NEWMODE"
> @@ -49,12 +49,21 @@ network namespaces is not needed, shared mode can be used.
>  
>  It is preferred to not change the subsystem mode when there is active
>  RDMA traffic running, even though it is supported.
> +.PP
> +.I "NEWSTATE"
> +- specifies the new state of the privileged_qkey parameter. Either enabled or disabled.
> +Whereas this decides whether a non-privileged user is allowed to specify a controlled
> +QKEY or not, since such QKEYS are considered privileged.
> +
> +When this parameter is enabled, non-privileged users will be allowed to
> +specify a controlled QKEY.

This is missing syntax notes. One might think that to enable it they
need to say "enable", but in fact it's "on", and "off" for disabled.
There should be an "{on | off}" somewhere in there.

Also, line length.

Also, the paragraph is imho a bit long-winded. Maybe make it just this?

	determines whether a non-privileged user is allowed to specify a
        controlled QKEY or not.

>  .SH "EXAMPLES"
>  .PP
>  rdma system show
>  .RS 4
> -Shows the state of RDMA subsystem network namespace mode on the system.
> +Shows the state of RDMA subsystem network namespace mode on the system and
> +the state of privileged qkey parameter.
>  .RE
>  .PP
>  rdma system set netns exclusive
> @@ -69,6 +78,19 @@ Sets the RDMA subsystem in network namespace shared mode. In this mode RDMA devi
>  are shared among network namespaces.
>  .RE
>  .PP
> +.PP
> +rdma system set privileged_qkey enabled
> +.RS 4
> +Sets the privileged_qkey parameter to enabled. In this state non-privileged user
> +is allowed to specify a controlled QKEY.
> +.RE
> +.PP
> +rdma system set privileged_qkey disabled
> +.RS 4
> +Sets the privileged_qkey parameter to disabled. In this state non-privileged user
> +is *not* allowed to specify a controlled QKEY.
> +.RE
> +.PP

on | off, not enabled | disabled.

>  .SH SEE ALSO
>  .BR rdma (8),

