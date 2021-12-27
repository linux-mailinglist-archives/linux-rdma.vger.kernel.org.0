Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A747FA9C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Dec 2021 07:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhL0Gqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Dec 2021 01:46:54 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45245 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235273AbhL0Gqy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Dec 2021 01:46:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.rkKkK_1640587609;
Received: from 30.43.106.107(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.rkKkK_1640587609)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 14:46:50 +0800
Message-ID: <717d6262-ca7d-3aef-528a-23850a42d888@linux.alibaba.com>
Date:   Mon, 27 Dec 2021 14:46:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-core 1/5] RDMA-CORE/erdma: Add userspace verbs
 related header files.
Content-Language: en-US
To:     Devesh Sharma <devesh.s.sharma@oracle.com>,
        "leon@kernel.org" <leon@kernel.org>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>
References: <20211224065522.29734-1-chengyou@linux.alibaba.com>
 <20211224065522.29734-2-chengyou@linux.alibaba.com>
 <CO6PR10MB563579D00D681B370A36FBE2DD429@CO6PR10MB5635.namprd10.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <CO6PR10MB563579D00D681B370A36FBE2DD429@CO6PR10MB5635.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/27/21 1:48 PM, Devesh Sharma wrote:
> 
> 
<...>

>> +
>> +static inline struct erdma_qp *to_eqp(struct ibv_qp *base) {
>> +	return container_of(base, struct erdma_qp, base_qp); }
>> +
>> +static inline struct erdma_cq *to_ecq(struct ibv_cq *base) {
>> +	return container_of(base, struct erdma_cq, base_cq); }
>> +
>> +static inline void *get_sq_wqebb(struct erdma_qp *qp, uint16_t idx) {
>> +	idx &= (qp->sq.depth - 1);
>> +	return qp->sq.qbuf + (idx << SQEBB_SHIFT); }
>> +
>> +static inline void __kick_sq_db(struct erdma_qp *qp, uint16_t pi) {
>> +	uint64_t db_data;
>> +
>> +	db_data = FIELD_PREP(ERDMA_SQE_HDR_QPN_MASK, qp->id) |
>> +		FIELD_PREP(ERDMA_SQE_HDR_WQEBB_INDEX_MASK, pi);
>> +
>> +	*(__le64 *)qp->sq.db_record = htole64(db_data);
>> +	udma_to_device_barrier();
>> +	mmio_write64_le(qp->sq.db, htole64(db_data)); }
> Standard function definition format
> Func ()
> {
> 
> }
> Update all over the place.

OK, I will fix it.

Thanks,
Cheng Xu

>> --
>> 2.27.0
