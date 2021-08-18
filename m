Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3053F0871
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhHRPxE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 11:53:04 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33950
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239922AbhHRPxB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 11:53:01 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 4C81A40CD9
        for <linux-rdma@vger.kernel.org>; Wed, 18 Aug 2021 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629301944;
        bh=a4yimsaD54f0w0M2iKmjYx0RkapSJobec2lRCuhnCeI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=cFmBtr8aGX3B+qeCIFJ8oDi7Q57vqslSzCyV2Ht/CGhplf0AFG54eNvD2eHzgauef
         L/CcROa/X4R/2MxnVdM9v4iMG7G7PiqeQG/H6ptu1uWlQu2XdawSsyMIelYfZiBM/c
         Pwmdm7saqErzVZiWIbofGoIxESsJBXynqL3MJswUxW9neYgS+Bhw0wAGMn1CcPabK+
         t3pmrEn+a9BnryD/Scv5JDZXosQF1e7Ty3juO8uceB4T/rGNWh3+IJMPgc4yUvfm3T
         Biilji5znRWi5d0anOWO4Y1jmCq17qOKfAOAjQLK1zRG4uapGK7LQ2qqc8DPGpX2UP
         2RA5pC5cF5irw==
Received: by mail-pg1-f199.google.com with SMTP id 184-20020a6303c10000b029023d089ffadfso1670375pgd.5
        for <linux-rdma@vger.kernel.org>; Wed, 18 Aug 2021 08:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4yimsaD54f0w0M2iKmjYx0RkapSJobec2lRCuhnCeI=;
        b=FNtTlUsih0T7aAihFh6pgfHJ1+nal0OXz4q4B/n/HBNciKq/XVrBYXzjdrLH/nS4ta
         lzAUxNb+3QRXwQhQBsm+CsSpZhmuv3GsTDY/nWrhg8hW41ERbo1DLy7XS2u89nUtrfPg
         PTZNUJ7ajYyoRUgrooUi9nV+gLGZe+PmA6S7c/GI0dviK8ZjrerKkJr7rBCIB+8kbg/G
         bXhjEQQ+qHL2zERyz7EXLjSB09KCaHnl2xgb40vN7MVZdtoPwDZJXTYex3kQzZMlpqpL
         LahLUElGfAjpx6aWnq2fpWhbHk22yPnRtvOFsTNsTiaV1EhA/uSc2ho6UboGyvALF+H7
         UlIg==
X-Gm-Message-State: AOAM531S4Z1Jt8B06pQzF8X0aSKpwaMbFGcmkN61jmaVDbEXbZTq3abI
        glCI7kNcQb6CcnyZQoAXVAfqehBjfwLivT5jkblcZyjnqDvO/34R4dhxkPpnw4ee949237FJ4kA
        3qhXCi2CAwV7h90Q/I17m91ey7ea7aCxzJGfZxII=
X-Received: by 2002:a05:6a00:10cf:b0:3e2:139b:6d6c with SMTP id d15-20020a056a0010cf00b003e2139b6d6cmr10152668pfu.3.1629301942799;
        Wed, 18 Aug 2021 08:52:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyr41UVZeTDSI360h/gDC1oF4ZXumjqyY+ZQgymCzpmdw7UeXfWqDIYa7yOfQqyWYoB6UZSOw==
X-Received: by 2002:a05:6a00:10cf:b0:3e2:139b:6d6c with SMTP id d15-20020a056a0010cf00b003e2139b6d6cmr10152635pfu.3.1629301942520;
        Wed, 18 Aug 2021 08:52:22 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id g10sm145654pfh.120.2021.08.18.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:52:22 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     tim.gardner@canonical.com, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Vlad Buslov <vladbu@nvidia.com>,
        Jianbo Liu <jianbol@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Roi Dayan <roid@nvidia.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH][linux-next] net/mlx5: Bridge, fix uninitialized variable in mlx5_esw_bridge_port_changeupper()
Date:   Wed, 18 Aug 2021 09:52:10 -0600
Message-Id: <20210818155210.14522-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A recent change removed code that initialized the return code variable 'err'. It
is now possible for mlx5_esw_bridge_port_changeupper() to return an error code
using this uninitialized variable. Fix it by initializing to 0.

Addresses-Coverity: ("Uninitialized scalar variable (UNINIT)")

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Vlad Buslov <vladbu@nvidia.com>
Cc: Jianbo Liu <jianbol@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>
Cc: Roi Dayan <roid@nvidia.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 0c38c2e319be..c6435c69b7c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -137,7 +137,7 @@ static int mlx5_esw_bridge_port_changeupper(struct notifier_block *nb, void *ptr
 	u16 vport_num, esw_owner_vhca_id;
 	struct netlink_ext_ack *extack;
 	int ifindex = upper->ifindex;
-	int err;
+	int err = 0;
 
 	if (!netif_is_bridge_master(upper))
 		return 0;
-- 
2.33.0

