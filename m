Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CE24933DF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 05:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351037AbiASEBh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 23:01:37 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38828 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344750AbiASEBh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 23:01:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2EqgKG_1642564894;
Received: from 30.43.72.229(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V2EqgKG_1642564894)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 12:01:35 +0800
Message-ID: <0140e80e-b578-0e62-7cfe-ec9ff00c7345@linux.alibaba.com>
Date:   Wed, 19 Jan 2022 12:01:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: PATCH [rdma-next v2 03/11] RDMA/erdma: Add main include file
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB2631CD09BCD3F88EFD70A48B99589@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB2631CD09BCD3F88EFD70A48B99589@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/18/22 11:11 PM, Bernard Metzler wrote:
> 

<...>

> 
> move these large inline functions to where they
> are needed. No need to put those into .h file.
> make forward declarations if needed more than once,
> static otherwise.
> 

OK, will fix.

>> +static inline int erdma_alloc_idx(struct erdma_resource_cb *res_cb)
> 
> no inline, move to erdma_verbs.c
> 

Will fix,

>> +{
>> +	int idx;
>> +	unsigned long flags;
>> +	u32 start_idx = res_cb->next_alloc_idx;
>> +
> better read while already under lock?
> 

Nice, will fix.

>> +	spin_lock_irqsave(&res_cb->lock, flags);
>> +	idx = find_next_zero_bit(res_cb->bitmap, res_cb->max_cap,
>> start_idx);
>> +	if (idx == res_cb->max_cap) {
>> +		idx = find_first_zero_bit(res_cb->bitmap, res_cb->max_cap);
>> +		if (idx == res_cb->max_cap) {
>> +			res_cb->next_alloc_idx = 1;
>> +			spin_unlock_irqrestore(&res_cb->lock, flags);
>> +			return -ENOSPC;
>> +		}
>> +	}
>> +
>> +	set_bit(idx, res_cb->bitmap);
>> +	spin_unlock_irqrestore(&res_cb->lock, flags);
>> +	res_cb->next_alloc_idx = idx + 1;
> 
> should be set while still under lock?
> 

Nice, will fix.

>> +	return idx;
>> +}
>> +
>> +static inline void erdma_free_idx(struct erdma_resource_cb *res_cb, u32
>> idx)
> 
> move to erdma_verbs.c
> 

Will fix.

>> +{
>> +	unsigned long flags;
>> +	u32 used;
>> +
>> +	spin_lock_irqsave(&res_cb->lock, flags);
>> +	used = test_and_clear_bit(idx, res_cb->bitmap);
>> +	spin_unlock_irqrestore(&res_cb->lock, flags);
>> +	WARN_ON(!used);
>> +}
>> +
>> +#define ERDMA_EXTRA_BUFFER_SIZE 8
>> +
>> +struct erdma_dev {
>> +	struct ib_device ibdev;
>> +	struct net_device *netdev;
>> +	void *dmadev;
>> +	void *drvdata;
>> +	/* reference to drvdata->cmdq */
>> +	struct erdma_cmdq *cmdq;
>> +
>> +	void (*release_handler)(void *drvdata);
>> +
>> +	/* physical port state (only one port per device) */
>> +	enum ib_port_state state;
>> +
>> +	struct erdma_devattr attrs;
>> +
>> +	spinlock_t lock;
>> +
>> +	struct erdma_resource_cb res_cb[ERDMA_RES_CNT];
>> +	struct xarray qp_xa;
>> +	struct xarray cq_xa;
>> +
>> +	u32 next_alloc_qpn;
>> +	u32 next_alloc_cqn;
>> +
>> +	spinlock_t db_bitmap_lock;
>> +
>> +	/* We provide 64 uContexts that each has one SQ doorbell Page. */
>> +	DECLARE_BITMAP(sdb_page, ERDMA_DWQE_TYPE0_CNT);
>> +	/* We provide 496 uContexts that each has one SQ normal Db, and one
>> directWQE db */
>> +	DECLARE_BITMAP(sdb_entry, ERDMA_DWQE_TYPE1_CNT);
>> +
>> +	u8 __iomem *db_space;
>> +	resource_size_t db_space_addr;
>> +
> 
> most of these below atomics are never checked, so remove.
> 

OK, will fix.

>> +	atomic_t num_pd;
>> +	atomic_t num_qp;
>> +	atomic_t num_cq;
>> +	atomic_t num_mr;
>> +	atomic_t num_ctx;

<...>

>> +	return FIELD_GET(filed_mask, val);
>> +}
>> +
>> +static inline int erdma_poll_ceq_event(struct erdma_eq *ceq)
> 
> better move it to erdma_eq.c, and make forward declaration for
> erdma_cmdq.c or vice versa
> 

I will check and fix it.

Thanks,
Cheng Xu,
