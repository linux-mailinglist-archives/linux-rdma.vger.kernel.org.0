Return-Path: <linux-rdma+bounces-20857-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD1pCQcDCmpkwAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20857-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 20:03:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 774D6562D7D
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 20:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93E1F300878C
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1683C65E0;
	Sun, 17 May 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="y/fNsf2L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D43B3C17
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041027; cv=none; b=b26Ptw30DUR/8dnuwRnLEQeAXt68KkRBRV9ViqCg1QOUx/ZywkTARkfV2eqTYXJMuKWypv9UWCVxe+GBYsn9WaREVU25qwR7p6pN8DnnU6p107XdYL+7tdRHKsDzskTXzTouLtzh7GsmduPXkWqAPnDPcYrYSvmJ9KJIXz6PGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041027; c=relaxed/simple;
	bh=IdvoRQAlkO0FAZ4NLE0UuPNSiFmHLFrzNUsD/aLM49k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otZDR1qUvcYeSL8ts4P4jSxX3+CEMVRZL34RfQ2JsD6kR/j/TPe32cNsBmw26Dhv949ZTfJH5xFjoCMTOVi7XYCHftYHP07H0f9CC61IxnYVVxIlxYUxFWkw/ezlWfGg3GgY5uOXCBR0TRqCNmZnvOJT/PbrkdhcwuzoyJ0qVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=y/fNsf2L; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso18405915e9.0
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779041021; x=1779645821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8b8oejsdlmzvPAGqVmNLcazi/0oxdkSgT6uUc1uw7Pw=;
        b=y/fNsf2LbpXsd+Pp7irdkAakyE36oSY3WgkaGjHcbmL2qomTiwWI5PM9wZPzZCw2os
         1ARfoxMDJ2Hyfw+NLYX3nUiNSpl/smR69qx4DLKASr2guhEe5MQKdBkqyYZGRvUiJnl0
         bVMDKUoumpgc/AyYgWXei+DoywkLTWtLz8D41N7DNhXpW+fOGhx0rlIWVdKlzK/3B6t0
         dIoPD3HuxwzZtBorxRST/vsP1IJVMVxKIiWI9IJ9XHkFIP5jj2ZVf4VsKO81Q5k2KiWW
         a0QZWIgFD2zX+EBPZglyjqWw5DFF30q/5Z+iJhIUAMxcbqgFHijWwoQsfA1mKVAMEB7Y
         ohVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041021; x=1779645821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8b8oejsdlmzvPAGqVmNLcazi/0oxdkSgT6uUc1uw7Pw=;
        b=lwClLJ/p4CuPaLdYW6eLZdMrPTZf6NcnHW/t/8Ux2d/IrChvQg+uRHV2Wnd15qh85m
         jgkYq1efGGtEB9IH5ljOWcuQPNQAKbVWg56ZbIQt5s9qTABVZFmA4xYD8aiP1MSX3T5u
         6DhZWkUdfiWYNkrW+a/W1iBXqXEb7pB/SzNrffMM7AyWNie7aPWTAHwA5zPX8BRsfs8j
         4YhIoL08adufXDHsIfAxCG5iUsKX5c9oo9oFQp30MS+9jNa0vWgZm3mDj0A8x1Q5ZOjX
         PRDN2z5zVz3lWj+qyaVV/oyhXkmucVIFxf9Cm0/2KymVpACmL0S4tFAncwnm/A7vtAYI
         gdTQ==
X-Gm-Message-State: AOJu0YwVUK4xg+05+IL6Rb1bT1y6/HqlCrerq3GbhzdCnWCBe8ek0ZsU
	vHO6/EthlmIVGlwRs8Xg6RE5Dm0vmOdBuL9R6jORjjGBlL9UkKb0jgYrtYcPQ+u88ZY=
X-Gm-Gg: Acq92OFlQ7GG35hayVhIA7QUwB6LzoSj9itsvXGqYkF/4BmnGWzhbgZFoBiMJr+/fFX
	DQAXEmbrPOpdgYf6aNxvYSF/W/s91yOhLl9lksEmNhTCECiHXv15etPhc+ixWmKRcDgwYMUZveg
	VitoQzwlDC8kc6oe03s+PIdmHvnnfTbnUuQhjGVId7SzssFbfKsFtle2KpxAokd9YxPKzbVugUB
	dfb3zoJkydrv4eruwDg4bL55QF9NVcKS75juiBjpZcXtePK/0ACi+zAKV+lquOmUnGqotIP4g1v
	5hr2npP4BA8tMXfVX0nQ9VyEAwKH/3sIrvVPoFGwQqEdnqflP93lTfm2VqMFDHvThTGK1IpfAwH
	F2NtR5vfO1DQRxpBwgPacD06tzPbt/4L4aAZuvZCqQRfRnG/eaz34wZpTnA472hvefl1FOPqS1+
	kVhTiusYRp3ojUApRl/H0OXf08KrYLNmKK4VXNsPzHXrE=
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48fe59b047bmr199056875e9.0.1779041021027;
        Sun, 17 May 2026 11:03:41 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:4146:8430:fb4a:baf5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm32225217f8f.29.2026.05.17.11.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:03:40 -0700 (PDT)
Date: Sun, 17 May 2026 20:03:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, edwards@nvidia.com, 
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com, yishaih@nvidia.com, 
	lirongqing@baidu.com, huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn, 
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v3 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <agoC2SeEe0lC1Jf6@FV6GYCPJ69>
References: <20260517141311.2409230-1-jiri@resnulli.us>
 <20260517141311.2409230-3-jiri@resnulli.us>
 <20260517161712.GL33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517161712.GL33515@unreal>
X-Rspamd-Queue-Id: 774D6562D7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20857-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sun, May 17, 2026 at 06:17:12PM +0200, leon@kernel.org wrote:
>On Sun, May 17, 2026 at 04:13:11PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> When a device requires DMA bounce buffering inside a Confidential
>> Computing guest, __ib_umem_get_va() cannot work. The DMA mapping layer
>> redirects all mappings through swiotlb bounce buffers, so the device
>> receives DMA addresses pointing to bounce buffer memory rather than
>> the user's pages. Since RDMA devices access registered memory directly
>> without CPU involvement, there is no opportunity for swiotlb to
>> synchronize between the bounce buffer and the original pages.
>> 
>> The registration would already fail later on, since the umem mapping
>> is requested with DMA_ATTR_REQUIRE_COHERENT and gets rejected under
>> is_swiotlb_force_bounce() with -EIO. Fail early with -EOPNOTSUPP
>> instead, so the user gets a specific error code to react to.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - updated patch description with mention of DMA_ATTR_REQUIRE_COHERENT
>> ---
>>  drivers/infiniband/core/umem.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> index eb1de32bab9d..b32bc2a5d7d0 100644
>> --- a/drivers/infiniband/core/umem.c
>> +++ b/drivers/infiniband/core/umem.c
>> @@ -167,6 +167,9 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
>>  	int pinned, ret;
>>  	unsigned int gup_flags = FOLL_LONGTERM;
>>  
>> +	if (device->cc_dma_bounce)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>
>The series looks reasonable, but I cannot apply it yet because  
>`__ib_umem_get_va()` has not been merged.

Correct. Cover letter says:
based on top of:
https://lore.kernel.org/all/20260517063006.2200680-1-jiri@resnulli.us/

