Return-Path: <linux-rdma+bounces-2805-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56F88FA721
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 02:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A911C20C81
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 00:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634C0883D;
	Tue,  4 Jun 2024 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="h64O2c+v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADEE7FD
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462002; cv=none; b=tv2a8tAdlWX3/HaQZbQNSgohdqtfPpQ/NDJPDEFUhFW5xuGjsw+Lu1hb2aTFIqTCgh0YLmp5Imi1FED2BdHDJecsUmD/BukhCd1WXx5qwCDcwu8DjRncfuLmYxV2TIPLmP5zDAs/jCUoXN/rDK8y/jfk4BlN3mCWprTrN+bA+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462002; c=relaxed/simple;
	bh=CcYTAVWyB3ymSj/OaY1OftSd6VsNT505IUtr0hifhfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QbzWlfJli50gvBEd4pfe9MQRSn7Om38rXPDVM8M6f06PLQTtSQxr5OJZh7UcJtLrtEAZVaFF6U8W0qAHuLHJjlSMjTPWLw3QiOBMJQrAsD/0pASmYDG0vAXjMpysRnTObUn7Ju4EIn93KVJ9rVp3HAAfRCAXj3ANs7sIYZYd5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=h64O2c+v; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7024791a950so2342591b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jun 2024 17:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717461999; x=1718066799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6qJ3cMHA2ZvV0BHrtuqD+iovtfIMHyhYFzDZ7OtxxQ=;
        b=h64O2c+vb0/hkqU+j9xiH+oAo/4BANflqg4hW7j+kVwpE7XHPT2g9KvMqWp1OONrBo
         G91IdPe6AVx0cowx4wB70eyAgmss4XprBoq3GZVQffhyGOCsSZBjUm5QG2d2pMUmvNWu
         nAyQZL8hNYYovwlqCHv+qhxC86OZdHK0Tq3h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717461999; x=1718066799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6qJ3cMHA2ZvV0BHrtuqD+iovtfIMHyhYFzDZ7OtxxQ=;
        b=kg4B15YXNAlOX0P4UPzrHKAhHDYJn5FjVXrf/hVQLc2n1l6sOjBI/DsOXmyZ0nDK0n
         BCPZ6bf+L52N5VcMP2TgvLrMJEK0Az6p9AS1IST+ZK63+XhbFpLxn6C/lTqyvlzHYTxt
         Lv54FBfCVdZ6QsBfKcvvvxNVTPLNIUpoBqUXnSuPCA7C/Pqzt2Gs6dF8L5tA8J3bwBak
         JDGBniWWDphMsC4T/AQVSgPrusHWwLW7lesagdRjl3Wd6IChAP9RnMSJp0nLJuIrd7TS
         gOS3OgyfvKgdvN3+Nxt/oqMWnQNVWIXEehBzpwu00G7bjbb+utfyTEd4UEVYEV3loMMb
         NRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPxWfX09ODKBvCU/Ufv3bh0qX8ZLeGu8wGydoQ0jsh55quYM6ix0we/ghh9D6ROET9eks1qcyKHH00dDGv5P/KAQOVjCdMkAfd4g==
X-Gm-Message-State: AOJu0YzWu+So8ibCuNIka5IwAscE47oDXkXlP7MtAtN2Brwra3/F5Qhv
	xoufkbTOqbnemONw6W7BOXj+Hgs3EIBBa8wa3GaiO5gjqqgXDG+6Vm0JbQ35V3I=
X-Google-Smtp-Source: AGHT+IHiXBgr5xgcd9sLnnfdN+CIcxTRhmG+sm41M8+12g0FN0OWcYs//B0JiJ/pC845y6AvHYrpUw==
X-Received: by 2002:a05:6a20:8418:b0:1a7:590e:279e with SMTP id adf61e73a8af0-1b2a2b84011mr1872915637.5.1717461998677;
        Mon, 03 Jun 2024 17:46:38 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c26067sm6049316b3a.218.2024.06.03.17.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 17:46:38 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [RFC net-next v4 0/2] mlx5: Add netdev-genl queue stats
Date: Tue,  4 Jun 2024 00:46:24 +0000
Message-Id: <20240604004629.299699-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to rfc v4.

Significant rewrite from v3 and hopefully getting closer to correctly
exporting per queue stats from mlx5. Please see changelog below for
detailed changes, especially regarding PTP stats.

Note that my NIC does not seem to support PTP and I couldn't get the
mlnx-tools mlnx_qos script to work, so I was only able to test the
following cases:

- device up at booot
- adjusting queue counts
- device down (e.g. ip link set dev eth4 down)

Please see the commit message of patch 2/2 for more details on output
and test cases.

v3 thread: https://lore.kernel.org/lkml/20240601113913.GA696607@kernel.org/T/

Thanks,
Joe

rfcv3 -> rfcv4:
 - Patch 1/2 now creates a mapping (priv->txq2sq_stats) which maps txq
   indices to sq_stats structures so stats can be accessed directly.
   This mapping is kept up to date along side txq2sq.

 - Patch 2/2:
   - All mutex_lock/unlock on state_lock has been dropped.
   - mlx5e_get_queue_stats_rx now uses ASSERT_RTNL() and has a special
     case for PTP. If PTP was ever opened, is currently opened, and the
     channel index matches, stats for PTP RX are output.
   - mlx5e_get_queue_stats_tx rewritten to use priv->txq2sq_stats. No
     corner cases are needed here because any txq idx (passed in as i)
     will have an up to date mapping in priv->txq2sq_stats.
   - mlx5e_get_base_stats:
     - in the RX case:
       - iterates from [params.num_channels, stats_nch) collecting
         stats.
       - if ptp was ever opened but is currently closed, add the PTP
         stats.
     - in the TX case:
       - handle 2 cases:
         - the channel is available, so sum only the unavailable TCs
           [mlx5e_get_dcb_num_tc, max_opened_tc).
         - the channel is unavailable, so sum all TCs [0, max_opened_tc).
       - if ptp was ever opened but is currently closed, add the PTP
         sq stats.

v2 -> rfcv3:
 - Added patch 1/2 which creates some helpers for computing the txq_ix
   and ch_ix/tc_ix.

 - Patch 2/2 modified in several ways:
   - Fixed variable declarations in mlx5e_get_queue_stats_rx to be at
     the start of the function.
   - mlx5e_get_queue_stats_tx rewritten to access sq stats directly by
     using the helpers added in the previous patch.
   - mlx5e_get_base_stats modified in several ways:
     - Took the state_lock when accessing priv->channels.
     - For the base RX stats, code was simplified to call
       mlx5e_get_queue_stats_rx instead of repeating the same code.
     - For the base TX stats, I attempted to implement what I think
       Tariq suggested in the previous thread:
         - for available channels, only unavailable TC stats are summed
	 - for unavailable channels, all stats for TCs up to
	   max_opened_tc are summed.

v1 - > v2:
  - Essentially a full rewrite after comments from Jakub, Tariq, and
    Zhu.

Joe Damato (2):
  net/mlx5e: Add txq to sq stats mapping
  net/mlx5e: Add per queue netdev-genl stats

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |  13 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 149 +++++++++++++++++-
 3 files changed, 161 insertions(+), 3 deletions(-)

-- 
2.25.1


