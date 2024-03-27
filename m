Return-Path: <linux-rdma+bounces-1623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9349188F12E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 22:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C471C2F014
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 21:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C915356E;
	Wed, 27 Mar 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdR68CvE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D8152532
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575929; cv=none; b=Zs1S6JZVBP99M3iDZBoTKpkUcvRpK8QL7er/ZsDixiBVquS9mO9L0hQobKvB66Fn40XxXKKe3b8MEio6PxTurkm6M+JCuQyGiLPfhv77ERI+MDnjWU91Wm86H9YO6+R8p1JF85wuzpFo2VnvmkLs3SGOAq7LcdAXrI2046uKYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575929; c=relaxed/simple;
	bh=lTnVetYvVWg5DjyVBudKOtPcgTtVueyB5BYBsAsl91Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LmO/pRKJHVab20EG3ukUcZ+4mSd9AKeoRjb377DHic0e8MaGVCphMH5q4/q95/8dEaXJVjMgWosuEpzcvvkWqTI0bGg7J/pEYfz8ojDHjocVyTcA09+Ks/dxZlevmdsZdqKlMHI+h1uGZfwGnKVh3S5BMIVsKqi89Q3xADuBaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdR68CvE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a20c33f06so4277447b3.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 14:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575927; x=1712180727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CKh/si12loPcjkl/bjouIbxS+vyvkdZDxqEpH33Vuvs=;
        b=SdR68CvEpuBEsx2TIE0nQmQ0u5KH1ZB5jWHON47nBAdvzzx6a7S353k1NDA3eKnsz5
         MHTp6gPdPLJLmF9KWv1oxhHoJdiU9OSmkOUtVzJ7VgUoiVSLXW1zTGFfLeZdGpnE3HjZ
         Bkv28ee42yrZoMrydEOqUbmWrqVsU8WX4YAZvup4rNd8uzMzVWF40y+0MDrpHrljErxP
         LxnfH8nS9GAJ/88KNBeD0P/tZh1cdclhcFaOR8A9QCCCWsi02Ca1ogIgHJCPbgjWYY05
         KnRLYrUzHycOHOgnHqyqoHfJu8GPw4Wc8v2pAfmo4HHVxksJvu+S4NvX01do8bl32WAl
         NXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575927; x=1712180727;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKh/si12loPcjkl/bjouIbxS+vyvkdZDxqEpH33Vuvs=;
        b=UZpPN+IHpgUFqbq6ztQN4+QUCvSIAYtfFRkSe1FCNuGejBxEn9foTL9z9uStL09eA+
         hPk+LaiVyUENcm7fetem66v5Rfyr7TYk+KGZaqCgYj9mpeBz0gd/TaU01Sm7JCIk6ID3
         idJ4dTwBTQ+R+3taB6CvxDTN4jIU6qP+AYKN4AuIcfUdA8TD9d7SPF+VXwpayN9tHCtx
         NR8Qwx/jqfuBkrwH377Ljhyl/rq38KRaKaXCnEXLz/pVVNj0W2za57JyTlQdIVetrnzU
         3Tpb2S6i/L9csJqLq1gZcIGLlwKLsQwQFiTXOUkj1jsjd/pbgCBHzKHwyrYdOzr1I98Y
         Apbw==
X-Forwarded-Encrypted: i=1; AJvYcCXRYNWyX2/2rdPeIZFlZKxWwjDKM9I4AbG40cVDjo7sRmFj+7TFpuH6xzSm7mI4qn+oUh3mVgTxRls3Ei4VdGER59O2LB9dlj+xBQ==
X-Gm-Message-State: AOJu0YwuXqSRxvuyTyj8MHLNt522hP57Ke1nsBPq23ppgYQre8+uscy8
	iHzOe7ZbdY3NzvHCooken7iYqRahFgzLWBV2dzdh6P5ctCji0HHOJM8MoPd/l/kHnW/mWQ+XUi7
	gGbBLqnbmM/o5/DxISYLzVA==
X-Google-Smtp-Source: AGHT+IFM+e1tBg9sIOrqzj/fm8HC2M1gqAlsPGauO/4UHdAS39gUJvq9E+dCMs/mmshel1oryCqv2D34XoEaWwuTUg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b757:6e7b:2156:cabc])
 (user=almasrymina job=sendgmr) by 2002:a81:834c:0:b0:60c:ca9c:7d10 with SMTP
 id t73-20020a81834c000000b0060cca9c7d10mr184265ywf.2.1711575927326; Wed, 27
 Mar 2024 14:45:27 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:45:18 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327214523.2182174-1-almasrymina@google.com>
Subject: [PATCH net-next v2 0/3] Minor cleanups to skb frag ref/unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

v2:

- Removed RFC tag.
- Rebased on net-next after the merge window opening.
- Added 1 patch at the beginning, "net: make napi_frag_unref reuse
  skb_page_unref" because a recent patch introduced some code
  duplication that can also be improved.
- Addressed feedback from Dragos & Yunsheng.
- Added Dragos's Reviewed-by.

This series is largely motivated by a recent discussion where there was
some confusion on how to properly ref/unref pp pages vs non pp pages:

https://lore.kernel.org/netdev/CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu1TPJWSz4bGoA@mail.gmail.com/T/#t

There is some subtely there because pp uses page->pp_ref_count for
refcounting, while non-pp uses get_page()/put_page() for ref counting.
Getting the refcounting pairs wrong can lead to kernel crash.

Additionally currently it may not be obvious to skb users unaware of
page pool internals how to properly acquire a ref on a pp frag. It
requires checking of skb->pp_recycle & is_pp_page() to make the correct
calls and may require some handling at the call site aware of arguable pp
internals.

This series is a minor refactor with a couple of goals:

1. skb users should be able to ref/unref a frag using
   [__]skb_frag_[un]ref() functions without needing to understand pp
   concepts and pp_ref_count vs get/put_page() differences.

2. reference counting functions should have a mirror opposite. I.e. there
   should be a foo_unref() to every foo_ref() with a mirror opposite
   implementation (as much as possible).

This is RFC to collect feedback if this change is desirable, but also so
that I don't race with the fix for the issue Dragos is seeing for his
crash.

https://lore.kernel.org/lkml/CAHS8izN436pn3SndrzsCyhmqvJHLyxgCeDpWXA4r1ANt3RCDLQ@mail.gmail.com/T/

Cc: Dragos Tatulea <dtatulea@nvidia.com>

Mina Almasry (3):
  net: make napi_frag_unref reuse skb_page_unref
  net: mirror skb frag ref/unref helpers
  net: remove napi_frag_unref

 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  2 +-
 drivers/net/ethernet/marvell/sky2.c           |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  2 +-
 drivers/net/ethernet/sun/cassini.c            |  4 +-
 include/linux/skbuff.h                        | 44 +++++++-------
 net/core/skbuff.c                             | 58 ++++++-------------
 net/ipv4/esp4.c                               |  2 +-
 net/ipv6/esp6.c                               |  2 +-
 net/tls/tls_device.c                          |  2 +-
 net/tls/tls_strp.c                            |  2 +-
 10 files changed, 52 insertions(+), 68 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog


