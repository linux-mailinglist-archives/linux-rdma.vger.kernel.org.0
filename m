Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA46375DA0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhEFXlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhEFXlW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:41:22 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F7CC061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=1LCOSH1ZG21310bxw+RF0Wm0jsU11rb9f/qSMeoC25s=; b=STqzINP7jiWet1U0vOt0iaoaEj
        35ytJ6Zyqt5w25GMOvPgeve2dzf7VTg0TtRitBKlSO2Z76hwYJZFYh3tVi3n4FHHU1UMA0ujqZZLJ
        nxz00qFMAUMYQ8yrgL3PQDHt2s600KDvc6WPGiFte4ZZhxgteNu0ChExFXU+HGasVATXhnVSfoTXO
        h9bJzpk7d05ynkG205lEbZm/B5DG3BgWNHKslrqjbX8+8iahCuwV+vy99U8tDFUsr9MnVgNUtsyRj
        RPmsNOge/ixPHP7RPENpDTG+XsMHZV2vUbe3dK0JmAWC0Iuz0R0US2gE1CcglF/gh2oi+LMapmE4o
        2cuZzzVGD5r7RWU4XTKZKip8KYCcqAdUE5GPWF4cvr8cUFovP3DQZkdcKTguVH//7U5AngBJu7BWU
        eLjPboAhHhES//KIeisOUg4/w5VhCbBbsCiMfavHkIqY32AwubjXkPgfmlQVULL2IphccjMVwOR87
        XC6ilnVRC12edzrtdr1y3ohH;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenbP-0004PE-N5; Thu, 06 May 2021 23:40:20 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 31/31] rdma/siw: make use of __siw_cep_close() in siw_drop_listeners()
Date:   Fri,  7 May 2021 01:36:37 +0200
Message-Id: <b9fdc5960ef9710f312bf5a3bb9b2b19cfcaca54.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is more or less a consistency change, we should always
go via __siw_cep_close() to release the socket in order to
avoid problems in future.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 49d01264682a..58e965970f3e 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1995,17 +1995,7 @@ static void siw_drop_listeners(struct iw_cm_id *id)
 		siw_dbg_cep(cep, "drop cep, state %d\n", cep->state);
 
 		siw_cep_set_inuse(cep);
-
-		if (cep->cm_id) {
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
-		}
-		if (cep->sock) {
-			siw_socket_disassoc(cep->sock);
-			sock_release(cep->sock);
-			cep->sock = NULL;
-		}
-		cep->state = SIW_EPSTATE_CLOSED;
+		__siw_cep_close(cep);
 		siw_cep_set_free(cep);
 		siw_cep_put(cep);
 	}
-- 
2.25.1

