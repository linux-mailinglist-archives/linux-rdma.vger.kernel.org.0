Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4E7375D9B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhEFXks (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhEFXkr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:40:47 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D92C061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=c2m/BivsbwLTT/EdW8cczakrbQ6UcyoLiKFwaX4IFWo=; b=j0agjUiLh8Vs4rGwd4wITPFdrS
        PyTbJeAz5NFWHK8VHtOrSUoiM9zKBQ+br4woGIJUKadYbdwdD4xN+H/ZJKVt/g5kNba5iRTFjMyWI
        1DWDsyASIrpyJtsl/SC16Tu7tzUoyvNxUb5yNrfM+RnOtAgTbWHwqxThROH0j9v89UDU/CkjY5lWQ
        6lm2/AdkRfKmL5QUXhdbBG9kIy6mjdFp63n0yMFpXejRfzK4rTxnJ3fJfAiDLHtHS4dR1TNdFMV7Q
        3+RMseNEdjPGMc9+IvcXF/cK6UWdc4xkP8wuFPp5fOcgUBeqAY1bbguolb7Ot+o9y/fmYqq9OwvLt
        wRfNbkyW6Q+/eWxW3Y8mNdqAnLBVIJj/DchPWjkD+DKf5+xW2BqI5jOnSAvwdP2PMaxfpRPJPEXFc
        LMisJPj3l9q7vNj8hUsyzzj47rDFLNVTHKUENNRlRcID59Q4nblHIx3dwywfP5BJ2fupUdKDmixPe
        1gkJ+cYSm7ioRJ1JF/2tJJfw;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenat-0004O8-0c; Thu, 06 May 2021 23:39:47 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 26/31] rdma/siw: make use of __siw_cep_close() in siw_cm_work_handler()
Date:   Fri,  7 May 2021 01:36:32 +0200
Message-Id: <3d322fc684f15f4658fb8489adaf15f22fd35c29.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We should always go to that common function in order to
avoid potential problems in future.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index a2a5a36370af..3dc80c21ac60 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1244,15 +1244,7 @@ static void siw_cm_work_handler(struct work_struct *w)
 			siw_cep_set_inuse(cep);
 			siw_qp_put(qp);
 		}
-		if (cep->sock) {
-			siw_socket_disassoc(cep->sock);
-			sock_release(cep->sock);
-			cep->sock = NULL;
-		}
-		if (cep->cm_id) {
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
-		}
+		__siw_cep_close(cep);
 	}
 	siw_cep_set_free(cep);
 	siw_put_work(work);
-- 
2.25.1

