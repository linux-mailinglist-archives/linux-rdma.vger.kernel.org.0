Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134D564724
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfGJNjn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 09:39:43 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:60928 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfGJNjm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 09:39:42 -0400
Received: from ramsan ([84.194.98.4])
        by baptiste.telenet-ops.be with bizsmtp
        id b1ff2000g05gfCL011ffzv; Wed, 10 Jul 2019 15:39:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hlCot-0005BA-TD; Wed, 10 Jul 2019 15:39:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hlCot-0006vc-Qf; Wed, 10 Jul 2019 15:39:39 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH -next] rdma/siw: Add missing dependencies on LIBCRC32C and DMA_VIRT_OPS
Date:   Wed, 10 Jul 2019 15:39:30 +0200
Message-Id: <20190710133930.26591-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If LIBCRC32C and DMA_VIRT_OPS are not enabled:

    drivers/infiniband/sw/siw/siw_main.o: In function `siw_newlink':
    siw_main.c:(.text+0x35c): undefined reference to `dma_virt_ops'
    drivers/infiniband/sw/siw/siw_qp_rx.o: In function `siw_csum_update':
    siw_qp_rx.c:(.text+0x16): undefined reference to `crc32c'

Fix the first issue by adding a select of DMA_VIRT_OPS.
Fix the second issue by replacing the unneeded dependency on
CRYPTO_CRC32 by a dependency on LIBCRC32C.

Reported-by: noreply@ellerman.id.au (first issue)
Fixes: c0cf5bdde46c664d ("rdma/siw: addition to kernel build environment")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/infiniband/sw/siw/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index 94f684174ce3556e..b622fc62f2cd6d46 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,6 +1,7 @@
 config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
-	depends on INET && INFINIBAND && CRYPTO_CRC32
+	depends on INET && INFINIBAND && LIBCRC32C
+	select DMA_VIRT_OPS
 	help
 	This driver implements the iWARP RDMA transport over
 	the Linux TCP/IP network stack. It enables a system with a
-- 
2.17.1

