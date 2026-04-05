Return-Path: <linux-rdma+bounces-18989-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rVrGFVr80WmmSAcAu9opvQ
	(envelope-from <linux-rdma+bounces-18989-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 08:08:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CA539D7BF
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 08:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0D98300647E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 06:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD76436AB58;
	Sun,  5 Apr 2026 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T5uD+/qo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C544369207;
	Sun,  5 Apr 2026 06:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775369300; cv=fail; b=ND7MTFKAvpWmfFLQteOd204EQCJacoPvRb+LPoFdc17fkMpyUjjIKu5BTBB1L1jsSkCLIMT5mymDYmsf/glWSDsi/rmZf1xd43NfqAGKLliQCwmoY6uwq2L7t9wLiHKC8YbSGthO3nGbbhRGeKwCiTku5eHvMfOD3aP3+zE730Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775369300; c=relaxed/simple;
	bh=WXBhlVrrXewCge09dAfcnsnhwEdRlBoWVicy47Ur0NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UKqVWZTuTwK+5WUtYbb6znEn+SVaLQxbFFCU4XLa2wrRkDpJaX8TpYeZeziEsAqjiw0olhRiSq44Cvq0EEfG3fVdP3VAPLadJYy3yJS3VVucU1+0S1Xv3BqoecuII1ZHXnU8ObJS2JBvmQoXYqgmtbqYTiZ0QolovlDCZPRC4s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T5uD+/qo; arc=fail smtp.client-ip=52.101.61.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQnC5bhpfrcojBw58mcH6vAQKagQOkS0kC5RxRN3cKbPshdU4jHFVJKO+GWMvJi0wMlEHJalTeuM/KyYVSzUdjixXHeVgHBBdFl147e826edVyfC6303ivMP0EHL8YZWLJpILYIXuarRWPbW7YfFHCQVgi4L3ULuYAsOjQu7T5KSXMxmgAv66DQL4ItbGtauo/ryxuUQ7ObN2wMLExhaMau+fTnYwZ+ja5h6iXpZC5lxQ6oJHZ6qtY+QIF600BsCvPL0OOs3B1OSuvFJ4Zleu63YtZEFME/eRAobduu5SlXvN+GCviiBekRrg3yTvsomkQRv3IABj/R9SLHZCrptiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qi6l561egxcdAp3TFmg82nWPxq6/B01vNwepLiuOgg=;
 b=M+ZlwZHJaio7Y1L2zuT67wxDTl5MnLCUpUKUBE+QcK61SE1NKDYV2VcPaCvq3MwNN7brywHTSjXH8WbU61NGadleCzmstemOmB7BWiZOeIFckn7lhToW6uJbkSVOuKQcPCbVUr5CMj+MLVlHacxbo15/2PvDp031aPJgaqQuAI/rMaKxtw6LXGvBg7D6KEk6R5JCpH4iCQOWVfNf/QbLvTYg+AjSntJdrxJzPozdaFdXVjh6QT6vG4Fnlf/ZLanZBaHPGGwKd8uLVnq5axRwAxtQkTGCAwBptsqaR0LKbMkILgroYQO3t3zX77ovn8Ha6m2dn+uU0cLuDZ6clmnYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qi6l561egxcdAp3TFmg82nWPxq6/B01vNwepLiuOgg=;
 b=T5uD+/qo3qTj9grSf/7IMDFTs52I1izXQr8yn+ux4XHJHAWhVI5HNlSHVyOJEy56HpFGdpM29vSCf4Hi4o2ucRH8db8CtxkTSg3iLGRwD7llmDWlRQSj3igj/n0Tl+ne5Xl8m2a9U0f2SmrRbJvpx/9FpSmgp/4wheXnlB70GnyVdYhhJ9n9tWws8itDHfplibiLb4JylBDtrbdz/0FVHSYfHt1Bsf8GuApeKuNAon/51Gh3YRyUBux6KDDsJs5xghVGhA6DpW9zSC/LGzXYWjlIB+NpUD7jMh0sJtxDCdJnOE+KfRyhORXLl6gTNQMlIwdNfBWsrYyLTna2RJlc/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Sun, 5 Apr
 2026 06:08:13 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9769.015; Sun, 5 Apr 2026
 06:08:13 +0000
Date: Sun, 5 Apr 2026 08:08:06 +0200
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Lama Kayal <lkayal@nvidia.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Nathan Chancellor <nathan@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next V2 4/5] net/mlx5e: XDP, Use a single linear page
 per rq
Message-ID: <adH5yAsPJ8rNgT0k@x13>
References: <20260403090927.139042-1-tariqt@nvidia.com>
 <20260403090927.139042-5-tariqt@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403090927.139042-5-tariqt@nvidia.com>
X-ClientProxiedBy: LO2P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::34) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cae724-7e46-4dea-f182-08de92d9b83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2Csv4m8z8kqo4LWfU1+xgKdS2j85yrPM+oraOssl7dKT7XulgUcjL+naW+I+0jYhiYuurXTHf8lepqoL0zDf9kAz6mCwoiRagnjBFiL9xwchYU736vHAsOcgBpUUT9oSJdngtZWq+6KgzYV2F0amprLmWtQoa0XRPD8N6IB5ipZFnlPeOD5CUobClVdp2fDIUKKVqAV641E9xliBXVBXBJBp4oUMru5d5CUDUXU8zmzVkIluyhuT6+dgGx7JKnV2wRn2d4WQfiaRyImSUpjmyrXPj1LstbtA5do1r1bNNwtbHsJ03cu4IR42xTny8UNukICzC4v76vfYVsoJkfl3NfE9fVlrX6+3kKrnHQvh79UTCOXz0M0JFhxqQxDieDMBjTTGZp1bOdrfLkqT3YYB9+7ap7ENtzEmwoLm3h+ZBBvkK9ZxCQHVZ6uzQcx68hs6PibSkqyRxbpm5qSFW7626/ve74KjRrU15Bt3jy5sNyM0LTE7KtVVHPExRBTVaGVffr9TyiBwyQWbEoJHIw4wAz575DpOKinI2rNDCDd3qPhk1m/bK80Qf58Qxyy5IctDxbIk94J/dXZZ8lwx5/1UVaGaryt6Z1FyUiX/EVUT531j1Bn9gCaR026v+i4NFmUL/1R60TEIwK+yDrKaM/4gYIrNfgyNCrD1PiHFDrBNPYuHJkNHCY/lspS9AnaNdbhd93UHSlhbeS6LZN+6KiGnc9l/51GDLIL+qRQ9Gbm7B5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RGdsX89AdLxJeE+ROC8Q3nOavaRDlJg5Cc80WTKp4Eg6vnWCCbbWp0RlNWzK?=
 =?us-ascii?Q?H9v4KLOZE5K9Lq4N2JcSiTEMAE1Eyni72x1h/xh2kThA3QS+0nCu+QXt19UK?=
 =?us-ascii?Q?zyOSoE3wduzXZLoL1Dk7QeFFfY8SreX+WtsOi9xS0xddAwen3aNhOYv4vMSX?=
 =?us-ascii?Q?gRtQgZrWHPcYGeGJZClvFOci5sBJICzgU8qH7L6L3qiHcIKpUGtfgyWLrgJg?=
 =?us-ascii?Q?eDhpUskJ4ezhg+sxxlrt3XK9QlwPjk0WK5YOodR2cA5V+Xr1arbQoCtqtAOX?=
 =?us-ascii?Q?/VF7jDSsOOeGsMWAPtu2Po1JGXIt+Su70td3yQisZmVuKJubakCRiY/1xZvN?=
 =?us-ascii?Q?pw6KXl8X+ObOASOg1XyHaaoPomLsmS1SzHxdBIrOeVAV9egqW4Ucst/qI1GR?=
 =?us-ascii?Q?P2n9HiOCpI0Bq80OHlKRbw4JjVS2D4eVEMvteZ8sJ2SRTFG1yuSr3v0ryMaD?=
 =?us-ascii?Q?hy3f8mRcSIrBH327AG89vHRJblIQ5p3uIWrRDvV3errZ9PcY9koL8zH7FJHu?=
 =?us-ascii?Q?kxAEYz6Nnjq77BY06cfCcCVJKZz4LXvQyG7CAkFsfHGFu/Y3WlOlFgWdKwMH?=
 =?us-ascii?Q?PR17TBiNkakIWMYV9TV4tHzpPKpgKzJpWAK5tSJ9fHQp9NBzIc3fHo+w/9iy?=
 =?us-ascii?Q?opZmOmBx/Fn/ddTFXwLgIrmBCiVW+r3M6lLUKhh/1Pvz3IXd3QcmrMBdfX4H?=
 =?us-ascii?Q?sXE6KfiTrZ792r7ua7DdbmXQRYY2t0eSSQhSXkqWWKPY+TaDSr/T/H8d4kmZ?=
 =?us-ascii?Q?PQei19GeBSfYQUdaFt2Rv79B835KWkGkaEhIXVQlCGCiAXYpUArEFqOPw7Jd?=
 =?us-ascii?Q?bm1Qeu4Z/N4sKBBa0lBLqCa8xno96rbblmYDkiJ+kJnv47EXk2T73i/IY15I?=
 =?us-ascii?Q?qj55P+68eijJAO8TVyT8oHLgVXQbrsW0vE4zZ038NL2/Ru6+Z6n8dGVeAUic?=
 =?us-ascii?Q?Q4s9kMHYVKZbqc8dNh8WNaWIK0ftGTvI79RwvxRZ0/3Y2a72aafvK8NZmYIm?=
 =?us-ascii?Q?IcUjA4TE9TXIuTm7fR/00ic/qxeYF7vNf+dpg/b9tYXEJAbJp83rw7/Z1Bta?=
 =?us-ascii?Q?n+Vj1uE2JemB1epK/PSzMTPCmJuJQIdGxNMjqUNti8Zk2mpccHG2lQVcaC9T?=
 =?us-ascii?Q?Drj3ByqsGoc9rHzVAnj2HvenOiZpL/O3g2xjOHSI0nGSW8KwtWJmIdRarisP?=
 =?us-ascii?Q?Sic0IlfscGGXF/seO9ktpyjdpu+xwH6tElvJbZEdErzTuxvKftPI5oW4FTfc?=
 =?us-ascii?Q?PoyK72fBJgc8B2sHompBWnqGF5SzdGOjkqRD/W6XEQr81IRwPFuOnKioHoRD?=
 =?us-ascii?Q?mTmomiCVTie6mK2reu12z6lsz+WIfppAhQbd7JfGshsfcJHrlT5Q5N2TAQAw?=
 =?us-ascii?Q?Qc42ffY7Oq47lzLCuflyXAQUWI4d0ysDB/l5UUhp7qcaWRyKvJMWKDUd4bSA?=
 =?us-ascii?Q?cJhvZu6JbYhdWESUrtKhArgLEv4MnnMPGGYUruJ+Ys8EW523wFMd+rKr0utI?=
 =?us-ascii?Q?caozYyGx4Z95+Lqrx6Hag9H2nI3Vms9z/kDQ8bnelCDr5DwMSneaTyYI0e0v?=
 =?us-ascii?Q?Zs/3RNJq6XgO4kIVFGm9PwLAvNVdSDBCFKFmHKxw1r0lFq8Ai8SWeGIeGHtw?=
 =?us-ascii?Q?33UkRQEMMRF1Z4Kdll3aIffbFYEjVTtYq9fx0zRp9M0rvFFeAt2PIxqLwevU?=
 =?us-ascii?Q?PoI3lbTAGsjX8dj0NKuyTuMlF/sObYk1Dymf2n/S8Vy7SmsDY2Pw9qyLfBYu?=
 =?us-ascii?Q?gzspHxph9Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cae724-7e46-4dea-f182-08de92d9b83d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 06:08:13.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkqcrScB3hZHOEgzLkghuPmJh30QBAnUVTmyXb4ddPwQP4L/h3AU0sy1FPX+jt5rNAUDwOe/rVGgA+3/vKEmIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18989-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5CA539D7BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 12:09:26PM +0300, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> Currently in striding rq there is one mlx5e_frag_page member per WQE for
> the linear page. This linear page is used only in XDP multi-buffer mode.
> This is wasteful because only one linear page is needed per rq: the page
> gets refreshed on every packet, regardless of WQE. Furthermore, it is
> not needed in other modes (non-XDP, XDP single-buffer).
> 
> This change moves the linear page into its own structure (struct
> mlx5_mpw_linear_info) and allocates it only when necessary.
> 
> A special structure is created because an upcoming patch will extend
> this structure to support fragmentation of the linear page.
> 
> This patch has no functional changes.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  6 ++-
>
> [...]
> +static int mlx5e_rq_alloc_mpwqe_linear_info(struct mlx5e_rq *rq, int node,
> +					    struct mlx5e_params *params,
> +					    struct mlx5e_rq_opt_param *rqo,
> +					    u32 *pool_size)
> +{
> +	struct mlx5_core_dev *mdev = rq->mdev;
> +	struct mlx5e_mpw_linear_info *li;
> +
> +	if (mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo) ||
> +	    !params->xdp_prog)
> +		return 0;
> +
sashiko says:
"""
Could mlx5e_rx_mpwqe_is_linear_skb() return true here (meaning li is not
allocated), but later return false when the rx handlers are being set up?

When mlx5e_open_rq() sets up handlers it passes NULL for rqo to
mlx5e_rx_mpwqe_is_linear_skb(). Inside that function, without rqo, the
page_shift calculation falls back to the system PAGE_SHIFT rather than
rqo->qcfg->rx_page_size. A smaller page_shift could cause the stride check
to fail, returning false.
If the allocation evaluates to true (skipping allocation) but the handler setup
evaluates to false, the nonlinear handler mlx5e_skb_from_cqe_mpwrq_nonlinear
will be used for the queue.
"""

This is by design. HW-GRO is the mode that Sashiko is talking about. In
that mode linear_info is not used hence not allocated.

> [...]
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1869,6 +1869,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
>  	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
>  	struct mlx5e_frag_page *head_page = frag_page;
> +	struct mlx5e_frag_page *linear_page = NULL;
>  	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
>  	u32 page_size = BIT(rq->mpwqe.page_shift);
>  	u32 frag_offset    = head_offset;
> @@ -1897,13 +1898,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  	if (prog) {
>  		/* area for bpf_xdp_[store|load]_bytes */
>  		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
> +
> +		linear_page = &rq->mpwqe.linear_info->frag_page;
"""
If mlx5e_skb_from_cqe_mpwrq_nonlinear() is invoked but linear_info was skipped
during allocation, does this result in a NULL pointer dereference when accessing
linear_info->frag_page?
"""

Connected to the statement above. linear_page will always be allocated
for this handler.

[1] https://sashiko.dev/#/patchset/20260403090927.139042-1-tariqt%40nvidia.com?part=4

Thanks,
Dragos

