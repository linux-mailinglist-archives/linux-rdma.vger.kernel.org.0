Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C059214FEE
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 23:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgGEVpq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 17:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgGEVpq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 17:45:46 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7304C061794
        for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2020 14:45:45 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 7F219BC127;
        Sun,  5 Jul 2020 21:45:39 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     aditr@vmware.com, pv-drivers@vmware.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: VMWare PVRDMA driver
Date:   Sun,  5 Jul 2020 23:45:28 +0200
Message-Id: <20200705214528.28561-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h          | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cmd.c      | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h  | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c     | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c       | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h     | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
index c142f5e7f25f..862d6c2e8b87 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cmd.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cmd.c
index 4a78c537d8a1..7d585e0bd56d 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cmd.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cmd.c
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index 4f6cc0de7ef9..05be5c7d1fce 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
index 86a6c054ea26..34522b23dc82 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c
index bf51357ea3aa..a2dc768a34af 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 780fd2dfc07e..12f2e19a21a0 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c
index 7944c58ded0e..e3f2b516b300 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
index b039f1f00e05..4f6cffcd21f2 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index afcc2abcf55c..c27554b0c3c5 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
index 8b558ae234c8..2a99bbb40ca5 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
index d330decfb80a..6c54beb9c164 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index ccbded2d26ce..0029598ff949 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 267702226f10..ad4d51ab8cc9 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -8,7 +8,7 @@
  * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
  * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
  * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ * https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program available in the file COPYING in the main
-- 
2.27.0

