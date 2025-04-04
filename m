Return-Path: <linux-rdma+bounces-9150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F6A7BA8F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 12:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD058189E404
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB911CDFAC;
	Fri,  4 Apr 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2RXwUQn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB619EED2
	for <linux-rdma@vger.kernel.org>; Fri,  4 Apr 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761934; cv=none; b=Ij+BzoRvGLPAQ3/H5aA+QPFJFTJ8/DNaLgemP2wqUwVuaVZJYNXb0+C3/RQ0dSIBoNb4kuJdkdcTKoZP62ZIOkJDaiPqmu980z4uvP3rVfPgvuQ1cSEK6gfYC3oz2jT0bvnW2TiI03/0OCZzE8sYqKIpUaaZPsl703/kOoHSajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761934; c=relaxed/simple;
	bh=LXZ9/vk+POSfcKSx9sqdr7qvqqBdI7C6a+Nl5sTnVg4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O9tyclysnPvCNggF4BWaSDlcy+1EKelUyKTmrBCivWzIH6cIPBnWf+tj1zwUIuiB1AH8QdIM3R5BbHwbs94XBQo6mDH/f/duCK/dOrzrgKmrHqZSZE02LSAnf6aFcHhYTSly5lUzNiVzhWofCXz0QGxePI3WkG17fFfMis3ElyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2RXwUQn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743761930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5M+rOyW1P59pNZ57TipRkSHKMefjk2AQHbLsm27xPvw=;
	b=X2RXwUQnnrVC9WZwumj+Pb8/Vu8CReIrVdPmVGRBI6gjAZdPmYCXqEfSsbcZKz42h137vP
	sbP9vBGO9r94IMPpzy7cT8yusEBJLUv9iSo87OWwl02H1kogrDydGobmjuUP3353KOQpvB
	ZZ0+rYMFekxXbLZDjyCp1SLOwMpJeIQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-H62Ce_eLM9qZ9yzSZ_Bk4Q-1; Fri, 04 Apr 2025 06:18:49 -0400
X-MC-Unique: H62Ce_eLM9qZ9yzSZ_Bk4Q-1
X-Mimecast-MFC-AGG-ID: H62Ce_eLM9qZ9yzSZ_Bk4Q_1743761928
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30bf647866aso8741441fa.1
        for <linux-rdma@vger.kernel.org>; Fri, 04 Apr 2025 03:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743761928; x=1744366728;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5M+rOyW1P59pNZ57TipRkSHKMefjk2AQHbLsm27xPvw=;
        b=l65XwhxaFE/jyTBUnFsi1X1ga1AppxokVSkgyutzuXw2heOfwhIcmboSMnh+sKyGgF
         J8WgJr3vpIZhmL9gSxd1mFxITffO1svZQosDtjg8q4jGiCcSNnTTXc2siVbTN3BjB7lw
         8k4SGMdP7ZhfiK23zdruAOlqdnIeufRz1H/uEuVxLz7VtnHV0luJzuXZj5UYl4qjKNxN
         U4l1ClFHfrsRufisF05D9DCl0UCYI/jczRugcrGn6ILnYS9E7CeNFQPPsYF3UiiYn+S0
         qZwC5wDjtsSBt4kS2N7zVeBkxYu5TyguGbyBSLtqbPzsPF4o8shPUHOneeDjGqZek8sv
         ndNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgNWGgK/P/jhZz9E0UeKgOHSkRfERTulG6nkuYYxYwM+C9eBGdql7ACqPHsYfj6f3go+tUP8+YoSUJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzImHni8dN5hMcjO1ACS+XDe/+K/iU1hdV07vVRh8BafX05VFUh
	83KBZxxtAK+02CgwakJWKdG285Ty0+lQdC8IZlqRiGwd2/ZIkPVZHuXYUhiCE2MMv4+wrYL4oi+
	9RdAdcZnFnYCcbXpvvBy8eUhvywb0rLhasVgcq+loOvhYfhwTi1o3klU8L00=
X-Gm-Gg: ASbGncsJpktTECJqvP1TTXvriKgix3HBU+Xf3JLWRPLdXR01FNwc0sST3BUO8Uv34Oa
	uMntDUdZvzItQtq0O8gYJlngneiBe6n4fFm8WiSo1axhDN7F/tsm003KWYaWMAGEQ/KAlGzlF6x
	btO3QLRNpL+BKBec72cPBconGF6Th6buhTP8uFR3+uGA+N7svOL6AN9snGx2iDggIzG+5y6EdoE
	6ZxxjhrQB7QnUDKbCxvxHfRp9fC9EQoGeZg/sXrv3wWhfURS4nM85h4HKGO8dIDOrJA6kaqwBq/
	p+em7RFComp3PrgEm0KofB03UavXwRoFvmNFLm2c
X-Received: by 2002:a2e:a5c9:0:b0:30b:fdc0:5e5d with SMTP id 38308e7fff4ca-30f0a0ee84emr8785121fa.4.1743761927634;
        Fri, 04 Apr 2025 03:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUiX5YdBxTzl44jWDQITU1CT7/li+YPbg+WN6Bv/W9Q984Oh34yiDzKProh3dcMOWAJ4tAlQ==
X-Received: by 2002:a2e:a5c9:0:b0:30b:fdc0:5e5d with SMTP id 38308e7fff4ca-30f0a0ee84emr8784931fa.4.1743761927260;
        Fri, 04 Apr 2025 03:18:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f031ce997sm4982351fa.92.2025.04.04.03.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 03:18:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8A14B18FD725; Fri, 04 Apr 2025 12:18:44 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v7 0/2] Fix late DMA unmap crash for page pool
Date: Fri, 04 Apr 2025 12:18:34 +0200
Message-Id: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPqx72cC/23P0U6FMAwG4Fc52bUz3dpt6JXvYbwYW5FFD5BBy
 DEnvLuTmIhhl+2ffm3vYuaceBbPl7vIvKY5jUMp3MNFhN4P7yxTLLXQoA2gAjn50pvG8VMu2Yc
 PGa9eAqJGQk8WWJTJKXOXbrv6KgZe5MC3RbyVpE/zMuavfd2q9vxXpqq8KgkyaKXZOO8o6JfMs
 ffLYxivO7jqA6JNHdEFUQq5DeqJbIcnBI+IrSNYkIbJEijL4MMJoSPi6ggVpMUGYrAObIQTYo5
 IU0dMQYwB0L6zDfp4QuwfUq6tI/bnnbZBctQ4iPQP2bbtGyKAyvkaAgAA
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
 include/linux/poison.h                           |  4 ++
 include/net/page_pool/types.h                    | 63 +++++++++++++++++-
 mm/page_alloc.c                                  |  9 +--
 net/core/netmem_priv.h                           | 33 +++++++++-
 net/core/page_pool.c                             | 81 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 8 files changed, 175 insertions(+), 39 deletions(-)
---
base-commit: acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1
change-id: 20250310-page-pool-track-dma-0332343a460e


