Return-Path: <linux-rdma+bounces-20021-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPPFDs0T+mlRJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20021-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:59:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6154D0C5C
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80EED302AFE9
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489AD481FA2;
	Tue,  5 May 2026 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SGTHw7J3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBAC47DD67;
	Tue,  5 May 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996177; cv=fail; b=ltQCskqYUg7AnGCvw8BZVYcH5BImp+d1EwLVB0E23/DLTqgD8cfMqk0eKUV1NLlV5DnMm71h/+UH4hBi292W1k8aUH3ZrOJoJ4Yuez9EH1lZeEBh+tNikrl0JZqetDP9WojuU2FNK7NOAPrc6UvKUzpE8DX4YqeMaLnp5jQIpIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996177; c=relaxed/simple;
	bh=sg3zSEL3MKVK6G4JJ0UiTCEVyEGmC9AhLlXLjRlgsNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7tYyMO84DF1tJWxBLJ1p8tQY4sEJU4reWATjMloYHxHbOLaxXpQqIYG5Q05AlfGcNRaGWpRcfLmbRBz1uzAyxLVvGx/6A75StuDm11YoaUVOXZeukjVMUTqG4VBf5mEeuaPCebBqV58f1J5cR1eXjF6cVxNBB1jDHTA/qg7xiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SGTHw7J3; arc=fail smtp.client-ip=52.101.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4QTs58Zfn3wsqUPBV0DXWMlM5ARW5EAofW27gLXfLrGyUcHz9mWByGRhoj/gSCMsqY6JBcCio8fkaf31vaZTHkm3QjQ0h6i8GhumHlyNdFV4xlyWruUGF31ZcAy3ivUYrQK3ubqIwJfuKN9NaZjoGsWXri/2E0g09oaEc3ZVfTx7t1JaYVnSrQ2BKKz36Cb7rXual6kVSogTvEPHGe4oqMXB/LAMq85SByNIF2Jp4Qu3D5zt9K7W2CUXJd+JuA7g1pwXj2ZPVGIndWC8cLdhG2KylojKaQbQ6HCaNJkzzR6U5bIi2gm5kvVt2VHNDPfZq3fHcOpV9ZTvfH3GVC/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsaAgJ5tZSvkuFhmAlE2Z3UKP454Gb7eRVIt+eEiIzU=;
 b=As8CM8HDGXDsam2rjUp2lrBTzy/s257YKozSz7Fac7lbu91+cHl12KQgJy+Io5djQEHMkGmTlNsTkLh3uvGK2rwqWaTu0lJQx/hd1sAXV+s4tx3F9Z/sjoLLm6zKx8f1aIC82FTko+soigMBd6Ls2HYXuBTSkT0kjXlMvCH05pZtZM0AiRdsCKnR6wsykk5k7jjTCyrCpkDzdzsEAG/2PF2Hz2salvO0ukyzVcLS5cKrsYHUM8C0PMt+xbynNEiXEgdpLytAeKITHK0UtltaCE8ufOxhIBlOvFqzH5bRJsTkm4f1x0zYG38tyzh4TjjSxJ/QAf6NOdxyI8rKhBrOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsaAgJ5tZSvkuFhmAlE2Z3UKP454Gb7eRVIt+eEiIzU=;
 b=SGTHw7J3N+g+XnRgHIdq9qoIgZKrEx82O9cIR6cVGdcYeBRmIzwb8WOlRuZP1/7WKoJgLOovhvXprXoXGNyOSBNHtq6Cuvwup2QpVBouZac+WCM4h7ZbnZrmSupQQ+a4bgex1rXg90HvRmSBP1lgi5q59kkrMs/zUcUUO9Ix+ykGy8WB1Im7aWJb0OB1L065vBxKe3qVq7zpFO8hXwteuFSi9C1FJggq4xzQqIbLXyWQE69w/ZP156fUyM9dATFvLBAdDnXPE1vKJMvT+vEb/P4XZ4/TXMz7Vg1e8LUbex2pS3PrTGeQeBOYeQrpfgSnFddvD6i/0zqqnFWQhkXOIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 15:49:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:49:23 +0000
Date: Tue, 5 May 2026 12:49:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 10/11] vfio: selftests: Add mlx5 driver - data path and
 memcpy ops
Message-ID: <afoRgOne96fT3zk7@nvidia.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <10-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkghFm9Vo-SfF5c@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afkghFm9Vo-SfF5c@google.com>
X-ClientProxiedBy: FR4P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c289e3-1509-48b5-f9d1-08deaabde0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aIl1RkMwVwRQ6tTIWPPLfr1WdGoWEv5i0lH80i1Qw4A+ukfMmY03dIuQThPnBhO1MzFlHLdtHHtaRrCxBLEmNKq1mOSHqPDfCh+OpRVDWBZ8GhvDQoVNexpwAcZzwTO4BlZsXysY0ntCamdMLq9VbSa28kxi5dGnRfAGjgr30nmdewzRcqHA22oHKaQ0om9auRp30AiWcm84iNIg0ml5bJMPivTJNWVvMuuDTw+30lpgK8hhLAGrqrcM7E70Ii+nwEdTpBs17S6s8chUnENXTLMYGfout68Of3zQSXnVlvPHTUXjCtVhovkodf1LffgVSvBqSJlm6evD9FxqAPgg6dBw1oZmh8/Skhqu3ECl6K5m5RXQkil8odt4J/QLqLROgYbRCuM2K2ZICJ1lS3FRXlRCwyB4NPLC1P5rMnmaUFHiAAiB4ZrTYJ62auRsav97LEDArPO3emsecMhd84mJsOeQo7FTJ0nDlps4J/bzAZfXDvMXh/jdkajIvDXuQRMHTgWDKxhr//fLHdeHxLjaCP1QeTGHMtKHbvEYNmFvV7ObNphZedGLTO2yYbbozbPTOJM14lM5Uvwa5ZjKrS/j6GtouHoTI7DLo7NFoRKnbUoz9qjjzJ3BAPnQ3vRPfP82e5R80jEMBpJhjMYhWRt4iJlE2Cxu+r5YBhyG254pD2GiHYj6wR91cZopKx5JS1E0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wQIS7aSUn3HyL5nj7+Kdr5fL6yUill4Dxxp7Ppmz09KoAdywlF5CuQdtJtid?=
 =?us-ascii?Q?ey4huiE3IX+YaW6BVteOjPFCExYuoyYjNZwwBHeiVIrvGPmhHb5Do3FXy9az?=
 =?us-ascii?Q?wdtsC9SFUq3Hc/tYSfuOKeYy5SZoclJrvaiVF7g9akouiaomF1f2aFMqF175?=
 =?us-ascii?Q?WmGO0e6V/ey+0Nq9wa0Jf+AF8ZprUkaTWCHG2TXLmLdEzLCDZdRC7ctPyY/n?=
 =?us-ascii?Q?Or0t+EyLFhfjGVgcrC6wVeRSV/RusmMRblANXlU6N11eSK5MMLbelVWLfSE/?=
 =?us-ascii?Q?pIEBw/Gw8iyQFcPEpc9Hr4dChqoDINCh9seNI59SzVR1oH2PP+MnSDXzHRPm?=
 =?us-ascii?Q?/mc/OCkLorl5m8x3YaGlsOdlGKSsbsc9jCmA06dDkad5LcOHT2x22T3vVYXr?=
 =?us-ascii?Q?66wDteTNzC7e4jXDjg0K5xMGdQ30bzUHHJe61/awf7v/PBe1NfNVYtjztzz6?=
 =?us-ascii?Q?TRSnkIdtA8zAPnxoZdx8la8K9vX2qXDd+l6yvO4vxjGt0dGTQq3LuH3MGrFC?=
 =?us-ascii?Q?fVbEWQ+GkE9/K6ad61BkH2t7Zop8340xexbeinzsyB+roqarUDvTphak56uU?=
 =?us-ascii?Q?N5RnF2tNDendg+Ul4v5N2qD5HBNEm41dQxuW/GRkTDutyh8HxJdr7RJzC5qK?=
 =?us-ascii?Q?OBi7xS0ongC6XwkgXeZ2UnQ5Di6Q/AmawDVMoeOy6vdWds4kdHqu8DGymEFs?=
 =?us-ascii?Q?WlcuOlgxQxV23TZfABRFhfHHuLIFrlgbFJpSvbhLLBkIUa3kScyuk1zG7Yun?=
 =?us-ascii?Q?o7OcvR5Q+yuwvsFSJ/1UU47I9Y2m1LCvreGOruXpvBycG6wZuXSqpspqiBEK?=
 =?us-ascii?Q?qZjw7bvWcUW4s7kwP4j2WdBa+Chrz/gGJ3VxCQPdQKbgUMxRWWjEQgMGa8f3?=
 =?us-ascii?Q?Dh0/UeWv2VxAqyTUaDb/BVFK3cFxlE2sOQujE4BlkrpIk0Y5nepAR6XNehFw?=
 =?us-ascii?Q?rwkJD+FsuwnKFNnnroG48xWMqD4y9DCo7tH3lL0bxa1b3eMglYnsvQoFU0Wn?=
 =?us-ascii?Q?7ScY8dD0F6rYlelgR2g7Du5MHVc80mvfBwhiq5PT6hzU+pVEkZ6+FbXEcMtA?=
 =?us-ascii?Q?UHr15sb4RqE+afixH/Yk0Tp8+x/v+w7H5K4859Cr0jOXzVe9Z4uaWeUKKSmS?=
 =?us-ascii?Q?0u659t0zDBDEXbDM6dpSAKSBFcOdJCdn0d1jyrbDqn2ZHxDq3OTuaPeu306U?=
 =?us-ascii?Q?BgMBlfLqaA4HtQqPa4GqyDYKgHrJKM33M1rtmrZnpoo0JTnWpsUxDoD6bFbB?=
 =?us-ascii?Q?AmEaaR1dtjjFkCxjMkBcFzl81F5Wo+sAVMf0MUKEutwdZNfRfKDzWzSWAsNB?=
 =?us-ascii?Q?glPxzz0hmOqib9+gXOQJHepSOit+CZyDoLMjRXeNyseTiIH+OZ7byePUAYNx?=
 =?us-ascii?Q?izbrV4ee5kCJ2lLxaAlI+pfHGACO3lsWg9ynTN9w6BNuJhEbm20MuxF1T4zp?=
 =?us-ascii?Q?s9Migv45MiYlCUu938JmpeEOOaeyVZuTB23Hu9t2e+Ve7oKXWkWp4URL1ifT?=
 =?us-ascii?Q?BWzqj0uQzwT+NgqxUJXdjMz5zV6353Z4Z9TEp0wFKDkGXmr3e6+flF59CL8k?=
 =?us-ascii?Q?V0wI/jFm2v+/ssryabqSWfgoi6we8MPFWBBWHegYtaS9f8E8J/DHa4Tpkg09?=
 =?us-ascii?Q?860ClxwiWLuGyvOLNUDYQpIk2brAIZK4LngX2h+Fs6Rwt87U0K5GgQs7mEoi?=
 =?us-ascii?Q?jKR893iyuO+KkYcE2N2fY2MQJ35y1L0GahaHsL4aV3FO/tpW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c289e3-1509-48b5-f9d1-08deaabde0dc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:49:23.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+VtmpmQdrSZ4jO6jhzS5z7pGDjPBt0brZiVi4Ml3d/Jv4CI0DkvX1fam7ptG7w0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
X-Rspamd-Queue-Id: 7B6154D0C5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20021-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]

On Mon, May 04, 2026 at 10:41:08PM +0000, David Matlack wrote:
> On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> 
> > @@ -1368,6 +1716,11 @@ static void mlx5st_init(struct vfio_pci_device *device)
> >  	mlx5st_alloc_pd(dev);
> >  	mlx5st_create_mkey(dev);
> >  
> > +	mlx5st_setup_datapath(dev);
> > +
> > +	device->driver.max_memcpy_size = 1 << 20;
> > +	device->driver.max_memcpy_count = SQ_WQE_CNT - 1;
> 
> What are these limits a function of? e.g. Is the 1MB size a hardware
> limit? Can we change SQ_WQE_CNT in the future to increase max count?

I have to check, I don't think there is a small limit on RDMA WRITE,
and SQ_WQE_CNT is just a number it could be somewhat bigger.

This may be a hold over from an ealier version where it was trying to
make a PAS array, and the PAS array was capped. I removed that but
would have missed this.

Jason

