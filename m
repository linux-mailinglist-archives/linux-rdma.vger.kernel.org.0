Return-Path: <linux-rdma+bounces-20135-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHorLaJy/GkEQQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20135-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 13:08:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B62574E73CC
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 13:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC98A3006D64
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC536CDFE;
	Thu,  7 May 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="vjhgEdP4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8823128B6
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152090; cv=none; b=C0AKayRJ4R70gvC1gyQL/fIG7Dgn1tLo1skJRYWK0bK0KQ3lFe3P0A8GnOWMV7B0Oxzp++PESrg4ThB7QzRvcLVMtGHknizyYeuvYch6V3Ao5T/OtdHGYJ7ZcukdSjWXjjT9ZAMTuTdaQ2Y25KB18Py2PaZAqkRWsMY3+DSDhIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152090; c=relaxed/simple;
	bh=Nsrc00XMPyX354SuXe3nqx7fE5fihqR3ZqDdgpTbxkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufCjZZtxI6lC7onmN/KNUUYZQgX+TZmsr+WmcykcA+hqHmbuhmUoap8Z0TLRDb1+LxW547pfhOwaoX84dnhwZCZHl/ZB/Wcf/HeU05hHc+a8F+aoTEJUy4Z1vJ3D8ceTcAQOSJMozzV9MogJl9jq62U7iZpFdpOj+Aqbmi4vUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=vjhgEdP4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so395344f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 04:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778152088; x=1778756888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kgrq7ox95689Ig8vha0xiBqXHGOC+ZuPbRsEee974HA=;
        b=vjhgEdP4XA6KSiKerw/89U6Z3XXtAo8tQ78KeMc9QWmjVF4e6YVKYWxt5tYkBJnFaU
         P2zcDqAQdZfRk/Z3MbZAi0Ypr6nkx6IzwgYMAvy7/fwPWXFSV3eRc5pT5bqYyLlofl8O
         uq8AnIAklk5MLvi6DQeEEtPXtnmIDL8dr8HADz2DAhE4QRJl7Iv3gjmHWJfwzn7QBzmx
         FSwGSsV26p+a2GVUXVjhGKFT7c7igFfu/FIn+sObWqLJw5M0GU+JqBwkWwFjd/gTCJmm
         mxT7IX3+uZKfWeN8x/7GjGrUlY3eyiJceB65Soe39Iqh0l+FPVIhauFzr/o7oL/G30lA
         GBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778152088; x=1778756888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kgrq7ox95689Ig8vha0xiBqXHGOC+ZuPbRsEee974HA=;
        b=hfhO7oPkXEzVpJduGtFZ8qphQopFWAa/JhY7NcdiN6tQLUYgAL34I9WE3wDG55MtCe
         TngqE8c6hi9efayvS5QPbAbGdu1j+l+L+apoLSloiFk43G+pEG+N2B2AWnlZyA9X9yLf
         6qif46rpMm7UmQyCKUgnPx3T0aD0tE6uVWnMCI4Yfs2mEaH1bs5kDjJ32QPSv3R4djuy
         hK3ek3QsXLLcvOPW/k22Zm/yhFyDAtVm+E09Mkf9MFjWjjFYS70oCosdod7IuVYEkpdN
         B8VHBCe9oy+Avq5kb1uMQbdmtCvSzlCmnUVVPHloo6OyEib9bcqrUH/QnDZGZEiFmuST
         Kkrg==
X-Forwarded-Encrypted: i=1; AFNElJ+YKn6ONSK7EijxfyTYnB6y78c7JBQH+8Py38ORG383dYTjq79Uic7Yr9O/y/Gf0BY+wtyzdRMajxFG@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFPyE78Ww1KC+2neLnu6FM2d0eRMyIu9oKM4Bhp4u1IJwSeMA
	+k6h4fnfbl+CDNz0lMaign7w86JR/KFj4ycSlx6mp9UMyDgAg6vYc6PDMobpjkrhjMM=
X-Gm-Gg: AeBDiesRuWkaztzIJiWX9guS6BSMOGdS2uD+ywE/Ck0aoQCvUQ9mGPAzxy6+MYRcnl9
	wWjQGFVbLOu0xa+qlcCkFwPsOz6Ne5RftwQhhthKTwFDJVGNGkvnQ53ZwnBVjb++gNW7US/8FaZ
	cJcxF8+M9z0BlIL5vXKWVZHmNIMdQREYJL9cBakHh9cfR+kvKJ5J6GX2WmXOZHWUDXO76i75BO9
	fbzc1sKFLd/yZ/zS1qOemDRf5/Cg370zzXYVVKL0Fy2zVg98Qw4HLN+BGXCSOthmvZjSw/4i7Z1
	w/de6jRIYF9s5vCE3Qqo5P8460RYv9uPAa1ycEQXbk6Y0aYef8s+EwTtiPxa370jvqraFPj7KIN
	dnIuyO3b07JTBlXOeQYddXNlyF51tQOsxlsdGyY9wHMToZmuE4lMpraaAKgKRGCD/DbX5W/QD2Z
	N6FIfOkjDgduKhsu+R0vHSxuKwgmBbNUY9DGVkUwbQ3YBfu6epBvkINw==
X-Received: by 2002:a05:6000:2c05:b0:44a:aa3c:5927 with SMTP id ffacd0b85a97d-4515d5c69b6mr12915400f8f.29.1778152087145;
        Thu, 07 May 2026 04:08:07 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:6064:31aa:7680:7221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02abbsm18552017f8f.18.2026.05.07.04.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:08:06 -0700 (PDT)
Date: Thu, 7 May 2026 13:08:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] dpll: add fractional frequency offset to
 pin-parent-device
Message-ID: <afxyKwzMcnc4AEu7@FV6GYCPJ69>
References: <20260504155340.411063-1-ivecera@redhat.com>
 <20260504155340.411063-2-ivecera@redhat.com>
 <20260506183342.767b5fbc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506183342.767b5fbc@kernel.org>
X-Rspamd-Queue-Id: B62574E73CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20135-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,lwn.net,kernel.org,nvidia.com,microchip.com,linuxfoundation.org,linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Thu, May 07, 2026 at 03:33:42AM +0200, kuba@kernel.org wrote:
>On Mon,  4 May 2026 17:53:39 +0200 Ivan Vecera wrote:
>> +          At top level this represents the RX vs TX symbol rate
>> +          offset on the media associated with the pin.
>
>Isn't this a hacky hack? I'd think that pin is in or out.
>Having a freq offset between two pins or pin and parent's
>ref lock makes sense. This new interpretation sounds like
>we are trying to shove a difference between two pins into one?

The pin is in, but it is associated with SyncE port that has RX/TX
symbol rate offset. As the doc says, the "offset on the media associated
with the pin". Why is that hack?


>
>> @@ -299,6 +299,10 @@ zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
>>  {
>>  	struct zl3073x_dpll_pin *pin = pin_priv;
>>  
>> +	/* Only rx vs tx symbol rate FFO is supported */
>> +	if (dpll)
>> +		return -ENODATA;
>> +
>>  	*ffo = pin->freq_offset;
>
>It's easy for driver authors to forget this sort of validation.
>We should fail close, so it's better to have some "capability"
>bits or something for the driver to opt into getting given format 
>of the call.

