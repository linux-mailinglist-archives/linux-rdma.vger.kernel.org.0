Return-Path: <linux-rdma+bounces-11213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC106AD6057
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 22:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF7A177811
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 20:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2423BCE3;
	Wed, 11 Jun 2025 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tT4KmrVq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9570121B9D6
	for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674932; cv=none; b=bcqy0wfYDwpj1UYYtipiobxvNrK86t/J3UPd5azvQt3DN9ay0EC7/QbhcajtInb7eo4Oij7dlkqwtHieyMH7dtMijGZjE35ysACqhfnz6H6aJGa1MfFye315JQlnKVSSkzHCoKhWNo6QpxhMFQ/aEpxaguLmfiPDY36lgIWOUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674932; c=relaxed/simple;
	bh=dy/Bwb6Thnom4khEjtNBkceEkdwxV066C0Be2MDTp9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWLXiMGg9tA5fcG+Y5aCxemL6KvpgEM2Xved09X6Xikf+2nkUqyPccpJ/5IF9s+CqDc/lpjcCQwBED8IvD/paETc657C9VEtPprIoxThdQt0O8o2cp5dRpCr4cSACZdilyMybCctqgyfxAvZBIiD19BjTwRZ73hZMh7eRZyJk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tT4KmrVq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e389599fso57685ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749674930; x=1750279730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUvCi02xABTrop0OD7rFaiszrr+jU6INxefWYNqLLI8=;
        b=tT4KmrVqknjLs8qzr6UWSjt5mo+eef31F2aM9nz5IspAqwF7Aa1JIungUKk8h1qzQg
         uaPVaTBDZ5Y0Mr5HtmLN+w5CwseQTY1cal77Njj43cE8VM44xAQbglfBILtphlcZIF/5
         sqOkrVvLIqiL54+Fbqua2BvovxTIIjikNV4ei8OGaFG6XZyDqibGz1N3u8Ycz3OH4Msk
         HLjexu8cSIrp9WRrCgmpNm2GmCY+YLk5766s8X5M4Vkd4tVB1eJea51xcMQvK7Ugr7uI
         tByho5TjJaDxnZtLY9LuLVDSGJYRwXPm4H5hp7KO4zt2pT7LBD8OV4rS7is6YU8ysHHl
         SNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749674930; x=1750279730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUvCi02xABTrop0OD7rFaiszrr+jU6INxefWYNqLLI8=;
        b=tERsmzHMtAPREt6/meA9aIGPmP3wMp0neSyy9XQ2oKCBsT5SIYzBufukr2LgTV4Fdz
         FcJbjMUaAEQC0WK/0YGq9fvfGQgLb8UFiB98rnYjDW9scObLh8TUCIBNN1C354rK4bW2
         aKhWTdlwhOgRSBrs/t1thOZuaLNpN2B6C7hHq61OR+wqSblGiPCzWKqaMymxFZEJvioQ
         M40r47ZXorjmITKNc2UON28/t3/kXMjRSa0K2r4MTkBi0UDwYo6EqTXWl1+sR2BHnYch
         OgKRhvl6KiFm+Y2ZXsyWWSs9LSclOsC45Qtpk2yJz7BqD94d8dHWttryybBNd4wP+J1o
         jDbA==
X-Forwarded-Encrypted: i=1; AJvYcCVsbAmfvwtd4g7m+Sv6029hLouz1NoGGEGDPKAvaiL6kKmtReNrSF/2QmXDG3aJxEQTI6zSUAjAfv7S@vger.kernel.org
X-Gm-Message-State: AOJu0YwdK8O+f+CjL/HX+Lrqh7h/HI5ACMTzI0uh7QM3Q8F7CMmJ1btb
	H0d9FkkPo/L+kjYq02L8y54t3dnagbSf2uJEfW3Ht2825mqGwEfk9XB5rNVwxLoSaU12NH0Njqj
	26iNbPew5HHTcIZKYx2tl7XU4Ok7FkIzr0fd63snB
X-Gm-Gg: ASbGncvrPi0PZGkg8PRM24CsciwxA6Vq0S3cUdTvyY87vWUJfFFElLMRnkx1K6wa+HU
	O/lc7TR1baDhcMU+y2iCsYv9EOutLwGM8unmemRHP8ddceSf1SrgC/XWAnqMpaPTgbq6lBGY+vn
	FK2COqG5ibERAOpn2ry02NkOFk8qWxTvz/++/1kOP+gW5bDAe0oTBYEdekFRdyJjzNWWQED8nY
X-Google-Smtp-Source: AGHT+IHPOhN+2kRO/ieW+5bXzKNpmLOWrF7VTuuMHfPxMqYhDS9sFU10fG4M5zXkX7CwS4WlSGyc/8tNtPMJ+fMmqfA=
X-Received: by 2002:a17:903:2ac3:b0:231:d0ef:e8ff with SMTP id
 d9443c01a7336-2364dc4e38fmr398195ad.8.1749674929600; Wed, 11 Jun 2025
 13:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <8c7c1039-5b9c-4060-8292-87047dfd9845@gmail.com>
In-Reply-To: <8c7c1039-5b9c-4060-8292-87047dfd9845@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 13:48:36 -0700
X-Gm-Features: AX0GCFsiObw-5gr4V36jOF5DxyaQMi5Vz9ZSIsC4_vLQ1YuMrAJGB2FI0rG1Qcg
Message-ID: <CAHS8izNiFA71bbLd1fq3sFh1CuC5Zh19f53XMPYk2Dj8iOfkOA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] Split netmem from struct page
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 7:24=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 6/9/25 05:32, Byungchul Park wrote:
> > Hi all,
> >
> > In this version, I'm posting non-controversial patches first.  I will
> > post the rest more carefully later.  In this version, no update has bee=
n
> > applied except excluding some patches from the previous version.  See
> > the changes below.
>
> fwiw, I tried it with net_iov (zcrx), it didn't blow up during a
> short test.
>

FWIW, I ran my devmem TCP tests, and pp benchmark regression tests.
Both look good to me. For the pp benchmark:

Before:

Fast path results:
no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.337 ns

ptr_ring results:
no-softirq-page_pool02 Per elem: 529 cycles(tsc) 196.073 ns

slow path results:
no-softirq-page_pool03 Per elem: 554 cycles(tsc) 205.195 ns

After:

Fast path results:
no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.401 ns

ptr_ring results:
no-softirq-page_pool02 Per elem: 530 cycles(tsc) 196.443 ns

slow path results:
no-softirq-page_pool03 Per elem: 551 cycles(tsc) 204.287 ns



--=20
Thanks,
Mina

