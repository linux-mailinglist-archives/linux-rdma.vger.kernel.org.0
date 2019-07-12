Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404D766961
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfGLIxX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 04:53:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35751 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfGLIxX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 04:53:23 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N7zJl-1iZCS82YIV-014xdb; Fri, 12 Jul 2019 10:53:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rdma/siw: fix enum type mismatch warnings
Date:   Fri, 12 Jul 2019 10:53:04 +0200
Message-Id: <20190712085314.3974907-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8iWClpmbXxnlV2N+r4s16RVUWQy/lLRG7xIZbD65OGr4GY3zpum
 hIh0oAjDiZoJA0g1zbd7HMc5DxOLmYZg88rbPnn0XsJN2dr9guwIQps/8ULp8VvmUhGRR2M
 ONfSk0mirJWYhTIuDdngeIdFfsdCUtLYOUsn3CAA31Dzpbz+UiqFJvjBVh1Jiv7SxP3ppNg
 x8O/l/1itebdimFJkLAXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IRRjqEpKqLg=:c2+XX7gqRcai7/WSFVMgFG
 PU3LQ/0NuFvpxt1/6fWHR+ZmJdWKT+5ZZq95nGhdgPwwlYwiE2yukyTU7tsVfR0gREPCuVwfQ
 0fBoBVLkfmJY9VQe9HrBfShA71S+VC1JNwLi3fOek3ZkhnjFAm5Ytzi881mzghb90Ofj7R4kC
 k4KSeDJLlfmm5cq9lG3V6L3AdKEF7R1PM6U+Gyb9ddnqMw/Q/mqcORj8JgjKt4K2sM2b2LW/N
 NSUAxLOyKZhmCQVXKdY56oN1+uyD8QhoQ8p8DDOEtiGnq+r1ehH+1hd+p1H+u5gYNlVmEYZsv
 QY3ezySe7qxqHxaTgQwygGVVqGYZlZ+vumK4zSE8xtu1mtTz7zPYrqjDV+TbnYlqO41AkvZXZ
 9jDDSlS+xdUmEBZXzEPrwSUp5iHGbySus332/skyC5RkqhFcJ/GlhMjr9dHsEYekbu2xw61BM
 Uu6DPagT/QlTDImhldfJJwncdS0OIrfFGOsXz/tV3MWpsASAw7ULbzRtNCuDThzNoy+AwW/SG
 qtk2OpqfToke4St5z42UImqwdyFIVC5LwEzSOMfs6JiY8fvBepziiammZq+/5YMKvs21od6WV
 z0RK1Z2MrJnCnyemLcKgJmCaNXj1Ti0BZABCdowq58wsea0Z1QMcUgFZoM+j4qhmcXhu4w41M
 omH8N2k30+nW9Erz3hgQD/umCYv/tyOqRTdVGjlndDnjWmfwLjI9tjXEujU2bcU315Pi5Tawo
 ZKH/PSyaNw2S0qiw4pcOEB6Px+lQMJ6lPklQwA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The values in map_cqe_status[] don't match the type:

drivers/infiniband/sw/siw/siw_cq.c:31:4: error: implicit conversion from enumeration type 'enum siw_wc_status' to different enumeration type 'enum siw_opcode' [-Werror,-Wenum-conversion]
        { SIW_WC_SUCCESS, IB_WC_SUCCESS },
        ~ ^~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_cq.c:32:4: error: implicit conversion from enumeration type 'enum siw_wc_status' to different enumeration type 'enum siw_opcode' [-Werror,-Wenum-conversion]
        { SIW_WC_LOC_LEN_ERR, IB_WC_LOC_LEN_ERR },
        ~ ^~~~~~~~~~~~~~~~~~

Change the struct definition to make them match and stop the
warning.

Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/sw/siw/siw_cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
index e2a0ee40d5b5..e381ae9b7d62 100644
--- a/drivers/infiniband/sw/siw/siw_cq.c
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -25,7 +25,7 @@ static int map_wc_opcode[SIW_NUM_OPCODES] = {
 };
 
 static struct {
-	enum siw_opcode siw;
+	enum siw_wc_status siw;
 	enum ib_wc_status ib;
 } map_cqe_status[SIW_NUM_WC_STATUS] = {
 	{ SIW_WC_SUCCESS, IB_WC_SUCCESS },
-- 
2.20.0

