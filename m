Return-Path: <linux-rdma+bounces-11044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E3EACF839
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 21:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3963B3AD8D7
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 19:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5186927C84F;
	Thu,  5 Jun 2025 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNGckdM9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795513D531
	for <linux-rdma@vger.kernel.org>; Thu,  5 Jun 2025 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152638; cv=none; b=G3XAv81IMzfgvxPiQtiN2xpYQ+EbKejMLBXRlaN6aPcuyqVwAVNMQOB5pTrWMPN4SX51Tn5fmQ2Gx/GopgjuCujh53uIb6PXH86c27S/3O1X2w2Qll5UEquVavoB5zu9n75A52dS8BEAt+cZ/uA92mI2qHDsXiHsgqNYhhL9yWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152638; c=relaxed/simple;
	bh=jN44ZFVMr9GHNcIYHb3FN2FmJm8OL7ZLAAK+uoNvIUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXnCsfPHZtKleiZDWx7BI9AojtHu3FB4LGEjYC5CWS5lyjLrmu2EczwIcQxaG5J60r/rM74GcZpJpSE5d7kJ4OZxYoeb+0MsTDJmVCDphTxDKSXsjin/LcHJyLdI0zbWNK5L09Vt2kApFDPFbGbYjPXkvT7HMBwE4uL2OrfSBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNGckdM9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e389599fso52255ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 05 Jun 2025 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749152636; x=1749757436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj3tye4JAMlRcErC28Dz8Fh6Njy6GB9AnVOY8tKtYOE=;
        b=BNGckdM9/alHGZr0CBny/zgGBFCG+enXk78P0r9eya08tX3/YohwUdPyv/SlWm3zdC
         qxYDfmb7/Mn9mfRWO3BTsUL8fbeV8tpYAItRvKYumdF7YjVzzeoos3TDl8c8TWtvthXe
         BuiDWcdFpEQTevPC8LL5yFrA82tst+ntTxrvyGGCaiE5W5MaSncDqL4tJeqHSr+8+okt
         3XdCh1Ko41oc+rOXnspAuaWWxUyX1hs8PshRaazqYhMdsGjmCPrN8cU3o0x0rf1EEsCr
         0AlNf+wlsP2JxV3mmyMQdWe62Yc8qw+yONOpI+v4+eAF9BnBMuyNFP4O+x8kLtsAVqCt
         28IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749152636; x=1749757436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj3tye4JAMlRcErC28Dz8Fh6Njy6GB9AnVOY8tKtYOE=;
        b=DZ8zJ6EFCbcuk772hkGZ3V17xbf0w6h1zQGTfnq2SfhjlduEe189girS8GbS1kMGqs
         v8Zis8rNWJTZH7b99rtls2IKgWTg6+oQ5NXEgjIAj4g6FWzDuYBmy6fRoe2bPs1SywK4
         eg6FNHxMYpXQJsZJZ9vPxkgaCirEsYQzCWM46YoWQsKKql2Wx5zDE0ivZwLIRxDMTRIX
         o6F9LVUfQs64y/J5YQb1b2mnKGzWQLv65KOpZeSXfMuW6UpBwA7gGxU/qYhOeu0a33Wu
         UWXyYu/C6GGyW6/6QPgfSwIztRx3BjA7KG2o0Bn1BjcYFqhQPCX/BhF2nmB1kBKGOa3T
         PPcg==
X-Forwarded-Encrypted: i=1; AJvYcCVfj/vJ3gNpVuoKM5fn6B3wzASZOTueyRON0TTBqnWIWc+FNuplgiiCKXLimNbQiOUqMskR9VRmQQCV@vger.kernel.org
X-Gm-Message-State: AOJu0YzENXJhotsoe33d8cFclrWC1F4xNsKpTy1jgiK6gHeJxaEfwAMx
	Voa2Yv0WXT287H4dwsx4ZotQsReNW3z43kJemhXusS3/ILZJa5F81+JeNZQuR9bu0xFRvRTZq8Y
	43Axzwy9lJX3iqplYFE2unwzLU3pSSVxrpEw2TH4m
X-Gm-Gg: ASbGncvWmBmvnOnJFk1V8xSbXJW0xtTKDpf7Cfx1UzBNItgAHTrElymCAH2pb9lvJWy
	v2uMviNCzvdRrdZJKT/CRsNcPwgV8l0H5d0Xnw0vyTqE8kgILpfwh/bQ4ahsDzzySHj+UEQj7m4
	KYevHn/Ub2CEpxSwXTDw2bgnSt6Go5vX9ylKOTcfcJgAj3M5GH0WV2KqI=
X-Google-Smtp-Source: AGHT+IEBIODvKBKgtAshAl1P411grxlbXS/55w2jMC1YMikPG5ZKwDo4SPQP9h6zD1jvtjknBfImHPrKKrn1cZNVkuU=
X-Received: by 2002:a17:903:1c9:b0:235:eb8d:8018 with SMTP id
 d9443c01a7336-23602350a46mr581785ad.28.1749152635690; Thu, 05 Jun 2025
 12:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604025246.61616-1-byungchul@sk.com> <20250604025246.61616-17-byungchul@sk.com>
In-Reply-To: <20250604025246.61616-17-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Jun 2025 12:43:42 -0700
X-Gm-Features: AX0GCFtYUIJFXLeYwJiH9gq68hlpsWo0WYW6pa8nN0A0HiJO6W2G4teckj3LJCU
Message-ID: <CAHS8izPU=A-sb-8ybSGx=Y30at1Rah2ofpR0FfRAgUnJ87=-rA@mail.gmail.com>
Subject: Re: [RFC v4 16/18] netmem: introduce a netmem API, virt_to_head_netmem()
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

On Tue, Jun 3, 2025 at 7:53=E2=80=AFPM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
>
> As part of the work, introduce a netmem API to convert a virtual address
> to a head netmem allowing the code to use it rather than the existing
> API, virt_to_head_page() for struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index d4066fcb1fee..d84ab624b489 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -265,6 +265,13 @@ static inline netmem_ref netmem_compound_head(netmem=
_ref netmem)
>         return page_to_netmem(compound_head(netmem_to_page(netmem)));
>  }
>
> +static inline netmem_ref virt_to_head_netmem(const void *x)
> +{
> +       netmem_ref netmem =3D virt_to_netmem(x);
> +
> +       return netmem_compound_head(netmem);
> +}
> +

I would squash with the patch that first calls this to shrink the
series, but anyway:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

