Return-Path: <linux-rdma+bounces-10728-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8897AC42C5
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 18:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730EF3B84F2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9B2226D11;
	Mon, 26 May 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mvfCXxYO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12342226CF7
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275703; cv=fail; b=j/Mv/Dp/g7a/BnH9luMTuZnfvwiZyV5teBfkhG9dtLFXpQSoROScKVnoP1WS8EXhMUPC1hsOYOZl3N90cuAg+Lt6aV8MrgbnsmtnOKji0goX/2RXEX5D8Vgr58H0PzrJ+LGdYQHKqA0ye11zxX69Ag/v/ZwgqBbOVAxSJdcaNrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275703; c=relaxed/simple;
	bh=ajmHKlY4slFAosHFAP0T3e7+znC/CcDF1i6ExPKWjBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=goIumK36sGMBO6kK5SPnWMYRyAASO2rDV+ItbyQIlt1JLBJox+iTMVuSGdV1C81OOqy248AkD8hX9/TnxzbDUZcxWchsUBgEPnVgV+ZKzbU4mAsxxC6hO+N6/B0kvEA3dpryrce1XiH1F8ll6H+1TzruQGn01FpKnzWHDNrxUrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mvfCXxYO; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZWOZvr9EL4bTRJSaaZtx0wEw6d4B60ME0/jt2R88GIMNsEo/hM1dTVJM6k4Ito0LR1zpLzhPxmeNnnqK3JBuplbXlt4Xwu6q8EunP/i0dCxCQUQEaTFlhrDxMR7OH6+bC5w7fyxJT0Vf9ik17Tm3zIftIEHpJFqWyawKNLFwNsplmaMR0X7TmB7WRq3hmJUpVwRQvqOZ4OmNRqVvl29smqOWhlbCvpsAX7yZQxo1YGjqRJRoOdLPQbOMYacbGsX8vnmXniMHFwfv9grGVDmfPJIYIBObVUuW2ujhCnuU08DleRr+fOWoXztsZCnokAyzg10QR29mN7I4I2wpFZchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajmHKlY4slFAosHFAP0T3e7+znC/CcDF1i6ExPKWjBQ=;
 b=Y6JHazmMszUVfbdGIZXTEZHUQmTTHSsFaNS48C565KhZZMLrmOW7uBwDCw89gZrpxrqJW9U+ZYWPzsXlu+57tjHguh3ryEsTRiLeLSeiv6xgs4JEI9NcFMg9SYB712F72UE4zqEbby1yOgY2S4ntevJ/zhqBNMeVfLglyBNQihDzq1MAcLV2iWZsyCOwEiQDd/7TxQnHRfzOZJCjuqnlwuvCPDJ5EwwXAKO9lY5L22+h88s7n8SMtolGqIhRgtm4cau2iQnlkm8kF0pemP0Ps+fmmQjQrCHUrWztXTJzNHCpvIfITMRJKYRoYvHKK5m8+vupdzZRS0MXE+w9a1iHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajmHKlY4slFAosHFAP0T3e7+znC/CcDF1i6ExPKWjBQ=;
 b=mvfCXxYO7IwiwjOnSZZ8f8OYYyjpCB1Fc+ssE14JdxZBUVnKXrWUQQ08Zd+4EwcqiiWDUvKfSLVM/nbR49jNR3jWYk6wWNEP5sQ7aBP9Xmic/Oe4ave+JSqHiI5ntYncxjiSBxHmliIT4Xav8aWUiidI1GjIFdyDIdn/ZTnrpfLoselnbzU+JNgmPBaitrcdVr88EeZiI27Se0f8cc/kbbo+caTx2Sp2txIMmReK3nmPKlWSv2IWSjf0910ZQXMAfijq81JcKUe1O3r61MO1+1denBn5Ap2NcGRy0wpK8ap4vGA6e2CD/WPd2qq31oWb9YWkqcStBkJv/pm98CydMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 16:08:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 16:08:17 +0000
Date: Mon, 26 May 2025 13:08:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Message-ID: <20250526160816.GA61950@nvidia.com>
References: <20250515145040.6862-1-mrgolin@amazon.com>
 <20250518064241.GC7435@unreal>
 <985b77cc-63bb-4cf9-885e-c2d6aca95551@amazon.com>
 <20250520091638.GF7435@unreal>
 <9ae80a03-e31b-4f33-8900-541a27e30eac@amazon.com>
 <20250525175210.GA9786@nvidia.com>
 <5a2c3ffd-bdcb-4ad2-b163-3c1db7b3b671@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2c3ffd-bdcb-4ad2-b163-3c1db7b3b671@amazon.com>
X-ClientProxiedBy: BL1PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d854702-a77d-4723-8079-08dd9c6f867e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fHRTU9GElMlce2QO4x4vWCq/fF4yLNlmvRachO8xJRoLIfyasKciKJFSvNeu?=
 =?us-ascii?Q?cCmhN2FiZ/AYRi3v9JOEn+ibNDqG/UShK/EpHiseae07KiE6Ovkyi6K+gp2I?=
 =?us-ascii?Q?SxMGjlBLjg6iS4RGXeLPrVGN2/PjT3dtTTOQJ8etNWkmeG44426Gsj3pfwZb?=
 =?us-ascii?Q?C5s8/Gpkbn2w8mQbefIgt34Yx0W3rOrgq7IxDJ+rUKmr3mw5DZH+wD6Sip7k?=
 =?us-ascii?Q?T/GQnnQk51jVOkApnkz9zl8P/2RMEakR99tw2mRfuljXpt0fJAS0xeV48vGT?=
 =?us-ascii?Q?yrshR8rgId2kCmGkOSNAiZRwzidKbazUvNgH+vAdA8NKWrAKq1Sp0obt3rp8?=
 =?us-ascii?Q?e351/WRJzCs7YT/ieZL+P3WRt4mVObTTqZtEirLlL6bGo9IsrKOw7nde9qQG?=
 =?us-ascii?Q?9Bm+zgZpbRhKhTZIVE1IsUyh7e/RRsw7IS73TSZxhpgnIl0GYm7Ng37fgZHV?=
 =?us-ascii?Q?DXzsyrf5zClNC70z45MOr7IqRbq88ysSPsTo3ZxCgpWikMsH2G6V8VDtgu6S?=
 =?us-ascii?Q?9hRl0rH90zw9TtAlKv6IDhKsr1bmfzUUnuw8OQX1rAKg5txIl8es7MvV+rO8?=
 =?us-ascii?Q?mayuspDsKOpUv5uSxLruhQOoEeNDKNWUTRslCq4smRlplzIsVYBR9JEdRnKV?=
 =?us-ascii?Q?n1uWccQuCc3FtbAhf7uQyrSt2lE7aS4OwMmXu2EHAld3g9dhJrgC8Bt3ig3f?=
 =?us-ascii?Q?cTy0t5EBtRXu8HggmAa8yw71/9Xp0NaYUgd34q2EysyKUmrxGpKZED4Btf93?=
 =?us-ascii?Q?+R+X0QWIY7K0m2pwQR5gBKn2c4FHBAhsaz647vxOzEzKnotTZ39vVDNxUR8+?=
 =?us-ascii?Q?aTFpy6YSx0jAmj4gK5iUV3pVhw/hBgOrycNjh67HGjKvTw/22LNTFsv/6AWi?=
 =?us-ascii?Q?SwCQHUWCFVi0c6cFSZH23DSiRbKEYfmBkz9Vb5MksWsli4TBO+9Y1Q1js4d7?=
 =?us-ascii?Q?XTU+FoCx+BkKZkX6j16we556sITpeDtkYKH3v6p8Mi4Z5WrwrzhsGvyDPrUI?=
 =?us-ascii?Q?abINqLkaad4xn4AGiCgT25AHsAWrvBMq5J1d79u3SgKJn0fh+mVMZPkR0pH1?=
 =?us-ascii?Q?nx7Erh/1aTinwCNSfGIFLOXwj1R2VDht67YG7F1qTYdrfzDFr6hQLvr2pkod?=
 =?us-ascii?Q?84c59mgP1gH9sjyQZkqEZsAgyZXHjNLKCTgWHNI6NlKs5ZGnklop9bo83jXN?=
 =?us-ascii?Q?nIT1G2kXZEXRsMmMQIDH8TAj7JMSXGE3Jr1hjUWeI/2pGNcip91g2ULxCrIi?=
 =?us-ascii?Q?24Z7eA9uwaZJk9eiUAJaz7hb2IFJo+Mvj4ZYDwAxv6IWYJW2lvs02ukJQ+rU?=
 =?us-ascii?Q?SHVOd0jW5Nusk2cftzIatt8lBUkwHQ9bW0Gv1YBOz2913VrCZSDho620uU2T?=
 =?us-ascii?Q?iWc243ofnb9E85p5NGQ6S+Y2QBUiVyfd9EUei2VlXVYgWJvw3Ml6QN5ZMQW2?=
 =?us-ascii?Q?Wse9FXIXadw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?66v+uPVlc3YGgMMM2UJUQrfrp3u1BQdICPzFj3WBOMKGd/l2ujjX7xpm2kRP?=
 =?us-ascii?Q?8GaBanq5DoOzqZy8XO9cOSc13JxYBhWmZcbBIi+pNchHuHL9G5U6n/cYGKOo?=
 =?us-ascii?Q?bQFQGwPxeI+2n+6hmIuqb42cNjz/8yWP0zi0UroqYwocaSOKzLJ85LlhN1j6?=
 =?us-ascii?Q?XHju4xFz4dz44Pj0m6swjWD+cVtOJTG6HdhArTwoYGCtWEllFhHtDlRXCZEm?=
 =?us-ascii?Q?u2lcBR0X8CvflRY5Iv3KSFmZAdAuvslvLOWuRv9V+t+GBEkN7pcYByVS2lNz?=
 =?us-ascii?Q?pI3LRZZsHgc5ILXH62wdmTVSXn+3lvzafg+cH1wyvbjNFVUpXkMTQMGnz5Zk?=
 =?us-ascii?Q?B0W22xMlYhNHqYB1h7Az44oXJAZLCWVj6t6PpWSE6Nf05evIx6mpJ1ARaI4K?=
 =?us-ascii?Q?I/LD/V3y+leqTt8/aF9gWCISI/uE4U7fUJQIqPryKiyTKRnv+CEy+BUCoQm2?=
 =?us-ascii?Q?T78rBO34lxK1Imp5dmBlBzD8GV/3g7qi80Kxrq5VNkORo7U5HbtNKfXu/JI+?=
 =?us-ascii?Q?LPrNP6dqgkHB/Ffatbs2AZEGKTJE3v2T32rzETJtQvqrQkcIkDe/ttTFIDa6?=
 =?us-ascii?Q?iBVIaoo0/nG3nbyAWzlybkkap7sTKk+zcF7UP7WioNWivAinKaKmzG5uiXGh?=
 =?us-ascii?Q?Dnm4gTtwJO1FMt4O1P0KfeQwPes0bC9WGYGofojYdRI0NgQOdKS1qNqbR0lh?=
 =?us-ascii?Q?Xtl1nY5RGCbN5i6ej/wG1z2bPQKHd/qAZaIRf+s80BTSEGCTpv8ThFvFlxB7?=
 =?us-ascii?Q?DPZpWJN+ZUsR7AwUhsId6yu391fYARg3C36Ol2k/GursAmjqaKd/if+qtv1C?=
 =?us-ascii?Q?tuo3IvXa44s/beoFRmC4bhqEZjbNM5qws7m3kctLJ9HDii3eTAThLWYF9NRL?=
 =?us-ascii?Q?81pzyEESwEPSgij/tpmnCbLWZquXtcnLehCCoTPVDiAx7+4ZclB7M8pxuSYo?=
 =?us-ascii?Q?dTwpLpq/CGk4Kdjevnbx1iEXXA3+9FYfb40pSzXTjdBVesaV/tBv3+KI4Xy8?=
 =?us-ascii?Q?I0fQ1llnm/S0sU36XfglgyTKDN/7Lxr02N99FO9O2Ms6VRW4r2yXecNDHQBe?=
 =?us-ascii?Q?vhK4pbw7Y0w1VUplQI6LtECSb9Lb25C185QDTKc/rvAruvg//x6iFNI5/peX?=
 =?us-ascii?Q?bObbZdEfnYTg88pLO2OFgk0Ui5KpTJ+gQV6ydsE5/cV9B4M/jrnDQmwyw7Oo?=
 =?us-ascii?Q?pq29rs+51+Q3ufTxsdpnLZUBVrfS7gZrZ82lJBv47+AfoXpupwY47GhpcDQ8?=
 =?us-ascii?Q?Aqh9sqrLwPG1/QwB2yH+k7ZUxLj1Xxmyzq5L9k4tgG5NRcbb3qaVbfDWuZyY?=
 =?us-ascii?Q?3Z5A7OHjximeT6ZO5Gw1LvYR6d40BJ8NP4B9Blk4GbfCwdacde1WX7HPP3nm?=
 =?us-ascii?Q?HExWOrXOp5hPgIXgvSTPayNaMqDvjGLfLSCA2a3InjCgLgnnEJdHbfu4G9c0?=
 =?us-ascii?Q?5pg5wfFBHtPcWdQKFXelpButcN67UM1I8jNqZreWrO9In/sOeeHBjNRHCUXq?=
 =?us-ascii?Q?97xUuxDWbIkm2j1vgMzIxO7QxN/aX0ddBeiBcTvyDGA6V4NSJ9Pak/DhDGS1?=
 =?us-ascii?Q?R+v85MUMHxui+WfVY0BOsaU17kXNgcO4Gg0G/1hW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d854702-a77d-4723-8079-08dd9c6f867e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 16:08:16.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1nZO1r3k7v0kisRudqx3GCL5MW5KK8GBDa21Hl/JKNJMG2QB0WHoqth2et8PcVR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825

On Mon, May 26, 2025 at 06:45:59PM +0300, Margolin, Michael wrote:

> Are you suggesting turning mlx5dv_devx_umem_reg into a common verb including
> the kernel part or some kind of rdma-core level abstraction for passing
> dmabuf+offset+length / address+length to a create CQ/QP function?

I think Leon was, but I'm not sure that is so worthwhile.

I was thinking more of having the ioctls for things like QP/CQ/MR
accept a more standard common set of attributes to describe the buffer
memory and then making it simpler for the driver to get a umem from
those common attributes.

But EFA is alread sort of different because it normally uses a kernel
allocated buffer, right?

Jason

