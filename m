Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B78C6695E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 10:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfGLIxC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 04:53:02 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfGLIxC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 04:53:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mum6l-1idY2v3fPf-00rnml; Fri, 12 Jul 2019 10:52:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rdma/siw: select CONFIG_DMA_VIRT_OPS
Date:   Fri, 12 Jul 2019 10:52:42 +0200
Message-Id: <20190712085253.3965945-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wCFOA0CycKu+Z05bKx8yWCyvQio4U3zT7P3w2jzGrCUExyhfL/q
 ZZwvzLBFgFeMaWBTC4Smgm3iav3IDmC2cYfLlkBLyWZT+Z17TIBatUyBpMIIE0FvKAbNHkk
 Mre/AYTQPfH8K6UFNW0sbeWjr6w4q9TLCThFVLa1ko2FR1X5HJWX4s4HXmCbKZ9NETnZpuF
 kVGmcKkq6t6oTh+N1htlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dj7UNo/Gs78=:tDSmwTVdiefhQAkppIKVey
 Y0hGlG4B6wOXGZvb1Mct++bEe4+gIG3dauuatZeXfjcETzfymYRL+G6FloD2710HsGipE7T/R
 lODoDj7T3MbFSayQysa1TVdDOSwLIP2hLy8SIIy1NB81rwEyF3S2a1Nff36Clm3AHwEsA+VFe
 TGwwitSizNdYqbYvFLGzDhus9WQvwtH2diy5cJJ9T6FyJNOtAqzmUlznSoJXIGMSvlhU0AYkr
 ciG9lZwmLslyxle6lwC0jpynMMLbDCuuBjc6S5dhwsvp6Z//NqX6gjhOBCI1ii6JZGzopdHwn
 Ih9cJv1guFMguNIRAHP676m5OFdOU1xSNYAqCTdQ0SWi4Z6cJ3wH4qnkvCZCabJbOnQySV6hD
 8UlUSr3PfMExiU5fDYoUaRIHKybq3bfAkDRcmAn3uPqE899tNn+EIcw9ZfRbHudTVAHVrihis
 LFgCi1gyIJXhAF/1FpYN47sfTKICp90R3ql/+/ZEFAvdo3FHI2IiZOvVjQ13W32SYDVn9r5Gx
 Nb396/i7cnFhaDWAJN8/c8SrG4vIeDxyL5Q+kUtMBBTfEGVwlhLdeGZE2svnyIqaZtLalk9wk
 3LasVDoR7m+3yUiypAwRmdNAf8gyj3N+NTtIJHIhFMBCju4V5WbDkT8lqKmM9xsqzVH215Mn8
 pfjZGUgwo0uRp5kJmnYTLYgqQ9NRWhRNhIWO6esaVyO9hEtRXm3+vFJNbjHqZ6OEwZVnwJijb
 85cKRc6NG299/nVcrbnGXpeqBBUzPcME9e5QuQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Without this symbol we get a link failure:

ERROR: "dma_virt_ops" [drivers/infiniband/sw/siw/siw.ko] undefined!

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/sw/siw/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index 94f684174ce3..ea282789f466 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,6 +1,7 @@
 config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
 	depends on INET && INFINIBAND && CRYPTO_CRC32
+	select DMA_VIRT_OPS
 	help
 	This driver implements the iWARP RDMA transport over
 	the Linux TCP/IP network stack. It enables a system with a
-- 
2.20.0

