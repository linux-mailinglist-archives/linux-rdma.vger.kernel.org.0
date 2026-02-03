Return-Path: <linux-rdma+bounces-16443-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFDpEOvJgWl1JwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16443-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:11:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB3D75F2
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA9373004403
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB9139C63B;
	Tue,  3 Feb 2026 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QEHo3cFY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F263B9
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113507; cv=none; b=jdaxiBMevb5Cv1Fh0/5TmlZz3uxulVoJmFacVAN0G2uUx6DMT71fWTv76WA8xvcxgy6q8L3lDZtuIFnFBWMbTsWxapTxq3vManze2GzNWbFb64y2bkFrMDJ8916t03MRE9rG4fYScyuSmZj7QLJlUrssr3CukAan2yxfC9VWhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113507; c=relaxed/simple;
	bh=3spaL0VLlXrH51rqu309a8C5dLuNXM0uz37Cdx47AKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okZw1sgv67pjsjRtq16tfPhNu2sFoIfpPvorjGvrVfR7Z+U6A2BGNa+GEpYwLrXtvXMm4vcQsEAyEwUwVjBod6Ql8ETqVqFnBZK4RNBHP5PA0+WFlptq2hUuse9FzkqdMZ6NXFSBJXADPhQeY1ATIgx09niGCndVMYQp0uqEDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QEHo3cFY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so3450289f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 02:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770113503; x=1770718303; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0DYDA5i9EbDel89w8+M5jnadYYzManL/kF9/w4q9W4I=;
        b=QEHo3cFYLoYZqiAfpxz1Y+uXmx6z2BYF1oSwRISSqE4g/ZMRy+CYJZXr16W42Tv/FH
         flTRgpvGkztVWtlq+oAGZ1xjzj9zZRtTNyMYBJmbylkfiTolhwh2a7XvQKGTrDr24hTI
         LOjjGoB+ZsX03FQv20ZRgWxY6stghdIwn8Xv22dvUpahPOuuy5mbj67W7mjfNOjdfVN/
         qBq3xL+w9ljeUPRuDx9UXTCXTvaL3whYESbVS+8xf/lj+6qPDHEnwCFTo5OmiKoe1Eor
         UihYHE3zyet1HQQQGbExbuCzVx493AlAOBpwWefKCZntCcNP1r4Xi1GvJxeHp3AToSgK
         Z5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113503; x=1770718303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DYDA5i9EbDel89w8+M5jnadYYzManL/kF9/w4q9W4I=;
        b=VmQSIqgrjkff1NM8QCGUPXbkNL1XIXBzt2ILJcwIfzvDyTWLPkyCtQz41sQHogfOtE
         CKW0E3ZFin/ref8r6vOBfD6bp7zQHqWDSS/lYWz0wmqRSkxbunzZKijmu1eyLxa1gcbX
         jS8mXtCh86sJorDdd3jSUnfVdTksr0kdPuDVhSMmku+yfwOFmTno4sMAt8tCTScxRoYX
         PrCRzU37XsQzr9+R6dwp5I8O+jQvqMJih/bepH2cy+D+r3++sysNjIbtJkmX+LNRJPy2
         R3HDaiBBIeO66H/d2/my01LzuDYOMgklJq5wXQ2zijtLDjwijnffPk8a5QgpJtkk4P8x
         uJKQ==
X-Gm-Message-State: AOJu0YzQLMDH9bxeuLmAkFruj8S9bkP2GdvpemDVt1C6eqLrylnwWLq1
	NwSwKM6bJyhDiozlEq4/9aVPjFmrBqsQvm7I2v38nbYJHEd8cGxniqHLsWi47+jNFIQ=
X-Gm-Gg: AZuq6aKmudw1gwQ0HHEWzXKiGMzMEIC2dpL7zMjtXz1lHqC/zOBFXM2C0Ly3lH+fVPu
	tGDoUnuwN+j9ve4A9zO4+vjgbaYJpulho/DFCmRRv2BdTc7y1FRzMJTOJC+Yew04pdI9QBHOvc8
	seiq9uRbVSs0+gDomvE6hI7d9LZ1CqJFk3LKZsD4TKPiiKrb1vZP1tIQEwM23xwtDNZd9VTIHov
	GVj38UDWkxyHKK4O/YvyHP2by3xrqYfTyuoP7GHe3owPD3po5jWjxW9Ok7/3uZtPZIlHDgXYzii
	t0I+BW5ZfRdMd2asjX7WNC6QKPIsfPZp14AumXMNUYsf7Lm9wdcnIvW8exTM1HX7LnJtdm0ZOb8
	7QK/FAXdLhnTTSdgvHy4XzqDvJIPrjMtqGvtXWYVzpMP8Vc7uxDtcR6fgo+75HdfnOWduGNg5P0
	hRtXc5GAzZY4fRBxUJa8sO9Sg=
X-Received: by 2002:a05:6000:4023:b0:432:851d:35ef with SMTP id ffacd0b85a97d-435f3aaea50mr21930347f8f.42.1770113502511;
        Tue, 03 Feb 2026 02:11:42 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm49061338f8f.34.2026.02.03.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:11:42 -0800 (PST)
Date: Tue, 3 Feb 2026 11:11:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, wangliang74@huawei.com, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <vw3hrr5fsamtsgydvydoewd4fnglas5xzickgfpjgp5y44gxkm@dmmvo36blqtb>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203100327.GS34749@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203100327.GS34749@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16443-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 45EB3D75F2
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 11:03:27AM +0100, leon@kernel.org wrote:
>On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Introduce reference counting for ib_umem objects to simplify memory
>> lifecycle management when umem buffers are shared between the core
>> layer and device drivers.
>> 
>> When the core RDMA layer allocates an ib_umem and passes it to a driver
>> (e.g., for CQ or QP creation with external buffers), both layers need
>> to manage the umem lifecycle. Without reference counting, this requires
>> complex conditional release logic to avoid double-frees on error paths
>> and leaks on success paths.
>
>This sentence doesn't align with the proposed change.

Hmm, I'm not sure why you think it does not align. It exactly describes
the code I had it originally without this path in place :)

>
>> 
>> With reference counting:
>> - Core allocates umem with refcount=1
>> - Driver calls ib_umem_get_ref() to take a reference
>> - Both layers can unconditionally call ib_umem_release()
>> - The umem is freed only when the last reference is dropped
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Change-Id: Ifb1765ea3b14dab3329294633ea5df063c74420d
>
>Please remove the Change-Ids and write the commit message yourself,
>without relying on AI. The current message provides no meaningful

I'm new in RDMA. Not sure what you mean by meaningful information :)
I'm always trying to provide it.

>information, particularly the auto‑generated summary at the end.

Doh, the changeIDs :) Sorry about that.


>
>Thanks
>
>> ---
>>  drivers/infiniband/core/umem.c        | 5 +++++
>>  drivers/infiniband/core/umem_dmabuf.c | 1 +
>>  drivers/infiniband/core/umem_odp.c    | 3 +++
>>  include/rdma/ib_umem.h                | 9 +++++++++
>>  4 files changed, 18 insertions(+)
>> 
>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> index 8137031c2a65..09ce694d66ea 100644
>> --- a/drivers/infiniband/core/umem.c
>> +++ b/drivers/infiniband/core/umem.c
>> @@ -192,6 +192,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>>  	umem = kzalloc(sizeof(*umem), GFP_KERNEL);
>>  	if (!umem)
>>  		return ERR_PTR(-ENOMEM);
>> +	refcount_set(&umem->refcount, 1);
>>  	umem->ibdev      = device;
>>  	umem->length     = size;
>>  	umem->address    = addr;
>> @@ -280,11 +281,15 @@ EXPORT_SYMBOL(ib_umem_get);
>>  /**
>>   * ib_umem_release - release memory pinned with ib_umem_get
>>   * @umem: umem struct to release
>> + *
>> + * Decrement the reference count and free the umem when it reaches zero.
>>   */
>>  void ib_umem_release(struct ib_umem *umem)
>>  {
>>  	if (!umem)
>>  		return;
>> +	if (!refcount_dec_and_test(&umem->refcount))
>> +		return;
>>  	if (umem->is_dmabuf)
>>  		return ib_umem_dmabuf_release(to_ib_umem_dmabuf(umem));
>>  	if (umem->is_odp)
>> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
>> index 939da49b0dcc..5c5286092fca 100644
>> --- a/drivers/infiniband/core/umem_dmabuf.c
>> +++ b/drivers/infiniband/core/umem_dmabuf.c
>> @@ -143,6 +143,7 @@ ib_umem_dmabuf_get_with_dma_device(struct ib_device *device,
>>  	}
>>  
>>  	umem = &umem_dmabuf->umem;
>> +	refcount_set(&umem->refcount, 1);
>>  	umem->ibdev = device;
>>  	umem->length = size;
>>  	umem->address = offset;
>> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
>> index 572a91a62a7b..7be30fda57e3 100644
>> --- a/drivers/infiniband/core/umem_odp.c
>> +++ b/drivers/infiniband/core/umem_odp.c
>> @@ -144,6 +144,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_device *device,
>>  	if (!umem_odp)
>>  		return ERR_PTR(-ENOMEM);
>>  	umem = &umem_odp->umem;
>> +	refcount_set(&umem->refcount, 1);
>>  	umem->ibdev = device;
>>  	umem->writable = ib_access_writable(access);
>>  	umem->owning_mm = current->mm;
>> @@ -185,6 +186,7 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
>>  	if (!odp_data)
>>  		return ERR_PTR(-ENOMEM);
>>  	umem = &odp_data->umem;
>> +	refcount_set(&umem->refcount, 1);
>>  	umem->ibdev = root->umem.ibdev;
>>  	umem->length     = size;
>>  	umem->address    = addr;
>> @@ -245,6 +247,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
>>  	if (!umem_odp)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> +	refcount_set(&umem_odp->umem.refcount, 1);
>>  	umem_odp->umem.ibdev = device;
>>  	umem_odp->umem.length = size;
>>  	umem_odp->umem.address = addr;
>> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
>> index 0a8e092c0ea8..44264f78eab3 100644
>> --- a/include/rdma/ib_umem.h
>> +++ b/include/rdma/ib_umem.h
>> @@ -10,6 +10,7 @@
>>  #include <linux/list.h>
>>  #include <linux/scatterlist.h>
>>  #include <linux/workqueue.h>
>> +#include <linux/refcount.h>
>>  #include <rdma/ib_verbs.h>
>>  
>>  struct ib_ucontext;
>> @@ -19,6 +20,7 @@ struct dma_buf_attach_ops;
>>  struct ib_umem {
>>  	struct ib_device       *ibdev;
>>  	struct mm_struct       *owning_mm;
>> +	refcount_t		refcount;
>>  	u64 iova;
>>  	size_t			length;
>>  	unsigned long		address;
>> @@ -110,6 +112,12 @@ static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
>>  
>>  struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>>  			    size_t size, int access);
>> +
>> +static inline void ib_umem_get_ref(struct ib_umem *umem)
>> +{
>> +	refcount_inc(&umem->refcount);
>> +}
>> +
>>  void ib_umem_release(struct ib_umem *umem);
>>  int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>>  		      size_t length);
>> @@ -188,6 +196,7 @@ static inline struct ib_umem *ib_umem_get(struct ib_device *device,
>>  {
>>  	return ERR_PTR(-EOPNOTSUPP);
>>  }
>> +static inline void ib_umem_get_ref(struct ib_umem *umem) { }
>>  static inline void ib_umem_release(struct ib_umem *umem) { }
>>  static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>>  		      		    size_t length) {
>> -- 
>> 2.51.1
>> 
>> 

