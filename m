Return-Path: <linux-rdma+bounces-1095-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08FC85F1BB
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Feb 2024 08:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3521C20F95
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Feb 2024 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1E81755B;
	Thu, 22 Feb 2024 07:06:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C77F9E8;
	Thu, 22 Feb 2024 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585594; cv=none; b=t1qqkOnFTmyDGCXckcIopp3HPGII+D91LP5Af2hCJzvpQDucWgsQiFSM8pTjRsRB60oma7VyuNwgAZPYV8Cg5N3yvKj2EsHW70JVL+1Noh9gZNJDXbniyOGAPhHnDcJlCddOfj4zFQE6jo0PHcR+xU7kKIvO1zzwvd67zsRGyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585594; c=relaxed/simple;
	bh=IItrBRW1vlpkqCiIwyvCGuHX3RHvkCR+JmgXBd/0jrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ehsM/QnE7mHJUcmG4vTbqf3VdldwGE5yCDKnMBWxkFSY+4iIOdomio9OTSmKzRBRSOR6H6EiIVjhE+zP7oSqXaTYkjQf/zp7W6jJpa2JsELAaRcfqeeg3vaAenmf54CfF4swJW4w/AWIByQGGjJrjfNC+Q1T/ohy7q9z4oBP5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TgPLL4TFhz1vv16;
	Thu, 22 Feb 2024 15:05:46 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 277661A0172;
	Thu, 22 Feb 2024 15:06:21 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 15:06:20 +0800
Message-ID: <26ea175c-fa31-720c-2ac3-41abcb4d398a@hisilicon.com>
Date: Thu, 22 Feb 2024 15:06:20 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 for-next 2/2] RDMA/hns: Support userspace configuring
 congestion control algorithm with QP granularity
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240208035038.94668-1-huangjunxian6@hisilicon.com>
 <20240208035038.94668-3-huangjunxian6@hisilicon.com>
 <20240221155248.GD13491@ziepe.ca>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240221155248.GD13491@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/2/21 23:52, Jason Gunthorpe wrote:
> On Thu, Feb 08, 2024 at 11:50:38AM +0800, Junxian Huang wrote:
>> Support userspace configuring congestion control algorithm with
>> QP granularity. If the algorithm is not specified in userspace,
>> use the default one.
>>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h | 23 +++++--
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 14 +---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 +-
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  3 +
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 71 +++++++++++++++++++++
>>  include/uapi/rdma/hns-abi.h                 | 17 +++++
>>  6 files changed, 112 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index c88ba7e053bf..55f2f54e15fb 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -594,11 +594,19 @@ struct hns_roce_work {
>>  	u32 queue_num;
>>  };
>>  
>> -enum cong_type {
>> -	CONG_TYPE_DCQCN,
>> -	CONG_TYPE_LDCP,
>> -	CONG_TYPE_HC3,
>> -	CONG_TYPE_DIP,
>> +enum hns_roce_scc_algo {
>> +	HNS_ROCE_SCC_ALGO_DCQCN = 0,
>> +	HNS_ROCE_SCC_ALGO_LDCP,
>> +	HNS_ROCE_SCC_ALGO_HC3,
>> +	HNS_ROCE_SCC_ALGO_DIP,
>> +	HNS_ROCE_SCC_ALGO_TOTAL,
>> +};
>> +
>> +enum hns_roce_cong_type {
>> +	CONG_TYPE_DCQCN = 1 << HNS_ROCE_SCC_ALGO_DCQCN,
>> +	CONG_TYPE_LDCP = 1 << HNS_ROCE_SCC_ALGO_LDCP,
>> +	CONG_TYPE_HC3 = 1 << HNS_ROCE_SCC_ALGO_HC3,
>> +	CONG_TYPE_DIP = 1 << HNS_ROCE_SCC_ALGO_DIP,
>>  };
>>  
>>  struct hns_roce_qp {
>> @@ -644,7 +652,7 @@ struct hns_roce_qp {
>>  	struct list_head	sq_node; /* all send qps are on a list */
>>  	struct hns_user_mmap_entry *dwqe_mmap_entry;
>>  	u32			config;
>> -	enum cong_type		cong_type;
>> +	enum hns_roce_cong_type	cong_type;
>>  };
>>  
>>  struct hns_roce_ib_iboe {
>> @@ -845,7 +853,8 @@ struct hns_roce_caps {
>>  	u16		default_aeq_period;
>>  	u16		default_aeq_arm_st;
>>  	u16		default_ceq_arm_st;
>> -	enum cong_type	cong_type;
>> +	u8		cong_cap;
>> +	enum hns_roce_cong_type	default_cong_type;
>>  };
>>  
>>  enum hns_roce_device_state {
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 42e28586cefa..21532f213b0f 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -2209,11 +2209,12 @@ static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
>>  	caps->max_wqes = 1 << le16_to_cpu(resp_c->sq_depth);
>>  
>>  	caps->num_srqs = 1 << hr_reg_read(resp_d, PF_CAPS_D_NUM_SRQS);
>> -	caps->cong_type = hr_reg_read(resp_d, PF_CAPS_D_CONG_TYPE);
>> +	caps->cong_cap = hr_reg_read(resp_d, PF_CAPS_D_CONG_CAP);
>>  	caps->max_srq_wrs = 1 << le16_to_cpu(resp_d->srq_depth);
>>  	caps->ceqe_depth = 1 << hr_reg_read(resp_d, PF_CAPS_D_CEQ_DEPTH);
>>  	caps->num_comp_vectors = hr_reg_read(resp_d, PF_CAPS_D_NUM_CEQS);
>>  	caps->aeqe_depth = 1 << hr_reg_read(resp_d, PF_CAPS_D_AEQ_DEPTH);
>> +	caps->default_cong_type = hr_reg_read(resp_d, PF_CAPS_D_DEFAULT_ALG);
>>  	caps->reserved_pds = hr_reg_read(resp_d, PF_CAPS_D_RSV_PDS);
>>  	caps->num_uars = 1 << hr_reg_read(resp_d, PF_CAPS_D_NUM_UARS);
>>  	caps->reserved_qps = hr_reg_read(resp_d, PF_CAPS_D_RSV_QPS);
>> @@ -4737,14 +4738,8 @@ enum {
>>  static int check_cong_type(struct ib_qp *ibqp,
>>  			   struct hns_roce_congestion_algorithm *cong_alg)
>>  {
>> -	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
>>  	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
>>  
>> -	if (ibqp->qp_type == IB_QPT_UD || ibqp->qp_type == IB_QPT_GSI)
>> -		hr_qp->cong_type = CONG_TYPE_DCQCN;
>> -	else
>> -		hr_qp->cong_type = hr_dev->caps.cong_type;
>> -
>>  	/* different congestion types match different configurations */
>>  	switch (hr_qp->cong_type) {
>>  	case CONG_TYPE_DCQCN:
>> @@ -4772,9 +4767,6 @@ static int check_cong_type(struct ib_qp *ibqp,
>>  		cong_alg->wnd_mode_sel = WND_LIMIT;
>>  		break;
>>  	default:
>> -		ibdev_warn(&hr_dev->ib_dev,
>> -			   "invalid type(%u) for congestion selection.\n",
>> -			   hr_qp->cong_type);
>>  		hr_qp->cong_type = CONG_TYPE_DCQCN;
>>  		cong_alg->alg_sel = CONG_DCQCN;
>>  		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
>> @@ -4807,7 +4799,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
>>  		return ret;
>>  
>>  	hr_reg_write(context, QPC_CONG_ALGO_TMPL_ID, hr_dev->cong_algo_tmpl_id +
>> -		     hr_qp->cong_type * HNS_ROCE_CONG_SIZE);
>> +		     ilog2(hr_qp->cong_type) * HNS_ROCE_CONG_SIZE);
>>  	hr_reg_clear(qpc_mask, QPC_CONG_ALGO_TMPL_ID);
>>  	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SEL, cong_field.alg_sel);
>>  	hr_reg_clear(&qpc_mask->ext, QPCEX_CONG_ALG_SEL);
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> index cd97cbee682a..359a74672ba1 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> @@ -1214,12 +1214,13 @@ struct hns_roce_query_pf_caps_d {
>>  #define PF_CAPS_D_RQWQE_HOP_NUM PF_CAPS_D_FIELD_LOC(21, 20)
>>  #define PF_CAPS_D_EX_SGE_HOP_NUM PF_CAPS_D_FIELD_LOC(23, 22)
>>  #define PF_CAPS_D_SQWQE_HOP_NUM PF_CAPS_D_FIELD_LOC(25, 24)
>> -#define PF_CAPS_D_CONG_TYPE PF_CAPS_D_FIELD_LOC(29, 26)
>> +#define PF_CAPS_D_CONG_CAP PF_CAPS_D_FIELD_LOC(29, 26)
>>  #define PF_CAPS_D_CEQ_DEPTH PF_CAPS_D_FIELD_LOC(85, 64)
>>  #define PF_CAPS_D_NUM_CEQS PF_CAPS_D_FIELD_LOC(95, 86)
>>  #define PF_CAPS_D_AEQ_DEPTH PF_CAPS_D_FIELD_LOC(117, 96)
>>  #define PF_CAPS_D_AEQ_ARM_ST PF_CAPS_D_FIELD_LOC(119, 118)
>>  #define PF_CAPS_D_CEQ_ARM_ST PF_CAPS_D_FIELD_LOC(121, 120)
>> +#define PF_CAPS_D_DEFAULT_ALG PF_CAPS_D_FIELD_LOC(127, 122)
>>  #define PF_CAPS_D_RSV_PDS PF_CAPS_D_FIELD_LOC(147, 128)
>>  #define PF_CAPS_D_NUM_UARS PF_CAPS_D_FIELD_LOC(155, 148)
>>  #define PF_CAPS_D_RSV_QPS PF_CAPS_D_FIELD_LOC(179, 160)
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
>> index b55fe6911f9f..e5b678814f58 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
>> @@ -394,6 +394,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
>>  			resp.config |= HNS_ROCE_RSP_CQE_INLINE_FLAGS;
>>  	}
>>  
>> +	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
>> +		resp.congest_type  = hr_dev->caps.cong_cap;
>> +
>>  	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
>>  	if (ret)
>>  		goto error_out;
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> index 31b147210688..e22911d6b6a9 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> @@ -1004,6 +1004,70 @@ static void free_kernel_wrid(struct hns_roce_qp *hr_qp)
>>  	kfree(hr_qp->sq.wrid);
>>  }
>>  
>> +static void default_congest_type(struct hns_roce_dev *hr_dev,
>> +				 struct hns_roce_qp *hr_qp)
>> +{
>> +	struct hns_roce_caps *caps = &hr_dev->caps;
>> +
>> +	if (hr_qp->ibqp.qp_type == IB_QPT_UD ||
>> +	    hr_qp->ibqp.qp_type == IB_QPT_GSI)
>> +		hr_qp->cong_type = CONG_TYPE_DCQCN;
>> +	else
>> +		hr_qp->cong_type = 1 << caps->default_cong_type;
>> +}
>> +
>> +static int set_congest_type(struct hns_roce_qp *hr_qp,
>> +			    struct hns_roce_ib_create_qp *ucmd)
>> +{
>> +	struct hns_roce_dev *hr_dev = to_hr_dev(hr_qp->ibqp.device);
>> +
>> +	switch (ucmd->cong_type_flags) {
>> +	case HNS_ROCE_CREATE_QP_FLAGS_DCQCN:
>> +		hr_qp->cong_type = CONG_TYPE_DCQCN;
>> +		break;
>> +	case HNS_ROCE_CREATE_QP_FLAGS_LDCP:
>> +		hr_qp->cong_type = CONG_TYPE_LDCP;
>> +		break;
>> +	case HNS_ROCE_CREATE_QP_FLAGS_HC3:
>> +		hr_qp->cong_type = CONG_TYPE_HC3;
>> +		break;
>> +	case HNS_ROCE_CREATE_QP_FLAGS_DIP:
>> +		hr_qp->cong_type = CONG_TYPE_DIP;
>> +		break;
>> +	default:
>> +		hr_qp->cong_type = 0;
>> +	}
>> +
>> +	if (!(hr_qp->cong_type & hr_dev->caps.cong_cap)) {
>> +		ibdev_err_ratelimited(&hr_dev->ib_dev,
>> +				      "Unsupported congest type 0x%x, cong_cap = 0x%x.\n",
>> +				      hr_qp->cong_type, hr_dev->caps.cong_cap);
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (hr_qp->ibqp.qp_type == IB_QPT_UD &&
>> +	    !(hr_qp->cong_type & CONG_TYPE_DCQCN)) {
>> +		ibdev_err_ratelimited(&hr_dev->ib_dev,
>> +				      "Only DCQCN supported for UD. Unsupported congest type 0x%x.\n",
>> +				      hr_qp->cong_type);
> 
> Do not print kernel messages triggered by bad userspace input.
> 
> Jason
> 

OK. Will remove these printing in next version.

>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int set_congest_param(struct hns_roce_dev *hr_dev,
>> +			     struct hns_roce_qp *hr_qp,
>> +			     struct hns_roce_ib_create_qp *ucmd)
>> +{
>> +	if (ucmd->comp_mask & HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE)
>> +		return set_congest_type(hr_qp, ucmd);
>> +
>> +	default_congest_type(hr_dev, hr_qp);
>> +
>> +	return 0;
>> +}
>> +
>>  static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>>  			struct ib_qp_init_attr *init_attr,
>>  			struct ib_udata *udata,
>> @@ -1026,6 +1090,9 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>>  		return ret;
>>  	}
>>  
>> +	if (init_attr->qp_type == IB_QPT_XRC_TGT)
>> +		default_congest_type(hr_dev, hr_qp);
>> +
>>  	if (udata) {
>>  		ret = ib_copy_from_udata(ucmd, udata,
>>  					 min(udata->inlen, sizeof(*ucmd)));
>> @@ -1043,6 +1110,10 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>>  			ibdev_err(ibdev,
>>  				  "failed to set user SQ size, ret = %d.\n",
>>  				  ret);
>> +
>> +		ret = set_congest_param(hr_dev, hr_qp, ucmd);
>> +		if (ret)
>> +			return ret;
>>  	} else {
>>  		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
>>  			hr_qp->config = HNS_ROCE_EXSGE_FLAGS;
>> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
>> index c996e151081e..757095a6c6fc 100644
>> --- a/include/uapi/rdma/hns-abi.h
>> +++ b/include/uapi/rdma/hns-abi.h
>> @@ -81,6 +81,9 @@ struct hns_roce_ib_create_qp {
>>  	__u8    sq_no_prefetch;
>>  	__u8    reserved[5];
>>  	__aligned_u64 sdb_addr;
>> +	__aligned_u64 comp_mask; /* Use enum hns_roce_create_qp_comp_mask */
>> +	__aligned_u64 create_flags;
>> +	__aligned_u64 cong_type_flags;
>>  };
>>  
>>  enum hns_roce_qp_cap_flags {
>> @@ -107,6 +110,17 @@ enum {
>>  	HNS_ROCE_RSP_CQE_INLINE_FLAGS = 1 << 2,
>>  };
>>  
>> +enum hns_roce_congest_type_flags {
>> +	HNS_ROCE_CREATE_QP_FLAGS_DCQCN = 1 << 0,
>> +	HNS_ROCE_CREATE_QP_FLAGS_LDCP = 1 << 1,
>> +	HNS_ROCE_CREATE_QP_FLAGS_HC3 = 1 << 2,
>> +	HNS_ROCE_CREATE_QP_FLAGS_DIP = 1 << 3,
>> +};
> 
> Why are these bit flags if they are exclusive?
> 

Our FW uses bit flags. Although there is no direct relationship between
FW and ABI, but from the perspective of readability, bit flags are also
used consistently here in ABI.

>> +
>> +enum hns_roce_create_qp_comp_mask {
>> +	HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE = 1 << 1,
> 
> Why 1<<1 not 1<<0?

This is to keep consistent with our internal ABI, there are some
features not upstream yet.

> 
> These are in the wrong order in the file too, they should be before
> their first "use", ie move above struct hns_roce_ib_create_qp
> 

OK.

>> @@ -114,6 +128,9 @@ struct hns_roce_ib_alloc_ucontext_resp {
>>  	__u32	reserved;
>>  	__u32	config;
>>  	__u32	max_inline_data;
>> +	__u8	reserved0;
>> +	__u8	congest_type;
> 
> Why this layout?
> > Jason

Same as the 1<<1 issue, to keep consistent with our internal ABI.

Thanks,
Junxian

