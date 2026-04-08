Return-Path: <linux-rdma+bounces-19133-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHDDCMVD1mk0DAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19133-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 14:02:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BACEC3BBA72
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 14:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BE9D3036D65
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2026 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547E3BC676;
	Wed,  8 Apr 2026 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="mliC2jwX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A303BBA01
	for <linux-rdma@vger.kernel.org>; Wed,  8 Apr 2026 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649709; cv=none; b=IWdk+kvsgt1TUx+JOs9AjtTpt41Thmk/PXpKr//kYEXuQD0T3r4LsSao7fykPcuWVCAr41Sv0XWc6k2SuoOrgXXrh1bYulbYyRxikrfDZz65bKvM62RUCxtRVpTnqv1XJ7wBcztdqWDNFVT8eNfYtPMCyUGEBC+5AXXvPj28Bsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649709; c=relaxed/simple;
	bh=UEdb6b6Z5iQlGQJZPDCcB5rUaLckwRSveh0FGowiTB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl/hdD6qE2vMzZyZaAf9pl9nJFRC4Bnk8nwt+s6wBr70uzxWa3mq+2NpkwSFG+a2rQU75ju76V1aKIdXOih5Z1c4ouFkKRwPrizl7KhgV+sIoXy7yDs9N4AAHj0BVqq8NeMomTuMSJXihcroD/gkd5bMb+QNqOSgWI0ZNWExYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=mliC2jwX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so564160f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 08 Apr 2026 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1775649707; x=1776254507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKYv/92g4USBYnuvjQ2o6KcGgYeWGPu2ptasrtf+UBI=;
        b=mliC2jwXaNGrsu/QC/M5rKsg2cnQu95WnGY381hlLcLLO7rcDiYWRysk1TrzBllamY
         vFv3SneOsCU38DBmtJYyrIiAyn0FfHGsasgDGiqj54AGZj8FtPS9Jej5ULgc07u7F/as
         EC+RxgI453J2kf7ql7QeZKsIE+D7Wvd+EN81Snvnw3mt9VZuRq8QwVwcb1R9U9Uv+Ye2
         ZK1i2efYgowdGJxhN5gd7pLK5fGlD2QwczufcN3GHi1LP+Uc6N9fSWcZZUghYf15y7qW
         EUu3j+B3oOp2C5HVzeNBANw1atqr/H03oBsQPsOK6xFfGGXyTsATqLySTlTkYJKDfpmq
         e7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649707; x=1776254507;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKYv/92g4USBYnuvjQ2o6KcGgYeWGPu2ptasrtf+UBI=;
        b=qtLxsXfGq/jfL0kKiJeKkWSV2vPwhavdDgj6G0SqneWybfHrxiNFAeHIU5x7S8YdhL
         5UuIUKZ561vLt7o/ogt5TW3WryuNiSmo0Uvcl0FiNwK1UKuvJ3ZTFzubhwajBLtEXrbx
         PMy9B/mf3P2MjyiHThBHTBV9dPwNgzdqk8K5BHjm1A575UNUCeu9tBhhkw3iKYdG6/MN
         R0Pdb2419Cld97nP0CmoViAtiKUa11hnbVSPYp0GW2/lVWFqDC/SfBcrFgXCFRuhb5Q4
         a5IvYS1kjQbtF8Gz7+5U+0fvMjTeumgxrc/3+vjp0DO5vwASWu3le9yXSEhbKlEdj2uL
         tJKg==
X-Forwarded-Encrypted: i=1; AJvYcCVgEYS0kgoEOuXkSSjsIJbJ0D9Jh2Ky36mJKwhQn6ogkvpozAl8g1vYNzpde10P0urjMPP8KDgDVtaX@vger.kernel.org
X-Gm-Message-State: AOJu0YyvL2ER0VvsTaORIcGyyy5vmofee1wX9wKXpSKsqiSS2TBowHTL
	Wr/z8XLlffxR3UbTFSMAnOEGEoUu301+1D2Wupc0VfyJbjUSeUZXbeucgo7scM49sSg=
X-Gm-Gg: AeBDieubYthFmeNoyftSgl4dtG/L9DMDRu1lHZuM0XVbRheVIvtFf42ttdpKhpwTPF9
	813R4zgQaxgVro+nou1F0T8cJjR9zL21WSiKwzfsTlHWJO9en1X7WXVw/aeIF9PAZPqdBGVk14s
	kDWZnAjRlH3lOjn6iZ+RRlJsEIS/crjrdXkm8KgabYsgc59f7YefOGmRedHv4vOjblT3yUZ6teG
	IEYcCp7JsrWBeb+kCoIHBb3yIIA9tbZAXVzNwFbBJFIxWqI42AsLmK5mchs1hCIxWxhxIeuvtlO
	vCKi6J8PZxbwIWLQDR915TVsrVg2dygB9+UmLnpX040ezaErN2H/JitjRbssgJ/4rY3KhSK8ndF
	bpeh6+4vTyOOWK5x5xmMG2tzjnY87Bw8LiqFRiSPIK9vMmadIKofdWkBW6rKoN2N+Qz39Uex6BE
	OmUfqiptXAn/unWewogUil2HR4aZfA2SzjXGOnGFDsAn/+/kCtlMcUIvgNzFdrw9v9OGqSuQ1X6
	I9cMQ==
X-Received: by 2002:a5d:5d0a:0:b0:43c:fac5:d382 with SMTP id ffacd0b85a97d-43d2118dc50mr36398359f8f.12.1775649706776;
        Wed, 08 Apr 2026 05:01:46 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm54605833f8f.35.2026.04.08.05.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 05:01:45 -0700 (PDT)
Date: Wed, 8 Apr 2026 14:01:43 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
	Joel Colledge <joel.colledge@linbit.com>, linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 06/20] drbd: add RDMA transport implementation
Message-ID: <adZCPanS7iZlcPE9@localhost.localdomain>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org, Joel Colledge <joel.colledge@linbit.com>, 
	linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
 <20260327223820.2244227-7-christoph.boehmwalder@linbit.com>
 <adXq36pbGLXMZc2r@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <adXq36pbGLXMZc2r@infradead.org>
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linbit-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linbit-com.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-19133-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BACEC3BBA72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 10:42:55PM -0700, Christoph Hellwig wrote:
>You really need to add the RDMA mailing list before adding new RDMA
>code.  I'll try to review the bits I still remember, but you also
>need a maintainer ACK.

Thanks for the hint and your detailed feedback. I'll address all that
in v2 (plus some other similar fixes).

Thanks,
Christoph

