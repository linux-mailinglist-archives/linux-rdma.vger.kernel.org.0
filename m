Return-Path: <linux-rdma+bounces-18990-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC+nELMB0mmiSQcAu9opvQ
	(envelope-from <linux-rdma+bounces-18990-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 08:31:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A6F39D803
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 08:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DF5C300D69E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 06:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A072D9EDB;
	Sun,  5 Apr 2026 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A0QF7HNM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F82236F7;
	Sun,  5 Apr 2026 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775370665; cv=fail; b=l1ZqPAWo/R6KZvzqTbfAeqlM4Ebr8mIK0+Nv3Wk4ne+i97yxIdw8CFuS68Liy6ATR8WZLUHegSV+4ZnQuKlVthXG13nW7KeOvVX9DaWr1TKo85OFWqoe0zRyNw+RrzfwZrAWT3lg1t9BQBFiEkoCbYUBERv4gPNh9uBMF4wP27s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775370665; c=relaxed/simple;
	bh=n+agWQ4IvI7Q3BKlFbH3gxCpWLOyVPk7fIFtTnHyzKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aPtNFpvcE4VPfAR1HY++U0Kvfc5TWuH88+Ows2oO3vFQ+MmrFb9QygAA2HtwnzAKpYaEeKH7jbgxElZxtGwLXNCh/L3iNLX+T6Kj/byTN68thEBm3fpS/k1okX4IuZjln/Xp0WLHTFUuUmtWU6ypP0BeL2UsZ5PkB4R5IDIyXfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A0QF7HNM; arc=fail smtp.client-ip=52.101.61.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V69mfN3/Qi6ywVbZL0xbRrXJox98DAOBz2z2tnkZN6pg8GCHVkka6QFnf7T17QIwwUXGU/W5PcKcMxoCBKrv4sz27S7jYxP3/mjhFNctGFAkGjEldX0fOterj/hJxGcvcKgIXV2tKZ5pUFpMo1Zq5jyxiQSZfaS1tPquMu11eqNRG6gsNBpAt3JziEo48ZRMjdoUcNovya7DjVMQcxDY/MPsIBRPNZQSlxwwBXntLuZvRtQHXfuL7fxmbtfvjf6qK1cGfRun5xsSB7cx6/ZnUwBo97gJ8ot2qVfUm5yNpNJQkbVwwbOu607OxjQq2Y0YHFPArzs2c+Jj0lk5jHt7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEUPd4p9SsjKjald0weWk2LPTXT0R4bfYSpsuaNkpNQ=;
 b=Pc3FRjIVxyAd6KWJkCdNquD+mOokNu/vpsmkZjzjTIBkdhY1PhEeu7maJKMf1o5qmgKVJdFE/eaXnU/RKFHD9OxrJlkDOc2rTt9Lx/uwELtm8WebtGcrbVFNmumfqwWi3MkusUGyZseheNoc+EN04mpmQsdQ7whWtZstlgGcME2oNc2+cIrCVE7k/gvswkBjGAf1FDoTxkgcIGjcmnL5NJD5k03GsezR1zXBuagNjdzqHeXXilLqZP84SnvswzT9ZEgp+LuDSKX6EaaIbWRfTUl4wWXESDsHKgonRIXcV7ZsC9W+pzftlQiOSw6Kt42Ke9/+lLzw78Xx6sdmd7T0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEUPd4p9SsjKjald0weWk2LPTXT0R4bfYSpsuaNkpNQ=;
 b=A0QF7HNM/BbGTcOgvmrvqGF0CkUW5Sw2CeYswxI78Xe2araW92rcEScZYXQLxdPXWGb1CwrqHG4oeK4L/k4GPaHyw8IrKNZz8KrJh5Zio+qdUgpP6L5lg8cyiacKYmNuGrdxhKKC1qA/yoC3tMYjGeMJrk4LqwgokACEcDU0rDyggardIuuqB+PKJsuV1e5mEa1KvP4ptKPsNEiWjxho+NgxJDwIBITmagKjgHLGq35KPJVSwKmr5kEsb+sy6x6hMNz61Bgg3HpNUjziQpj7Qvc2eCmg/r5H2Q/RZ7PraICmP4sQtVncpKEI+9aRXij90aWvoJKmbsh2/4+VLOXgQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Sun, 5 Apr
 2026 06:30:56 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9769.015; Sun, 5 Apr 2026
 06:30:56 +0000
Date: Sun, 5 Apr 2026 08:30:51 +0200
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
Subject: Re: [PATCH net-next V2 1/5] net/mlx5e: XSK, Increase size for
 chunk_size param
Message-ID: <adIANNrS8QspFy0b@x13>
References: <20260403090927.139042-1-tariqt@nvidia.com>
 <20260403090927.139042-2-tariqt@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403090927.139042-2-tariqt@nvidia.com>
X-ClientProxiedBy: LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::32) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf61dff-0a62-4c35-493f-08de92dce4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6sUZwnDPc71rzkCLsafjejiIhe9jcoEMrcq4EdJX34kJdte+uWa26llSVU9A18ZTsU8BljmS6YjlRodqOePAuIDUpQBzcq3CohaRRKa5qeztcy3Bxc3BsnYtYlLAxJ/F39mvVvpNI6CbDbnIe4S5nuhMqu4AVgtpVPdFY/QAi/zc5gIxmfnF05CQ0Or4YVJcz0R/ghDLu2tkcYqz6bRvTtRskkPsfpOTWsr9syrOnVvWRW6SG+ZgVajACLKlfNXnnCNqF9PcJ0toQyWvVkq124vh7gIMmBp48/vYJGwsUHOYt+xRE5sJoxtwVXecKXKyuvdeAtQIbV7JCHH/mjl8t4mC5hY1jXNUEP6iYHofgV2G6Dg/pBZoEiuC+XxIYPvHGiPTWO/nAYn+lGckAJO5+EYIrDNcmgUcfAZNsWTZrOjtbsTzMoe9TS88e+IrhhGm54tCFYhbMTo6V81Luu1bGNbjqSIFjUX4ZFxOpmbSC/ZbXyl3/swfg7bKa1qgcoWQ4Z75rICsgjaILUoS7VyiK9mL8cv4/PvS8gdtAOX19vOYekWw9trl5BiQmQlAx2Yw/unWMqcWKUprbxIvA8tbp63+iFzAMMrg4aavSFuuOmW9hsees04AjgszLlhQp+PVps/+Uy6pv6UpS4dsmJun0/8JYshHjmOZm1+nko8+IRRKgu+eotzZ5ydj2uvFrFOisvaWC4h+xAgBOtqJOTGaogyGu1sMQD+RU6YB/eml5AQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c34ukiHC++T18ZoNu5RFsEiIGiCaG9vwzVDK97kjx1tne44RUf2xGOgOVt2W?=
 =?us-ascii?Q?PfQ0ex7MalwyTSOr1ByHTmKu6cglzlZV7W+CsZZ3Ua2Y+kOGU1r6iUplKVie?=
 =?us-ascii?Q?MzLU09CWJvYsCKkm/LRDgaxMT47jAejdPBb5OQ9gXTHZ2vwrJYuGvkafD+r7?=
 =?us-ascii?Q?EQbz3BNqS6bgS/k/olPW2+sYqP3KeDj3/EbOW7vdipmgpvIb4VHWRbpQfqHE?=
 =?us-ascii?Q?UlzwZS76sX5yxpKvGvUzGRFEz9X4JEzbVvJ0/RGSycjr6TQxZCXdQlzi8DGG?=
 =?us-ascii?Q?026/z+/sJoSghnP9aCM4NltAQgwr2+2UL47NAy2WB/1+7iDKJ1Kb7yPZRWm4?=
 =?us-ascii?Q?dZU2CfNzgsiNPrFaZ9LkMfOr6ja8o1iHn81/Lisa4XUQvTsYbofvG/YUPq5Y?=
 =?us-ascii?Q?Gzi7mmL1wEzqW5vP45YqBhhgfyzb7BRftB214YFmBbajAPiSdhsJBMcRG1cx?=
 =?us-ascii?Q?mwHBPbqY/6/s/zpj2pa/TjDmzmzuEDWiFMzVm/rF7mPjNICMsE3ZdQT/yZQt?=
 =?us-ascii?Q?lzBEdnd6iYIQAai1dQnVC3TmlBp43Tx7kxPY0O4z6AX1wQRezlsY3OXk5DZE?=
 =?us-ascii?Q?xB1LMxYleSx1JfaAYnx33eNDsXvdq3mWU1+XEUeEvUIr5gfGv8wcoZ0xXZOM?=
 =?us-ascii?Q?3ozcTQAYPKeemU8b+BeYheMbkaY3/ACcIx0xhnm6POijsHjsYoCu0wrRXbk9?=
 =?us-ascii?Q?rsJ344ZKb046jYeMG2EtB0g5nONpQ8Tt93d7T1nJPig4pSJGEetnYDVnI7wH?=
 =?us-ascii?Q?yiRk/WrYHAyxxjQanJGyztpt7bkgzgDXRKiZDKxiAy0r0eqoJQbMjXhwX/vM?=
 =?us-ascii?Q?GuVjmm0r/Lohg/NrdgpaVKvxzpRMW4lvNVYOkMzEpi9qQ3F+6iMHJ7Z8V+23?=
 =?us-ascii?Q?vd+mm8Et6J/ioU/IWvb/aqJmQphy6mP49bB5xD6GHoStR11DWHnlXqMfn/m/?=
 =?us-ascii?Q?3WoQXPqmh/lTNnt+XsyNSzFuE7AtXvsFzq92feK+enSc4atmLVa1s6aT1DIP?=
 =?us-ascii?Q?WOmeUXkjGvvQSmOtau1oFcH1HIsj1Kb0dxpd3GoNr22RDfrVD6+GDnSG3Tbc?=
 =?us-ascii?Q?ivzSRGlzBDfyllt5D92Xa7vY6Vy5Vo7i6z81HWU5KFPTYhcM+jjQvKDt0Yrb?=
 =?us-ascii?Q?KYheBRAuyCi1VhsmS0CxUMgIceVpCv0cd9pK0JyKyeCEQP3+ApFBjr8ZpIUe?=
 =?us-ascii?Q?YDPy3gnOzXnyjQVEflZ24EazaVB2zTDVoXu0T9x6Qslmh7DKRPq1RsmJXLSM?=
 =?us-ascii?Q?IkB6sulWHYVWWGdWJt2NG/QUUua1u4MWE7tkadOrF8zQ2TGsFnSEI90Q7Qy0?=
 =?us-ascii?Q?pZwC6ufN9et+imPMRnL8lCCdZvSmSfRZFCh7szP+zeF37tjqyg2Y7eFXnH1O?=
 =?us-ascii?Q?ARvBDX3VDa0drA+RErcqER9egw0nqwFqETTEpQMZSx3ViB4dd27Wg8/yRDWV?=
 =?us-ascii?Q?ANNzKcFL2RyEUMKH4IgOD8PCg1XzmWHQ6Jn5yAOiEQxqglq9xEfw99H3Qht5?=
 =?us-ascii?Q?Wk9YuOk36Kj8qkowGKekY7mJ1g6NENmwwuoAoBkJdLRTPLAYgH/WyMB+Qv96?=
 =?us-ascii?Q?EsXFyKM2nah7l4YyGomHSoQ8GOEfvznETz4fxemCp31S6vjrMcKDkJwD6Mx2?=
 =?us-ascii?Q?Oaw60edkV0o0+FTUmVlmHgvP+rm8mZJAUMT8DRqND3Iero95Y7pFO6N/wCBO?=
 =?us-ascii?Q?gwA8Y4B+gy9CBJIIbpjELYiTEnwqpLlMfFwVMvNxxDId8YHet4AMJsraHBMX?=
 =?us-ascii?Q?HCEPUElZIg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf61dff-0a62-4c35-493f-08de92dce4d0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 06:30:56.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29d6aXuuySnDPvHv03PaDJdjYWlq2SKg7sJG0zdH1oGWtkCICfxjNOuSsVMsONZ+hjppSY/gEyOID0FjZgb1LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18990-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 83A6F39D803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 12:09:23PM +0300, Tariq Toukan wrote:
> [...]
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> @@ -8,7 +8,7 @@
>  
>  struct mlx5e_xsk_param {
>  	u16 headroom;
> -	u16 chunk_size;
> +	u32 chunk_size;
>  	bool unaligned;

Sashiko says [1]:
"""
Is it possible that users will still fail to create XSK pools with 64K
chunk sizes because of an existing limit in mlx5e_xsk_is_pool_sane()?
[...]
"""
Yes, it is possible. XSK is not yet supported fo 64K pages. This series
adds 64K page support only for plain XDP.

[1] https://sashiko.dev/#/patchset/20260403090927.139042-1-tariqt%40nvidia.com?part=1 

Thanks,
Dragos

