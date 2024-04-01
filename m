Return-Path: <linux-rdma+bounces-1715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD288946B6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 23:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D693B206B4
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA354FB1;
	Mon,  1 Apr 2024 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xqJlfgFm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105D54F87
	for <linux-rdma@vger.kernel.org>; Mon,  1 Apr 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008248; cv=none; b=ArvkuH2Tjtgpk3uK0wZGYNHPCd5p0nRr3IrAK14vvsXv1wxGeJO+fuSBvyUdX0Ofu/rame4Qv/Gsx77UBsuc4jivKv8xMAUWkBB2EbezJKRlmw02AzFk6Y7X1F+SuNGPPRujpRjR6gACDsmaNvZ00GZX3ZqCqFn6nHWRpKxStNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008248; c=relaxed/simple;
	bh=LvCBtM2YQSeJABfcqD051PDiGGBI0pmlfrMCxzUoMmE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a8uVDqT9Eqq5zJiRdK/u0RHiQ1RDQTjH3oIbp+wW5I4KfS0ajlbqpG8Bm3TjxHg2KkvDMyOEEccMRW40fCLsnpJD1mULetmFq9c4BCRSRv+2aHFL9w6CcDua9z+A0cKZ0x0/WiJGJATaupzkZVxMPugbdcMP8qTTTdSUMgJayj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xqJlfgFm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so6979624276.3
        for <linux-rdma@vger.kernel.org>; Mon, 01 Apr 2024 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712008246; x=1712613046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XLIDZpDBHrtC9mQGuM4295zuVNtkbE3PLQnEnnfrBMA=;
        b=xqJlfgFmw8EVSNp5ix6dcbeyrN7dLmOMFe9SHW+OycpRPRgMAHRgN2t5LerU4HRTdT
         KmTrH+Dk4u2rRCeuRD3GD/R/X6W3ZDBgF95+9kiqJ2I1ulsuINi0c55F0JSK7v0tHOHH
         5fVHW8PZ4eTjTLqREeHKCeaxxS0GMHCwWtZZ7uCn+j5eCpwkm3Fln1UBQM/YOZrjUNap
         89LDl067TluOt9qOfbERA1tzFi47zLt0YDEFJU7IY8+QjHQaO2D2X1+rxkjg5/4wV0Fz
         0BEuUIgSpyjQ73z9thH5OhAUZrxiIFff8QaSdDFXTzxRvVuOjhyDGaxgB+5D/XxdXYzc
         H5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008246; x=1712613046;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLIDZpDBHrtC9mQGuM4295zuVNtkbE3PLQnEnnfrBMA=;
        b=eP7Wztkki4zRUOQXaAj3YVlkE9mDUYkE5BBcVhsT1zJovrOul3kuVM28PWZzc88x3S
         Ki7g/ixi1uUSCv5l8WQ8lZJDDAToBLU/kV3efj/3d/k5gViTaA19D3c/slhNiJiiZhMw
         G8PJVp1Qo9qrCCqNckGkzL62tN48BOlgkrHRUI0D0EE4TydEYXD5ViPC4wC81/AFNp73
         f7ZmpdiqsdIt/DHWWN4sPAGdYI1gg0wcw3EUu8+tNdxNFEVLZxfZEG7tMRt2BjfRe+xc
         iJ1IWkSSXy8Zww5otwsbpDtEQwVhRFmcid4hrk9otfDo6tsOJlO3ABATvRpB2dm5h24/
         e3VA==
X-Forwarded-Encrypted: i=1; AJvYcCW6M36eaQFxLJVw0uPTfgvEX0D1qjmuyDaMEq0st99obZUSwI8kfuAooPTYz84LrekNe64W5+fisTUofwtCcA7gRd47/E54tA4JUA==
X-Gm-Message-State: AOJu0Ywc4mAe4n/Nl5A6NhsP4C+YjXjXhLjj2gbiShgdFoaah/7NEXTI
	CCcq2U8q9eWR92vJWL+0xawO3flngXoOtAe+uaTPbWk4MbJu52XuC9ODSdYH2Gooc1kYEqi4hjg
	UiAJaJ+Fvwvzd0kwLay4Cdg==
X-Google-Smtp-Source: AGHT+IHruwWq4JyI/hLsIFHmVo+4Qge4gKmr6iKc/6xRaXQRVz5Jk7BCEwSZk+LRAFeal/Y+Ugr7hvswKysh+BY5+Q==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b337:405b:46e7:9bd9])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:2503:b0:dc9:c54e:c5eb with
 SMTP id dt3-20020a056902250300b00dc9c54ec5ebmr3429870ybb.7.1712008246111;
 Mon, 01 Apr 2024 14:50:46 -0700 (PDT)
Date: Mon,  1 Apr 2024 14:50:36 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401215042.1877541-1-almasrymina@google.com>
Subject: [PATCH net-next v3 0/3] Minor cleanups to skb frag ref/unref
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
	Dragos Tatulea <dtatulea@nvidia.com>, Maxim Mikityanskiy <maxtram95@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, 
	Yunsheng Lin <linyunsheng@huawei.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Howells <dhowells@redhat.com>, 
	Florian Westphal <fw@strlen.de>, Aleksander Lobakin <aleksander.lobakin@intel.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Liang Chen <liangchen.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

v3:
- Fixed patchwork build errors/warnings from patch-by-patch modallconfig
  build

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
 drivers/net/veth.c                            |  2 +-
 include/linux/skbuff.h                        | 44 +++++++-------
 net/core/skbuff.c                             | 58 ++++++-------------
 net/ipv4/esp4.c                               |  2 +-
 net/ipv6/esp6.c                               |  2 +-
 net/tls/tls_device.c                          |  2 +-
 net/tls/tls_device_fallback.c                 |  2 +-
 net/tls/tls_strp.c                            |  2 +-
 12 files changed, 54 insertions(+), 70 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


