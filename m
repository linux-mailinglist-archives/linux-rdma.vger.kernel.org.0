Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79DBABD16
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2019 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfIFP5w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Sep 2019 11:57:52 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47473 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfIFP5w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Sep 2019 11:57:52 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mq1GE-1iRdCD3TDm-00nCjn; Fri, 06 Sep 2019 17:57:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Parav Pandit <parav@mellanox.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kamal Heib <kamalheib1@gmail.com>,
        Florian Westphal <fw@strlen.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usnic: avoid overly large buffers on stack
Date:   Fri,  6 Sep 2019 17:57:17 +0200
Message-Id: <20190906155730.2750200-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HDVOY8kxC3eE7WALG7hVfJjSyAaTZ+KrGpPg9ZJuJr4ZTdvo8jK
 f1Wa/p/V5VdaUvKpS6tZcVXcH7QpsfvQ+g6H1/exQ2gHY2eWz1DOj8VT6vclR6fnTt/ZDv6
 8XoG/aMJONzPlOPveIz1L6juODhrNmt08eESlBG+9JcCje9aUxS+CXdivVkRQKyrCIqhaRv
 Jpf8n9+H52aZmMFJ8KlGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lM5YSSTMTMM=:TuZtY5jhLgJsRVZQAUYnVN
 tb1fPknLz/eHVwUCA7Oi/y4qNo8cuZgjwMqn+EpIreYJE79TUEx9jUKc82wc+Zc8naaVd1Fom
 BO9V6jpQwi+qRKNF9yxGRkc1Nk9NZcuGf7evk12WKOU182xhqNm8Hrmz5Wsu1WL5PMnTOBc1i
 lAs3MDlttRh+EzIjJLzlIUUCue0+SRc/s4KyXQpDjikUFt2SsZ4CfTePVa+rsoCUmM98qvHnX
 8QSHulnXjgeutDP0qpgyhQcbkMoZKKVWqT44k8M/cvqSxwh1fQVXIX9117cj/KDwJz+3yxXmf
 vXN0hiyaY1HYQu5baLynt8W92uKgpDhFnKmP4n7SJU6aLPv8AjvUe508DPz7unZPfhaRQidVL
 M/oWtA2eoYtD9HgsAPK0mxh4EhoBDilicgwbx5MN5a9o6A/kXX/N4Yteqtf8qUom9Yw0b3cDC
 7FV1UFPg0vzNgFjXyfbpNQR/974UUYSlduQK+nLVqCB0vtgUQWOXf4ngWFMihVYFsTMCffhbD
 bdRcEBvKiYVPrG7DP2GbxM/+MhEK/PjPIj3JUufLEroW5b2sM7fh70Je4WiIH36A8uI2UKM+I
 ID8HyzMF+bqAFCKhcUT/Mo/LfB82XIJjEwzFHFK0claq83zcEJMBLNoecPuAUKf6Wk/AJbd9Y
 rK74+GmZHBZ43KabyIavElUnm3zu0am2at8nbZERwq52SGFmAU6oyvUYiw1Cky8yQZ5H90xpk
 gnXJILY01U4ixOX3xUCxst4fo4b6lvIDIh22en6QGicoqKHIKtGJ6R32ZL4JOiQC1edNg44XI
 pmq2PPgWcFWLTZtn8YcmVlVLGDbyA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's never a good idea to put a 1000-byte buffer on the kernel
stack. The compiler warns about this instance when usnic_ib_log_vf()
gets inlined into usnic_ib_pci_probe():

drivers/infiniband/hw/usnic/usnic_ib_main.c:543:12: error: stack frame size of 1044 bytes in function 'usnic_ib_pci_probe' [-Werror,-Wframe-larger-than=]

As this is only called for debugging purposes in the setup path,
it's trivial to convert to a dynamic allocation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/usnic/usnic_ib_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 03f54eb9404b..c9abe1c01e4e 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -89,9 +89,15 @@ static void usnic_ib_dump_vf(struct usnic_ib_vf *vf, char *buf, int buf_sz)
 
 void usnic_ib_log_vf(struct usnic_ib_vf *vf)
 {
-	char buf[1000];
-	usnic_ib_dump_vf(vf, buf, sizeof(buf));
+	char *buf = kzalloc(1000, GFP_KERNEL);
+
+	if (!buf)
+		return;
+
+	usnic_ib_dump_vf(vf, buf, 1000);
 	usnic_dbg("%s\n", buf);
+
+	kfree(buf);
 }
 
 /* Start of netdev section */
-- 
2.20.0

