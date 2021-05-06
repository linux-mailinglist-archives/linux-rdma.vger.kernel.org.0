Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA1375D99
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhEFXkf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhEFXkf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:40:35 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AFDC061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=ZsobkM1YfPjvMwiTYMVy+t1N2zoP6ZDVULTZ3u7YKE4=; b=iGlEwMOz41yv8LNNu/p+0O1LEW
        QAzpX0Ek+K1mUmyuKVC51lVgkJYJE3Obxxq+amh1YZ5n/YivCfu10chkEPByRXJjAbUrmTqUkKU2N
        /f1MChgVZ+JT4enjhd+LJIBBKW7uLf+gRWQrTViOBgMyViTiwDqHwO0jS8nICXBLIXqlP9H0KjRNu
        zfpKiSyR+nm4VDcGCM8l9hWCGF4W69+BNDriJy26pd+DU7KgapxiLpFRIs3ImlacR9RxiFErJUJ//
        WE2GEtEPFBjxjcA8zt2lmAmuZhuS1v3ov9gKeLIGmrVmCUXs6cRm5H6lHXt42fICtCDHWkRSdQMSj
        HZ4ieN8zc9QLfNy/rQWWSCrJw4oAEASNuM9CL9mAYgRttFE+Exc+s3MmxmZrdNFZn3txa8sMuHZNn
        TKJHJUzeMAZNDmmSx4kW6jQkBO86uWh97K8E2DZ/+C+OA7j/YDluM+bqZBuGWTvWrHKbv4B5Gx7Xt
        ki2alBLoM2fxVhpaRtbGoCbb;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenag-0004NX-Af; Thu, 06 May 2021 23:39:34 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 24/31] rdma/siw: do the full disassociation of cep and qp in siw_qp_llp_close()
Date:   Fri,  7 May 2021 01:36:30 +0200
Message-Id: <05e4a83a1b65d0cf47f4d0501f6dd081bce75602.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's much clearer to drop the references on both sides and reset the
cross referencing pointers in one place. I makes the caller much saner
and understandable.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 2 --
 drivers/infiniband/sw/siw/siw_qp.c | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 7fd67499f1d3..31135d877d41 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1240,10 +1240,8 @@ static void siw_cm_work_handler(struct work_struct *w)
 			siw_cep_set_free(cep);
 
 			siw_qp_llp_close(qp);
-			siw_qp_put(qp);
 
 			siw_cep_set_inuse(cep);
-			cep->qp = NULL;
 			siw_qp_put(qp);
 		}
 		if (cep->sock) {
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index ddb2e66f9f13..badb065eb9b1 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -166,8 +166,11 @@ void siw_qp_llp_close(struct siw_qp *qp)
 	 * Dereference closing CEP
 	 */
 	if (qp->cep) {
+		BUG_ON(qp->cep->qp != qp);
+		qp->cep->qp = NULL;
 		siw_cep_put(qp->cep);
 		qp->cep = NULL;
+		siw_qp_put(qp);
 	}
 
 	up_write(&qp->state_lock);
-- 
2.25.1

