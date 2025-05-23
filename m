Return-Path: <linux-rdma+bounces-10638-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3247AC2850
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CABA469DB
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FB1297B6D;
	Fri, 23 May 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMvFsIvR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225CE297A68
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020424; cv=none; b=RjIiXcJwqRr4kG98M4doq76g+PWUfUfv9789S8KlLap899Uu6RcJCZFDPki+/sPK5rkBjSEaAAO3VwaKYPI26rn3nN83WnAk1lKIK99spESlRc4Cj2xRfa7CAf51ognJTsS+vuH8lm0uH4gKT0r600kWPP7rA5XeOKaz/QPRasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020424; c=relaxed/simple;
	bh=b6+odg8Uy4SxwN3Tk8MC1g2EyZZcGTBLhKLUpCK3vWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ6Egyn3U0BUHkw9AGQHvPDwQqtfUqc06JbcS/YcUzGPnGQCoz4GKEhSgWtl7pzX4B29/vOSnmjdK7TW1cJFyEGwcTbfK3UwiQx2yPf7kMDQ98P61J6LtKlvj/ZFJBmGcb8oDv2Mrby217jYWLE6lueBbK7yNt6C6PvHu13DB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMvFsIvR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234050cb45bso8935ad.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748020422; x=1748625222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6+odg8Uy4SxwN3Tk8MC1g2EyZZcGTBLhKLUpCK3vWw=;
        b=GMvFsIvRFkw5jOSQUKELMdp3vG5J3omj2HkoA9Gl/g57Cd1dR4yaYFB/ad54YlHDob
         clpUyhL6kpvUcHXFO0uppzUn9AsCX4EfDW7hrtqeje3H3gTAEgXZTsYyYFLbKLGtznBg
         Y7rgPh3W809lzwCs0gmwgjzOSqUatCtIrCP4dgbxxPgRrTlL8RZoj1yoPd/TvGiGM/2m
         cg70+tMGZcUygKrj1Z85J4+X9r8Va1bUve3mdf3HkQwo6ydQUZIkKt6Kj7xBMCHmfk1L
         O3oYiZX7jNJmbLyd8oeiX4i2mHNwGRGSAbgkSYjD0BT8KWMdpbrAGpEpKbzRlwotYsWR
         APFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020422; x=1748625222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6+odg8Uy4SxwN3Tk8MC1g2EyZZcGTBLhKLUpCK3vWw=;
        b=HSlEgtltX1XMvQGEC82Jx0Sg9Yg9sy/JoEkmx3cj0THiW7qKH2/I7fGPbIRrGzkIf3
         yp3ummF/TyfuXijNd7gtqI3r/EAffsSOddGASnNarZUjgrgwVu2y8polm/pYeCm2UUS4
         YIgocumfzzZQwMIcZp23PlwoGCq17iBfUZGMgPjLukQC9HQevAcfBWHmt5mciA8ILBbd
         MiNVOlt97q2UmWzUrKhumCQIqeaA1d3cFMwNODZ1gnSD4BzlQ82UZd9yWhhp8NWMKk02
         s1kYwkg0s5La/dMq1WOyNTBjTFxSdDWrqcuJ1/LrF6KXx5GlV7exxJG8Lx/LiocD6fqC
         uc2A==
X-Forwarded-Encrypted: i=1; AJvYcCUtHrEyujZuUO9vLiymFTXJIZBDFUASg+pP48fgbRq1gdtOtHegJxZf3kqOKNJ17eTHPutoc87xArGG@vger.kernel.org
X-Gm-Message-State: AOJu0YwW44NPSWkRtafLYeB43irhGJIPMWkz/msusqJV8b3ut7tgjxnl
	5qRQJLqbVRpQtPKeGuJMrY9AnNI4+CcZhBBYJHfJp+5bQ9Jc0EiVGNL6PF3ROSxzbNqgPybYc9o
	wbLSreaT4v/ZV1Fj5iDuLaKfxolkS2TsttewWEZzD
X-Gm-Gg: ASbGncsCuOXMbTlz8KttH6sQmJstNG3GCB2qwpnjvN/M1CjND4s+jAxVkr5ONtDFkEz
	bBLV/dwStBrEuURzvbHzZy9G8TgXhrKWBA/yTCYcFyAqlXiUs9CECctZK27LyDkPsED2KWeJ5Ys
	d7XBJ6tCX3FOqCdGxDPjqQBhzsaLsT8e7i0FMHJL11S09NcMPQ6KUR2dE2NdZxKKtupL/n0G46U
	g==
X-Google-Smtp-Source: AGHT+IHAljnGYXYXNqd9nHJuWOzFhZwP9BJe61GK3nUJDrt7+9et104XIn5ap3VmMUMS9tlMLC62sQxv3IszoNXzfZw=
X-Received: by 2002:a17:903:2348:b0:216:7aaa:4c5f with SMTP id
 d9443c01a7336-233f34df516mr2604685ad.3.1748020421823; Fri, 23 May 2025
 10:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-14-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-14-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 10:13:27 -0700
X-Gm-Features: AX0GCFudL84CRA-sCSeMtnKfh8Fbbgk_GwqD2a3SUOuPIpK4U4Fi3ZaEYQxBmmA
Message-ID: <CAHS8izOX0j04=KB-=_kpyR+_HZHk+4hKK-xTEtsGNNHzZFvhKQ@mail.gmail.com>
Subject: Re: [PATCH 13/18] mlx5: use netmem descriptor and APIs for page pool
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to seperate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> Use netmem descriptor and APIs for page pool in mlx5 code.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Just FYI, you're racing with Nvidia adding netmem support to mlx5 as
well. Probably they prefer to take their patch. So try to rebase on
top of that maybe? Up to you.

https://lore.kernel.org/netdev/1747950086-1246773-9-git-send-email-tariqt@n=
vidia.com/

I also wonder if you should send this through the net-next tree, since
it seem to race with changes that are going to land in net-next soon.
Up to you, I don't have any strong preference. But if you do send to
net-next, there are a bunch of extra rules to keep in mind:

https://docs.kernel.org/process/maintainer-netdev.html

--=20
Thanks,
Mina

