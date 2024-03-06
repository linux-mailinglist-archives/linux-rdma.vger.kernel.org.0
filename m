Return-Path: <linux-rdma+bounces-1302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0388744D1
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 00:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C724284742
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Mar 2024 23:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D47E1CD04;
	Wed,  6 Mar 2024 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJ6Lqnat"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF931CAA1
	for <linux-rdma@vger.kernel.org>; Wed,  6 Mar 2024 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769569; cv=none; b=XZFHOusoSKnossABYBIHrGvxt6yTrz1cuNtx8MksHbLaGrYMJY4gOhQ9Z2ps4/fHN0z0BhrlTKLOlWZidEgtX2a+bzC+C00ME3KvM/UbEimCb+/Z32NB+VkDfjtuMVvH9eNBB+pPOWhmyYfXfg2u2Wx6O3xbazEfKxfobpCMF7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769569; c=relaxed/simple;
	bh=uwk2ahz3j3nCNSoiWAgNLzF3crn2cMJrLrVycgFVLC4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mPWvxrF2mm1P93lqDny57Ll5OwF7sL+PwdyXJMRX3oO1I6Nasuv4s5o7eOwykQyJ1dTbfn0yTuL6ydnmq7BeeZkWTVUV0LIX9KIt1+BVEV30YsT7CHTefba9OOhTg8AZeQIDZwy0cPwi7NYxhTcSUGQr34MDphTzt0VuCyWiTDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJ6Lqnat; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609e89e9ca8so5317017b3.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 Mar 2024 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709769566; x=1710374366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NkZW2ptiTvn4uJjuK6pXF9K7rZKuDbfhR4CUsK2zUgQ=;
        b=HJ6LqnatrgTNx8gURMkSnZ+z+6b37qOPLz2XH+Mw8E9WJRwuD0197pOt1tVA/k7W4n
         +FgZYri4qMrxiOSQSLiza9Hn50ow2HiWzv6Myd4gfOMCmY0QzKe3aMhPWXzd+pEmJOHD
         cVhLZ10J5praDKgc278HiXlOpzfTHevrSWX0SdwiMW7xJF65sM8++qTciJSNT8ynGS+8
         syQ7DM87Vmmb2r98XgtYo11/2M/4pEMk63ikYG/sUIrei4HHiAhCbwNuxN/0phoifEuz
         TodGSioYzwxceAhVKjQxdYfB4k7/50gTb84nvvizxHPOfr3kk/eipxmv/tpCgfQoWtaW
         sMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769566; x=1710374366;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkZW2ptiTvn4uJjuK6pXF9K7rZKuDbfhR4CUsK2zUgQ=;
        b=XASy3Y+NJtWAihpefOiUqrAxukt9I88F1DBHTSxWGkkpcpMQtKx4lHrZXJn/IbEY9+
         YKsMaNoQ6/8cE1ub5qxIdycsBM4qA2nnbf/5HOUBWKwP7awtfoCWzXSJVDOTqfSh9Hp2
         NtlBfnCgkazwnGNK7Txx+P7fAEJPrcIY9gJjfsjmvFjXJDxHIULNrVgndAQBWC5Z2P2e
         ygOY7G85wqV6KawDbOJLLboC/oLF3C1Pd97sahf0Nn4mJzpUQfJ0KWo2oJ8Z6M1ODubp
         /hLoEEUI00Ihpx8gUb9kOmzl7WAXkDQ1b7utK9KZo3bGGS1SwxTIwrB3B/aAw1WWzSsf
         joPg==
X-Forwarded-Encrypted: i=1; AJvYcCWutL0A2kPin+gGaeTFiMsUMPWNdmuhDzmW8zL1260wFCAtr/SB7YX/e4NCJSH7qyGlare9AaTs8G4/AcxFjfvgHaO2WcAsy6wngw==
X-Gm-Message-State: AOJu0Yzi5eOZNHNSPLO8R1XKLXefQjdIkgvAfSVQf0UN54X+6yaUdytT
	OPqEo1IY7slEZzUPT7/YnF0JG/AeMFQcsJ8WaVe8120HtR/PsqNOuF0G/qXfkUlb/mQCG0USSUW
	qu4Byt2Sg7ouN0XErGaEoDg==
X-Google-Smtp-Source: AGHT+IHUihCzETvNdLP/gwG1C1yCXXXKV4Mr+NDAUX//1QucYmnF2QH48UYNrIxzNiW4HUIl9tfQ6FznsThujGuW1w==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:daeb:5bc6:353c:6d72])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:c17:b0:608:8773:85da with
 SMTP id cl23-20020a05690c0c1700b00608877385damr4107511ywb.0.1709769566467;
 Wed, 06 Mar 2024 15:59:26 -0800 (PST)
Date: Wed,  6 Mar 2024 15:59:18 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306235922.282781-1-almasrymina@google.com>
Subject: [RFC PATCH net-next v1 0/2] Minor cleanups to skb frag ref/unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Mirko Lindner <mlindner@marvell.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

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
  net: mirror skb frag ref/unref helpers
  net: remove napi_frag_[un]ref

 drivers/net/ethernet/marvell/sky2.c        |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |  2 +-
 include/linux/skbuff.h                     | 45 +++++++++-------
 net/core/skbuff.c                          | 60 ++++++++--------------
 net/tls/tls_device.c                       |  2 +-
 net/tls/tls_strp.c                         |  2 +-
 6 files changed, 51 insertions(+), 62 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


