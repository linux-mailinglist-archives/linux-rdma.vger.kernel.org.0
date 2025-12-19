Return-Path: <linux-rdma+bounces-15108-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B9CD0402
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 15:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0760C3019BB9
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF6329E44;
	Fri, 19 Dec 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N/adXfgJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888C246BD5;
	Fri, 19 Dec 2025 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154367; cv=fail; b=ZFb2UA88LbeWrOBxr03gR4qRzpAwAIpXKIVJTQpF0IHjW4J7ZvPFKkWYIDIq3vAvPne1phy5hbsQrwU0a5HMQOY078vbDxup/4E0XhOnjicEJt2hwIsZdTw3zs7QYKBtxEVO82jTK5SU4AOdKuxqjR+N6EtnoYB/tc3sb5ZTO8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154367; c=relaxed/simple;
	bh=DmOnHXljSCV1a0h7J3MSLMsyWUHmeB8hCl/4yjYPzbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JiqjSCpMn4BGnFOUz3GU43lNVWQwxHnFM5qXa770/IcM5rdwWQrIP0pyj5Kql1FRBl9omkaf8+1Yd0QM/U8384rr/kVLoPOTW6GTNB42XdkopQPJvzH7bo5huFbvEWIYvaWS/NzlsNm7QQwFg3bAaQ4BmMbSY1jERlrRWcu3zX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N/adXfgJ; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi15UErWfco4lL5alcTsKVZV0nPgsGoPvpGc+v1xLNdsbGL20OGawf1qmfdIByPOo93Tr2V7aIUfx2ysqDXMgs2yu2lr7bY0ZZT1+fPXIfbDmWZK+KOiCDlrqc+mMWNHDXqwzqldV8kxWUlUTUWYR0ItQKZpq2wjepkfDIIGTdjIec/xovzqyMogHfXhQFoP6xq49Zj1IbWs7mJb7CzBs4uket9Nrm74bNXbC8ALbp98oF5bF5zlAt75yFgV1PBA/5h+kkrfSpUXIi0rip4h/2NAXz9oyReB/cp2mLFQ4o5da+8M1bCuIq5Y1xf+imwjVvAccJ8P5qvczl7M1JYaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUTFu7UDCi4KheoCBe4UnJdq/jj4bubkb4TdeXiAh/0=;
 b=ovH0BDNvrrKSPNx4YelrgiE80FrUlC2pehoElbG2WVBCcelVm2umvpxl9SptthSRXJ4iy6PBu7V5SHMxlbETsITUh33i9a/GOSkWUTRbGShtsSLG2pH1n+YdTF78rzl1WaTBnMhzExYpdlQy317dAIErPsmg3SUKxdWsZByF8SHwFImkWVryzmu0K1WDoP9RPbaeuPHTirw428witvjFIr5GVaNrwuBG85ry3WYfTc/qkFeTSEZERPVR3cOoGd8keezuleoyIkgbtzSVJ0V9HLn0PIpqwxyg1mCUlCvKR4tAa2mtiw4/QmEe8WW3yjKqAW1A0ZM1T9tFEYOAjneP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUTFu7UDCi4KheoCBe4UnJdq/jj4bubkb4TdeXiAh/0=;
 b=N/adXfgJiM3sCC9C3yREDU8s8LSyjOmFmwlfoSUzElN0rMZ/ObINc1IkrvQ9EoHSy/rvZNqBTCRC+X/7EX5/hRn2rpzvPw+IXyqoZj4ptL43f6U/LQa4QjHFvjrjoIqyAiVxA0pcAusqr0rvjV95lFeYSa97+AfsUCBgK461U0qtbQq8e/Y6hgZ8UACYelGtcSpNXY2mJSLZkc4SXa9pZZ7p2w0n23ocs46cTtIxzhy0xSzDdMwNw3MHfGhidIW25mVVT0ERfhsOC++UhuwLk8IkpysufzkupKR69VmiaPbneSI8mifYyFUuxXkl6TkuGgj1gPrgA1YYeiLvwDGx5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.9; Fri, 19 Dec 2025 14:26:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 14:26:01 +0000
Date: Fri, 19 Dec 2025 10:26:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Yanjun.Zhu" <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251219142600.GC254720@nvidia.com>
References: <aRKu5lNV04Sq82IG@kspp>
 <20251202181334.GA1162842@nvidia.com>
 <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
 <20251204130559.GA1219718@nvidia.com>
 <80620d09-8187-45b1-a490-07c52733ac21@linux.dev>
 <2191ee0f-a528-4187-ae5b-5aba18741701@linux.dev>
 <7e3a294f-5dc2-4e8c-aacc-0286c1592038@linux.dev>
 <20251218155623.GC400630@unreal>
 <5d950681-7f16-4b1e-a512-b118c747ffd7@linux.dev>
 <cbb0ec98-0291-4ec4-9633-690e9199248b@embeddedor.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbb0ec98-0291-4ec4-9633-690e9199248b@embeddedor.com>
X-ClientProxiedBy: BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b71cd2-5d3c-4950-c9a1-08de3f0a88d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LAM0uxe2zWTw0KOgQ2rjmngxf3Ndp4pDL0JQ4Im129Hpbe60dXmZ0eLacbDb?=
 =?us-ascii?Q?5YLdrV3HEqdmJFsSopwegf6Y6p1ehvzRVYDXSkVVWJhILX+ZA1r1YPGmOVfn?=
 =?us-ascii?Q?ebcn6k2fKRoI8kUkq69CQfcPf6MmV+VGexircFw6f4vLCtgV3G26kLhbs9aH?=
 =?us-ascii?Q?Mo6WKjNYdiXJUYnU9sQmiQNn4ENZkjIiOsSX1bBHpc8Z0LPnG3lHcgvy2hlk?=
 =?us-ascii?Q?Sa2LGK2Lgkdok01aN4LCNuxXUwRemqiJS4/ziN1979nwhOMqS81uBDz4hE2e?=
 =?us-ascii?Q?H64BnkO3x73+5WJoSOtlxlDlynSh2aHxbd+QOzwll5YhOkHLpTJcyd1QqaFz?=
 =?us-ascii?Q?h4lR+tSpRsbAP1iCXwTtQonCIuX+dExeAePBYYtTqaxY8hp9jR+p++IYzdlu?=
 =?us-ascii?Q?H86BG+v2hnlBevc0HmMHRKfwdOOtIxjHDXKiNIt8enzwMNtv2gN53a6XbHah?=
 =?us-ascii?Q?Yh/bEiQcegJaabi5WyaQk+fy9mmuams9c7+bw1tvQvHBLxpITkTyydoC0bVs?=
 =?us-ascii?Q?mko6Yz50Qf1diSCZNMB3xIi3HZJW+CfjMlw6z95MKXt6ACs8UfWg8HKmX4sO?=
 =?us-ascii?Q?yehzO7t6FOO4yXab3TamytGjlK3WViZ+PTNFfgoR6YTlgMgneTujCX5kCRqp?=
 =?us-ascii?Q?PyqsMXRvqgG0vXXR+PmdzkhmwHawZnBX2K2O6xSZc8wDltjmEuF87FdB7cb6?=
 =?us-ascii?Q?XEzyZHIkNmfsiSITc7uxvYxssEThfGyA0lPFr+5o32u4mUQqNLy+2NRL9+ZR?=
 =?us-ascii?Q?TFvA7P4CbzHbCVN+gmgtkRndsWp6WUdooelie/yaQMCXxK1s+UIa/sbvJqUs?=
 =?us-ascii?Q?vGE1rr/uFQoN/pnXwN7CqcPGBTBQ4umOlyB5/U6b5o7vOGwmY+8iNesgEym3?=
 =?us-ascii?Q?QTL+tv1Lrqw5obU+OZfQNtu3C32ioFmdIYgvDZKKwzYbPCh3I0p8YkcPVajm?=
 =?us-ascii?Q?Sk9EhjCxrRJfnluTF3oV1UtJ4yH3GQmS/XmTjJ9+s9f0OUezi7CAbbdL+NU5?=
 =?us-ascii?Q?3VhqcDgcZTnwvYqR5S+WZ4T1jS6MgJMX+nZIFEgbVSPMgVIwsM4+puEqCbLM?=
 =?us-ascii?Q?FoI6OYneXbkSo5WESdUmn4sGU2GznOKdRfVB6BbdmcDx1WY3rkzkLJ3+PsID?=
 =?us-ascii?Q?b8o39mKKV0HEPf9GFAkgdnl2hJqH0JKN49NJX2y7GqmK1LyPV3AYmXF6QnSA?=
 =?us-ascii?Q?2RDOR/nyVnn1jKClczbnMKTWWPuC3NUgb47Ni/1ICjSQYIzdPRxNq2kac44z?=
 =?us-ascii?Q?QZML+cTVAhYiFHNBrEdfYov87AbP5FUb8gW/P/nY3HNLODTozfuGIaDuZJbB?=
 =?us-ascii?Q?x1baWasFt1yypkqvXMESlL4HVEAZZG87b/peIx38Mub5llJ6xkhgJjqGw+iv?=
 =?us-ascii?Q?5yOo5N0ys4FcnfvaizAY8u55vM+cH3DvwXxOj8ftyKi3GBN4P5t20wQMqlSm?=
 =?us-ascii?Q?eeIcGtyDGsMo9HbPBtjP20lhX0fDavmO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0XGjuGhfDvC46bSG8upQYbtPkUs6O3n3i/2SHTmJA3t8RF6yIaPE88+opIu?=
 =?us-ascii?Q?6Z6nlV66Y/OgO+1TL9Jr6GauAPh4d6ed4bvNuE0L3edxf6hZbpiXTPXuhxTF?=
 =?us-ascii?Q?6QpwvHy1/rSC8N1FYWVTNbVRTAz2d01maclOFQ1cKePdVRj6Wx6VNyN1IQDF?=
 =?us-ascii?Q?K/4OkhA8M7m8U0ixQso1+7gUa2DCQWh5687woQPJSuWVSOhInsRfz/LzrffD?=
 =?us-ascii?Q?ag3BpDpoR/U+5ublU7zAkuybGpY1Z7hsd7A1Y9uQ/zG4koqRgvXwHkL6WScz?=
 =?us-ascii?Q?oPmA2WFMAubBR/GnGb79lpLCw5iczLnh7QQv+nnD0gEV1OzX3cMq8N2JuFSX?=
 =?us-ascii?Q?K/LRg2QykR55f1p3d1y6CymjUeFCWbsd4ORADKQZ2PzDXgwpo+m9knHj23fl?=
 =?us-ascii?Q?vivjtVVJN1W+o81GshVQOa1gAYZD4S/O/NXyFCARdRLaaOcMlNCoaEPt8TAt?=
 =?us-ascii?Q?cHJgnHybiJZ7Vgng8RHld+aT4CZuuYjeDNyYyJYN0hX7jee0e1nPgxdbOqHe?=
 =?us-ascii?Q?aksljKyOCCu6Hxf2K9WBZ+5gsSvQ1t6sCuJTCqRJukrbjsf+JY4mevHo+UAU?=
 =?us-ascii?Q?gLSkoVrsVzCpLiyuRNy3we0HpBIceF2ir39Z4Z1omrxOX5hlpccUGNiIVZfT?=
 =?us-ascii?Q?FEo26U1kvOLnSpPlh6j+4KS2TlrzNFAarUgGJlhN967Vg7qaJy4B99eIqPjz?=
 =?us-ascii?Q?E/FG2dtIbzgK4BcyJtAMhEs9vTvG0Q+YWG7Go7pv4i5nW0ubYp9UJmS50EQd?=
 =?us-ascii?Q?8cRGN2NY/wrJATX6ZZnjBMLN8wY1n6dw3FOoyGHyOOv0Xc4x+z0BAVPFkvPy?=
 =?us-ascii?Q?wbFK9Jj1Yi4dCJrK1avX2sSp5YWfj0oJCvs2kt+VW6X5VwBTMJ8zhGe7w/aE?=
 =?us-ascii?Q?ONiVlPj5JX61Di7FgutR46AX5xjuySQkeRTnsLv9Fmw//KM8yEFnn5goWIBc?=
 =?us-ascii?Q?1RBYZuQKwiTC/2BybCnjHj51dofhZxMK0cown+ci7XUBHzmVngY5i0uYvArZ?=
 =?us-ascii?Q?1YlrtP6zX3sych8NlKVQvd2X4nv7loMsKu3FA9ZR2veDcpb2zufGtIUJiq/P?=
 =?us-ascii?Q?T4yaGhzNSqWwTAMjtCvCbpBL1q5zcRShtbloasMPmYpCNtATkJmoWc3UjqlA?=
 =?us-ascii?Q?VteCqNvrM7nSQdau4LiWwb5pOTXHBdZOgohb/H0TfLmEe/xcD/yQZzmdj/rw?=
 =?us-ascii?Q?ydLpTvhuV4f6hadf10ZKB4DcF6Et4QotpFJxwwvtBeICsOhx7BWECFgTOJqr?=
 =?us-ascii?Q?htKvLasBGs2gKqeDEpztX3Ac5h6B14HfY86Qsm0VqVMtV/y/xmaMpNFCRMc2?=
 =?us-ascii?Q?VTLFO7ck2XzbmFzX1hkoa/yWOtpbKzubGM/C8KzTi4P2pxhqwDu/WozP0Imz?=
 =?us-ascii?Q?sqIMgUT+LQFfRfheufh9T9jQQ8mG7s916gvTyHpisEMBHawKVffZWCKOTl7l?=
 =?us-ascii?Q?ysn2XiWkBfEJa0FZkOkgkcaiWK8rvnym55O2TsjFoX6fUCKYySoTk/lY+2Ol?=
 =?us-ascii?Q?2ELHLsdgxcM/ODEjhemYnHEgwVk4F+YatH1INksV8cgLHUS4BEPMnVjXJuVV?=
 =?us-ascii?Q?uUGRd11PAbvLESWy6xk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b71cd2-5d3c-4950-c9a1-08de3f0a88d5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:26:01.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnoZVoyc3ofyeCq5PJwnMvIDtAN8xZi6tFncJAK8fvRk0IlkykUHSh3GlkrMBDd7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446

On Fri, Dec 19, 2025 at 11:51:54AM +0900, Gustavo A. R. Silva wrote:

> > > > Any update? If this looks good to you, I will send out an official commit
> > > > based on the following commit.
> > > You are RXE maintainer, send the official patch.
> > 
> > Will do. I will send it out very soon.
> 
> I don't see how this addresses the flex-array in the middle issue that
> originated this discussion.

??

It moved it to the end of every struct it is part of?

Jason

