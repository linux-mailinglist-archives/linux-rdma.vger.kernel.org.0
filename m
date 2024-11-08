Return-Path: <linux-rdma+bounces-5850-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBED9C1706
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 08:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458AD28373C
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281661D0F4F;
	Fri,  8 Nov 2024 07:34:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0F634;
	Fri,  8 Nov 2024 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051246; cv=none; b=e3ZG56tZMNkXdNefRC/xVz5u8bF6V/zv38bbCA1MaVlQCYSjSEnG1FBiLVtAIQRrlE4anumohI9wkyADFNLyeY5GMHfUDL7/KYlv1ke0DohzIkN9J9zfTU8rQiRdmdYNyR+ShX6Mi1Lpk7GwR0fH8SwT8NORd6P4JD5DSCkYL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051246; c=relaxed/simple;
	bh=ivcz6yucx9YSQ0k76nxy8375MqeOFkfTQ+U0AdavhLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tLltbvkXXhj6Sc+dsW3BYtqxUmBgBtHBgeweAa1umWV4KcSNXKNeSdhIMrMK7fFKwMkUZf6L6xQrHGYcSaPEjIqqeGO70EeNNrN+JyQ+GHYgv4DVuA7FPFZr99zoGryLek4waPJN6v3SI427GhIXQkOEpdhhHIjOSIUJ1f56vaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xl9cj3Jw4zlXGq;
	Fri,  8 Nov 2024 15:32:05 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 318011402C8;
	Fri,  8 Nov 2024 15:33:59 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Nov 2024 15:33:58 +0800
Message-ID: <7646ef8c-6cab-f2e5-2bbb-14a894c741ca@hisilicon.com>
Date: Fri, 8 Nov 2024 15:33:58 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 for-next] RDMA/hns: Fix different dgids mapping to the
 same dip_idx
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>
References: <20241107061148.2010241-1-huangjunxian6@hisilicon.com>
 <c1837568-8895-49f2-b340-262824d2cb74@linux.dev>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <c1837568-8895-49f2-b340-262824d2cb74@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/11/8 15:11, Zhu Yanjun wrote:
> 在 2024/11/7 7:11, Junxian Huang 写道:
>> From: Feng Fang <fangfeng4@huawei.com>
>>
>> DIP algorithm requires a one-to-one mapping between dgid and dip_idx.
>> Currently a queue 'spare_idx' is used to store QPN of QPs that use
>> DIP algorithm. For a new dgid, use a QPN from spare_idx as dip_idx.
>> This method lacks a mechanism for deduplicating QPN, which may result
>> in different dgids sharing the same dip_idx and break the one-to-one
>> mapping requirement.
>>
>> This patch replaces spare_idx with xarray and introduces a refcnt of
>> a dip_idx to indicate the number of QPs that using this dip_idx.
>>
>> The state machine for dip_idx management is implemented as:
>>
>> * The entry at an index in xarray is empty -- This indicates that the
>>    corresponding dip_idx hasn't been created.
>>
>> * The entry at an index in xarray is not empty but with 0 refcnt --
>>    This indicates that the corresponding dip_idx has been created but
>>    not used as dip_idx yet.
>>
>> * The entry at an index in xarray is not empty and with non-0 refcnt --
>>    This indicates that the corresponding dip_idx is being used by refcnt
>>    number of DIP QPs.
>>
>> Fixes: eb653eda1e91 ("RDMA/hns: Bugfix for incorrect association between dip_idx and dgid")
>> Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
>> Signed-off-by: Feng Fang <fangfeng4@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>> v1 -> v2:
>> * Use xarray instead of bitmaps as Leon suggested.
>> * v1: https://lore.kernel.org/all/20240906093444.3571619-10-huangjunxian6@hisilicon.com/
>> ---
>>   drivers/infiniband/hw/hns/hns_roce_device.h | 11 +--
>>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 96 +++++++++++++++------
>>   drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  2 +-
>>   drivers/infiniband/hw/hns/hns_roce_main.c   |  2 -
>>   drivers/infiniband/hw/hns/hns_roce_qp.c     |  7 +-
>>   5 files changed, 74 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 9b51d5a1533f..560a1d9de408 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -489,12 +489,6 @@ struct hns_roce_bank {
>>       u32 next; /* Next ID to allocate. */
>>   };
>>
>> -struct hns_roce_idx_table {
>> -    u32 *spare_idx;
>> -    u32 head;
>> -    u32 tail;
>> -};
>> -
>>   struct hns_roce_qp_table {
>>       struct hns_roce_hem_table    qp_table;
>>       struct hns_roce_hem_table    irrl_table;
>> @@ -503,7 +497,7 @@ struct hns_roce_qp_table {
>>       struct mutex            scc_mutex;
>>       struct hns_roce_bank bank[HNS_ROCE_QP_BANK_NUM];
>>       struct mutex bank_mutex;
>> -    struct hns_roce_idx_table    idx_table;
>> +    struct xarray            dip_xa;
>>   };
>>
>>   struct hns_roce_cq_table {
>> @@ -658,6 +652,7 @@ struct hns_roce_qp {
>>       u8            tc_mode;
>>       u8            priority;
>>       spinlock_t flush_lock;
>> +    struct hns_roce_dip *dip;
>>   };
>>
>>   struct hns_roce_ib_iboe {
>> @@ -984,8 +979,6 @@ struct hns_roce_dev {
>>       enum hns_roce_device_state state;
>>       struct list_head    qp_list; /* list of all qps on this dev */
>>       spinlock_t        qp_list_lock; /* protect qp_list */
>> -    struct list_head    dip_list; /* list of all dest ips on this dev */
>> -    spinlock_t        dip_list_lock; /* protect dip_list */
>>
>>       struct list_head        pgdir_list;
>>       struct mutex            pgdir_mutex;
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index d1c075fb0ad8..36e7cedfd106 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -2553,20 +2553,19 @@ static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev)
>>       free_link_table_buf(hr_dev, &priv->ext_llm);
>>   }
>>
>> -static void free_dip_list(struct hns_roce_dev *hr_dev)
>> +static void free_dip_entry(struct hns_roce_dev *hr_dev)
>>   {
>>       struct hns_roce_dip *hr_dip;
>> -    struct hns_roce_dip *tmp;
>> -    unsigned long flags;
>> +    unsigned long idx;
>>
>> -    spin_lock_irqsave(&hr_dev->dip_list_lock, flags);
>> +    xa_lock(&hr_dev->qp_table.dip_xa);
> 
> In the original source code, spin_lock_irqsave is used, it means that irq is also taken into account. But in the new code, xa_lock is used. It means that irq is not taken into account. Not sure if this will introduce risks or not.
> 
> Perhaps xa_lock_irqsave/xa_unlock_irqrestore is better?
> 

The original spin_lock_irqsave() is kind of over-designed. Actually this code
doesn't involve racing with interrupts.

Junxian

> Zhu Yanjun
> 
>>
>> -    list_for_each_entry_safe(hr_dip, tmp, &hr_dev->dip_list, node) {
>> -        list_del(&hr_dip->node);
>> +    xa_for_each(&hr_dev->qp_table.dip_xa, idx, hr_dip) {
>> +        __xa_erase(&hr_dev->qp_table.dip_xa, hr_dip->dip_idx);
>>           kfree(hr_dip);
>>       }
>>
>> -    spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
>> +    xa_unlock(&hr_dev->qp_table.dip_xa);
>>   }
>>
>>   static struct ib_pd *free_mr_init_pd(struct hns_roce_dev *hr_dev)
>> @@ -2974,7 +2973,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
>>           hns_roce_free_link_table(hr_dev);
>>
>>       if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
>> -        free_dip_list(hr_dev);
>> +        free_dip_entry(hr_dev);
>>   }
>>
>>   static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev,
>> @@ -4694,26 +4693,49 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp, int attr_mask,
>>       return 0;
>>   }
>>
>> +static int alloc_dip_entry(struct xarray *dip_xa, u32 qpn)
>> +{
>> +    struct hns_roce_dip *hr_dip;
>> +    int ret;
>> +
>> +    hr_dip = xa_load(dip_xa, qpn);
>> +    if (hr_dip)
>> +        return 0;
>> +
>> +    hr_dip = kzalloc(sizeof(*hr_dip), GFP_KERNEL);
>> +    if (!hr_dip)
>> +        return -ENOMEM;
>> +
>> +    ret = xa_err(xa_store(dip_xa, qpn, hr_dip, GFP_KERNEL));
>> +    if (ret)
>> +        kfree(hr_dip);
>> +
>> +    return ret;
>> +}
>> +
>>   static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
>>                  u32 *dip_idx)
>>   {
>>       const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
>>       struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
>> -    u32 *spare_idx = hr_dev->qp_table.idx_table.spare_idx;
>> -    u32 *head =  &hr_dev->qp_table.idx_table.head;
>> -    u32 *tail =  &hr_dev->qp_table.idx_table.tail;
>> +    struct xarray *dip_xa = &hr_dev->qp_table.dip_xa;
>> +    struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
>>       struct hns_roce_dip *hr_dip;
>> -    unsigned long flags;
>> +    unsigned long idx;
>>       int ret = 0;
>>
>> -    spin_lock_irqsave(&hr_dev->dip_list_lock, flags);
>> +    ret = alloc_dip_entry(dip_xa, ibqp->qp_num);
>> +    if (ret)
>> +        return ret;
>>
>> -    spare_idx[*tail] = ibqp->qp_num;
>> -    *tail = (*tail == hr_dev->caps.num_qps - 1) ? 0 : (*tail + 1);
>> +    xa_lock(dip_xa);
>>
>> -    list_for_each_entry(hr_dip, &hr_dev->dip_list, node) {
>> -        if (!memcmp(grh->dgid.raw, hr_dip->dgid, GID_LEN_V2)) {
>> +    xa_for_each(dip_xa, idx, hr_dip) {
>> +        if (hr_dip->qp_cnt &&
>> +            !memcmp(grh->dgid.raw, hr_dip->dgid, GID_LEN_V2)) {
>>               *dip_idx = hr_dip->dip_idx;
>> +            hr_dip->qp_cnt++;
>> +            hr_qp->dip = hr_dip;
>>               goto out;
>>           }
>>       }
>> @@ -4721,19 +4743,24 @@ static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
>>       /* If no dgid is found, a new dip and a mapping between dgid and
>>        * dip_idx will be created.
>>        */
>> -    hr_dip = kzalloc(sizeof(*hr_dip), GFP_ATOMIC);
>> -    if (!hr_dip) {
>> -        ret = -ENOMEM;
>> -        goto out;
>> +    xa_for_each(dip_xa, idx, hr_dip) {
>> +        if (hr_dip->qp_cnt)
>> +            continue;
>> +
>> +        *dip_idx = idx;
>> +        memcpy(hr_dip->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
>> +        hr_dip->dip_idx = idx;
>> +        hr_dip->qp_cnt++;
>> +        hr_qp->dip = hr_dip;
>> +        break;
>>       }
>>
>> -    memcpy(hr_dip->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
>> -    hr_dip->dip_idx = *dip_idx = spare_idx[*head];
>> -    *head = (*head == hr_dev->caps.num_qps - 1) ? 0 : (*head + 1);
>> -    list_add_tail(&hr_dip->node, &hr_dev->dip_list);
>> +    /* This should never happen. */
>> +    if (WARN_ON_ONCE(!hr_qp->dip))
>> +        ret = -ENOSPC;
>>
>>   out:
>> -    spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
>> +    xa_unlock(dip_xa);
>>       return ret;
>>   }
>>
>> @@ -5587,6 +5614,20 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
>>       return ret;
>>   }
>>
>> +static void put_dip_ctx_idx(struct hns_roce_dev *hr_dev,
>> +                struct hns_roce_qp *hr_qp)
>> +{
>> +    struct hns_roce_dip *hr_dip = hr_qp->dip;
>> +
>> +    xa_lock(&hr_dev->qp_table.dip_xa);
>> +
>> +    hr_dip->qp_cnt--;
>> +    if (!hr_dip->qp_cnt)
>> +        memset(hr_dip->dgid, 0, GID_LEN_V2);
>> +
>> +    xa_unlock(&hr_dev->qp_table.dip_xa);
>> +}
>> +
>>   int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>>   {
>>       struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
>> @@ -5600,6 +5641,9 @@ int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>>       spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
>>       flush_work(&hr_qp->flush_work.work);
>>
>> +    if (hr_qp->cong_type == CONG_TYPE_DIP)
>> +        put_dip_ctx_idx(hr_dev, hr_qp);
>> +
>>       ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
>>       if (ret)
>>           ibdev_err_ratelimited(&hr_dev->ib_dev,
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> index 3b3c6259ace0..1c593fcf1143 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> @@ -1347,7 +1347,7 @@ struct hns_roce_v2_priv {
>>   struct hns_roce_dip {
>>       u8 dgid[GID_LEN_V2];
>>       u32 dip_idx;
>> -    struct list_head node; /* all dips are on a list */
>> +    u32 qp_cnt;
>>   };
>>
>>   struct fmea_ram_ecc {
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
>> index 49315f39361d..ae24c81c9812 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
>> @@ -1135,8 +1135,6 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
>>
>>       INIT_LIST_HEAD(&hr_dev->qp_list);
>>       spin_lock_init(&hr_dev->qp_list_lock);
>> -    INIT_LIST_HEAD(&hr_dev->dip_list);
>> -    spin_lock_init(&hr_dev->dip_list_lock);
>>
>>       ret = hns_roce_register_device(hr_dev);
>>       if (ret)
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> index 2ad03ecdbf8e..7d67cefe549c 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> @@ -1573,14 +1573,10 @@ int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
>>       unsigned int reserved_from_bot;
>>       unsigned int i;
>>
>> -    qp_table->idx_table.spare_idx = kcalloc(hr_dev->caps.num_qps,
>> -                    sizeof(u32), GFP_KERNEL);
>> -    if (!qp_table->idx_table.spare_idx)
>> -        return -ENOMEM;
>> -
>>       mutex_init(&qp_table->scc_mutex);
>>       mutex_init(&qp_table->bank_mutex);
>>       xa_init(&hr_dev->qp_table_xa);
>> +    xa_init(&qp_table->dip_xa);
>>
>>       reserved_from_bot = hr_dev->caps.reserved_qps;
>>
>> @@ -1607,5 +1603,4 @@ void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
>>           ida_destroy(&hr_dev->qp_table.bank[i].ida);
>>       mutex_destroy(&hr_dev->qp_table.bank_mutex);
>>       mutex_destroy(&hr_dev->qp_table.scc_mutex);
>> -    kfree(hr_dev->qp_table.idx_table.spare_idx);
>>   }
>> -- 
>> 2.33.0
>>
> 

