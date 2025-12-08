Return-Path: <linux-rdma+bounces-14922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A6CADB67
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC52D3006E1B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFD52DC78F;
	Mon,  8 Dec 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="R3Q0IBYr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C263238C0B
	for <linux-rdma@vger.kernel.org>; Mon,  8 Dec 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210521; cv=none; b=qzuF8JhzWygqBy4S2t/d6eu0N+XY1qxLVYLwyoKMO1UxffDVu8QtlsLMxypxAz+NuVW8CaUQf0lQXT7gaPDdcY0YwoZvNID8Zyndl2w75aOdxUR2SH+sjfQuZ+jBKTB2WDY+noXx0+Uip1ovihQsCycUN+Xsvgyod1iRayKxC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210521; c=relaxed/simple;
	bh=J8nsHnHZtGdVRKURZR1Szvo2iU30+Y1cShRPZqQShpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLyhjmKi8ZV6oml0OaMAbf1i2Pd7JgN1l0NbyCBMGAqNg1TltZrBPmUS46b2P8IBj44PkldS9LCCCrn7HQTxDzAwM4h+XbYiU43bJwSqJwhgfa5vbvOWH+H0ERsn/2v6tguFRxcojRC+Y8SmoNlmgFj13T9DmSiUrfr27UA//oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=R3Q0IBYr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477632b0621so34089915e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 08:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1765210517; x=1765815317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pEudmW959gnYs8Q4heeI9nyPF4+bv8i4SMVGLLtaz0=;
        b=R3Q0IBYr8lVb1y+fimwkK1Shae768KPcD9xhE6AcXadaM58ONVxgV5moOYlq8EycfM
         jJtO8941hQBKSW0D4yNM5WylHqxbZdojKT6gFaUeeJC+Qc0F3BR2AgVFuWvdDDl4zzdf
         +41+sPXcvhm7oZw9XhwLfasvwyjl4e64vkdoHp3sygn1K9vg7/ON24a2M3NU1X5nlEtL
         w25DioEFN6pPcWquhmOLS3+Ev5S22GEl/SiW0iNk5Nn5a9s36b0zCahhm4cW1gLeC0Nf
         6NDXAWOdDCiDO6xrNiCgcVy/Zj5AkaT5t59MahJrgXzNVYQAxmGx8qkXVSpAFSfGa7OT
         bLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210517; x=1765815317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pEudmW959gnYs8Q4heeI9nyPF4+bv8i4SMVGLLtaz0=;
        b=VdxcQwXb3Yw0xpUeOsaE4jgTLi61pc4togukVYzSlVfa2/OrFYNmBHa+R0UjYsi8CX
         ztJiPacbEg2lmwKMHy2xV8j66qKVdCc28/ceTvT1dhiGH97RLbXkmHtfW6auX33xthLe
         YskWtpiOHh6zZJCK2aKRUgyBrE/233gN/OkMa6GNZEMCED8HKI5V6pb0HY0W2RFjvXtg
         fQg6hdkLpLGowuZhhntLYHCLIJ3QJXMH2DgmajQpq0YjgwCUtW39KyazVg/YSbzFGCJQ
         JEaBGl/IWYEGc+33T16Zr+KJF1J3LBK4QCpxOYMApIAOBQJsvjyBvnvmcy/Q891hHet7
         82KQ==
X-Gm-Message-State: AOJu0YyrmM78dOxHpej877mNlvLzqTD1kMwTIClUyADFmkcbQK+clDcv
	vprpahzXd0slIkwN4lgk5zMd6DwWqU3vV+y7Y/hZCI/D4XdgMQ7SpnLo/aFE5n+FZ92NxOupbSz
	AWQqU
X-Gm-Gg: ASbGncsJJPH8hwMijH/KggfD9pjZP2/lc42xZSRmeCJZo76LbVlPdbVluPum1FDjBRy
	Nls5SJetffeoInl2K45Prwpp0KOnrlQGL4WewQcpvB2hZ5aicu06Yipl0jtk95Dm58DT3/D3Z/5
	H0mwTGAXXlOS+Io8MVCH20fbbfzduuKZldFEb3N3J16QaGT1f/6IymvkVyGQ6e7tpfH3ECrJ1P9
	6r/dRQ2j4ajQKgEKNRV9iESgGE/iPXMFkQJab7NDeQXbmbAY1O9yKTu3ZvMveMjKbq5bSxykPE2
	yBqvgQds3KzFGiusbAgRbv0CgFJz1145liMLWTJeHdoVpRUvTMVytbCoCnz3fSDYnh09lfWtUb7
	n8nGKKTvoOXuR3DlTIT35TYvwB5cenRu9LLGSRN1ucnXRdpTyn3WIFmd/BxDcH0NnWakfXQE9ub
	IpSalEI0UHJDX5LpI9iElFN9Gbh0u1jdKg+VcRQKmNrXT8cj+OFboyVqhS4AmOgcuK+PIaraqcK
	II89To5HVSmn2v+cpw0rGbv
X-Google-Smtp-Source: AGHT+IHOfKm7+lUqtY1/jjhzHSG1tK9XOchYj4xv7mWwb1/IUwSexw/Z2ED/HOgvlqYw3Y6QzkIztw==
X-Received: by 2002:a05:600c:1c0c:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-47939dfa46dmr94685825e9.11.1765210516912;
        Mon, 08 Dec 2025 08:15:16 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net (p200300f00f28af1ae57f1d6cbb50b9bc.dip0.t-ipconnect.de. [2003:f0:f28:af1a:e57f:1d6c:bb50:b9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm245275655e9.13.2025.12.08.08.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:15:16 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH 0/9] Misc patches for RTRS
Date: Mon,  8 Dec 2025 17:15:04 +0100
Message-ID: <20251208161513.127049-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason, hi Leon,

Please consider to include following changes to the next merge window.

Jack Wang (1):
  RDMA/rtrs-clt: Remove unused list-head in rtrs_clt_io_req

Kim Zhu (4):
  RDMA/rtrs: Add error description to the logs
  RDMA/rtrs: Improve error logging for RDMA cm events
  RDMA/rtrs-srv: Rate-limit I/O path error logging
  RDMA/rtrs: Extend log message when a port fails

Md Haris Iqbal (3):
  RDMA/rtrs: Add optional support for IB_MR_TYPE_SG_GAPS
  RDMA/rtrs-srv: Add check and closure for possible zombie paths
  RDMA/rtrs-clt.c: For conn rejection use actual err number

Roman Penyaev (1):
  RDMA/rtrs-srv: fix SG mapping

 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |   8 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 132 ++++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   1 -
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  12 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 185 +++++++++++++------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   1 +
 drivers/infiniband/ulp/rtrs/rtrs.c           |   9 +-
 7 files changed, 232 insertions(+), 116 deletions(-)

-- 
2.43.0


