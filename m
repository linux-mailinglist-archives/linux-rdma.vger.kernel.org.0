Return-Path: <linux-rdma+bounces-20909-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDrlNN4RC2pN/gQAu9opvQ
	(envelope-from <linux-rdma+bounces-20909-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:19:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FD456D807
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B42463001598
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DFA480353;
	Mon, 18 May 2026 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stQ8++1G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C80409E0A
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109460; cv=pass; b=a3HUCf63uBOpQ8qgG0E0cQPlrZFU1WJFEbuNyslkTB0AxjJHVdDYOAD73m/7nx8el764BLGw+us0RZ80M29XNUZJwLpu5ZPyyUNg4hGVxXcRuRarZYNycGiiRibVoQ23TTewl8G0ZUTInAkbJRqdxiSdQCgGoPpYVhQs7YgnurI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109460; c=relaxed/simple;
	bh=nFV04lWWOa5LUhpXiG8LJ3n3JBJVew5O5Xt54Ly5eRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abymzeYZ/YEzryV9F8MoMqtLY6VMtovqNFGxI2dp9g5gT8J5k7UsHCsK9pV26B1xe8mbY58vUlIS8TQZ7fgPa+aIxJ/q1ZA/vTSUg0pGUaBnMo2pXH9USAW71/Dn00Bsi8w9uIGMh3PxHgmIdLs9olhU5lwctkpXjPl1AzP+QRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stQ8++1G; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479dc6d26e3so1434588b6e.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 06:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779109458; cv=none;
        d=google.com; s=arc-20240605;
        b=OI7mWS1mRjxFgfKocxmS2WmPzwiMUQO+wPQERArLtw8B7mtIMFlz8a3uxW2yHkUxG+
         U5WGHYUiq6sokVs+DNA6NM9wAHyDJZztoHdI00bknmBbYaqSKp5o9uuExwagMNlj2VrR
         qIoNTANF27eswLY+92Qh6zbIUIi4OU/1yaHI5EaqRO/w+Fro2yBN3qs2zFJoY1znYjLu
         18j1Vj254nmKPqZhaHjoGbzD1+dxRKQ6zrm5Eoejdg9GcnBmL18Z5mNeZbgPwTeldXf+
         fzT5vRII/FhyHn3zT7ANp4n3JQ51vjRKHgUQOS2fAI/Y2pXj1F6S7vSnfApXslOx63jh
         k3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FHcuYJ2jfU0I4UrGtS0aRbUlDq2T8NiEaX2Txw8z+ys=;
        fh=7GyPgsrkr4pnT3tXdIhDhhFVTVcF1boRaT+54nye0o0=;
        b=EP0kiyQfD9u7AXWIfE1SmeEcTJYLQX1fosswbpop+sgUTM2xpctlc2hHRkeNQ1Ytuo
         LmhAwIhbrFuN45j1B6kaIP7WoVnmjmkO909hm/e8i3q0iQ6WQA8jlVIbnu/9XJiZhVMv
         UHXQr12jtaLS704pczi6fqX+Ymuu17fas8XIqEPw6VIQOd8ebq6MqJ1ucvxYYzDmrHf+
         wozn3twxK6ej35/7UsgHKiUYDB95wBWBnj3NrcLAKBJ4K2bIv9GV4zmm2kULGm6lRJ0l
         KFARTdugFkAZiL0fDgUz+hF/aDJc8HGYYTIYRr7gzRjujyh6uwIn1Y8RgA3WRQWUFlE7
         KWGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779109458; x=1779714258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FHcuYJ2jfU0I4UrGtS0aRbUlDq2T8NiEaX2Txw8z+ys=;
        b=stQ8++1GQu/R2nIcWxy5sLTFjgh0HyQNx4As/fAVsqZiLsZ71HlZhTyZMl89Y54u0i
         isuz/yDPCtHyDibolTWBzChPXKtDSulh8DHcGty306hzz1AFmo9US/zLzsWdhabRBwRc
         CC1PS9SYw7IUaoChViXCG4EL+v4SeK5rhqO4wVrYclIzKN+V87TupCP6qOtWYRXk+U6j
         xuZetoywEl6ZvsJehTwnEAfwggnIiAAHe9lJgMQ+ySKq7uNNXCg6bWTpYOb67An6mmCx
         jHbRKQ2xr0Fc2N5AuHB1O1RrZ8y33cJv3x+ljPajXGtFbPTbj/raJpUTH/buF58VR3sj
         ZxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109458; x=1779714258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHcuYJ2jfU0I4UrGtS0aRbUlDq2T8NiEaX2Txw8z+ys=;
        b=Z/3P2/zBG6CMd54Ppei1gOHG/PyshFqCK33f06bptFKvZNT8yKrURc5xlms2SZcZED
         CTS1sJ4LMCTSwzneyKjXpYzvQEu2e1Jd9l92kn40qPSyz3011pgHJCcl87qNfX6U4rGN
         foGO9ySke/uBb8TId8CaZZeH0HHT1yu9X3/VRai9GauAiFpX/Dli/b+78j7//cy/m5cW
         xrJAUyeapRgLO9y7KfeWRrRdY2Guqwt0QLsJga+INKA6lkdrjGWic3dE+m3jkkEtwisQ
         FpK7ICMzPRsI3WJhoGtpHboMNkUs3z7+eY+jWZZj6qSXUSGxGhEPy70sdNfqooyKBsBF
         +QDg==
X-Gm-Message-State: AOJu0Yz1O52SjPNEz0MLRN2UgtogHSB9KNoA2fmx7kFMORl0i/zmApSf
	BSabEiPU6tCK7e3j4txUFMu5hKkL9LM52Rst9n4wmlbLGMg9mJCChazIA+r3hqPmhfDesgUv4XR
	WhbGdsrNXOhjAMwjqtLbFSZahGKgVUkYXLjX0chUW
X-Gm-Gg: Acq92OHmcC7uIuv/dQR+o9Lunyy/Z8WKYl/OMDqSvx09FhzQmSvz9Bf8Sj/CPYN5IHt
	VvNiVQIa6t1+IxWCOF+VlMlCFYzLpZ7PwWq8D9dbRJmeplvV8md+Dak4zLsYFE2XRt03hAR1UTJ
	C0apT97NWoIndSZdAAWdWTLTfR8xajV5jiY0D1CDUqat3OAgh+utRyNce2cDa6R5okbqsW0nkNk
	Bb97jO1IZH2QFIWB9PDAj/d7hEDVEp4ZZFpCZjkgJ00NzzcFxtOMStgh8Uh9lYxrYPrvF9DItwj
	xMXeupHeKsSmAeCrcahxU/TkQwtEFNmWz38urcek3TgIM3Y4
X-Received: by 2002:a05:6808:124e:b0:479:de32:b310 with SMTP id
 5614622812f47-482e539709bmr9001354b6e.0.1779109457501; Mon, 18 May 2026
 06:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517063006.2200680-1-jiri@resnulli.us> <20260517063006.2200680-4-jiri@resnulli.us>
In-Reply-To: <20260517063006.2200680-4-jiri@resnulli.us>
From: Jacob Moroni <jmoroni@google.com>
Date: Mon, 18 May 2026 09:04:06 -0400
X-Gm-Features: AVHnY4IWRe5p9fjIHGv8FtTLyLetLPLYjneXv1Ht_fJ5K645T0pMYsP6ly-X7gQ
Message-ID: <CAHYDg1RXDuB91xDUW9cURq3hWfYeWabrBNKfXEZm6aHVbQi+9g@mail.gmail.com>
Subject: Re: [PATCH rdma-next v5 03/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, 
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev, 
	marco.crivellari@suse.com, roman.gushchin@linux.dev, phaddad@nvidia.com, 
	lirongqing@baidu.com, ynachum@amazon.com, huangjunxian6@hisilicon.com, 
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 23FD456D807
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20909-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

> +struct ib_umem *ib_umem_get_desc(struct ib_device *device,
> +                                const struct ib_uverbs_buffer_desc *desc,
> +                                int access)
> +{
> +       struct ib_umem_dmabuf *umem_dmabuf;
> +
> +       if (desc->reserved[0] || desc->reserved[1])
> +               return ERR_PTR(-EINVAL);
> +
> +       switch (desc->type) {
> +       case IB_UVERBS_BUFFER_TYPE_DMABUF:
> +               umem_dmabuf = ib_umem_dmabuf_get_pinned(device, desc->addr,
> +                                                       desc->length, desc->fd,
> +                                                       access);

This all looks good to me. Just thinking out loud...

Is there a longer term plan to handle revocable dmabufs on this path and
get rid of the separate ib_umem_dmabuf_get methods?

- Jake

