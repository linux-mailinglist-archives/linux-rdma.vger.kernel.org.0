Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA6B389B16
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 03:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhETCAj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 19 May 2021 22:00:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3429 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhETCAi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 22:00:38 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FltBj3LVqzCstj;
        Thu, 20 May 2021 09:56:29 +0800 (CST)
Received: from dggeme705-chm.china.huawei.com (10.1.199.101) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 09:59:16 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeme705-chm.china.huawei.com (10.1.199.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 09:59:16 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Thu, 20 May 2021 09:59:15 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "wangxi (M)" <wangxi11@huawei.com>
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Remove timeout link table for
 HIP08
Thread-Topic: [PATCH for-next 2/2] RDMA/hns: Remove timeout link table for
 HIP08
Thread-Index: AQHXRwcXsOUcx+vtJUGMJPpDjUtK4A==
Date:   Thu, 20 May 2021 01:59:15 +0000
Message-ID: <522756d5e132440bb914d09621edf4c0@huawei.com>
References: <1620807370-9409-1-git-send-email-liweihang@huawei.com>
 <1620807370-9409-3-git-send-email-liweihang@huawei.com>
 <YKTS/95LQq9tsoRG@unreal>
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

On 2021/5/19 16:57, Leon Romanovsky wrote:
> On Wed, May 12, 2021 at 04:16:10PM +0800, Weihang Li wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> The timeout link table works in HIP08 ES version and the hns driver only
>> support the CS version for HIP08, so delete the related code.
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |   3 +-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 177 +++++++++++-----------------
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  16 +--
>>  3 files changed, 76 insertions(+), 120 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 97800d2..5bd4013 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -854,8 +854,7 @@ struct hns_roce_caps {
>>  	u32		gmv_buf_pg_sz;
>>  	u32		gmv_hop_num;
>>  	u32		sl_num;
>> -	u32		tsq_buf_pg_sz;
>> -	u32		tpq_buf_pg_sz;
>> +	u32		llm_buf_pg_sz;
>>  	u32		chunk_sz;	/* chunk size in non multihop mode */
>>  	u64		flags;
>>  	u16		default_ceq_max_cnt;
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index a3f7dc5..e105e21 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -2062,7 +2062,7 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
>>  	caps->eqe_buf_pg_sz = 0;
>>  
>>  	/* Link Table */
>> -	caps->tsq_buf_pg_sz = 0;
>> +	caps->llm_buf_pg_sz = 0;
>>  
>>  	/* MR */
>>  	caps->pbl_ba_pg_sz = HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
>> @@ -2478,43 +2478,16 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
>>  	return ret;
>>  }
>>  
>> -static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
>> -				      enum hns_roce_link_table_type type)
>> +static void config_llm_table(struct hns_roce_buf *data_buf, void *cfg_buf)
>>  {
>> -	struct hns_roce_cmq_desc desc[2];
>> -	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
>> -	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
>> -	struct hns_roce_v2_priv *priv = hr_dev->priv;
>> -	struct hns_roce_link_table *link_tbl;
>> -	enum hns_roce_opcode_type opcode;
>>  	u32 i, next_ptr, page_num;
>> -	struct hns_roce_buf *buf;
>> +	__le64 *entry = cfg_buf;
>>  	dma_addr_t addr;
>> -	__le64 *entry;
>>  	u64 val;
>>  
>> -	switch (type) {
>> -	case TSQ_LINK_TABLE:
>> -		link_tbl = &priv->tsq;
>> -		opcode = HNS_ROCE_OPC_CFG_EXT_LLM;
>> -		break;
>> -	case TPQ_LINK_TABLE:
>> -		link_tbl = &priv->tpq;
>> -		opcode = HNS_ROCE_OPC_CFG_TMOUT_LLM;
>> -		break;
>> -	default:
>> -		return -EINVAL;
>> -	}
>> -
>> -	/* Setup data table block address to link table entry */
>> -	buf = link_tbl->buf;
>> -	page_num = buf->npages;
>> -	if (WARN_ON(page_num > HNS_ROCE_V2_EXT_LLM_MAX_DEPTH))
>> -		return -EINVAL;
> 
> You added these lines in previous patch. Please structure the patches in
> such way that they don't need to add->delete in same series.
> 
> Thanks
> 

Thank you. I will combine them into one patch.

Weihang
