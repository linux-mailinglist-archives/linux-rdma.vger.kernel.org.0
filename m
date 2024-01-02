Return-Path: <linux-rdma+bounces-513-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BFD821816
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 08:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE7E1F21F61
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7820B1FD2;
	Tue,  2 Jan 2024 07:44:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B16AA6;
	Tue,  2 Jan 2024 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T44cJ1gRPz1wrQm;
	Tue,  2 Jan 2024 15:44:16 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
	by mail.maildlp.com (Postfix) with ESMTPS id C2A061A0192;
	Tue,  2 Jan 2024 15:44:29 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 15:44:29 +0800
Received: from [10.67.121.229] (10.67.121.229) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 15:44:29 +0800
Subject: Re: [PATCH iproute2-rc 1/2] rdma: Fix core dump when pretty is used
To: Stephen Hemminger <stephen@networkplumber.org>, Junxian Huang
	<huangjunxian6@hisilicon.com>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
 <20231229065241.554726-2-huangjunxian6@hisilicon.com>
 <20231229092129.25a526c4@hermes.local>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
From: Chengchang Tang <tangchengchang@huawei.com>
Message-ID: <30d8c237-953a-8794-9baa-e21b31d4d88c@huawei.com>
Date: Tue, 2 Jan 2024 15:44:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231229092129.25a526c4@hermes.local>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)



On 2023/12/30 1:21, Stephen Hemminger wrote:
> On Fri, 29 Dec 2023 14:52:40 +0800
> Junxian Huang <huangjunxian6@hisilicon.com> wrote:
>
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> There will be a core dump when pretty is used as the JSON object
>> hasn't been opened and closed properly.
>>
>> Before:
>> $ rdma res show qp -jp -dd
>> [ {
>>      "ifindex": 1,
>>      "ifname": "hns_1",
>>      "port": 1,
>>      "lqpn": 1,
>>      "type": "GSI",
>>      "state": "RTS",
>>      "sq-psn": 0,
>>      "comm": "ib_core"
>> },
>> "drv_sq_wqe_cnt": 128,
>> "drv_sq_max_gs": 2,
>> "drv_rq_wqe_cnt": 512,
>> "drv_rq_max_gs": 1,
>> rdma: json_writer.c:130: jsonw_end: Assertion `self->depth > 0' failed.
>> Aborted (core dumped)
>>
>> After:
>> $ rdma res show qp -jp -dd
>> [ {
>>          "ifindex": 2,
>>          "ifname": "hns_2",
>>          "port": 1,
>>          "lqpn": 1,
>>          "type": "GSI",
>>          "state": "RTS",
>>          "sq-psn": 0,
>>          "comm": "ib_core",{
>>              "drv_sq_wqe_cnt": 128,
>>              "drv_sq_max_gs": 2,
>>              "drv_rq_wqe_cnt": 512,
>>              "drv_rq_max_gs": 1,
>>              "drv_ext_sge_sge_cnt": 256
>>          }
>>      } ]
>>
>> Fixes: 331152752a97 ("rdma: print driver resource attributes")
>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> This code in rdma seems to be miking json and newline functionality
> which creates bug traps.
>
> Also the json should have same effective output in pretty and non-pretty mode.
> It looks like since pretty mode add extra object layer, the nesting of {} would be
> different.
>
> The conversion to json_print() was done but it isn't using same conventions
> as ip or tc.
>
> The correct fix needs to go deeper and hit other things.
>

Hi, Stephen,

The root cause of this issue is that close_json_object() is being called 
in newline_indent(), resulting in a mismatch
of {}.

When fixing this problem, I was unsure why a newline() is needed in 
pretty mode, so I simply kept this logic and
solved the issue of open_json_object() and close_json_object() not 
matching. However, If the output of pretty mode
and not-pretty mode should be the same, then this problem can be 
resolved by deleting this newline_indent().

I believe the original developer may not have realized that 
close_json_object() is being called in newline(), which leads
to this problem. To improve the code's readability, I would try to strip 
out close_json_obejct() from newline().

Thanks,
Chengchang Tang

