Return-Path: <linux-rdma+bounces-17206-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEjaDNb9n2n3fAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17206-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 09:01:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FC31A233D
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 09:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E185F309B404
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9E0277C86;
	Thu, 26 Feb 2026 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zjix01H8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93F38F22F;
	Thu, 26 Feb 2026 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092805; cv=none; b=L1Q7aqJK1t2MGoyiH9+zneE1w+ZboVo6GbYaPxd0ffvexDKkh8VBO8HiT9GQZ9QVJYmnCiyENm6m2AZu0poRkJ1ine5LyS66gzfOU9TkLTGqXYd9J6SC8c53MwGCBrTGZgs4CJXfb5qjwzIFUo+QvnONd5BGgleAwbC3eZVx6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092805; c=relaxed/simple;
	bh=cJAqpzk+6Fnjp1Adul3e92S4CU5ul9AqjRQ/CGkqGfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/pMGkotr9yYWz3LdYFanA7p3mbaEwt5CrGbVPc10OiMGPFjzuJnXasGwRFslbS72MbCW7KKw7ILw6Gjn3mkIcxenEpxdfFjFDlV0gIz+AFtSiP0ZPzmE00PyB3liXrxYL0tIWntgVaqVJQi7LP/74hzXKXdC47ORMnhw8478IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zjix01H8; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772092795; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+YTqvsV2SttcidyUCaVUACWY2WHw1J1DoKRuAsoPitc=;
	b=Zjix01H8exnTL8MaMJQRtNUAkNVAFX/IKKNWKvn0JYptMDb/v6VCI8os38/ZSdYfY8IMo165QS2MFVXQ29gKZMFZF8pBFc03fPu3/pyNA/2hgBHIrhxbm0MBo2NbHdYis2IaA0n3S/qBV2TKs21ROcjhPvolnjUg8i2mzBwHwPo=
Received: from 30.221.97.172(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WzqVP0i_1772092794 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Feb 2026 15:59:55 +0800
Message-ID: <2d5e7f0a-2ea9-026e-2e79-da716a8b0a32@linux.alibaba.com>
Date: Thu, 26 Feb 2026 15:59:54 +0800
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
To: Leon Romanovsky <leon@kernel.org>
Cc: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>,
 Kai Shen <kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260225085143.1721-1-lirongqing@baidu.com>
 <7cfd31d3-fe40-8b2d-cea8-14748db5f35b@linux.alibaba.com>
 <81eac7dd27d344b59da16bd4cef7bc77@baidu.com>
 <b00bcf9a1aee447eb64d955c52851c05@baidu.com>
 <39e148d1-6a56-863f-8126-e92d452b3106@linux.alibaba.com>
 <20260226070954.GC12611@unreal>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20260226070954.GC12611@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17206-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99FC31A233D
X-Rspamd-Action: no action



On 2/26/26 3:09 PM, Leon Romanovsky wrote:
> On Thu, Feb 26, 2026 at 09:50:00AM +0800, Cheng Xu wrote:
>>
>>
>> On 2/25/26 8:07 PM, Li,Rongqing(ACG CCN) wrote:
>>>
>>>>> On 2/25/26 4:51 PM, lirongqing wrote:
>>>>>> From: Li RongQing <lirongqing@baidu.com>
>>>>>>
>>>>>> Currently, MTT (Memory Translation Table) buffers are allocated
>>>>>> without NUMA awareness using kzalloc() and vzalloc(), which allocate
>>>>>> memory on the NUMA node of the calling CPU. This can lead to
>>>>>> cross-node memory access latencies if the erdma device is attached
>>>>>> to a different NUMA socket.
>>>>>>
>>>>>> Switch to kzalloc_node() and vzalloc_node() to ensure MTT buffers
>>>>>> are allocated on the local NUMA node of the PCIe device
>>>> (dev->attrs.numa_node).
>>>>>> This reduces latency for hardware access and improves performance.
>>>>>>
>>>>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>>>>> ---
>>>>>>  drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>
>>>>> Hi, Li RongQing,
>>>>>
>>>>> Thanks for the patch. However, I think it is better to keep the
>>>>> current behavior, for the following reasons:
>>>>>
>>>>> 1. This path is in the control plane, so allocating memory from a remote
>>>>>    NUMA node should not have a noticeable performance impact.
>>>>
>>>> If TLB Miss , or the internal cache misses , does the HCA need to query the MTT?
>>>>
>>
>> This is rarely happen in our chip.
> 
> So why do we need this patch? The xxx_node() functions are useful when you
> need to force allocation on a specific NUMA node. In most cases, a plain
> kmalloc() will allocate memory on the same node as 'struct erdma_dev *dev',
> which typically matches the PCI device's NUMA node.
> 

Thanks for the detailed explanation.

> Please avoid vague phrasing like 'potentially improves performance' in the
> commit message and responses. It adds no meaningful information.
> 

Got it. 


> Also, please remove the dev->attrs.numa_node caching from erdma and rely on
> dev_to_node() instead.

OK, I will fix this.

Thanks,
Cheng Xu

> 
> Thanks

