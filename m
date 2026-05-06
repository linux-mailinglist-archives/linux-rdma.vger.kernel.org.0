Return-Path: <linux-rdma+bounces-20059-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEMULhQI+2mbVQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20059-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 11:21:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A804D887A
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 11:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ED333011C79
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535613D3335;
	Wed,  6 May 2026 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="AN+YhfcV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77C1EF09B
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059076; cv=none; b=B58fHm43/EWHXieG+bl9vZD8u/OzV6w34d5VrY+Y22NMarSRY/T/E6vpN/64CSRUeN17e8H0GxybVbGdqzPp/9HLxeunlckW5CnPqFByvX7GEVUlSMea1rVsu4g/7YaTSinWxL7co2p2NJI0Eg2YN3on0ouqfwr4RPi0wTl4KIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059076; c=relaxed/simple;
	bh=xmpwKc8jOjxMXbQKNUo/hddcgk8UkxzveVCAkHyZYkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1NQ/22kvK774DEqPj02xktrO81QXVi5EvW5MmO9sHSDly9LdpfFjHPxdI+0Y0yLX+sUkxp8dF6GpgG2+S9UZ9JQI6LYfhkYAXpwtQXGIn2OhljBe9kRFy0JeT7KbtoRjmlfKNMXyIrmlc9Atoi2Lxqsw0juVnJduxT9onQ1RAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=AN+YhfcV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso47408275e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778059070; x=1778663870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wrRfzlO6Gwe188vt4uuT1uyKoETwkfhQhhNCQs3frA=;
        b=AN+YhfcVf/VfMt4niy+nMTtpCKpYcJcQK0VlpeHCQzE4+dzTkbX/GI6C0/M6922hvs
         PuEL3AQk4wRnCyNEm9MgANDEAiGv5gh2YIV7rgPzG4wCfpCROw+uYXZQrPT82gee0BU8
         671WoIbV2Z93ySLGHIpOB6kZp404qPcapteiB1H7rqbW49M/c3SEIrjGmupgo/Vdl+MK
         upBv8idwsx6FMrc2Rll4do54WVTngGkzG1JxYZMjlp+fch6A8CRawH93OiHWBo8fZhs8
         5uQRXLKPwdrr4qAUAsw/kfjEdewigOv8dAbcsVRtk1A388Oie9UlGGwiB+SEhLn5T7M1
         TvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059070; x=1778663870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wrRfzlO6Gwe188vt4uuT1uyKoETwkfhQhhNCQs3frA=;
        b=IfXhxVpZcqxs20TZ/WlTXg+b2Zd5zK33j2SaMJGR0n6UDvzkvyDsNbXJbBFCqOsvH2
         60YH1NlzkjLM7RIBbi40QQwR+Z9D9sbbJpriQKiDpfeaWZ2bg5glqZrF7gQ1CyAJLTik
         xz9FadPcE7VyqSKhlEZHaJcF0vpymeGW/anvm67RSqGxDDAx3gWj1E5+Z6YjZfAFju/D
         8aTtM6/Rkrp7jLd73EBimJFx6Kdvws5kKkXT/TXXrGiD1nZtg3AFZOeLL5W3O3KnT+B8
         gBIan4Vh/ToEB3fLNT4p7yLJpubH+W6fh+AIXaLZd5oovthgRfBIItk4IiylQvqPo2j3
         ioIw==
X-Forwarded-Encrypted: i=1; AFNElJ+KetqtpbkVT8PNfI6wCOSyXjXZCjR9dYawkFl2R8kR3jgn92KWqjKIfSwN8T1ikKZR2ha+t5Knv038@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0OHmVc6GmmtxnS12GnGxea5psnFlTs6RvBPiB7czCjhi6FJb
	pRwtM70lNKc8prCExZbGMwX/pqjLdXT21e6m27S9C2mUKCfsFnyF3+K9R1SzD0431dE=
X-Gm-Gg: AeBDietdolN0LWidHDzNKSCTdLNFOB6d1V1EU1mCmOWOnf8dZ//EXvOt4ZG2PG/PSMG
	YLwg8CYlDx2pV2BnSqzvIlh7hk5lNfv7iorfNS9WUYhDaEL9FliiHk/amoEv1wwFvpO+RemZl/N
	vHY1PV3roMTdhvhA7IpKz756sAwrLyaqMmYXELAMVqc72ErWJclW4OjH0/7foxeig89gv1kJ+t1
	D4HdBSXFbExrJ65EIA7LxA1aFbqNdT3Flmcj2QfMvVG0dWLQa5qmYq17txaBBpfUgT0ZRH9FbKf
	Q+9ybpHWEuTM/etvJACLmiZeRQyz/BQOU3b8xuSC7W6YWIxTDUbUllnvhfTXzQnNdppRtiL3VHH
	CtVh+iy3BkdeDg9ZBlKpI07yT/xWFiNsq8pOdTqg9FFbV15Jh1EbcFkdF6026ddg+1JQcQDMxE3
	a/tI8zUAJSWPSZDagId3LTt6r5d+aAYlkQtXNclND8cw==
X-Received: by 2002:a05:600c:c11c:b0:488:a723:ea53 with SMTP id 5b1f17b1804b1-48e51f5398emr30420065e9.7.1778059069695;
        Wed, 06 May 2026 02:17:49 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fb1a7sm66353855e9.9.2026.05.06.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:17:48 -0700 (PDT)
Date: Wed, 6 May 2026 11:17:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, linux-rdma@vger.kernel.org, 
	leon@kernel.org, edwards@nvidia.com, kees@kernel.org, parav@nvidia.com, 
	mbloch@nvidia.com, yishaih@nvidia.com, lirongqing@baidu.com, 
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn
Subject: Re: [PATCH rdma-next 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <afsGma7oz0A8QTuF@FV6GYCPJ69>
References: <20260505061149.2361536-1-jiri@resnulli.us>
 <20260505061149.2361536-3-jiri@resnulli.us>
 <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com>
 <afoUqiDgZmhE4Kog@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afoUqiDgZmhE4Kog@ziepe.ca>
X-Rspamd-Queue-Id: E7A804D887A
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-20059-lists,linux-rdma=lfdr.de];
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

Tue, May 05, 2026 at 06:02:50PM +0200, jgg@ziepe.ca wrote:
>On Tue, May 05, 2026 at 09:20:01AM -0400, Jacob Moroni wrote:
>> Hi,
>> 
>> Out of curiosity, it seems like we set DMA_ATTR_REQUIRE_COHERENT, so
>> would that have caused these registrations to fail anyway since it would
>> be trying to use swiotlb if running in a CVM?
>
>It is supposed to, at least that is the intention. I think that
>new attribute overtook Jiri's patch here?

Yeah, my patch seems to be redundant now.


>
>> I was hoping that the new cc_shared heap could be used without
>> modifying the kernel driver by replacing the normal allocations in the provider
>> with a dmabuf allocation+mmap and just passing the resulting pointer to reg_mr,
>> but that won't work because it's a PFN mapping.
>
>> The driver could be modified to accept the actual dmabuf instead for the QP/CQ
>> rings, but I just wanted to see if that matches your vision here or if
>> you had something
>> else in mind. 
>
>Jiri has been looking at both options, but kernel side irdma must be
>upgraded to accept a dmabuf for every kind of userspace memory.

Correct, the transparent dmabuf-backed-VA pinning is still in pipes, as
it is based on https://lore.kernel.org/all/20260504135731.2345383-1-jiri@resnulli.us/
Check it out in my working branch here:
https://github.com/jpirko/linux_mlxsw/commit/00c51b20a977bb63681d140d65d857f978b3b8a6


>
>This is why we have been trying to centralize more of the umem logic
>because every driver should be upgraded to accept dmabuf for
>everything...
>
>> Another idea was to just allocate them in the kernel using the DMA
>> allocator and map them into userspace but it would be a larger change.
>
>This isn't the pattern we are using in rdma..

Yeah, plus I'm missing the motivation, what that would help us to
achieve?

