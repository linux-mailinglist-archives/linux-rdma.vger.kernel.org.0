Return-Path: <linux-rdma+bounces-12913-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB1AB349D4
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF72A36FA
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D72A3090DE;
	Mon, 25 Aug 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HiXtUMzp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA83307ACF
	for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145458; cv=fail; b=Kmjz8qIiURvtTQ+Cv5SHvFfmSfxHBLd5uMRiaLdbbvUH8WgXeIJf6ZoJvurZ3Gq6MwpacvAzyg8fan2bxS6mWfAnHBqJR8hHF0JbGH2nf0zRZPLsWqX4C9VRtt77f/UQ7zGapFlXdIzYxQsb0Wv2nuOS9RmWsPy/3clpU6gnakA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145458; c=relaxed/simple;
	bh=dIdo0EsbcPazsuKEnvw32tzihfftj6wwg2DQHfBqGWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BBPvMhLKlqNJkdblrxRFU6G1bzl8FTZfIfNOEJt1Zz5ySCB5zuHfhtO7G9VJZGQxY7EFuMUW4Zf4xoK2itIx8iIRqpSK2OtcqfXzHDD6NL/9BJmYgEUIznT1KXKaJhcr75ByM2W8gj18q5D9byzAKOporplF1DMl6kfRleMV4p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HiXtUMzp; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yr4ZCLGem1fKTNbrc26Yu5SRB2QyhvRW3pv6hx0hvy07qs5ND+qdPzbkffBC1LGniOikNLNhANez5jKyI3tojGbLPL8tzVYYyQ3UwBpVjpGVdSgSpofQbs8bIoIw5iSDWJBXFyUmJAN3LDDEXRSqrCgNu9beftCxAwN9BJLln7IkBhXPuDtgPUgE8DQMqBktKxMJsBMFDm396WXCUPoIkV06qTY/SOq/8FLX2hGtIIbMvljLKQW6bIrk7HfkTXa2Z3pARa6O9qj74vavRYoLY1i2hpPyB9UFWJo1yZuhsmSvvz0pZJ9N+AWx4ZYriqPcRAbeCEPBZ1Jn2nnyTsY4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnDNsWMD9k4Uwfk7YvDhvz9RJ5jorOOf5krMGLHJTZY=;
 b=u0gUH8WNBEI3vYjZ4jlC3Rl0r9vISGHv38SQFCuSQbY9cnZMZPwrZ7CPkn+IoAOH7zR5FJM5vWX6kaCy/BMwQ5B0HEcFvF7DyM79iwaQft/xEm5GZzlwfOYSBLvOrsQr0juBBhBl5thltDBA28nVQYwOO8KkgNmGicNNC76ppDNH3KwRU/yXyC5AqSi2AGguZiDnNdtFblSHYIKHRQx/3+ILtNFHC1XkMsLOSPdKka9qxe9JgiU8V16kEh0Vr32gIAhLhCgtO2rH1/IrTfdjhvpLELM3llR+GbJ6FMJ56SwIQhAOmQuWEiL05ZX47QX3OtwA8IAu7m6E50vdUO6J2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnDNsWMD9k4Uwfk7YvDhvz9RJ5jorOOf5krMGLHJTZY=;
 b=HiXtUMzpnT3RBy7kEN5/PcExCkZVp8IChLvTPAtEcLZhD1X9QRfLedgSBIf8SDDJwxG7Exhf5pO3GmFuZ6qUf/jg8mbOD1bcf2OSU7ia7WFYGOZua40ISv2ihCTMsPnWw2z8sCMGP1nK8XIXTz77vYIcdn7IuRAzYGmKnUTerhppuGoTxSL+371rjP5XMmGLP+hU6zlpy1Dn/JBcgfaTtFiik0Gd2uJP5p6cbAc91ZsdJKx4hdIbpjBvbADGI38KRBIZjTiwZweuziD2i/u4MGqe2DXzHfnm2iCcQQjUsv919jmPZEiouUrzpUcDHl5kzJ6kRQbkWW8Ncav+6QOJDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 25 Aug
 2025 18:10:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 18:10:54 +0000
Date: Mon, 25 Aug 2025 15:10:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	yanjun.zhu@linux.dev, philipp.reisner@linbit.com
Subject: Re: [PATCH for-rc v1] RDMA/rxe: Avoid CQ polling hang triggered by
 CQ resize
Message-ID: <20250825181053.GA2085854@nvidia.com>
References: <20250817123752.153735-1-dskmtsd@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817123752.153735-1-dskmtsd@gmail.com>
X-ClientProxiedBy: MN2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:236::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6fa9b0-0e1d-4ed5-fd93-08dde402bb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CvIzx+rLlmj4Ajx/CY98AwMhBPufa27pSz/zcwicKG6yaugUoHKynU+dYwBK?=
 =?us-ascii?Q?B62QyqpkjNpLwHdzez2xGpX3MIaCbb7Lpforr2rNL3oAU4Uy7epgM+SQUg0j?=
 =?us-ascii?Q?rBj68r2RXapQ+z1q7ssFpAzCiVcirzI1SAst9xjEHJQuQfm1kAyZ5GF2lxtM?=
 =?us-ascii?Q?95dQUjR7lQ59uWzegYcwlwxtbotksL9hS0/YWHPuEsld3IGjQARyucVG0unR?=
 =?us-ascii?Q?0PHY6y1RyB+x8IE7cyndOQjW/wJIWP3+jHH/Ha3dyzRus9P/T+2HdIA3bD6U?=
 =?us-ascii?Q?ODQP9vWhzWh1Zyp/7cZJRhjIoImPN8b0v89OTvBy+62VKFmvtjC6KbCEvG6j?=
 =?us-ascii?Q?bLSkAfqs+gdFWUabQsD/zgzDBX9N4FEJsY8gutpxl2Lfvz2pu47k5yJpj6On?=
 =?us-ascii?Q?ppEafEuYeYqwvOvDEWYJ4D8HDWKQh+J2tvnHTqKvamLyBhN842ecd/jOBl3v?=
 =?us-ascii?Q?BE1vNsGw5uQHTlVbV8iLt7YWiAQbCEodfYmGMYTKmWdStOED25W094xnS2RB?=
 =?us-ascii?Q?pyGgKNp5Q6gFxfYEEvhkIAsMqKvGB7i0V1gsbfu9evdGnK36SA2jWd1hB15p?=
 =?us-ascii?Q?hPd38xLYeusBcq0FTOKeIinH1+xrF57eOZPk7V/tWa0K6gjqC9zqO6uyUkLU?=
 =?us-ascii?Q?pdQtli69mUnKFGUX8IhwAkq/g56F2IK8Lrxfua+2Qz/BhjVynN0rGH6AziKa?=
 =?us-ascii?Q?pvnn1Yo9LEI064ofxW+wulZ6304fhDH2aiHd5aCqBzNY1LKgjjWptRxoOCIW?=
 =?us-ascii?Q?74Pv50mCXGYwylyAGIJnfYHdEG8JyKF2XriMIftMmSJHhxM0P6B2ar8bnnf9?=
 =?us-ascii?Q?EO9NCQh9pQJz7idIiK1jJue8wqYlQiplPf+/IAztUJz094YJ3peY+AZmB1Kf?=
 =?us-ascii?Q?EaQoZuJXeQEGd7T7QnKpEc+brfZn9xwrg1h00SNY+XaAfs0JOYb6qBV8m7mX?=
 =?us-ascii?Q?3Tpbx+l8qNlSSSb59iVraEdeF0a2aezPwgFGNBAMezV0tdjD5URHytNzmNMp?=
 =?us-ascii?Q?tDIGyQPK4FZ/fvd3tX7dcdGIig0Dh+maRMsUU6TZwNAjBKkaB79Qbn8jI1ZM?=
 =?us-ascii?Q?gGNQt+xSJZYAX/Fky4q/1p0Ji9YePJocbef37orjViT0plYNMqOoD1STHydg?=
 =?us-ascii?Q?UDP2K885ccNCDqE+wYRFl65IgFELPlRhl7lqdDiTuP1OmONLB00qHw+uRwLE?=
 =?us-ascii?Q?WEYV99qpk3SjeaD/6QryoZzm+asfFrRINZNELxcfYsQ+9q8igcf55OzNEQZy?=
 =?us-ascii?Q?cvaNntGUr5n5sBvT4YF960KIo6rtZLR+pBiGTH6VPZllex5XZIQwSZaIG70T?=
 =?us-ascii?Q?YXEdjT3jdqkDbUn8mzC8ZIH4r/eeDIgC6ojxDLvGhm8RW7sfjBxOzSziSzyP?=
 =?us-ascii?Q?JCop9X5COFvIMjfR3Nt00Pl/1/6qy06DPoJ3sFVRYyICMP8+/RV/BUIsDKkC?=
 =?us-ascii?Q?CfuGSsVAHOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJtkQpqkOCLImQDAojLQuujlew7/VRVfJ/YRy+SsTjGIhGtX2So++UuVVCwW?=
 =?us-ascii?Q?NMVn/vGtxdyy2yybNazKAR+p35npeVuc2lzNa4CPohzY7o4TeSoqMV4hlD01?=
 =?us-ascii?Q?ECg8Le1JudWDIQMgQulljDOyNRl5C9+Y4f+u22d0pb+kZnkCa4yFUJkgG4vC?=
 =?us-ascii?Q?jqviq8XWerWRhYIuxiyEmBWV/tr8RV+Bqj5pC1GR6mX11Qt0WWqebzSrhtcL?=
 =?us-ascii?Q?zsBwpBdjdmnJK1abv8ofZW7HLmftkHC4L+yuP4xsIheSD4c9t4oRmlXZO9JZ?=
 =?us-ascii?Q?AWJt+9yqY9Bd6CYRuU5lzl7GZUAan4aXzjYRxTrpzuEy8QPQnvdGRJCWASnY?=
 =?us-ascii?Q?D9vRhB3AShYYpAPSlLitgvQR7b+vy3+05i5JsXRshapnD5tXfdjgn5xrvuFM?=
 =?us-ascii?Q?hHBLhSyhaF1qmwv4xcoJ+XROlwO1D2olRSYAKVHwiVDEnTpl5nfSJttwa6Ad?=
 =?us-ascii?Q?3WdaqAqoyw/djscumMtmyMWzZHf7cQPXkuYb783rR40aKnXEt5jsvfxTgSvL?=
 =?us-ascii?Q?JLbp0/cXFXtCLy1EvYLrSS+SARi/xs/1jl+M1WSxh9+nGpZtyNe/fUGRppBw?=
 =?us-ascii?Q?fxJ5K61rcSa7YV8VuZ1VcSKQ+nqFmDNLqUUFwTgMTDUbX0g6S2dM0NZ8mjyR?=
 =?us-ascii?Q?Iei2g8XMTU375rIv0N8oLWhcaZCjQV/gxFkzWI/Wx//033vkVkkUQI89woiW?=
 =?us-ascii?Q?an2W1OAlhXhTmuhcfZk2u3sk4y6AuNxYqCaPIAklDW/D28BSGI0wa6pCJ7KZ?=
 =?us-ascii?Q?rSNHAHlnLfdgaIs61qhtiYWem51+xW/E4GkJL6xFwfiRyfMH8Uj23hKuFOnH?=
 =?us-ascii?Q?GakADKSAsS8FWer//3hkEVVC7+MLmBcnWIzFxEpUP9yVvYAtxydXX0xBg4jn?=
 =?us-ascii?Q?4qnmEreGnuR7m/hNzcjCvepF9sXYRJDAN3HuagKR4PP1ZGTs10qOE43O528C?=
 =?us-ascii?Q?k8NUPGb6Z2Jobjgqu2tkWQfSL8M6+RXxdVNjt0ZwgciBlU2DsW28sVaOjloT?=
 =?us-ascii?Q?3DR+n/klLeof30MFV6gKS8or4VAnoaR2+VRS45o2q+di8X8N08ESXwPd/VjS?=
 =?us-ascii?Q?YagnXMh5kMN/GxwFGHmi7gkpCfxwiCTN9CbO0IdYBj8/MZ+qTq4D4wNxDUIk?=
 =?us-ascii?Q?4mLfE0yMZVHi5QX1//q+AuccOlFz7QmDssBzFSVOuxjWpxwQKkoEDRpBTMyx?=
 =?us-ascii?Q?CWqv7GtuZlWk8WZEqb6ygNjIGBH1Q89GG5HM7Bnd0p7cQnH2zezMt+NHsyQG?=
 =?us-ascii?Q?+T70VzwtQrFleXXsDA54mqHxF5w8Gt5tbY7HDqgLF4pU2kwarcxxHzuHLCRY?=
 =?us-ascii?Q?Br3lSOce4hNxSSTRANP8t2Ofl4A/+qmsJZwaLD0XUhPgSbFSkIMxKIlvimz6?=
 =?us-ascii?Q?EZAV5Kpz3PHCnf95mGfILCbRCz5wLT2oIWwcq/kUilHLuMcx9bKsdi3FN68o?=
 =?us-ascii?Q?KGiJ6FqOPwW+xih3dASXSc1j++Jef/qDgf0dMANnCPongUNGFmWvuvYZYxq9?=
 =?us-ascii?Q?Zng92Qr7YoPhkDl6MfmvO8S54cndCxNkh1CEfs7xQm9HWw6ot587+B6cOSyr?=
 =?us-ascii?Q?ikqdYhO4/yxJCBEUEuc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6fa9b0-0e1d-4ed5-fd93-08dde402bb5b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:10:54.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwH+QhiHtmH1qICHux9SOukk+RSFD/5JHsKevUBgcej+XI+QscMSszVfhBOalY81
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681

On Sun, Aug 17, 2025 at 12:37:52PM +0000, Daisuke Matsuda wrote:
> When running the test_resize_cq testcase from rdma-core, polling a
> completion queue from userspace may occasionally hang and eventually fail
> with a timeout:
> =====
> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
> Test resize CQ, start with specific value and then increase and decrease
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>     File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
>       u.poll_cq(self.client.cq)
>     File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>       wcs = _poll_cq(cq, count, data)
>             ^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>       raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
> remaining)
> =====
> 
> The issue is caused when rxe_cq_post() fails to post a CQE due to the queue
> being temporarily full, and the CQE is effectively lost. To mitigate this,
> add a bounded busy-wait with fallback rescheduling so that CQE does not get
> lost.

Nothing should spin like this, that is not right.

The CQE queue is intended to be properly sized for the workload and I
seem to remember overflowing a CQE can just ERR the QP.

Alternatively you can drop the packet and do nothing.

But not spin hoping something emptys it.

Jason

