Return-Path: <linux-rdma+bounces-7750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA50BA34D4A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288153A7D27
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C71324167C;
	Thu, 13 Feb 2025 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wn4dMCsz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92918F2FC
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470368; cv=fail; b=lf2a59FRfnuFshDAsUlBbrMhPcdl7EbpmndwmSI+OmWjZrXupJ/5wBPEBTxtVpgpMuP7yxLXdknNVRZ35xnvtett/AbH0WPx0ed4b9Km3BLf3nX7sDts0UhgBXde4xu9UwdHcJViUu7M2RCaIYQCvCqUN/oUhKcvzvL6u0RBuTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470368; c=relaxed/simple;
	bh=Gt/6h3fy6zdVM3Cw/nyIck1sz/QkhHvwPARQUvmAJog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fEwFKaysn8crTR2Pm1qwbrjSh4v4NYQCzQGxYpn6sNYSyvwdHcPMtKevhJyatMpFf4BTwxwQiefOn52A6hPPPXhuaCpPMG1+sVDLNhK5dI3fLNR5xITMQtE67sxikd3uVKhj16a3+ZonNLwLVQ5e66ZJEMTXYQrQUPs4Pmn/5dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wn4dMCsz; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEZ17u/qqLWCrfEpGWoWsodFXItMSHdEPHSQvghTAE6ciS2P2VQ9yv/OtSdFs819XYB5I2oyczotYC7hkXEvmoKp1rIBdRaMrTCw7JX/LsMVs5sJGdUDAWHpOVETvRRR+pqzpPB2uf58kvsilZ8bXd0lR6FaAKr9yS0ElFydWJ4g9pUbkhhLSY/V8oYbb6rSBqddVwr7ALhXMkZnbYZS/rOVUDYhUyJceOF6UvYjbl9bII1GQtmL2JzcCjPDsFk6YhgXVKYj7XAsk8dPnvRznPkQrYzxZajYZMex58yDlCs3jqkboiNDscuEdGoOZvF+UlKaVytjvsETcTdk+mE0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qVCHIppsPQoGCZ8ce6NZ6vN/yE04jS1BchRjGF6EAk=;
 b=xcv9jrhgxYesb9aSnISlYFZCYNg/3OD1T3zNM8RxjJi6VBejJ/C0BR7mP/R8f7/4/HejyKDwLJ1pmds5EVrj0ntOpfzQXSKW5zqseye97YfJzmEP/+supux3R66HCdCgFKmykqQ8Y/kt/6mztC/7x9ieeiLXg1N1nHY9tQrj0Ipy5oOgt6wDEXI58PutVhvwH3cmVmsKf1aBHCGm3NCFPLTG5KbdhmxH0TWNnEo9Tox4GGqeMls/6hw1GBFX6tNSN4xMEEsOvZ67a/qSJBisg3VncWYa2j95ApMhHtpfkCro4M694bW/BI+EmaFCONO3lya7aQMg7HfgRMcmKOjbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qVCHIppsPQoGCZ8ce6NZ6vN/yE04jS1BchRjGF6EAk=;
 b=Wn4dMCszXdkPLxMUBF3LJRz2yampN+lXwke7dnUYpHnqIyhDa9WsoCGukm3akphJmuSeHOdtaLhe0GI3Ep2WqWJqfhHZ2JRYfcJ2DL3ssiub4bw4IQRrR+NlLogTY0h6RALNKbtirf8utJRsiFOfXCLCtHu1QtANtXeFkBouY/POWmFZM0/T6gYQYmd7cbGaWo+98p70JnJnJsYpRvNUFfknTW2KM3bqLEHqViimCgf/bRvNBUuzgf4lICLtj5i4DulvojEo+tZGsmjKVglVM+8zE0zfFZG2Rj3LBcEuWKGFqfbqf3W7WVy+RUgvgrFLNBj+DDBma8lBFiqyOtaYrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 18:12:44 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:12:43 +0000
Date: Thu, 13 Feb 2025 14:12:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Margolin, Michael" <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250213181242.GF3885104@nvidia.com>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal>
 <20250213140421.GZ3754072@nvidia.com>
 <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
 <20250213144219.GB3754072@nvidia.com>
 <20250213173510.GO17863@unreal>
 <20250213174043.GG3754072@nvidia.com>
 <20250213175517.GP17863@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213175517.GP17863@unreal>
X-ClientProxiedBy: BLAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:36e::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 11520eec-a728-46cb-c94a-08dd4c5a02f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bp5dqr1px297Oq8n/twURUyQU0qaiH8X3jaH6YwzDlvwTtg1FJMIgcgCB1sb?=
 =?us-ascii?Q?/68Nd2JzWfZ7eaGGEQmdYvzmaT0IK19vpVxqFVILT7158e/1MgGutXHgokaS?=
 =?us-ascii?Q?kAzKegzuTliXO4VmENWZh3/s7O2iSUKcz2lPdJRXl5qriJMOxUk2iTv8v1jA?=
 =?us-ascii?Q?q5tmWm9qEWnYcZRa8RsfRJ6m93VBYJ/vPbibopgBj27xn/SUoSjPtWRSjl1k?=
 =?us-ascii?Q?Frc44klYzVPEVMTgy+RTcDXX8F4oAFZyuN4Yhk26dQsbOxgThQmpzcipmuPe?=
 =?us-ascii?Q?QtyqODwX9vTQ+A3jAXt0QMHpN4DUvZxn5jVcbVRAyU555wutMGZKkz8v+e31?=
 =?us-ascii?Q?8lIXY6L/gXLhnLQYqnh0eEwJpVle8T58ibS02fme45/TZ6L4d2BGcnVt6qPc?=
 =?us-ascii?Q?eiDOizFnyfBmV7Cw9oRxGEsJnTQWvKOPOffjeAc3OkzonerCoVXOO2EhGU4E?=
 =?us-ascii?Q?A9tsuqhvut2sB98GXpN/6b9arhZ3p2neai6AYxR4qaDuBq2AOr3ROdHYWA8u?=
 =?us-ascii?Q?YwYzkKmilxME/C7HLv2F0ZsV5vOz1ITW5TVsh0s2oVS2u7UM4IORo0xByxyf?=
 =?us-ascii?Q?fXZFFjXDiL+K5Zm7FljETUXMBWpN4dG9aEkIUvteqU4KwOT3crtPV7mo4h9b?=
 =?us-ascii?Q?9KfgA/8Hx4BPj8N72pHlHVZ+/cqT7YTp1Vhylc0TmaA1nNkiGt8Q9oMQfOmz?=
 =?us-ascii?Q?AansQlLnHuu9hea4Y2CpHAt4U7fG8t2lgHewRTegHj1ySnwa+q/loCU3ro+d?=
 =?us-ascii?Q?nHOAyLJHWpQlwxaPR/gSDeXVJX3ChjA32OL4qWHWJTfqJkipwZADOFCOi6Ay?=
 =?us-ascii?Q?P4njN+Gnl1HP8hFmxB+FbHMItVW5lc0bCNg2IZQ98W9UzoIEf52EagOisHut?=
 =?us-ascii?Q?SDoXGP2HSfOS+Nuoo/3YhNmSiS9en3cW0oyNBzwypAnrQfJiqbQ/LDFnmjSl?=
 =?us-ascii?Q?I8bFQQM2TaZdk8a3JamlmabMsWziSCnqUhCJm98+MXBl7VIsKqDbVS1E0FWD?=
 =?us-ascii?Q?HNEFd+IZiYPo3p7Qvu7CT/M/2lSq/6yu/y3gl4yO8sWcdCQNmaxg3Z+CXqel?=
 =?us-ascii?Q?YAeNSV5sXA6A/cQyx/+aGDFM0HOvtxCMuWBWx3GNicvM6/+JcmknJyHrGzWi?=
 =?us-ascii?Q?OUybuEVWXfkiLELibC3lk+VaOPsqpAhtIScuFcW4ynvxFuxQjlFVKZO5gns1?=
 =?us-ascii?Q?x2+9fc07TmWREjOp06u6KOVF0HXCe9Q7nGzRCGUxlELxUReszreFKyRKjOVL?=
 =?us-ascii?Q?Y0hENAo+PXrsnChAqzMhg95pZv5sL/FQu8wz3gbA769n5Q971NdzqnKDH/yC?=
 =?us-ascii?Q?LHbvycx5tP98h/VABZjykhwUF6hMds8tdrviVmvqjPapZ0iAYEq5sinuZtEc?=
 =?us-ascii?Q?i18h1dFYUVaQohj4YxYh65NW443T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYL92pkbguPKbom6CgM4cJqWMlElTgTlOaAWbfVjAN9e6K2DV+HSbC5nsAMX?=
 =?us-ascii?Q?6UyQKp74c2IfbaNZZ3jrtcoSQYJ5yfx8czO3RKzKpl1ZTdF+NmeSiPaR4N/8?=
 =?us-ascii?Q?XF7WGv5pdi9RHuRrts5GL8vDvhH5ZCxJD9yNmgS7/BOPR6Ztqnsu13ijD6zK?=
 =?us-ascii?Q?Kt++C4QuFIVxAg9LGM4S5jGHeXkxLgm/q1LKHLihm5xvTziLAiDTowrpLgF3?=
 =?us-ascii?Q?l1I5vBXWTXGAhsZ829BBeKfWMDjxAM5I63YRj05kdiyqEKGo0PKWHsaH+h0b?=
 =?us-ascii?Q?iGgpimP1aOEqOVxiEhKuJGLTnDpRdyuPUUPTwFQbOSwFcV/3Ersv/Hjw9Jza?=
 =?us-ascii?Q?KM/WlrtMAeD+INq9FNHOCa807zEGbIwRteIwZGfjgoNk/vCeOsoPj7uewF6u?=
 =?us-ascii?Q?LmEGAV7ZuqXvCbxdo8BIO+etowTOO+t9FCBujn4xQV6thb+3NwHNqbCMCJSV?=
 =?us-ascii?Q?tgYhFKu43RvNfwOpsmPBS7cQOlFTNlP3udYsbrdIb1CHgRK/ovqn8HSlyn2d?=
 =?us-ascii?Q?cXzbsM1SsJhRVizRCm0k1sVjuAnWbHLph/e0nWMh1z8ZpNeFmQ0MD/V4COHH?=
 =?us-ascii?Q?9AzHDms28fnuGP2wDqT7qHJBiws6Wl8KXbrkWESoW+uEv5Tlg4L5NABNMmI6?=
 =?us-ascii?Q?qexh3tqmSbfDIW6woEHib0mvWCVB810ASm0D0QF22YYpBuOa5ESNvJoppSBy?=
 =?us-ascii?Q?scaVcB/JxE4V5ONXLKWYj1AvXXuaVybJ9rnT60+vOW1974SgH410N57v+N2X?=
 =?us-ascii?Q?rjLiyQHfjbRZlKiVQVuD3PeFE/Xu+36Ocp1C7I2UpTunQzRRrdNsQxElYTv8?=
 =?us-ascii?Q?/cZCzdoTDijjCOwXCxhMYDVUKcvMw87+emjitRp/2uZWMsdIeVnztpYQpQk4?=
 =?us-ascii?Q?gIrC3O//SrqogM1JsG+X2KXyToB91Z9YUBpIPH8h156ZjFJeMcB8jwpAkrTq?=
 =?us-ascii?Q?nDz0ja+/bqoJGv+X3y9qfTT2BA7hLx37pn7L2zMXWHEoMRKYDNzbsEZd6STp?=
 =?us-ascii?Q?GYZqbTDVkbGwxTl9sCVHRfhuZNau3zkiHuD2jBnoziJfzDaOHtuyhzzWm25x?=
 =?us-ascii?Q?1MOpZOAkNnMIRYCSKWAF8fWV9tZ6/4BTvcJvi06yj6Yl/NnuREni98GzE2JM?=
 =?us-ascii?Q?xGuZV2OUg6q1oBkYEFtVfja1a/RMiTcE+45MANSxhVKP+GChLNLbj//qyHOX?=
 =?us-ascii?Q?tH3KEyZWytftVaux2KTqu8ntSHiVnR5tEcdJ/3/XbWt/yzgQVpUwOp1uD0GV?=
 =?us-ascii?Q?tAdi73VTaKJBLRci8aCKoj0xpFNmcdUrWJmV8oND4MVZXJScQMoLWJ8fYfN/?=
 =?us-ascii?Q?xGIV3ndBQDa5oe3OAl4lR/a8ABjuvenwX5gKZWqy7BUajBPsOOqgJQ1yBzOJ?=
 =?us-ascii?Q?Fu1cQuqBEKuT03sPxd/Y8GGdcvguag/U1drekI0VU5FMNB+fsH0nwNlMu7Co?=
 =?us-ascii?Q?/s27yiMNPTQkzQTWCBLb0JeA/UjsXSTYi1srR36qR2oYmel+zG4el0AULtXF?=
 =?us-ascii?Q?zo2geUIFIN5bcyUZPkK/t/WlKiDfy3IS7URAClwHhlb1A6oTX0trfUH/v9A8?=
 =?us-ascii?Q?ERZfxBP0We2si8NaSmWqX29lHrxhpmxbjHNeMMaC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11520eec-a728-46cb-c94a-08dd4c5a02f2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:12:43.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: si1D3YRm1HlDjzRdnO0xRTGu1GOFqw86aXrC6jIyQBdaz50MdDCaowxUYwRKZfuG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799

On Thu, Feb 13, 2025 at 07:55:17PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 13, 2025 at 01:40:43PM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 13, 2025 at 07:35:10PM +0200, Leon Romanovsky wrote:
> >  
> > > Initially curr_base is 0xFF.....FF and curr_len is 0.
> > 
> > curr base can't be so unaligned can it?
> 
> It is only for first iteration where it is compared with
> sg_dma_address(), immediately after that it is overwritten.

But this is all working with inherently page aligned stuff, cur_base +
len1 + len2 + len3 + len_n should be page aligned for interior segments..

> > > So if this "if ..." is skipped (not possible but static checkers don't know),
> > > we will advance curr_len and curr_base + curr_len will overflow.
> > > 
> > > I don't want to take original patch.
> > 
> > Subtracting is no better, it will just randomly fail for low dma addrs
> > instead of high.
> 
> Aren't sg_dma_address placed in increasing order?

Not necessarily, dma direct produces something random

> If not, whole if loop is not correct.

The point is to detect cases where they happen to be in order because
they were split up due to the 32 bit limit in the sgl.

Jason

