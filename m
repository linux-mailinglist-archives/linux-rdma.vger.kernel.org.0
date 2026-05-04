Return-Path: <linux-rdma+bounces-19910-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLnVNYyQ+GlswgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19910-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 14:26:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 997BD4BCDE7
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 14:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 853B23018C24
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5343CF683;
	Mon,  4 May 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="FxZRCPzF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B163A7844
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897604; cv=none; b=kFNUxJc0lyVX9rsnBJZtpirYrntGz3mr29cjBDg0SCc2PuM4evp1Q7QLCYdIXMo1Rx8L1i3VzBAmIyyARhthqElW7nTfCVNpZQzu80rX6niAtbUS1mewsJwbbVKwdtZ14miHOAjpgL32+jSFF2GXGL6VtyoJmKfRxdUighR9KDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897604; c=relaxed/simple;
	bh=GuKduAnAifjM+KgXSrO9TSTQq1fQjT1dMuJSNnmK2KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtLDdSHgArITnr84YQ33WN+mQAki15PT+RGpUzuMRC7HmYSva5vLEEn64326rEzoJ1igX3H1kAALcFMIVlopNnyblgoDxOQt5CAtaoC+ZlTkNB1KNbstLemz2YhfMHCRyofRdsBImKiq9OPAe+JEJmVBYsX/CpSgjZ1IhzW26do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=FxZRCPzF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso28793725e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777897599; x=1778502399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djsbXCX96LzcDVFKY3N8T8f6fULjj9Xl7NUY8EOdjGw=;
        b=FxZRCPzFYRv2+F+2okSUuhTlDvhfok8708y2yAhiSK/6qikCv2BPPK2beb7Du2qKfm
         0Qri/7wtazK0S6qU4WpOGBqsSgG0nmkcTf8piFxbopGdzFSXuNC4N/n6VCttw8MWA2t2
         5oJ7vY9EtKgehzdQRnhHWFwoa0pEDqxgPyMTbWydWhe4d5Va587TWR6kkZQsy5zsZKv1
         3rnmsfMf69aqP0m+4z6h9NwQ5RoOBg0++bxncSL3SmdPrkpk1zkVk1bREXtm8+jYHev1
         Aq0MZEoJFUSB304hWU4KZsRjNIa+AWbkJr/nc1Gq0XOocorpsfYyC1No5vc4P3lQfkgb
         Mxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777897599; x=1778502399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djsbXCX96LzcDVFKY3N8T8f6fULjj9Xl7NUY8EOdjGw=;
        b=E2gYUqMozJWnv6O4K9PP+QnX5SkUJH0CNRJZkmL/Vc3XZK5A8YyyV+lyEK76qg1e5/
         Hvms4f62TUHoHAKD1k9C1YqXU5dsX613JpIAQ4HBxossHsLLUp2oHtkn1qVzlwQChQ8D
         MJCq/S3ZTYbgzDvdG4D2z5q+IcyNeT2ltP9vsj0BluDvep+fDBjGFA27gDgMFTo/WgJ8
         rkyDEyorT3+zVVFqjBoZbNIjnxI1gvR2YwKvUG1o7dEexg7nf5D+vCtzoAVBt9ucnMPa
         AlG4Vx5AtrDgHpIYax9U19F1Svx6EQpd9xAuEvSSsZierbF9phlBk6Ghx5QidB3VAZW+
         qP5g==
X-Forwarded-Encrypted: i=1; AFNElJ/bygTLzk6OxvDkpV8m0O0FpdEpi3JPQsgynUGaTS/0gqoANUxmt8fRTs8fx+2TcnyjtB6Fe1UThssQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxGn8oSD+QXceT97rjtDksZAa4vMiach6TtObE+QLOxYo+/qlGn
	6tq2vMVbSH5DkV5KmIcTfF7yosGGq4/qnVP8IjwFYWK49821kk7M2SMO0XDPN23mFIA=
X-Gm-Gg: AeBDiev+TISC9xjfhdCCHlTjEjo+KO7ojvEK+1xiNLyoWQ0I2d4AG43l9uhAsh9NFmf
	WjlWKSndFgUgDDI016W754+rCXXmcOkOp8smUqkH15tZr2G2+YVK03SIUJQq1//nDfGmJJOodmK
	ZeWdMXljnSM2vZ6iyCkUBfNZ6kBPPJBqbQQ0qrX9U5CzopClXFgOjhtTN6NknrQ0s1+LktHz4ux
	4DyThhe92ml775ljyvTxkuQ3aGLsDLvF9wyTMI9z3haBEzSUZ1ZDiRwksGQg6flXSSeXs2aiuPV
	711JLK6gU4d3+MZrONY+EJIGKd+iv3hAtPCYgryJN5KRz4iewjH5dWAh6TYK+k3tAu0ucZfmIIQ
	6UEnqUbKU42CdfgLzLWqXR30ILQeE3dVDSvIMoXtr1WTCvbbKqbVi7u7WcOgxHyYbrZe35I6ITA
	uX6tZLeRl/0OlkKuH2gAmv9HuBCsuj26Tc4hN1vQzjc6H8Ig==
X-Received: by 2002:a05:600c:c058:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48a98874de2mr121990565e9.8.1777897598760;
        Mon, 04 May 2026 05:26:38 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f7csm334623445e9.12.2026.05.04.05.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:26:38 -0700 (PDT)
Date: Mon, 4 May 2026 14:26:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dpll: move
 fractional-frequency-offset-ppt under pin-parent-device
Message-ID: <afiQTPaMyAApbLRk@FV6GYCPJ69>
References: <20260430173611.3312596-1-ivecera@redhat.com>
 <20260430173611.3312596-2-ivecera@redhat.com>
 <afhdCnT0ns-PgZD8@FV6GYCPJ69>
 <290673a1-fb5b-4586-b44a-e109cc1a4629@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290673a1-fb5b-4586-b44a-e109cc1a4629@redhat.com>
X-Rspamd-Queue-Id: 997BD4BCDE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19910-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Mon, May 04, 2026 at 11:36:19AM +0200, ivecera@redhat.com wrote:
>Hi Jiri,
>
>On 5/4/26 10:48 AM, Jiri Pirko wrote:
>> Thu, Apr 30, 2026 at 07:36:10PM +0200, ivecera@redhat.com wrote:
>> > Move the fractional-frequency-offset-ppt attribute from the top-level
>> > pin attributes into the pin-parent-device nested attribute set. This
>> > makes it consistent with phase-offset which is already per-parent and
>> > clarifies that FFO PPT represents the frequency difference between
>> > a pin and its parent DPLL device.
>> > 
>> > The top-level fractional-frequency-offset attribute (in PPM) remains
>> > unchanged for backward compatibility.
>> 
>> That is odd. The ppt one was added just for higher precision but was
>> semantically the same. Now you change it. Could you still treat both the
>> same?
>> 
>WDYM?
>
>Keep fractional-frequency-offset-ppt at the top-level and add both
>fractional-frequency-offset and fractional-frequency-offset-ppt into
>pin-parent-device nested attribute set?

Since both are the same, only different unit, it would make sense to
treat them both the same. That prevents from user confusion, hopefully.

>
>Thanks,
>Ivan
>

