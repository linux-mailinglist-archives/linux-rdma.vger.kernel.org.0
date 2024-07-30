Return-Path: <linux-rdma+bounces-4107-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFF941F9B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FBB1F24C54
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148CA18A6D4;
	Tue, 30 Jul 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vncm3ufa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641651482F3;
	Tue, 30 Jul 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364451; cv=none; b=hq5UuDsoyXIRtV/Umbutznjgnptnowi6oZXRWsNVabo3uS8UGHnkF5yBU7K1MXywdDPfKCnEmbN/41EWAgblgdcFboNAdM3ARRHtAo3S5BTKiYehKTTZUEEDW9AIuLP5fcq2u6uVoisqcW3TXYRJxf4ZfIh90z7YHb7UGbxv+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364451; c=relaxed/simple;
	bh=zIzgANHERYWgSlCLvUxdACUEif8zYOTAwucITvoftoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ViWVIcyNmDXCgb/ZGLaKPaI+I2xTftv6vKbwfcfVbtR78EDlS54Ec+0sb+QJMesYPFs9P5TeYQ/Wzy0VOG3JJYEKxnn8he5/Hfy24Hk/R93oPS/iGwKjbkeU8tgs3VXA3vz/SKJ/KoqMcquq2JKq1WnWew/dtZDlhlms69dEi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vncm3ufa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d357040dbso3863350b3a.1;
        Tue, 30 Jul 2024 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364450; x=1722969250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fp9sY+KsYLEoL++6nfL7qEAWDNCH4f1pH2g10lY6LQ=;
        b=Vncm3ufa/LazsIFOCCupAOE6Lr/QHug2z0sCsXSxBLqD/Cl3kCHXhKkRMB/8yZAINX
         MPqLZ7b8WSl0ouP4AI0Ap/X7MrKTJGSK19BBsAxUNW0AICpD5C2V7GIRCn/EeWzpqvQL
         YyIAGccTwlyyDTf/Swp6AXPpAnSKgtQvR5+N1AKvyqnq65CuXnl5jTlrDBCVQwl/g3xM
         p1fgsqtxTAc9ZcsvWD6+vOVsRSeU4KLKKUerL0GDaJ6WExEmN4UY94ATcPpJ1qBiN4ms
         uJwIw7kX0ko1Wyv4IGVDVbV+neKACnupFNpk/EChvysXpFJFEWBprBI9q7nzZ/oT9xmv
         Y8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364450; x=1722969250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Fp9sY+KsYLEoL++6nfL7qEAWDNCH4f1pH2g10lY6LQ=;
        b=nHSZDfenYt25561kzF5Z5p4r3W/1PQNo298PV207iQ7MrAk7rTvo2WhoW1mcLlSSzm
         d4+tRGrYVwvsBeHedPjb9h+Mi3zqdsI1UKjEwzhF/6FruILL0vzHaaEfHW9MtX8Pe8F1
         oE3LsZqtI0g//XG54okIoXiDSdQ8X/QhrqAE6AcCW+IhRXv+XNo99l00n8RClJSuXwPv
         kzvZxIxuQSziRoSsmt7WZr3Hxrh5+uUNsPSlD6y72WYuxbypLiWkQ07YSlSZdQs8nE9d
         wHYuR9I1D+UJgn7TksCHPmjelBHd0c1DlocPT/5SrnvgGCl3Z7ytKVqFcgPWc61ioBv7
         M8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvtRvr69/2Po9GKAZfC0jK0YxUoD8uymp/qOQg2nv1v0Eq/QZJVjFLMnQN5biQIRoyt2oD8UyALn4+xHPPPyoH8Df5uxqJ4ICYQG5hhOhnV6Hg764rODRLGbBMBOVZ1pHJ/VXd0Mq5P822q1D3oMeXxXNCQKQFQzWSeFB7esGxLA==
X-Gm-Message-State: AOJu0YxlbLxp52pgMl46juqr6f6yUzStpetU/ymXlONOAYk5WtsYMXae
	CyhkUhnu/tavxSESJulB8GXwG5qVjBqOqH93sIIrfHvWOJjiA6fW
X-Google-Smtp-Source: AGHT+IEwvW3IZW0hcDRfGFY4bnSHj92tWdAy2P6O4KTjmH4xJdoIfxE1/aHVwTk9k0ym5kG1irSowA==
X-Received: by 2002:a05:6a00:b45:b0:70d:26f3:e5cb with SMTP id d2e1a72fcca58-70ece9fae78mr12592731b3a.3.1722364449528;
        Tue, 30 Jul 2024 11:34:09 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:08 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jes@trained-monkey.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kda@linux-powerpc.org,
	cai.huoqing@linux.dev,
	dougmill@linux.ibm.com,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com,
	cooldavid@cooldavid.org,
	marcin.s.wojtas@gmail.com,
	mlindner@marvell.com,
	stephen@networkplumber.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	borisp@nvidia.com,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	louis.peens@corigine.com,
	richardcochran@gmail.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acenic@sunsite.dk,
	linux-net-drivers@amd.com,
	netdev@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next v3 00/15] ethernet: Convert from tasklet to BH workqueue
Date: Tue, 30 Jul 2024 11:33:48 -0700
Message-Id: <20240730183403.4176544-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws. To
replace tasklets, BH workqueue support was recently added. A BH workqueue
behaves similarly to regular workqueues except that the queued work items
are executed in the BH context.

This patch converts a few drivers in drivers/ethernet/* from tasklet
to BH workqueue. The next set will be sent out after the next -rc is
out.

This series is based on
1722389b0d86 (Merge tag 'net-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net)

[v3]:
  - Include Reviewed-by signature
  - hinic: can show work_pending() as a partial replacement for the tasklet state.
  - mvpp2: retain and re-word comment.
  - fix rxempty_bh_work() which will emit 'RX Queue Full!'
     message, so the change should be visibile to the user.


[v2]:
https://lore.kernel.org/all/20240621183947.4105278-1-allen.lkml@gmail.com/

[v1]:
First version converting all the drivers can be found at:
https://lore.kernel.org/all/20240507190111.16710-2-apais@linux.microsoft.com/


Allen Pais (15):
  net: alteon: Convert tasklet API to new bottom half workqueue
    mechanism
  net: xgbe: Convert tasklet API to new bottom half workqueue mechanism
  net: cnic: Convert tasklet API to new bottom half workqueue mechanism
  net: macb: Convert tasklet API to new bottom half workqueue mechanism
  net: cavium/liquidio: Convert tasklet API to new bottom half workqueue
    mechanism
  net: octeon: Convert tasklet API to new bottom half workqueue
    mechanism
  net: thunderx: Convert tasklet API to new bottom half workqueue
    mechanism
  net: chelsio: Convert tasklet API to new bottom half workqueue
    mechanism
  net: sundance: Convert tasklet API to new bottom half workqueue
    mechanism
  net: hinic: Convert tasklet API to new bottom half workqueue mechanism
  net: ehea: Convert tasklet API to new bottom half workqueue mechanism
  net: ibmvnic: Convert tasklet API to new bottom half workqueue
    mechanism
  net: jme: Convert tasklet API to new bottom half workqueue mechanism
  net: marvell: Convert tasklet API to new bottom half workqueue
    mechanism
  net: mtk-wed: Convert tasklet API to new bottom half workqueue
    mechanism

 drivers/net/ethernet/alteon/acenic.c          | 26 +++---
 drivers/net/ethernet/alteon/acenic.h          |  8 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 30 +++----
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c      | 16 ++--
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c     | 16 ++--
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          | 10 +--
 drivers/net/ethernet/broadcom/cnic.c          | 19 ++---
 drivers/net/ethernet/broadcom/cnic.h          |  2 +-
 drivers/net/ethernet/cadence/macb.h           |  3 +-
 drivers/net/ethernet/cadence/macb_main.c      | 10 +--
 .../net/ethernet/cavium/liquidio/lio_core.c   |  4 +-
 .../net/ethernet/cavium/liquidio/lio_main.c   | 24 +++---
 .../ethernet/cavium/liquidio/lio_vf_main.c    | 10 +--
 .../ethernet/cavium/liquidio/octeon_droq.c    |  4 +-
 .../ethernet/cavium/liquidio/octeon_main.h    |  4 +-
 .../net/ethernet/cavium/octeon/octeon_mgmt.c  | 13 +--
 drivers/net/ethernet/cavium/thunder/nic.h     |  5 +-
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 24 +++---
 .../ethernet/cavium/thunder/nicvf_queues.c    |  4 +-
 .../ethernet/cavium/thunder/nicvf_queues.h    |  2 +-
 drivers/net/ethernet/chelsio/cxgb/sge.c       | 19 ++---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  9 ++-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
 .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  |  4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.c    |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c      | 40 +++++-----
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c    |  6 +-
 drivers/net/ethernet/dlink/sundance.c         | 41 +++++-----
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |  2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  | 18 ++---
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.h  |  2 +-
 drivers/net/ethernet/ibm/ehea/ehea.h          |  3 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c     | 14 ++--
 drivers/net/ethernet/ibm/ibmvnic.c            | 24 +++---
 drivers/net/ethernet/ibm/ibmvnic.h            |  2 +-
 drivers/net/ethernet/jme.c                    | 80 ++++++++++---------
 drivers/net/ethernet/jme.h                    |  9 ++-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  9 ++-
 drivers/net/ethernet/marvell/skge.c           | 12 +--
 drivers/net/ethernet/marvell/skge.h           |  3 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c    | 12 +--
 drivers/net/ethernet/mediatek/mtk_wed_wo.h    |  3 +-
 43 files changed, 288 insertions(+), 266 deletions(-)

-- 
2.34.1


