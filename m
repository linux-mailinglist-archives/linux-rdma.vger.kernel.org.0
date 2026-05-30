Return-Path: <linux-rdma+bounces-21539-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFamKWvnGmrm9ggAu9opvQ
	(envelope-from <linux-rdma+bounces-21539-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 15:34:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1245060CFB2
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 15:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B77913036E5E
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF963C345D;
	Sat, 30 May 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+rNOiji"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B573C345B
	for <linux-rdma@vger.kernel.org>; Sat, 30 May 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780148066; cv=pass; b=T3QrmNiglbhWkhmpmVpepVJ2L/oYFY0lQ2ga4FQNZmxxW6Kttf2jyQ4imG62/hFojRA67u3Lulw//M+84KVnQ67I4E/FBkOfeq+Y9YQQibtBtVQ16rFXpdwKiuCwRVtSAHjKhT5OKnQAmphwHDEktpzUQ3j7nu2ZwbKiUhJeEG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780148066; c=relaxed/simple;
	bh=4C48hJN/qXSe1G7BFBSSph/sYgM9Q42RRduhkVnKpn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaVBfwS0DLLxt7evjVvGj4ElGIGGxEPrZ4LhE4MckXefJTaLeDIfJGFuJcDOkicynWj/9W9EsMnxr+eAE074t0QCWLQ5IhHRTzoupD0t4allSFzQraStojjZnW0sWae0sGpXCdPxWWatgXEEWFy3vx/4s49cunqfxtSVxsS+/Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+rNOiji; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a8f9841616so11960985e87.0
        for <linux-rdma@vger.kernel.org>; Sat, 30 May 2026 06:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780148063; cv=none;
        d=google.com; s=arc-20240605;
        b=TLjlo3tmEGeDdXuwDzRS3qPsXlwxloI934BNudMfr5mwNhFBLNTue2Nl95nNV8Fm8H
         5lZzjWPYY++yaPTkoXl0G0K5qaHrcjdJoCvaVQggIJ1/MxGl4IcuqmVVLc/BcYkYgTqr
         tyr8KzdsxT11CARIeNZkH20iTeWX7iL8D8QqAsSFKmnOELF7Vth4yQnJ8lOhmTjUWCf8
         2KeIpVXaxqanAOJxd8126MXh4wPjo1LwmLzcTtEexyxHnEgsHDCQKBcXZF56u6xYKSz6
         zvf6pV3ivhNYfTHanRKs1VUsGzwIzOunRWCKShI5zhnQLOnb1Wb4O12dH9HqP0qk5eEj
         UCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4C48hJN/qXSe1G7BFBSSph/sYgM9Q42RRduhkVnKpn8=;
        fh=zT4SKus5OrTSF829g7ihk+7Rb571hUINNC8tO1Fmt6Q=;
        b=HdJL/kHqohI+UMxV0MqXrcD2OnAJGQowlOqsXNamsmz7J4i7me6ZzFWvH4Sur46KQ2
         kdLkhX7gOmDMHLfX9Nd0U+TJRR6TqLpvNNdZCDFb/3gAW9aIyqKSKBRxGjOI7KSDHpCl
         YQlXYM7ZQ0cBnfCPKzwiHpIZXAGigjp3ygKXnENgCrqyiHNrmPltsE44jPlWQgiiKtDs
         zBk+cBqC3be1eJrzYpWRsZwB9QbCWhjuduXVGJSOGTqWbQZwCxWbp8VywccfvsiSpD2z
         2isC1v8ZBr0dnhWL3/9lyWRXCNKPXZysPCtRhMrOt7HYNdzDY3siRYti7FZsoNTWY+UN
         jzLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780148063; x=1780752863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4C48hJN/qXSe1G7BFBSSph/sYgM9Q42RRduhkVnKpn8=;
        b=T+rNOijin48Hi5Eq5SKACIDwZ9vPh1Qq+La0DABcaQ9v9PWzaS62gL8sjX79vIwbSy
         hfaCQU/0LzocJ0vz8zfasWvP4epWKFv4O5l0PUNhsenVI7DPd0R++/Vkxg0sXRFHnw5Q
         b7VcjQ/oT78nN0Kmji1l2Ubq7NeKfJFwx8s1aoW1eRsuRTAc++pASjPWs5AlmlREM2Je
         bhvGaJ1Xq6GXjlXXF9RmtUx6RdLhWoGJnRSFbPhoC9O2d9bUTjrchCNmbFsQO//ksKRm
         Q1wug2bP2wpPAJeHGNrs02iwhJaOxpW9YspS/kbhn+6HiFvJIOvxiFEKtWwHyByL7ecl
         ry+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780148063; x=1780752863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4C48hJN/qXSe1G7BFBSSph/sYgM9Q42RRduhkVnKpn8=;
        b=sCqmaRz4RC5TsHtrYHvLdVTj5syws78zu7gr5hDoPqvVbEFIWwmOyKwphCMj8jE9M+
         64y52fnHmU2hykHu7TjoqYP0L2iVUoHtc7v1Wk5NIYDKV9iShhyt+G2pIgcou/f8fTJQ
         URGlVEGAW9viilhMzBZffUL9nHrDBeSZ6WpyKKE38E77H+HeGoTII5b+EzlZQCHjDpN/
         oxThFQFvTtvdAcjvU6MgwsG01syOWCw86MEDZ31Tg7dzNmM/foyi7VQZVQbpLuoDfBsD
         q+vTTdqRDiLgGtR7SvxxM1i/rKSmW+mQxvfy4TySQ8FpPWVnBn3Bi37Z+184YZMmk/JC
         ZIFA==
X-Gm-Message-State: AOJu0YwRit0S6/eRblDSoC6Z9fAApr9+kLXQqewk+GD08N2dSt58ICy/
	3PpPPdnNzmh72CeW8XdunV6E4/nW1qecX/nDFoPxqyZosRqr6DGT/t+bjTlcSiy5srvRnU83Ij5
	dFrwZTU9baj29HbBVFt0grsFGlqJj/Dw=
X-Gm-Gg: Acq92OHHwkTaotweLdIeNR0uwvrJm0yF2XA+WZQr85rfEp29InpRTXf2HtNdraj2VB3
	S0BzJchgySoDKID3HvMATnXzgU2eaa4q698l/mjLoPlEy/dQy9mh/uHkALtrhTapA+KDWf3zKMP
	UKO1dAIxEcRYGAqW3PAgGegarT2w/t3JsLzOV4FrHa7WqNZSRRB70x0cngUiUyDKAeQIIxjKjRm
	dJpUnxSJs82qhtHTkQ5yI7qdJu71Fok82LqtjzMLiWor5TCaBHgrhxo/4A3b27kaInKpqNL82tt
	ztCscREXw1OaxyI=
X-Received: by 2002:a05:6512:689:b0:5a8:99fe:59eb with SMTP id
 2adb3069b0e04-5aa609275fcmr1107706e87.41.1780148062771; Sat, 30 May 2026
 06:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahjB87k54bYdFbft@grain> <CAHYDg1T3m=mn17zLRZp3+zcJq+GeDGcOU_99ZZmWxYasEDKN=g@mail.gmail.com>
In-Reply-To: <CAHYDg1T3m=mn17zLRZp3+zcJq+GeDGcOU_99ZZmWxYasEDKN=g@mail.gmail.com>
From: Cyrill Gorcunov <gorcunov@gmail.com>
Date: Sat, 30 May 2026 16:34:10 +0300
X-Gm-Features: AVHnY4IE6soG_JvajGLUg_Vob1PixX4OMyygnzNjPQzMF354VXyVOHw-tfww_1Q
Message-ID: <CAM5jBj4LPZxejjq2VFJZiwPWkZf3_rNxBRcT-8yrnfDXFSot-A@mail.gmail.com>
Subject: Re: [PATCH] RDMA/irdma: Fix typo in SQ completions generation
To: Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21539-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1245060CFB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks a lot for the review, Jacob! I miss to add that the nit came in
with commit 81091d7696ae71627ff80bbf2c6b0986d2c1cce3,
which is 5.18 series, so I guess we might need to fetch it to stable tree later.

