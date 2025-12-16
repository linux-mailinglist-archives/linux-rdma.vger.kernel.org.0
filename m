Return-Path: <linux-rdma+bounces-15031-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FE5CC3848
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 15:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7287B3070176
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE865296BBF;
	Tue, 16 Dec 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpgSUrNY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9DF27815E
	for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894677; cv=none; b=Wp0tAXq6f3TL8AvcIWtgoIdiKKExJ/nKEZgtE+tpudAD/6RayTnzQphkEJLbQZk7buCOZPJLqeArFPNaK3/Nj5DjFf/Wo6d1ds3+QBZmPWFRAQ//WBmf4mx19RIeJweCToUsFyDUPeEijP0NA8qN4VstpEgI2wmyBp44lJHwSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894677; c=relaxed/simple;
	bh=6ZOMSVoP5j5/oJeczvH0K8VYsiw/TB8ZX1wq8YopK4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tvw3+rtiGfyKnwgcVp2E7QEnBOrNk4Q4odUHmJDwrN+F8uk+jZ4PddVyK2131rx/B4tZnt4uDqVlAD5ySNKIJF2zxlmHH8Ppvic3yxuZ6frLGKrdOxOvAFKPehcFzBTHswpWEEzT+/7PNvEWvHoDzImMx58VT4y7iHgaD5/2710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpgSUrNY; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3e83c40e9dfso1859180fac.1
        for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765894675; x=1766499475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaJHY74T15CgE9XMXiSj1vrnnlykzi3ZNr7V3QhwxSw=;
        b=wpgSUrNYe7b3YB2TCnHfX5hNu+QpxE3gGEOtxOjlaqDiHtzZj4+4bPWLiBxslNAIx7
         JYYznmSdXZKyTy/vWGcJpcQPACoAqevjnzS2AqKcHg2jXA5a/YN5VYDt/KGKZ7oQfn9Y
         0pWg+q0bW78E3v1B+zM5RlUQtFMq6UReHmHi36llgBVd3t6jM68yUeDaGXH3xFBEkjgz
         67HP4WkRo1AClYYmwPTJXT5NNU+FC8681gNLquCvJVI1nZuSt5IuCWJptVrn/gs7VkME
         1pWP0FbWb3PX+KBhdfoVrg+Ed+HUjZsidvLDHdJuS5EsB+V5Jbq80pJ478SwnmQEsLS3
         PoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894675; x=1766499475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QaJHY74T15CgE9XMXiSj1vrnnlykzi3ZNr7V3QhwxSw=;
        b=B3q6GNf/TqlnIi1SNi2mXdK3can7H+en7MIjxZ3KCSpr6PWz2rCvb77KLzqgOTlQ1G
         z5sMmL/me3rUX2PSNGo57wH+GMaQ3f0FuqNx8Y7U9XXiRBvIvzO7Rz9NgahYMyk+dSOt
         tB5EeVbT+pgNJmE2qcHmek11wLSVQuiElSz1Mk2zDXwt/6vzcUrIf0u3BR/LFKix1imT
         lKwT/T3Quj4LR0XSnivWC4t6/97rTj3PYn5KkaL5HbzgmV1wdeidQkmJ1tjS9zM9nCFm
         eXP5FWSbqaQxUhe06rEZrn8B40BgRODMQJCPZjGAaftJM9pta15hWdlI568TytzlYTgf
         SegQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4bzbshlqQRVknaNQUbDWYIcqENSvkAor/q9CdY/VNDiR7yAJxaLebEbiGRKROHn49A9HHmkhMSQ9q@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgssm+hVR0MoWwnhAFaY+YID6kS0NuRckqcDIBZGy9b4HdmQb
	ccn2ciCXzupUp61RvdKSgnlnYCrf24sPsrxdyMUC2IRwWC4fc8wKj326JFFOtneOTlx0bWtnrT/
	2HMQQtx7m9PfKbqKd163774Ki3uYLuaDGaZcCRVM5
X-Gm-Gg: AY/fxX72ZkSla+M6EYhEKwm4pKN5Egc8RjjtEnWiKepvTuzUm+BCUF1GtZ72Iz+F+8Z
	s6bl2wBdhkEN9M2IOCnso/uU4amRZPFpg/EHmWC/a5YrYZzttuFsCOakQUjmxgPdO65PsUMaMjy
	MIEHHHFxNvtiEnQz0EZXs6RSr3BtBa+Zpt9em0qWrkdnOrKDoK0dJ54mWi7Hd1c2zO/Glwrtp4Y
	YSfYyheSXAJIpSnE35vbvg7ESygh22FsI5x5jLUSQmaM01XZL4X8oZ1Oxw+Me32nD/JvNLzRSfI
	rlPI6wMGMn3J1oQUtm7IUqaVsL4nqA==
X-Google-Smtp-Source: AGHT+IFTijlZLNDvpKQ60+ReSQPxDZlsKGWiOPbQbAHGFxbKfZAkwGtIP7BpsqaJtl2bCaCSzbyAuU8/0a3eEvzexWg=
X-Received: by 2002:a05:6871:33a7:b0:3f5:5af:c9de with SMTP id
 586e51a60fabf-3f5fc62f334mr6165691fac.51.1765894674446; Tue, 16 Dec 2025
 06:17:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208133849.315451-1-arnd@kernel.org> <CAMuHMdXvNzE++8w1nmD3QXBGb1BzstZwJTSb5=tFfHZDfdqEww@mail.gmail.com>
In-Reply-To: <CAMuHMdXvNzE++8w1nmD3QXBGb1BzstZwJTSb5=tFfHZDfdqEww@mail.gmail.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 16 Dec 2025 09:17:41 -0500
X-Gm-Features: AQt7F2qBqwiU7EaypioY8zx4HxoXUfIseVgU2PzgHa1NeHtumDhjUbUP6Sn8zM0
Message-ID: <CAHYDg1QbNWW=wm4fH71yLVX_gKsPij5jed5R64JbN0mv6Lyx4g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/irdma: fix irdma_alloc_ucontext_resp padding
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Faisal Latif <faisal.latif@intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mustafa Ismail <mustafa.ismail@intel.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This doesn't change the offset of max_hw_srq_quanta on my system, but I tes=
ted
with a verbs provider built with the previous and new proposed change
just in case,
and both worked.

Out of curiosity, what is the policy for increasing the size of these
uverbs driver
response structures? I think the response gets silently truncated if the us=
er
provides a smaller buffer, so this shouldn't have broken any user applicati=
ons
using the old ABI IIUC.

Thanks!

Tested-by: Jacob Moroni <jmoroni@google.com>

On Mon, Dec 15, 2025 at 1:43=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Arnd,
>
> On Mon, 8 Dec 2025 at 14:39, Arnd Bergmann <arnd@kernel.org> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > A recent modified struct irdma_alloc_ucontext_resp by adding a member
> > with implicit padding in front of it, changing the ABI in an
> > incompatibible way on all architectures other than m68k, as
> > reported by scripts/check-uapi.sh:
> >
> > =3D=3D=3D=3D ABI differences detected in include/rdma/irdma-abi.h from =
1dd7bde2e91c -> HEAD =3D=3D=3D=3D
> >     [C] 'struct irdma_alloc_ucontext_resp' changed:
> >       type size changed from 704 to 640 (in bits)
> >       1 data member deletion:
> >         '__u8 rsvd3[2]', at offset 640 (in bits) at irdma-abi.h:61:1
> >       1 data member insertion:
> >         '__u8 revd3[2]', at offset 592 (in bits) at irdma-abi.h:60:1
> >
> > Change the ABI back to the previous version, by moving the new
> > max_hw_srq_quanta member into a naturally aligned location.
> >
> > Fixes: 563e1feb5f6e ("RDMA/irdma: Add SRQ support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for the discussion in Tokyo!
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>

