Return-Path: <linux-rdma+bounces-20090-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIQYOdlX+2n1ZgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20090-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 17:01:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F24DCCED
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C219930C45A0
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA43ED136;
	Wed,  6 May 2026 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="eyubpEk0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D056246781
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079248; cv=none; b=j+bzLLRjzBEwNQg/rxwT6mLFCgONq62fTm5PN8w5+ycrEmRRLfYMdOARsEQ0P2fLxwuzxzcXJpXbjKGnGGhrZzpgv4MmIKKVuwUv4ol60a2OV80WTIawrwPv4VV2J17Njk2s7KJ2L4axnVeQeDwrpQ3TsTC2Hm5c6DBVdFNRnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079248; c=relaxed/simple;
	bh=HdOGOlrHnm/Qc7yuVkm+8OX5aok9h48wU4EA8M2ecEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awkw9nEepWaEibomxv84R6+Xiecpsm4MZPHvG1mxM8xdgGC1w+hYCMpB0n0kXjwrhDkuf/H155Y+HDDAz6iXKT8fhbfaPszrKhVGIpdhaIPOinXzclmUtaDV6F9xhML1+uS4OQtPYB9wprP4LwdZXPZuzFkoqzgS4CPtTtf2M6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=eyubpEk0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48d146705b4so25970885e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778079243; x=1778684043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdOGOlrHnm/Qc7yuVkm+8OX5aok9h48wU4EA8M2ecEo=;
        b=eyubpEk0Z1REjXqQp/MBZSgfmBvtHwEIqSSZYdpPiTLkxNMJ2obaHOrgwOWY2y2aIV
         Ovf+ob2QMj9+p9vGyaQwOhZu+j+pjzxWksDfKMMDBjJ/absYpbQvnYNwmup85c4KU6p3
         XY1zjpD1tVVvD1rHOmgpkbaoH30DMpw6AWIrFO+HC8FMC047+bbDn9sm5Yns0gq0kdFt
         4hhwrhLZifACICcmrMpLYlgrylMUpm2TMwBzepFBea73eARnlnqz9dCCkW+j6c6DLlYO
         t9od+ZYGmb3ktTy98NVhnejJIUKElPvXGA+L8ZL54UILeWyvHzsbQ4S67ysS+l8rX3k4
         w8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079243; x=1778684043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdOGOlrHnm/Qc7yuVkm+8OX5aok9h48wU4EA8M2ecEo=;
        b=dXH3PQxO+sxQke5H/GCmB+wvBKi8wIWJfbZZwy8vjh91+lX+QXYpMs2urQpMyNyzsb
         iKEhGKMuejMdchWjfYVcNJJQyCj/tPnQLk9LcCgyHziI08M/RcD30uKHDCSkKhR+xMj2
         EeN8AG+Tlb+PfHd0TGFWGLZ8n8qvVxx/ALOlFVG5L/okxkhrdZGMb+12djbEhAgIl+JB
         oemTl1BTYrcXV8EcixhaLaerul+HtX2XZ+THtWbYPOgRQ2EW8eAbsYAwfKLA900dTXUp
         tudJ4xSebwYmIDzScD/PNLXDPIHmvDbwcHf3GVnXp4P38xNNGc99MkkOwl7klyPtkZwJ
         Vdbw==
X-Forwarded-Encrypted: i=1; AFNElJ/QykgYGrgb/Vvu4jQ1EhLCimmoaZbEdkeTvfvxXVIDFP/i06iS/c18GYwapa3ED2JpzlDvBe4an4YH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh18qNHsmaDggajR2Bw9lnLKiyVVwon4xEbIQ5SXWJqeOrmgNS
	ctJhAa8RqzarPe9JEGCz2zBqtsOZ27yn8Spw0AAyf4kqAS4qG0xbK3nA0WudDqaGk50=
X-Gm-Gg: AeBDies7hvlxUZ9kp+eKS8DXUFWAhipu6KzETv8a5b1taIMAjBMEJpX8cvsk5niZw2P
	jwTr1UCLdzwJOvknjG4WOxRqYuirhJPQuU1kNMYurtwgDjS6qxAhDHoxiHAJPeJIXeAUwRpfzmz
	KgsLqTGsxDHZKt7ktE8njTZG5Xt4rDUyA9eYEkJInNxgve2zow9CG2dwTzLbLZ51MKmGLxycw8+
	DUB4woqQg5ZYddlwq6OffYhditK4P66updnStT5xD1Hmosp7FHBK4GeDDCUpgzpCB0RPvXm8+WM
	PAf+YR9QU/S3+bmEpEpZJh22m5ntJMs4umImJIunvJ+TT6xC2RNoXePcW6ycHwQlxL3Ws1l/7Am
	kueZ4dlliqEkgbCOVPgxasYO3Fnw5BzBeOmcOAEWOJo5oU20djHvprwHk3A5e+eDQNwprtcUHl9
	rsxpFnmhK4X6zIdKlGyvGrR2CsBQnmZTVKg0XGM1W83YxvEm+W8Ga/PM+MnHbPTgQi
X-Received: by 2002:a05:600c:354b:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-48e51f427bemr64385215e9.13.1778079242854;
        Wed, 06 May 2026 07:54:02 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:8c0b:afdd:3d9d:e976])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524834eesm12599798f8f.4.2026.05.06.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:54:02 -0700 (PDT)
Date: Wed, 6 May 2026 16:54:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Moroni <jmoroni@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
	leon@kernel.org, edwards@nvidia.com, kees@kernel.org, parav@nvidia.com, 
	mbloch@nvidia.com, yishaih@nvidia.com, lirongqing@baidu.com, 
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn
Subject: Re: [PATCH rdma-next 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <aftVhkIh4DtoH8zq@FV6GYCPJ69>
References: <20260505061149.2361536-1-jiri@resnulli.us>
 <20260505061149.2361536-3-jiri@resnulli.us>
 <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com>
 <afoUqiDgZmhE4Kog@ziepe.ca>
 <afsIsW7vKgJtdNA2@FV6GYCPJ69>
 <afsOtEeppBzxOGUB@ziepe.ca>
 <afsdvIvEdX85iCXE@FV6GYCPJ69>
 <CAHYDg1Tbrekfnd7RyHm07ctAP9DLtUHqQ5EsYMYJr=bjjHSMPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1Tbrekfnd7RyHm07ctAP9DLtUHqQ5EsYMYJr=bjjHSMPg@mail.gmail.com>
X-Rspamd-Queue-Id: D68F24DCCED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[resnulli-us.20251104.gappssmtp.com:query timed out];
	TAGGED_FROM(0.00)[bounces-20090-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[jmoroni.google.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Wed, May 06, 2026 at 03:39:32PM +0200, jmoroni@google.com wrote:
>> transparent dmabuf-backed-VA pinning
>
>Thanks! I took a look at your WIP code. It seems like it would really simplify
>things for irdma. Looking forward to it.
>
>Is there a WIP you can share for any rdma-core changes? For example, I
>am wondering if there will be some generic allocation helper for drivers to
>allocate umems for internal use (for QP rings, etc.). This helper would
>detect if it's running in a CVM and use the cc_shared heap or something.
>
>I'm mainly just curious how you see it being used on the userspace side.

https://github.com/jpirko/rdma-core/commits/wip_umem_bufs/


>
>>>> Another idea was to just allocate them in the kernel using the DMA
>>>> allocator and map them into userspace but it would be a larger change.
>
>>>This isn't the pattern we are using in rdma..
>
>> Yeah, plus I'm missing the motivation, what that would help us to
>> achieve?
>
>This would have been a driver hack and doesn't make sense compared to
>your current plan, but the idea would have been to use the DMA allocator in
>the kernel to allocate the QP rings. This would give us a public buffer, which
>could then be mapped into the process with dma_mmap_coherent which
>sets the pages to decrypted. I imagine this scheme would be needed for
>NICs that require physically contiguous ring buffers (if any exist, not sure).
>
>Thanks,
>Jake

