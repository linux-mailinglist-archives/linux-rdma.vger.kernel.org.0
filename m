Return-Path: <linux-rdma+bounces-8897-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC8A6C113
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 18:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C60D3B41AB
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 17:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45622DF84;
	Fri, 21 Mar 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ExufT+n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322622AE59
	for <linux-rdma@vger.kernel.org>; Fri, 21 Mar 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577417; cv=none; b=qaLk7bNd0ReoaU4+bWu8a5tyFKLXkF5mBCL6FX6AQFInD26cSFeiUjT0kkHD8DHMxrf5k11CDF+8vvRrkHxniuyO6nsLlXQWc6itH13PPVtG7/trDU6dJt9XYHEZIzM7PbCIPXeuszno5j2v8YjACsz4WU9xMuHehltZm6DNitk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577417; c=relaxed/simple;
	bh=GF76z/gw6/XYCeidT43ebdiAMeBN3LvsPNBDBQrg7YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoqTejMHhvtOG9vGAn8sPP8AzuMHuD55zzEl8SKPeETMDExcG4iufYMBn//tzHlmlo2ZoUtUc7bZEay07hESLv6ZbikiryYRe7iDE91WuYjGqO7vEOWFe/mR5uZ947HHiNkSCIjAfKEJe1CNIG7OVqs3DhD3Em6mZpp/FnqpHws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ExufT+n; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so691a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 21 Mar 2025 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742577414; x=1743182214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF76z/gw6/XYCeidT43ebdiAMeBN3LvsPNBDBQrg7YM=;
        b=1ExufT+nazhlKz2oe2+tlrbwfCoaRGvifx5rhrQ/FXUblFaAOrpuoHIvsLs5h1pgCo
         X5AhsXJtW8P8zGkhpLFBHQZBWAQT3N/eN+VZo8ltE8ZeyAdyvk26JkXjWqP8ZDGjrVLu
         0MFZ/xLmpHiJL5S0G2vCDJzoT3WBMR95zGBIDGJUJW4Ntrv3mFweMVOdGN7akgYzwgFU
         d3IndcfRiMH+RPKj0DUmq8A6QxO7fjMtjpQmD73c+5T4SENiEWviOPfBnndz/so0vHTU
         U07Y7XjRuKJcxDJq+HT0fuKpoQhOdN0oDZkrUMms4M7b7nYwJ6gPeNSXdYA/cnNoat0N
         XMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577414; x=1743182214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF76z/gw6/XYCeidT43ebdiAMeBN3LvsPNBDBQrg7YM=;
        b=m2nD7QRDPQv247MLHwQtmVavO4UpSHhuEUYlg1sG7jP9swkDDb5vJp7tlAi29NZXzI
         SNzDgZv790KTh2WKxoceQKRmHvpTOp4Kovt44IuXlZnkWExauWPH01BEfX1OdrheY45n
         U9oOlff7M9x42AJ5SiIRJ63pVpYqluv+MemzLeKu5ENsGby9imayO+zJtW9/b87pceSU
         A5I9KnpPIZSBcDFY7rqkwrdSSRm3zMshhAYjy0PvpLbbE6WiizDvYarjjueWXv8+rVLI
         o1cWTWhwekvec1Uo7ACRzZeZ+p4w6paEZqXSnpK8b6V/4N4BHkXmIrF/tC4bGMnBLbbm
         j1yA==
X-Forwarded-Encrypted: i=1; AJvYcCVT9KSZ0elyowv3WLbYE7hYq2VY9ExFhRp2wMmr5frn80o1ns/fbkXxh5hhHWlG8v2M6dDeplNdCUco@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22NUYRsPwioo0JEp1nbBeAVKUJkYu8EXQTSMqz1NnQlTU1yYS
	LlN8MNygKLTsa6+Xedu/AxPmfh+bKtt/aK/YSeGzG4zB6aogmPRWQZKSGaJYW0knTNrSjxVtCZE
	BQbR08rPM74woyIW2ddX/jKxQUQAz41Ng4j1I
X-Gm-Gg: ASbGncvxm0Ge/Oh0zpUF4tejVvuNXfKci9Z2XoSxQdfABBWsyZ6B0VUkmhDSwtFdkbu
	P+NMDcnQ5gRIAdR2shK+E4k9f5eEyUGEsk7z6zExq4mpeoDuTz8MHhXut5safXrGHAauxc7Zq4S
	YX1iws68cDXeMHGeKERQXrzNUttKwQQa7xpqRYQPm6QfxgcZMtyVsjTnrE
X-Google-Smtp-Source: AGHT+IH98cBXDDveN9rfl6GGcJmdCE4sTWw1fPkcgg6ndYVyXdIooR0jo6P0/9JLlSPXdrq0KQvrTrtTuAfJEOPcfyY=
X-Received: by 2002:aa7:cf04:0:b0:5e5:ba42:80a9 with SMTP id
 4fb4d7f45d1cf-5ebcfec9cd4mr99789a12.1.1742577413456; Fri, 21 Mar 2025
 10:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com> <20250314-page-pool-track-dma-v1-1-c212e57a74c2@redhat.com>
In-Reply-To: <20250314-page-pool-track-dma-v1-1-c212e57a74c2@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Mar 2025 10:16:38 -0700
X-Gm-Features: AQ5f1JpuhBehogw3WxvH8_uBEh2ngmkK2xaGkRPh_1xg8XM9z4JphAcaolSD8Kk
Message-ID: <CAHS8izOMXpYn=XdVt6ysd4SJ+qpPeUShnG9grCZEO7pcJqEVrw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] page_pool: Move pp_magic check into helper functions
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yonglong Liu <liuyonglong@huawei.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 3:12=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Since we are about to stash some more information into the pp_magic
> field, let's move the magic signature checks into a pair of helper
> functions so it can be changed in one place.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Straightforward conversion.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

