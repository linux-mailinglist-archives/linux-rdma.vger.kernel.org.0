Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C392B47CB62
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Dec 2021 03:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbhLVCgN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 21:36:13 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47913 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230172AbhLVCgN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 21:36:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.O7q2b_1640140570;
Received: from 30.43.106.56(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.O7q2b_1640140570)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 10:36:11 +0800
Message-ID: <d3d717d3-d0d5-da3b-7047-e2fac16f0d40@linux.alibaba.com>
Date:   Wed, 22 Dec 2021 10:36:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-next 06/11] RDMA/erdma: Add verbs header file
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-7-chengyou@linux.alibaba.com> <YcHWbNusWdT9mMet@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YcHWbNusWdT9mMet@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/21/21 9:28 PM, Leon Romanovsky wrote:
> On Tue, Dec 21, 2021 at 10:48:53AM +0800, Cheng Xu wrote:
>> This header file defines the main structrues and functions used for RDMA
>> Verbs, including qp, cq, mr ucontext, etc,.
>>
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>   drivers/infiniband/hw/erdma/erdma_verbs.h | 366 ++++++++++++++++++++++
>>   1 file changed, 366 insertions(+)
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.h
>>
>> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
>> new file mode 100644
>> index 000000000000..6eda8843d0d5
>> --- /dev/null
>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
>> @@ -0,0 +1,366 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Authors: Cheng Xu <chengyou@linux.alibaba.com>
>> + *          Kai Shen <kaishen@linux.alibaba.com>
>> + * Copyright (c) 2020-2021, Alibaba Group.
>> + */
>> +
>> +#ifndef __ERDMA_VERBS_H__
>> +#define __ERDMA_VERBS_H__
> 
> <...>
> 
>> +extern int erdma_query_port(struct ib_device *dev, u32 port, struct ib_port_attr *attr);
>> +extern int erdma_query_pkey(struct ib_device *dev, u32 port, u16 idx, u16 *pkey);
>> +extern int erdma_query_gid(struct ib_device *dev, u32 port, int idx, union ib_gid *gid);
>> +extern int erdma_alloc_pd(struct ib_pd *pd, struct ib_udata *data);
>> +extern int erdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
>> +extern int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
>> +				   struct ib_udata *data);
>> +extern int erdma_query_qp(struct ib_qp *qp, struct ib_qp_attr *attr, int mask,
>> +			struct ib_qp_init_attr *init_attr);
>> +extern int erdma_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr, int mask,
>> +			      struct ib_udata *data);
>> +extern int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
>> +extern int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
>> +extern int erdma_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
>> +extern struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
>> +				      u64 virt, int access, struct ib_udata *udata);
>> +extern struct ib_mr *erdma_get_dma_mr(struct ib_pd *ibpd, int rights);
>> +extern int erdma_dereg_mr(struct ib_mr *mr, struct ib_udata *data);
>> +extern int erdma_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma);
>> +extern void erdma_qp_get_ref(struct ib_qp *qp);
>> +extern void erdma_qp_put_ref(struct ib_qp *qp);
>> +extern struct ib_qp *erdma_get_ibqp(struct ib_device *dev, int id);
>> +extern int erdma_post_send(struct ib_qp *qp, const struct ib_send_wr *send_wr,
>> +			   const struct ib_send_wr **bad_send_wr);
>> +extern int erdma_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
>> +			   const struct ib_recv_wr **bad_recv_wr);
>> +extern int erdma_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
>> +extern struct ib_mr *erdma_ib_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>> +				       u32 max_num_sg);
>> +extern int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>> +			   int sg_nents, unsigned int *sg_offset);
>> +extern struct net_device *erdma_get_netdev(struct ib_device *device, u32 port_num);
>> +extern void erdma_disassociate_ucontext(struct ib_ucontext *ibcontext);
>> +extern void erdma_port_event(struct erdma_dev *dev, enum ib_event_type reason);
> 
> Why do you add "extern" to function declarations?
> 
> Thanks
> 

We misunderstood the usage of "extern", and will fix it.

Thanks,
Cheng Xu

>> +
>> +#endif
>> -- 
>> 2.27.0
>>
