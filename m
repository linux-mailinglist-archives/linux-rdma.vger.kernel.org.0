Return-Path: <linux-rdma+bounces-1887-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAA28A0047
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 21:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061F61F292DF
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 19:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1BF181325;
	Wed, 10 Apr 2024 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x+VEU+E5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF57460
	for <linux-rdma@vger.kernel.org>; Wed, 10 Apr 2024 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775911; cv=none; b=R4DRBWRoLOseAPhhrhVe9bOFWicqtKTlrwQahtzaphdgN5UNCtvGAvAhc5rTU/fpKYk2sEsmrBKV4Xe6NJNRP7B5VYFMD+/7tr4wA9uNi3qBTQYuYLDhjMOTXetPoFGhemjRqeIBL1rfs2AAPYtONQnBLTCDye3MTZ9CzSsB20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775911; c=relaxed/simple;
	bh=fmONSPwwncQRNVe6gLdC7y2dFGVtjszuSrUkmPvCfMc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gztmGzzit6KwwlDV0oU8Jmss8JWzIA6P91QXfIb3XIc7KyM/6M0PxGGHAoLGVvHBnQ3ywcmpTuQ6ugEB2Vs5v7JsW4SYt3wWyUhEPBtI3Iw5Zb25aKv5eVUV7vhoWm8nHt0KDIkK9iOKvzqt/DJAeP+l12b7b+ceOI77ipQb1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x+VEU+E5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61814249649so54890947b3.3
        for <linux-rdma@vger.kernel.org>; Wed, 10 Apr 2024 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712775909; x=1713380709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NUsqaY3FlD+Zy5gL3/6y26rsQKtdUSDBl6T6cUgvwGY=;
        b=x+VEU+E5c4GbDaPYaNdZcxDOslPEALGSRJLuem9mUjVeMcSNBLP3ASaxZPQqQ5XUQZ
         GZMXRyCkhx2ZoxxyRLPMKrCqPZ+3yvuZEPa5AUd/6FJ8/yzq1XcF4hnROHBlxlK7Vgcx
         2pyZa2zNev3R91omeeXv2aO0gV3B/NJBobuMHBIRA1cVejh4jjPsHoitvpHL3Zd/40WE
         8JXRx0qZSqdCyEyWcppCQJYcHhwxeQ66pzqYrqYfjyIhXJ7KWt3JYnWgKWiEzv/g1wpN
         95gbBhqfIKateV6/hlTY1IgJOxtlJjoG83yPoufIOVhEi2xSPNNRakvoMC/x0k8EFMCl
         OBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775909; x=1713380709;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUsqaY3FlD+Zy5gL3/6y26rsQKtdUSDBl6T6cUgvwGY=;
        b=jV5ZMXslkykXZXR7YtNBC2himHGUt8s5Suf/jYMTYehyyRi7cRHm8mONKvrRY84WBM
         7ATvx/KexXU1CmNxpMHgOvyxZzUYMIznp7ERQ3YdZLx1xw0hliBdEkTRz6pPgLc/QyvG
         /LOIlmOtD6S4K/8ZnOHKdPE+o8TZPLabD9waH5Qb4jM6Vg3LynOeGYqOqhdU2uCpvhBV
         ZzndttobvNadw16z77vVghEteqOfdzTEJG7XPzU4cA46zZSzClWPj1nQm76f4OMem0uU
         NkhPsm7/HFEKWaFNYEf7GFKV/kIE+ajqMo+ETiE9ZPyMMT8r5b8mli+PzB6V4hSZsVBC
         TtJg==
X-Forwarded-Encrypted: i=1; AJvYcCVfbebj1ksvI6QXosUgaCLutmMV7lVbRjxCVXLr9ZuizXWZmwJQhoRHEuQm3VXp3lG3Gk4BcmzrCkpSKcC1pDGYnUBih2hbri60Rg==
X-Gm-Message-State: AOJu0YxyBiPxkQTGZYJEwIh+wE4AJNDmWnM8el8inNMTbXagJJeiqHvz
	gtLaj1RDPV9FIJVY++MoRJiwhzuGwjuQdGrBaFpgAf6TMEM6NWw0LzEZzH12CjJj5TimPd4orLx
	DWHOlg3i3h3/cj/KSfC+/Sg==
X-Google-Smtp-Source: AGHT+IEqVOgcwBysoxKVNXvqkW6QcqgDsjz5wi5Y/eDCWWMsTGxmIgG0Wg30HM+okFcwb6g2q2KBLiBBmJSIPM1hCA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:21f0:1a3a:493e:cf21])
 (user=almasrymina job=sendgmr) by 2002:a5b:34e:0:b0:dc7:4af0:8c6c with SMTP
 id q14-20020a5b034e000000b00dc74af08c6cmr344899ybp.6.1712775908813; Wed, 10
 Apr 2024 12:05:08 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:05:00 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410190505.1225848-1-almasrymina@google.com>
Subject: [PATCH net-next v6 0/2] Minor cleanups to skb frag ref/unref
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

v6:
- Rebased on top of net-next; dropped the merged patches.
- Move skb ref helpers to a new header file. (Jakub).

v5:
- Applied feedback from Eric to inline napi_pp_get_page().
- Applied Reviewed-By's.

v4:
- Rebased to net-next.
- Clarified skb_shift() code change in commit message.
- Use skb->pp_recycle in a couple of places where I previously hardcoded
  'false'.

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


Mina Almasry (2):
  net: move skb ref helpers to new header
  net: mirror skb frag ref/unref helpers

 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |   3 +-
 drivers/net/ethernet/marvell/sky2.c           |   1 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |   1 +
 drivers/net/ethernet/sun/cassini.c            |   5 +-
 drivers/net/veth.c                            |   3 +-
 drivers/net/xen-netback/netback.c             |   1 +
 include/linux/skbuff.h                        |  63 -----------
 include/linux/skbuff_ref.h                    | 106 ++++++++++++++++++
 net/core/gro.c                                |   1 +
 net/core/skbuff.c                             |  47 +-------
 net/ipv4/esp4.c                               |   1 +
 net/ipv4/tcp_output.c                         |   1 +
 net/ipv6/esp6.c                               |   1 +
 net/tls/tls_device.c                          |   1 +
 net/tls/tls_device_fallback.c                 |   3 +-
 net/tls/tls_strp.c                            |   1 +
 16 files changed, 129 insertions(+), 110 deletions(-)
 create mode 100644 include/linux/skbuff_ref.h

-- 
2.44.0.478.gd926399ef9-goog


