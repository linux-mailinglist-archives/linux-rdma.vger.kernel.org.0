Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EC2484C42
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 02:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiAEBzl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 20:55:41 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:39176 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236991AbiAEBzl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 20:55:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V1-t-L1_1641347737;
Received: from 30.43.106.8(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V1-t-L1_1641347737)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 09:55:38 +0800
Message-ID: <51a46e57-222f-6ccf-46ed-449999237548@linux.alibaba.com>
Date:   Wed, 5 Jan 2022 09:55:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-core 1/5] RDMA-CORE/erdma: Add userspace verbs
 related header files.
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Devesh Sharma <devesh.s.sharma@oracle.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>
References: <20211224065522.29734-1-chengyou@linux.alibaba.com>
 <20211224065522.29734-2-chengyou@linux.alibaba.com>
 <CO6PR10MB563579D00D681B370A36FBE2DD429@CO6PR10MB5635.namprd10.prod.outlook.com>
 <717d6262-ca7d-3aef-528a-23850a42d888@linux.alibaba.com>
 <20220103235212.GC2328285@nvidia.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220103235212.GC2328285@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/4/22 7:52 AM, Jason Gunthorpe wrote:
> On Mon, Dec 27, 2021 at 02:46:49PM +0800, Cheng Xu wrote:
> 
>>>> +static inline struct erdma_qp *to_eqp(struct ibv_qp *base) {
>>>> +	return container_of(base, struct erdma_qp, base_qp); }
>>>> +
>>>> +static inline struct erdma_cq *to_ecq(struct ibv_cq *base) {
>>>> +	return container_of(base, struct erdma_cq, base_cq); }
>>>> +
>>>> +static inline void *get_sq_wqebb(struct erdma_qp *qp, uint16_t idx) {
>>>> +	idx &= (qp->sq.depth - 1);
>>>> +	return qp->sq.qbuf + (idx << SQEBB_SHIFT); }
>>>> +
>>>> +static inline void __kick_sq_db(struct erdma_qp *qp, uint16_t pi) {
>>>> +	uint64_t db_data;
>>>> +
>>>> +	db_data = FIELD_PREP(ERDMA_SQE_HDR_QPN_MASK, qp->id) |
>>>> +		FIELD_PREP(ERDMA_SQE_HDR_WQEBB_INDEX_MASK, pi);
>>>> +
>>>> +	*(__le64 *)qp->sq.db_record = htole64(db_data);
>>>> +	udma_to_device_barrier();
>>>> +	mmio_write64_le(qp->sq.db, htole64(db_data)); }
>>> Standard function definition format
>>> Func ()
>>> {
>>>
>>> }
>>> Update all over the place.
>>
>> OK, I will fix it.
> 
> Run it all through clang-format. Very little should deviate from
> clang-format, use your best judgement in special formatting cases.
> 
> Jason

Very useful, thanks.

Cheng Xu

