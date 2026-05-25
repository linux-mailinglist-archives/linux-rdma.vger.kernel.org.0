Return-Path: <linux-rdma+bounces-21247-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN6LA8J6FGokNgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21247-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 18:37:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3CC5CCEFF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C980F3013A7B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AFB3AC0C2;
	Mon, 25 May 2026 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DBlmLopF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00738228F
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727035; cv=fail; b=tsYwmNtPZ8kycj91UBOWQbs6q/AWNWHJ0qTWW0/7hClHjPBmQ9+cV2yxDJFyCU4dwZkSy5RMy+RqU/Ob0YZpXmGNECCTsSMplVL8TKKIV/zy3TojnjDPimQL2vy8r+qoWn4/urExKgd+OgHBQE0NVdT2fULND+SE6H/P1/fcOQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727035; c=relaxed/simple;
	bh=C/g1B0EhoQ0/zRsv7w42Qrbik+tlSprKen8lpIvdc3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h9429gmh/1aRXwbYgZtCLYp66m6eigBmwbAly8wqsmRj8B8PJDzRW6q3VLZ0AJuFrQfrPx7IdThV/4H4gNZkCU3CjjJkYFPRF0NOUYHZdnydiSFAjwsR3LABIkSj+b23D2wkqreLyV/kDXSz54OLQmvKmQhgmnlL2iKkMxgBkBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DBlmLopF; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdge0dzYzt8/Cclg0qHfeHzEklR8X75bOOOlzfsPoH39Tvschkl8N0nmZv+bzSMxvWlgBW+vAzZoNpbIdURxLPh+39fVHcXXUzz0b8qP7mfikbXAdtqfXLnFlne8CwotyZ1ppyGt4Fa/X5Au/JYe9NKcQhh4S5KEcq7amJTW6EtRZ/mpgcfTkklDr6ca680kVhpssNgl6BLBZslRPClWzlpWdAfcoSU5b96299QFf0+2zFyANHHhd9oEm9DkEwKHGdeb6OyXmQz89Of0hN4CNxSivlAVcUgJ4LIANyJ6n/gYH0rrPrisKciwRqMa/89fCSMW0o1+CRal6hUH0FMKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYE516+Pj5/Y6eg0zZl7ycqfvIlyWsG8mQhJDXNYkpY=;
 b=QgockKcGGKYEzmWJnjNaLrl6bFgNYMA7sgCMC25FKSkQY258oVSLsdbgx0v4dgu4+mzbrS5rO9nVVMGUlPrwaXv3bi9vcji19o7dctrMqnm7+WAjO9inbG7B/U0o+jZqyv/CTVrWAzfQ2CY7/X47UHPzU6cLN3zER9HddzZdJdvmn05mGZr1lIWZg11OgAt4XYRqNjkVVyJ2ZBV6Bf8gna58FIAGkkGZUZDKmZ6aQuCN01UQBYNMDyEmWLoN9A1Xpo4lZMox43dbDr9H2pFqnsnkiBOiSZYDzgIoJAVVLiSjB2twJuRGfXig3d/cblMzWbvM8IHQklWM4TQoSmMeFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYE516+Pj5/Y6eg0zZl7ycqfvIlyWsG8mQhJDXNYkpY=;
 b=DBlmLopFhCp92XJxo9UCVFjdFsqVnLg276kqGRl+NAGgzbfn2HlOGH1m8RYhWt/o2/4ggvxtvejI0+aM/xeaVvM1gTqyLkblhsmAXRH+no1YWiG3jhnFf3IC1r2PiTzdC6pR7N0Thj9/shAKqiQxMSrg+UhPkbhV0N2VF1PZtIQ4wSNsYCk1TzzrOkzCHmD8kyGKE8tFxVoQWYZU3FgVPUcmxUwinZ3ct5EMQ7FDBXmcb4GbjwKcuCsxmEOYr+w9A9+FNAoMfqlyFD/FE0X3tnGxJ0MVBiAQRKLxBUtduMk5deNPB3EJSH6gHEmcVqi8GiiV2/lOdFwinveCkk3qIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 16:37:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 16:37:10 +0000
Date: Mon, 25 May 2026 13:37:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Boshi Yu <boshiyu@linux.alibaba.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 3/3] RDMA/erdma: Implement
 erdma_reg_user_mr_dmabuf
Message-ID: <20260525163708.GA2504127@nvidia.com>
References: <20260518120637.16831-1-boshiyu@linux.alibaba.com>
 <20260518120637.16831-4-boshiyu@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518120637.16831-4-boshiyu@linux.alibaba.com>
X-ClientProxiedBy: YT4PR01CA0242.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afe863a-c242-4233-71c9-08deba7bddbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	gS718Ell7sdaZrF8zrbOQ3ra58QMFJ8cp/RHzY65vVyEhqx6d6EOa+u0RvOktnF7fyhUpqB5cs/a7tMLKHu/mCyib6wVPY7KidOSS0pXmHioKOLuU7elpNMEhYBksWs+H9TThjU08y3RBFmJLJssonk/XsmWFo4fd21L7XQV0qCl1LXnFMxnfbML+qiueL658wA1iyWtkNtlm+1yUXMwPEVdO7tFDXajs+qzb3bd0sackOAckkLS4u2gAMBljroMGUce6xdkjo9vPBtcbGGSQMkErTw6xWiv5kgm8taDvpay4Wx5n2JCFjlJPKoBE2sxH11EEKcCboNTHy01sWcq8gTMRfrBd13IaKPyukMQb10Rw/MMINoVCcLVZEIpcioCB5015b9X3a3rFuuoCfEMN77gvTt2Wko7EB9ccp3mJhou74SKmMwdpq74t+wzhbE1kLShjGAOsUJED5Clu5IucXcxFy2M78Dg8Fq6aygv+aHU7tOKyArsvKClVtthiL2djnUeSltC4/E0FfQdE7I1jntrEIHr34iP5AHut1i7GIO4hOGhSZfOBiEiprBSy878r2tF/7nmGqbPv9lFQECS6y/WHT/cFOx3VpBeH+L8bUw2GTbOoUanODe1shs30tFAi1vNJwq9NG5j99RVbflSK3pkELDFwZGzaHauClCuGcS9SSzACUtJcYrJiaSGGYt+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w6oXNp62APYylkZPNwM6Ahz5S/qLY2Z0oKoKL0+uzjiwcFcb5VkUjkLS2wDe?=
 =?us-ascii?Q?a42gSFp8gttmE1zHZ3VgSWaF3aIkaG08cyOiB9RlBIqPwKr6XOoFxZ8Nl1mp?=
 =?us-ascii?Q?LV7FPg81FpLmJAkCQzq7NH1+bD/WPBz64TTvIUgtLnUUSuWccLeDFwFVk4nU?=
 =?us-ascii?Q?tQekks4tjwsEbanaQcYXTlvwCURb5ygCrHAgy3O6keyU8l42XpPReePXoMIe?=
 =?us-ascii?Q?VR6qtckEUbLeEdhz2sKZpNK72fwrw2rGZLHMKp2CeFSytRZdEG5QpjUxaU/T?=
 =?us-ascii?Q?nM9VymhNTRdySxWj90G5cgAZBd1tKVHmP5Z/Gddg+qbeS3JEF+oo9e8LPdxf?=
 =?us-ascii?Q?hmptc5hr1b1UVu06EUk6qJp9IfeRUKrsZGstxLF43nUpbaAvdWXQk4SaFZHv?=
 =?us-ascii?Q?m89Zx+/TQi4oKvUEjlYjDBHtEqJXxxIs8azmI09h/KXI2AaVq1t9STg8TDM/?=
 =?us-ascii?Q?0qGr6cM5d6mcmkBelGA+/Xdf4/5113iIW0NKkTIgDVY5rCCC5LqleUQ+QQo8?=
 =?us-ascii?Q?sr2y5lsmT7iA4Gobkr7Oqe7m8Ps34nxO2/+DlhA4WSdEt0fV+RcVPKfunI39?=
 =?us-ascii?Q?v58lX7fnOQ/qWvMPrY0nsK2SQ6i0GyTMMMxEUB3+rahV6KLr+BAjNsqv1zvL?=
 =?us-ascii?Q?qUGdouNg/PavFUOTZtS5YAcTnY5bbgBb3RXpehPA1CKE4taNB9NkQDj+XgjF?=
 =?us-ascii?Q?ppGhwxav46JUjhnBcGg8ajVBV/D7dO50I9adwejRbKuGdwwjdWoZu88WsSNl?=
 =?us-ascii?Q?AWI+3Js8f7fipxTMj5sspHQSn/Ozp7ZVc1LXCm/tg4az+D2Kg75ML/v5DrbM?=
 =?us-ascii?Q?JlNcSFk6mIo+VvzuRmnYZJscZ8WjJ3a6hXLtwY8mG/kCOfFOjm+v6GuPAVYc?=
 =?us-ascii?Q?kWilx8x4Bkft+cwSR8DOBWviehG9mJm681B/QDGNJd/fadJy+2X1pYhX5Bo/?=
 =?us-ascii?Q?J59vD/xUf0jVmLO0mMY1S4SLA1yOa9qas8ZfjRuInuKaV6J3Tlw7+R6nXhVp?=
 =?us-ascii?Q?2Lm6P+4EpqOT1cMqzp55gWIyLgWFYoVr4LPRJFTW8R7FVlxJqkEJkh36JRHq?=
 =?us-ascii?Q?g78wz5reDv9U2S9DiDp02+N7+upttcI/4SizG88usRdtf1dxuLAv/S3MVzdR?=
 =?us-ascii?Q?5UkxA+jGgLeXt1DRmXdFVNci1dPvkuvuNAeiIZpluVenlexIA/M+YatX7Whs?=
 =?us-ascii?Q?lJPD2+Yt+W7lVNuEwH23Ow1e0837zX6t+wK6Ml71lKq70sDVQqw34qZFszPH?=
 =?us-ascii?Q?Nmz67ptqUAzggRLc5SUB5t52aWZ2hdvv9PjuFJjcukpdrZp3odXZtgQnYOOg?=
 =?us-ascii?Q?OwPGyNd723a6dPEHQ1ZXiJaWBM8faWi1R5AY9zMtjleYqQFRabTt3siKmDLd?=
 =?us-ascii?Q?ZTYBGSANkc9f4SMEfpMS2lcaFKpkJwZGzpy5dQnOWDuFjQ/lNDoAmcSUIHdz?=
 =?us-ascii?Q?Qg3FjNKjURu7D1SfAOMV8sKXS3g17swUiWyMNsWHcqdV8l3rfa1yBzGC4nVx?=
 =?us-ascii?Q?9eMbszfjji9XTQ0pwK5/NCnIaLBK/FURcYmo+UJqGUqfPx3DkVDP6QNZ+BUE?=
 =?us-ascii?Q?Y+x6NvyBYGGZ1k2PBDoNNluCSTAqFXxzehYlkvcf3LLaaSOc6hCNHbmHMek3?=
 =?us-ascii?Q?V8cRUJYv5Fr9gikm7Dl5Fz1vWaTp3c5vtH9vwnNOLkYMa8FtHv1eqvOJvAje?=
 =?us-ascii?Q?OQC83l6pfd2ZbwULFMLKMvZaE8cW1hUEouSfyYnclosY/fvJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afe863a-c242-4233-71c9-08deba7bddbc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 16:37:09.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZlCuo5sffyunEQAb0YjRrm1rTFXUdi4jwHCWWf93cGgXrmoW3TGbXJJZpnTWdBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21247-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 5F3CC5CCEFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 08:06:28PM +0800, Boshi Yu wrote:
> +	if (attr->flags & ERDMA_MEM_FLAG_DMABUF) {
> +		umem_dmabuf = ib_umem_dmabuf_get_pinned(&dev->ibdev,
> +							attr->start, attr->len,
> +							attr->fd, attr->access);
> +		if (IS_ERR(umem_dmabuf)) {

I don't want to see new MR implementations that use the get_pinned
interface.

Please implement the revoked interface Jacob added:

commit ff85a2ebacbdaec9f28c4660c991295ace93cd1c
Author: Jacob Moroni <jmoroni@google.com>
Date:   Thu Mar 5 17:08:24 2026 +0000

    RDMA/umem: Add pinned revocable dmabuf import interface
    
    Added an interface for importing a pinned but revocable dmabuf.
    This interface can be used by drivers that are capable of revocation
    so that they can import dmabufs from exporters that may require it,
    such as VFIO.


Any IBTA compliant device should be implement revoke at least through
regreg_mr.

Jason

