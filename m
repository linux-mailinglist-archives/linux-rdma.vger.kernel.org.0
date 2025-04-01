Return-Path: <linux-rdma+bounces-9065-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19BA777B5
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 11:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8D23A5F63
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131701EF37E;
	Tue,  1 Apr 2025 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVL+6mIG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7D1EEA37
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499654; cv=none; b=Lz99bKmi6+k9HdfoI7bYT4P5rtjYlsoDj0GBcFijH1cOuKiiU93OTrQdb3h4qCt6ZwngJuRh1OVt9ahN8ItyEwrHX0zxPvzzIigQGiIEMxENttOkedgTWnHxwJ53w64adOaqDgi/0ES5BKGyYihUoOz5bdiQj+mNV+b3F4/lWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499654; c=relaxed/simple;
	bh=RVh2BP0zNXztVGW8aRee7AQCaUaVGwZPjcv6NQH5Dtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rMM1ynJuHcqTfPrwkjqohvP06uvNH7fNLCxGVzUf2R9JbTSwVe+z/5tkUmwArlrAM11OmkrKLLx2V7oAbpr1mAQi/Ab9u4Fgly62f7F/0CnilVkbRwMEpg8OJ+TolRcdulJf88SMZwHRuxAkGBIud5r8yyKuXZeBgVqjthrWlG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVL+6mIG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743499652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1ZiwmWlfT5msBPwsaS4TsFciafSUxtrnbKJoha2W67Q=;
	b=eVL+6mIGReCoPgzBn5hTHDZeYBH3jW4nPnKE9tqtQLVMEqhQcifEn7VbutSgBXVVVpW417
	e9BvdZp0x1R9SKGm4wHrGrM3B6MF24CcfzBWcVc4vvf4rN2A/vMuhwcP5O1+7SbbNU5W46
	CH+FgiIf7kzglfslwv5SSJ9cJShRA78=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-A7lh0ptiP3KVQm2FWPd64g-1; Tue, 01 Apr 2025 05:27:30 -0400
X-MC-Unique: A7lh0ptiP3KVQm2FWPd64g-1
X-Mimecast-MFC-AGG-ID: A7lh0ptiP3KVQm2FWPd64g_1743499650
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac287f28514so442869466b.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 02:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743499649; x=1744104449;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZiwmWlfT5msBPwsaS4TsFciafSUxtrnbKJoha2W67Q=;
        b=TPyvhaYgOD1F5d0vfeVwLJT2ssyMNJioXe1nzCtZedLyeEIg2zQCwpI7Lmj4z2DpXA
         C0In+KxZNG2LJXpjmbyG1LS5uESFBwd9h+gkxuSkHWNsgahugY/Eh746oiM/KokHmV0l
         +OCEMvqJpt0x5PM0W5GJ2wxHAFWzYEx5f3t/gdGWJtPQqSDWgVLlNi3ZPcMWJAtytfHb
         qgR341aVoPZaw3bLN3ZFQcEiWFOgdY97D5V5MoG9vsvhTSSGr7u9qffVpVo0mLpxIYQH
         hM09JbuLCxeEMc5FxZOZA8jZ4DTC3PAoKlP5n7sLxjic8E7ryN9uRzGFHpHhg3wQHmdm
         OrMA==
X-Forwarded-Encrypted: i=1; AJvYcCXRVheWqiCjB7w4HaeryGRZmv3h63Jp3FRdjmMLe4p6+YjEoku45ppbt+/lwco3OzuuSPePu/bu3N/E@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9trTuApVdl73l1EICksExSUE2ULqc/4FrUCslpcPlxumD98a+
	rCSQQMCPmn7htttxXOPV9IDYaNVfy1io6ZRmphJ/orN3AGu2cNCzMScNMqb+6aXz81dHF+1MQ0A
	AM9VVdyMGwwdgeeCRxj3sTauXLYiwK2FjE1GF5JFILMdInyX9176DNAx/SA8=
X-Gm-Gg: ASbGncuiu2978lhUvLam6JjEh0n2dkAWYUUdmEJKw7og91EYB44/iEVizSadzWB3ZQO
	dQhEUDeKFLbJ7UvuJ2pf+iB6E2tnkilLWzFGfC1YFc6X5G/beAbZayb1lhBEe0fOd1r4vqVgjtS
	Y/crem0KR8v6sP/EnJFPuysOIMR2F0iNNLXk2MpF6A6i46bzEHq/bAPYfKUjRvL0pLVHZ+/OR+5
	3XakmIa5LIsJKOrv/udZwseGRQCoHUnz9fdjcz/l9AmC+xpJVt/atbUP7n0aFsBVl+Bv+CapCyI
	SUr4U4O5CHhY
X-Received: by 2002:a05:6402:278f:b0:5e1:8604:9a2d with SMTP id 4fb4d7f45d1cf-5edfcc04fd5mr9820815a12.4.1743499649604;
        Tue, 01 Apr 2025 02:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUGsT6plXzO/A1LVcdoXRQcUcCcBW0zBrJ/EkRGpYDjtXu+hVn+0Ib/LtdHGE/4da71LQe5w==
X-Received: by 2002:a05:6402:278f:b0:5e1:8604:9a2d with SMTP id 4fb4d7f45d1cf-5edfcc04fd5mr9820775a12.4.1743499648927;
        Tue, 01 Apr 2025 02:27:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae2fsm6755282a12.4.2025.04.01.02.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 02:27:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 81DF318FD267; Tue, 01 Apr 2025 11:27:26 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v6 0/2] Fix late DMA unmap crash for page pool
Date: Tue, 01 Apr 2025 11:27:17 +0200
Message-Id: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHWx62cC/23NwU7EIBAG4FfZcBYzzACtnnwP44GFqSW6paGkW
 bPpu0saDzXl+M+f/5uHWDhHXsTr5SEyr3GJaarBPl2EH930yTKGmgUCGiAFcnb1Nqf0LUt2/ku
 Gm5NAhKTJaQss6nLOPMT7rr6LiYuc+F7ER23GuJSUf/Z3q9r7P1k35VVJkB4Vsulcpz2+ZQ6jK
 88+3XZwxQOCpo1gRZQivnr1ou1AJ4SOiG0jVJGetdWgLIPzJ0Qfka6N6IpcqYfgbQc2wAkxR6R
 vI6YixgCgG2xPLvxDtm37BdksqQjVAQAA
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
 net/core/page_pool.c                             | 82 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 8 files changed, 176 insertions(+), 39 deletions(-)
---
base-commit: 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
change-id: 20250310-page-pool-track-dma-0332343a460e


