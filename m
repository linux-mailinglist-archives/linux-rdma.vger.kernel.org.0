Return-Path: <linux-rdma+bounces-6160-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59319DC2B3
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 12:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667222823F8
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A01B1991CF;
	Fri, 29 Nov 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tp3MSw5m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C01586C8
	for <linux-rdma@vger.kernel.org>; Fri, 29 Nov 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879120; cv=none; b=nv385zqPtVLZRghsH67qlwr8lPzNY3sTv/s8yRRFaWjw4j5REqOpc7/GXtLxwIpF6+nuHco1NnXIvskC/1ScfZIxWoYDYXatYRcwa17WowRjbLprDW6cNak3ovuUToiwt4LDrwXNz9myLdXxKCqY2/8Z4P/oIDni38tyxq66voU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879120; c=relaxed/simple;
	bh=nRrjBeALFxGgBZar3CGJPOdu/k2Ciz3s0PYUfI+FiYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=I00nzlayLh791xPxyvtViPye9yg9e0oXluQDHcGT5yJQWq6FuytGOA19NXer+Ah/F5f4kbPq16dzEnS1EH0+n1kTwey71rRFyF3SOy0zvWGfA5yZaSbroF/kA1udzHABHspp1sUtuSuFoCfEhLSl8Iv4liDLrgOqf0T0mkbGWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tp3MSw5m; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732879106; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JCt7YlwwcZna7XwvvuRPwyyDDzRgyM1+v9LTTCMR9Ow=;
	b=Tp3MSw5m3yM3zmMmrq/dxcY7KhJb4JC4h5VIpXqMqhWfRvnJMjqT34lkRmM6p7MaHq3bU77E2NaJublqyYwXuA8+p87on4JrTZwX36HpvzLWY2XFpTABTygpY5RemygJvbg5/u0JdMsWHK5Yx0KYjzLSi77PJeqsmqVvIziQXJU=
Received: from 30.120.153.200(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WKU5ces_1732879105 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 Nov 2024 19:18:26 +0800
Message-ID: <c86e8468-2344-41f4-bfd8-c1796742bfd5@linux.alibaba.com>
Date: Fri, 29 Nov 2024 19:18:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 2/8] RDMA/erdma: Add GID table management
 interfaces
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 chengyou@linux.alibaba.com
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
 <20241126070351.92787-3-boshiyu@linux.alibaba.com>
 <580390cc-b4aa-4d72-86ae-ad1d24dd5b31@linux.dev>
 <Z0fW1JTJSl067TZP@xy-macbook.local>
 <e109482b-45a5-49a1-888b-d7ed3eb3ec89@linux.dev>
From: Boshi Yu <boshiyu@linux.alibaba.com>
Cc: linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com
In-Reply-To: <e109482b-45a5-49a1-888b-d7ed3eb3ec89@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/29 16:54, Zhu Yanjun wrote:
> On 28.11.24 03:35, Boshi Yu wrote:
>> On Tue, Nov 26, 2024 at 04:51:02PM +0100, Zhu Yanjun wrote:
>>> 在 2024/11/26 7:59, Boshi Yu 写道:
>>>> The erdma_add_gid() interface inserts a GID entry at the
>>>> specified index. The erdma_del_gid() interface deletes the
>>>> GID entry at the specified index. Additionally, programs
>>>> can invoke the erdma_query_port() and erdma_get_port_immutable()
>>>> interfaces to query the GID table length.
>>>>
>>>> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
>>>> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
>>>> ---
>>>>    drivers/infiniband/hw/erdma/erdma.h       |  1 +
>>>>    drivers/infiniband/hw/erdma/erdma_hw.h    | 28 +++++++++++-
>>>>    drivers/infiniband/hw/erdma/erdma_main.c  |  3 ++
>>>>    drivers/infiniband/hw/erdma/erdma_verbs.c | 56 ++++++++++++++++++ 
>>>> +++--
>>>>    drivers/infiniband/hw/erdma/erdma_verbs.h | 12 +++++
>>>>    5 files changed, 96 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/ 
>>>> infiniband/hw/erdma/erdma.h
>>>> index ad4dc1a4bdc7..42dabf674f5d 100644
>>>> --- a/drivers/infiniband/hw/erdma/erdma.h
>>>> +++ b/drivers/infiniband/hw/erdma/erdma.h
>>>> @@ -148,6 +148,7 @@ struct erdma_devattr {
>>>>        u32 max_mr;
>>>>        u32 max_pd;
>>>>        u32 max_mw;
>>>> +    u32 max_gid;
>>>>        u32 local_dma_key;
>>>>    };
>>>> diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/ 
>>>> infiniband/hw/erdma/erdma_hw.h
>>>> index 970b392d4fb4..7e03c5f97501 100644
>>>> --- a/drivers/infiniband/hw/erdma/erdma_hw.h
>>>> +++ b/drivers/infiniband/hw/erdma/erdma_hw.h
>>>> @@ -21,6 +21,9 @@
>>>>    #define ERDMA_NUM_MSIX_VEC 32U
>>>>    #define ERDMA_MSIX_VECTOR_CMDQ 0
>>>> +/* RoCEv2 related */
>>>> +#define ERDMA_ROCEV2_GID_SIZE 16
>>>> +
>>>>    /* erdma device protocol type */
>>>>    enum erdma_proto_type {
>>>>        ERDMA_PROTO_IWARP = 0,
>>>> @@ -143,7 +146,8 @@ enum CMDQ_RDMA_OPCODE {
>>>>        CMDQ_OPCODE_DESTROY_CQ = 5,
>>>>        CMDQ_OPCODE_REFLUSH = 6,
>>>>        CMDQ_OPCODE_REG_MR = 8,
>>>> -    CMDQ_OPCODE_DEREG_MR = 9
>>>> +    CMDQ_OPCODE_DEREG_MR = 9,
>>>> +    CMDQ_OPCODE_SET_GID = 14,
>>>>    };
>>>>    enum CMDQ_COMMON_OPCODE {
>>>> @@ -401,7 +405,29 @@ struct erdma_cmdq_query_stats_resp {
>>>>        u64 rx_pps_meter_drop_packets_cnt;
>>>>    };
>>>> +enum erdma_network_type {
>>>> +    ERDMA_NETWORK_TYPE_IPV4 = 0,
>>>> +    ERDMA_NETWORK_TYPE_IPV6 = 1,
>>>> +};
>>>
>>> In the file include/rdma/ib_verbs.h
>>>
>>> "
>>> ...
>>>   183 enum rdma_network_type {
>>> ...
>>>   186     RDMA_NETWORK_IPV4,
>>>   187     RDMA_NETWORK_IPV6
>>>   188 };
>>> ...
>>> "
>>> Not sure why the above RDMA_NETWORK_IPV4 and RDMA_NETWORK_IPV6 are 
>>> not used.
>>>
>>> Zhu Yanjun
>>>
>>
>> Hi, Yanjun,
>>
>> Given that the values for RDMA_NETWORK_IPV4 and RDMA_NETWORK_IPV6 are 
>> 2 and 3,
>> respectively, we would need 2 bits to store the network type if we use 
>> them
>> directly. However, since we only need to differentiate between IPv4 
>> and IPv6
>> for the RoCEv2 protocol, 1 bit is sufficient.
> 
> I can not get you. You mean, you want to use 1 bit to differentiate 
> between IPv4 and IPv6. How to implement this idea? Can you show us the 
> difference of 1 bit (enum erdma_network_type) and 2 bits (enum 
> rdma_network_type) in driver?
> 
> Thanks,
> 
> Zhu Yanjun

Hi, Yanjun,

I'm sorry for not explaining this issue clearly. The enum 
erdma_network_type is actually a convention between the erdma hardware 
and the erdma driver. We just want to use fewer bits to pass the 
information to the hardware, independent of the kernel definition.

Thanks,

Boshi Yu

>>
>> Thanks,
>> Boshi Yu
>>
>>>> +
>>>> +enum erdma_set_gid_op {
>>>> +    ERDMA_SET_GID_OP_ADD = 0,
>>>> +    ERDMA_SET_GID_OP_DEL = 1,
>>>> +};
>>>> +
>>>> +/* set gid cfg */
>>>> +#define ERDMA_CMD_SET_GID_SGID_IDX_MASK GENMASK(15, 0)
>>>> +#define ERDMA_CMD_SET_GID_NTYPE_MASK BIT(16)
>>>> +#define ERDMA_CMD_SET_GID_OP_MASK BIT(31)
>>>> +
>>>> +struct erdma_cmdq_set_gid_req {
>>>> +    u64 hdr;
>>>> +    u32 cfg;
>>>> +    u8 gid[ERDMA_ROCEV2_GID_SIZE];
>>>> +};
>>>> +
>>>>    /* cap qword 0 definition */
>>>> +#define ERDMA_CMD_DEV_CAP_MAX_GID_MASK GENMASK_ULL(51, 48)
>>>>    #define ERDMA_CMD_DEV_CAP_MAX_CQE_MASK GENMASK_ULL(47, 40)
>>>>    #define ERDMA_CMD_DEV_CAP_FLAGS_MASK GENMASK_ULL(31, 24)
>>>>    #define ERDMA_CMD_DEV_CAP_MAX_RECV_WR_MASK GENMASK_ULL(23, 16)
>>>> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/ 
>>>> infiniband/hw/erdma/erdma_main.c
>>>> index b6706c74cd96..d72b85e8971d 100644
>>>> --- a/drivers/infiniband/hw/erdma/erdma_main.c
>>>> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
>>>> @@ -404,6 +404,7 @@ static int erdma_dev_attrs_init(struct erdma_dev 
>>>> *dev)
>>>>        dev->attrs.max_mr_size = 1ULL << ERDMA_GET_CAP(MAX_MR_SIZE, 
>>>> cap0);
>>>>        dev->attrs.max_mw = 1 << ERDMA_GET_CAP(MAX_MW, cap1);
>>>>        dev->attrs.max_recv_wr = 1 << ERDMA_GET_CAP(MAX_RECV_WR, cap0);
>>>> +    dev->attrs.max_gid = 1 << ERDMA_GET_CAP(MAX_GID, cap0);
>>>>        dev->attrs.local_dma_key = ERDMA_GET_CAP(DMA_LOCAL_KEY, cap1);
>>>>        dev->attrs.cc = ERDMA_GET_CAP(DEFAULT_CC, cap1);
>>>>        dev->attrs.max_qp = ERDMA_NQP_PER_QBLOCK * 
>>>> ERDMA_GET_CAP(QBLOCK, cap1);
>>>> @@ -482,6 +483,8 @@ static void erdma_res_cb_free(struct erdma_dev 
>>>> *dev)
>>>>    static const struct ib_device_ops erdma_device_ops_rocev2 = {
>>>>        .get_link_layer = erdma_get_link_layer,
>>>> +    .add_gid = erdma_add_gid,
>>>> +    .del_gid = erdma_del_gid,
>>>>    };
>>>>    static const struct ib_device_ops erdma_device_ops_iwarp = {
>>>> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/ 
>>>> infiniband/hw/erdma/erdma_verbs.c
>>>> index 3b7e55515cfd..9944eed584ec 100644
>>>> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
>>>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
>>>> @@ -367,7 +367,13 @@ int erdma_query_port(struct ib_device *ibdev, 
>>>> u32 port,
>>>>        memset(attr, 0, sizeof(*attr));
>>>> -    attr->gid_tbl_len = 1;
>>>> +    if (erdma_device_iwarp(dev)) {
>>>> +        attr->gid_tbl_len = 1;
>>>> +    } else {
>>>> +        attr->gid_tbl_len = dev->attrs.max_gid;
>>>> +        attr->ip_gids = true;
>>>> +    }
>>>> +
>>>>        attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
>>>>        attr->max_msg_sz = -1;
>>>> @@ -399,14 +405,14 @@ int erdma_get_port_immutable(struct ib_device 
>>>> *ibdev, u32 port,
>>>>        if (erdma_device_iwarp(dev)) {
>>>>            port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
>>>> +        port_immutable->gid_tbl_len = 1;
>>>>        } else {
>>>>            port_immutable->core_cap_flags =
>>>>                RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
>>>>            port_immutable->max_mad_size = IB_MGMT_MAD_SIZE;
>>>> +        port_immutable->gid_tbl_len = dev->attrs.max_gid;
>>>>        }
>>>> -    port_immutable->gid_tbl_len = 1;
>>>> -
>>>>        return 0;
>>>>    }
>>>> @@ -1853,3 +1859,47 @@ enum rdma_link_layer 
>>>> erdma_get_link_layer(struct ib_device *ibdev, u32 port_num)
>>>>    {
>>>>        return IB_LINK_LAYER_ETHERNET;
>>>>    }
>>>> +
>>>> +static int erdma_set_gid(struct erdma_dev *dev, u8 op, u32 idx,
>>>> +             const union ib_gid *gid)
>>>> +{
>>>> +    struct erdma_cmdq_set_gid_req req;
>>>> +    u8 ntype;
>>>> +
>>>> +    req.cfg = FIELD_PREP(ERDMA_CMD_SET_GID_SGID_IDX_MASK, idx) |
>>>> +          FIELD_PREP(ERDMA_CMD_SET_GID_OP_MASK, op);
>>>> +
>>>> +    if (op == ERDMA_SET_GID_OP_ADD) {
>>>> +        if (ipv6_addr_v4mapped((struct in6_addr *)gid))
>>>> +            ntype = ERDMA_NETWORK_TYPE_IPV4;
>>>> +        else
>>>> +            ntype = ERDMA_NETWORK_TYPE_IPV6;
>>>> +
>>>> +        req.cfg |= FIELD_PREP(ERDMA_CMD_SET_GID_NTYPE_MASK, ntype);
>>>> +
>>>> +        memcpy(&req.gid, gid, ERDMA_ROCEV2_GID_SIZE);
>>>> +    }
>>>> +
>>>> +    erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
>>>> +                CMDQ_OPCODE_SET_GID);
>>>> +    return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, 
>>>> NULL);
>>>> +}
>>>> +
>>>> +int erdma_add_gid(const struct ib_gid_attr *attr, void **context)
>>>> +{
>>>> +    struct erdma_dev *dev = to_edev(attr->device);
>>>> +    int ret;
>>>> +
>>>> +    ret = erdma_check_gid_attr(attr);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return erdma_set_gid(dev, ERDMA_SET_GID_OP_ADD, attr->index,
>>>> +                 &attr->gid);
>>>> +}
>>>> +
>>>> +int erdma_del_gid(const struct ib_gid_attr *attr, void **context)
>>>> +{
>>>> +    return erdma_set_gid(to_edev(attr->device), ERDMA_SET_GID_OP_DEL,
>>>> +                 attr->index, NULL);
>>>> +}
>>>> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/ 
>>>> infiniband/hw/erdma/erdma_verbs.h
>>>> index 90e2b35a0973..23cfeaf79eaa 100644
>>>> --- a/drivers/infiniband/hw/erdma/erdma_verbs.h
>>>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
>>>> @@ -326,6 +326,16 @@ static inline struct erdma_cq *to_ecq(struct 
>>>> ib_cq *ibcq)
>>>>        return container_of(ibcq, struct erdma_cq, ibcq);
>>>>    }
>>>> +static inline int erdma_check_gid_attr(const struct ib_gid_attr *attr)
>>>> +{
>>>> +    u8 ntype = rdma_gid_attr_network_type(attr);
>>>> +
>>>> +    if (ntype != RDMA_NETWORK_IPV4 && ntype != RDMA_NETWORK_IPV6)
>>>> +        return -EINVAL;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    static inline struct erdma_user_mmap_entry *
>>>>    to_emmap(struct rdma_user_mmap_entry *ibmmap)
>>>>    {
>>>> @@ -382,5 +392,7 @@ int erdma_get_hw_stats(struct ib_device *ibdev, 
>>>> struct rdma_hw_stats *stats,
>>>>                   u32 port, int index);
>>>>    enum rdma_link_layer erdma_get_link_layer(struct ib_device *ibdev,
>>>>                          u32 port_num);
>>>> +int erdma_add_gid(const struct ib_gid_attr *attr, void **context);
>>>> +int erdma_del_gid(const struct ib_gid_attr *attr, void **context);
>>>>    #endif


