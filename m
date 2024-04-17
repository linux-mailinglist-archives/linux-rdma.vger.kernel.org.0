Return-Path: <linux-rdma+bounces-1970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74198A85FE
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Apr 2024 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78575283827
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Apr 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5F7132807;
	Wed, 17 Apr 2024 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="P0C5yH/z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565E53801
	for <linux-rdma@vger.kernel.org>; Wed, 17 Apr 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364493; cv=fail; b=sPF5JXAh7EXOXwwmJe8UVlkdFRc09JuKR1jGXyDMyyyQxNNf3iEs7/sYYpZJQHc68X/Xrw/SXWlGZ4zMPR11SzFwUFbmAYo04N0zV58futh3FVXCgNj10/8o1NkH4zTqDIv8eazEOo/boPt425mdvxUoBhAhJ5YwR9cqeXNcjvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364493; c=relaxed/simple;
	bh=MnQbx3mkFTburbHdpJ3cQ139rvkoqTMb/5WccH5zC64=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=h08i3sG+uXYVRtPdZynNk9bF+8KJMdvpUmyQuQv35zkqyycibMGKJrBXy/nWIW2wMbCrRybIN6rFOvBO35Kcxk6Ij0ihJ126JBsK2wT+LDd0yRdIbeRgn3zuW++qtBDKPTTA3V65OdicKF3wJQM7+tfAIiE1jCUvtyTi4tb6QeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=P0C5yH/z; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by mx-outbound45-173.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Apr 2024 14:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Etm5HyFlKwdh3cxF+vhNib68vjaCu//EUQ9e3DfJjpKHaVcB+u1NFR/NgL/vERvKFVPDvouJjp2RUzlWejMeB6vcO8lHJSYSbDpYO1oanVNUcacwB8mxXhWV8VK1sMCIfDpkAj/ZrAzQmsSPqSoRK5xrjDn3GeWv7Y5n7fIlXP8GpFmbYz15mTad7tuuoXn5SEeAKQqeR51BCnt+2tQLqdPdtJ47hhmOQhOIf5Oqz5dA5yucWlSYew8mT7LgjajZGK0DOt8vHFHKSnC/UG+vub/lrgk/6ZhKlhuQfmelbkTvgYar7jlzfWGlu9VnHhwQQ8YbXZjUwUWEeq8ZNCpmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKecmHCjg38zOEruWDTH0H6zrQuWWUQnZKenlBcjfn8=;
 b=IJxw39Haod/pmBxzF1wiOxHzFItSfnR8HOqB+ShMBvTrB77LnY5yKJhLQi7TBasps8xaFie6rvGxKulJSdJHuPgjDX9BjW6vuYEOr3NEX7YRuM9bqZ0Je++xDIqBxCJ6bpqJLUTNiekbNjLTg0nkHAFXvq2yLH1nLuJOLZg07fOCWa2or7oeLtfPLKIgwciITDhS85meq49UCOXC/DisVK4RGk4gj4khe7FhxNQBWScABGIKylT1GsHVqjgN0/l1+VyhpiZrfrR4gOTvwaS+ZGhBkUmP91EtSE4dt/Ajx4WJWGl3fCGt7QCCBJA/48mzo664tGGP7VOAMWKpPGr/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKecmHCjg38zOEruWDTH0H6zrQuWWUQnZKenlBcjfn8=;
 b=P0C5yH/zqWsdXQYXzSPkBoogvcIBVWh3I5QmSW3Af8rDMa2v1o+6f66q7aUmIQ10B838dyTH+98+u6iJgPn/F5zf+77LgV/HZUwDcYswSLXD4DYqpyP7/WjUxit4dxpg9vhl9ql+PRn5OfOA+rbSdRkxq9/kBTSeLe85+7xOwb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SA1PR19MB5570.namprd19.prod.outlook.com (2603:10b6:806:236::11)
 by SN4PR19MB5406.namprd19.prod.outlook.com (2603:10b6:806:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 13:01:26 +0000
Received: from SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2]) by SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2%7]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 13:01:25 +0000
Date: Wed, 17 Apr 2024 15:01:12 +0200
From: Etienne AUJAMES <eaujames@ddn.com>
To: jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com, shefty@nvidia.com
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"Gael.DELBARY@cea.fr" <Gael.DELBARY@cea.fr>,
	"guillaume.courrier@cea.fr" <guillaume.courrier@cea.fr>,
	Serguei Smirnov <ssmirnov@whamcloud.com>,
	Cyril Bordage <cbordage@whamcloud.com>
Subject: [PATCH rdma-next v2] IB/cma: Define option to set max CM retries
Message-ID: <Zh_IGG3chXtjK3Nu@eaujamesDDN>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO2P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::31) To SA1PR19MB5570.namprd19.prod.outlook.com
 (2603:10b6:806:236::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR19MB5570:EE_|SN4PR19MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8f66ce-f7ce-4117-ee6b-08dc5ede7d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfZw3P4c3U4D03N/XH/mOwdH83You7u5vxR49OUvQTiM/A0LvGo/8OTX73a9?=
 =?us-ascii?Q?MlmolJ0nyrggnyDRzZ/4xjUfKzaHtHWkUFbnIa4gmIMUhjOw77Rnvm6miLq9?=
 =?us-ascii?Q?yq01wvu/3h409gwH4ZnGmNnFOAwzUqa/NiS90EJ122eXGrNIqZCh4m+XPWmq?=
 =?us-ascii?Q?KQTsQeJwRiC8xDGhAYQs57gA6wzaYtSbQfdC3OHPa26nARY1o5bOIEx3wPMw?=
 =?us-ascii?Q?D6idtAwIcMXCgH5yEL9lFRVDaec/QgiKQAZfmtSAyaW7Yd1Cq06msCpVHG++?=
 =?us-ascii?Q?4NvALXbPlGdYH4b1lEmCjstSQQSrijya8IUqfvBkh8BohJbItMbfrAc2XQ2W?=
 =?us-ascii?Q?56Ge6xg8Dx2vrim6wgtgWwjRcEm5lHSEl/CkYzVIC5755/M4/NzUDwVyvGP/?=
 =?us-ascii?Q?oSBiOrasj5WKV0jp2WiB5GVUizIHLCh8mdL0vvVfncgGDa9oEc24rf9+mYBB?=
 =?us-ascii?Q?wQ7Z/yAxeaGUuUhT2adkcOwY62g02+5iRsZJenN18Axo4UTU8/VgCzNVZ+oy?=
 =?us-ascii?Q?J+NldK/42ABje7eR9kjSr26Ca2ACDxtCJwPs8C/N+v0wuU3MG2Gjhk5IekSC?=
 =?us-ascii?Q?6Tt8jngkJl7/vOr0tHVQS+DSP14/IZLoudXYAvFfXyjt4ggW8Dzk1hoqToMt?=
 =?us-ascii?Q?7seV1oNNDvoI9/X98nIKQUWQVp/ZrUkZwzhQhM0rxAFmXLb2/bNmlOQthV3b?=
 =?us-ascii?Q?73/hrDwzQlFkrW2gK99mvoqd5OrttkE86LtRxeYJZuBYcThhkYHh6EJwT6xC?=
 =?us-ascii?Q?2h8Itf31p1kABPKflzpeUdcTC9iC4swNio82OkSMgNnorAoA4/hpnaF2qfl4?=
 =?us-ascii?Q?wWcIzkaxrTfySdviCpQTo9OkD5WXwPBN2VV1fiP+4yECEVEd/WVMn9t6/+3B?=
 =?us-ascii?Q?qNbcUJ/Wg6mpCorxIAIicUg2nQOe8Kgn69HSA4ZLXcF/a5zTRNgLGrPkykMY?=
 =?us-ascii?Q?f0SFRoaSA6xOD+1PwTxLMgbuGKkX+yjPvzDmdORNn28iWchJeedsm+uEujrL?=
 =?us-ascii?Q?8peOJLcQ8vI2GqiIjAMVDGQzZo7gJIEzatmQVYZXZAffgUe4aoYa3J8qcloL?=
 =?us-ascii?Q?a3gkDm5A+cZ9WlCKyiMvKkSuCNgB+EYVE7WRv52xRKMlxLf+xH+WQAozFd3+?=
 =?us-ascii?Q?84zx1xrULcEuHZnfb9G4FnalEB2Mrhs5KyT0c+FcYN15DSkEgwO+NWMAJVJq?=
 =?us-ascii?Q?8qPaLWWY6VxnfI5F+xibZsMLXQjhn4qcOcPV2+pciQxwLhlqwIDFNSKu/Zdk?=
 =?us-ascii?Q?2Qfw4f1jxSyb04Zwkqy8WxQVTjggCGzghNGrYeab4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5570.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0LaSbE0O0EXYAOssm3MgfejPCE4EjNkZWT8Vc4FxzbdRp67HuoqK7RJaXK+C?=
 =?us-ascii?Q?hCVfzVNoQbnFnCYo8JGRPoNO3X27FiL2Nzc+zYRHV47lI++m+Az8PsCMGHGZ?=
 =?us-ascii?Q?EbGB/Id5UG+H3Er7cBUiQ/1MeL29j0bIBqbR+rPMRcSCK7hEomZ7TE4SMfXz?=
 =?us-ascii?Q?SoUSRmf3Uk2oCORZFy3gPtd5GWnVbir8hDqY3AW+PxYrdcEmH5GmyRWi4LXZ?=
 =?us-ascii?Q?gREtNSBU4X9RJcDCeSOWYtvDPoJTOI6d7Xkvl8XeU011qi/9AUMsjjxekRjq?=
 =?us-ascii?Q?LOp7RILH2+WrtO2aulhjJRgsq9pM6Q4LMI/I9GFVSr6UeuuDoZ9P0e8yRgV9?=
 =?us-ascii?Q?2ji2m5x74a+dnxVg0s6qYNX9dgi5vNMr5KpouaeviJjr6EdTa/uH1TmXGjtd?=
 =?us-ascii?Q?ceR4m8D+pSbpAmNS8Hn61DENbiA9pqLionhqS9cpEXieK+i/dKRz7mvcjPzL?=
 =?us-ascii?Q?1RF/LJcmHRKk7QVIvz/nNWzQ9wYHVYNtp9twqg2Il01MF1lPkbFBi4RqnqKt?=
 =?us-ascii?Q?H2wsPMKsHlVyRUpjjLdK9gx2jwxXRIoHIriekxmQnHnEwWa4kyYd83IYq7Og?=
 =?us-ascii?Q?72Q94coKyCn2NWBDednTeMVgZW57XhNQZueTqM7D9MEpqXhmKyLiWNW1Q6jS?=
 =?us-ascii?Q?ubBDSTXhiLBENLmLvgTjSB9s0zGANuMqP7jeNdfzkkMbIo7yi2XkZXrJKf2m?=
 =?us-ascii?Q?13WxzPPSHtihBm+d61eCnxOYkfA6jS3oPKPOTzOVpLYqfcnRGqmoujmNZx2I?=
 =?us-ascii?Q?QG+hkpo3DoPzbZR/eFhFMdpUvH9YOoS75dUCZ3ZLzAXNyGVIKHXTXTGlqOhy?=
 =?us-ascii?Q?Yw9EdN+kw/XgylPeDwYhidfUSuhIUdWe8ukf6YD573+xNY2oYuKQFoTe805d?=
 =?us-ascii?Q?66c5xrtDe/iURfw9FXZTaM6+Db+khNUr7CpZZeGMXG0N4xlT3P9zSQlWCf+f?=
 =?us-ascii?Q?jH3Oa0/Lmy8fiSxyQK8ymNdpqto0tuGL4DDhjGUUqkCmMV3MiMaUAhrLibHL?=
 =?us-ascii?Q?mnquDNfhdB+JVfuEp+vEcD5B0G/iYpk3r4w/MppuoTKjsd3EmmM1CVqht1FC?=
 =?us-ascii?Q?MliauANuTdvc/j6pgWgC1Z/oZHyRT6lxgWeOUU1tmB4+yZTeFLlp++mGa8UN?=
 =?us-ascii?Q?rT+nopgXFazOWeKqWSngWIjdbW79LZoRBZDnQEIbwGiwg+qePrcDPHK1YPlR?=
 =?us-ascii?Q?nc1gsSgRHk3pf1vMD4wYXWI3LsDOhnD5G/TSWNyNAiWweeSdcVYG/fJZ0WMF?=
 =?us-ascii?Q?SX1KtFUEXyaugl7U/9xfPLvDZMh4zNTn/9MoaT3wPbw4SiTjohq6JC+AdzTO?=
 =?us-ascii?Q?d28UHc8Z9hn9Fo5jTeOrOlwwKW3hYvqTo2kuMLIts2Y2+16kkmOiwyFKYHmT?=
 =?us-ascii?Q?LVWkxUGSR2/qR/EnBh4FpqhImoeYumhBq5T5jcK5AUC8AmGgt8IJgmqK1Lc0?=
 =?us-ascii?Q?KXhN0GYAk3BNNCP+GmC8V09FCmNlufreQWkcTN6eiQA/e0YjKoBweq002C7w?=
 =?us-ascii?Q?6ByTCYYUibH0SjJXIffKSJ1CwpKmGMg14W01ID5hvtUEZtGpmxhFbyJwL7ft?=
 =?us-ascii?Q?CN1oa2ZZRw0EEECH6YaoY3DoGuF/cGq2xOD49y41N1BfaSWeEx+MMFuRyrTI?=
 =?us-ascii?Q?Y8sxgi2eHMmORurHyVQwAhBDXarjr04dhym4rdhflMDS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dNxyALj/d9QN7PXKT2pWh059HxwnJaJFCt/VPkfS5yZEGDhUbsCjoZ+TeFnvbst4e/jHpfOqBuZ/nuAhk24Cbk8gGbWq/ubofentYtxQ4A4SyLa0EfYnzo89FHp6qE1Q+xD8ON94mUoF/TMVZGeW6/o3PNXrhK6fi58rSfPrBWxCOXxGoBf802Ctxmy+4Gvr6H/f7EYlWlyukrLiUS+dsKEBswp8p5KhhNzZgcOCm0vdTGkOOcloavjHujxprg5yxmwfhSPRjY6g24IB7lXiXU8qgwZ5n4UomzlH2Ag1sf/naFxeFYeuRrXdpJq7rgGlIBRxO0M4Ntw25nYUpDjshN04/jG0Dbgad/ZPt9S09LqYD/YynoqeX7+jF77+pqWuEv6qrfdPiCcTDZ/uysQHoHBBZoxfmknSJRSYuIf3fll+QEcuobRJgbLTR7/GsFOTAlQ+SGAqk6/BFKsguVYAqxQUN3qHmQ8EllZmgn176s9AIp285ZIU8np2qX7cppShuXlz1xV9VrJa6OrBw80XTUWitJHPeTHYx8NwOEJA9iET05DzWc2TWHqw5GiwodlWef7d+apmAzwg9LWGBpLpWkafJ51nXl2XOB2W122cmjywrgTqPtDSciqbWo7d1QOIhk8xqemw/0tjtmSxYPVhww==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8f66ce-f7ce-4117-ee6b-08dc5ede7d31
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5570.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 13:01:25.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt4tMypFyjmocYdZ0AE6zjfXdSALvKtglB6GU3ZIVc3WcOZaVwcN1HoD8cGM2nh97OhJ3BedR3KfmQtkgMVvXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR19MB5406
X-OriginatorOrg: ddn.com
X-BESS-ID: 1713364489-111693-12718-3825-1
X-BESS-VER: 2019.1_20240412.2127
X-BESS-Apparent-Source-IP: 104.47.56.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYWxgZAVgZQ0CjR0tg4JS3VwC
	wxKcnMxNwgMdXC0MQ40dLS1Nws0SBVqTYWAGBwVIFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255628 [from 
	cloudscan14-34.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

Define new options in 'rdma_set_option' to override default CM retries
("Max CM retries").

This option can be useful for RoCE networks (no SM) to decrease the
overall connection timeout with an unreachable node.

With a default of 15 retries, the CM can take several minutes to
return an UNREACHABLE event.

With Infiniband, the SM returns an empty path record for an
unreachable node (error returned in rdma_resolve_route()). So, the
application will not send the connection requests.

Signed-off-by: Etienne AUJAMES <eaujames@ddn.com>
---
 drivers/infiniband/core/cma.c      | 40 +++++++++++++++++++++++++++---
 drivers/infiniband/core/cma_priv.h |  2 ++
 drivers/infiniband/core/ucma.c     |  7 ++++++
 include/rdma/rdma_cm.h             |  3 +++
 include/uapi/rdma/rdma_user_cm.h   |  3 ++-
 5 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1e2cd7c8716e..b6a73c7307ea 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1002,6 +1002,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
 	id_priv->tos_set = false;
 	id_priv->timeout_set = false;
 	id_priv->min_rnr_timer_set = false;
+	id_priv->max_cm_retries = false;
 	id_priv->gid_type = IB_GID_TYPE_IB;
 	spin_lock_init(&id_priv->lock);
 	mutex_init(&id_priv->qp_mutex);
@@ -2845,6 +2846,38 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
 }
 EXPORT_SYMBOL(rdma_set_min_rnr_timer);
 
+/**
+ * rdma_set_cm_retries() - Configure CM retries to establish an active
+ *                         connection.
+ * @id: Connection identifier to connect.
+ * @max_cm_retries: 4-bit value defined as "Max CM Retries" REQ field
+ *		    (Table 99 "REQ Message Contents" in the IBTA specification).
+ *
+ * This function should be called before rdma_connect() on active side.
+ * The value will determine the maximum number of times the CM should
+ * resend a connection request or reply (REQ/REP) before giving up (UNREACHABLE
+ * event).
+ *
+ * Return: 0 for success
+ */
+int rdma_set_cm_retries(struct rdma_cm_id *id, u8 max_cm_retries)
+{
+	struct rdma_id_private *id_priv;
+
+	/* It is a 4-bit value */
+	if (max_cm_retries & 0xf0)
+		return -EINVAL;
+
+	id_priv = container_of(id, struct rdma_id_private, id);
+	mutex_lock(&id_priv->qp_mutex);
+	id_priv->max_cm_retries = max_cm_retries;
+	id_priv->max_cm_retries_set = true;
+	mutex_unlock(&id_priv->qp_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(rdma_set_cm_retries);
+
 static int route_set_path_rec_inbound(struct cma_work *work,
 				      struct sa_path_rec *path_rec)
 {
@@ -4295,8 +4328,8 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
 	req.path = id_priv->id.route.path_rec;
 	req.sgid_attr = id_priv->id.route.addr.dev_addr.sgid_attr;
 	req.service_id = rdma_get_service_id(&id_priv->id, cma_dst_addr(id_priv));
-	req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
-	req.max_cm_retries = CMA_MAX_CM_RETRIES;
+	req.max_cm_retries = id_priv->max_cm_retries_set ?
+		id_priv->max_cm_retries : CMA_MAX_CM_RETRIES;
 
 	trace_cm_send_sidr_req(id_priv);
 	ret = ib_send_cm_sidr_req(id_priv->cm_id.ib, &req);
@@ -4370,7 +4403,8 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	req.rnr_retry_count = min_t(u8, 7, conn_param->rnr_retry_count);
 	req.remote_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
 	req.local_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
-	req.max_cm_retries = CMA_MAX_CM_RETRIES;
+	req.max_cm_retries = id_priv->max_cm_retries_set ?
+		id_priv->max_cm_retries : CMA_MAX_CM_RETRIES;
 	req.srq = id_priv->srq ? 1 : 0;
 	req.ece.vendor_id = id_priv->ece.vendor_id;
 	req.ece.attr_mod = id_priv->ece.attr_mod;
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index b7354c94cf1b..4c41e5d7e848 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -95,10 +95,12 @@ struct rdma_id_private {
 	u8			tos_set:1;
 	u8                      timeout_set:1;
 	u8			min_rnr_timer_set:1;
+	u8			max_cm_retries_set:1;
 	u8			reuseaddr;
 	u8			afonly;
 	u8			timeout;
 	u8			min_rnr_timer;
+	u8			max_cm_retries;
 	u8 used_resolve_ip;
 	enum ib_gid_type	gid_type;
 
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 5f5ad8faf86e..27c165de7eff 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1284,6 +1284,13 @@ static int ucma_set_option_id(struct ucma_context *ctx, int optname,
 		}
 		ret = rdma_set_ack_timeout(ctx->cm_id, *((u8 *)optval));
 		break;
+	case RDMA_OPTION_ID_CM_RETRIES:
+		if (optlen != sizeof(u8)) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = rdma_set_cm_retries(ctx->cm_id, *((u8 *)optval));
+		break;
 	default:
 		ret = -ENOSYS;
 	}
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 8a8ab2f793ab..1d7404e2d81e 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -344,6 +344,9 @@ int rdma_set_afonly(struct rdma_cm_id *id, int afonly);
 int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout);
 
 int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer);
+
+int rdma_set_cm_retries(struct rdma_cm_id *id, u8 max_cm_retries);
+
  /**
  * rdma_get_service_id - Return the IB service ID for a specified address.
  * @id: Communication identifier associated with the address.
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index 7cea03581f79..f00eb05006b0 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -313,7 +313,8 @@ enum {
 	RDMA_OPTION_ID_TOS	 = 0,
 	RDMA_OPTION_ID_REUSEADDR = 1,
 	RDMA_OPTION_ID_AFONLY	 = 2,
-	RDMA_OPTION_ID_ACK_TIMEOUT = 3
+	RDMA_OPTION_ID_ACK_TIMEOUT = 3,
+	RDMA_OPTION_ID_CM_RETRIES = 4,
 };
 
 enum {
-- 
2.39.3


