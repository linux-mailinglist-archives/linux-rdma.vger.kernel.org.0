Return-Path: <linux-rdma+bounces-20511-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGnPExRzA2q55wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20511-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:36:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DDF527D4A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E30531733A9
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA425B082;
	Tue, 12 May 2026 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="dw1QkoUz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFA25B0A6
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610619; cv=none; b=T794sc7zrR85ktx5rEFWAe+vyDHXQyXSvW6pRQ4ngak3fZYJMBrKh5dz5cSZZWxMJTxT4pfxPbusQpCyt6kWp+sKVlhVlEKFF3/W2QCp741M1O28qmKWfQ0ACtXw/8iZs91CCzSHMjEbOlbLgp4ATKQmUnyeTmEXHOjCAL3rD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610619; c=relaxed/simple;
	bh=A7JUt9gim09vWLW/PaGF14i5dV2gC9bQ1PHoZF59AfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOCIPGCC5EXoJ+q5fSJ6Mgff8haI6roQuJiffXXsLPLxw8sFCC9GxLv9Dh2kxI7N5QEipCFc194qs7Ae4Cl9E+I+38ER4bHWrFFectS29An8DxxXjHPke1zZxPcx2j0twtiqEt0o2RrTMzR50niKYeI0A3GZMVV3ZxHDvnxbd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=dw1QkoUz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48d146705b4so71674145e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778610613; x=1779215413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpnX5MOQQbDWDyiB+H59voKXW1nDcmJVspMRxfTS/ms=;
        b=dw1QkoUz613IMcFSXFqakKmd9bU9x1mFH2zFigw0li3j8P80bXtfEEHXV/VndFtIv2
         ty/RoIFo81sjEUl8oHWYws/zFoAIGDtjTDDktNIbwZENFGZ9lRX5mlkPejOMpP9G7Flr
         lZ7iK46Yrvm47Ad8Tqmtwos1GM9Evd0o7C1ubEtXNykfgSeyeoEKYSyjuQeOn+eeQ7Jq
         K9LSWTjNvp+YZpOcmGXAMyuway5sCfhSj3gJVfTc0ACQli8h7PIhKoKpv/cNlDtiUVWd
         PGEgw9m1p/aSIChYogAhCPbiWzWH6E+N2J1I8KYBfL8gWkBbATwmYy2JwOiezy+3pfuu
         kXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610613; x=1779215413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpnX5MOQQbDWDyiB+H59voKXW1nDcmJVspMRxfTS/ms=;
        b=PEzaHDIqV2Qxox1xJaRBDdN2TChu4SWSQBC4tO5humYUBbdW+pydFrYnUiVFj7sAhW
         LlDht2vLFjZpzDgdCqIxmG55nlq33agovfNqWdSKpI3Y0/CSU6n29tQDN1lWKVk3Vr1c
         P9iB0pqJZ1QtALjRXZz5bQj4tsKT/R4pKd0rMMEV6lzVAXsad89MHg5zF345kjhAw5/5
         hfmrkNbA12hzLv+BJYO6nsvd23RTX3DhbjhPCkWZPt/XoNGg+vtIAkDMu6G49mbAUXws
         QLVQOpPwyFXNfRHuvcCl+9l+gsYbb9hGAlCyOyv+U1aY3hXYu8JDhDxrLiTEt23vbug8
         ixKA==
X-Forwarded-Encrypted: i=1; AFNElJ+5OebJrZFINyU/jQo+txZMJv15jEyZJBhQiCCjPHzfyrc7pQHl/18Lg80dAcTQLnQxeHNQxNdWgHYa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jP4B5VFb52mn81H1Rvm+jTQJyFn5DtBx3mm0fuwPE6uiCo8Y
	d6o81MZQud1glDVmRWQZCgOQ9Vkal2Q1831w5HzUpXEC7Xe2WkrJyAMVlHRkQij6z7U=
X-Gm-Gg: Acq92OF1wb/JCZ+1OWl3R/bwJVuG+xvNM4xAlmFav7Hpe4NMBssV9S8k/lmSifKc4k0
	u8NRtVvEPXzhvz0uwxcuRMFqhoo6BsIgACwzLXzXH7kFNbemXCaqz0yH4bpjgff0tM7HhhzTT1s
	3ENXYJyRKfpEj+0W7ZhLtjMyHHQ6zEfCmxFZUuA9BGodQ4bfJoOXZjs5PGzu+jbdvp6KcxvLfrE
	yfen14lVPHi+lSoU/0Nc5A67ps4C8e51mt1qbnUs263kIyWrkl4sZKScqhc6U0MTPyDGCHUYJkH
	EfLGS9QLrXiwhh2fGtacARdVFPcwCFVzysQvBWrMN4e/IjjM80FMSZR41nxaHAdbSNW1LTBFZGo
	JxCv/jcZVjHVONc2g4UEHQOH1ZT30n5kiCzWX8qbjHa6HmrqRUBP4KaG3IpVYwPYjrt2TeEghaH
	oqtFU5doIaPi5Lrcey7jelOqJ7vKREOyl+XQ==
X-Received: by 2002:a05:600c:5010:b0:488:b749:8482 with SMTP id 5b1f17b1804b1-48fc9a02312mr1330935e9.4.1778610613058;
        Tue, 12 May 2026 11:30:13 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.211.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e60f3d1sm36274755e9.3.2026.05.12.11.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:30:12 -0700 (PDT)
Date: Tue, 12 May 2026 20:30:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	edwards@nvidia.com, kees@kernel.org, parav@nvidia.com,
	mbloch@nvidia.com, yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 1/2] RDMA/uverbs: expose CoCo DMA bounce
 requirement to userspace
Message-ID: <agNxsagYQebMfEXe@FV6GYCPJ69>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-2-jiri@resnulli.us>
 <20260512130329.GU15586@unreal>
 <agMzG-ZX6TRoikrI@FV6GYCPJ69>
 <20260512140510.GA7702@ziepe.ca>
 <agM0bHFFDnSBL8RK@FV6GYCPJ69>
 <20260512143402.GB7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512143402.GB7702@ziepe.ca>
X-Rspamd-Queue-Id: 96DDF527D4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20511-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 04:34:02PM CEST, jgg@ziepe.ca wrote:
>On Tue, May 12, 2026 at 04:08:44PM +0200, Jiri Pirko wrote:
>> Tue, May 12, 2026 at 04:05:10PM CEST, jgg@ziepe.ca wrote:
>> >On Tue, May 12, 2026 at 04:03:07PM +0200, Jiri Pirko wrote:
>> >> >> @@ -1419,6 +1421,10 @@ int ib_register_device(struct ib_device *device, const char *name,
>> >> >>  	 */
>> >> >>  	WARN_ON(dma_device && !dma_device->dma_parms);
>> >> >>  	device->dma_device = dma_device;
>> >> >> +	if (dma_device &&
>> >> >> +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> >> >> +	    is_swiotlb_force_bounce(dma_device))
>> >> >
>> >> >It is the wrong place. When I worked on my DMA series, I tried something
>> >> >similar (a call into SWIOTLB) to notify users that RDMA would not work.
>> >> >
>> >> >The general feedback was that this is a layering violation, and that any
>> >> >knowledge of SWIOTLB (and its API) should not leak out of the DMA API.
>> >> >
>> >> >You shouldn't call to is_swiotlb_force_bounce() here.
>> >> 
>> >> What do you suggest as alternative? We need to somehow tell the user
>> >> what is the situation.
>> >
>> >For now CC_ATTR_GUEST_MEM_ENCRYPT is likely sufficient.
>> >
>> >Later we should be able to detect if the device is in T=1 mode
>> >directly.
>> 
>> Okay, so we assume for now that every device is T=0 (which I believe is
>> the reality). Once T=1 device appears, it changes this "if statement".
>> Do I understand that correctly?
>
>Yes, that is what I was thinking

Okay, I'll leave some comment for future generations. Thanks!

