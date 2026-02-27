Return-Path: <linux-rdma+bounces-17293-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AfvN2KuoWk3vgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17293-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 15:46:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDEC1B92FA
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 15:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4197E300BC8F
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C8B41C30A;
	Fri, 27 Feb 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGDkAMmm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4D41C2EA
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203459; cv=pass; b=BIlCCqsB8ZFEgBKlqR/4GbMwGR752QvX3XT1pxmgq7XnendktMPigCwpyLbbN0ors2bWTjmUvHGfsNGmvC5wwCk3yhPWfv7Cu0zS5YGx+fPu5qnCZhQf9Z+UE0oszPN51FenFQJL1klNPBN3wy+9qpHPqeXR1JowrQPOt/meIzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203459; c=relaxed/simple;
	bh=n5a/R+EizTTFwaW1MXf9F+O9dzE48hZCSYZ7lwhnBVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgy5DyZJdqaJejnWDeWh/aY6TPAbyn09UkRNhkFTc7V2SDaIOyTsnsERr5X7FTMl3+79bHLHeM+GPlBnHQeh+8zqHsJF1PgRW/uORS3BsRAQ0aWI09yiFaCf81z+3+J4bEuQhBiN4Tu22tS0HKaJdfcjrFsURz7WMsX/fflqNdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGDkAMmm; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso945246a91.0
        for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 06:44:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772203457; cv=none;
        d=google.com; s=arc-20240605;
        b=H+vchGHw8zSorD6xyd33lde9U1mO0NA/NndLpMadgTTW7YpdehO9Qd2pOy7BW+oIn/
         J/RtviAx/HPHc+f4GiSVp+YjgNTFNpn5Y7tf+7gcswKHOiPEU/OddO5VCLaNjlLMZbuR
         hBIZvPkHWrTtVeToYOzRXQgZhaCVCmED6J2byThqFWHfnrLR/dIpH+Ru0spTNR/GTKTq
         +3t2pzjZLuNVDAq3uGqHhX2vPDMTH/6KDEyIxLF5Cwp1kwYOIy7T4ytrdaiXzt953zIl
         /OoFUU/A4DEHzh+3rNpQyTF3A2USvMu1uzwevBGJsg+KH1VyV2tVL8ee8kJ2lkpZqV/n
         8Irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5a/R+EizTTFwaW1MXf9F+O9dzE48hZCSYZ7lwhnBVE=;
        fh=WuXCgucey5RxaIW6ML56gMYV1j1sdGvWzQNSTQfjDpQ=;
        b=f4gQInNFxfG/CC9M7CPdDntueOAHO1R8duDCw7E4H/eQHRm1ULsemowSeBCrqHDxq0
         Vg3EThL2EIz+yurJHPlzBq9KByLmvouD8Jsecc0qHUu0R1JQJiv1fjWV1Wzc/i4LHi5v
         0EnzeygA7EjTsP1jYlLYSGUjQ/+QY5cLEV6rJKUyM6jcM7uHo4hkKQc+agzbcFt34F+U
         of71p2FVDyZoMf8pf7ntI61dsMsIekVXf0BstCS1VRz96Ndzhd2GbQgAGHIHYS9fkV5k
         3I7Rj7OtnReCofwdZVc6oHdIP3Duq9nxThA3yS0853fBss4HegWLSFTr5kAf4QdLb2eO
         BaWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772203457; x=1772808257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5a/R+EizTTFwaW1MXf9F+O9dzE48hZCSYZ7lwhnBVE=;
        b=HGDkAMmmYi2RiPZ1/IVLzy4FmjwxLzkv1QVfX0Ja/h440Pfny1nMwnrVFo70NGLm0o
         SUQyuXKV6zvy0EtxcC25cngWsd0821bRDCVrusYSPJ7pNaI2m0xfT5mEPrN6d7a1vjRQ
         aL3snrPoJelFThTUiSAo7IfmFmmAbHD39yEug07OQSMSE/zsgAtYx9kKMZZX5W9YXovp
         XOE0wqPZm1mPHUnysopAEb9w1Fs2q/anMvwZJUJnFAWyTUFXvGk33cRdc37VzOouP7dA
         HE6DbgYFQXrz1IIC8m37S418CtF7UnoBGb1ZCEec+h9dshX3wvlBJL4aKWTlpKZVHZB9
         Ld4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772203457; x=1772808257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5a/R+EizTTFwaW1MXf9F+O9dzE48hZCSYZ7lwhnBVE=;
        b=qdb8wOzjdETnEfH2iYJcIO7JYowhqOPZ+x6abXfpk7rpf5r8K5R1cV3IvaFdUw9kmt
         Co/EAeHzz5bNNbu7+VGCZ+O72i9vonzxzrg2Bd3Rop+iZoWbS6mWTuPa/5xzC2rR20FP
         6lM6rQJLY7BQfpOQ1Ef4fmxAmjk0gXMrWuk5ZgoQA1lnEu7xhdYNLKop06mw1YDBZJOf
         6wuRabAfgb82jRQ9YWSv5C9OH5CF4h/te5QHfP9HjstRj1sSNc9iNulhiEBLb9F9dXtD
         TFh1werbY3AE9oXa+4XL/o4g/o/bvBQkLV4TqcEs2n4BmMy47fQb1/Ejhv4lIL7EMFEg
         JGDw==
X-Forwarded-Encrypted: i=1; AJvYcCXWgQqlKDHiT8z04s4rDkRtRBytcX0GxDGcgkxUvRhf1jDfXLRQWdI7oCjT6HGhDFFv49T+g/eNPF34@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjeJiuZguy2JglXBuoxdeCGe3k/fK1yvIHp7WaDXfKt7kDimf
	koCDhDnYLWfoiw4LzGinRtRAgDGo2sjX0dRmqc+lTJB0a3aplGf5J3PoyXIp9ewWIrZqour6TOz
	M7Zbz3nvCDfBXjdH6FIJn3ZeGtbbS0k9qQI9QKvQx
X-Gm-Gg: ATEYQzzdAjJYHoC0RQ1okjuJ8g4UYwAViHJKyjRZVsolUYnmqxaf9UvJUp7ziEEB+BU
	obK4A9uDiTR0dgpoP+HgnZ/IZPhGXH7Gj49+FrqpF2pDWJPdCfY4sWFGfc37JodCfXypqy2TjJC
	52+/w1vTLLTaATWsXA6q8F/VfA6uITSLeSmhpWwcTXDSb0uzXMz+8BLigeZEUH2kwyCaYkeGrFl
	V3Gr2fshJHg70HdX8tetuja7v1kXbMNvF51bopvu+gJGLCxibpX5nvTQitZi1y/Tuhyw8Sw4He0
	2DF8Mul95vkJT1oEEkoAcWV+ZR4fYwBi+BP0
X-Received: by 2002:a17:90b:5843:b0:354:a57c:65dd with SMTP id
 98e67ed59e1d1-35965cd0e68mr3088198a91.24.1772203456589; Fri, 27 Feb 2026
 06:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225210705.373126-1-jmoroni@google.com> <20260225210705.373126-5-jmoroni@google.com>
 <20260226085517.GG12611@unreal> <CAHYDg1QLzeQTXpCTeP5ZYcYyYLHG3yhUQtrGec+-5MzaGL-jKA@mail.gmail.com>
 <20260226194149.GM12611@unreal> <CAHYDg1QB9sPWLx34heDnnV-K=pMXniqT7qxL_CY95fi7esPTBA@mail.gmail.com>
In-Reply-To: <CAHYDg1QB9sPWLx34heDnnV-K=pMXniqT7qxL_CY95fi7esPTBA@mail.gmail.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Fri, 27 Feb 2026 09:44:02 -0500
X-Gm-Features: AaiRm52uFoVnRFuPeXLSaCzmRs8ITiuuxTgaXVtSvnqghTgnUTSYe0gKAUqoWJY
Message-ID: <CAHYDg1Snxj5sfFr2ebkacZjbpttgjFyPHGedHXG155MXx0NMEw@mail.gmail.com>
Subject: Re: [PATCH rdma-next 4/4] RDMA/irdma: Add support for revocable
 pinned dmabuf import
To: Leon Romanovsky <leon@kernel.org>
Cc: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17293-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BDEC1B92FA
X-Rspamd-Action: no action

Hi,

I will have to send a v2 anyway to address the rereg_mr path. This does rai=
se a
question though: What is the expected behavior for rereg_mr on a dmabuf mr?

There is no rereg_dmabuf_mr, so my read of the irdma driver is that rereg_m=
r
will work as expected as long as you don't specify IB_MR_REREG_TRANS.

If IB_MR_REREG_TRANS is specified, then it will drop the umem_dmabuf and
get a new normal umem based on whatever arguments are provided, which I
guess makes sense, and I assume I will need to preserve this behavior since
it's user facing.

In the case where it is only a PD or access change, I will need to also den=
y
the rereg if the umem has been revoked. The buffer has been invalidated,
unpinned, and unmapped at that point and the rereg would have the side
effect of re-validating it in HW which I don't think can be allowed.

- Jake


On Thu, Feb 26, 2026 at 4:38=E2=80=AFPM Jacob Moroni <jmoroni@google.com> w=
rote:
>
> I see. Thanks for the context.
>
> It may be hard to totally hide the fact that the umem is now revocable fr=
om the
> drivers, but we may still be able to still mostly hide the umem type if w=
e make
> "revocable" a property of the general umem. Then, there can something lik=
e a
> "ib_umem_revoke_lock/unlock" helper which would be a no-op for most umems=
, but
> would allow drivers to have the same dereg path at least?
>
> Thanks,
> Jake

