Return-Path: <linux-rdma+bounces-257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9429804447
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 02:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A629BB20B23
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE581870;
	Tue,  5 Dec 2023 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pb2P/HzL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B3E6
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 17:50:49 -0800 (PST)
Message-ID: <d639b4e3-e12a-47e8-9b03-2398b076fdbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701741047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/Ql7aByCzkyBc9Mo8qY8s+MUwFzsPU9axcZHcBsgXs=;
	b=Pb2P/HzLMJzVbCdffBXxcdJdG9S7trwdBJy1DwyDetgijIeDOp0EKX4qwHSAHo3Xpp8wRo
	GWTsFZfR51AQiOhLC0xCB/oubGrLShfD7e3bDPVRP3LZsmt16BTCXQT9uNW1svgfpKEe2q
	NVhoS5bQPHPnP1VRmXL6BCGRWQ6bhOE=
Date: Tue, 5 Dec 2023 09:50:39 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v7 0/7] On-Demand Paging on SoftRoCE
To: Jason Gunthorpe <jgg@nvidia.com>,
 Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
 linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com, yangx.jy@fujitsu.com,
 lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
 <20231205001139.GA2772824@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231205001139.GA2772824@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2023/12/5 8:11, Jason Gunthorpe 写道:
> On Thu, Nov 09, 2023 at 02:44:45PM +0900, Daisuke Matsuda wrote:
>>
>> Daisuke Matsuda (7):
>>    RDMA/rxe: Always defer tasks on responder and completer to workqueue
>>    RDMA/rxe: Make MR functions accessible from other rxe source code
>>    RDMA/rxe: Move resp_states definition to rxe_verbs.h
>>    RDMA/rxe: Add page invalidation support
>>    RDMA/rxe: Allow registering MRs for On-Demand Paging
>>    RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
>>    RDMA/rxe: Add support for the traditional Atomic operations with ODP
> 
> What is the current situation with rxe? I don't recall seeing the bugs
> that were reported get fixed?

Exactly. A problem is reported in the link 
https://www.spinics.net/lists/linux-rdma/msg120947.html

It seems that a variable 'entry' set but not used 
[-Wunused-but-set-variable]

And ODP is an important feature. Should we suggest to add a test case 
about this ODP in rdma-core to verify this ODP feature?

Zhu Yanjun

> 
> I'm reluctant to dig a deeper hold until it is done?
> 
> Thanks,
> Jason


