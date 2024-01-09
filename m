Return-Path: <linux-rdma+bounces-566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B06827C93
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 02:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1661C23299
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 01:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E317F4;
	Tue,  9 Jan 2024 01:37:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072D10E4;
	Tue,  9 Jan 2024 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T8D5L2nbZz1Q7qb;
	Tue,  9 Jan 2024 09:35:18 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 748BD1A0172;
	Tue,  9 Jan 2024 09:36:49 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 09:36:48 +0800
Message-ID: <b23fb661-4a04-edb0-70fb-2d2c89d822d3@hisilicon.com>
Date: Tue, 9 Jan 2024 09:36:47 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH iproute2-rc 2/2] rdma: Fix the error of accessing string
 variable outside the lifecycle
Content-Language: en-US
To: Andrea Claudi <aclaudi@redhat.com>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
	<stephen@networkplumber.org>, Chengchang Tang <tangchengchang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
 <20231229065241.554726-3-huangjunxian6@hisilicon.com>
 <fb7c85a4-165d-7eda-740a-d11a32cb86c0@hisilicon.com>
 <ZZweXDQ-4ZrlfxBv@renaissance-vector>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <ZZweXDQ-4ZrlfxBv@renaissance-vector>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/1/9 0:10, Andrea Claudi wrote:
> On Mon, Jan 08, 2024 at 09:28:52AM +0800, Junxian Huang wrote:
>>
>> Hi all,
>>
>> the first patch is replaced by Stephen's latest patches. Are there any
>> comments to this patch?
>>
>> Thanks,
>> Junxian
>>
>> On 2023/12/29 14:52, Junxian Huang wrote:
>>> From: wenglianfa <wenglianfa@huawei.com>
>>>
>>> All these SPRINT_BUF(b) definitions are inside the 'if' block, but
>>> accessed outside the 'if' block through the pointers 'comm'. This
>>> leads to empty 'comm' attribute when querying resource information.
>>> So move the definitions to the beginning of the functions to extend
>>> their life cycle.
>>>
>>> Before:
>>> $ rdma res show srq
>>> dev hns_0 srqn 0 type BASIC lqpn 18 pdn 5 pid 7775 comm
>>>
>>> After:
>>> $ rdma res show srq
>>> dev hns_0 srqn 0 type BASIC lqpn 18 pdn 5 pid 7775 comm ib_send_bw
>>>
>>> Fixes: 1808f002dfdd ("lib/fs: fix memory leak in get_task_name()")
>>> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>> ---
> 
> Hi Junxian,
> For future patches, you can have a faster feedback adding to cc the
> author of the original patch. In this case it's me, so here's my
> 
> Acked-by: Andrea Claudi <aclaudi@redhat.com>
> 

Thanks for the advice!

Junxian

