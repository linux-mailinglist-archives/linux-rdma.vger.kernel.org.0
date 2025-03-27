Return-Path: <linux-rdma+bounces-9004-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A57A72E07
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 11:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC1C189A71E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D7E211261;
	Thu, 27 Mar 2025 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSMGnTZ9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8120E310
	for <linux-rdma@vger.kernel.org>; Thu, 27 Mar 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072279; cv=none; b=fNgY/yS5t1/TP9up523h5TlBWZt9ZLZE/gfaAk7IgfTDpBrp4v7TaKtFvvvP/tVSQCuU8DDx0543e85EzGLhgqkOxy+puqW04SHEYiNJPsbAyuZbO6E8jpNqHexjuelNdg+psaEGjb+7sEjSshc8xAc85/3HDva7peLYTQmBVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072279; c=relaxed/simple;
	bh=Z1z2oQX6GVOmFSouXE51dlABKEyLBAbiPyOzdqPu3W8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ce2b0HM2tRA0a4J0gzOmjpkFy1h3fA0dndFLFvmX8fKBuwJCdywMOreT8RtHO39L4joVwhmPo4opjSBTwY5HlcgoKv2o6F3L9SACSc04UA0zTP/t1yJojVw7N1MaanuWjU1ulksSdWjYx8upK0c/jI7PWXmC2UOl8p/KkUEDOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSMGnTZ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743072275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WyWvRzluSiEXBBT2a7VCBlnyJ21GZtU6y+n9uBuHn7I=;
	b=CSMGnTZ9VuyQ76IDRW7vUBrpvzB0h+6iV9Rrkr3vmJvZrGNS5X1mdfnpqCmCTcZs0q8lIU
	QCmvAd0iRAniHsKi2c7bB2dMFCFWYXAYhPZ/jRXGMcTPCu2vuFc5TkqXcZ8AhuhcNoSOGF
	HjS2z7GkF8jEL9zGrEAytN92pcA5nn0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-X6EP2jwAPjy5K9F5ruezuA-1; Thu, 27 Mar 2025 06:44:34 -0400
X-MC-Unique: X6EP2jwAPjy5K9F5ruezuA-1
X-Mimecast-MFC-AGG-ID: X6EP2jwAPjy5K9F5ruezuA_1743072273
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e5d8a28de7so922483a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Mar 2025 03:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743072273; x=1743677073;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyWvRzluSiEXBBT2a7VCBlnyJ21GZtU6y+n9uBuHn7I=;
        b=j4FMF0VgxZopbF4oirk0SoA6gyS77PAJE5ztASkYQpfVRHifHF/5hjAFO7p8GBll+7
         CKtNTqAwcUbsVHT4TiP6pw+gO0q0+bvQkEUDC2qMYBEroJvG0i37Zgoxb+SuByEOJIPL
         ah76Y/9aVpRlNj5HUzNNy8DEziyfEhfa8yL+gcvrd8CN1dFnoesV6dcoqrud6kxj5w/k
         +2bdxEo1fKOZx5XZQw/E3RL52kVFzD1gbTUv9ZpN0O/3VL0oHQhkm7tY7Jizyz3n4GSs
         eDetdV/9p6kMjc3h4ppAfAkryh+5sPN6XgXUe9dTJZtMviMTUOQnhqTtHWOU9Bm0yusU
         UkDA==
X-Forwarded-Encrypted: i=1; AJvYcCX3BOemHFSNO8fThslI68qgdwOAnNHmZZAR7IyBW6Q6k2rvMEvwql6len/5pkXx4c/8NmNJ2kmx+znW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdp5r4jdQQiIapnZ7bv09VCHw88NiGI9CzO31UDziCWZ04Ng/C
	qtYTNT/+iYRBruG8Xjr54sVIZENUl+tauPocgU/HMhL7/x2BhK6QUQv6nfx8JtdwvVy7HO8xbbA
	fXlKrB/en+74IKHe8pF5iUugIXpFwws5IA5VDcFvLlaSQ5QwJ9s/Cqhvs4U8=
X-Gm-Gg: ASbGncuXZ0BnH7kIGCcVn0dAk+7P0N3xdyYVQzVkoJXS0H1Tl+MN4m+bDUd0awkV224
	1yxFG2LPpJ7t3AUFVyVTyn6bhqUyNdPULobtJWuQR/GnTSqO4OJAJ34IaWQYRYtlW5COqm5Z6QK
	IHdZDhkoK3ccs14faIrPko0hy++fOiwwyRsdiXp56aICfe/HZQDSxGkP4qyGjrwz02MNtnc9w4E
	PpFKwqR48bD6TqliO9S6C+e+tfuejzgLT1G8C+DWpDpbzgvt4dpUEem2af10JdLqqX8RgQylxn8
	A+DqIq0huvbSYlRzCt9kCIQtSpVVkFMlEcvqTUL1
X-Received: by 2002:a05:6402:430c:b0:5ec:cc90:b126 with SMTP id 4fb4d7f45d1cf-5ed8e5a5d7dmr2920447a12.19.1743072272765;
        Thu, 27 Mar 2025 03:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxY9QVIO/VsgSyaKIBh62Jyrq8IaKt0cDmXoin9ToYvgK/LxQKcrJwZ0uLZmyq2x9mCaJPWQ==
X-Received: by 2002:a05:6402:430c:b0:5ec:cc90:b126 with SMTP id 4fb4d7f45d1cf-5ed8e5a5d7dmr2920405a12.19.1743072272282;
        Thu, 27 Mar 2025 03:44:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcce36d66sm10908646a12.0.2025.03.27.03.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:44:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AC5B618FCBF9; Thu, 27 Mar 2025 11:44:30 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v4 0/3] Fix late DMA unmap crash for page pool
Date: Thu, 27 Mar 2025 11:44:10 +0100
Message-Id: <20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPor5WcC/23NQQ6CMBAF0KuYrq1pZ0pRV97DuKhlkEZpSWkIh
 nB3G+ICI8s/P//NxHqKjnp23k0s0uB6F3wOar9jtjH+QdxVOTMQUAiUgncm37oQXjxFY5+8ag0
 XiIAKjdKCWF52kWo3LuqVeUrc05jYLTeN61OI7+XdIJf+K6tNeZBccAsSqChNqSxcIlWNSQcb2
 gUcYIVAsY1ARqREult5UrrGPwTXiN5GMCNHUloJqUkY+4PM8/wBzpEw+UsBAAA=
X-Change-ID: 20250310-page-pool-track-dma-0332343a460e
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Yonglong Liu <liuyonglong@huawei.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
X-Mailer: b4 0.14.2

This series fixes the late dma_unmap crash for page pool first reported
by Yonglong Liu in [0]. It is an alternative approach to the one
submitted by Yunsheng Lin, most recently in [1]. The first two commits
are small refactors of the page pool code, in preparation of the main
change in patch 3. See the commit message of patch 3 for the details.

-Toke

[0] https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
[1] https://lore.kernel.org/r/20250307092356.638242-1-linyunsheng@huawei.com

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Changes in v4:
- Rebase on net-next
- Collect tags
- Link to v3: https://lore.kernel.org/r/20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com

Changes in v3:
- Use a full-width bool for pp->dma_sync instead of a full unsigned
  long (in patch 2), and leave pp->dma_sync_cpu alone.

- Link to v2: https://lore.kernel.org/r/20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com

Changes in v2:
- Always leave two bits at the top of pp_magic as zero, instead of one

- Add an rcu_read_lock() around __page_pool_dma_sync_for_device()

- Add a comment in poison.h with a reference to the bitmask definition

- Add a longer description of the logic of the bitmask definitions to
  the comment in types.h, and a summary of the security implications of
  using the pp_magic field to the commit message of patch 3

- Collect Mina's Reviewed-by and Yonglong's Tested-by tags

- Link to v1: https://lore.kernel.org/r/20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com

---
Toke Høiland-Jørgensen (3):
      page_pool: Move pp_magic check into helper functions
      page_pool: Turn dma_sync into a full-width bool field
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool

 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 +-
 include/linux/poison.h                           |  4 ++
 include/net/page_pool/types.h                    | 65 ++++++++++++++++++-
 mm/page_alloc.c                                  |  9 +--
 net/core/netmem_priv.h                           | 33 +++++++++-
 net/core/page_pool.c                             | 81 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 8 files changed, 176 insertions(+), 40 deletions(-)
---
base-commit: 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
change-id: 20250310-page-pool-track-dma-0332343a460e


