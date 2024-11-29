Return-Path: <linux-rdma+bounces-6157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EB49DC0E7
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 09:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBD0164F3E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125216D9AF;
	Fri, 29 Nov 2024 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AlxGVzzd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD516D9B8
	for <linux-rdma@vger.kernel.org>; Fri, 29 Nov 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870482; cv=none; b=P7xa66iHUC9JlsfRI+nd+Qz4GJzE2wf1MGB68XUQXZ4ZOw8JyZZIrffFneGMO3D9BGh4LmZQwKWrgxzUxFIW5LyrBHKnP/Dh0FTwCF4gqpt1tCB2h+fzAL2HJYaLBAZWyRZnHKVJiv1K4Hvlt73YbRm8XMY0j/RTgfDzgJJ0/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870482; c=relaxed/simple;
	bh=zoSmQVGOPbRkahLn95CS9D4DVDN9oJObHSehWxBOd2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IL9SvVzD6zxDJuA9cpmMZXCjX55vSCB6IpfM6EePxN8ZSAxCxeYi7siwl7zwRsmn0yPCz2ZL5AA86EPCPM0svSl+IqqM7xANiM/XcVOxhY6/nGGNF8vLBIs855Lrq8JMSuYYaierXmEFkoMQ0Ume1aikgaNsDu014OU7/quCxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AlxGVzzd; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e109482b-45a5-49a1-888b-d7ed3eb3ec89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732870476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATMmZuHSWbtDDWk89qGOHWhXTZvsGQayG3Vk1yqnp74=;
	b=AlxGVzzdWqz88P6gu4FNFxUbHpVOFiKBmcEK7TF8yVTFm5KA1rIzkOn+FV18uiUcpkaSyp
	cdXtIs9vDbnPttlddYUJf2OCz7AdF11RGjEl3T09521hQVfL8RdmUfihyEeAPl8cPX8156
	kz48nAIDNvp9DpBTd+6hDU4WHt199Mk=
Date: Fri, 29 Nov 2024 09:54:33 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 2/8] RDMA/erdma: Add GID table management
 interfaces
To: Boshi Yu <boshiyu@linux.alibaba.com>, jgg@ziepe.ca, leon@kernel.org,
 chengyou@linux.alibaba.com
Cc: linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
 <20241126070351.92787-3-boshiyu@linux.alibaba.com>
 <580390cc-b4aa-4d72-86ae-ad1d24dd5b31@linux.dev>
 <Z0fW1JTJSl067TZP@xy-macbook.local>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Z0fW1JTJSl067TZP@xy-macbook.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 28.11.24 03:35, Boshi Yu wrote:
> On Tue, Nov 26, 2024 at 04:51:02PM +0100, Zhu Yanjun wrote:
>> 在 2024/11/26 7:59, Boshi Yu 写道:
>>> The erdma_add_gid() interface inserts a GID entry at the
>>> specified index. The erdma_del_gid() interface deletes the
>>> GID entry at the specified index. Additionally, programs
>>> can invoke the erdma_query_port() and erdma_get_port_immutable()
>>> interfaces to query the GID table length.
>>>
>>> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
>>> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
>>> ---
>>>    drivers/infiniband/hw/erdma/erdma.h       |  1 +
>>>    drivers/infiniband/hw/erdma/erdma_hw.h    | 28 +++++++++++-
>>>    drivers/infiniband/hw/erdma/erdma_main.c  |  3 ++
>>>    drivers/infiniband/hw/erdma/erdma_verbs.c | 56 +++++++++++++++++++++--
>>>    drivers/infiniband/hw/erdma/erdma_verbs.h | 12 +++++
>>>    5 files changed, 96 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
>>> index ad4dc1a4bdc7..42dabf674f5d 100644
>>> --- a/drivers/infiniband/hw/erdma/erdma.h
>>> +++ b/drivers/infiniband/hw/erdma/erdma.h
>>> @@ -148,6 +148,7 @@ struct erdma_devattr {
>>>    	u32 max_mr;
>>>    	u32 max_pd;
>>>    	u32 max_mw;
>>> +	u32 max_gid;
>>>    	u32 local_dma_key;
>>>    };
>>> diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
>>> index 970b392d4fb4..7e03c5f97501 100644
>>> --- a/drivers/infiniband/hw/erdma/erdma_hw.h
>>> +++ b/drivers/infiniband/hw/erdma/erdma_hw.h
>>> @@ -21,6 +21,9 @@
>>>    #define ERDMA_NUM_MSIX_VEC 32U
>>>    #define ERDMA_MSIX_VECTOR_CMDQ 0
>>> +/* RoCEv2 related */
>>> +#define ERDMA_ROCEV2_GID_SIZE 16
>>> +
>>>    /* erdma device protocol type */
>>>    enum erdma_proto_type {
>>>    	ERDMA_PROTO_IWARP = 0,
>>> @@ -143,7 +146,8 @@ enum CMDQ_RDMA_OPCODE {
>>>    	CMDQ_OPCODE_DESTROY_CQ = 5,
>>>    	CMDQ_OPCODE_REFLUSH = 6,
>>>    	CMDQ_OPCODE_REG_MR = 8,
>>> -	CMDQ_OPCODE_DEREG_MR = 9
>>> +	CMDQ_OPCODE_DEREG_MR = 9,
>>> +	CMDQ_OPCODE_SET_GID = 14,
>>>    };
>>>    enum CMDQ_COMMON_OPCODE {
>>> @@ -401,7 +405,29 @@ struct erdma_cmdq_query_stats_resp {
>>>    	u64 rx_pps_meter_drop_packets_cnt;
>>>    };
>>> +enum erdma_network_type {
>>> +	ERDMA_NETWORK_TYPE_IPV4 = 0,
>>> +	ERDMA_NETWORK_TYPE_IPV6 = 1,
>>> +};
>>
>> In the file include/rdma/ib_verbs.h
>>
>> "
>> ...
>>   183 enum rdma_network_type {
>> ...
>>   186     RDMA_NETWORK_IPV4,
>>   187     RDMA_NETWORK_IPV6
>>   188 };
>> ...
>> "
>> Not sure why the above RDMA_NETWORK_IPV4 and RDMA_NETWORK_IPV6 are not used.
>>
>> Zhu Yanjun
>>
> 
> Hi, Yanjun,
> 
> Given that the values for RDMA_NETWORK_IPV4 and RDMA_NETWORK_IPV6 are 2 and 3,
> respectively, we would need 2 bits to store the network type if we use them
> directly. However, since we only need to differentiate between IPv4 and IPv6
> for the RoCEv2 protocol, 1 bit is sufficient.

I can not get you. You mean, you want to use 1 bit to differentiate 
between IPv4 and IPv6. How to implement this idea? Can you show us the 
difference of 1 bit (enum erdma_network_type) and 2 bits (enum 
rdma_network_type) in driver?

Thanks,

Zhu Yanjun
> 
> Thanks,
> Boshi Yu
> 
>>> +
>>> +enum erdma_set_gid_op {
>>> +	ERDMA_SET_GID_OP_ADD = 0,
>>> +	ERDMA_SET_GID_OP_DEL = 1,
>>> +};
>>> +
>>> +/* set gid cfg */
>>> +#define ERDMA_CMD_SET_GID_SGID_IDX_MASK GENMASK(15, 0)
>>> +#define ERDMA_CMD_SET_GID_NTYPE_MASK BIT(16)
>>> +#define ERDMA_CMD_SET_GID_OP_MASK BIT(31)
>>> +
>>> +struct erdma_cmdq_set_gid_req {
>>> +	u64 hdr;
>>> +	u32 cfg;
>>> +	u8 gid[ERDMA_ROCEV2_GID_SIZE];
>>> +};
>>> +
>>>    /* cap qword 0 definition */
>>> +#define ERDMA_CMD_DEV_CAP_MAX_GID_MASK GENMASK_ULL(51, 48)
>>>    #define ERDMA_CMD_DEV_CAP_MAX_CQE_MASK GENMASK_ULL(47, 40)
>>>    #define ERDMA_CMD_DEV_CAP_FLAGS_MASK GENMASK_ULL(31, 24)
>>>    #define ERDMA_CMD_DEV_CAP_MAX_RECV_WR_MASK GENMASK_ULL(23, 16)
>>> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
>>> index b6706c74cd96..d72b85e8971d 100644
>>> --- a/drivers/infiniband/hw/erdma/erdma_main.c
>>> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
>>> @@ -404,6 +404,7 @@ static int erdma_dev_attrs_init(struct erdma_dev *dev)
>>>    	dev->attrs.max_mr_size = 1ULL << ERDMA_GET_CAP(MAX_MR_SIZE, cap0);
>>>    	dev->attrs.max_mw = 1 << ERDMA_GET_CAP(MAX_MW, cap1);
>>>    	dev->attrs.max_recv_wr = 1 << ERDMA_GET_CAP(MAX_RECV_WR, cap0);
>>> +	dev->attrs.max_gid = 1 << ERDMA_GET_CAP(MAX_GID, cap0);
>>>    	dev->attrs.local_dma_key = ERDMA_GET_CAP(DMA_LOCAL_KEY, cap1);
>>>    	dev->attrs.cc = ERDMA_GET_CAP(DEFAULT_CC, cap1);
>>>    	dev->attrs.max_qp = ERDMA_NQP_PER_QBLOCK * ERDMA_GET_CAP(QBLOCK, cap1);
>>> @@ -482,6 +483,8 @@ static void erdma_res_cb_free(struct erdma_dev *dev)
>>>    static const struct ib_device_ops erdma_device_ops_rocev2 = {
>>>    	.get_link_layer = erdma_get_link_layer,
>>> +	.add_gid = erdma_add_gid,
>>> +	.del_gid = erdma_del_gid,
>>>    };
>>>    static const struct ib_device_ops erdma_device_ops_iwarp = {
>>> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
>>> index 3b7e55515cfd..9944eed584ec 100644
>>> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
>>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
>>> @@ -367,7 +367,13 @@ int erdma_query_port(struct ib_device *ibdev, u32 port,
>>>    	memset(attr, 0, sizeof(*attr));
>>> -	attr->gid_tbl_len = 1;
>>> +	if (erdma_device_iwarp(dev)) {
>>> +		attr->gid_tbl_len = 1;
>>> +	} else {
>>> +		attr->gid_tbl_len = dev->attrs.max_gid;
>>> +		attr->ip_gids = true;
>>> +	}
>>> +
>>>    	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
>>>    	attr->max_msg_sz = -1;
>>> @@ -399,14 +405,14 @@ int erdma_get_port_immutable(struct ib_device *ibdev, u32 port,
>>>    	if (erdma_device_iwarp(dev)) {
>>>    		port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
>>> +		port_immutable->gid_tbl_len = 1;
>>>    	} else {
>>>    		port_immutable->core_cap_flags =
>>>    			RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
>>>    		port_immutable->max_mad_size = IB_MGMT_MAD_SIZE;
>>> +		port_immutable->gid_tbl_len = dev->attrs.max_gid;
>>>    	}
>>> -	port_immutable->gid_tbl_len = 1;
>>> -
>>>    	return 0;
>>>    }
>>> @@ -1853,3 +1859,47 @@ enum rdma_link_layer erdma_get_link_layer(struct ib_device *ibdev, u32 port_num)
>>>    {
>>>    	return IB_LINK_LAYER_ETHERNET;
>>>    }
>>> +
>>> +static int erdma_set_gid(struct erdma_dev *dev, u8 op, u32 idx,
>>> +			 const union ib_gid *gid)
>>> +{
>>> +	struct erdma_cmdq_set_gid_req req;
>>> +	u8 ntype;
>>> +
>>> +	req.cfg = FIELD_PREP(ERDMA_CMD_SET_GID_SGID_IDX_MASK, idx) |
>>> +		  FIELD_PREP(ERDMA_CMD_SET_GID_OP_MASK, op);
>>> +
>>> +	if (op == ERDMA_SET_GID_OP_ADD) {
>>> +		if (ipv6_addr_v4mapped((struct in6_addr *)gid))
>>> +			ntype = ERDMA_NETWORK_TYPE_IPV4;
>>> +		else
>>> +			ntype = ERDMA_NETWORK_TYPE_IPV6;
>>> +
>>> +		req.cfg |= FIELD_PREP(ERDMA_CMD_SET_GID_NTYPE_MASK, ntype);
>>> +
>>> +		memcpy(&req.gid, gid, ERDMA_ROCEV2_GID_SIZE);
>>> +	}
>>> +
>>> +	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
>>> +				CMDQ_OPCODE_SET_GID);
>>> +	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
>>> +}
>>> +
>>> +int erdma_add_gid(const struct ib_gid_attr *attr, void **context)
>>> +{
>>> +	struct erdma_dev *dev = to_edev(attr->device);
>>> +	int ret;
>>> +
>>> +	ret = erdma_check_gid_attr(attr);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return erdma_set_gid(dev, ERDMA_SET_GID_OP_ADD, attr->index,
>>> +			     &attr->gid);
>>> +}
>>> +
>>> +int erdma_del_gid(const struct ib_gid_attr *attr, void **context)
>>> +{
>>> +	return erdma_set_gid(to_edev(attr->device), ERDMA_SET_GID_OP_DEL,
>>> +			     attr->index, NULL);
>>> +}
>>> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
>>> index 90e2b35a0973..23cfeaf79eaa 100644
>>> --- a/drivers/infiniband/hw/erdma/erdma_verbs.h
>>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
>>> @@ -326,6 +326,16 @@ static inline struct erdma_cq *to_ecq(struct ib_cq *ibcq)
>>>    	return container_of(ibcq, struct erdma_cq, ibcq);
>>>    }
>>> +static inline int erdma_check_gid_attr(const struct ib_gid_attr *attr)
>>> +{
>>> +	u8 ntype = rdma_gid_attr_network_type(attr);
>>> +
>>> +	if (ntype != RDMA_NETWORK_IPV4 && ntype != RDMA_NETWORK_IPV6)
>>> +		return -EINVAL;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static inline struct erdma_user_mmap_entry *
>>>    to_emmap(struct rdma_user_mmap_entry *ibmmap)
>>>    {
>>> @@ -382,5 +392,7 @@ int erdma_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
>>>    		       u32 port, int index);
>>>    enum rdma_link_layer erdma_get_link_layer(struct ib_device *ibdev,
>>>    					  u32 port_num);
>>> +int erdma_add_gid(const struct ib_gid_attr *attr, void **context);
>>> +int erdma_del_gid(const struct ib_gid_attr *attr, void **context);
>>>    #endif


