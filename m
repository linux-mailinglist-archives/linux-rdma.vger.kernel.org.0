Return-Path: <linux-rdma+bounces-2114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189EB8B3F5A
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73EC1F24E56
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8A4A3D;
	Fri, 26 Apr 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vVVU2/Ct"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5F1173F
	for <linux-rdma@vger.kernel.org>; Fri, 26 Apr 2024 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156448; cv=none; b=N2RY+tffMiSyN/Ig4607JSMRheNCXsDOdfP6SbKlBr0koB+5EEJdlT+UMFb3XDwuuodqKJ1rpxP5rFWMURzvLMC8AGZc96d/pKH+7NTY+XEaQXp2ZuR2hOaZU1c9tqgG7/S/WbsjD6FzgUUjbghOCdV9UVfHxR5SJz4IsnB0ps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156448; c=relaxed/simple;
	bh=veT0sDsyrl73mCujRdcKEc2AtCFryNFecy2sFtWamoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+9rUytcgvt9l0AGz+H1OhP7FE/ib3r1YJlWpuf3kIS7Y9tiNKs8SgBZ6lYQz22eY4oX9ral0G+oknKzLe9VVoCyge1UKAskqSM3JMx2zfDrYK6FfbBhOpS04kEC4InhdwobFbGLx38llN4hKRVfJ9zce4JtaA53ceGOWDy1e5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vVVU2/Ct; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3f17c6491so20381975ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 26 Apr 2024 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714156446; x=1714761246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZoSwzLi6xvTIvtNVms/jlVvWAfvYtCLM7lzp/fumoA=;
        b=vVVU2/Ct3D4r2pjJ2u3DuoB0ifAiZURDotWsnzPg8nxXXw9YkeMRN6cieUZGPlPzMX
         MqTsJnI6khIFz+q5hkcs0CUXKEUv88CDwSoel4Mvr+R9QJwsFrlZULYwll/ba9T1GTz+
         xHVf6eo1eoKnSks0UCOmH4o2MKl+zoHnkiS18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156446; x=1714761246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZoSwzLi6xvTIvtNVms/jlVvWAfvYtCLM7lzp/fumoA=;
        b=W0gppYo45/79d1E11SF7zT3kboyEKvTSyPg7WeXRzxf4/oeELYrm4USj66Vn63Hn8A
         Pm+ztfRlfzpicNTR7CQgowiMI+HBb1uCPr6cZdgdGM0C+vHOv/HFhAASBqb3LiBkIrPD
         dlnsB2xyjcF2OJqwJXvL1Wbi1Q2pVeg/lifUl5z0qdd31A0D1ns6PbADD8OmdFEcqtow
         oF70mXFw4h9O0YF2d6rpAdHQdqTGLI9Co1mBxObAl+AH+hgBnWpTWgbJrvlcoErKr4fd
         8V199Xy+jJ39UgFh3E6GGI3Stwy6MAgfNd3lDFuoS1WwPPxFTzSZhQ3tCoHqmd0VTqer
         TYXA==
X-Forwarded-Encrypted: i=1; AJvYcCUe0q+6COHblU67Eo1l0lSR5zhcW53RdoykznBDhvNNxr9oGPe+gEOiJwt2wssIzrgXRuBwT9VBTcXh3lr9HY7r7doE7bszZp2hxQ==
X-Gm-Message-State: AOJu0YxOzUCQWGqAI7lJjtiNQEYqUgNUnAJWEEFn/jhrt6kaP4aC5PZl
	EXC06BH2Sh7AYDxPY1YK4m8WMl8y3iPCUE+aDg6aCWln32Y4CGNZ6cHVaWQeus4=
X-Google-Smtp-Source: AGHT+IHnG5xfPC7t9g3uaoL8prAXxXW+Go6YADGhLzvoUqn+vtXCfvI59SkJt+SVoMBVTy4FuT5Pxw==
X-Received: by 2002:a17:902:c40f:b0:1e4:4537:40ab with SMTP id k15-20020a170902c40f00b001e4453740abmr4026315plk.12.1714156446226;
        Fri, 26 Apr 2024 11:34:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id j23-20020a170902759700b001deecb4f897sm15713152pll.100.2024.04.26.11.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 11:34:05 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca,
	gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/3] mlx4: Add support for netdev-genl API
Date: Fri, 26 Apr 2024 18:33:52 +0000
Message-Id: <20240426183355.500364-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2.

This series adds support to mlx4 for the netdev-genl API which makes it
much easier for users and user programs to map NAPI IDs back to
ifindexes, queues, and IRQs. This is extremely useful for a number of
use cases, including epoll-based busy poll.

In addition, this series includes a patch to generate per-queue
statistics using the netlink API, as well.

To facilitate the stats, patch 1/3 makes use of an existing field,
"dropped" which was already being exported in the ethtool stats by the
driver, but was never incremented. As of patch 1/3, it is now being
incremented by the driver in an appropriate place and used in patch 3/3
as alloc_fail.

Please note: I do not have access to mlx4 hardware, but I've been
working closely with Martin Karsten from University of Waterloo (CC'd)
who has very graciously tested my patches on their mlx4 hardware (hence
his Tested-by attribution in each commit). His latest research work is
particularly interesting [1] and this series helps to support that (and
future) work.

Martin has re-tested this v2 using Jakub's tool [2] and the
stats.pkt_byte_sum and stats.qstat_by_ifindex tests passed.

[1]: https://dl.acm.org/doi/pdf/10.1145/3626780
[2]: https://lore.kernel.org/lkml/20240423175718.4ad4dc5a@kernel.org/

Thanks,
Joe

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
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 79 +++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/en_port.c  |  5 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 +
 5 files changed, 101 insertions(+), 2 deletions(-)

-- 
2.25.1


