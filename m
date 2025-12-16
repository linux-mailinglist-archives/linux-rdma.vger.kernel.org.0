Return-Path: <linux-rdma+bounces-15036-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C317CCC42BE
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 17:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C61D33091983
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEE033984D;
	Tue, 16 Dec 2025 16:06:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C2330659
	for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901192; cv=none; b=rG5gL9U72Ltr2vtl5BhF1J/Wx/glo9tknLnO0RolNTX0n31cri1Volj3S9FWNerouGsayjQXrGHRHjOeK21Qt9tJp52sQbFUCvkT6EbSQlhbqh5fbsLhfp8J+NI2xydJ2mVuRXkwwpyh0aD6alaL9hn5Oq5IDNA2ctfAO23fYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901192; c=relaxed/simple;
	bh=ZbCxFXViYY0JqhcGfnxOHCUGcljEiGp2x9f+pJft6ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4yj/6Quffi1181yQq360CePhaeZUby3fe8QXIUPpBbSEXLRQruv+1CJH9JNIX/5VkMPsr/8vk11Soq2Dt2YUa6tPyf7e14enmrdU9F0dRpwGGuhRisHXXgc5DmqlIUMxIDaoPtf3KQxmtf+NHHZ37LYeFUjcsxZqHC1fFpFcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b1dde0961so3316192e0c.2
        for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 08:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765901190; x=1766505990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABolTLbL+Ijw9a+lTCbW30nxIpq4yhzUHc7TJQGRpDg=;
        b=qVWHFJ4YOi69QkSVgS/eUh9sgq9n77pyXBbuiAGezX8+2GUZDt0TufUlAQI95R2NMx
         5ofTbb305NiPMwpC/Bcq4ARD1E8LPK/QcuxRO2dt9TXhxYZGzAodSm0v7lFwrrhVBvSm
         ScRjNTlB08/VM0g1pMjaxRg1pRobFMcuTmAbyWUatufS8e8lA9DNaGRmf6tr4tKSTw7t
         e2NC4MLLOG4gFzfZsFvHagLQbyyJxuMVZrcq5bagK17oq3N0NAqGITcJt/ahxogsJOPe
         0dkoKkKeZbZ2kt1iZVspLZHzY1qbAcA1Ct4Y2dFqinmAs/eP55rr7rd7I0LU0pj6BwjS
         s6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk9/TXaeaRjPu4/XTH5wzec8Wlga8+DbqaWG51Vi+9GEnxExp8uFNy04YRojLtG1NHI5l1A786I758@vger.kernel.org
X-Gm-Message-State: AOJu0YwCIqwZSzbRlkKL7GU/7LBduiBaDtOGeIZUwBQ5iPMn28Ctd//4
	P2HZDr1DtAK/sOBCJORtapx9g6RmRoiZPqs5X0ZzYhzsVVtjHjrGGFe+A2bArcGn
X-Gm-Gg: AY/fxX6bJODQFblWv4ITSbWXtDDmowlCblZbsF/0podwWPQOkglf54z/awk5iPO9AGz
	H+ABQHKQfEZJIIlWj2c5/vueYy18Gx0/qD1kUk+fNoVj7zygrWnYHDyyyBiFToeieO+BfB3GINR
	aMeSng3vdkVn5OcoQWGgsDmrudcHh9w2vyUVZUNAfWXN0I+nbpCBQlGFFjR9i0nsmxlIKUnVKyh
	0OHFLhzy0pB5TSy//iZBOQAOKnzg/FUpjL+gQ/V9ILS4atVO+5xrbDw3XCtKc1noICfbU/AdID9
	6DhsWf4+DdlUBcFuHqs/zbGG2g+L5cnkxCKSBR7pfG10ptgz2VCbYHqMVnf+o1ndIxAtiNHfTob
	kF9ZAK+BntpDB4QqcvqCVTrsXitT7rF0SISANaUcd/qfOkXdAr6ayJk/w4njNdnKvM1zr8rioIB
	iTQJNfw5Cd5sXpIdtrzq4aUaVCJ+4TjPJyYWcJ39CKakrLpXoO
X-Google-Smtp-Source: AGHT+IGUZQ9ksPdIH4wZmGdoFUUUAvUuhRQXMS8xhk+SW7Fy2Ge15MMvu3KO9PHaAPC1ca1NzUZORQ==
X-Received: by 2002:a05:6122:2a13:b0:556:9cb9:65cd with SMTP id 71dfb90a1353d-55fed587a9cmr5197413e0c.6.1765901188788;
        Tue, 16 Dec 2025 08:06:28 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93f5af00debsm5733423241.14.2025.12.16.08.06.25
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 08:06:26 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-940c539de8fso2713117241.0
        for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 08:06:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+8y9R1s367t24QyD9b1WsBhiHoaLOBXmrBSoaENNKgs3MjL8JMsYp5Jtle54Zp34yx+U18v66wbdo@vger.kernel.org
X-Received: by 2002:a05:6122:208a:b0:544:7d55:78d6 with SMTP id
 71dfb90a1353d-55fed5627c8mr4657306e0c.2.1765901184991; Tue, 16 Dec 2025
 08:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208133849.315451-1-arnd@kernel.org> <CAMuHMdXvNzE++8w1nmD3QXBGb1BzstZwJTSb5=tFfHZDfdqEww@mail.gmail.com>
 <CAHYDg1QbNWW=wm4fH71yLVX_gKsPij5jed5R64JbN0mv6Lyx4g@mail.gmail.com>
In-Reply-To: <CAHYDg1QbNWW=wm4fH71yLVX_gKsPij5jed5R64JbN0mv6Lyx4g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Dec 2025 17:06:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUnRGUCiLmPYhPA8-vkNqnzX74nad9d=0Cck66GorZK1Q@mail.gmail.com>
X-Gm-Features: AQt7F2qvjXqrNdCfN0utewkCwdlxG_hIB-NvIkLGhwr-a8i2B8izMCC0vdDPNrs
Message-ID: <CAMuHMdUnRGUCiLmPYhPA8-vkNqnzX74nad9d=0Cck66GorZK1Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/irdma: fix irdma_alloc_ucontext_resp padding
To: Jacob Moroni <jmoroni@google.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Faisal Latif <faisal.latif@intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mustafa Ismail <mustafa.ismail@intel.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jacob,

On Tue, 16 Dec 2025 at 15:17, Jacob Moroni <jmoroni@google.com> wrote:
> This doesn't change the offset of max_hw_srq_quanta on my system, but I tested
> with a verbs provider built with the previous and new proposed change
> just in case,
> and both worked.

It indeed doesn't change the offset of that field (except on m68k),
but it should restore the size of the structure to what it was before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

