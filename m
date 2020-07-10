Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42A21B2FC
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGJKLW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 10 Jul 2020 06:11:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbgGJKLW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 06:11:22 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 4D86F3FFE3DB53409F17;
        Fri, 10 Jul 2020 18:11:21 +0800 (CST)
Received: from dggema702-chm.china.huawei.com (10.3.20.66) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 10 Jul 2020 18:11:20 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema702-chm.china.huawei.com (10.3.20.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 10 Jul 2020 18:11:20 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Fri, 10 Jul 2020 18:11:20 +0800
From:   liweihang <liweihang@huawei.com>
To:     Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: Question about IB_QP_CUR_STATE
Thread-Topic: Question about IB_QP_CUR_STATE
Thread-Index: AQHWVQvzdhZOnKQSQUeecEiJVm3Vfg==
Date:   Fri, 10 Jul 2020 10:11:20 +0000
Message-ID: <3cfb41bfa2cb4d5cb508a572dbb5e6c7@huawei.com>
References: <876ca1eb8667461a9d2e0effb8ee3934@huawei.com>
 <881488e6-03d8-1e01-076c-5c901d84a44a@amazon.com>
 <20200708154434.GA1276673@unreal>
 <a738e3f3-e2bc-a670-7292-8025c78e210d@amazon.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/7/9 14:14, Gal Pressman wrote:
> On 08/07/2020 18:44, Leon Romanovsky wrote:
>> On Wed, Jul 08, 2020 at 03:42:34PM +0300, Gal Pressman wrote:
>>> On 08/07/2020 12:41, liweihang wrote:
>>>> Hi all,
>>>>
>>>> I'm a little confused about the role of IB_QP_CUR_STATE in the enumeration
>>>> ib_qp_attr_mask.
>>>>
>>>> In manual page of ibv_modify_qp(), comments of cur_qp_state is "Assume this
>>>> is the current QP state". Why we need to get current qp state from users
>>>> instead of drivers?
>>>>
>>>> For example, why the users are allowed to modify qp from RTR to RTS again
>>>> even if the qp's state in driver and hardware has already been RTS.
>>>>
>>>> I would be appretiate it if someone can help with this.
>>>>
>>>> Weihang
>>>>
>>>
>>> Talking about IB_QP_CUR_STATE, I see many drivers filling it in their query QP
>>> callback although it should only be used in modify operations.. Is there a
>>> reason not to remove it?
>>
>> IBTA section "11.2.5.3 QUERY QUEUE PAIR" has line about IB_QP_CUR_STATE.
>> It is one of output modifiers.
>>
>> Thanks
>>
> 
> It says the current QP state should be returned, that's what qp_state field is used for.
> According to the man pages:
> 
> libibverbs/man/ibv_query_qp.3:
>                enum ibv_qp_state       qp_state;            /* Current QP state */
>                enum ibv_qp_state       cur_qp_state;        /* Current QP state - irrelevant for ibv_query_qp */
> 

Hi Gal and Leon,

Thanks for your reply, as Gal said, I can't find the reason why the IBTA use
cur_qp_state either. I'll take a closer look at the protocol.

Weihang
