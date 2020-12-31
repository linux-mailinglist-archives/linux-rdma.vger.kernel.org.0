Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135532E7F01
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Dec 2020 10:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgLaJhM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 31 Dec 2020 04:37:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2538 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLaJhM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Dec 2020 04:37:12 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4D631C25fDzQx0w;
        Thu, 31 Dec 2020 17:35:43 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 31 Dec 2020 17:36:28 +0800
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 31 Dec 2020 17:36:28 +0800
Received: from dggema703-chm.china.huawei.com ([10.8.64.130]) by
 dggema703-chm.china.huawei.com ([10.8.64.130]) with mapi id 15.01.1913.007;
 Thu, 31 Dec 2020 17:36:28 +0800
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
Date:   Thu, 31 Dec 2020 09:36:27 +0000
Message-ID: <f7eb8350a0474532870c5ad2ab940c5a@huawei.com>
References: <d681bc1cad0e4726806aeb46f240d07d@huawei.com>
 <20201231075907.GD6438@unreal>
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

On 2020/12/31 15:59, Leon Romanovsky wrote:
> On Tue, Dec 29, 2020 at 01:31:39PM +0000, liweihang wrote:
>> Hi all,
>>
>> We want to dump some hns driver-defined information that belongs to a
>> process to keep track of current memory usage. For example, there is
>> a ucontext-level(process-level) memory pool to store WQE which is
>> shared by a lot of QPs, we want to record and query which QPs are using
>> this pool and how much space each QP is using.
>>
>> rdmatool don't have a ucontext-level resource tracking currently, is it
>> ok to achieve that through debugfs?
>>
>> This may looks like:
>>
>> $ echo 1 > <dbgfs_dir>/hns_roce/hns_0/<pid>/qp
>> QPN        Total(kB)  SQ(kB)     SGE(kB)    RQ(kB)
>> 110        6400       256        2048       4096
>> 118        6400       256        2048       0
>>
>> Or should it be achieved in rdmatool?
> 
> I think so, because PID != ucontext. Why can't it be presented as QP
> attribute? Can you please send "rdmatool" example?
> 
> Thanks

Hi Leon,

Thanks for your response. If we can achieve it in rdmatool, it may
looks like:

1) We want to get some information of a ucontext (assuming that each
ucontext has an ID), for example, the size of a memory pool that belongs
to a ucontext as I mentioned above:

$ rdma res show ucontext
uctx_id	1 pid 20 qp_buf_sz 6400 sq_buf_sz 256 sge_buf_sz 2048 rq_buf_sz 4096
uctx_id	2 pid 20 qp_buf_sz 4800 sq_buf_sz 128 sge_buf_sz 2048 rq_buf_sz 2048

2) We want to know which ucontext a QP belongs to:

$ rdma res show qp
link hns_0/1 lqpn 1 type GSI ... uctx_id 1
link hns_0/1 lqpn 2 type RC ... uctx_id 1

So the question is, we don't have a ucontext-level restrack currently, and
there in no 'id' for each ucontext.

Thanks
Weihang

