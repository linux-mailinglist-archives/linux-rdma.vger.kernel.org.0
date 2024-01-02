Return-Path: <linux-rdma+bounces-518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46265821B66
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 13:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB46282DC9
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE5EAED;
	Tue,  2 Jan 2024 12:06:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C0F9CC;
	Tue,  2 Jan 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4T4BQk51JVz1vrQt;
	Tue,  2 Jan 2024 20:06:22 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (unknown [7.185.36.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 510671A0195;
	Tue,  2 Jan 2024 20:06:20 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 20:06:20 +0800
Received: from [10.67.121.229] (10.67.121.229) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 20:06:19 +0800
Subject: Re: [PATCH iproute2-rc 1/2] rdma: Fix core dump when pretty is used
To: Leon Romanovsky <leon@kernel.org>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
 <20231229065241.554726-2-huangjunxian6@hisilicon.com>
 <20231229092129.25a526c4@hermes.local>
 <30d8c237-953a-8794-9baa-e21b31d4d88c@huawei.com>
 <20240102083257.GB6361@unreal>
CC: Stephen Hemminger <stephen@networkplumber.org>, Junxian Huang
	<huangjunxian6@hisilicon.com>, <jgg@ziepe.ca>, <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
From: Chengchang Tang <tangchengchang@huawei.com>
Message-ID: <29146463-6d0e-21c5-af42-217cee760b3f@huawei.com>
Date: Tue, 2 Jan 2024 20:06:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240102083257.GB6361@unreal>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)



On 2024/1/2 16:32, Leon Romanovsky wrote:
> On Tue, Jan 02, 2024 at 03:44:29PM +0800, Chengchang Tang wrote:
>>
>> On 2023/12/30 1:21, Stephen Hemminger wrote:
>>> On Fri, 29 Dec 2023 14:52:40 +0800
>>> Junxian Huang <huangjunxian6@hisilicon.com> wrote:
>>>
>>>> From: Chengchang Tang <tangchengchang@huawei.com>
>>>>
>>>> There will be a core dump when pretty is used as the JSON object
>>>> hasn't been opened and closed properly.
>>>>
>>>> Before:
>>>> $ rdma res show qp -jp -dd
>>>> [ {
>>>>       "ifindex": 1,
>>>>       "ifname": "hns_1",
>>>>       "port": 1,
>>>>       "lqpn": 1,
>>>>       "type": "GSI",
>>>>       "state": "RTS",
>>>>       "sq-psn": 0,
>>>>       "comm": "ib_core"
>>>> },
>>>> "drv_sq_wqe_cnt": 128,
>>>> "drv_sq_max_gs": 2,
>>>> "drv_rq_wqe_cnt": 512,
>>>> "drv_rq_max_gs": 1,
>>>> rdma: json_writer.c:130: jsonw_end: Assertion `self->depth > 0' failed.
>>>> Aborted (core dumped)
>>>>
>>>> After:
>>>> $ rdma res show qp -jp -dd
>>>> [ {
>>>>           "ifindex": 2,
>>>>           "ifname": "hns_2",
>>>>           "port": 1,
>>>>           "lqpn": 1,
>>>>           "type": "GSI",
>>>>           "state": "RTS",
>>>>           "sq-psn": 0,
>>>>           "comm": "ib_core",{
>>>>               "drv_sq_wqe_cnt": 128,
>>>>               "drv_sq_max_gs": 2,
>>>>               "drv_rq_wqe_cnt": 512,
>>>>               "drv_rq_max_gs": 1,
>>>>               "drv_ext_sge_sge_cnt": 256
>>>>           }
>>>>       } ]
>>>>
>>>> Fixes: 331152752a97 ("rdma: print driver resource attributes")
>>>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>> This code in rdma seems to be miking json and newline functionality
>>> which creates bug traps.
>>>
>>> Also the json should have same effective output in pretty and non-pretty mode.
>>> It looks like since pretty mode add extra object layer, the nesting of {} would be
>>> different.
>>>
>>> The conversion to json_print() was done but it isn't using same conventions
>>> as ip or tc.
>>>
>>> The correct fix needs to go deeper and hit other things.
>>>
>> Hi, Stephen,
>>
>> The root cause of this issue is that close_json_object() is being called in
>> newline_indent(), resulting in a mismatch
>> of {}.
>>
>> When fixing this problem, I was unsure why a newline() is needed in pretty
>> mode, so I simply kept this logic and
>> solved the issue of open_json_object() and close_json_object() not matching.
>> However, If the output of pretty mode
>> and not-pretty mode should be the same, then this problem can be resolved by
>> deleting this newline_indent().
> Stephen didn't say that output of pretty and not-pretty should be the
> same, but he said that JSON logic should be the same.
>
> Thanks

Hi, Leon,

Thank you for your reply. But I'm not sure what you mean by JSON logic? 
I understand that
pretty and not-pretty JSON should have the same content, but just 
difference display effects.
Do you mean that they only need to have the same structure?

Or, let's get back to this question. In the JSON format output, the 
newline() here seems
unnecessary, because json_print() can solve the line break problems 
during printing.
So I think the newline() here can be removed at least when outputting in 
JSON format.

Thanks,
Chengchang Tang
>
>> I believe the original developer may not have realized that
>> close_json_object() is being called in newline(), which leads
>> to this problem. To improve the code's readability, I would try to strip out
>> close_json_obejct() from newline().
>>
>> Thanks,
>> Chengchang Tang
>>
> .
>


