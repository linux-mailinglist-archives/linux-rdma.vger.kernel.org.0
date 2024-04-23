Return-Path: <linux-rdma+bounces-2027-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085D38AF78A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 21:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C79B210C1
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02E1420D3;
	Tue, 23 Apr 2024 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="O23D/Lds"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E41420B3
	for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901778; cv=none; b=UVQhhm0lt/n2VO9BVrOKJs3+VC1bstsBytAlWf0RpuukkPIGQTtIPZUhVwnyZXa1sjxPShiycV4/fu2GnJ2FWxhH2eMScb55hqFp589d/NBfP29gcMFAK/gomY9wqBE1M9xJElI7br3TNZTT8tU6dkqjcYJa7/b4JE1TpqVjd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901778; c=relaxed/simple;
	bh=kJ9kYfil2xzfpoYxIpb3/kZLHitOV5bl8cT+liycUAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CepelDQPNEQgh5gazWBnmHshpHUw0tuULziAeepKpJPKnTXE1Fng9XZJdOItCTHaG5dOzjx89NJqXNiLZqIqF8V6vz7BgTW5wRKFUcNCIjUeq6u3y4qeqFTd76vNnDeIcMNSM05skBcyL7V/nS+UENanhmA0GWIjFRrcQm6NnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=O23D/Lds; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so5938604b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 12:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713901776; x=1714506576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPtGpJ/IOjI79m4Y457ecZg+Ii4M4Q2uc2yvPSAuKZY=;
        b=O23D/LdsracELJIRnsl1Q9GakcG+wGXRnrx01rydjSQr6LqkRBxoFQQPXCwXf2k4fZ
         rpq+M08yVj4+YTes+Mq1grbTTfngE3X3wVf1XrkmabhnxGXgcEPJcnVEhGp23JcOTvAq
         wcWRHzjEJKXaW1ebVC7zSY1+FvubZ3+3CQdFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713901776; x=1714506576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPtGpJ/IOjI79m4Y457ecZg+Ii4M4Q2uc2yvPSAuKZY=;
        b=E1itaHDrxS7d4RdpBtj9hRd1hGuUG9VUiNIqrQBkC7FXEPAiQglYOrH+SLOV2KIMpU
         JmX6QhYvtht0iuCTnAL+VrnJd0xSCxEhS5FDdrketbkQAm5p6hYcApfTdf6D5sHJfXi9
         PAwfm/AKbv0ricyJAwMWYwm5h5E5jgfnEHyHtqF2CMZ4Fl4U+szKj+n9kZKscumyZq6v
         Pt7NbjwLSoOoh35Mov/LgklNqvWuEccrJmYg/gQ6e18wUlCczo7ftp+H8gm3TYXoEhh7
         RgQaaw5eZpW2amSfGTLZ7al1XMVKLxR2PERkX+82vGcNE3HVzm8yskIIaEsJskacE9jm
         tYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaEKcqBlb9dzT0skLBjUbVFmUmv1tILT+Rr6Va3Fpd0HA54y+PV3HI5uqTfEOr6cM8yMbqo68mnax6jYNcgJfHpzmhJbvLHitPLg==
X-Gm-Message-State: AOJu0YygXkOiaLVnRSn03vqdEoIB8Ui2wen68T1nO2DgBeopMujxinbp
	BKWeVFXRjk/wKkAwF2roM/NX7lZgu1Y1e5umpDpOMKqdcWPi1jyw3PXNubqN1fI=
X-Google-Smtp-Source: AGHT+IHfhg5op9/dvJaSrwjVkbxyvWR8iTMv6cxD/iyEnDvQGXqvcq/rsuhpMV+6R+9nENeq9i1FyA==
X-Received: by 2002:aa7:888d:0:b0:6ed:d189:a0b6 with SMTP id z13-20020aa7888d000000b006edd189a0b6mr710354pfe.32.1713901775801;
        Tue, 23 Apr 2024 12:49:35 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00084300b006ecc6c1c67asm9995672pfk.215.2024.04.23.12.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 12:49:35 -0700 (PDT)
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
Subject: [PATCH net-next 0/3] mlx4: Add support for netdev-genl API
Date: Tue, 23 Apr 2024 19:49:27 +0000
Message-Id: <20240423194931.97013-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi:

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

[1]: https://dl.acm.org/doi/pdf/10.1145/3626780

Thanks,
Joe

Joe Damato (3):
  net/mlx4: Track RX allocation failures in a stat
  net/mlx4: link NAPI instances to queues and IRQs
  net/mlx4: support per-queue statistics via netlink

 drivers/net/ethernet/mellanox/mlx4/en_cq.c    | 14 +++
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 91 +++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/en_port.c  |  4 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 +
 5 files changed, 112 insertions(+), 2 deletions(-)

-- 
2.25.1


