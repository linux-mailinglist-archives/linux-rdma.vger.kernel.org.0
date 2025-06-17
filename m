Return-Path: <linux-rdma+bounces-11409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3393AADDAE2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 19:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CF64A0884
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9F321D3F6;
	Tue, 17 Jun 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rhBDdvnY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15733BBF2
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182764; cv=fail; b=hCn6bOPTKOn1Hm75HCYjE/oqmQedrqjs8m3+CfN+CKUYe/PjC/kgHuee6j5OFNsb0EJHtDJPTLkowklDZszBGobVzdqIUmLAT7283j8YsyL46jgJLj+Lm/y/MLvl09EGEc7FbQ6dm8TVu6lLHK2+o/IK0PbLsRZbWuggHobE7RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182764; c=relaxed/simple;
	bh=FqYZkiSHlgSAGBqXfphh/RSxj9GcVGrHgRO2hh+Y0lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qwmgXs5GHKbkrH3r5+WkCKcNaEWrUsF9/5VVbLxKmVxe6yJ5TWEo3ea0iYhW0K8ejM/SVhe/3FedkGHAqlPBlg3GoCw4oDrkCmSFsdP/cD3n/kZjWLxlbaiRQpqSGYgvFnjfd7/tFRbcoLqBsSMJkW9LZUvWv5mqx0LN+28UXVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rhBDdvnY; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbjIS8q1q9LATSTKctrVny0XH6HoowI5UQCVRHSWfgzO/+xOZyBkFLCk/BvPI35KxFvQJShms/5qphmjib2E2zc4iVKqmIZea0/v9LBjxp8JgW4emswhQmyr71Ni9cDI8Q2R7JT/wtqcIT3wK1iUm1jf8jzGVLWdxVEB88L88PLbEpWm/R3quNjG/KCNIUqxcWnWKjeuue2QSZPerdM8ZeVtZ62726suT6xgyk/UtZV4iBNbQGafY759y+52GszjYbeIreCZy5nQEgHSIoUR0k6WjAsbbLleYFbT224vBvKZtyKlnweztx70tJpbejSNy+1+TDxq3KBvDJOcQXjwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+e5c6DK+rpV6hvFCGc99MPARn7GD6aulofFB0BvfQE=;
 b=o7xi4Bo50LxwIbPo7znZLHpwVhW2VnVYHRsEgdPfjjE+5YUBJpA3wUq3Spo0BhRxQmX4XOdgGWWE9LsPIOLUmsQ8LFHLixY1nA694aJnUhCcdoSihYiQr8M/gomq40ODDZOCb3BwdlhHvZ3U06J2AIEKzviOPTdJi5pj4kno75cfNPSy2gNCHQK7euFhlKA3LHjepLOYCmCywG/e+YlVFs4qRFgWcgBRZTaJv778J+4WsNOex0DIiA+DyaG3JAmKMuc41rrj8hZShwWuSdqgh0uDw47AdHkPyVJJEjVFHmL8ailxuDXRpadmva24Rl2IRpD4N49uF4r3BOhFSuz3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+e5c6DK+rpV6hvFCGc99MPARn7GD6aulofFB0BvfQE=;
 b=rhBDdvnYIACUiMSqyCqXX9+LyUXCbSlazOM4ILygiLBXz0Ti1Bb0VnhqQyOa7mFfM3gvqiLDiLmJEM7zb1b5zUuQYR28VtqyJhwXM6dDRPGBvk0xheGpJk4VOt9xjAv1I0k+XHhNWfOmo4F51WDEm6nuIUKOIQenOnjbqa9p/keL8oDRX4+1QVytsX9YW6vCEsr4OK9/CngdDCtrL+9B3EnufwZw5du3heFiKbza+wP1YCLl+rw3PH4RCzphuKGHKZA+G0uuQr/sPXOunmeB65tauVu6iTYAu9je0hGmZmmiifcMIHx7O1AbjCgfalPpVPIx619QkeARwKXK0RY/Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 17 Jun
 2025 17:52:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 17:52:33 +0000
Date: Tue, 17 Jun 2025 14:52:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-next 2/7] RDMA/uverbs: Check CAP_NET_RAW in user
 namespace for QP create
Message-ID: <20250617175231.GZ1174925@nvidia.com>
References: <cover.1750148509.git.leon@kernel.org>
 <1845d577e9b09caad3af28474aa2498390587db3.1750148509.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1845d577e9b09caad3af28474aa2498390587db3.1750148509.git.leon@kernel.org>
X-ClientProxiedBy: YT4PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8d3cc8-2243-4e23-7d01-08ddadc7bc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H1eo6f9sv3tKShDK9vwC8ECPUKsuv3qEnKiLquSW434Fo+w/AIswlbh0ckIU?=
 =?us-ascii?Q?gOkCXCx6YUqj736iMsxJgORl1VwgCtcc382r85bTaUItYGX1lrHEJUz+EMHC?=
 =?us-ascii?Q?GO8xB9klwTVMvlVbQoEEGC2/MACOsPCsCh5Rkp2eRpFw4aDh/n1Q/3uIVwyV?=
 =?us-ascii?Q?1skI1TXAbF4USQXdxKjs+tnpKfFK0LhbANEF3dc+89LvLN1fFuiALDt+1Mqo?=
 =?us-ascii?Q?f/tv+jUZq+/KBptlRijk0y6t5w9/mZakTT88fAhVryiUhTnj0CqtfGIKFL0v?=
 =?us-ascii?Q?wabzmoEFztQsmivBH/lPGeFMEYwgV0XRj5YRugsTan3sDKZwvmBAproDa0lP?=
 =?us-ascii?Q?/8mB2JM4ugrUUevIWD6HyoLceZloDNy+AWEEieJwZS9NU91cQYzub+2AEmtb?=
 =?us-ascii?Q?SEdNuQYjBZVuzy7AbuHgmqoj2Q/0FQrXHeXDxbS+hbFkRRnmZXHdYAc8iJKX?=
 =?us-ascii?Q?S8Ly+Zmehk3UKIteKyp7HzIRHZPLmatUeUN0zbXof8DdjjmYc1iS/OIrm7A2?=
 =?us-ascii?Q?jA0lgHZVnTk9MBLMbUxNpKvnmz0kfE77mck6h7/wrFEe8sJkhtBejI++Jgxv?=
 =?us-ascii?Q?GO8tLrjzvs96+tzwoZxr7ldjc/h3gvr7JQmO/Ur21Q92SZuomR4oBbZ5ho4m?=
 =?us-ascii?Q?yl93kPlAKjYAcoC1FIIT92VuI5rKKaicoXO0wqNWQzE06X7JyL1HUQyNtPg6?=
 =?us-ascii?Q?vEf+kKl8XuzNg0ZfYw9pw5W2tbsm231Y+LPHcSjpkE9unqHa/SmfUELag/jq?=
 =?us-ascii?Q?NqHsXwFeSUJpFnoU6CrgTwk2MWXYUffjqYh3JhajJ3SmwiIxFepVpM2mVviT?=
 =?us-ascii?Q?tVqndmsQYwgkF0bbvwwJ55HIAm01s9dTy8NN3CMxGdHtV4tq/0PM9BP3fGbQ?=
 =?us-ascii?Q?8ccK1Ntmqfup5ELBaXkX3bhdcPJSUCzFeRpk98X+IM4BuJYd6fi9/svyrZO+?=
 =?us-ascii?Q?DmSXzIKVS0ka+q8y0s3/n+ppESNSph730plchl0dHXbWwqb7usWjDPPiowPD?=
 =?us-ascii?Q?Dc3UKy+gnMGAP4zyw2Cmcb9ts1z3HHF75F0Wt5GqGq/T0MXsUBKeVqW79w2/?=
 =?us-ascii?Q?X7Jq92i9KZzIlW1FSDgnQmG5H1Zw3XHEd3LJayoOGSMC068tuSuwlLYJqgws?=
 =?us-ascii?Q?B37Q4Lmz40IXHb4CM9D2CjBBKa2GreOXurb/fvEOb6/OVVmlJfOEgjPNyJ9l?=
 =?us-ascii?Q?AhperJBUwcJLbPEn1xIgTSU/aDMRz/V6RkRQK5xvPYQJga/YBART8iJX5PHA?=
 =?us-ascii?Q?PF0oNJV/x7yF+BePW/22jOkcLlgou6OcVDpw5Q+099JT0ubikMm4GfUCnwid?=
 =?us-ascii?Q?wX81Kk2PkHawinitmITnBLUWH/s7s2hO5R5nzLbfh4s7wtAflOpPOTaKmKeD?=
 =?us-ascii?Q?kGEPJfNUnvN95K8EBTSZKnkz+V921roMJmBikNLssCHxbvLCfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZ+Dj2vJSLum5yPgi6lHT/YnnZE+YKkGmO4eEs0vzH0immNN7FOYqyOPC+B6?=
 =?us-ascii?Q?+tT/OLk4vvCuzZFMvM3BMDmzKzMUswzBBapGWnWQOLWDkfYef1Lc2nuuRJQD?=
 =?us-ascii?Q?eRKOSize944Veyqp2vgKZjFEGBnb8DRmX4Nvzk7tWSnVrUc2eaLpvM4ydX7a?=
 =?us-ascii?Q?olgl9N88DcvpHE2XVcxWenWRXYUe2eVjsMDXwMW/AGy1+MvpsQekCxFGZ/26?=
 =?us-ascii?Q?jF5cek/qnl4tx5KwHxmHdsPitFj42PJk2PrjfqYkidCPBAxTyx1glDi3GgcD?=
 =?us-ascii?Q?mWXS1CWCex4Ia3I8jRg93YFQA/3UQzD1gngr5N+HMdMuLCI5WJuILfWYzrXR?=
 =?us-ascii?Q?FFIUYLxfSgYRAh5MZM30xYAOhGLOJcwJNxwfrIcOhaI590gX2x2pu/sWXRg/?=
 =?us-ascii?Q?Tgn+enRC7WVp5D/wEgln+mpzyhRp4wYkk3CVr+gtHZAaqbFvqQ/3p5vOrrH5?=
 =?us-ascii?Q?g6Oa5EBGMLg5Knnr8bp/NPTunxJ+vqhjMUdDbZ3hM3KiVexsq7mw7du36tZd?=
 =?us-ascii?Q?i5QGcbBgf+23iMgDEd0urBL7qux5ZDGU4oU6gMOLPPnKLw+UTd124to0w4Hc?=
 =?us-ascii?Q?Ayn9V0+xV6cKj93XXFyQvubqvq5lFI7DC+CesFG4UV/v1wm8PMN1h8C8FVJ9?=
 =?us-ascii?Q?S5NuRoRsglq0ZAozReGqI4FXj1I+27vA63d5wIDBNAzGsc2q0/GYb7y6w/B8?=
 =?us-ascii?Q?9hlOastaVr7spCDMD4zJHPDr7lBSgnPQaMGYzVaEt+OG8IaIk8t0mE/OPCtq?=
 =?us-ascii?Q?UUVZRhDumbIExlnlXDRcqOOgfix15tpGvzP6TiqhH7c0And+ESUCfL0vwpkq?=
 =?us-ascii?Q?43Jk6q7Sa2G0i6b1S/6LEX2ZapdiEZdEb30oIt49DkgY5K621t5KGxy1xiNw?=
 =?us-ascii?Q?ZD2WeTJD89PliPL71XmqrJefHhY5vSlcvwafIXQX3/Dg2U9LWoaK3xUg+A7V?=
 =?us-ascii?Q?eqHoyzd9HHoe/Q8S2tDsYH2Pn9sdjyjEQ4KlvaWe0wgfG3tfu0md3PanGvpJ?=
 =?us-ascii?Q?ect3mybx5Yf9bcKps1uA/W3REjpi5E1oC2FHy/G/TDwLl4tqnpQiNTUiLATK?=
 =?us-ascii?Q?GjCediElk5oAaMQw+fmBqHWcza78f0sNrpZHcEv6gEaFesj1QMnG0huZUlzM?=
 =?us-ascii?Q?yAEns/73I5h6C/YCogqUTO/DDQQGjhbb1gPgJmiukK9dXbXH0wqlzH7FD8Co?=
 =?us-ascii?Q?p2iCpXc9dDTF49Cqa3HlT6Aw3roWmEPsUvLZfF1++Xh4r4wk4Qz3nLrtirVb?=
 =?us-ascii?Q?VW3ZGbjFcuL9ZhPIBg9edJMfH0SATEnTpJhshPC3ZKFgE1ytUH+JYCvhovXU?=
 =?us-ascii?Q?c3C5ZxeXnro6lKs4JCGZE4JlZfIwyBEpkz3Puiv2Zr/bfUa0mGtFN+hxpNb2?=
 =?us-ascii?Q?6F0MZ5Z5TJzeU//8fNNLx5F5pqRAIhLJ7DQud2aBR/qtXGaida+E5DDeh4YQ?=
 =?us-ascii?Q?M4F7Wlx76jHIiR3Bry0HtVvZaJTjpnMKAwp/jQ/z6/4IHcMzSr0TkAby61ew?=
 =?us-ascii?Q?RkRGRsgSJUYrEHxY2sYeVKF2ZLUYSruicgSc9Ks9jgohwSgMFFLHOTtkKpuw?=
 =?us-ascii?Q?6JnDhxBhpUGPYrpNTi42G9b4D2bV/QPloaAXqc3I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8d3cc8-2243-4e23-7d01-08ddadc7bc4e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 17:52:33.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOgIm/8YYnyuRarVzn3rG4byHpuBx8692d7rztNzHvHzABJ1C7oWIR83xjPqN3Le
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170

On Tue, Jun 17, 2025 at 11:35:46AM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@nvidia.com>
> 
> Currently, the capability check is done in the default
> init_user_ns user namespace. When a process runs in a
> non default user namespace, such check fails. Due to this
> when a process is running using podman, it fails to create
> the QP.
> 
> Since the RDMA device is a resource within a network namespace,
> use the network namespace associated with the RDMA device to
> determine its owning user namespace.
> 
> Fixes: 2dee0e545894 ("IB/uverbs: Enable QP creation with a given source QP number")
> Fixes: 6d1e7ba241e9 ("IB/uverbs: Introduce create/destroy QP commands over ioctl")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c          | 11 +++++++----
>  drivers/infiniband/core/uverbs_std_types_qp.c |  2 +-
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 08a738a2a1ff..84f9bbc781d3 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -1312,9 +1312,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>  
>  	switch (cmd->qp_type) {
>  	case IB_QPT_RAW_PACKET:
> -		if (!capable(CAP_NET_RAW))
> -			return -EPERM;
> -		break;

I don't think we should do these code movements, I'm not sure we won't
create a security problem by actually creating the object and then
immediately destroying it.

Add a rdma_uattrs_has_raw_cap() and call ib_uverbs_get_ucontext_file()
to get the ->ib_device

Jason

