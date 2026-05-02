Return-Path: <linux-rdma+bounces-19850-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO2uEtv+9WlrRQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19850-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 15:40:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F34B231B
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 15:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742D3300F53C
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9502B287247;
	Sat,  2 May 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AKYMD5qV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02599175A66;
	Sat,  2 May 2026 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777729232; cv=fail; b=XtKOY8AwwD5siRHOV88IJVIya+NguoSJK7qeFTI0Dj1X6rKOBfFf3e4kl8voYCeKXL0KeLkrxlL5e8W1k2C6W5ZtDFhvz9OOCzrBMmC+kPHtOSL2ZCDOTom2+wRMWHjwvIOQE8eD67Eqo+MtWNjX3QCsSxt/n81Zk4eUXa0YeHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777729232; c=relaxed/simple;
	bh=nm3PVgMMxdPWcgzW3XERj2TYCZkN9Neyp36kF1ydPeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qZGWas6rK7C6eRK2midqO+rZim4bCeo9xlwXQeALjK6FBpLz2m6N2HLt5yEoh0uYQTkvQJW6nEdQI5TlGpx7deb2G2+NGq/ahQsjV3zBnV8VXf7ytweZq0iwohThtPRmv6CY6t8Yx/OD2vOL30t/kYruDJJM9xNYo6LCFjQTyAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AKYMD5qV; arc=fail smtp.client-ip=52.101.57.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVjLFwgk7OClZ/hBdljG+y3YHas+R7ssLpWZ6iV8TBXOTUkHfy4YIyqrfzMl4X5s0XiQ6+c6rp0NTSIi3azCDH8hcCU/V3Goz/PQYvoSU4nakWkpmCM0yLIsz2aQUG8vd9OWMnrbbuyaQ43wVGgneEuB7pA4mR+DMTghqkpGsyNqN+WpiE0COVGWBN7O+Re7oOeiHtGpkpwbXKEL2h5m0IjoWv2+I2mOwbNC2iQ5ygkC/0JT6Dt2V+jaLrBW9qpDqceNECNloC/NbcO22zfsDAdVhSj23C+ZuzBoj6jAgtquEMx4i41jEWIKcJodoJIUd5U7abmGBzxa3gj08FClJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPLLxaN/HNkZxGxyFNnJeAly4uq4N4+5z3KTupex5I4=;
 b=YuAnsKtjF0wYjxNMcIWGJeFN/bf85yjPOg3YEk7RPipNMXO1er7vSTV/NUs5R/bMxSnspyZj6uMAF5Xu+k/CbUN918VK/GSZpTHd7VGOy5kzBg2GBVRtjEqEeQadDDpxldnT41AUW/paSjfbmNc9UQY+tK6MLgHdDzO7PQRvIZFruxiDrnKguPomKxQNcfPS5w7zvxVpkLpJZ86nxJRn5RipYVLhsQfP1gDP6+h75sZmghgculx2FUeODW74qoV5iCiUXOfOS4rfNQDjDH1c9lWsfyaI6FSPaoOOfM3tHzscBCBtK8h7nViRLDHEUmUyLSv9dgIUottt2JMe2pAddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPLLxaN/HNkZxGxyFNnJeAly4uq4N4+5z3KTupex5I4=;
 b=AKYMD5qVbtgcRZ+u31KN2hCcNvQTLeIhmizekyMd9x5+3PM1IQ7h4U+bN/Y4JqFzATfYP88Sx/jB3DbPfrba0T5AXPzpNstdsqNkbH6ZdOrDsQQynnDAEqOsvL2Y/FeK2hVN9dwE+yASsDETwEXZAD3RUppc/a01WN6b/7Hkw5fLyXyDitf4hZqQ4SZXWDtOtBYEMsobqtgFY8kRlIkVZSUFsYmbiNKTMCyspo1IybeqCKoNPDtskvWE3Bnk0xCHkTbSLAjdMFCXxd4n7f8aZtxpgLbFkZoRY6pysaFG4Au4f2qQGqmp1Wefz0e2UzD09n5B47UNI1wlBDZtAC78UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 13:40:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 13:40:26 +0000
Date: Sat, 2 May 2026 10:40:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
Message-ID: <20260502134024.GC1381708@nvidia.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <71afd479-71b4-4ab7-bcbe-3f7b53bd11f4@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71afd479-71b4-4ab7-bcbe-3f7b53bd11f4@app.fastmail.com>
X-ClientProxiedBy: MN2PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:208:23c::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8b3557-836b-4728-00ff-08dea8505da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/fI7RtQ6J2R6tUfxWAexS5pfHh1lK5GUaTkID68n8l9wbWtaYvgbO1acGaLzJGdQkO4x4bmsqy8UrIOCv0l0B3GLE59iD/jQt9MtqsDoiIwlTjL54eTPeLi7Dv+ALs3r9GQxQQ47+wtg+xgD5vkEP3KGLZMYeiDC7hl3FZBAPgUYI3opJ/VvkNPqqbzyb8iltY0dhIvdpyi5y3peUbcS/FWorCNDpFiOtRItcrUEGLi9EGr9DOE6d5W6IP+DXjAS7BqvpG9yqBBeC6OXY2aTBiJ/gX0zAa2UrTvAlMsMdCpNmuPfcmcz/p8jUwhI+guGjYCmK5dFNlk4FFRi8q0hELaP7Apl8epWhEnaIsLACM48+pL1wkDfuQYuKG3nFG2MA7NDDm3FN/kSAxyXajiuW5Tt5/QckQqZvmcxSNueMFUkeuvU3cOQx0jps/iKzZJ/K3iKmUY4agP0RlFcj2JtPK0wwTN/Bnx+OMfLSLBwdChfmJFM3DLrwt7MBmfaD3GIJv6utVhyFLn83dwPHyTcm5+oSnQpQxySzqdAtX6oTU4Fe1RH1bLqgCSPGeJyeDiqL2OhstSc8c4oa0tkn1VkX3sL5d9M04XcXq2saUHfhAqoW8zfLgLkreBtSQJpJcHS8RuORJX8pF9+weLb8RDVDtA++EPMLyUYZDO27tG2RePmkuPX975xF5Gihj+ywO08
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AWtf1Gs4myadVtoBxR3FwGW1AKLKIQh3KnyeD6h7656HPQfTlsTZ8K9OQ9xy?=
 =?us-ascii?Q?d7vOxBtwjF/rdVOfVLIkBKeYccGJmc6Bzl3Cl3uRLCwV+gnbn1tywCWp9AZd?=
 =?us-ascii?Q?wAy33ZrkDFZogjt9pzz5NsRb6srr65NkM2dgkAXpof5lad++SJCJ74fnhpbL?=
 =?us-ascii?Q?RGP1ShFLtxix8/w1jTzgKuiMZA+jUuyzEdWMY8iD/AlVY3TADmc08Kc490Yd?=
 =?us-ascii?Q?BcPwhzgrMQnPD+fWZRmqlzTDpFJojIngTTChtDGdpWk2xgeH1+yWFqraWnLG?=
 =?us-ascii?Q?q4XGucArLwJg26jQcqvDxssvsrGyM17dfLbxuvuSMnb7FK9HmSHVFCb1XJZ7?=
 =?us-ascii?Q?TxtxlRPkjJq7iqxsifwWqoTYz4N6M4skFGigXzs/HNX7f2WYNsKQ/HktF9sV?=
 =?us-ascii?Q?RwocFR+3KkJtuqWZXhk1tC6y9I5pS0TbWpcCAoMyNrKc50vXpdSl3cR4uIEK?=
 =?us-ascii?Q?amAL7/aNlpxEw7XCYffIiipJm7JLvn95LVU7Z1TK9WmSOcHLRDFGdEE7IHAp?=
 =?us-ascii?Q?+2fVj8P5clPzozK6evztVoVGxI9E1eC0L03jyCAQG+W7JGoZGiJ3lbSMxhFm?=
 =?us-ascii?Q?bpe5gNUKF94ZWSx4a8Vg+zA+W8get2CXB1W4KPLahY8jIM1FZY+6IxbQ4aQG?=
 =?us-ascii?Q?ltBc9XSoYSufBBxhX0BRbfZmT9Z8h6UDHElmUS+HU4XxyOqIj+KjvM/uGvDt?=
 =?us-ascii?Q?7/Qt8AyEEOb47uwJHt1aQsEc56CPqeAcld9VbgZXGdXZStzm4eDe350pe05v?=
 =?us-ascii?Q?1YzqMm6qVoIddM9HauHaxuqghLAyAGJLSMyRY3870TfIX/A2hT5lMZD+nOcb?=
 =?us-ascii?Q?h85Lc9KYA8xwjyHlJ+hZg/e/YZkczH6azfQm1bNSqiSLbS2rGjFB3Ji3T8sE?=
 =?us-ascii?Q?meRaKB2DRsBXLiYUKhlJC3MkIMpI7rqyHCgX0oTuh2Hx7nh4nZ37DtUQjhpc?=
 =?us-ascii?Q?0r2jg5pGMeQrDdxLYN/R2erx53Hgk1D50JDyMg+KFKg9MI3i0y57RVuuWXRQ?=
 =?us-ascii?Q?R3w6Tx31WO3QJzuJFvp189JfuFkwMMleRkh0zNc4lBwzhCNDpT7KFvXx1n3R?=
 =?us-ascii?Q?6mOWTtpBUyed54/vj6nM0hW7bZId3hU2u2G/7Uo2Sp7QrQ9TIL0nptCOklQh?=
 =?us-ascii?Q?SnTx9yAd0IuO2JeMdm751oIY6FyA9rwVSquaYrW/UoiHfX8CvdoDhemtyRNR?=
 =?us-ascii?Q?Ij6TB6s6MONMBu9ILIw5xkZ03r8x+3bCYQx4MCGzklK3WdLnvhFFzhnG4Ape?=
 =?us-ascii?Q?Useg4ifcAS6wyZU1Gl3LwHWbJhp0AQ72N/OfBhm6Uvh1iYiFhQoWBW9wng/i?=
 =?us-ascii?Q?B7b5ImSEqkKjn6bxc/loy8eXllHHG2f8a+ayFEQYMqTlbJ/d+dNdm9gsAak/?=
 =?us-ascii?Q?MlB3o6828UNy/H7iZlemGKb99eJmouClyNUmIKJm6iasNEbe38kLGGOfXijd?=
 =?us-ascii?Q?CiuzCP/bNtAgD6LaHj1kG0lDFm4X7ajMXyr3j9vxGv08OEInKnPkG3+I98Se?=
 =?us-ascii?Q?Wf8dK1JHiGmUiIuNm7DtuoiZfyjUMAhfQ+65d4qHMclLQgT1IJR1CnV96zLv?=
 =?us-ascii?Q?Ton2M9R/simxpEy7an3YH/R8uPrTKp6/gtY81xHm6lRG8BfckUaHct96HVGj?=
 =?us-ascii?Q?/9tgXU83Fgwt5jGZI6L8U4csgM64mHmVDZtTaS+LVE7YZjQozyOpbQCKnOWb?=
 =?us-ascii?Q?32o30xeAq5J6bqW9YOoM2aZFLOsQsrfQX/5r1lhH8652vWqP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8b3557-836b-4728-00ff-08dea8505da8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 13:40:25.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjP5Cw59N1Fjbp/BzvGsDjE5kQAiGPt5WBy7RxEXdKT9+W4FBXz34tw0urwLFySW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
X-Rspamd-Queue-Id: EC3F34B231B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19850-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]

On Fri, May 01, 2026 at 10:31:49PM -0600, Alex Williamson wrote:
> On Thu, Apr 30, 2026, at 6:08 PM, Jason Gunthorpe wrote:
> > Add an mlx5 driver to VFIO self test. This is largely a remix of the
> > existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> > to issue RDMA WRITE operations which effectively perform memory
> > copies using DMA. Since mlx5 has a stable programming ABI this
> > should work on devices from CX5 to current HW. The device FW must
> > support the QP loopback configuration.
> 
> Does the PCI ID table in the series need some pruning then?  It
> includes CX4.  

Maybe.. I don't actually know that it doesn't work on CX4 and before,
I only was able to test as far back as CX5. I'm thinking to leave it
and if someone does try it and it doesn't work then remove it.

Jason

