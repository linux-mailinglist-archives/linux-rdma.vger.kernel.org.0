Return-Path: <linux-rdma+bounces-22789-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M8saLN9AS2oZOQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22789-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 07:45:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE170CADF
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 07:45:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=NCLV7Mes;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22789-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22789-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9437D30053AC
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 05:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64993BE638;
	Mon,  6 Jul 2026 05:44:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E53BE16A
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2026 05:44:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316698; cv=none; b=be6fcH7MyOpw7Mqt5R858vpQD8uYy9h5TCkc4eQEMLt/NdfGF93DT6tGsZltA5nrrafveVXVJ/ds7BaOCupaUc+9CtN3xBvEd4NcEsbouIv40XQt7sY52FPI6KJWUZccYHqcmX/I2Bvpn3Gm08CO4Uym4OElPKyvjEfOQPiu9Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316698; c=relaxed/simple;
	bh=e3o8h5HPCHxAtU/QyRJRXSuHI36SHMPWEq80cdBwXDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ee9kSJx1IG8FAOv1w/V8DL0WeDPRx46orTQfRJL4EAfyz8iKomvh3c9E3GXygSM86UewNBLqRA5mUuQ8OTKsiZEr5XdeEKxnEFZh1A2tw8IJO7C4J8oZFyAPS0xKmswbn3QSAq/m2fjcZ/M9O4dmrTRQ/9XhJqZVQUNjuxh5hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NCLV7Mes; arc=none smtp.client-ip=115.124.30.118
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783316693; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=m+0mYCInFi9JL/QRGG/qv0eOufrGftDMcHhovPimBHw=;
	b=NCLV7MesTf3CM2C/T2sjm6QdpcBXDxI21FUPjH6dwuDTzjcsw5lfqGOJBJoHR3Jf6iFEblmsvpYQELnQmT1TMKXOTahMLdbtbULseP9/108hpUs/GaAod4IrGrsYN1Gdr5tTtBTzuZEF690CJlpC20HuDbojqZyKre5ls3IGUes=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6QRpMz_1783316691;
Received: from 30.221.132.82(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X6QRpMz_1783316691 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:44:52 +0800
Message-ID: <abcf5ef9-1e61-4c6b-b530-61b5c525f907@linux.alibaba.com>
Date: Mon, 6 Jul 2026 13:44:50 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 0/3] RDMA/erdma: Add DMA-BUF memory
 registration
To: Leon Romanovsky <leon@kernel.org>
References: <20260618045120.51210-1-boshiyu@linux.alibaba.com>
 <20260705100841.GA15188@unreal>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 chengyou@linux.alibaba.com, kaishen@linux.alibaba.com
From: Boshi Yu <boshiyu@linux.alibaba.com>
In-Reply-To: <20260705100841.GA15188@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22789-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23FE170CADF

On 7/5/26 6:08 PM, Leon Romanovsky wrote:
> On Thu, Jun 18, 2026 at 12:51:02PM +0800, Boshi Yu wrote:
>> Hi,
>>
>> This patch series adds DMA-BUF memory registration support to the erdma
>> driver:
>>
>> - #1 renames get/put_mtt_entries to erdma_mem_init/uninit to better reflect
>>       their purpose of initializing the struct erdma_mem.
>> - #2 introduces struct erdma_mem_init_attr to pass parameters to
>>       erdma_mem_init(), improving code maintainability and preparing for
>>       DMA-BUF support.
>> - #3 implements erdma_reg_user_mr_dmabuf() to enable DMA-BUF based user
>>       memory registration using the revocable pinned dmabuf interface.
>>
>> One known limitation: if the DEREG_MR command fails in the revoke
>> callback, the driver can only log an error, since erdma does not
>> support a function-level reset like irdma's request_reset() yet.
> 
> I hoped someone would comment on this. If revocation fails, the
> hardware may continue accessing memory that the system considers
> released.
> 
>  From comment:
>   * When a revocation occurs, the revoke callback will be called. The driver must
>   * ensure that the region is no longer accessed when the callback returns. Any
>   * subsequent access attempts should also probably cause an AE for MRs.
> 
>> We plan to introduce such a mechanism in future work.
> 
> That mechanism needs to be included in this series.
> 
> Thanks
> 

Hi, Leon

Thanks for your suggestion. I will implement the reset mechanism in the 
next version of this series.

Thanks,
Boshi Yu

>>
>> Thanks,
>> Boshi Yu
>>
>> ---
>>
>> v3:
>>   - Patch#3: Switch to the revocable pinned dmabuf interface as
>>     suggested by Jason Gunthorpe.
>>
>> v2:
>>   - Patch#2: Add validation for the return value of ib_umem_find_best_pgsz().
>>    link: https://lore.kernel.org/all/20260518120637.16831-1-boshiyu@linux.alibaba.com/
>>
>> v1:
>>    link: https://lore.kernel.org/all/20260507053437.46211-1-boshiyu@linux.alibaba.com/
>>
>> Boshi Yu (3):
>>    RDMA/erdma: Rename get/put_mtt_entries to erdma_mem_init/uninit
>>    RDMA/erdma: Introduce struct erdma_mem_init_attr
>>    RDMA/erdma: Implement erdma_reg_user_mr_dmabuf
>>
>>   drivers/infiniband/hw/erdma/erdma_main.c  |   1 +
>>   drivers/infiniband/hw/erdma/erdma_verbs.c | 262 +++++++++++++++-------
>>   drivers/infiniband/hw/erdma/erdma_verbs.h |  17 ++
>>   3 files changed, 201 insertions(+), 79 deletions(-)
>>
>> -- 
>> 2.46.0
>>
>>


