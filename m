Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D217D3901FD
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 15:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhEYNUS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 09:20:18 -0400
Received: from mail-dm6nam08on2050.outbound.protection.outlook.com ([40.107.102.50]:26336
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233143AbhEYNUQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 09:20:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY+DylfxW/u8jdtLWBof0SKu7zXGQc1LzLMMzLLetcqQcAI2u9PhOCgVQrd99Wp/3PGAgAE4kAek+8q3Zt8sOW30yOJqw4Zq+40+Mgr8XLGAMaj7AxaS9dWojyg9wZjV0wU8YrFLmoZwSKIERjWVrmeyLjRwh+gYfbA42zX38ZOynhr0b/jmNWk/meejHVWrarMKjvQ/HyIlmgiYhtqJa9Oqc+61ylkzCm3Lkw5xsMmdwy58uIiEcLaVNAeEU1kLL08JqEexxWSRy6oQcXPPi4P4AMUogKAA5oguy0TTaA9V0cZeoblp05Twa0q7XnY0D9vbKiRoyhH8EMHTsG/jSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4pfp5V8YxmTqLPZ7nG/MAirkPj7LmvR+dikTv83hyA=;
 b=T77Q9DBv9Zzl6WCjJVNd3ZYROLdLFFu0tFawTyjngcw1yody9aW0Bamvv9QS2zj09NJgWdpAMmrNgzHBd9JGUAbuqEX223YKFkU32jzBxyIkhQNbb5Tow/qPCa73I0dfHzUeMtWJR6P3hLwgLy2xNqqJK3euR2XkLkUcIYcAh+cFPlAyOUpxZq6HvWCao0VyscCuImBfGvL5jB646hMCSe6u8xsBzQgDq4zrB1nXAIkATDActi//0CqKL48Im3ip6jt9AKr3Jz5h4LOut4A2he2CU/yt/iZAlo2lmTT2S+7m/9XdcyylZMJfsxduIlW8117EplNZBPuiLUg0jKE01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4pfp5V8YxmTqLPZ7nG/MAirkPj7LmvR+dikTv83hyA=;
 b=X4oNcKVN2hDZ7hsbiTQVnagm7fQSeZnFym7d0DcnONvHohDyW7NCAFUmOw8se0UQ/XdDSXMhy1GyRhmsrxKz5vZwFwU4Us/ltqg/S8xMzR76AKTrmhy/F2k8UrxpsCfnrzu0PWmwwPHbYA715usTiDUm74/p/aYOGDcu6xtVSbMRdpvJBafZ3bQmTW0AE8OP8B0VAg/37YYwgqRBvPpFD/EG6S6fWtGLRuEZ4Sud/f8TS3/h6g/5bzEKTC2r28WCD/87nmdCzNOz7tlOIReuXgRf7cyExyJYZ0TrUnzKbwJ4KsS/hD3Dcx9Hom5fm8zFM2AY/UVXvB4jBJ3zj5M/IA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 13:18:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 13:18:45 +0000
Date:   Tue, 25 May 2021 10:18:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        dledford@redhat.com, leonro@nvidia.com
Subject: Re: [PATCH 1/1] Update kernel headers
Message-ID: <20210525131837.GV1002214@nvidia.com>
References: <20210525223222.17636-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525223222.17636-1-yanjun.zhu@intel.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Tue, 25 May 2021 13:18:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llWxB-00ECuT-6j; Tue, 25 May 2021 10:18:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b494ff98-f324-4cf2-8f08-08d91f7f9f95
X-MS-TrafficTypeDiagnostic: BL1PR12MB5221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52216FF90892DC0FB661BC8BC2259@BL1PR12MB5221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZnfF3yadojPpXmHn8FidH7O1NfyWhMhH63LjlwG/1SucU3ZLDdxURGKH8byB0sWMRJiyOkDFoPfuQ8+chwIXQSPeB0cS5al2FHI3H1CwNVEbe0j/KSOo9dAKowUzYCHaQjd4fwOfK84agcGba/TzD81uqu/K38+ud7pzUiTUeoZxpHKE2I+kRXDSDzE6/BIqiiccWIiYqCzN+xo3YkLVnnQa66kp05zbESDoIGm2reMAb8VVFYaDvArxNA8E+BVxyiqThQABkEwi7R2KUSY+DvQ8j0uItd7iHzyhUioIxcE29TOnXJX2Rogo14LLLaQFp1U/kyTve2BXpXeZW5nVzgf3Ep9+QPmdSn/kWfRPD9yDiOvogF36N9FZCr4Aw9y1pgy/SQSPYlx0BqwbBrcUjACAuykxP4b0ZOJZgkWtCaUbJxWc8OaVJa8uThYrynouQKGIC20sFKlCXIEB3OrCILN6sNagR8ZdDEa5a6qPw/dku+puxOVWGyXtbRbo6ZEzQB3hq11OBz9l+3bJPYi227nd2aXdztNXLIN/I4rsTGUMuyH9MowUbhWjMLLTGO4FEBux2CjJuaFwTkyamFi5vOhl4biHiEDOSLeuUbszyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(2906002)(1076003)(8936002)(9786002)(26005)(2616005)(426003)(4326008)(9746002)(186003)(5660300002)(86362001)(83380400001)(36756003)(66476007)(66946007)(66556008)(33656002)(316002)(8676002)(107886003)(6916009)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ur/Hf0Z84LJPsgLHCK2edstksmdsEcJS5Ij4pTkvuIWB0i4/cAGYHPij3OpP?=
 =?us-ascii?Q?Va9CX99nA3/8ywBXBTiBFqi3u4txcev8YMw4fK++vP8cQRQSaF6TJmhCMfpT?=
 =?us-ascii?Q?8WddWlzsthyYqjzS+8a7LysbOzaV4dTyqIRl2a4liTk/HDn6SNrDNe2Vt8up?=
 =?us-ascii?Q?VnZ3zkvwEzmvGQyYAduS5yfrsnj3QYEZfnDas9aUK5u2y/ehxmXBTerlQC1I?=
 =?us-ascii?Q?EJ8rFndWSUJw9R9xNbjC+LU6tuqKOQ88pf8TQDAFzi0D6zo9yARb4Udtv02n?=
 =?us-ascii?Q?Mc5AGmm8ZQppt2OVWBO0BZSWTZJLX7ezRKWYAwRntyAKPI4yhZWvJyFltWpD?=
 =?us-ascii?Q?jXzJ/hxIi2CQ5Swrp1SOuNSnSvfycNbtCI3/W5kLk9mGS4bcCpvI6StTNbYf?=
 =?us-ascii?Q?QGD69oulnCYY+IxG5CaM6antQmqAAisisDj1lFr7UnjmD7GAZe01g3t31yII?=
 =?us-ascii?Q?6wEuZtWQG9b4WxIhOl2e1UWR1OBeAXXzzRngA4m4Ch+UC9Ui3uIhemx2OrIK?=
 =?us-ascii?Q?6mh2OKV+H/LQHEh8oir6Cu166by2/wIWmCQrC0k5oVMbgrPJybkwPbeWIhUG?=
 =?us-ascii?Q?DnSr8XVeIHivo0qa6px5E1fPf+aHT4kdmJcog9yHV7un+L5I4PX6Y4PDWBgq?=
 =?us-ascii?Q?mow51S9yR93PxiugWsmkCT4Dx4oIcPnkc5S8fSWB141gTptKaH6uveL9A9Te?=
 =?us-ascii?Q?lAwj17tGzqeD6gQC73uPAiWLHuNqP6ZtjEvwaurG5yi1/Loj0pkXpb6tKdqJ?=
 =?us-ascii?Q?F2FMFLgfUs/vzda2XIXWlJCh0X2TwrxRDR8NiexEShOQX6WWagr1XaVvpy7z?=
 =?us-ascii?Q?9Qs8JiRyGnykOHZXAWCo5q5CMwDlTllo4W99CTWVj2aKX81six/86jj80bb9?=
 =?us-ascii?Q?ScGgTjbUR389cytwVVPYvh8jus1XskW/k6fZMHnCwF+ThVIMBvgTzmtmtiBX?=
 =?us-ascii?Q?eCVqLcFmvkXSYA8i8orGozo1y46e2veJMtiJ/i1jMvwA+Tgsxp+SJk2JT9c7?=
 =?us-ascii?Q?m4Wr96HCUtvpzF91Ti6lBDNJnVxUeuokIRdciZPgCy3LwgRuM3ndRNuZc6hj?=
 =?us-ascii?Q?aT16hrGhIVfalIUczdqVTfuj+DiubfPWGvkeIbirjHWOX6rlqs/gblv+HmGz?=
 =?us-ascii?Q?KMbAEMnoZgibhBVFBeBvHYm587WlD6R++gxgfi6Rq2KiSAR0nU85u0tVGPRl?=
 =?us-ascii?Q?cKclAFFAR7sS+bP07bVXhX9eo5B6rA2KQi1h2t8KAApI1SQhmT8L3sj7BEq3?=
 =?us-ascii?Q?rz3RFDmy5fTlz+8LMdJyjgXUWq9O6lBseVUqmTN6DCa/zUj6LJ3shPnRd1O/?=
 =?us-ascii?Q?tNJCNPUMOds6vcZ0CQS0ve2w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b494ff98-f324-4cf2-8f08-08d91f7f9f95
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 13:18:44.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWZm9qjfJV6Y3wt7MZbEUvWmKxXL9mdLQe/MVLFYucXJ7b7zAQUoovtNC+5uwIY3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 06:32:22PM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> After the patches "RDMA/rxe: Implement memory windows", the kernel headers
> are changed. This causes about 17 errors and 1 failure when running
> "run_test.py" with rxe.
> This commit will fix these errors and failures.
> 
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  kernel-headers/rdma/rdma_user_rxe.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Huh? Bob? You can't break the rxe uapi??
 
> diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
> index 068433e2..90ea477f 100644
> --- a/kernel-headers/rdma/rdma_user_rxe.h
> +++ b/kernel-headers/rdma/rdma_user_rxe.h
> @@ -99,7 +99,17 @@ struct rxe_send_wr {
>  			__u32	remote_qkey;
>  			__u16	pkey_index;
>  		} ud;
> +		struct {
> +			__aligned_u64	addr;

> +			__aligned_u64	length;

> +			__u32		mr_lkey;
> +			__u32		mw_rkey;

> +			__u32		rkey;
> +			__u32		access;

> +			__u32		flags;
> +		} mw;

There is room for 4 u64's in 'reg' and this has 5, so it is a no-go

Jason
