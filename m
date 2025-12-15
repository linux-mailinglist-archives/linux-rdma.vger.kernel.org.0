Return-Path: <linux-rdma+bounces-14990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78565CBCAAF
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 07:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC01B300549E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 06:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016330BF4E;
	Mon, 15 Dec 2025 06:42:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A0306B25
	for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765780958; cv=none; b=Gp9XsJ2PEHgIOdH2nLx5C+HICFUCTlafs1TrgurgjmQC+nSb1sLMuqAcO6z2TPAwWDbOKXiuaNtmgO4WvUBqO3knW27zbjvBAx8nXRkwlXxEmGfBam4JQredL29NwhlPuXhZZK+pRaBErvbqfTz+kOxFReChVIJo/QSSkJR6EnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765780958; c=relaxed/simple;
	bh=3iPp2d5onCiyZPfoBFhHJpAArm28lwn829Q9It9B8as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFXhMOlOQWi2y+kzphBXiVs6r6oacMVwBFGVMkkyy7D77i8z4Q/SHwxUQ8FzvWZr6nwpDVmFa1PUPZ2250EKWupOnsfQHG3yrdrI83E0QjVKy0mGgFVLq7mU2GFYlNt/0KFgcnwhEjTS/aNC3SDhyr45P41w1upuZKmnH8L2Zyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-55e8c539b11so2225966e0c.2
        for <linux-rdma@vger.kernel.org>; Sun, 14 Dec 2025 22:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765780955; x=1766385755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJ5FSztgxTiZe6NeETAhXYf5RfaijCvaWmTWrc6L7m4=;
        b=lSd7CRKj8QBM/9DHVeD2X9cIQ0Txb8xXhS2/q7g7wMaIH1rfQVQmJKVHWuFl/pjZwq
         2JrnWFN7wULFhOe4z5sYEKiJlYCufOOlz6IWoW+6vAKDoWzYCvJZHAE60GGOsWGuL5ra
         hWkJI8wPdZH86312AOJ8LYuQziofgl0LMceIt5r64SddYwvOcibSkGgZmJG7CrWId7me
         D6/jWqEJpUa7pJjhnceXw83fF7qIAtN/V6HsSu9enbzT/ZkrzyhpKkKIpvVppvjY5LIm
         Wmo4BqxmgqkRtzoztXrLgK3b2/C4oIFt+SpId19FUiTwp49iShc4/mhN4lefQj0odcSm
         VSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcmlUwIPocxHHtERfdvgnV+dEBMvE3RE8yDgMhbIXomoQ8FGsSvyt0rm1OgMv9O7Oy4yJUlNzm+5pr@vger.kernel.org
X-Gm-Message-State: AOJu0YzMM2srUaPhrmnZ9iYvIc7O2X5hf2UzRLGjQeAAKdxLMsiAyME6
	ZVe3ehJBv9yp04qI/Cu3qjUBrM+C/5oopDoZzAJlWnv5/AiN2vEq2N9aMEsL3Co7eF0=
X-Gm-Gg: AY/fxX422qXWOp0UMY2VRHjx6h0uBgVELCp+ZVmWs5y6RidRWXfLfarnxSc+ZMXfYpk
	+IddgKXhSUW6xbb6sGODQcJ0wANRDCnV+31JxBgoXa6orZM/a6JwjkoLnvRg9AsttkDYJmvAAzn
	f2BcFZAes0AfxW6dadibWFhE2ymP8fmx4gOVv1HGpWIjWHVebyFRVyIIb2AzBY2sbqyUbnLA26L
	wJLeJc/OEU9db6+c+6tWb5uOJwcNWAw6XWk0ofQaHU7pZhVaDOS1R3YJr/k5sCBXaw4Gc/PnjRT
	eH9gSR8jwNzfL2TuEZyfPXsz55y8nxYrokM7/LKi5hYOE/nh8q+SCBnQIng2wOKZWY50qqsEdTn
	8gvvyI+0nPNsSo1H7PC836ybFnrlHZ6HkwkDxjZRsWUCVKKjkVnqQjsWAO/2B+nWg6X8Wjzrn6x
	jm5JUcuOpvih+OwbDR/bDWNBw5liL+o3yVZqbpWaJDDMgEdsQK
X-Google-Smtp-Source: AGHT+IErDPFTEjmLOWOJh+Dqdo+Q2b7QqaVfGuOJ7B3V2h/rS7zXlrhaqbl0cS7a/wd8kSqhKXJzww==
X-Received: by 2002:a05:6122:2495:b0:554:b32c:6f76 with SMTP id 71dfb90a1353d-55fed65975amr2551791e0c.15.1765780954718;
        Sun, 14 Dec 2025 22:42:34 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55fdc5efc86sm5902993e0c.2.2025.12.14.22.42.34
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 22:42:34 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5dbd1421182so2875240137.1
        for <linux-rdma@vger.kernel.org>; Sun, 14 Dec 2025 22:42:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXyAI/WqjyV8/qARWgzos3GOV/Rl+UXjbsd+MbLU32xEaD5dCtWC63TMeTbX1HilnmoS9ty6Nqb/8c@vger.kernel.org
X-Received: by 2002:a05:6102:5114:b0:5db:e851:9395 with SMTP id
 ada2fe7eead31-5e8274880c3mr3176724137.7.1765780953967; Sun, 14 Dec 2025
 22:42:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208133849.315451-1-arnd@kernel.org>
In-Reply-To: <20251208133849.315451-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Dec 2025 07:42:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXvNzE++8w1nmD3QXBGb1BzstZwJTSb5=tFfHZDfdqEww@mail.gmail.com>
X-Gm-Features: AQt7F2oarjP5QGbxmpaEZ0_EM9xtIXwm1jfIRkcALdkvUUJHSsJhnUQ6WxUQxdY
Message-ID: <CAMuHMdXvNzE++8w1nmD3QXBGb1BzstZwJTSb5=tFfHZDfdqEww@mail.gmail.com>
Subject: Re: [PATCH] RDMA/irdma: fix irdma_alloc_ucontext_resp padding
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Faisal Latif <faisal.latif@intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mustafa Ismail <mustafa.ismail@intel.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 8 Dec 2025 at 14:39, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> A recent modified struct irdma_alloc_ucontext_resp by adding a member
> with implicit padding in front of it, changing the ABI in an
> incompatibible way on all architectures other than m68k, as
> reported by scripts/check-uapi.sh:
>
> ==== ABI differences detected in include/rdma/irdma-abi.h from 1dd7bde2e91c -> HEAD ====
>     [C] 'struct irdma_alloc_ucontext_resp' changed:
>       type size changed from 704 to 640 (in bits)
>       1 data member deletion:
>         '__u8 rsvd3[2]', at offset 640 (in bits) at irdma-abi.h:61:1
>       1 data member insertion:
>         '__u8 revd3[2]', at offset 592 (in bits) at irdma-abi.h:60:1
>
> Change the ABI back to the previous version, by moving the new
> max_hw_srq_quanta member into a naturally aligned location.
>
> Fixes: 563e1feb5f6e ("RDMA/irdma: Add SRQ support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the discussion in Tokyo!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

