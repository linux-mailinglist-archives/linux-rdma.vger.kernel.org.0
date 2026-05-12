Return-Path: <linux-rdma+bounces-20495-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IxJMuA8A2oq2AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20495-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:44:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFF1522D13
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07E0D303C9A2
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04823A7D9B;
	Tue, 12 May 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="IikTLBYI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6A3A59B7
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594931; cv=none; b=KPgGtQi4PuIovNU6cSW9HyppVPA5ZE3xl7yPNJgxlho3vORakxaADkDLobzkvs5fGJ8NoHA8BDrQAiSV4Ob2bfTStQY7qDnu2vJW3umffwKu9y+w6MOx38yp1kWvWnbXift2ptoo4VxxCC6t+tFA8yFCVhvu9DCsGJTvETsiOBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594931; c=relaxed/simple;
	bh=nFixi4/T3PqxWneEutYsxvxrO5Iqbo1HRj3m1GdYjtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdz6bCNoANMkSOIIYpWyHG9QIc+NYUfq+uFzgxnufhC+ilsB3yLG6fww7SipBjRp+ppW/TGjb5rfO4evC4qkAxuKWTEC0/2Bg1d7SZT5GQqBGO1yhRuY0IsDXj6vh72dCGorpxlaLUJJcKJqcXWNf0wQ6qTVEa6bTilJjG9BoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=IikTLBYI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso48041295e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778594928; x=1779199728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1PF3Clfdo+Tco3WNqFtoYy/JF/hr0CU+1k6e4Cd5uA=;
        b=IikTLBYIJ3UzEZUOkfJOHUQMMAHVBUu/XfSXIWbKfOCLT5lHtMQwJg7p/Tex4pI4UE
         KMDhIK8ycKaBG0BQkuG79sXLxQesdi+ua5JX9VqMMVZ6Tn5QCeE1aXAOafsJBS9FCE+U
         5iVppExWbOj+k1RSS15gRii5AGopODkYiA/gTBqCc2KRjn9CUQkOP+WVCOxB0WGShpwp
         o09SjqKQARalGUAuMGfCZmk4bq8q0DUsUWF8vFaI3GbpE3/Vm1VxQLuiLeD7je3a/1q+
         LEATviFYHFJbeCahfAn/RJoDcCJ8RfEhvhAcEebI43QVcHaL4hf1zdrmfOqBghWeL5iP
         Xp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594928; x=1779199728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1PF3Clfdo+Tco3WNqFtoYy/JF/hr0CU+1k6e4Cd5uA=;
        b=THQRjmotjh8MS6zLgVLdzke/ltW7ZnKRD1F1XCgVX2pWqLf+qstsf/9CLOtYYVGa0b
         hDK0W/JseeZ0VA8jTfWfvo1vD+55GFLnahMCQqgbRJB2oe7GMK9xSZyyi/eG56+fI3dN
         SW6ItKcVArPeFZpE+1cTAh5LJXP3+A/3TGiXYQ7DzXwS0JbdCtaraUiyjXgErEmL2Ckt
         bVzo0VG4R2uYTPEzA8G8NW2a6K+EkeKt1vNn+4LfMF1s0kPUCAxElbVMyjwlelreBdoR
         ioBT51rNJTSdNt1neT4Ep2bgn1MO0AmOo7dVLQev1bFNTUa8OHjRHeQcZHBP++80f4dd
         +IwA==
X-Forwarded-Encrypted: i=1; AFNElJ892enIkMOLyVVXeL11pYfk4O7S+ZGLh4QxB4OWrsMumSNLPEzr3vcfWqCS3FCIIbakwRl2QR/HYDmK@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwYxZmmJeMmqtOK59oUgOqa4PnIt/UAdIy1NDgmtadvwHkU9Z
	fUFROrHZzF9MEZ1JlFY3irc2qEsa1zst7pd5j9aPQ04DKLVSxk6oa0mvzDxnmlDSlAs=
X-Gm-Gg: Acq92OGUyog9TtcyIFYQvvtgYZmrnys1my9rj2pxRDRYFJyHgUE6PY0yC9NO4uE8vSg
	XLKsbkq+QSjKF7JGXFM0NunPf6LLxOO0jMI0H2X9KeEB7ALf1Q3aKGBcHaezR9cpOChciz1bunb
	x1PIN1p8d35VfjnPOHxcBsTjVv7sjzDmoHO8jvWzDrViNOEL/vJPGJPht+s+xM/tWsYek6dJnUS
	au7NrryMw1QaTKj6nt38fshiNCcE2Cz/5XoQJIYEFMweD9mHLYpsNO2XO3GXvwfDBkMfErGkV8E
	e8E/Zr5oFO12BO0SD5u3IwGqZhXuOxZG4KyjquF4RX4Jv9MPA6vD/KP4S4D8eRn+SRyVbEmXWd/
	peOnNjGqL5HVqW16SI0tWcmx6XTyXrUKSQvbsmF39y8S2HJz8vJdcVrdEB7NHrM1tLk7rW4RwgN
	aMeSSBFrqQC0Mu6/0MsKFwGMDXmCcSFULGZ1ysmwQmOMc3MA==
X-Received: by 2002:a05:600c:34c8:b0:48e:8741:fd3d with SMTP id 5b1f17b1804b1-48e8fe71c0amr6921865e9.14.1778594928368;
        Tue, 12 May 2026 07:08:48 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e5fd648sm19804935e9.4.2026.05.12.07.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:08:47 -0700 (PDT)
Date: Tue, 12 May 2026 16:08:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	edwards@nvidia.com, kees@kernel.org, parav@nvidia.com,
	mbloch@nvidia.com, yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 1/2] RDMA/uverbs: expose CoCo DMA bounce
 requirement to userspace
Message-ID: <agM0bHFFDnSBL8RK@FV6GYCPJ69>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-2-jiri@resnulli.us>
 <20260512130329.GU15586@unreal>
 <agMzG-ZX6TRoikrI@FV6GYCPJ69>
 <20260512140510.GA7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512140510.GA7702@ziepe.ca>
X-Rspamd-Queue-Id: CBFF1522D13
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
	TAGGED_FROM(0.00)[bounces-20495-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziepe.ca:email]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 04:05:10PM CEST, jgg@ziepe.ca wrote:
>On Tue, May 12, 2026 at 04:03:07PM +0200, Jiri Pirko wrote:
>> >> @@ -1419,6 +1421,10 @@ int ib_register_device(struct ib_device *device, const char *name,
>> >>  	 */
>> >>  	WARN_ON(dma_device && !dma_device->dma_parms);
>> >>  	device->dma_device = dma_device;
>> >> +	if (dma_device &&
>> >> +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> >> +	    is_swiotlb_force_bounce(dma_device))
>> >
>> >It is the wrong place. When I worked on my DMA series, I tried something
>> >similar (a call into SWIOTLB) to notify users that RDMA would not work.
>> >
>> >The general feedback was that this is a layering violation, and that any
>> >knowledge of SWIOTLB (and its API) should not leak out of the DMA API.
>> >
>> >You shouldn't call to is_swiotlb_force_bounce() here.
>> 
>> What do you suggest as alternative? We need to somehow tell the user
>> what is the situation.
>
>For now CC_ATTR_GUEST_MEM_ENCRYPT is likely sufficient.
>
>Later we should be able to detect if the device is in T=1 mode
>directly.

Okay, so we assume for now that every device is T=0 (which I believe is
the reality). Once T=1 device appears, it changes this "if statement".
Do I understand that correctly?

