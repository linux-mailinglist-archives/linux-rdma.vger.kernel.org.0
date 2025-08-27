Return-Path: <linux-rdma+bounces-12948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E8B381E4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 14:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7D63BB6DF
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 12:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB372F99A3;
	Wed, 27 Aug 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pIMual0p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45C156F20
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296304; cv=fail; b=b2A39UkHvLmmxSnh7hGbao3Y0dGMpJleWVqh4LemsNXBzUstVrI6P22B8D7HliBtBrqJD4sAZAuLUf9JwWhRj1Eh7RLXvlHDFYDL3wYQ1CXOCo13FG4r16aR4/fMVxDXtvwTmlYlTNLjPi62TUcCWUDljQGa94oEY3QdASwEVOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296304; c=relaxed/simple;
	bh=U90NTo/iXf28Ood8595nuQ5PczVmS+CdSAxheEC+tkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jTeaxKUPsxF7aoNk1P5vK6i55sBk2Am2/BqEwEYIbz0YunHFKR7wnU85QnvI4TAwiCQwzHj2G9q5VpYpJB2jUA8e05n4wqTswq6cSfLPGaFvabTvh00u+X1sBzcvgQxl3SSSgVTiZh6e8hU7OBegzli1Nml7PzYqJgI+qzMmZnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pIMual0p; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf2vA/MMmiX+kqKcoviNN0BwXybRJDWYsKGrH/LetHqhhYoj4b1Jkix1O5BLqRhrXpIDO6VrY2Rax+3ApQXf9y+SHrXT835j96QFJki4eqKXxN45JKtuKvw4XOHJTB7Z4btAgloHoiXw3Bju+nkO1Pl0SlVopmCeL1kkTYMVmWzZ9DX681MvwpV8y9hSVScbcuqpf9A2x3qBWktuUeIC/EBR39fh0Y1qs34jMLq0HV55ntN2W6FtwxEvqfWSnmY8E1MXH/ZoZgXPebEvL9j0GawBhFKJhng7inKt3ds8L/3hjigo0h4EBUJPYxDvbE6eCHBuONJJXR7NohNwlQzvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRyOktLBFa2FGgG8RtMfeDCmwUGC8J2oBovoZ8hQJGw=;
 b=QJkjCcxkx76aoTnFuIYG5SGUZ1/2IGneMnC/X/7XWIEbprQuvDBGNVUXnOOh9oPgheTFuwwbzNNhp/Q42TTbmMaRu8k86EfdC39RqFN3+U+HjzL33yL3p01EkKPP1UrUNexZQjrUHPcjQwFz4t3tIWFMTnp1v7l7DiO0L6nyn8hEBGWuqx3hxk7yvDC5fsuoVqzjih2vMg3Joxo8MdNpa+P+atFsH0G9sYPCI9Ns03ozD4sjOPyuwUG1nmA+rjUU9tlEhpHEhSwMXuZe6gr+2EO0klS1qqKsdQAUXjvA5YfopfXNWShpnAFgi1KZl/EpLtLcCK6uj5e0ZRh5YWwLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRyOktLBFa2FGgG8RtMfeDCmwUGC8J2oBovoZ8hQJGw=;
 b=pIMual0pEKDqhtRZeQtCmNgJF62dHiJKSBJM3aDOG4HnydyQJSYrO5gAVUxa+CLD/vxAKgEwy2sXdsiBogaEXkIHugQsu7K9EzQ0B9jvj31QqBpmYV0AZwjgIIlnp2tZLdVYgfhhx8fTXIgy76iwAwrl5vB+348MZjDpbHo0WTfKB9AgDqwMHZDlfAxVB3Uz9vtPA0WS9u7oxAF7kg9A07htbp7bU25Ti0mvDx+NTqPAZRzPdmBmGZrFlV0F4gd9GhlaXRtu3BoYIC1P7txsb9F7dfwB/R/IIiU4wTOFmg/Lo/xhfAf4JZ90Vt3tyy+yaCY+noI7gzVaOnWK/bXTeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 27 Aug
 2025 12:05:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 12:05:00 +0000
Date: Wed, 27 Aug 2025 09:04:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	yanjun.zhu@linux.dev, philipp.reisner@linbit.com
Subject: Re: [PATCH for-rc v1] RDMA/rxe: Avoid CQ polling hang triggered by
 CQ resize
Message-ID: <20250827120459.GK2130239@nvidia.com>
References: <20250817123752.153735-1-dskmtsd@gmail.com>
 <20250825181053.GA2085854@nvidia.com>
 <a59640c4-f166-4a7d-9da5-f8318aadb394@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59640c4-f166-4a7d-9da5-f8318aadb394@gmail.com>
X-ClientProxiedBy: SN1PR12CA0094.namprd12.prod.outlook.com
 (2603:10b6:802:21::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f51009-abd0-4caf-0a93-08dde561f2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6UvRwiHz0ZNiVAstEejZXyrm6RcWrublqsACmWHxHII5MiF02c9jVy+odTlx?=
 =?us-ascii?Q?/rLHwMfi3kJwQmIYG1BWxJiO8Emfw21/cwxIaTm3b4r/oUoWT62m0pk0rq/t?=
 =?us-ascii?Q?P9LOKqCcC+/r18Kzn/4XDx4zX5f3C/iCl4l5P4I4q4hafThLLQ5mmZKfnMpd?=
 =?us-ascii?Q?9ZgfCKYyKMTelEzw88s6SaodXFMuR7wICO7FNjTD5FmpvD2pR0/TYfxgPlvK?=
 =?us-ascii?Q?fZZsMvXMuXoBYAFqV0lWVwLJSpJI5O454DLYuxNyaYBvuATn32ToFlICNYo3?=
 =?us-ascii?Q?QsA9nHDW9vq906GAWeJSRUmEoNrk/D/43/Y9G/+IJtWUHBc/wzBRON3Y6Tmd?=
 =?us-ascii?Q?t5/BL711Gnre5BlEnP0wlFdCx7TYyNXJy4eiZ/3Mn3YrvmfADHI3ucQTHUiT?=
 =?us-ascii?Q?einC1usRPesNqUlkubNy7UesUq12ckSfHwy8ZUZh3c4orPb5rFosohhFerbO?=
 =?us-ascii?Q?Cf1XDhLTE52k7dxuPUgyA2BwhxaiE15W64FVy22WLvrq0BmLcgEhOvHcI5w4?=
 =?us-ascii?Q?rxRSmZT0A996GEY2A5gPXqWszFCv8rLb+x/Amhau6uL9GZw+/4yc4b7p1slG?=
 =?us-ascii?Q?523glxDaYWiTxktZcfT7GMK4p84bAhd4R6klY5+0F/iKbRtpxFASu6UHHUzx?=
 =?us-ascii?Q?OxSk82Pm4YDjQ/S96O0EJqpxXGmDaq0KTpFvAy+RAIsPMpA9GNXIJAbqU/wJ?=
 =?us-ascii?Q?2m77Os6de4Y8b68hP9n7vSEMZTsOrwuikCJSTF2fftnkNgewls7gqYydHuCZ?=
 =?us-ascii?Q?bAqr3hGe5LVUHUqfmG9FPmXPq7IOKU5MMozViL0aXj1vC+x125XmDkG+SgDt?=
 =?us-ascii?Q?F6hQAVKXrEveN29qYz4hSbYavf9fP8jOLzueHboO4ZFcs3Zki8mCDq2AZsms?=
 =?us-ascii?Q?P/L7AMQdza7YOqjdxcNRpStmeg+eNIxE/BppIlt8PNJ805Tm8jjDNz6h8x1J?=
 =?us-ascii?Q?IpAkzjnv6NLxwzqOve9wFxG7/Xk1BSd2ae9hMisB4Rx5kn1RRLFIbWt7SXPy?=
 =?us-ascii?Q?jsBtTLrkmjyfqpsBsiLRmRBiRsxOW4MUGJx+RfbLnH0Xo1qD/YFksr2o0lv/?=
 =?us-ascii?Q?xSBC9jnu2qxhckT6WTdKaFEZJ/JQUlXWL6j3zjdLQyxPdAmPJ6oLv5FeqYVw?=
 =?us-ascii?Q?i2aByChUQ1dIUOPjWuOr33/jh3B2+RvK/0KM4RkUvFA4k39nUwmN07kaqXl8?=
 =?us-ascii?Q?EqBZPy2akg7+aeSvy+KsuX2qLV6G0Lmv7wTw7gAg54K2mHHm5vkI2So5FMUa?=
 =?us-ascii?Q?/HpRGUAl4z5S5D3F/a1BmLvyeU4tbplhDRXqjV/xtHVn0PY7NytAwP0w0wYW?=
 =?us-ascii?Q?Tb01eMIJphp5SRv50wRMTBZoS7ndm/aB9fEawzN/mlTw/ArD7kY6KQm8X/tQ?=
 =?us-ascii?Q?seC2kc2s5oCOkCydVWaJU8UQ4qTkbDPGZnQA+x7KOcrcnr+08Ut030A9KS2R?=
 =?us-ascii?Q?Nj8dNc0nq8I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/tb5AyE5/S0ISnB2qVSTvV7Rydh8+jlWFX0cCEW6C8Xe5u782NCFISrHjp+b?=
 =?us-ascii?Q?xVGhSXCvatDgPy3htmF4te8m1u9PNbv3Ys4lBAWmcgyN1IG5AFiBW4YdHK2o?=
 =?us-ascii?Q?FWRxNfWkP4YikqYWotfvdYreyKy/wfrnem27CT9dr1h0Cemm2rxIPJJNRa7h?=
 =?us-ascii?Q?P5aDdkEUkx02QNnchfFYEC3B8I7zOd5YJMa5F5qhoLnkMZBvJ/Am9Mj0bqzn?=
 =?us-ascii?Q?UsVEEY6ncJK5EzW4KsVs+J8+rMueoxoQyPznHt+XZ4OmHHS3t4eFBwmgteOJ?=
 =?us-ascii?Q?r4HYrns282VlVHvnOzrB6Sw9xC7b38drDEk2i2m636RimYulRmjH8yev+pC5?=
 =?us-ascii?Q?Lc5910TrMeClelccHX7/HYLbGtJiUQlW+B0ipvwBiBWpfjmqCbMXOZNOjf5w?=
 =?us-ascii?Q?hj9aSoc/t9M/CCOxCDN0ctJE4ikQHC8nQDqTvy3GpOTxVp3MgZ+tBSRtDFSw?=
 =?us-ascii?Q?4ZLrWmpExhPs8mIS0I7lncuIq08GAGZfjxOGnri/Bed9Az5fSIq7eChOG+II?=
 =?us-ascii?Q?8SSpK/QmIC963m0foVAlALVK4tSSyabKUg4kPImyxFjUzswZkFzGdoWczCbl?=
 =?us-ascii?Q?uEJcvpRecyvCWJfFr1HoFJisyo0ClY9mTLB+4O/sljEejs8SMEDCuDEklQGj?=
 =?us-ascii?Q?PIbIDQV3LATXoJUtnAGhI6ZWjOqQKOhlBD2bhzTSLyOeiYsM07qTu9vbaZDS?=
 =?us-ascii?Q?Sf+uGFsevRJsqs5hPaqrOW5WRVzHcGv7ZkM7nOeVckqDlIY+PyRK0iL7jqf4?=
 =?us-ascii?Q?zGw6KAZR3IzeokMDVNoLb/2BNZEXjAi8oqDpxsqeu87pxetXnEJePEBsYa6a?=
 =?us-ascii?Q?lxcB8P1jx1NIGfnbeYa1DDvW0e6yuKhgfquGRvC2vZXG/bl//squ2iNcXs9Z?=
 =?us-ascii?Q?9amTJpBO7aMpu7gLvRKUGNYbwg4V72huskuHguT6DJQJVrRRBN2Uu24ZZbdY?=
 =?us-ascii?Q?aYS4G4Y2MIEz1PlQl7GwzhS+dkl8709d7FvTSHYHFxm9v+HJ7MDFfIOoFUz8?=
 =?us-ascii?Q?Wd9w+VmUJfNHmZrSUqYf5wAHGpLVkvNozab5JYSnt0qTXZ/AF83PRLzsC3Qv?=
 =?us-ascii?Q?jtZHnubib0yyeC7j3MRJ7OML2oR9J6/Na5qTxjtCT6DYn/eN9SLD2G01RVTJ?=
 =?us-ascii?Q?hLEfCgu+aLrRR3U1sz8rdy5KqxkY1n4bMk6slUoAK+R7eqp5PfwZt23EQ3dH?=
 =?us-ascii?Q?IOSI52D6+iJ1mWOGMDG8pWt6gAakauYc+6WA4KJCNIK339wYYAAQh2iyBQJK?=
 =?us-ascii?Q?wThZZBn1YOFURLRj9h5mKv8xFodflH5wV/VeVM6m3/KCvlzon2GNHUt9nfeT?=
 =?us-ascii?Q?hM2BrFveYDhIdBBw4fhupRsO968C3pF2lcYLPEZaWN4DdUpqNjueSxZE0lyG?=
 =?us-ascii?Q?Ezy0/L89Ps1BwwFCCZe8sVEDCWUcrx13WURhzKXjAXKxxxKvmbU9cyPRMivT?=
 =?us-ascii?Q?dfZg7xtWSAEkQ1G5KLVk2VUSjgMJPCso2ExD9XYAjExtjhtpzuIE+cDvgFLm?=
 =?us-ascii?Q?tgMsW0KPUuVq++pT7SYPjPV2R99L9pdraYGJ8+Ve+BrbvXpXHF9fAgLHg2s7?=
 =?us-ascii?Q?SHG6PvFutxtqMrtcQpP50bWqBMRXATa4NkXqbE/W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f51009-abd0-4caf-0a93-08dde561f2d2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 12:05:00.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUJ/H5eZznvV7Qgpdxtzzml3ADzJFU3QnEizq4AlgddQ7tX8/ZgWm3+OUYsXXHlP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495

On Wed, Aug 27, 2025 at 08:14:53PM +0900, Daisuke Matsuda wrote:
> On 2025/08/26 3:10, Jason Gunthorpe wrote:
> > On Sun, Aug 17, 2025 at 12:37:52PM +0000, Daisuke Matsuda wrote:
> > > When running the test_resize_cq testcase from rdma-core, polling a
> > > completion queue from userspace may occasionally hang and eventually fail
> > > with a timeout:
> > > =====
> > > ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
> > > Test resize CQ, start with specific value and then increase and decrease
> > > ----------------------------------------------------------------------
> > > Traceback (most recent call last):
> > >      File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
> > >        u.poll_cq(self.client.cq)
> > >      File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
> > >        wcs = _poll_cq(cq, count, data)
> > >              ^^^^^^^^^^^^^^^^^^^^^^^^^
> > >      File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
> > >        raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
> > > pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
> > > remaining)
> > > =====
> > > 
> > > The issue is caused when rxe_cq_post() fails to post a CQE due to the queue
> > > being temporarily full, and the CQE is effectively lost. To mitigate this,
> > > add a bounded busy-wait with fallback rescheduling so that CQE does not get
> > > lost.
> > 
> > Nothing should spin like this, that is not right.
> > 
> > The CQE queue is intended to be properly sized for the workload and I
> > seem to remember overflowing a CQE can just ERR the QP.
> > 
> > Alternatively you can drop the packet and do nothing.
> > 
> > But not spin hoping something emptys it.
> > 
> > Jason
> 
> Okay, please drop this patch.
> In a sense, the failure indicates that RXE is behaving as intended.
> 
> This issue seems to have always existed, though its frequency appears to vary over time.
> Perhaps the switch from tasklet to workqueue introduced additional latency that influences this behavior.

I'm not sure the test suite should be hitting cq overflows though, it
should have properly sized cqs for what it is doing..

Something sounds wrong.

Jason

