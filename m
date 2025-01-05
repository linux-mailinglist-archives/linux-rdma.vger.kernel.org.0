Return-Path: <linux-rdma+bounces-6815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5FA018C5
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jan 2025 10:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E723A29F1
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jan 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C0C13D502;
	Sun,  5 Jan 2025 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ll5sUttv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6361428F3
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jan 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736068011; cv=fail; b=d7vujt6d8HBPkJPYgbVHH+3oYW0zckvcwgdJ++8qDPI+5cDJk4S7vQYHZBn0kneEySEr3pJz9aT86VsQSDgD4R+PtATBeM2rA1oRS1nuQC63PhH+ubLTHPXjkIUZoaiBT1p+HjPGmuwCsFTZSLB2GnqTsoEu//+BhGTzVtzTtA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736068011; c=relaxed/simple;
	bh=B91t9ICu7T1KrfgJlK8oFGuF5/1umU+8eF9JEe06tA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKVzlp4w1As/FxGvQIv98nKNqtnBA8I2Mcw6AOpB8oqsc18Z3LutZc6Fe6sPxBTQ8yBshyKAj/q5elHz6KGV5gDEP88DfqbAOOYITZ+O/icVHBft4tLL7PtAKuq/Sw0NnUQ1hbrHB2oJPOGg1cLiyAl1vDYGB8B/OmCC+aMxwR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ll5sUttv; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ce6V8NbYpkPemNfAxfzxJR9z6jm8AjsqV6Y0BQOk+Wph2Y590SOjDpxe6/wUe4EezNGfM5lz5kiTrhj9gO5RncNs1XETxGGXz/aKcORYusAX+/XEqF5Fy3q3O6E9+lCoPdxrKANbw1FD653JDvwBpegUrDgcijDQw7609aMOs/ljKYF5o1hfLifPd9eEP1p9Sn8Nbff2hsrlDUEhr6SvFwcFHG6DbT9uyPwDgJwygPQcvsLoj67oiGYR4rFY/9HJuIq7azPNOBvogXgRG8WjMKavmx9d6yEG4KJiME95Rzelynt7kDkfxWmM6xkFkb0qT++t+ytvhkpu2Wk2uMgS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWfi2DSZBvLFW5zew6JQmlyd0Si4Q4Ybv/j8VONLVqU=;
 b=bGNN8OCangva761nXoXpJyrF5++1P0hlPv3NuScv/ca6fP8+ijmOTmgAFNyqjKPq+zzWKnrDYuHOqTJyA5WSm6RcnYr3W6aeVZRiYC0pfFhRcQWq8NB35xOjw8bCz7eXls74Noa8u5FzWEXNf7UWuWtkRglC5xi3+RqW8hLvhTU6Kq6ksaVxRNJIZbtaVAsh7XsGE/aeuEdK3SxL0Iv/OHtcOEEtY+Kz4sSUGdGldSIfZszq7tVfx4KcOOCSP3sZ3fP3qeh8biXzbkp8iZvOUdWBdTvBUBQ6p2BnolTu9M3T31kB9muyuMGOCZERG1bZoHlpZOf6mwhxwaxP8kPm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=chelsio.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWfi2DSZBvLFW5zew6JQmlyd0Si4Q4Ybv/j8VONLVqU=;
 b=ll5sUttvg1mSE7mcE78hKmQ9FBnV4MsH4oOL283hS9DTDuY5DSVrtR23+ec7Vb25DyqDFCJXlmUMfLK1Ac8QBIbPEs/VG+vJYikw1CMMjvfg8HegTpz1pJ0uHIR8PUR1apSiieM90Avv5cD+Xw+4AW0rnXi3JSksJ5H8zfutIcWcgM9H3iZOdcMUZrX7PeUY93RlTa+KjldJloaFlZudsDY8IMflG67yVkLzZYbiDbGyooYRNe5i01YRIc9QhHkOoGeSnArwY7kh+JPAtVl3oBoLT+2d+S44vAQrnVQjJifv3HJEalT5Bo0gROILdsvNWQ0dWHfUeKro382UQeobjg==
Received: from BN9PR03CA0856.namprd03.prod.outlook.com (2603:10b6:408:13d::21)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Sun, 5 Jan
 2025 09:06:40 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::1b) by BN9PR03CA0856.outlook.office365.com
 (2603:10b6:408:13d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Sun,
 5 Jan 2025 09:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sun, 5 Jan 2025 09:06:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 5 Jan 2025
 01:06:26 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 5 Jan 2025
 01:06:25 -0800
Date: Sun, 5 Jan 2025 11:06:22 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <bharat@chelsio.com>
Subject: Re: [PATCH for-rc] RDMA/cxgb4: notify rdma stack for
 IB_EVENT_QP_LAST_WQE_REACHED event
Message-ID: <20250105090622.GA5511@unreal>
References: <20250103100721.1015370-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250103100721.1015370-1-anumula@chelsio.com>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 491406a7-c2e1-4276-0306-08dd2d684450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DBs9U7s6tks8S3tFbr49izNJiXluAELLSwnTfDLg+lHMf1Z6Q293JuMqywIe?=
 =?us-ascii?Q?xKzBkNqSxLHS0CQ2cWICvsESjG2P9tIoXlMDUNa/hEXrGs4ynpLZ3W0jVkmN?=
 =?us-ascii?Q?7HtwrfujzSpZQ0UFblKd5Co6tQICZlUCSSaqqlyXYNbSRSKAoFI0HEGog7S+?=
 =?us-ascii?Q?uh66ptkUTkSw4Tc6PGO7qyTAcTnsonWWhXkyRM56F8ZZGpXQ1lwCVUKRpgpU?=
 =?us-ascii?Q?8Ic5KZ3fET7D/7kb5nR4mlLK7TmKT1b4stMZzdLjHS+az6vrDJu4eAFOCkPd?=
 =?us-ascii?Q?GS98wJiXNjjYCTVly7p4dqaaUmLRh5afW+msSzz/A+YcNzrFSDZRK8OZDZYi?=
 =?us-ascii?Q?FOnJBv+ZTVG3gXN0TGo/QKAZGE++g9OQUJJVMz0nYKSoIYWrW0dbSDQy14kG?=
 =?us-ascii?Q?wrK4mh+tBQf/PCyGBUsnURxoftFWrSSmNswVopfe3NvbXzbkkHTpXG6ULxf9?=
 =?us-ascii?Q?NLmNbj0Rhuwmum+SDbHcZE1rEx5AwUqT1QuFiSMT8VmgXrdUaOElzs/c4C5P?=
 =?us-ascii?Q?sCq0g5gYecib2vvb9CqftKtQimFbQPMk/ra0FrFTeo+OuJ9nBeke4Gj7zb1w?=
 =?us-ascii?Q?jkH90gb8nxSguNm5BRskQED9LR+zlQ8AQ6SCDOlJE7+XtXQsfttBGf8sOA7F?=
 =?us-ascii?Q?6Pzy38Q3tfMTNx/4I1Rd1xVSwUNbRvTpgpRaszXuRreevkEsj/5zV+Lz3hH+?=
 =?us-ascii?Q?ApKkOQ3gGPSxqSCCosS43AytzMbM8usdtiCm3zdBvR0RV6rBWWD/k6zzquY8?=
 =?us-ascii?Q?mYNy4GC8TGMvPsLJ07kujSp3GIGqwgPVKp9UutovZyEJqh67UnAquhzUEsbs?=
 =?us-ascii?Q?ZGqnAHHeFwRjquRbwlH6J9/BxVk3GtE5QL7nYHqsICH3ZVV6NoFmsdzNdPmR?=
 =?us-ascii?Q?oP1TnhbBw0wiv30kpliiTl8GyGtvcYqQaUJn/16b/AeJ1DEvdX+cJyS+OOZn?=
 =?us-ascii?Q?4wV+Pwo+Z1VQ6ASD7dUSy34UeHEdJc5nvPOqKN4Z4IGr1ib3LLQCqq1YhZ+a?=
 =?us-ascii?Q?GgAEAFEVDTSAuaRl7UjR7z5u9HxUMk8T5yvXqrZh1o4Xk+nGV0840cO88V9e?=
 =?us-ascii?Q?RCLeA3L0jNYQVS7mmgnH4D/Rn0b9woUnSjLcVNa4MHnf3qf1X70zA6mNb6dy?=
 =?us-ascii?Q?OAsv5qqqtOAD4mhtCNjwDswsfEQad9PZQjyTAezg2c90ep46ke7mwqC+aIBW?=
 =?us-ascii?Q?40DlQqR5K9c0toyGxBI5HjOW7qzGCT9a98OO7XGLaLayBKCHu8P/e6PhXGV9?=
 =?us-ascii?Q?TmfnsS0MxDSKsUxeEBx0jd3ZEkn4CRSNg5CjSzcbFTuysIcTdDaFGPR4aX7X?=
 =?us-ascii?Q?BUxXdyJv2cIbJvVrk16fCCt9py0UlarO/+hfcv6TI/8R1kgE5W7Y1vYX/a5o?=
 =?us-ascii?Q?MOJ8BeGx2CyBYZ2C5BBcfEZRL1ziCowY31qYxlUvyVxURfSZY+/QTdjIqOF1?=
 =?us-ascii?Q?Q/3AsWIiiXnvDlFtjYwUhUzV5xkWcIwC/qHUsmQqE71gF8pFymd/vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 09:06:40.0233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491406a7-c2e1-4276-0306-08dd2d684450
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770

On Fri, Jan 03, 2025 at 03:37:21PM +0530, Anumula Murali Mohan Reddy wrote:
> This patch sends IB_EVENT_QP_LAST_WQE_REACHED event on a QP that is in
> error state and associated with an SRQ. This behaviour is incorporated
> in flush_qp() which is called when QP transitions to error state.
> Supports SRQ drain functionality added by commit 844bc12e6da3 ("IB/core:
> add support for draining Shared receive queues")
> 
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Please add fixes line.

> 
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index 7b5c4522b426..10f61bc16dd5 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -1599,6 +1599,7 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
>  	int count;
>  	int rq_flushed = 0, sq_flushed;
>  	unsigned long flag;
> +	struct ib_event ev;
>  
>  	pr_debug("qhp %p rchp %p schp %p\n", qhp, rchp, schp);
>  
> @@ -1607,6 +1608,14 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
>  	if (schp != rchp)
>  		spin_lock(&schp->lock);
>  	spin_lock(&qhp->lock);
> +	if (qhp->srq) {

Why is this event limited to QP with SRQ only?

Thanks

> +		if (qhp->attr.state == C4IW_QP_STATE_ERROR && qhp->ibqp.event_handler) {
> +			ev.device = qhp->ibqp.device;
> +			ev.element.qp = &qhp->ibqp;
> +			ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
> +			qhp->ibqp.event_handler(&ev, qhp->ibqp.qp_context);
> +		}
> +	}
>  
>  	if (qhp->wq.flushed) {
>  		spin_unlock(&qhp->lock);
> -- 
> 2.39.3
> 
> 

