Return-Path: <linux-rdma+bounces-2639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D1D8D2313
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 20:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F3328641B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 18:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE8C481DD;
	Tue, 28 May 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MpVdkp2P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC827481A3
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919908; cv=none; b=WfmgpPICF4iZj1v3nDQdQjhdNegWKZXkJ8aXCu35Uw1pAgpzDFcAzN9H+qQB/w4YKR4ZxOCEQ69fn1Mve+PJT7OWSkhuOxOGflp+RHxEqYYKG9zUdCHNrGZd6jsfwGky1gpY0t9ZAccg+FatUhE6pJfuoUWVs0RXEhbenx9MVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919908; c=relaxed/simple;
	bh=DxMmwuUCXezZFv+mb5iIiGAbotZICiMbVKYF2kKySd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bgNr7noizqhS1E239YtQdp7+rFfV0N/dXVqsUS3ho/TpRXerchEVouGsmVeusqbBDtHYGB+qcB1NqcY3Idmz2g2ZW6MzGY6ulZQkHVtL5j5bK+ZdV/kyowudpvkKgwVoGXYAqMR7UHpTccfkl6H58f1Wtpg50jAuSWcQ0Ref4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MpVdkp2P; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f8ec7e054dso777185b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1716919906; x=1717524706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HLTItsKb0gJ5n6w6HK2kWf2lGcmTvXrEj2hni93mCL4=;
        b=MpVdkp2PMi9XbdYl5pcV+2jB658QHpp/gpdlZ/s72IB9ehrlOVsougSJ15r4Tyl/Gz
         Gx+A1XGMOfKBb8rm3QHQPsdTKgSCAAa5FjZfvGLxe1SGg/kF1Uv5iNWL6VlyRa7evN7V
         hIYWw6ihw3BEyvrYl4pZ9dxSnB+sybM1wfT9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919906; x=1717524706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLTItsKb0gJ5n6w6HK2kWf2lGcmTvXrEj2hni93mCL4=;
        b=oUsiZId45Dxy7SJOCl1CRiDSWBUWHbhI0IqIWBeWs5egzFsJo7mNbXte/vp2rp9hU2
         GWugjhJI6etRag9WI8012d7i8a1P6crdQ+agAZ5cAGMx9VOMJ6Yi2Y5HjHy2hrzcGyKK
         xgk4qjNHJYdlZz/xRcC+WJ+1lpFU0zK25k+cInYr3RIprReBq0uERymDtl+Ib9xDWvnC
         VlrDqBBIYlorJeVCP5iTELcPZsoVmCC7neuySptsREWWi3XcW34CKCAeVzyAUYyowwOK
         0oQL4kydL8pDn6gmnDfMiYQJNghnrZPBJVaoOpQjjgsLdm4b5/ZeXXeFU6dbQN980bBY
         QbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbnPtBBED+utDYPcsTC2R/V6cNLgyDt9Qo3lHtI6PPGxi2MQjMFE5h5lTJN/Q39ad+zX+JQArEvViA4bGCEfTKuyWGYFSEjNZgwQ==
X-Gm-Message-State: AOJu0YyDDjcAZpl28jXMt/zSRoYyXWOB9qTBYD0QrXjhxNKxT5JDAmEA
	s4HgIhxChytZNwl1tZCOnYLhO8A7pLn5I0iQxxozS4IjhWFPQcsYL6SevFFaP78=
X-Google-Smtp-Source: AGHT+IHroYl1kMgMz1vNC7iYTcXtrmaW+NLvInRSueD42auS9hPkPrLcOB21aSPzlQJN/erZjerYZg==
X-Received: by 2002:a05:6a21:3a83:b0:1b0:1a02:4128 with SMTP id adf61e73a8af0-1b212cc391fmr17196667637.6.1716919906011;
        Tue, 28 May 2024 11:11:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcdebf54sm6718849b3a.112.2024.05.28.11.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:11:45 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: nalramli@fastly.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	Paolo Abeni <pabeni@redhat.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next v6 0/3] mlx4: Add support for netdev-genl API
Date: Tue, 28 May 2024 18:11:35 +0000
Message-Id: <20240528181139.515070-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v6.

There are no functional changes from v5, which I mistakenly sent right
after net-next was closed (oops). This revision, however, includes
Tariq's Reviewed-by tags of the v5 in each commit message. See the
changelog below.

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

[1]: https://dl.acm.org/doi/pdf/10.1145/3626780
[2]: https://lore.kernel.org/lkml/20240423175718.4ad4dc5a@kernel.org/

Thanks,
Joe

v5 -> v6:
 - Added Tariq's Reviewed-by tags to each commit
 - Sending while net-next is open ;)

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


