Return-Path: <linux-rdma+bounces-19906-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBmII/Bd+GnatQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19906-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 10:50:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4EB4BA8BF
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B89AD3048611
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80903451A9;
	Mon,  4 May 2026 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="gktmWMMm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9D3491E1
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884500; cv=none; b=BJh6kdhxW1+7wBdain3l2zUDZyahzBolLx7S73UBqpBI1Sl5+Zrcl4/LXgYTAYYh52wL1aFImhXnnb5U6iUxqBIV+jihgtf827Ey4UhLccmP7sC56M4/p6LRRP1UFYRAMYlrrR0WmPjpxfeB3tFDCiQZzZacLxgujhSXxGi3bFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884500; c=relaxed/simple;
	bh=bLUccklgBubfjMF9F927WmSX/x9egmRdCcgt3JBFY80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV5mMQmgXR6P1nTCUSuuDgZeR4aKLvC8hBIPs01Duso9KMwzkwFcNkhcII4uuMOSIj/Trz5i57drXO3QodjbJheDmbYCU8BjpCIeut0HYtEZMXHHolNM79VU2f43DQtnDRrRg/R2sZJB2jxwQ3SlFoRjjWgYRzVm2r9R5LaM/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=gktmWMMm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so24526925e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 01:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777884495; x=1778489295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLUccklgBubfjMF9F927WmSX/x9egmRdCcgt3JBFY80=;
        b=gktmWMMmQ6ZMu18AJzugEYu3wh2PAKxmnNIQknr4FN9cJ8Q1Cj+Z7P1A7sJL4jDw3v
         ngsPhUFTOM4LdVZHxtePRtxqJBzAwOVtBLDz/ZkVFblYcaWqFXSo/sF8pBR/pY8SI4wl
         qmH83NPMfxtSR3ZIoE6z1IBUt1RbAnuFLvzHxBqzv1QxvbrEaLR+1gXUKuhPPU10AoXR
         QP3KqBC3oz58i31k9f3s6qwKdPqTLDHBWzxlTeyMwb0i7N90hnyGR4nsCT927hITPe6t
         /yLnXWlnVK2+/XiSZQ0jjB3l/I1yviapkncr37GOjF2IRiI6bMK8risVHZ11QyI+eEb2
         Cf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777884495; x=1778489295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLUccklgBubfjMF9F927WmSX/x9egmRdCcgt3JBFY80=;
        b=GyNe/O992UrE3ndteZTfOYheBASCS1iIqY1bXq90xpBAc4NUoGDeTNInYy/jMZ0jeV
         1F/6KbgWsd1ibakOykUrmYDt2bDlAdrQTICOg+uK895Z+iQHPwOU8gruyHy20XygzFne
         bYpRF8QC22Uh4OExkHFOIPVuFXY4C5wU10CbpwKWVBUYm+5SuFgoLJV/aKvJbKJwa7x4
         Bp+m43YyoAExLKQcHR7UDSqVpoOEW/a3VLKcLtfkTYMXAXnmI7YkfKMzyBk0pgvdTkPu
         KNnQ84VxfthtNAoSyfMBzgdCB+jCIBvCYSCwkQnE8bigqjHR300F+dUzf4O/G0kXdpug
         011Q==
X-Forwarded-Encrypted: i=1; AFNElJ9J8g7BD+nqYKXSwX0yFw7bhpOB/V/vqq2O7nq2toYoIBm6x7bAIiUyrR2hI2m8Xy+S8rxHd1VUwFZx@vger.kernel.org
X-Gm-Message-State: AOJu0YySXj4GPPddFOOianJSzPpETbQjXXK0WZ4xslRdFyXXmKBB5uw3
	NcuHj+ioMXAhXHzJrTlCwSTBfHGwAJ+AaRArGnIxHAwkzxEYKNLlKKHQFlkshFAZpJg=
X-Gm-Gg: AeBDiesoxcdSxbGbZNcb7MA7F6SNBw13Rydbisy4EupD1WXM5WF1rjXSfPrFlFrsUpl
	ZSooNMUg8/oJy85QjaGcoNHb2ZHcTHfLHLTisMGLvsQRQKYp33mrPIzLKszN7CPg9MothJlJJHP
	K/CsPhBtkyaQVLy9eqxkRyI3v31vHLktDP1BGxA6raJwO4CnjpESysYeO3nKAPZUBMurez1csvT
	y0yLdB3Y1HcGWIat2Pk+GmAQGwv9dQtIHJnTbUbJfXCsM4uZFjhQbCSFMeA851dUxXXCXGhnPxM
	lH7Aj9+HC+dFay43bMqMHkkRfZTqL3ASZApK0HK+MeBb7fpsmYvlu8L8GAzOBVyI7UT+uNXWmZX
	exJsRfNF1xtiTm+In6p0okiTmvzg0/fJnogOqhXwnU8jGYbmR3vFqBWQVR/s5Ie0jU3GRpoC7MP
	JbYWpekIEcQ3xiToGURr8+XH/RuT7Vcy6VyD/Dxi0XFnE=
X-Received: by 2002:a05:600c:26d2:b0:48a:5236:7f38 with SMTP id 5b1f17b1804b1-48a8607970fmr159836115e9.14.1777884495283;
        Mon, 04 May 2026 01:48:15 -0700 (PDT)
Received: from FV6GYCPJ69 ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44b63d78692sm20604340f8f.27.2026.05.04.01.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:48:14 -0700 (PDT)
Date: Mon, 4 May 2026 10:48:09 +0200
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
Message-ID: <afhdCnT0ns-PgZD8@FV6GYCPJ69>
References: <20260430173611.3312596-1-ivecera@redhat.com>
 <20260430173611.3312596-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430173611.3312596-2-ivecera@redhat.com>
X-Rspamd-Queue-Id: 4F4EB4BA8BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19906-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Thu, Apr 30, 2026 at 07:36:10PM +0200, ivecera@redhat.com wrote:
>Move the fractional-frequency-offset-ppt attribute from the top-level
>pin attributes into the pin-parent-device nested attribute set. This
>makes it consistent with phase-offset which is already per-parent and
>clarifies that FFO PPT represents the frequency difference between
>a pin and its parent DPLL device.
>
>The top-level fractional-frequency-offset attribute (in PPM) remains
>unchanged for backward compatibility.

That is odd. The ppt one was added just for higher precision but was
semantically the same. Now you change it. Could you still treat both the
same?

>
>Distinguish the two contexts in the ffo_get callback by passing
>dpll=NULL for the top-level (rx vs tx symbol rate) call and a valid
>dpll pointer for the nested (pin vs parent DPLL) call. Update mlx5
>and zl3073x drivers to return -ENODATA for the nested context they
>do not yet support.
>
>Add documentation for both FFO attributes to dpll.rst.
>

[..]

