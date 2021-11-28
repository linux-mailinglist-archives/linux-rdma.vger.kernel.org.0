Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327C5460621
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Nov 2021 13:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbhK1Mmq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Nov 2021 07:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbhK1Mkp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Nov 2021 07:40:45 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86B7C061759
        for <linux-rdma@vger.kernel.org>; Sun, 28 Nov 2021 04:37:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 137so12312071wma.1
        for <linux-rdma@vger.kernel.org>; Sun, 28 Nov 2021 04:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kryo-se.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LcBtqbRPkEcsZfTVxey43CZc666mGtsTaMbpCcH3s5g=;
        b=EFGSv3vr1jlJ/3OMklxcssKtiEGwrXuZR4CYy49g2ILzX8LCZv42cKGCrlgF94UaAR
         fJzYXAAHNBb0rJsfAuc0DYrr3AM7KMyuGTeCUEapqAzfvCQ6ub2bS4bq1NMHwZQRAo3c
         UYOzndMo+SQ7jD+XM6MMtVyJo1UfH2XO+jcqAakyvfrbmErRkhvy2cuqXiZynZeIHnUd
         K6M8trgx348nfu/shp7EacR2qsTamZx2vMKL0BwmAaUnlU0Zw5qwwBF6ZVSt1ARptJAI
         30gCfj+PQkYRad5Jt+lKq9suUS5kV9dAnrEkmt3DsBUkIcf5DK8EHepZYdOhdSKn2+Wy
         7idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LcBtqbRPkEcsZfTVxey43CZc666mGtsTaMbpCcH3s5g=;
        b=1WkSTUT4XAfjsMS5wpoqrI+PLSRDpYe4PDWlViszdR4Kkn3+a3fLiTXN4aQj0BMbTi
         71LRBnXlq0JFFRT1knMspNLum+B3HP2qvqJ4yT4Hoa9VgDoPF4x6JeN/UkoJ4XoiJ07K
         HrYJEw+nuK+M9ogaz9jMx8iJyqTqHPQz8VxvhZuWBhJ1+EY1YQSuYmIz68KI/jtauvJc
         r8yadnRwel0S8mxZIOCz9fZWWN+9y1z9Y6N8WbFt6BBgoK/2CKvoQsfctHpfxC2Fp/2o
         +72z6Rmbrdrp69hTtxVZTJqL728Inb8LNfCflYMC1i/lVUcZoYlB3mwXMbI/8a6paCs5
         8X+g==
X-Gm-Message-State: AOAM530M2z3SPzVcOVtEC1n6Zxidf+EUmKa87HObY2AOcEO3rFGub+/2
        3B7Pfu8cwipuTTQE6Tr0bRUmMNJidWtC7flK
X-Google-Smtp-Source: ABdhPJzoYvlmfuiKv+WzJ+bzTDTdJ/1Ukqz8IBwpUamRawGyGPn7UwPf0/m9fhSyxaXJfWgNsb3osA==
X-Received: by 2002:a05:600c:3505:: with SMTP id h5mr28916296wmq.22.1638103041103;
        Sun, 28 Nov 2021 04:37:21 -0800 (PST)
Received: from kerfuffle.. ([2a02:168:9619:0:5497:3715:36d:f557])
        by smtp.gmail.com with ESMTPSA id y6sm16242178wma.37.2021.11.28.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 04:37:20 -0800 (PST)
From:   Erik Ekman <erik@kryo.se>
To:     Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Erik Ekman <erik@kryo.se>,
        Michael Stapelberg <michael@stapelberg.ch>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx4_en: Update reported link modes for 1/10G
Date:   Sun, 28 Nov 2021 13:37:11 +0100
Message-Id: <20211128123712.82096-1-erik@kryo.se>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When link modes were initially added in commit 2c762679435dc
("net/mlx4_en: Use PTYS register to query ethtool settings") and
later updated for the new ethtool API in commit 3d8f7cc78d0eb
("net: mlx4: use new ETHTOOL_G/SSETTINGS API") the only 1/10G non-baseT
link modes configured were 1000baseKX, 10000baseKX4 and 10000baseKR.
It looks like these got picked to represent other modes since nothing
better was available.

Switch to using more specific link modes added in commit 5711a98221443
("net: ethtool: add support for 1000BaseX and missing 10G link modes").

Tested with MCX311A-XCAT connected via DAC.
Before:

% sudo ethtool enp3s0
Settings for enp3s0:
	Supported ports: [ FIBRE ]
	Supported link modes:   1000baseKX/Full
	                        10000baseKR/Full
	Supported pause frame use: Symmetric Receive-only
	Supports auto-negotiation: No
	Supported FEC modes: Not reported
	Advertised link modes:  1000baseKX/Full
	                        10000baseKR/Full
	Advertised pause frame use: Symmetric
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: 10000Mb/s
	Duplex: Full
	Auto-negotiation: off
	Port: Direct Attach Copper
	PHYAD: 0
	Transceiver: internal
	Supports Wake-on: d
	Wake-on: d
        Current message level: 0x00000014 (20)
                               link ifdown
	Link detected: yes

With this change:

% sudo ethtool enp3s0
	Settings for enp3s0:
	Supported ports: [ FIBRE ]
	Supported link modes:   1000baseX/Full
	                        10000baseCR/Full
 	                        10000baseSR/Full
	Supported pause frame use: Symmetric Receive-only
	Supports auto-negotiation: No
	Supported FEC modes: Not reported
	Advertised link modes:  1000baseX/Full
 	                        10000baseCR/Full
 	                        10000baseSR/Full
	Advertised pause frame use: Symmetric
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: 10000Mb/s
	Duplex: Full
	Auto-negotiation: off
	Port: Direct Attach Copper
	PHYAD: 0
	Transceiver: internal
	Supports Wake-on: d
	Wake-on: d
        Current message level: 0x00000014 (20)
                               link ifdown
	Link detected: yes

Tested-by: Michael Stapelberg <michael@stapelberg.ch>
Signed-off-by: Erik Ekman <erik@kryo.se>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 066d79e4ecfc..10238bedd694 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -670,7 +670,7 @@ void __init mlx4_en_init_ptys2ethtool_map(void)
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_1000BASE_T, SPEED_1000,
 				       ETHTOOL_LINK_MODE_1000baseT_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_1000BASE_CX_SGMII, SPEED_1000,
-				       ETHTOOL_LINK_MODE_1000baseKX_Full_BIT);
+				       ETHTOOL_LINK_MODE_1000baseX_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_1000BASE_KX, SPEED_1000,
 				       ETHTOOL_LINK_MODE_1000baseKX_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_10GBASE_T, SPEED_10000,
@@ -682,9 +682,9 @@ void __init mlx4_en_init_ptys2ethtool_map(void)
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_10GBASE_KR, SPEED_10000,
 				       ETHTOOL_LINK_MODE_10000baseKR_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_10GBASE_CR, SPEED_10000,
-				       ETHTOOL_LINK_MODE_10000baseKR_Full_BIT);
+				       ETHTOOL_LINK_MODE_10000baseCR_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_10GBASE_SR, SPEED_10000,
-				       ETHTOOL_LINK_MODE_10000baseKR_Full_BIT);
+				       ETHTOOL_LINK_MODE_10000baseSR_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_20GBASE_KR2, SPEED_20000,
 				       ETHTOOL_LINK_MODE_20000baseMLD2_Full_BIT,
 				       ETHTOOL_LINK_MODE_20000baseKR2_Full_BIT);
-- 
2.33.1

