Return-Path: <linux-rdma+bounces-2459-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A799C8C45FF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 19:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304CC28271A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB2B22612;
	Mon, 13 May 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IUK7X2dZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961FA20DCB
	for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621358; cv=none; b=Ooxg+Ry3eAo1T6WWPfCTsxwTq289EsyEyrGwdsAPPKacj0oyfl5OZvicpVbpaFqZHkNGALHh9FeEC8nuv4bVl6tKDiTz8QknTe31ThzkFg/fbBll8EBVnOzNRZD7mu2/Q2sZBv7NH/1MegrpE9gUI1R7SgC2KDohPVJwpe0243Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621358; c=relaxed/simple;
	bh=pN6O9RfjQ/FO5k/EWvMYOp58I4huXHdbGsUOz2JADDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PUHVtIjgkvGSFD2Yf9twOt9xswgZKEXrOe2Yy+ejrOoki0biTDPp2jt+jAWg17PkBBvkRjgwij1MGmL6wob2r9hbpo+tw2I4aRkqSCkGgDxqHaAIhiOe8S2EKr/WQqwivrNCLDEmIyeHXhxpofl7cu1hNPi+5qQE1fcy5XlC/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IUK7X2dZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee12baa01cso38009235ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715621356; x=1716226156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=twgvuS/AqKd4scTz7PH+7RQVZvRlqUMOD6Y6dp77Dms=;
        b=IUK7X2dZGWd0C5bc+rw3tZtRurtAb0tAW4D8R2sBamiyVza1VR3AHJrM82nRwlKW31
         w7YhfGZk+VpKieSjHAYe/lhgdHaQMQFAs5lxssNNc5DN6ygBPr6JcWRca/z6ObNxBrEc
         hz70Eb4y0N9XHMc8ImTpwpF+sm7SnIg7R9vew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621356; x=1716226156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twgvuS/AqKd4scTz7PH+7RQVZvRlqUMOD6Y6dp77Dms=;
        b=B9ADj6cA9u8svhmaADfNERQ10cEYX8gLZle+0CP7NeZmAYjDe+S+N+HL4eYm06Slne
         vpLdz0KkfwE+AHmDOt4+kjmeIlq991Zz4GzkhKeqUPGE1KIUpjoODdEx/fzkf/vV1pvY
         tT53fJ91ir+Cv9beUUAgbjy0kdfw+dvk1Gfndb/kTgyzk/HKYweb3qoWftR0JxRp+o4A
         H1ysTj+gXy2v7Z42IqX6MnRcQP588zVs/FxN2BoYfDVniD+IPKWGFs9QD2QjZLgNxCbv
         dq/cq722i9iFJafDCesw7VqxiPCGaxG2DTg+YkBLwkE2w7MpegoRHJ9/nrDtYUp39J5t
         fWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQp5tiijBS28iPqXdyMWAZOIssTY+zu82RgKn+/pn+0wBj0cspIzp89gpX0PNzIApdqPDECYkMG+OnIHjHTLimYEcmRCenKKvp6A==
X-Gm-Message-State: AOJu0Ywbaba4WOK6qV6owS6/ei5aCjnJUyoSgtRRY2RBkAPdqxmkzX//
	L+sspKEF6bgYd77s4y8Qrzyhj0l8cIkDbY6D+ZxGIRSAY3kDUqZE1AlDDjvvbXk=
X-Google-Smtp-Source: AGHT+IF1KOi9NoWRwBo6ktLp7HEDT+ysiiT2vuIUD8jN9HNskgTpIC61bmV+hGgRrfJOid6rrz8zBw==
X-Received: by 2002:a17:902:c1cc:b0:1ee:b25c:1a8 with SMTP id d9443c01a7336-1ef43f4d1d5mr101159345ad.47.1715621355764;
        Mon, 13 May 2024 10:29:15 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1663sm81948995ad.6.2024.05.13.10.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:29:15 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/3] mlx4: Add support for netdev-genl API
Date: Mon, 13 May 2024 17:29:05 +0000
Message-Id: <20240513172909.473066-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v5.

Only very minor change to v4, see changelog below.

This series adds support to mlx4 for the netdev-genl API which makes it
much easier for users and user programs to map NAPI IDs back to
ifindexes, queues, and IRQs. This is extremely useful for a number of
use cases, including epoll-based busy poll.

In addition, this series includes a patch to generate per-queue
statistics using the netlink API, as well.

To facilitate the stats, patch 1/3 adds a field "alloc_fail" to the ring
structure. This is incremented by the driver in an appropriate place and
used in patch 3/3 as alloc_fail.

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

v5 was not retested as the change to patch 1/3 was very minor.

[1]: https://dl.acm.org/doi/pdf/10.1145/3626780
[2]: https://lore.kernel.org/lkml/20240423175718.4ad4dc5a@kernel.org/

Thanks,
Joe

v4 -> v5:
 - Patch 1/3: Reset mlx4_en_rx_ring field alloc_fail to 0 in
   mlx4_en_clear_stats.

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
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 74 +++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  2 +
 4 files changed, 93 insertions(+), 1 deletion(-)

-- 
2.25.1


