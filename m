Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B64375D87
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhEFXiw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhEFXiv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:38:51 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3833C061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=0qtB4Cl0hGBRt7Yo3gJ1E+UNj0AN64ZCB0gKeZKCxo4=; b=3UUyI8mR06sO0L4uOSdCLhWaFS
        EgrFNiFQI+lmpa6fyey7RnP1pugw0ToVLL9UTB7pL6723Nh5dW5yXIw6xQ9YukfeEk28nJRyDYTAZ
        0EayaWrSkGn3XnoMPcAvZalNFW9Ww7lB1yozZBj8tNSeiedBeMhfmIR6ey/Krp9LRNI0QI9ioS7aN
        mUavhavJ7tkviz1CWKFQwXd+YDG2TywZaeeowzI6F6II/sTr81RgwMr4jkrBIRmVAWzp6fnPfpeOB
        V5bB9T9UKoOvQZT7npMC8U6Obk4COkut3TQ1ankMvAYTNNLttu/pTHIzI8ClDnWW+2qQx4s9CIO50
        dnDq5G+70XM5EnC7FrGz+tnAynjlggz7Gy//+BENN0+v3dK0auPs43pI/5pn6CkQZ+oiwam0b7Jwo
        Tfng/XsVqmRhusSqUwoPrGIZATBmV0AnGPmnqnZLpMGa6EeACQhCRjTfiA3GV1L0h9tP2D6r/ui6J
        LyOZF2AOSwRkszfdmecIDT1E;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenYy-0004Js-AY; Thu, 06 May 2021 23:37:48 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 08/31] rdma/siw: use __siw_cep_terminate_upcall() for indirect SIW_CM_WORK_CLOSE_LLP
Date:   Fri,  7 May 2021 01:36:14 +0200
Message-Id: <c4ad39d9a5c7b22e60fbbfd43dc2f8b068e2eea9.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Both code paths from siw_qp_cm_drop() should use the same logic.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index c91a74271b9b..b7e7f637bd03 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1071,11 +1071,7 @@ static void siw_cm_work_handler(struct work_struct *w)
 		/*
 		 * QP scheduled LLP close
 		 */
-		if (cep->qp && cep->qp->term_info.valid)
-			siw_send_terminate(cep->qp);
-
-		if (cep->cm_id)
-			siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
+		__siw_cep_terminate_upcall(cep, -EINVAL);
 
 		release_cep = 1;
 		break;
-- 
2.25.1

