Return-Path: <linux-rdma+bounces-19189-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMzOAZ4B2Gl4WAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19189-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 21:44:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E33B3CF157
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 21:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B70C03008D10
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 19:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E132BF41;
	Thu,  9 Apr 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s8acGq/O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29902248A3
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775763867; cv=fail; b=YQbSNMLMlA7houxdHut777mxH75wj/BhZ+YCYp7GVQCTdHDAHFuHlhvSQOBbHfxvNMCzARbSFBNuTewXS2xSmZS/u7m+L3O5od6SlSbbdlhhFa23NZSM3peSfnQ4JqH4PQeUwXd5grCzhIuh4l+et9s43Jcb5aaNiq71B0jAK7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775763867; c=relaxed/simple;
	bh=Lsq9kLoOavbQ6kn3q4y97/SRO8reZITEK8CXifPjdvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fOcZOI1oY4e23DiulT/09I4i9oXYN4M1CtnUTU7UlqjubVKLc1W2DmwVnTkMC3noYCOWyH9ViJuv6G4a7wob4wnreDuGubBbaf7vrMi+1nqNrkv9zF/60ivnxeikTtCR7F6eMlYWITTiuaay8DYgiHJ9ttMRQfIF/Ouzd4DWSCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s8acGq/O; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHdwpFW18wl05o3BQPOB8vE/YCrNP6DOcs2/7p2k/XsQrXPNHcFw7AFQklx1khUvut7OsiroUEze1ARbjaInytw5/+PbWyWUg8LhBG/130Rl5Ys1YUX9s6johJT8TAO+5p3Rt5Ai1EojHDQT+JfKy7BIfLfLxZS8u9mmQJq+1g6lohpa+IYSBYK3Mz8TCh8IW7nYD+sdz4Y89qQ/NEPlFex1jIrvVlMcxoFKbRr5+ImCg4GvDAyscB61kbkB6Y6+rg9n2MXrZJlMfTAl7pCHuVHelm/2yamqkK5p0vKsLR/+27iMwvVxXa8XDuh1QCrF445QdfoTbxuHg20PydcZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evpkcPdP5OOUcI1T+GL3VxFPCVHiZXzxT/NtirPXeZA=;
 b=DSInlGvtFmyZq3jZLNGa22UbDiS5bgAHAzzvS2oywyTf8Pzmfyv11rc//XPGtV5myDeHj6JEinu+UcBWUQJbYhtKlk/oLcIF8mZbpHnTvHZaQbgnO5vndEUdj+ZdIHNlyio0HxxkBVVpKdSOZjnT8mY/c0UDEKG/G4SkFfEthHdIWyqrYmdxL80vmEfrdXbZ/si5cSJxSVPGLPMD1QMusZU1b3YQM2JbScf9AjpeE35cWykDRRzTjDrXrRCbiMhpJNmexfj/zsAVWsdz9Ipozb2+mBaXJMCz3+hihJwNWWUImKDJ2MsMwk/gS3b09qMfmjTy6QfED9O7TXFsI4x1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evpkcPdP5OOUcI1T+GL3VxFPCVHiZXzxT/NtirPXeZA=;
 b=s8acGq/OjNHzEkCm6cjr6582bLOflOHrBwJ/yd1sYY3pcH0wPgUQlkNR3pInxyo2HlbUsdKL9+Gz/O6vhW2gjwwiGlOPKEmqIDXOy6qTA0IRn/R/oyI224ZEXKt0+rRZWQBDT1+WqVvnpHZKK5UpFQ/YDe15D+W5U0/PkBspQMtHdGTZBfK5A4YobkBC2H/Z86uUakA2/r5vQaHBg+57UVyX1Kc0qAPElqHieflx9Zzq40HDm9twjVyA4vgpmgyK4S0dwXUGKYHHXE0b90X1VjQ4LZQkzmu/tIVipyMJJAGxcxauouiMeygkkCwpfz05rGYTXoxpVQqTO/+OituD4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 19:44:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 19:44:21 +0000
Date: Thu, 9 Apr 2026 16:44:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: Michael Margolin <mrgolin@amazon.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"sleybo@amazon.com" <sleybo@amazon.com>,
	"matua@amazon.com" <matua@amazon.com>,
	"gal.pressman@linux.dev" <gal.pressman@linux.dev>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 1/4] RDMA/core: Add Completion Counters support
Message-ID: <20260409194420.GT3357077@nvidia.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
 <20260407115424.13359-2-mrgolin@amazon.com>
 <20260407141731.GC3357077@nvidia.com>
 <20260409160007.GA24340@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260409161357.GL3357077@nvidia.com>
 <CH8PR12MB97416FB899448DE69BF3082EBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20260409185537.GQ3357077@nvidia.com>
 <CH8PR12MB9741DAD52C2D8078B6D366DDBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH8PR12MB9741DAD52C2D8078B6D366DDBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN0P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a8aea5-a0bc-49b2-dc99-08de96706548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	66gVB1O25gGh2+HiIftPLjaRle/3B+hgIt2hkZ4CL1WS+BtkeJMNCN+2XHnTvmbrqFJvnaINR6egKWJ3vWF4VOZFELQ8547BsOnlrZuQSC6HKFfh2i7xtePXxMjDDI38RtLuzC3O5jnxEMFRI4c0lVVIIIYJDPtt82NyK9tf/11I77kG2lRvrWqIN7fjbRF34hj89XDWz4H5OT3IHfD+p43tqUFPVD4xkZwimc01pBphezZfn/8tX/VO8IUOU8Y45FEqmQZD3ptUDaueG7OA/FPWG8xGXtPDNX1uGxi/6BHZ3o7QntdOg5mcECeVqxWoVnt2Gd0fF5vfYUL21jKg66gY/nqXoYnWvyN1ZtaFwb2YLmteQrwbwxbvMOPXyupglJFqLKQ3k7lpFVfuTWB50AyF5SlvSDeyS7xaWP71MEwkfSNWppfYt6MybgV9mPQKq3KpHTb5m7FBeCSvFqGatyMHHxN4lyh7AwxVNnxKzUi3bX95uUdGlIayRaLYge2dmX7J3jH7uKqXUOnwmKgr6IwIX79v3GRlQlol8HxUUR18iGIb6zriWpFn6wSDgyqWW+4g772l7yAE/f6/LUX3Nzfomc1adUu63XaGdoL48bj1KxBbTfp6pDRZjuX/gboPNw2LK0/qWMME1B4hoRID5lWNaMAd0FcVusXUvRMeKasaRrXrXdKNp1lFOtzB0t86Ok15B72Xo7ZxjFLwYjbBV0+Fnojla80fsKTihDGBqVQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7fq/ammSWRiTsVh5uoGsuv2LimSlDLmhxfCEZpRF+RfmswqeyDVhEkfb/L0?=
 =?us-ascii?Q?lFIdo8vcd/Ngo0lmHJXHEPpVirl9TJY0HrUrSfmZgc2oAOsCGs4NhiFWCszp?=
 =?us-ascii?Q?kXFXipDvYOvFDWZFosSJs1Qq7LmxRqjvN66eN0TBjR5Q6Ddtq4pSHzekzpXX?=
 =?us-ascii?Q?jbclE1jHvdRPqeznP58Gde4BhDqr+AQOri/E2GSaMRpeKnxb9gFsHVrdCPRB?=
 =?us-ascii?Q?k/JLkK7WLeWmW7E5QCMmzeiefLBGnlbN71Eqak3s2B/iVbiOP/zBtRkxE2ls?=
 =?us-ascii?Q?C65LTyvGFRYje0R5o+UB39CouE0wdpkSzSd+NC5Aj6+pS95uI/oiZoSXcyLd?=
 =?us-ascii?Q?tdhiDEmOLbwhU2tXrvOfT7b4pZOyyTkj1HHigCooAmfvcQ1h1hdRXzQSnWR0?=
 =?us-ascii?Q?2sTBIqWocGf14QaJB/orQtVGDMfFuwNU5Gz1adQcFB3bxHfc6x5W8zee8n3B?=
 =?us-ascii?Q?BL6mvh8wjIxHj/gInw+Fn3dvD6vWw53xWvNK2c54zf3WikB2hYDmAdz2VYb7?=
 =?us-ascii?Q?4BKzn10hQ1T2/dVzO/t0+Z9iFuttFHaukC3nGeOIm4amt1LoYw4kbQ3o+5yb?=
 =?us-ascii?Q?5F97INDgt89LnzNggqlJI6hD3kMyi4+xtn9wrLw/O1o3eTBkLRm8wCy5F+FA?=
 =?us-ascii?Q?4Y39pm6Tn38l2bKEgzX8JuxRaqorj2avc8ACj8JYq+sh+4pRuKBw+ZVrBdcy?=
 =?us-ascii?Q?SJ+uRtZqabhLxx7rHiOWMzcNpr9wZijr+cngZI1tnoonNpkPwzq1KuSw2UO4?=
 =?us-ascii?Q?E8hlId8QqroP/VAS5kkjvmTQVHC305QBSdF0tD9mLXCLdcpCP8K3uwVcz7ke?=
 =?us-ascii?Q?iJCzFRjxBmjMAEqAQxzGduYz0bnhMZmKOq5deDxB9CA7u6cvQ8rpPV3z42iU?=
 =?us-ascii?Q?2tqySh845/GdIRyStdS6CLjydEL5EC8ORxXsu1NRyrOz51zFWKGkTYChw4K/?=
 =?us-ascii?Q?dO4VsLUqM7JoSrOQw35NJCf3ouKZsski9ly+OHoQUykzTuHPkfBm6KUrDkaW?=
 =?us-ascii?Q?JIyHqwf0zW3hKKEgn2QJuWRSvsc15ldx2/CTtn49Zv6xHSkxERaiz+F4Tc/s?=
 =?us-ascii?Q?gDGyDvK3/imNFqKwx4xgNxgCbP7zhVUPkjH9MgMlfoEbDVSOYt9Dy+qSwvWe?=
 =?us-ascii?Q?oJz9u2+lxhDXOnQv7pPTSA/HQizYhUHPAgOpwiANAxuIgH6jZOjcnAnjuVST?=
 =?us-ascii?Q?wAt/Oqp+TVd0zqYHoeO8UU68cfKwv637PEaSf6rRGRs04BrPMGEjmNe8q45l?=
 =?us-ascii?Q?wflTl2fRKklkObApYjE5refuvoBzsRElRgGGw67Z3BgddRbiBdPznhm9OgmY?=
 =?us-ascii?Q?0XqcvHNoK5NiWAw8IHqhPOpT787tnHtzigcCsYJ7PtzOwWhTcRqn05OlaPrc?=
 =?us-ascii?Q?wgL586mBxy3JKa5lfPXEJdoOXqZbolDhPKAo5StiE0jII/a6IfLGOZJrusVH?=
 =?us-ascii?Q?orHJPd9IW8Al+TlubBlEzmyFtBoElyMt3msRDiG0FaB4LVZlmqTJt139ZHci?=
 =?us-ascii?Q?lE4LD77UZlyixL82Vi2IOpqBj9w8PuIJfYG9tRKD84E7JvyhF2NGvpKcAhWr?=
 =?us-ascii?Q?rg3VxZ8q2ipwv3fkpgUvIfREQGGCA8mFPpzs27jkaWTl3ZVCakwyIbaeZeia?=
 =?us-ascii?Q?5PZsfkcVSqj2ahGeUV5aLOT6wQ+xQqmDbvYsPsvQTZD2+5oDM+OeDFucwfej?=
 =?us-ascii?Q?U9G2L6neof9asyZws7voUTIr1i+DLcJGcXn31EMvJWQ1C2wN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a8aea5-a0bc-49b2-dc99-08de96706548
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 19:44:21.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pz50koMezAwkjA1+opS7m8J2ORVM8MLAkNvTK6ln0J/PAOgX8cO072ooFa9mSGkn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19189-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 5E33B3CF157
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 07:15:31PM +0000, Sean Hefty wrote:
> > > I view this as an implementation option.  One vendor may implement
> > > independent counters, which software can then piece together.
> > > However, another implementation may have a tight coupling.
> > 
> > Well, this is a problematic state to end up in when deciding the OS and library
> > abstraction. If we don't have joined counters then we can't really support
> > implementations that have tight coupling
> > 
> > But if we never see an implementation like that then we wasted our efforts
> > making them combined.
> > 
> > It seems like if portals and libfabric defined them as joined together then we
> > probably better support it that way too as someone probably made HW like that.
> 
> Can we make this some general counter array, with properties applied
> to the array and no concern with how any specific entry might be
> used (at least from the view of the kernel)?

How does the API work? Who decides where the counter is stored?

Jason

