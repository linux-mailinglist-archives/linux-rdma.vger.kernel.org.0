Return-Path: <linux-rdma+bounces-3377-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABC29119F6
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE731C21694
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4D12D1EA;
	Fri, 21 Jun 2024 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRrEAbY2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F123A6;
	Fri, 21 Jun 2024 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946342; cv=none; b=MPLzI0rGHeLQ0v8GMAcTBZyTwy/QA0nJrf9UNNSaU4gIU2PY7AzPjwHUHEUJsjYytjMNhLsh5Ibw3tSSWq28g48tD1gwUIsS3tOdmhmLm5TjENsrIZfuhjktIHJF8C6zXcPb9Ke5m/tvyP3cwLrUrSTIjH23xQMKc5X/8DITw0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946342; c=relaxed/simple;
	bh=rApctIhVi7cdAOhEyqi+uhU0WgA1lcXErGhYm2mePr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xq04OBHh4eve7etjdxwq/fTKBcihzIawieezkOZ39ua1ko5fe/7L7rOoTG6IP1ho/uIaFL968/XkLDCyLXDKjWK18qroHhkt5XU19GdVz0klNOMr4kwpCOXLqwJZLxexJ9b94xVGK6t61WkdYGR3iw2zzi3GSGJ2hn8naKgl9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRrEAbY2; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c1d6064557so174253eaf.2;
        Thu, 20 Jun 2024 22:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946339; x=1719551139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/GH/FDXuyfNhUERuFE3PVy696MmJwbOJjjtZC6JyQ0=;
        b=gRrEAbY2KaVW59T/edP5Pd3KZThb1831lstBzh0l+mStzmaFatyhEtiI7xfPTy03sw
         GnQDobWFrsPEDNWz8QWlhjQmcg6bSFM6PwIctMB4D37ifAOQZFVzBJTlhzi1YqKmbk7d
         HqofJCvKhWnC+3mdSmKB5wsDU3OtwJdWelASq61pIOSbhPaPUM5cUZwHlM6jjcv+NyrK
         sWLmS/+VkJVK7+qnko8BRd3w6KRSZZ0igA0yDLNI4GWzG/FzcefOI3KqEVJJ3Z0qqUFz
         iqN0JE1yr3SXRujKZyiOOP5mZuG7+dMuncQpOX9+o8QpDyu1oeTL9lxCbo+nU+9IKTKz
         6Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946339; x=1719551139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/GH/FDXuyfNhUERuFE3PVy696MmJwbOJjjtZC6JyQ0=;
        b=WIqkYUz4FvP9eevZLMtBJKAcD5PEACCkGhPa+gMiKV6ILiHLGP3z7QEuOVZNeQLJWL
         AMsAurHKl0Lsxc0s227VJwwK8HddrxRofjpiFuApCbsUmV5TBvG9aQ4g9qhuJIiNahfs
         TNPNcFxVROOEgPeoH/bUCzlI6aB04yNjProJ9rTNS026p2q0x4iosSRetS8EONbQcLaw
         XDy2fPEqOkDV7VCKUge1fswY2AcWU+2+L/9pm1GiUR9TmPVHHbmiPnaZMP4ulQ0bBRql
         PGMdvb04sa2OxmDd/P6LNM4eQZLflRp3sMdqoOf8Z9W73nlE+R20FDgHs1scqbq8IgiK
         qcPg==
X-Forwarded-Encrypted: i=1; AJvYcCVxz3MlW7VNrIHplpEGNj/wYdjhw27y13C3lcZqt9s6YfAVXleQaZW6q57BoOnVkqaUG7yQevFiZD9oH/SVrcFnZrmcCeecQEeoIyDxcL/ii7aWPdgmvz+IFoP2MZwvKrae+1SHrPjmWA==
X-Gm-Message-State: AOJu0YzIHNbeB/gA3Brts5mwPC/PTKyLE7rK9NRl8VQZWFeOo1MF5quF
	7Wf4WaQAMNMyG0Mo72gQIsfqCT082cnl9zUBPxrPQa7NQXnKUGvr
X-Google-Smtp-Source: AGHT+IGMY6E0I5Lt8Z85le6hJOlyVtMszZFqEfk0DT9XTrMxx1GhYOasQGgVO71VoHPbCv7kOB5J6g==
X-Received: by 2002:a05:6358:3127:b0:19f:2c7e:a226 with SMTP id e5c5f4694b2df-1a1fd3d9559mr891749455d.5.1718946339443;
        Thu, 20 Jun 2024 22:05:39 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:05:39 -0700 (PDT)
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
	Allen Pais <allen.lkml@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 00/15] ethernet: Convert from tasklet to BH workqueue
Date: Thu, 20 Jun 2024 22:05:10 -0700
Message-Id: <20240621050525.3720069-1-allen.lkml@gmail.com>
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
commit a6ec08beec9e ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

First version converting all the drivers can be found at:
https://lore.kernel.org/all/20240507190111.16710
-2-apais@linux.microsoft.com/


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

 drivers/net/ethernet/alteon/acenic.c          | 26 +++----
 drivers/net/ethernet/alteon/acenic.h          |  8 +--
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 30 ++++----
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c      | 16 ++---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c     | 16 ++---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          | 10 +--
 drivers/net/ethernet/broadcom/cnic.c          | 19 ++---
 drivers/net/ethernet/broadcom/cnic.h          |  2 +-
 drivers/net/ethernet/cadence/macb.h           |  3 +-
 drivers/net/ethernet/cadence/macb_main.c      | 10 +--
 .../net/ethernet/cavium/liquidio/lio_core.c   |  4 +-
 .../net/ethernet/cavium/liquidio/lio_main.c   | 24 +++----
 .../ethernet/cavium/liquidio/lio_vf_main.c    | 10 +--
 .../ethernet/cavium/liquidio/octeon_droq.c    |  4 +-
 .../ethernet/cavium/liquidio/octeon_main.h    |  4 +-
 .../net/ethernet/cavium/octeon/octeon_mgmt.c  | 13 ++--
 drivers/net/ethernet/cavium/thunder/nic.h     |  5 +-
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 24 +++----
 .../ethernet/cavium/thunder/nicvf_queues.c    |  4 +-
 .../ethernet/cavium/thunder/nicvf_queues.h    |  2 +-
 drivers/net/ethernet/chelsio/cxgb/sge.c       | 19 ++---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  9 +--
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
 .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  |  4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.c    |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c      | 40 +++++------
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c    |  6 +-
 drivers/net/ethernet/dlink/sundance.c         | 41 +++++------
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |  2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  | 17 +++--
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.h  |  2 +-
 drivers/net/ethernet/ibm/ehea/ehea.h          |  3 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c     | 14 ++--
 drivers/net/ethernet/ibm/ibmvnic.c            | 24 +++----
 drivers/net/ethernet/ibm/ibmvnic.h            |  2 +-
 drivers/net/ethernet/jme.c                    | 72 +++++++++----------
 drivers/net/ethernet/jme.h                    |  8 +--
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  4 +-
 drivers/net/ethernet/marvell/skge.c           | 12 ++--
 drivers/net/ethernet/marvell/skge.h           |  3 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c    | 12 ++--
 drivers/net/ethernet/mediatek/mtk_wed_wo.h    |  3 +-
 43 files changed, 273 insertions(+), 266 deletions(-)

-- 
2.34.1


