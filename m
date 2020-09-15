Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C28326A300
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgIOKRY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIOKRO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Sep 2020 06:17:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F31EC06174A;
        Tue, 15 Sep 2020 03:17:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so2806251wmi.1;
        Tue, 15 Sep 2020 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsGi0JQoJFYExpZv5IKen/TvRayT7TQ3lBJ+W8DLyKQ=;
        b=UWgjLAu/s9I4mTNInOri41CwAUD9uaDvrBqDolg0yTXUyejinL0GevwA/gyyCBXPQb
         7EI9M/K4rENREWX4R04CzCvZ4muLoQb0Ltdxol26RvaHH58x2pxmIBycyqEHeMJODZyO
         nq3PTcWrbefWCDCh8I09ON991FLHvOn3xKrGwq2Og5LJLPIlVD0HWacgHBhwdH2B0M3c
         BZRgs24cMaFR/EuwUirY0///M7vBRr8Zu+Brm/KEDftR0w9FuMtfl+JlWuXWwpEQ1VRC
         r72f4lqdSP7KTjuIyv2ToJcA0P+x+K1dMqfBD3bFqSY8vqkT0G0czOFV6omDgjIeZAY0
         PX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsGi0JQoJFYExpZv5IKen/TvRayT7TQ3lBJ+W8DLyKQ=;
        b=AXeyCGQIVJMfcavR6wcSt+1Tai1djdGWqaERkg7Nv5x9TnxBzEihTDGFZJMMqkz5vi
         gcpKTIzVLefrn7d8viJADxl8wvcNi+R4OsZE2rlbivoklLhsXCqShOjBb0jd3J/kvoBL
         eP5JGU+q0Lk018WfUhCs22Q0XzPNcdzCms5y4liFQaGQ/lOhTZv01nRLNrGKPhZpUw7d
         v7SLW4Vs5OFfoHbp9HxOJoycGHUaDjIkAP3QGsvSZ5lMBFIxWB7nYfBT7Yf2oCXFnl/V
         WIxL3E3dw/lA1i7DTK2EsjzAT1lcCG/fHxkUzm1lzLMzFCSuBcKYxJFbns+xmYDkYhie
         aDUA==
X-Gm-Message-State: AOAM531I0Dw8Gd+ujMXKned701XqVLaqL/mYXEt2WtEprNU7BFEGBbdW
        3tpoI+zj1q7PgcIMxd31tjyvegWyiriLSg==
X-Google-Smtp-Source: ABdhPJxSLJnTZS5iBpeppjcFzotLOcGHpIfmPZkNxHh/wNTPEJHQAt30J3BRZ/GU1v4KTEhVYEuFPA==
X-Received: by 2002:a05:600c:214e:: with SMTP id v14mr4116017wml.118.1600165031323;
        Tue, 15 Sep 2020 03:17:11 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id n3sm7132225wmn.39.2020.09.15.03.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:17:10 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     dledford@redhat.com
Cc:     jgg@mellanox.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] IB/rxe: fix kconfig dependency warning for RDMA_RXE
Date:   Tue, 15 Sep 2020 13:16:00 +0300
Message-Id: <20200915101559.33292-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When RDMA_RXE is enabled and CRYPTO is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for CRYPTO_CRC32
  Depends on [n]: CRYPTO [=n]
  Selected by [y]:
  - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && (!64BIT || ARCH_DMA_ADDR_T_64BIT [=n])

The reason is that RDMA_RXE selects CRYPTO_CRC32 without depending on or
selecting CRYPTO while CRYPTO_CRC32 is subordinate to CRYPTO.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: 0812ed132178 ("IB/rxe: Change RDMA_RXE kconfig to use select")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/infiniband/sw/rxe/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
index a0c6c7dfc181..e1f52710edfc 100644
--- a/drivers/infiniband/sw/rxe/Kconfig
+++ b/drivers/infiniband/sw/rxe/Kconfig
@@ -4,6 +4,7 @@ config RDMA_RXE
 	depends on INET && PCI && INFINIBAND
 	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
 	select NET_UDP_TUNNEL
+	select CRYPTO
 	select CRYPTO_CRC32
 	select DMA_VIRT_OPS
 	help
-- 
2.25.1

