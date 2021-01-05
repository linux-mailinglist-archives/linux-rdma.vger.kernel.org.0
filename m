Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C7F2EA3D4
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 04:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbhAEDQp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 4 Jan 2021 22:16:45 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2935 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbhAEDQp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jan 2021 22:16:45 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4D8yKl2jDxz5DR8;
        Tue,  5 Jan 2021 11:15:07 +0800 (CST)
Received: from dggema701-chm.china.huawei.com (10.3.20.65) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 5 Jan 2021 11:15:58 +0800
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 dggema701-chm.china.huawei.com (10.3.20.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 5 Jan 2021 11:15:59 +0800
Received: from dggema703-chm.china.huawei.com ([10.8.64.130]) by
 dggema703-chm.china.huawei.com ([10.8.64.130]) with mapi id 15.01.1913.007;
 Tue, 5 Jan 2021 11:15:59 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: Is it ok to use debugfs to dump some ucontext-level
 driver-defined info?
Thread-Topic: Is it ok to use debugfs to dump some ucontext-level
 driver-defined info?
Thread-Index: AQHW3ebw3F8B3O2FE0G2KEXK5NMuLQ==
Date:   Tue, 5 Jan 2021 03:15:58 +0000
Message-ID: <cee34a8583c84763a9efd1cf89628b6b@huawei.com>
References: <d681bc1cad0e4726806aeb46f240d07d@huawei.com>
 <20201231075907.GD6438@unreal> <f7eb8350a0474532870c5ad2ab940c5a@huawei.com>
 <20201231103850.GE6438@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/12/31 18:39, Leon Romanovsky wrote:
> On Thu, Dec 31, 2020 at 09:36:27AM +0000, liweihang wrote:
>> On 2020/12/31 15:59, Leon Romanovsky wrote:
>>> On Tue, Dec 29, 2020 at 01:31:39PM +0000, liweihang wrote:
>>>> Hi all,
>>>>
>>>> We want to dump some hns driver-defined information that belongs to a
>>>> process to keep track of current memory usage. For example, there is
>>>> a ucontext-level(process-level) memory pool to store WQE which is
>>>> shared by a lot of QPs, we want to record and query which QPs are using
>>>> this pool and how much space each QP is using.
>>>>
>>>> rdmatool don't have a ucontext-level resource tracking currently, is it
>>>> ok to achieve that through debugfs?
>>>>
>>>> This may looks like:
>>>>
>>>> $ echo 1 > <dbgfs_dir>/hns_roce/hns_0/<pid>/qp
>>>> QPN        Total(kB)  SQ(kB)     SGE(kB)    RQ(kB)
>>>> 110        6400       256        2048       4096
>>>> 118        6400       256        2048       0
>>>>
>>>> Or should it be achieved in rdmatool?
>>>
>>> I think so, because PID != ucontext. Why can't it be presented as QP
>>> attribute? Can you please send "rdmatool" example?
>>>
>>> Thanks
>>
>> Hi Leon,
>>
>> Thanks for your response. If we can achieve it in rdmatool, it may
>> looks like:
>>
>> 1) We want to get some information of a ucontext (assuming that each
>> ucontext has an ID), for example, the size of a memory pool that belongs
>> to a ucontext as I mentioned above:
>>
>> $ rdma res show ucontext
>> uctx_id	1 pid 20 qp_buf_sz 6400 sq_buf_sz 256 sge_buf_sz 2048 rq_buf_sz 4096
>> uctx_id	2 pid 20 qp_buf_sz 4800 sq_buf_sz 128 sge_buf_sz 2048 rq_buf_sz 2048
> 
> I have no problems to add "rdma res show ucontext" command, we just need
> to find what should be printed.
> 
>>
>> 2) We want to know which ucontext a QP belongs to:
>>
>> $ rdma res show qp
>> link hns_0/1 lqpn 1 type GSI ... uctx_id 1
>> link hns_0/1 lqpn 2 type RC ... uctx_id 1
>>
>> So the question is, we don't have a ucontext-level restrack currently, and
>> there in no 'id' for each ucontext.
> 
> We have IDs for every ucontext, it is called "ctxn" and because QP is
> not connected directly to ucontext, but through PDs, it is visible
> when you check PDs.
> 
> [leonro@vm ~]$ ibv_rc_pingpong &
> [leonro@vm ~]$ rdma res show
> 0: ibp0s9: pd 4 cq 4 qp 4 cm_id 0 mr 1 ctx 1
> [leonro@vm ~]$ rdma res show qp type RC
> link ibp0s9/1 lqpn 50 rqpn 0 type RC state INIT rq-psn 16777215 sq-psn 0 path-mig-state MIGRATED pdn 3 pid 479 comm ibv_rc_pingpong
> [leonro@vm ~]$ rdma res show pd pdn 3
> ifindex 0 ifname ibp0s9 pdn 3 users 2 ctxn 0 pid 479 comm ibv_rc_pingpong
>                                       ^^^^^^
> 
> Thanks
> 

OK, thank you, we will try to use rdmatool to achieve our goal.

By the way, can we use debugfs to add some trace functions?
Debugfs can quickly get a large amount of information at a time,
it's more convenient than netlink in such situation, especially
for some vendor-defined funtions.

Thanks
Weihang
