Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E26306EE
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2019 05:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfEaDPP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 23:15:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfEaDPP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 23:15:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8C1DAC6F0275231BFCC7;
        Fri, 31 May 2019 11:15:12 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 31 May 2019
 11:15:05 +0800
Subject: Re: [PATCH V3 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
To:     Leon Romanovsky <leon@kernel.org>
CC:     <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1559231276-67517-1-git-send-email-oulijun@huawei.com>
 <1559231276-67517-2-git-send-email-oulijun@huawei.com>
 <20190530193451.GE5768@mtr-leonro.mtl.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <37a46eea-4beb-d68d-9419-1f404f35638f@huawei.com>
Date:   Fri, 31 May 2019 11:14:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20190530193451.GE5768@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ÔÚ 2019/5/31 3:34, Leon Romanovsky Ð´µÀ:
> On Thu, May 30, 2019 at 11:47:54PM +0800, Lijun Ou wrote:
>> Currently, the MTT(memory translate table) design required a buffer
>> space must has the same hopnum, but the hip08 hw can support mixed
>> hopnum config in a buffer space.
>>
>> This patch adds the MTR(memory translate region) design for supporting
>> mixed multihop.
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Lijun Ou <oulijun@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  36 +++
>>  drivers/infiniband/hw/hns/hns_roce_hem.c    | 467 ++++++++++++++++++++++++++++
>>  drivers/infiniband/hw/hns/hns_roce_hem.h    |  14 +
>>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 121 +++++++
>>  4 files changed, 638 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index d6e8b44..720be44 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -341,6 +341,29 @@ struct hns_roce_mtt {
>>  	enum hns_roce_mtt_type	mtt_type;
>>  };
>>
>> +struct hns_roce_buf_region {
>> +	int offset; /* page offset */
>> +	u32 count; /* page count*/
>> +	int hopnum; /* addressing hop num */
>> +};
>> +
>> +#define HNS_ROCE_MAX_BT_REGION	3
>> +#define HNS_ROCE_MAX_BT_LEVEL	3
>> +struct hns_roce_hem_list {
>> +	struct list_head root_bt;
>> +	/* link all bt dma mem by hop config */
>> +	struct list_head mid_bt[HNS_ROCE_MAX_BT_REGION][HNS_ROCE_MAX_BT_LEVEL];
>> +	struct list_head btm_bt; /* link all bottom bt in @mid_bt */
>> +	dma_addr_t root_ba; /* pointer to the root ba table */
>> +	int bt_pg_shift;
>> +};
>> +
>> +/* memory translate region */
>> +struct hns_roce_mtr {
>> +	struct hns_roce_hem_list hem_list;
>> +	int buf_pg_shift;
>> +};
>> +
>>  struct hns_roce_mw {
>>  	struct ib_mw		ibmw;
>>  	u32			pdn;
>> @@ -1111,6 +1134,19 @@ void hns_roce_mtt_cleanup(struct hns_roce_dev *hr_dev,
>>  int hns_roce_buf_write_mtt(struct hns_roce_dev *hr_dev,
>>  			   struct hns_roce_mtt *mtt, struct hns_roce_buf *buf);
>>
>> +void hns_roce_mtr_init(struct hns_roce_mtr *mtr, int bt_pg_shift,
>> +		       int buf_pg_shift);
>> +int hns_roce_mtr_attach(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
>> +			dma_addr_t **bufs, struct hns_roce_buf_region *regions,
>> +			int region_cnt);
>> +void hns_roce_mtr_cleanup(struct hns_roce_dev *hr_dev,
>> +			  struct hns_roce_mtr *mtr);
>> +
>> +/* hns roce hw need current block and next block addr from mtt */
>> +#define MTT_MIN_COUNT	 2
>> +int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
>> +		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr);
>> +
>>  int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
>>  int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
>>  int hns_roce_init_eq_table(struct hns_roce_dev *hr_dev);
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
>> index 157c84a..d758e95 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hem.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
>> @@ -1157,3 +1157,470 @@ void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev)
>>  					   &hr_dev->mr_table.mtt_cqe_table);
>>  	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->mr_table.mtt_table);
>>  }
>> +
>> +struct roce_hem_item {
>> +	struct list_head list; /* link all hems in the same bt level */
>> +	struct list_head sibling; /* link all hems in last hop for mtt */
>> +	void *addr;
>> +	dma_addr_t dma_addr;
>> +	size_t count; /* max ba numbers */
>> +	int start; /* start buf offset in this hem */
>> +	int end; /* end buf offset in this hem */
>> +};
>> +
>> +#define hem_list_for_each(pos, n, head) \
>> +		list_for_each_entry_safe(pos, n, head, list)
>> +
>> +#define hem_list_del_item(hem)		list_del(&hem->list)
>> +#define hem_list_add_item(hem, head)	list_add(&hem->list, head)
>> +#define hem_list_link_item(hem, head)	list_add(&hem->sibling, head)
>> +
> Please don't obfuscate kernel primitives, it hurts both readability and
> possible refactoring.
>
> Thanks
Thank your review. we will remove it.
> .
>


