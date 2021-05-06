Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F093375D8F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhEFXjn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhEFXjm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:39:42 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E0C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=ysiqFt6wjmuvvJ3BMaZhbil9Yy6iEDpm6PVV3IzjKEU=; b=Vzs94vp+2fYixqb5Xz0QFiBsNq
        12kpt5xs+SB44DvwL24V6+Hs8e0jm1BG8ZViWRoYanvlXRqkZa9fgDDaTOBaBFyj8KFFDFMlAx37w
        /OYwpwzaok2PRiTepw8ClojHVh9R5pSv7f1FAL0HeN4NNQfqec5Ie+MZC3I6c1v0SNyH1Vy3ylX9d
        dQTK/clq3Ncv+/as6aHhP+HiP/yv5ivmaGbjt3lUVzReKNG0QCXXppYIRVFDowHdeqKbyfNgJB+dt
        PlHli590Rjbpt8oeUO0OG6HVYaV20xs9MLjJ9K4XCY/JoZ5wBXfay3Gwtn13HR6rSDDzHanY1cUZA
        2cKFvgfmlvmRWTs6vZDrEmFdMkpWN4tU9sSB4uhA9ccHDXmHsf8iRNwPv+Mhgxg40cB3Rl+Vu+FBS
        q8z+g9ohTDGRoVrUmdzEanFUe+FGylY7Vcw5ULonkh9NsysVQ6N5KsfDcru0vn9J9KAH0o21aIh1k
        tp0zrGSARMvfmXTFqf5VyPBE;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenZp-0004Lg-Kc; Thu, 06 May 2021 23:38:41 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 16/31] rdma/siw: use error and out logic at the end of siw_connect()
Date:   Fri,  7 May 2021 01:36:22 +0200
Message-Id: <3c43552c9b61a4d2352ae3680bfcacc25a9cc9b4.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This will make the following changes easier.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 41d3436985a6..ec6d5c26fe22 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1539,14 +1539,19 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		cep->mpa.pdata = NULL;
 	}
 
-	if (rv >= 0) {
-		rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
-		if (!rv) {
-			siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
-			siw_cep_set_free(cep);
-			return 0;
-		}
+	if (rv < 0) {
+		goto error;
+	}
+
+	rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
+	if (rv != 0) {
+		goto error;
 	}
+
+	siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
+	siw_cep_set_free(cep);
+	return 0;
+
 error:
 	siw_dbg(id->device, "failed: %d\n", rv);
 
-- 
2.25.1

