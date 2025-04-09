Return-Path: <linux-rdma+bounces-9289-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D897DA82283
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 12:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2521BA6882
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A935D25DCFB;
	Wed,  9 Apr 2025 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="To1jdHyr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A611DDC23
	for <linux-rdma@vger.kernel.org>; Wed,  9 Apr 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195313; cv=none; b=TI/cR6dkZ6H6iW6NQV5ysGE6U1Jnwa2DW5broQohuRopUnkfvPadlBRSKhSni3VPQkRzhx2nptxF/ffZV2JKcmtNO0gtGgSDy0D6ngge9qJGWVD8JY7s8AkYaw7cMxTqQ8zBrwsJ+ZKMNe+IuEHsOeaBCYX+xZ12F0KnPDOb8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195313; c=relaxed/simple;
	bh=OBCGUM8pT3sZOcUuRrnbvkIPjJF6ocXQKcWpUZ57HEY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JE6aNWycYePLxQXTZ1HH5vsY8A28EVm2OGpm7VyA7rKcWt6eP67zVYlUkuJd62g0MFggMawqXnKK/zz1UQgrFWOqb955MxXTBqfedJ38iGIReA4RbRcYYDyWHUaDJ/DcxU3pevduFxQD4aN6Yfs/Tur3GoD/JPI/KXbCrteQkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=To1jdHyr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744195310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LpuNjoUA7ewskiik1/U0SdrDhmNSPkv3veZPCKfxTj8=;
	b=To1jdHyrQdU1yWgB7/p2IQTz9QiioKNufF5pGDAQiMGJIaUTHVKNeMp04rx/Yp2ZvgbKRV
	F/2mSqOVln1l8Z4qt7o1Y1/Fo4837SnkttXBtTsIbL0q5ZClNsA3ZVUUmJQMZL0g0mJr+d
	rBUVfOBrUpX1Yt06ovXDGAjspLuSmVQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-46U_BmMxPQe-IXizPkesYg-1; Wed, 09 Apr 2025 06:41:44 -0400
X-MC-Unique: 46U_BmMxPQe-IXizPkesYg-1
X-Mimecast-MFC-AGG-ID: 46U_BmMxPQe-IXizPkesYg_1744195303
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e5c03580aaso5118839a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 09 Apr 2025 03:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744195303; x=1744800103;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpuNjoUA7ewskiik1/U0SdrDhmNSPkv3veZPCKfxTj8=;
        b=cEcTbE4GszG2yaqk+ygAbvTBjxgrI4er2hJkKMf2pc4yt9wRJqBArDAWF2F5TLKWxC
         rVzNUp27REvHvezNSb0e8kOTPVE5E47OG6r9q+w8s4YYl4i5k7cmvunsyvHaf3iIZByB
         /X5XunJtH3fbrTk3NdJkltGe66NHsqMrSxIr+EaT/+/5kwZhaKgPqh0XOS3iJlNa12cO
         eAboChvTQ2q2AvY4uIIS6+Ll23ZtV9O7/diXIVooGCHp/m+uO3MaKDDwME8JFn4i7QdS
         DTc7uUyNw1PyehgoQ1oix6zocLiW3XdN8a9UOcreAUEaroXccM07MATR/5gMnQyt+2Vq
         eOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl9AZN6l7dwaMbVqg4ZnpBIWPnC9Vvt+EaQpij+yX3zIkvcae5z6Tss/r6Nql2fpKRCI8/mRXW4kth@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8r7GcUV+QgaMkp6XWcWtn7Yl+g48rwDfsW0CzYlJ/XwKgQbt
	U86mn+cCJZ+MNEbKzJhz5yekgkTimaVtsD26V/WGVyZusDyz5XP3XNLIhPAXr5B/ClC+E1jUvMA
	TLd/9UbPTs6IOligTH/3e6ZwC6Jz2L+kkiM+bdYRs9n3MXzMnQEhdvUXiHhk=
X-Gm-Gg: ASbGncuscRn3cXP1YsAnPb3rLTEyJ8MV4i6IYtRv5lLPVKOJ8l0ZygMNhEdpPuNSwW8
	ADsie+/ZpYpg4tPNBjI6BaxtxkjhlbkSY2W1AwmVdge96uuGID2p3D2+xXbuToIUdhrNBshY2Wy
	/69j+DFwhiHL+X7+6227qprRS4zumdmERXa4SjluRMXQQ1QW77XaKNa3XtvaqmBmgAEcMSrESYu
	OtQXwwBBxmfCTZsG3j5kloIB3usoXUF9xLwYi05x+wmDMXduoguZps7dumMk76Y4UZFsfXNSB7J
	Rsr0vcu+
X-Received: by 2002:a05:6402:90e:b0:5f0:d895:9c16 with SMTP id 4fb4d7f45d1cf-5f2f77444d9mr1595787a12.21.1744195303133;
        Wed, 09 Apr 2025 03:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK3hVFyQkZt6pmA7KrzZ08m5M0tMwNnqzTUTsrF571Pe0wCk5dz+6BE6jOFe9oes5irlIvjg==
X-Received: by 2002:a05:6402:90e:b0:5f0:d895:9c16 with SMTP id 4fb4d7f45d1cf-5f2f77444d9mr1595757a12.21.1744195302653;
        Wed, 09 Apr 2025 03:41:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f2fbbac634sm587689a12.12.2025.04.09.03.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:41:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9AFAF19920AF; Wed, 09 Apr 2025 12:41:40 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v9 0/2] Fix late DMA unmap crash for page pool
Date: Wed, 09 Apr 2025 12:41:35 +0200
Message-Id: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN9O9mcC/3XRzWrDMAwA4FcpPs9DtuWf9LT3GDsotrKGrUlJQ
 ugoffdpYbCMpEdZ6NOPb2rkoeVRHQ83NfDcjm3fSVA9HVQ+UffOui0SKwvWgzOgLyRvl77/1NN
 A+UOXM2lwzjp0hAFYSeVl4Ka9Luqr6njSHV8n9SaZUztO/fC1tJvNkv+VcVeejQadrbHsI0XM9
 mXgcqLpOffnBZztCrF+H7GCGOO4zqbC0LgN4tZI2EecIIkxIJjAQHmD4BqJ+wgKUrsEJYcIocA
 G8Wsk7SNeEO8BLDUhOSobJPwhMu0+En7WqZPDiClCwQ0S18iD34mCUHHYQKjkuGmDpDXy4CZJk
 EKVLFSwJmv+Iff7/RvIR7LDpAIAAA==
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
submitted by Yunsheng Lin, most recently in [1]. The first commit just
wraps some tests in a helper function, in preparation of the main change
in patch 2. See the commit message of patch 2 for the details.

-Toke

[0] https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
[1] https://lore.kernel.org/r/20250307092356.638242-1-linyunsheng@huawei.com

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Changes in v9:
- Remove empty lines left over in patch 1
- Link to v8: https://lore.kernel.org/r/20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com

Changes in v8:
- Move defines to mm.h
- Keep pp->dma_sync as 1-bit wide
- Unset pp->dma_addr on id alloc failure
- Rebase on -rc1
- Link to v7: https://lore.kernel.org/r/20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com

Changes in v7:
- Change WARN_ON logic if xarray alloc fails
- Don't leak xarray ID if page_pool_set_dma_addr_netmem() fails
- Unconditionally init xarray in page_pool_init()
- Rebase on current net-next
- Link to v6: https://lore.kernel.org/r/20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com

Changes in v6:
- Add READ_ONCE() around both reads of pp->dma_sync
- Link to v5: https://lore.kernel.org/r/20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com

Changes in v5:
- Dereferencing pp->p.dev if pp->pma_sync is unset could lead to a
  crash, so make sure we don't do that.
- With the change above, patch 2 was just changing a single field, so
  squash it into patch 3
- Link to v4: https://lore.kernel.org/r/20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com

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
Toke Høiland-Jørgensen (2):
      page_pool: Move pp_magic check into helper functions
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool

 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 +-
 include/linux/mm.h                               | 58 +++++++++++++++++
 include/linux/poison.h                           |  4 ++
 include/net/page_pool/types.h                    |  6 ++
 mm/page_alloc.c                                  |  8 +--
 net/core/netmem_priv.h                           | 33 +++++++++-
 net/core/page_pool.c                             | 81 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 9 files changed, 176 insertions(+), 38 deletions(-)
---
base-commit: 420aabef3ab5fa743afb4d3d391f03ef0e777ca8
change-id: 20250310-page-pool-track-dma-0332343a460e


