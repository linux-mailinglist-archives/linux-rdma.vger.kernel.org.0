Return-Path: <linux-rdma+bounces-2375-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC08C17EA
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 22:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759431F21BE3
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE2884DF6;
	Thu,  9 May 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oDRxItNP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6DB38382
	for <linux-rdma@vger.kernel.org>; Thu,  9 May 2024 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287867; cv=none; b=JB9yT/dKZ6gdkSPgq3F8Zxko0rzAas1MyoH3j3bdKMq688IiG3hpa/MIcYFWNSWBToSoFtqXY5+0hiDO8uYWihxgmNNHkGKdl6eHpIvCk9nOmq886k4W3rOZJch6jsPi+g6UOBdCYKr28DvT988PjUQ1ZYAJIVM6IwGEa5p5Gvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287867; c=relaxed/simple;
	bh=ULvDOg8fzMreit7CsVIx5pIp0ST1oc4hCpoTX41YwQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eJbKQmU5N1gVStwpKS84zSMJCs+zYDxKtUw1ewQxi6OUTdh+XSH+2WKT4zvc2verqd0JbTbACoOPXKoyk+/P55rCM/CFjBZ33P1fOaZ7PL2+lIiqxW53nV2If0YzC8CrCqrt9c9NWsixbb6gPX5ZgGqP41aOhVG9S7wq60KSGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oDRxItNP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ed904c2280so8296735ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715287864; x=1715892664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WOWZIIxnPOq21znhA4s7gPvFpmBQHVTMtFbaXbcv/M=;
        b=oDRxItNPrZ55Izxu62VpTQCiNDFO/4B7qvA6h+lQfNTjdai/d1yAd+86+XOrImbTWm
         ytSGu+Q4ltJ7NdXmS4Zmd7m2ptz0NLG5j17mCNvxueDcMB4MVVb0cLxeKp2Qg7gcJITY
         FPcPutI/MxXMEJbvC21RVVZefSgnHQdUfqeXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715287864; x=1715892664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WOWZIIxnPOq21znhA4s7gPvFpmBQHVTMtFbaXbcv/M=;
        b=Y5nzmeHqW5jgnb7WxDs/FxTfwOarB6lQB5/foDUgMlQ1Q4QtktVksWCbfh2/W7KLje
         epxMd5TC37jC7kccPFrmfcrfw1AHwyGkr8hEGU21g1JaBSbUQvFkXckAi7Dqmk0jd9/e
         fuIbvKnBP9RTCrzGjQ7V0bvWbfZts/6gI6ilaEQr5rEGzTRZ/eIjf7FpiD3EuMzQGqtE
         ZR9bOn+oL2tKTI8uUHUP2SqSEas6tLrIhFN/bojvKXrLJCihBEsz+CoMLZxDlo6seTLv
         9mhSbK0AduUcRr4e3xOJO9vD4M/WWRYbyld7PukEdojSlgmat6kCayZexTjC/5gAfs74
         mYIw==
X-Forwarded-Encrypted: i=1; AJvYcCUVlI9f6nDC7g27choAHFDk/U2XlAO4Jo6JjrWnYU5G9vfZk3bus/0uxtIcvMFZ8B7D17aFI2yvrhpGwfqikoYYekrX209HFBs/sQ==
X-Gm-Message-State: AOJu0Yzt839Wh2ZtebLAs+ftXBXAF7+PWC471WOL124YrmKOmxlPmliy
	hIgswjr2J2/zPbAwdkYjs91g/rgXcFbSbY2XPlFSccdvlehm+cxwNB7QSGLd5qsgCHNfv+UIf2w
	3
X-Google-Smtp-Source: AGHT+IGHkpejsVXRV8ql1hyGhEzIcKTj2CVCTqG9GuqWnOnXiJfrIi5Kcqs9pXR36nwYHzVi95fM3Q==
X-Received: by 2002:a17:902:d483:b0:1ed:867:9ea0 with SMTP id d9443c01a7336-1ef4404a894mr8892845ad.57.1715287864055;
        Thu, 09 May 2024 13:51:04 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badb959sm18677365ad.85.2024.05.09.13.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 13:51:03 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	Paolo Abeni <pabeni@redhat.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next v4 0/3] mlx4: Add support for netdev-genl API
Date: Thu,  9 May 2024 20:50:53 +0000
Message-Id: <20240509205057.246191-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v4.

This series adds support to mlx4 for the netdev-genl API which makes it
much easier for users and user programs to map NAPI IDs back to
ifindexes, queues, and IRQs. This is extremely useful for a number of
use cases, including epoll-based busy poll.

In addition, this series includes a patch to generate per-queue
statistics using the netlink API, as well.

To facilitate the stats, patch 1/3 adds a field "alloc_fail" to the ring
structure.  incremented by the driver in an appropriate place and used
in patch 3/3 as alloc_fail.

Please note: I do not have access to mlx4 hardware, but I've been
working closely with Martin Karsten from University of Waterloo (CC'd)
who has very graciously tested my patches on their mlx4 hardware (hence
his Tested-by attribution in each commit). His latest research work is
particularly interesting [1] and this series helps to support that (and
future) work.

Martin re-test v4 using Jakub's suggested tool [2] and the
stats.pkt_byte_sum and stats.qstat_by_ifindex tests passed. He also
adjusted the queue count and re-ran test to confirm it still passed even
if the queue count was modified.

[1]: https://dl.acm.org/doi/pdf/10.1145/3626780
[2]: https://lore.kernel.org/lkml/20240423175718.4ad4dc5a@kernel.org/

Thanks,
Joe

v3 -> v4:
 - Patch 1/3: adds alloc_fail field to struct mlx4_en_rx_ring.
   Increments this new field (instead of dropped as in the last version)
   on ENOMEM in mlx4_en_alloc_frags.
 - Patch 2/3: No changes.
 - Patch 3/3:
   - Removed Jakub's Reviewed-by since some number of changes were made.
   - Removed checking the validity of 'i' from both
     mlx4_get_queue_stats_[rt]x as the core code will ensure i is valid
     for us.
   - stats->alloc_fail now uses the new field added in patch 1/3
     instead of dropped.

v2 -> v3:
 - Patch 1/3 no longer sets rx_missed_errors. dropped is still
   incremented on -ENOMEM, though, and reported as alloc_fail in the
   stats API introduced in patch 3/3.
 - Patch 2/3: Added Jakub's Acked-by to the commit message, no
   functional changes.
 - Patch 3/3: Added Jakub's Reviewed-by to the commit message, no
   functional changes.

v1 -> v2:
 - Patch 1/3 now initializes dropped to 0.
 - Patch 2/3 fix use of uninitialized qtype warning.
 - Patch 3/3 includes several changes:
   - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
     valid before proceeding.
   - All initialization to 0xff for stats fields has been omit. The
     network stack does this before calling into the driver functions, so
     I've adjusted the driver functions to only set values if there is
     data to set, leaving the network stack's 0xff in place if not.
   - mlx4_get_base_stats set all stat fields to 0 individually if there
     are RX and TX queues.


Joe Damato (3):
  net/mlx4: Track RX allocation failures in a stat
  net/mlx4: link NAPI instances to queues and IRQs
  net/mlx4: support per-queue statistics via netlink

 drivers/net/ethernet/mellanox/mlx4/en_cq.c    | 14 ++++
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 73 +++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  2 +
 4 files changed, 92 insertions(+), 1 deletion(-)

-- 
2.25.1


