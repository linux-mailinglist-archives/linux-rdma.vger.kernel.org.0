Return-Path: <linux-rdma+bounces-20673-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIbRLMaPBWppYgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20673-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:03:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2895053F904
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EED330254BE
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CADF3CC33F;
	Thu, 14 May 2026 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="w+v6uVs5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE7638E8DF
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749377; cv=none; b=sRZo4YwIdFePTM23D4KdjKRDZr9gk+1VG1jW8Z7socF4MuLpnK+WFmN7yM9SxF/v+lw8Jh4bJhzPMCFlbwxSL9WhP3Bd1NoGPrvqKEDjy6szTgao+oJ+RruLZj4mRuKBckwNU542QtGcCPhE8RcoPfobYcC9LiQUisbqJ1nVJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749377; c=relaxed/simple;
	bh=lsZQ9Qni5BG2+mYgoDJHmaXzuN4JdOiqjpVb+Qtb2Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/rpDfR9hkl9MALH4RyWk6ge6cpZ6EZV8+Fmnb3lmV4e38D8ugxQ89B10roMvdpsv4k9MCIXC93XVNGOOI6AVX695nBiemE7Jbavhu7jmUC8LKRTTyfiZnF2fY+Vi7AiYBJvyMuAp4ruXe36JjrzjPAO8cXJi8AgLjdTb7RXEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=w+v6uVs5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-448528f4e69so4470886f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778749370; x=1779354170; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=odUQIF8RY99k9e424SAOGu58meaPjWHcr39zOwblv4A=;
        b=w+v6uVs5Z7+CNSHSIF8QtZEc+ox3a0+EdHsAV4dv4lSAHS+J9p56iTxYMJZF1HbD/g
         dfdMRLsqDgr+47XZu51jXYK33lFyzBN5kMz8ZaWBZRBShU5qvXo2vS2VL7LfUXbJ5Dxp
         Zmjbpt+yYDhw2aUkAcFe2GGi5Z0D1Ze6Jd/MQbV/ozGVAllLi/BjOB6nlGq+P7BUYscr
         a6taMaHTrBLSYVUgiTFo+dXWDuRFHhmL6LZbrTR3vnHif+JInUaiEBZDjUh5KC+JMm7C
         UA/aAm2PTo77FTpWshD8AQ3lPf0npKamv5UfSAHsvMEU6ZJ/PbiPuWBybByAsuBAATef
         e2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778749370; x=1779354170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odUQIF8RY99k9e424SAOGu58meaPjWHcr39zOwblv4A=;
        b=N+A/rwEXA6aCGVl7ePWYF6U+qlxKVdKd+zSlod/VPkUyvjgMaQyuhks8gDkfHIg2a7
         zgTMPVg+Ri4Dx34TgQLWFJKCU+2wNeZrIhC4RkUQDHXHbA3h0Kro9uv5G3DY4UjRjGK2
         Zbh7b1YGmdn/fZs1ZD42V1pMdWTYWYoAOsidN/nPK/audWlVcjDuUQL/axu11wTEv4ej
         fzUqrbXaHi7foONlAiI4OP79rvJIqQ8G76oIrDXGYGsyJa18D4whJ4rBL9ymZk6df2w5
         s1riGWivL9xXIGKEwcMNlYaoaO/smDEUvSf92rRg8I3MTPZXhqY3vGIBVvdkLAET9NKJ
         NdqQ==
X-Gm-Message-State: AOJu0YxNgqxaKX+lnXdbihmSyu9bW2tuVzhay5LCGNDgEjeRZ00X/s+z
	5MNt6WtiuIkVxFRUXH+agrtnJnHWcrpsRCvrjbckrkRP8IXorTVuR12nlTZDdDkq2bk=
X-Gm-Gg: Acq92OG2P5X4ZzvYpSERnevcRwaCJfIBn3XoMxXjwLHuDcZX9e3+2dDmTpXosK078WK
	dDgHFrOYZaDA2Y5zMG1+Eq2datx5NIOERxXBlRcchMGMTn2YUJpxGAFPSaGIY3MdVkuAWImTZwN
	8S0PnDXOLqGe2fGEwp7gTe1GfRpLtCmcOv1uu9kwIjTaw59hZLeAw4NUhWcOQmuAqXnEwOk8cZw
	QtcZMWiD0aPI2Q6jk+XWwvvyhLuLDqsZ7y/WmMF/KDelv626O/x9y9GFB5flINeQVuLQj2icOX2
	/Dkojn1jDDi62vGWBNkTUq5DU1HG5kDh4q+X78iHVJs1KAYuQpayqIDqSeurHf+INxycxNOTNIW
	hJK+4EdB2OsDDYg3muMDoJlWcN7HS5aebBAFJbhlQ87alKzjBV/gKvy/sitnog+bTpP+qpGSukV
	VHSJ+nf/Sv08TpimQZZHKiauwxG5hFctc=
X-Received: by 2002:a05:6000:1847:b0:441:2aee:d561 with SMTP id ffacd0b85a97d-45c59cd2d7amr11165076f8f.28.1778749370150;
        Thu, 14 May 2026 02:02:50 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm5229899f8f.14.2026.05.14.02.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:02:49 -0700 (PDT)
Date: Thu, 14 May 2026 11:02:45 +0200
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
Message-ID: <agWOldIWkFI3i1xB@FV6GYCPJ69>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-4-jiri@resnulli.us>
 <aftENVgTr8AZVQnT@ziepe.ca>
 <aftL-2sJb4JfyDIs@FV6GYCPJ69>
 <20260512181236.GA175362@ziepe.ca>
 <agTNeYSOyMTbUbNt@FV6GYCPJ69>
 <20260513233447.GU7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513233447.GU7702@ziepe.ca>
X-Rspamd-Queue-Id: 2895053F904
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20673-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Thu, May 14, 2026 at 01:34:47AM +0200, jgg@ziepe.ca wrote:
>On Wed, May 13, 2026 at 09:18:28PM +0200, Jiri Pirko wrote:
>> Tue, May 12, 2026 at 08:12:36PM +0200, jgg@ziepe.ca wrote:
>> >On Wed, May 06, 2026 at 04:14:34PM +0200, Jiri Pirko wrote:
>> >> Wed, May 06, 2026 at 03:37:57PM +0200, jgg@ziepe.ca wrote:
>> >> >On Mon, May 04, 2026 at 03:57:17PM +0200, Jiri Pirko wrote:
>> >> >
>> >> >> +/**
>> >> >> + * ib_umem_get - Canonical on-demand umem getter.
>> >> >> + * @device:        IB device.
>> >> >> + * @udata:         uverbs udata bundle (may be NULL).
>> >> >> + * @attr_id:       per-command UMEM attribute id; consulted if @udata is set.
>> >> >> + * @legacy_filler: optional command-specific legacy attr filler.
>> >> >> + *                 invoked if @udata is set.
>> >> >> + * @va_fallback:   if true, build a VA-typed desc with @addr.
>> >> >> + * @addr:          user VA, used if @va_fallback is true.
>> >> >> + * @size:          driver-required minimum length.
>> >> >> + * @access:        IB access flags forwarded to ib_umem_get_desc().
>> >> >> + *
>> >> >> + * Return: valid umem on success, ERR_PTR(...) on error, NULL
>> >> >> + * if no source produced a buffer (only possible when @va_fallback is false).
>> >> >> + */
>> >> >> +struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
>> >> >> +			    u16 attr_id,
>> >> >> +			    ib_umem_buf_desc_filler_t legacy_filler,
>> >> >> +			    bool va_fallback, u64 addr, size_t size, int access)
>> >> >
>> >> >I didn't try to look at what the drivers actually do, but I'm slightly
>> >> >surprised not to see an addr_size here? Is it the case the drivers
>> >> >don't have have a uhw->size to go along with their uhw->va?
>> >> 
>> >> "size_t size". What am I missing?
>> >
>> >size is the minimum length, not the actual length passed into the
>> >system call
>> 
>> Right, you're correct. Size is the post-pin minimum, and on
>> the VA fallback path it serves also as the pin length (we synthesize
>> desc.length = size when no attr/legacy filler matched).
>> 
>> There's no addr_size because no caller has a user-passed
>> length distinct from the driver-required minimum.
>> Drivers either have no length in their legacy ucmd (mlx4/mlx5 CQ, mlx5 QP,
>> the size is driver-computed from entries*cqe_size etc.) or they
>> pass ucmd.buf_size which serves as both (vmw_pvrdma, qedr, mlx5
>> SRQ, ...).
>
>This is what I was wondering about, so how does it work when there is
>a ucmd.buf_size and also a minimum size computed from
>entries*cqe_size? What does the driver write?
>
>I think the driver has to pass in both the minimum size computed from
>entries*cqe_size and also the uhw exact size? The minimum size is used
>if the uhw path isn't used to check the other attribute while the uhw
>exact size is used to pin the memory if the uhw path is used - and it
>should also be checked against the minimum?

I asked Claude to check every caller: At the moment of conversion
none of them would have addr_size != min_size. They split into
three groups:

  1) Driver-computed total only (no user-passed length distinct from
     min). addr_size == min_size by construction:

       mlx4 CQ/QP/SRQ           entries * cqe_size, qp->buf_size, ...
       mlx5 CQ/QP/SRQ           entries * cqe_size, rwq->buf_size, ...
       bnxt_re QP/SRQ/CQ-resize max_wqe * wqe_size, entries * sizeof
       mana CQ                  cq->cqe * COMP_ENTRY_SIZE
       hns_roce MTR             mtr_bufs_size(buf_attr)
       qedr SRQ producer pair   sizeof(struct rdma_srq_producers)
       all DBR helpers          PAGE_SIZE

  2) MR registration / opaque user umem. The user-passed length *is*
     the request; there's no separate driver minimum. addr_size ==
     min_size by definition:

       reg_user_mr in every driver
       mlx5 devx user umem

  3) User-passed length without a driver minimum cross-check today:

       vmw_pvrdma CQ/QP/SRQ     derivable min (entries*sizeof, wqe_*),
                                not computed in the user path
       qedr CQ/QP/SRQ           ureq.size, no min computed in wrapper
       mana WQ, QP raw_sq,
            QP RC queues        ucmd.{wq,sq}_buf_size, queue_size[],
                                no derivable min
       ionic CQ, QP sq/rq       req_cq->size, sq->size, rq->size,
                                no derivable min

For completeness, the two drivers that don't go through ib_umem use
the same single-length shape:

       hfi1   hfi1_acquire_user_pages(vaddr, npages, ...) — thin wrapper
              around pin_user_pages_fast(); no separate driver-min check.
       usnic  usnic_uiom_get_pages(addr, size, ...) — single size, same
              shape as ib_umem_get_va().

So across the entire RDMA tree (umem and non-umem) every user-memory
pin helper currently takes a single length, and no caller
distinguishes a user-passed addr_size from a driver-computed min_size.

Group 3 is where addr_size != min_size could become real, but only
after each driver is independently tightened. Until then the split
just makes every caller pass the same value twice and would leave
ib_umem_get() the only helper in the subsystem that enforces the
distinction structurally.

Given that, I'd prefer to keep the single size argument for now and
spell the contract out in the kdoc:

  @size: minimum required umem length, validated post-pin against any
         descriptor produced via @attr_id / @legacy_filler; also used
         as the pin length on the VA fallback path. Callers that have
         a distinct user-passed length must validate it against their
         driver minimum before calling.

If/when a driver actually needs distinct values, splitting into
addr_size + min_size is mechanical.

Would that work for you?

