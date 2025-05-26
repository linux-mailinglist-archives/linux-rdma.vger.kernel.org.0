Return-Path: <linux-rdma+bounces-10726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DBAAC4281
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 17:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860C93BCA6B
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F9213E61;
	Mon, 26 May 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fn6Ytk2j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F092101B7;
	Mon, 26 May 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274101; cv=fail; b=OKSi4oXROINmyJqvX1nj1iCXO5+apRYf1y+WGlbpKFptHmelcbfCVMtPEl91q69KGNoz6u2E1pJFU1BjSKoScf7im4v620MbNHj0dvnL7aU8NPbgKIlg7jgAZWNA5PrV6izYh3psXG6izw1ENagkVNq2EsSiGxXxKz0M5ZJb9bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274101; c=relaxed/simple;
	bh=L025/Volje0xq5OibniD0CNa2bgUGkxjE2n6JgXflZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dtnd9lu9bVymsKlK2qaa0oGWWwp4DmjTBARYKN9PGn20I91Onx/3k1fG2XwigvDP0TpLQE9hShedpEr4A4cbb2K7nigKczmOJHFF4zaSw/FA6a3ev78fdJPdcRLio3tEaZrxn7LpJmDLAaPYG+ICJdNx98TeriMGDSDywGoo7Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fn6Ytk2j; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMaMEfk2dFdgZgEJcca0FdVyxO02BmD/KrsPkKvlCCsck+VAG8RQcUz1BRNetQ6i5DzZTWmE/uzkxyYOIl7P6LOH3ykw5NHnu3IwAjOVZY3vi1eBDAee3g3NGx2YBrqetLoBIUtdW4AUyz8X0PwaCGRu165yEzcsg24zARe1tw/rCJlYWsSEOd6wHCq44GCmImfVhmcWy1gVS4XvJDUxeUleh7LEnZSe6In/yH/kBg4c/7u06r+O2tzYymE6spugL5WCnaqC3POMZQdB1BvV25i76LqdfVgzzNhDs/0kpldqTIz/gSyRzAxMMaaF5IlNSj7Dh7uSRRGvo7LAnek1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBriJYn4hgSOwZM3wQZYHmuMzfJmD0FUd/WWghOVJvk=;
 b=b9OVBb0UaAuHFNwzM49E1OKyvkLHtYf8XTFtLdM03Si5yHZs5CBPgkIsokAFsSrQdCk9bpPSDJ7HyvpdMbqHHtHEnlfkjbQOQEqq64wgdWOB9yVWIDmO7TNnKeCR8PlZZP1AdIiIx19pXMu4siEmunIXtC3XjIfZdPo4XaqfRCen0uOjO2pwCebUicwu7YOupjdhDxHlOkFyu+rjCY80H9nI6rjZxiZD/OJEWuG+ESpHPyW+Dj7hx4MCc8RSg7zbfUeMpxwRgnFapRBnvK9JqVexahJ2LCYza3u+AYM23ZBczV7w0Mt/VJ/yIrA+9CZls0/iHVfT4D9fGPB0hQDI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBriJYn4hgSOwZM3wQZYHmuMzfJmD0FUd/WWghOVJvk=;
 b=fn6Ytk2j2c7Gv4MQNGsPJP85rXtzPmlA3EezVNpHD1iNtTxZANZSAwgU9Ph+HXPTdoaXcIO7XOU6M+JEnAArJVaBSSYMLnis809P0ymf0cRK0tJrPN6XobCLb+aE4lAjGXPxxYzlkw5eET54h7oMVsbDgrapAPIIqtNPnC3prpcXhicK3rxrfz/X7AlJd2LT+Uv0Jg4Vdw9AAgHTC+d1XQy8XkRB8BC3FhkouiLPA0bX/yBzxqySK2GrySlwNMOpljlBdFcjYxj1qLPtDt1jkB1PDiSIf3e8OD7F6oz9TUdTxPneRUtPBL1RNv5y+ywjUgOXABEtym4Ucn+bh8sWOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 15:41:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 15:41:34 +0000
Date: Mon, 26 May 2025 12:41:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, leon@kernel.org, andrew+netdev@lunn.ch,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Introduce AMD Pensando RDMA driver
Message-ID: <20250526154133.GF9786@nvidia.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
 <aCuywoNni6M+i07r@nvidia.com>
 <6bc6fb63-2a31-808d-91f3-eb07a681e631@amd.com>
 <20250526131938.GB9786@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526131938.GB9786@nvidia.com>
X-ClientProxiedBy: MN0PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:208:530::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fed64b-9289-4c3f-cf76-08dd9c6bcb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vzaE4NJyeOOCDLaUOKE0doWf+pP4X0yojBhByehcYXt2AZtQCbHeLf/FHd8o?=
 =?us-ascii?Q?UWJ/zzX6JveaXg07ZTB4cSIbls4/IkLvCHacQtOlnmlhpBUSJhjwWUT6a4xf?=
 =?us-ascii?Q?j0GHm0CEi6Gqc88hr5MYTyJpDF9oO0XDr0oWn3KMPtJVhP8uRegmAynTOpsK?=
 =?us-ascii?Q?coufvAgFOmC28buvVOFNSuwYBjrueZqkjyFJBAevnz89f1GByiYgg5QTw5rC?=
 =?us-ascii?Q?Wvil7/FyiG0sE/iyh07/Mz2Fiq6YzbGpeVEjcjxu4cmfMCUvnxGsRdVDoY28?=
 =?us-ascii?Q?BRhU7cXZFyxfsdJBULCaM3idKRefAHCMe5XHDYcRhfaaKUIAZpNB99CQg9GT?=
 =?us-ascii?Q?4tG38pEo7343qtG3I2UvuYIFerLkk+M8CT3bytetuA+YC5D7zLmytC5pIY+j?=
 =?us-ascii?Q?/9Cc0A6V5CcPzc061XtrzbkG+kwNiPpK+zuBr+S2tSpssuWbsOJJZenSb0lP?=
 =?us-ascii?Q?ZtTSMFNJPzNLRpTJNcUQ69c/kYa8pbmuTlwhVFhDlXRXgVl38hh4XnaIPZCw?=
 =?us-ascii?Q?oeS0UvzcMRXYsn6gU2HUMHCApbJjEmYiSTE/QGgOlhiFpseehd2MMr+xn8Xx?=
 =?us-ascii?Q?NguRM4O+kse7asuQvn91QNn7hi75RsJBvEoMFJihW+3PNlrEx7BI8hXD1GmB?=
 =?us-ascii?Q?dCJdlZ1KS+k3dGunORUYu3wsVQBDKNZQrlJWQ4WdSemwzBfcKPXzN49/GZur?=
 =?us-ascii?Q?Qv9yGO8Qlw+k4d73IKkQv5/Sd2RTSLf5omtRc6edTEWSAwhcXULOasPN9SRz?=
 =?us-ascii?Q?gmWX08DE5yoCHVMT7bNNrB7Y9Baea4aD6zhrIDYzWzrhEOF5nQMH+4Xd2CYr?=
 =?us-ascii?Q?I/2Mjw0vnzBA81sYOl0k9MxKJ7wHi29H+V9BuXrgeN3W5mRoLcp/mP92eRqz?=
 =?us-ascii?Q?DZfIdkf1uswj3Gqe2k2QiCgbQGEw7oP8yc82jPwVsZEkzn2VrrViQvpW5tY9?=
 =?us-ascii?Q?Vnz5a8WisyLBSnStLrSI8ob4R/kuhqTlT/D5qm82SHOo+pfr0jElVuRrRu+4?=
 =?us-ascii?Q?gX4qBGB4g+4q0wRoIO47xcYpud46U+PY5TPtEmSglAw438WujZpKGNLiq+w6?=
 =?us-ascii?Q?8evl0APx/ixNCaAFmwTyEna0cvz4prgnL99yH9U5zDxOZ6BaqtUEVlFSUXI0?=
 =?us-ascii?Q?1N9g5g/z6EkAz6EW1pU2FxQBiMWSfNt2/ryEnEPrrXgDMX+52b18xwf/vZlc?=
 =?us-ascii?Q?E2oR2AwIpjMdYkBXnSZgF4Rx0oOHsx0PcFR4s94J4MStKrFp4QdfRGDo1gjz?=
 =?us-ascii?Q?1hnwg/Vx5CwfVEmvf1YJ9UqYftqIzTG1QUT2AVmZQ9RkB977SscLfPYzOp3D?=
 =?us-ascii?Q?kBW+MPClGQY3xxVgkND/ahZ7Lc7U4sVCCckXrqmbI7A3Ii6NOZnjqz1qHU/Z?=
 =?us-ascii?Q?bAoR8oO/cLVaaL3+US8vEB0MRTErN/X3Ih6jYA5BE7RWVeCCDeb00gsTAJnq?=
 =?us-ascii?Q?9Z1XuuGXJIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mikpjYfdlRR7mXUfugJ+kUGu3v1OPDgzHqG+3q8m4lC7CseYdzqoqMDNHRht?=
 =?us-ascii?Q?M9IfHc+RUd8o0SmlCwK7TFN2ywa46LZpZ8kgRJT4PvNu2UsUQIFHjKH7I+oN?=
 =?us-ascii?Q?8m4WlrTAvJkB94Hon4iulnv15/54km5jfvGt7BScvkzAZE9xs4Cqx4eusHBW?=
 =?us-ascii?Q?LF1iYF/no+B4NAX4iqJLGmQAgN1YUK4DrAG6LYiXhemnjSM0WOqcXzhXOJV9?=
 =?us-ascii?Q?sbWy+ooBLsvVvrOJXI0H+bkC228Xa4vWjysIMZg1mmATI+BZmhRaxpf96O6s?=
 =?us-ascii?Q?FiRGiytDi/yVNhqpGPNhJ2Sxgyngj39zt6ZBjMx+BNsPYrokU5IlhLBlP6Do?=
 =?us-ascii?Q?gH/yyCoiXIrSJhy+dLQFFV/3Fc33JZnmcu2HOJW7Jzea+lZa1QisOwv4bqiY?=
 =?us-ascii?Q?DawrAYfgoU7EVLDui0CZynA26POcLyH9lYw2l1rwF61NZMtUzSnqKooFVWM5?=
 =?us-ascii?Q?0DOYCjq/Qg2vivGXXS68dEnsCf7RZhIN3vYEjw5SbyMf+6wVnswnXIWOvK3W?=
 =?us-ascii?Q?7t2gpzp1x4FQrjxvWGvIFINRQeDtD053MiSWHjvEZ+gIiMXLhP3FjofegttL?=
 =?us-ascii?Q?kPSc/6FaPF92RR7pGov70LZceq6qjaKm7s+SW03ptQwymdc/yB8e1cAtto21?=
 =?us-ascii?Q?3cEB8QQz3rK2e32zoEI8jxo66yzqlaXal7OwzjSLVnRsY186zsnlmYM7woSA?=
 =?us-ascii?Q?T3P62ggOdiblRo/IfL2Qlg49RSlcXYAyY22AU5MpGTtOoL4XnEDRripdcaUG?=
 =?us-ascii?Q?lSJDPGAKEA+qDX5IL3zf4S6cqFbTDNDFj9wKqQiU2T3iXFPkrZThUlFqeuK2?=
 =?us-ascii?Q?ZmAmjDotE2oWoQAKhaCLHa+MHcZakW6ZMq2g6TfnnEcd/ktoG/cGy8PsaNFl?=
 =?us-ascii?Q?YCOk9zuR/G+yZWok5SuYwdYp0ylpN8QS8LGpwf6VyD50mF8tdnJjFrSikj8y?=
 =?us-ascii?Q?AFUqmHdKoshHn8OVCouLSmUz6l3s211WHTDIrvNR4Sm8UniHa6+uGqyy5Uq4?=
 =?us-ascii?Q?w7lGumhO4QFpOutITPguLfoGmqayegvEYFz3mDZPLhFiRoPzseojdEqO2/WR?=
 =?us-ascii?Q?cpNXpCfjhRTaf6hUCSlyO6o9eKfxGCgnU7oLCnCFeYY9sgTFCGVnqKMbLPix?=
 =?us-ascii?Q?EBc3gFvpzdJ71BTBZahvDq6kDzRz+pL/0phtGISZCH0XExuKsmRY4IZyF5iu?=
 =?us-ascii?Q?46IdXh6I/V1wBOQIEbtkwW4u0v+k7PYix7FsC0t5SBjCxChCB5FoANdHfoLU?=
 =?us-ascii?Q?3rvMIQ8wrbc07GSFDCWfIXUclOkBNxZmCKISt2+DwSIlojlFCbJ9dFyk+qTb?=
 =?us-ascii?Q?tsu6imRhh183s9kgNbhcUkFkvGpUDT/8wGCtomu/ONExFqfFdzr8aNXyHvav?=
 =?us-ascii?Q?yQjnLHQ+AhfNChq1FdP4KTniRADpZmyR75/17uuZiZzWz/gNSIcKwTRqQsvm?=
 =?us-ascii?Q?yTzp8p3AbASo0I6CGfWLBGkdL1Fc1t4N1B7ecWFs03sBzj1g7j9vuEb6zqFB?=
 =?us-ascii?Q?BXU2dgTchMsHSuz4alF+jD8UEn7+pDRvxjItYY9pgj0qpneyfPWnp0Sa0Dnl?=
 =?us-ascii?Q?V+ivkLwTFPeX1R3Gm6UwewytndCKt1nYAVfQrtUU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fed64b-9289-4c3f-cf76-08dd9c6bcb88
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 15:41:34.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKJ6gwYIKjFNTJEcOwKnTAHBNYDJ6zjsqMgLz0n0I4+BxEBOPVcM7BkL4T/cX7Ev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384

On Mon, May 26, 2025 at 10:19:38AM -0300, Jason Gunthorpe wrote:
> > > @@ -1454,11 +1466,15 @@ static int ionic_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
> > >   static bool pd_local_privileged(struct ib_pd *pd)
> > >   {
> > > +	/* That isn't how it works, only the lkey get_dma_mr() returns is
> > > +	special and must be used on any WRs that require it. WRs refering to any
> > > +	other lkeys must behave normally. */
> > >   	return !pd->uobject;
> > >   }

I was thinking about this some more, probably the call to get_dma_mr()
should set a flag in the pd struct (you need a pds_pd struct) which
indicates that the IONIC_DMA_LKEY is enabled on that PD. Then all
QPs/etc created against the PD should allow using it.

Checking a uobject here is just a little weird.

Jason

