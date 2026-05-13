Return-Path: <linux-rdma+bounces-20606-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNpGFdfOBGr0PQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20606-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 21:19:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB4B539D0D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 21:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1673305B2E7
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CDB3B19A3;
	Wed, 13 May 2026 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="mlcJge/c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1F3B5E08
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699920; cv=none; b=TFzWGrX76rqJ41ftuHdB9Y4vK5nDfkITwiDL7DB4DEmRS782lMFE1BpUQUvoUmP8rc3GT4NGzayufUMHkWvwbTKHNvzP2+CMg/fUMaxMXxeLL+kQfgYW/CkadslgJkC97mQt4SmYLo9sjIHcDH0+MEDZN49DtAzggmzJWl2M4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699920; c=relaxed/simple;
	bh=sorhgcn4BAE5nv2ttSLhun73TJESVQ7lUyBDCwfv5eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNIqHDYmztPjg2Y7EpQFJ30dbnX/gLuF3iRFU9dNW9CiaqZ2ZrhLu97eDNs7X0Cb2HjRUR87XQBNqR9TkVwZTS+SW5CxRvLpmJnrTpS0fjAkDjPAGVHx1xNv/P15JIy61UX+9OTc11xjjrmG6uoiTs/eOC0XJrzU5n2W25+xBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=mlcJge/c; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488d2079582so74376405e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778699914; x=1779304714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//kpRyV6z5Q7j3m6KMJqYx4WQ5GSLEFDBfeID1T1/8M=;
        b=mlcJge/cMq2NDohGNOSRbJ12XK2avXYjQ3Md/d77fhANmC3wWPtAmgJnpVCm1njWm/
         LXSagvQHmXVcG3SAl1ceunSCQhvs8UV/AdQg/LD0hKOb5+K2ToHusJiYst5Qt69Y6s05
         pRgT5W9nODikdU4fZbzTHpaRpXYj7Vhi0tfrCTCBMU/uk01jwNdDAIc/USl5OSXmoujO
         WRYZgaAPjCCk947M6zPUiYeLd7Qlv/+rH1qUG9oXlwmgVBxMW4IWV7T5jMJGMTOt+zSa
         UNLSnsbd+/TGF0nmF0U9uUbONgRmpPON3mEwyATeOTl/1/fWhlETQEmrXhf6ajLYOwCE
         +mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778699914; x=1779304714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//kpRyV6z5Q7j3m6KMJqYx4WQ5GSLEFDBfeID1T1/8M=;
        b=qnaLx0WgSMtkxa/x7EjT89GiZR32L85qbj4zt+c+IryiQMUxtMlDBicEz707wrWbnY
         rWAit8nDRHohrKemrKZD0ABPywseJCQMehTmHwPWkpp0byKEYDr0ENkXgl+9BZQV+lfq
         83d6cjxgeiG6yrCrhbxEbl8QwWlfGPUi1rbuF/0VCyy4Ld/InAwy3fG/so0Do/mh1pjQ
         HAv7vH6DOw2Z8OvjY2YFB3hh7NKein8ceVa9V0xCxvL1rB6w+CigrWuDjLZLdnt4Gxzr
         Nc11anqLUpNt72FbPorEPmyWmb95yOB0JYs1CEDdovnz2+fCPQ4WVu/A4q9dGmtM75v4
         HU9A==
X-Gm-Message-State: AOJu0Yz2T5rqiuuPozHS9H2cJ7FDXjTlkXiAWd3d6tbm0gRY0PMk42py
	ZmAThlR8KToIVlNpVmWEPdPJemm2+mP/5GPqAgZBmChi35XVbbXgV4sbF2Xpu14MBOo=
X-Gm-Gg: Acq92OFeKFBF6dGzlAW/yrDWk/vHycGclYut7V1c0+Yryn+SAsdYe5pLMXCzZfwv1hP
	dcAcMc4dvmWVIw+xQagByJiXnpVfNZh8+cioDTZs+z83WwzajrmawS4WxjEKa9HBycE1BADnPMO
	Vii9wF7BHN3aTjicO+d1V9YjgVRb8pAZOsmXI7Z4dNHahmgE8Z4hbSoQjsesRvsZi0tZ79cUGGv
	O3nD1On7GPGhAvoQw3zIu7CXV7hnupqfP0hV3PVJEvb20Jn7r6uasWZW9zcsvkz22WCVUQ+C1qX
	3LKIHhtskZ3aF2MI+Gk6LJt1P7B+r8XzKqvhfockoQrnD7DYzdGt43W57M+rRm/OLICL/OPo5+Q
	cQISbH+niHibDErX2OrNtrx+rqeKnCtgkPIKqJaPN8F5IEPvpHa8bFG6Sm6TP74GW8f0lTtgXr4
	vX526ha5rDIBlyuvoxHRo8Qpli2J6sBrcu8/4zgxlDEbxqig==
X-Received: by 2002:a05:600d:1c:b0:48e:526e:1012 with SMTP id 5b1f17b1804b1-48fce99dc29mr43057135e9.5.1778699913237;
        Wed, 13 May 2026 12:18:33 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6497ec7sm11613415e9.6.2026.05.13.12.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:18:32 -0700 (PDT)
Date: Wed, 13 May 2026 21:18:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 03/17] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <agTNeYSOyMTbUbNt@FV6GYCPJ69>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-4-jiri@resnulli.us>
 <aftENVgTr8AZVQnT@ziepe.ca>
 <aftL-2sJb4JfyDIs@FV6GYCPJ69>
 <20260512181236.GA175362@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512181236.GA175362@ziepe.ca>
X-Rspamd-Queue-Id: BCB4B539D0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20606-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 08:12:36PM +0200, jgg@ziepe.ca wrote:
>On Wed, May 06, 2026 at 04:14:34PM +0200, Jiri Pirko wrote:
>> Wed, May 06, 2026 at 03:37:57PM +0200, jgg@ziepe.ca wrote:
>> >On Mon, May 04, 2026 at 03:57:17PM +0200, Jiri Pirko wrote:
>> >
>> >> +/**
>> >> + * ib_umem_get - Canonical on-demand umem getter.
>> >> + * @device:        IB device.
>> >> + * @udata:         uverbs udata bundle (may be NULL).
>> >> + * @attr_id:       per-command UMEM attribute id; consulted if @udata is set.
>> >> + * @legacy_filler: optional command-specific legacy attr filler.
>> >> + *                 invoked if @udata is set.
>> >> + * @va_fallback:   if true, build a VA-typed desc with @addr.
>> >> + * @addr:          user VA, used if @va_fallback is true.
>> >> + * @size:          driver-required minimum length.
>> >> + * @access:        IB access flags forwarded to ib_umem_get_desc().
>> >> + *
>> >> + * Return: valid umem on success, ERR_PTR(...) on error, NULL
>> >> + * if no source produced a buffer (only possible when @va_fallback is false).
>> >> + */
>> >> +struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
>> >> +			    u16 attr_id,
>> >> +			    ib_umem_buf_desc_filler_t legacy_filler,
>> >> +			    bool va_fallback, u64 addr, size_t size, int access)
>> >
>> >I didn't try to look at what the drivers actually do, but I'm slightly
>> >surprised not to see an addr_size here? Is it the case the drivers
>> >don't have have a uhw->size to go along with their uhw->va?
>> 
>> "size_t size". What am I missing?
>
>size is the minimum length, not the actual length passed into the
>system call

Right, you're correct. Size is the post-pin minimum, and on
the VA fallback path it serves also as the pin length (we synthesize
desc.length = size when no attr/legacy filler matched).

There's no addr_size because no caller has a user-passed
length distinct from the driver-required minimum.
Drivers either have no length in their legacy ucmd (mlx4/mlx5 CQ, mlx5 QP,
the size is driver-computed from entries*cqe_size etc.) or they
pass ucmd.buf_size which serves as both (vmw_pvrdma, qedr, mlx5
SRQ, ...).

The legacy-filler path does carry a real user-passed
length (desc->length from UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH or
the per-attribute UMEM payload), and there size is purely the
post-pin check.

I'll tighten the kernel-doc to spell out the dual role:

  @size: minimum required umem length; also used as the pin
         length on the VA fallback path.

Makes sense?

[..]

