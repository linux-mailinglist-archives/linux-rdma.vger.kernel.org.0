Return-Path: <linux-rdma+bounces-20846-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNYBFavNCWq2qAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20846-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:16:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A0556190E
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E72B3004627
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8803B7742;
	Sun, 17 May 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="vOeKLKcJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9339A7E7
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027349; cv=none; b=RE84j+MyNXS6Eq35AJSZNzIDpMjgU9IMKzA7LDCdrI0C0HlGXm4cba9oShp0D/Zgk69jXDP1qGskVjG+4eoS/PAWfzBA+bKMVsorEK47kMewyoB5oWKAFVJe0TbKVj/nK+9V7XuTCENHByUwhkNKPk5XrUARsGtcCRAoZYWSf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027349; c=relaxed/simple;
	bh=g9Q0iCkU0VDNjQx8ix43WhNpLgvGYQMggOZawm6j4sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7nytnnpGeqU2ALVAn/tVE1V1G9wOnyeeREhjjiwizeDP2bsd+azoxn9/wDvA6UrW+2XY/NoMv6pthPGDu3b4REKL9hCGFc54bOcrUXVsZeWDbLoWSzzX67DCWKQUBkZonlBrUaU+x2GzILLT143UOuJ935g7uxCH2Oaewl2cyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=vOeKLKcJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-441209fb77eso683999f8f.1
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779027344; x=1779632144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HkX/gFc4zx1iBWNKKtKboFVCS06ZTca6bzIy3pa7fzc=;
        b=vOeKLKcJdv9lSixSfkzxjRO0Utkd38UcZmMg/QgPSDw1+yoIJGsUqSMWEN1ytxYgH6
         yQ6+SkMRr+HOi7C5GF7jKYxtYINiOZtgKzbwUiPGeTTb9frdnp7/HJ55tfAoqAsZFaHN
         QTYGq9N/ExFZuSxYkY3Vglfl5PPzfKkdo92m7JFNPAaJX/P/bC5jurkltxyX5ZdWny+s
         c1i8dSNRpjwgITLAl4mA/7YPY4upcTBp6kkmH3rE2zGvH0QCV4Sy7ZUB1VKjf47nf9fR
         2DSvkeef20sflZC3FUwyWETlNhLXPM92PPLW+VWsM7BIZ9/psJD3INyoOWU7NGFeMrrw
         kJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779027344; x=1779632144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkX/gFc4zx1iBWNKKtKboFVCS06ZTca6bzIy3pa7fzc=;
        b=ahziskt1jDH6hBdziyKp0+b8fYjMr6UsXRyGi/Xp//SDhPoaTYV7tgUeVVnSi2SU7c
         JA92dSseWrF9CJuki8AdmgGbOrf1rzyfX0o6SZiOthLPmtYxglGdjH+xnF1n5KpI4kCA
         MILuX+1+LvUXfWkNFvO1wN2xPuNZaOiwjhTO59NCctgnJHNVkEuNuUcNLpjRcSXnEl8f
         bDOhIXte9WwWEIaevpSvOvH6G57K/ix60fCPA7JkV3FCYr7SldEz0qsDqu4LLR6LfAbQ
         NFk0Xfpfy1VKSK0mhXhewHUM4N4yYKC5iQVA3EOCXfah20WqQ3UCWRPkHQEts/6t8EsM
         SCnw==
X-Forwarded-Encrypted: i=1; AFNElJ9qDTOypaFgiLVpfVuir5kfwaY1hQ/lW16/Jdhd6515nVorzYtjHFFz3rZb3E5pdeWpR+KE4L1K59gX@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYohh5VfWJDT1kEic5mX1W1ZhH0KCWyOjp8dcQp/bfElxSRB/
	laYCFUz3s83sfbIlVBw9zIz1xvqYTDcCei8oaQrTcwEQFI3KUO1005g8LicW8szTyiY=
X-Gm-Gg: Acq92OEZmCBnlk00/vrFvNmDqw4Z0f67c68sfgLhCCZNdGCFQ93ozPm7iaYGsF61a4z
	lH3+IbloduCu2BSeS1gOGEHM8W/rIoODLs7VnvXmH7iLMkm/qqN0JRZeUMgG+gJ3ZH43HcIYO63
	5u9gH3mVtZLdHB7pW9iV65ol78tgX5wYGngeA47YIELmmg/6blokcy8IArhbHfp68Fymv/I0B7r
	U+Rc5u49dI1IKAsishktazsPNWdiNWX21SXlGlLhvH5Ejq6O7J+Yz2zwKcr1HFFGiKLga7rrlXW
	hPpcAyXA5lK4GBr2RCFWbNnuI5/7ivoZ3CjBu3SUw7Wj3jBhmvV7Q7Qz/mQaCkQ8Wp7nYu3Ao9O
	4OylFRhBhoMZa9DNbHjJIQALEeVKbnRt34PAOq5NwD1Qyb8z7AbN4Nq957B1Hyr0XtZY3hqB3yH
	0q1hkkSfQC+fRmEk7mmQOmQAUBHVLSFTqOj/R1J80OmR3ZTiG02QdkRw==
X-Received: by 2002:a5d:5f90:0:b0:441:2397:f40f with SMTP id ffacd0b85a97d-45d900ec71fmr23818062f8f.4.1779027343622;
        Sun, 17 May 2026 07:15:43 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:4146:8430:fb4a:baf5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm29807276f8f.12.2026.05.17.07.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:15:43 -0700 (PDT)
Date: Sun, 17 May 2026 16:15:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, 
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 00/16] RDMA: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <agnNSuse21HBK2TA@FV6GYCPJ69>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260512192319.GM7702@ziepe.ca>
 <20260517114755.GF33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517114755.GF33515@unreal>
X-Rspamd-Queue-Id: 51A0556190E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20846-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Action: no action

Sun, May 17, 2026 at 01:47:55PM +0200, leon@kernel.org wrote:
>On Tue, May 12, 2026 at 04:23:19PM -0300, Jason Gunthorpe wrote:
>> On Thu, May 07, 2026 at 02:52:15PM +0200, Jiri Pirko wrote:
>> > From: Jiri Pirko <jiri@nvidia.com>
>> > 
>> > This patchset introduces a generic buffer descriptor infrastructure
>> > for passing memory buffers (dma-buf or user VA) to uverbs commands,
>> > and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
>> > bnxt_re and mlx4 drivers.
>> > 
>> > Instead of adding ad-hoc per-buffer UAPI attributes for each new buffer
>> > type, each command declares dedicated UVERBS_ATTR_UMEM attributes that
>> > carry one buffer descriptor each. Each descriptor specifies a buffer
>> > type, covering both VA and dma-buf. A consumption check ensures
>> > userspace and driver agree on which attributes are used.
>> > 
>> > The patchset:
>> > 1-2,4. Plumbing: rename ib_umem_get() to ib_umem_get_va() and re-route
>> >    it through the new central ib_umem_get(); no behaviour change.
>> > 3. Introduces the core buffer descriptor infrastructure and UAPI.
>> > 5. Inlines the const attr helpers so ib_core can use them.
>> > 6. Factors out CQ buffer umem processing into a helper.
>> > 7. Adds the CQ buffer UMEM attribute and driver wrappers.
>> > 8-11. Converts efa, mlx5, bnxt_re and mlx4 to use the new CQ helpers,
>> >    with drivers taking umem ownership.
>> > 12. Removes the legacy umem field from struct ib_cq, now that all
>> >    drivers use the new helpers.
>> > 13. Adds optional whole-QP, RQ and SQ UMEM attributes to QP creation.
>> > 14. Converts mlx5 QP creation to use the new attributes.
>> > 15-16. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
>> >    doorbell records.
>> 
>> I think it is OK looking, Leon?
>
>I have a strange feeling that we have too many ib_umem_get_*()
>functions. For example ib_umem_get_cq_buf() which doesn't accept
>anything CQ specific. Or this general ib_umem_get_attr_or_va().

Does not accept anything CQ-specific, but internally it works with CQ
attributes. That's why.



