Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB456493327
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 03:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbiASCxy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 21:53:54 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:53604 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232983AbiASCxx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 21:53:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2F5dgv_1642560831;
Received: from 30.43.72.229(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V2F5dgv_1642560831)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 10:53:51 +0800
Message-ID: <65938b6f-421a-1284-017f-f11553884d69@linux.alibaba.com>
Date:   Wed, 19 Jan 2022 10:53:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next v2 06/11] RDMA/erdma: Add verbs header file
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB2631AB8978A9892821CBEA3B99589@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB2631AB8978A9892821CBEA3B99589@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/18/22 9:11 PM, Bernard Metzler wrote:

<...>

>> +struct erdma_qp {
>> +	struct ib_qp ibqp;
>> +	struct kref ref;
>> +	struct completion safe_free;
>> +	struct erdma_dev *dev;
>> +	struct erdma_cep *cep;
>> +	struct rw_semaphore state_lock;
>> +	bool is_kernel_qp;
> 
> this information is available via RDMA core.
> one can always query 'rdma_is_kernel_res(&qp->ibqp.res)'
> you should really look at the latest siw code 😉
> 

Thanks, I will fix this. I referred the latest siw code, mainly for CM
part and modify_qp in verbs, other part of verbs already have lots of
differences, so I ignored. I will check them before v3 patch.

<...>

>> +
>> +struct erdma_cq {
>> +	struct ib_cq ibcq;
>> +	u32 cqn;
>> +
>> +	u32 depth;
>> +	u32 assoc_eqn;
>> +	u32 is_kernel_cq;
> 
> bogus u32 here, and can be completely removed.
> use rdma_is_kernel_res(&cq->ibcq.res)

Will fix it also,

Thanks,
Cheng Xu
