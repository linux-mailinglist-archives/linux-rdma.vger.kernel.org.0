Return-Path: <linux-rdma+bounces-426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1EF81402C
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Dec 2023 03:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1D4288328
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Dec 2023 02:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184F381C;
	Fri, 15 Dec 2023 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZzbnkpVT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA5EBB
	for <linux-rdma@vger.kernel.org>; Fri, 15 Dec 2023 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f8c1719-2ac7-45d2-99a5-65a732adf299@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702608370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e62/UPwTCq/WeGbwMi7fzunn5DcATJ+YhRpMZa876ts=;
	b=ZzbnkpVTe8sz0X0kwiuFO0fdgWgpGTQgK577C+mnNU/p2+MaaBl6g7Ok5/EB951OO0Ev95
	DlDcQ1JNpBYJVwkESl7IS2QDvsz6agiUAtC9ZD978XPeuCtXd/WR6iPceMuxT5fjGdIQEw
	uUIKqRvQgBlAwzwJhZNQkw/WWj+HgjQ=
Date: Fri, 15 Dec 2023 10:46:02 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v7 0/7] On-Demand Paging on SoftRoCE
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "leon@kernel.org" <leon@kernel.org>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
 "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
 <20231205001139.GA2772824@nvidia.com>
 <d639b4e3-e12a-47e8-9b03-2398b076fdbf@linux.dev>
 <OS3PR01MB98659C7691D5DFB98D98D2BDE58BA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <c2414371-d638-4ac3-9658-30a07bc514e0@linux.dev>
 <OS3PR01MB9865474CFAC55AEB91D5A502E58CA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <OS3PR01MB9865474CFAC55AEB91D5A502E58CA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2023/12/14 13:55, Daisuke Matsuda (Fujitsu) 写道:
> On Wed, Dec 13, 2023 3:08 AM Zhu Yanjun wrote:
>> 在 2023/12/7 14:37, Daisuke Matsuda (Fujitsu) 写道:
>>> On Tue, Dec 5, 2023 10:51 AM Zhu Yanjun wrote:
>>>> 在 2023/12/5 8:11, Jason Gunthorpe 写道:
>>>>> On Thu, Nov 09, 2023 at 02:44:45PM +0900, Daisuke Matsuda wrote:
>>>>>> Daisuke Matsuda (7):
>>>>>>      RDMA/rxe: Always defer tasks on responder and completer to workqueue
>>>>>>      RDMA/rxe: Make MR functions accessible from other rxe source code
>>>>>>      RDMA/rxe: Move resp_states definition to rxe_verbs.h
>>>>>>      RDMA/rxe: Add page invalidation support
>>>>>>      RDMA/rxe: Allow registering MRs for On-Demand Paging
>>>>>>      RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
>>>>>>      RDMA/rxe: Add support for the traditional Atomic operations with ODP
>>>>> What is the current situation with rxe? I don't recall seeing the bugs
>>>>> that were reported get fixed?
>>> Well, I suppose Jason is mentioning "blktests srp/002 hang".
>>> cf. https://lore.kernel.org/linux-rdma/dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u/T/
>>>
>>> It is likely to be a timing issue. Bob reported that "siw hangs with the debug kernel",
>>> so the hang looks not specific to rxe.
>>> cf. https://lore.kernel.org/all/53ede78a-f73d-44cd-a555-f8ff36bd9c55@acm.org/T/
>>> I think we need to decide whether to continue to block patches to rxe since nobody has successfully fixed the issue.
>>>
>>>
>>> There is another issue that causes kernel panic.
>>> [bug report][bisected] rdma_rxe: blktests srp lead kernel panic with 64k page size
>>> cf. https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/
>>>
>>> https://patchwork.kernel.org/project/linux-rdma/list/?series=798592&state=*
>>> Zhijian has submitted patches to fix this, and he got some comments.
>>> It looks he is involved in CXL driver intensively these days.
>>> I guess he is still working on it.
>>>
>>>> Exactly. A problem is reported in the link
>>>> https://www.spinics.net/lists/linux-rdma/msg120947.html
>>>>
>>>> It seems that a variable 'entry' set but not used
>>>> [-Wunused-but-set-variable]
>>> Yeah, I can revise the patch anytime.
>>>
>>>> And ODP is an important feature. Should we suggest to add a test case
>>>> about this ODP in rdma-core to verify this ODP feature?
>>> Rxe can share the same tests with mlx5.
>>> I added test cases for Write, Read and Atomic operations with ODP,
>>> and we can add more tests if there are any suggestions.
>>> Cf. https://github.com/linux-rdma/rdma-core/blob/master/tests/test_odp.py
>> Thanks a lot.
>> Do you make tests with blktests after your patches are applied with the
>> latest kernel?
> I have not done that yet, but I agree I should do it.
> I will try to take time for the test before submitting v8

Thanks. Hope blktest can work well with your commits.

Zhu Yanjun

>
> Thanks,
> Daisuke Matsuda
>
>
>> Zhu Yanjun
>>
>>> Thanks,
>>> Daisuke Matsuda
>>>
>>>> Zhu Yanjun
>>>>
>>>>> I'm reluctant to dig a deeper hold until it is done?
>>>>>
>>>>> Thanks,
>>>>> Jason

