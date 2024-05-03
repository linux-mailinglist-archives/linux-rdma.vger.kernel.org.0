Return-Path: <linux-rdma+bounces-2226-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F618BA54F
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 04:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDF5B20971
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 02:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5A17BB5;
	Fri,  3 May 2024 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vINLO+wD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6835A11CA9
	for <linux-rdma@vger.kernel.org>; Fri,  3 May 2024 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714703167; cv=none; b=PADRMom89Yj6ZzKEEd56PzZzAFS/VF3y1+NH/91vVfaMOrTFbctxcLU1x4m3u5SDegszAmop+KxSc+c183LVHWtgF+Pr/AjOwRU1zrVLD8QOhE0tagK6/N/GFdq2sWIIBA1PTTaGqp3lIBprvuksEhaYRP5x29IxazJWLHLJTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714703167; c=relaxed/simple;
	bh=C454xzAC3JQOyYoIYohsLjHVU82xaCQmc1rcSmt8m+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OwLQS3d6CUd0wOV/v4cyMUuhKoAKJ7wr07HpD+mYUURRITDqKIWpNsSaSIWgDvFAfKVEnWhonN74CeZsqIqjEPN4sA/f05Qb/OTwk/CT5zGv6Pav14UQ0pI/MLo1cypRePWy6FXYB74ygVd24nRF1DXnxuoC5RXtmWRcVqf5ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vINLO+wD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4f341330fso80612675ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 May 2024 19:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714703165; x=1715307965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qLhxyOPSGPjPLLGWAZi81rfATVDEMRLBQaiXKuAdQU=;
        b=vINLO+wDtaG8r0KxXl3zjGPgVRIe1/vHFlpeT0X+wWBHqsbrzwtLnkqmIUa+6rJddP
         dZd8XhmySS1YGUeSfE7u3KtV98WYBJJEWOV0dsiIB//oXXqnxA0W0Prw6iv1qHjE9tLO
         sfbo8PZfJ4dwxLDwEZuTdlsZuzCBsGE29xm9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714703165; x=1715307965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qLhxyOPSGPjPLLGWAZi81rfATVDEMRLBQaiXKuAdQU=;
        b=Qh4X2sLV4Yx7SWBXnRF5KwAOl60xc+No4pj0XWUqdSE/ZUteIt3f6JPcBCZfS9/wUN
         SyotWBcJLl2Xk6p53LT28wT4THRPOZoSJ09C7l0CgNEO9carG5jVUsMfX2CYTdiHTOCd
         CJ/tZa8/5waXgZEr0X+yaEMTtSMzGbMp1uKeRkKncIWTJwDcP7S1e7gZxHF/wZJ6dSQJ
         CF4kP0FmhuCDdp5CJ+i6m20zkgRTR2+sdfld/PYmfM4s2aDVwmobibtNQ4jKuBEC2tE7
         8TIusIAwEcBnGDQNYTlNI/Yf+ompwePPEjds1sqwT4So6v+NQwlIvPR5rfdEdPMnvCTO
         kUjg==
X-Forwarded-Encrypted: i=1; AJvYcCXXI3beQGQHMvxgtt73ZaoEevPLHFLROyUR+HwJhlWaV8zg13QAo22qROvYEAqyU1VL5ztIz3jSbBuMo37PlL0OAhenmtAvpQ68Cw==
X-Gm-Message-State: AOJu0Yx3ilLb93pfkEOEUV2CniKNNtcIALMFsvRgRkaXa4sORxWgBPZg
	edw6fmKsBGJlRGxacFTDmt/lExljVUnW4AA0v15Q054JF/s0y6qqlnEII/sao0Q=
X-Google-Smtp-Source: AGHT+IEZi5tPqHLUle3y3xqWqlkatsV2QUiiEleutL/p7d1+aZO+5c+OKNqKoq3RW2UEfxbO0BUu0A==
X-Received: by 2002:a17:903:1205:b0:1e3:d4eb:a0f2 with SMTP id l5-20020a170903120500b001e3d4eba0f2mr1775321plh.51.1714703164728;
        Thu, 02 May 2024 19:26:04 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170903054300b001e904b1d164sm2070450plb.177.2024.05.02.19.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 19:26:04 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Date: Fri,  3 May 2024 02:25:48 +0000
Message-Id: <20240503022549.49852-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi:

This is only 1 patch, so I know a cover letter isn't necessary, but it
seems there are a few things to mention.

This change adds support for the per queue netdev-genl API to mlx5,
which seems to output stats:

./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
         --dump qstats-get --json '{"scope": "queue"}'

...snip
 {'ifindex': 7,
  'queue-id': 28,
  'queue-type': 'tx',
  'tx-bytes': 399462,
  'tx-packets': 3311},
...snip

I've tried to use the tooling suggested to verify that the per queue
stats match the rtnl stats by doing this:

  NETIF=eth0 tools/testing/selftests/drivers/net/stats.py

And the tool outputs that there is a failure:

  # Exception| Exception: Qstats are lower, fetched later
  not ok 3 stats.pkt_byte_sum

The other tests all pass (including stats.qstat_by_ifindex).

This appears to mean that the netdev-genl queue stats have lower numbers
than the rtnl stats even though the rtnl stats are fetched first. I
added some debugging and found that both rx and tx bytes and packets are
slightly lower.

The only explanations I can think of for this are:

1. tx_ptp_opened and rx_ptp_opened are both true, in which case
   mlx5e_fold_sw_stats64 adds bytes and packets to the rtnl struct and
   might account for the difference. I skip this case in my
   implementation, so that could certainly explain it.
2. Maybe I'm just misunderstanding how stats aggregation works in mlx5,
   and that's why the numbers are slightly off?

It appears that the driver uses a workqueue to queue stats updates which
happen periodically.

 0. the driver occasionally calls queue_work on the update_stats_work
    workqueue.
 1. This eventually calls MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw),
    in drivers/net/ethernet/mellanox/mlx5/core/en_stats.c, which appears
    to begin by first memsetting the internal stats struct where stats are
    aggregated to zero. This would mean, I think, the get_base_stats
    netdev-genl API implementation that I have is correct: simply set
    everything to 0.... otherwise we'd end up double counting in the
    netdev-genl RX and TX handlers.
 2. Next, each of the stats helpers are called to collect stats into the
    freshly 0'd internal struct (for example:
    mlx5e_stats_grp_sw_update_stats_rq_stats).

That seems to be how stats are aggregated, which would suggest that if I
simply .... do what I'm doing in this change the numbers should line up.

But they don't and its either because of PTP or because I am
misunderstanding/doing something wrong.

Maybe the MLNX folks can suggest a hint?

Thanks,
Joe

Joe Damato (1):
  net/mlx5e: Add per queue netdev-genl stats

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

-- 
2.25.1


