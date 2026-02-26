Return-Path: <linux-rdma+bounces-17192-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yClbOuOmn2mHdAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17192-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 02:50:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5700C19FF0A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 02:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 982683011C5B
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE7B36F425;
	Thu, 26 Feb 2026 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tgqPPcHn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC11F5842;
	Thu, 26 Feb 2026 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070612; cv=none; b=ljcy1u0Qv+rHSTt5XT5WmtIZvjW5r3u+xneWhhnbnuFX9cNaUuDtskoDI4ID2nmNv5dzA0PWNJN6IO1wxMjk9xgrzLjYZlNC3tOnunfdAqLwRDWLfc6hLI24jPDCLOrORHofEuEYWDrJMWbT1qO5PxuNj5sDBjOKHX5vyXX/vgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070612; c=relaxed/simple;
	bh=oAw0ldipZn/8qYXpbsNCUUGZSIOtvDbJLiOdS9EBvKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bx5Cs/dkC1lOhdvFZAk+lMkL0jR3g+iQcesIm2bX8Fb7q+IyVDgb1MhWL10goeWrW8/AYX5uuIwDnZqC1F/Vggv5/jDoUOtKpJQ/OCF+nRguBtvy26yBEqgv7ucAVMaYMRjCPSptSWzGmyqrtq8R2e0PbLGLQZ6HAAjMFGZCxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tgqPPcHn; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772070602; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=omWGKgvXZl8OpaSvHrIFgTeq1hllJhLNwG3Q+g+Prvg=;
	b=tgqPPcHnD7/77mmeZdfqFWjV/nGTsJibt7VsANdM4eRySAnyTAMxEKG/MjtWemnxXImJ+FtjHdr2fFafHdcNwveZAcq9VmFZHaatNY5VCG/7UtRivGBjXyO/Ykvn6AS1XnUAR1jiTqbZW9cJ7p8TYw6IyZCPmaw6LLNqZX5eXLU=
Received: from 30.221.97.172(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WzpWcky_1772070600 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Feb 2026 09:50:01 +0800
Message-ID: <39e148d1-6a56-863f-8126-e92d452b3106@linux.alibaba.com>
Date: Thu, 26 Feb 2026 09:50:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bcmRt?=
 =?UTF-8?Q?a-next=5d_RDMA/erdma=3a_Use_NUMA-aware_allocation_for_MTT_tables?=
Content-Language: en-US
To: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>,
 Kai Shen <kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260225085143.1721-1-lirongqing@baidu.com>
 <7cfd31d3-fe40-8b2d-cea8-14748db5f35b@linux.alibaba.com>
 <81eac7dd27d344b59da16bd4cef7bc77@baidu.com>
 <b00bcf9a1aee447eb64d955c52851c05@baidu.com>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <b00bcf9a1aee447eb64d955c52851c05@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17192-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengyou@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5700C19FF0A
X-Rspamd-Action: no action



On 2/25/26 8:07 PM, Li,Rongqing(ACG CCN) wrote:
> 
>>> On 2/25/26 4:51 PM, lirongqing wrote:
>>>> From: Li RongQing <lirongqing@baidu.com>
>>>>
>>>> Currently, MTT (Memory Translation Table) buffers are allocated
>>>> without NUMA awareness using kzalloc() and vzalloc(), which allocate
>>>> memory on the NUMA node of the calling CPU. This can lead to
>>>> cross-node memory access latencies if the erdma device is attached
>>>> to a different NUMA socket.
>>>>
>>>> Switch to kzalloc_node() and vzalloc_node() to ensure MTT buffers
>>>> are allocated on the local NUMA node of the PCIe device
>> (dev->attrs.numa_node).
>>>> This reduces latency for hardware access and improves performance.
>>>>
>>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>>> ---
>>>>  drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>
>>> Hi, Li RongQing,
>>>
>>> Thanks for the patch. However, I think it is better to keep the
>>> current behavior, for the following reasons:
>>>
>>> 1. This path is in the control plane, so allocating memory from a remote
>>>    NUMA node should not have a noticeable performance impact.
>>
>> If TLB Miss , or the internal cache misses , does the HCA need to query the MTT?
>>

This is rarely happen in our chip.

>> [Li,Rongqing]
>>
>>> 2. With this change, the driver may fail the allocation when the local NUMA
>>>    node is out of memory, even if other nodes still have available memory.
>>>
> 
> 
> When kmalloc_node() is called without __GFP_THISNODE and the target node
> lacks sufficient memory, SLUB allocates a folio from a different node
> other than the requested node.
> 

You are right, thank you for pointing out this.

Cheng Xu

> So I think this is not a problem.
> 
> [Li,Rongqing] 
> 
> 
> 
>>> Thanks,
>>> Cheng Xu
>>>
>>>> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c
>>>> b/drivers/infiniband/hw/erdma/erdma_verbs.c
>>>> index 9f74aad..58da6ef 100644
>>>> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
>>>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
>>>> @@ -604,7 +604,7 @@ static struct erdma_mtt
>>> *erdma_create_cont_mtt(struct erdma_dev *dev,
>>>>  		return ERR_PTR(-ENOMEM);
>>>>
>>>>  	mtt->size = size;
>>>> -	mtt->buf = kzalloc(mtt->size, GFP_KERNEL);
>>>> +	mtt->buf = kzalloc_node(mtt->size, GFP_KERNEL,
>>>> +dev->attrs.numa_node);
>>>>  	if (!mtt->buf)
>>>>  		goto err_free_mtt;
>>>>
>>>> @@ -729,7 +729,7 @@ static struct erdma_mtt
>>> *erdma_create_scatter_mtt(struct erdma_dev *dev,
>>>>  		return ERR_PTR(-ENOMEM);
>>>>
>>>>  	mtt->size = ALIGN(size, PAGE_SIZE);
>>>> -	mtt->buf = vzalloc(mtt->size);
>>>> +	mtt->buf = vzalloc_node(mtt->size, dev->attrs.numa_node);
>>>>  	mtt->continuous = false;
>>>>  	if (!mtt->buf)
>>>>  		goto err_free_mtt;

