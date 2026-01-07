Return-Path: <linux-rdma+bounces-15348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03315CFF282
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 18:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3365D3257845
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBCC318EE3;
	Wed,  7 Jan 2026 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Sj07H7ws"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354329A9E9
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802527; cv=none; b=JsflOnLYW5zDz3AdOQKJZL1Kx8iVj/+JJ7tN1W88m/qU/Y4QWRBl1R+QZjqdDRatffQkR1KarEh7UNaYi2S/iVJzMURzYHFo/9pi5CUFqPW5JQgJhQ1q/2FKNAJIUxFR9oO/TK/VHisvAvWCO9AtdASDOHMk0X2vmMZ/nVx46cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802527; c=relaxed/simple;
	bh=iYkCdYb6PIQ4+E8X3uZjHo+yocZ9lvb8VAY1R4TyF/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRcMbBzp+k+LB+LzBWvx0wWzhawlEPeFfIRCb7kke//pvtAIyJjCd7J+ErtB7eYue10ir2CLcfg7WQTQQdHKmt/kaB0D8s4vCkMlpNi/9zccIkqcE91Eayc720vG4IkMvxCOZusd9E44bF4msXS96sjLooh33VJJPnmbYkIDGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Sj07H7ws; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so3173797a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802520; x=1768407320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUOSf51r9o9BiwCILnaFHu+YUm937UqpHeR7XKSkiWg=;
        b=Sj07H7wszIqPs6vnT7kv2Y/1Hx38DBmWDH4kDGh2oczUmCF0Iq1F6iWJ6HelgPEkYq
         7CDKUg9i9qUgdVGXwp+VNddXJS2FOg0ZzWKxRDCDGiP2g6Wt5zEUMty5OhPFk04UoZVq
         bQ0x7pbN0vQHBTnrXTU05vm0mvuAjJhkJnib4JvImspn60L5Dhyx5Dpg3XlxK0n1V9+T
         IRla+5Yh2+XMg93cdGPI8JjkaERFdaU8TymT+kFihbNzu95+PlAjUyj7nxl4Ye0usw4+
         aQFXLqb6V8+yX6gNj6ryxYe+nzmf+IocnafXeoN7KObK29vmGqcLJ1o0/oEFNKQhR3tV
         IewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802520; x=1768407320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUOSf51r9o9BiwCILnaFHu+YUm937UqpHeR7XKSkiWg=;
        b=W5uJHmWYYrTPJkxuQLV3IY8tIULlR5NX1w2kLh3WX3/CM7eTknxqZKlRMqaxXehT7N
         +qeAaqTGZk0IlFqbcyVA5FNm2WnwcVwM/p2NRUjY2d/wMti4TQNienrJp7kbR8dmZoO8
         BTnbla6QGS1ce0qV1ikccg2RiWD6kf/bUdKe1TSd97/B3Vk6xOMMeExmI3nJRUYTfY8p
         c17SUk7amxh5rj3+qIxVesufvFOJwZlHQlEyt8hOAud8qzSJ3bcWTz25zAZQQI2XhSD3
         lgHhNT7rLFPA4VzbxdsGKza25YglCMsmX6LR6dIUlHbTSSvTp2HzBa0NZnzaqnX4Ag+F
         RRcQ==
X-Gm-Message-State: AOJu0Yy2bPWaZAFH/oBmB7sEs6D1d5YT5FXcccxBzym5JM7wstYFZWD5
	WLfjEyCmA/L3EotvYEI8QJKwAXk+Qt9KTVMYZwIh34XKwHNawXdvluWN2knMbNfSsYML9/X1k+V
	sdyxJ
X-Gm-Gg: AY/fxX7xlIH7zRPRwGohPOF6wlPjq9fYsr7fP+VnFT7pQH4VjoWAVpVqdCqdRaGKNHp
	Bw+/PuE3peGv/yDi818aTf5bGRNJzIN9vx+k2Oh0Ou7Inhoo2ZHvDIc9SgqyMvMF4ieULxpzWBE
	XYiVj7PHEcUgn9URireVMXEtjR43xSEuFZerXSWDy2fmT1Lhnr0lPgIp9WB2HDVxNi1jQTQ/mrG
	dwv0m2PlbQlYNxekZOgt8alKh3G1/GwWUastS/NdU+YCmT8YCVr4JXq6Exl3icE0l7ReBfK5dz3
	U/84m3wgwAuZOcnT/JdtfLw8t8CtMpMugrm8osSkSG1LxK8o88PjWG07nbDMn6jyYJJSVeeTIy+
	NuFHJjaMsNP5HoPmg4b3GsPdUdM7fTCZaL93QiF+0YWrlVKiEYdnMu/XBKJgVScTUn/lG6uLX8i
	+2Htl4vM3n0YU8MHYXYbiEDaMDCp36iW22KM0Go5EwnAdsT0oGXCvYMWa8OrsjZbhSVXUfWopI4
	k9a5WeimN0BLKX6dxIlRns=
X-Google-Smtp-Source: AGHT+IE6zy3q7KDBAZsundh73MsdAuj0RNoKBml2qE6FahAPl4RouJf75lxBmWPjC7WLJDu+ASyWvg==
X-Received: by 2002:a05:6402:27c8:b0:64b:4037:6f5c with SMTP id 4fb4d7f45d1cf-65097e4d1f7mr2804178a12.19.1767802520412;
        Wed, 07 Jan 2026 08:15:20 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:20 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH v2 00/10] Misc patches for RTRS
Date: Wed,  7 Jan 2026 17:15:07 +0100
Message-ID: <20260107161517.56357-1-haris.iqbal@ionos.com>
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

Changes:

v2:
- Addressed comment for patch 02 to print only error description.
- Addressed comment for patch 05 to remove additional unused members.
- Addressed comment for patch 06 to remove internal ticket reference.
- Added patch 10 which corrects the print for process_info_req.

Grzegorz Prajsner (1):
  RDMA/rtrs-srv: Fix error print in process_info_req()

Jack Wang (1):
  RDMA/rtrs-clt: Remove unused members in rtrs_clt_io_req

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
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 131 ++++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   3 -
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  12 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 184 +++++++++++++------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   1 +
 drivers/infiniband/ulp/rtrs/rtrs.c           |   9 +-
 7 files changed, 230 insertions(+), 118 deletions(-)

-- 
2.43.0


