Return-Path: <linux-rdma+bounces-12912-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69949B349BE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 20:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2BB2A2A91
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652123090CE;
	Mon, 25 Aug 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZMMwb1bh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F22E1EF8
	for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145264; cv=fail; b=L48nzfJNHxD8lnQow/YPAxUZqIzlGs6JGXcmuKCoA5dVF28KAoSIDkL4azTTX5IXg3uAC3EyjwL8jEQ93RDNFzXNjEV/GY7donDCbJ/VJD8atjKdmxm/hQ8VAq354pD7MRenbN3QnvkVQxh294xr0Oub8Z73JWBCrRI6+CUOEAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145264; c=relaxed/simple;
	bh=jxweMni1/B7YDyK25YDpyiXcyadu86NfWcW2nzjPVqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CQ7a2zT8ax/AVbXwwz9D7G3kMMsKuzMJQtrmds4xCbM73+ihMaWnHVVUNNVSh8D7iygiKJTjI0uWubruwuoiBZWNyZHV8y/c3Y4RDXxy/N588DqMHmRcdoeCLGMQK/HIi7c/uftGNWI4tIpooBANrO5Yvhf+yr0FqybGCE1zlhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZMMwb1bh; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjG7k4ZymQsFcpGl8FcxlZAX0YJRA0vTSVs+CQD1jhvVs6YHwbJluJx4MD2mFOqIaXLieTT1xry1D3DseGaxoZGK4SAMe7R8lCgFcsSY21nZBu6Pv6VLw6v378g4KnBl5B0SfNgMXEvy61zAbpuk/p4l55Z3A9T2lL9nx047BKGigwVmYsTsdqNzeXHeB/d2PVtNNqqkc9pMlcTt02D2EU55zap6RKVmIjaXMe9M0Tq95Cqu0nP2PEg/A9VAz3E8Mt1kKy0qeEys9p7GaE8zFc90nueiamfdmld3aNlKsxarUOoUqIsP7sYV/C9j0gUnUHvUrVm3HcMERWX/isqwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZXkDdwkqV3JDkaen0xi+WfWmkYbI7YDXah3E1bYtIk=;
 b=om9+9Y5a2KHc8RjUgmQc9M39U7kanNr/SJMYz/yZSu9FUqq0RljYmBeoUs6MrE9+HELby5TjbNAXVe1tHFTmNQi74m9JfPInFccgHEB40FGHQgds9ly6EKJhmyjK0Z3SwwxTz2t2oK16FtcWU258xz971BAH4nsevS1Jw9GGA2EP5JQdvNYgz51PLHJ1s2AwVk2VfqO+NiNjPW/m6X4q0tugycpdNjwt6RIdbbONI500+uSrbfOZsvQHIg6q9WDn+AtPdD4we5mm3zz/Krbehp1J697rNgHxmUx0yoUQEL273beTo2wd2midrs08jiI7Q7O6VUzbunC1JBHa//SdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZXkDdwkqV3JDkaen0xi+WfWmkYbI7YDXah3E1bYtIk=;
 b=ZMMwb1bhp81Q75JYlobX5MbE6LD2M/PpgtJW9KIIgCOHzaya/9vgHueL+y0y/LJuC0llCH8YtpTNf9587GLauFIgmpumgnBZ65p8XK5y4tm+fFUQFr1CI3LnckxqveF2BVKXRGrpJ/mDdQRghZq7/y8dBcRv/M3G+c1BTIRXzIvOHvaXCphaUaxaoHtLWk7YbqGmRIE64totMbEShuDmjEUEjBCHxhtZZSXuxZIEepzOQv/rnt5qcNBFw7uQtcDoZmU3gYZe1uPbh7nt+T8Ssm3MH7fjSCiZ8gGzZkb1TbUORjDFGMSwQb/AF1yc34moQVjfFx2GwXh2t3qpTfL70Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 25 Aug
 2025 18:07:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 18:07:39 +0000
Date: Mon, 25 Aug 2025 15:07:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix obj_type mismatch for SRQ event
 subscriptions
Message-ID: <20250825180738.GA2085732@nvidia.com>
References: <8f1048e3fdd1fde6b90607ce0ed251afaf8a148c.1755088962.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f1048e3fdd1fde6b90607ce0ed251afaf8a148c.1755088962.git.leon@kernel.org>
X-ClientProxiedBy: YT4PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cb5882-a0e6-4b4c-0662-08dde402471d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o6VCjlObJvX4p90nkP3uP30toO3A7cAyX603fn66l87zenTqPBKyz1bLfICV?=
 =?us-ascii?Q?bUqvOqmeSEY28jF2i3RQcUx/DOhGnjuUYw+Jrstt3Fd/ivM0MnLE6LLPXuxJ?=
 =?us-ascii?Q?EU7Ah74nTyGuX+GuEX8z/NCwqpqs1zVAEP3XLEE4/vqCiPkBa0aQr20liek7?=
 =?us-ascii?Q?iI6FF/XoCquLIOmndzktauYTYdiId+w4fPFN6sYU5rpX5g4JJglp1CnKw68O?=
 =?us-ascii?Q?oYB/aHux7OhyYngq94m12V9GYQPG5vONl/qK9r6+03pV8QKrWiQUc10thmN7?=
 =?us-ascii?Q?CilgUOFNl7e/ergYcIOhe/uauRupvsh99xBaRLdtpNF2EAjqMj868oafhkyN?=
 =?us-ascii?Q?2Xns/NO7+sNSpnaVd0JCbgEfpZtcDnjduIuGMRCitS8o8WbS5Vgq5lendyEe?=
 =?us-ascii?Q?yjmC7hnvdstpW3zSfSycJdmj3FfUIgZZbF+GGcWQHxRdzS77Mxgkuyz/jE1l?=
 =?us-ascii?Q?HM8iOaVPMz8XNKYAwMT6uLCxw358j/R5tCBo/DBycZ/HY7rL/6nihb5XKJc4?=
 =?us-ascii?Q?xIrxAEa5+WDAm656frKxWvacZ2WyocqKY7RZgJVLdNrkHVAsr2kwV6avvluO?=
 =?us-ascii?Q?0NXByOAA9G1Yr8NOZsAb/HPVIo+XpF3beKEZmV7V/F93qllXJMiPrhpzpnyI?=
 =?us-ascii?Q?vqnve9kM6RsmCfkB5FmrerTmTkueyIJ0iaDZTQM3bVkTgtsjNHkDSzLjZgYF?=
 =?us-ascii?Q?jxbFNR3XAhYyjtPjkmd1qw++7X7KBKNZJ8v6DjmmS9lnTxRMBnDC4LsR/3kQ?=
 =?us-ascii?Q?M4/AggUyZapUG3FvTTicglAgePvnKT3tJZOs0wXvnntHzoL/L3HxpxndXz9i?=
 =?us-ascii?Q?Mg0tSitamlj5ZekMecuiy//IRwbHfDpUUw0ULbB0yoPSWChFHGWp8T7sERCV?=
 =?us-ascii?Q?W+uRlLlgq2Aaly4UralqYS5MqVlcCVF8XfSjAM/ml8JNYfEe92L9BC7OVra7?=
 =?us-ascii?Q?8QmdExR6/mjw6FJWYjLzcnXBanx/RsG2ySaZOjdbO9Sq/HifXKo8ua3HNk0K?=
 =?us-ascii?Q?bVW+uNC1G8kBUQPRkrVzjUDbpUOCACPOCSpIbw3KX4Kq+wH3hkIjpwzX79uZ?=
 =?us-ascii?Q?lR8dhdY0vfCy94Vu6BziNxRWZaVWi5dxT7b+XRB5uvjoy9t6kmt2Exqw5xN7?=
 =?us-ascii?Q?uZDRYXGSpHwPdV+IyxeVxo6FGv7ZIyOCoCGLXvfoiqfW9ffPh+QRVwVtqvSL?=
 =?us-ascii?Q?bg4U+hzDXtjowcz17oHK75uPyNBwE3t9wtbt6dFGtwgNACeeCL/NzgegyB2O?=
 =?us-ascii?Q?tDaVDtgftX/TvMQfd5HjnAdUxqvypk4ACiVrjNyjQaC8x/kK85D3eNBscw3s?=
 =?us-ascii?Q?tSnElPsujGkJZCOzA8AD0XRh1ggPt2hicPERuIgwVPOMmvGq8uJ+ImkhxZFz?=
 =?us-ascii?Q?s1xp10Q9PCDs31Fa3oemDkqYml0myURMM5g++ocdGzB+zz/CPZ7Gck9anfxJ?=
 =?us-ascii?Q?WPXPk3504Fw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZIda4q5yp38jR8oxS2xp+TSNxTkPpLWkr0uTntPBueQkQXfkcvS7iELKchCo?=
 =?us-ascii?Q?GP92TQvq3s9zx+YR5Kowt2VWlcGkNqEjNtEKFXoZDrwk4QLpXmz3YxccPsfM?=
 =?us-ascii?Q?6QlaJNHD5QOpHS8ki9VjFAWZDrt7bnYQVnyN/TyabPo0oRgMG10kfkqiIV67?=
 =?us-ascii?Q?/0upjDYFEyFQnLZFGP4q9FykIhONX13fhOByxR8RbvFuRGKNJ41QOKlB0RDO?=
 =?us-ascii?Q?O0Ijcr4urd1QpgBLAtzZiXnFr0yzSRTvsBmYeW7OpqVzQEptN/IJLxY1WwCM?=
 =?us-ascii?Q?LsvCSGiipuN3svqSRGuuxTngVBoyA1bJW5CDBzFaIE3ma/ohmUeIz3zZNHMG?=
 =?us-ascii?Q?tQiS/RkLZlu05Z79HH/Mw01lQ2VImkhdRER0HBCiN2uEtXKL2+kKej4uJzw0?=
 =?us-ascii?Q?2eRRt69eVNPVDLOeyE1f16G4e6dm72vD32IbQ9RVYIqv7p4rDwldOoTrg/Y/?=
 =?us-ascii?Q?T1gbERC3Ogd90+zBTs9wC67yRsgiExdsqUJlqvWjILDZhlTrZXTvkH0o4LJo?=
 =?us-ascii?Q?D7tI1cj1btRhWUJEQSoH3XM0PowV1avhSVygE2B39yVYwkaWVgu0wH6be7Q6?=
 =?us-ascii?Q?0+DvUuI5wj5ki2zhMFgeFRNOeoAhi9p36/aJVPomBreAjEfhWxuJilatpvca?=
 =?us-ascii?Q?bVveo4NyuMLw/Rq6B9xArnedg9kMcqw9u/mDF89qqtLb8HjRShlBpI4Y1+KQ?=
 =?us-ascii?Q?NE87hMPgdwFrqjTFQj4MHSeFCAlmJM/J1rLQv3LO474CxCCn+psZxH2HFOlJ?=
 =?us-ascii?Q?f9+xTUHTn6oBGz2y5/lW39ZyrYO+AWITy7rUR4y96LMda03nIb2kqhhEEZC1?=
 =?us-ascii?Q?XNSw4DWF4lXOvFxHg6VrYXhv/lVgnXdoU2HzrzA5R7rYZCe8ZITMkDXmde9t?=
 =?us-ascii?Q?ovO3vwchqLhf3viMPWcGSKh3roLpO3hxgTO9RL18OQYYzHpv36qZMv4E+9Pv?=
 =?us-ascii?Q?QvpN+7qgAelAjV4FyHySD/iVetm3sjou5JrfXpdIEuASwjE8CNLYmHwni+35?=
 =?us-ascii?Q?hSO7p/DSkR5XJ/pgay7+GuRl5nyEvfpTb8Y2eDBslNi0BlGcmNYj90rC0c+/?=
 =?us-ascii?Q?REiTAwm54EkyMexJtS80HPmcjUycsZ1f3LpyvKyB4owoielgzc3Luew1H9bT?=
 =?us-ascii?Q?pGdul50fFzgoTWakEyDdYcyet23/j7jyaI2F2MI1HpDMFAdYtT89S5sQl4MW?=
 =?us-ascii?Q?zqZ/pky+pmkAEGGC+oPi83yDUUSve97+gDHgLp6ahOQTuB0Vrz2bsOqbcYoI?=
 =?us-ascii?Q?JYW5Hqnv1SY96VVzovSrcNK35Ay4ehkwA/I+DP2vOt6zjnySqfrCvGLAHCAS?=
 =?us-ascii?Q?/0DfHK2UFcgql+ce7beErIb+9ahRZp80V0zdFoDNJOVWMHgRPrcCRVobVXjp?=
 =?us-ascii?Q?i5hvuuyuk+MYlbL+oVmctwH20DqvsEMIkBCg0Jd9uMim1SE/PRdUixgiQune?=
 =?us-ascii?Q?L71QZSXc99D+t2EGW8qUbIuuqEj5F35F3pBqZoisVGf3IE8glaYd9jLyIIiL?=
 =?us-ascii?Q?qjO1CO+ww8lID+UFuRQrLD5zvvYbg342nAun3C37rTJYGoxinQnDgiuhrfD/?=
 =?us-ascii?Q?siOM/p145WhuxBs+nkg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cb5882-a0e6-4b4c-0662-08dde402471d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:07:39.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC+02GzGNIlx8raaF2SHFOnAh7QXWf1dTR2xr6mbOxs/+P6I87tCcJ9GwhTV6Qfr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681

On Wed, Aug 13, 2025 at 03:43:20PM +0300, Leon Romanovsky wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> Fix a bug where the driver's event subscription logic for SRQ-related
> events incorrectly sets obj_type for RMP objects.
> 
> When subscribing to SRQ events, get_legacy_obj_type() did not handle
> the MLX5_CMD_OP_CREATE_RMP case, which caused obj_type to be 0
> (default).
> This led to a mismatch between the obj_type used during subscription
> (0) and the value used during notification (1, taken from the event's
> type field). As a result, event mapping for SRQ objects could fail and
> event notification would not be delivered correctly.
> 
> This fix adds handling for MLX5_CMD_OP_CREATE_RMP in get_legacy_obj_type,
> returning MLX5_EVENT_QUEUE_TYPE_RQ so obj_type is consistent between
> subscription and notification.
> 
> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> Reviewed-by: Edward Srouji <edwards@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next

Thanks,
Jason

