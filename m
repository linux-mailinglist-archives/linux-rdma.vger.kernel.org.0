Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB154CCD8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiFOP3J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356184AbiFOP2p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:28:45 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF1FF51
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=EklZFP4aFAqi/lEclxMAM1al3UCe/uBglyUeYgxdUa0=; b=j6sPsSbaWYnE6zXWlIdbyZfjVz
        JE4G2bfNdgonsaCxCHvyNn77O874Rmc47CpxPOHmLPAWzPxuZbHH7sDcdPXwrhOaYDPnsX9Xg3OYu
        GHWbmnW8en6eFjcfBsFKKJUUpNM2IyJDbFfJAc/XI/Gk3+8hCcesbCC/i2C8KlojKYhV20+WFgTlZ
        6ZVi0FZhM/6fWabaGQT5pkTYVqcsyuHcOEWpVwmTqBs7tcvA8yl4dSPajBd3sh/xpWX9XUGGYfSOi
        DWySIRStqFFELbIaUuBk+ZwqXwT9k/blShHH3fctngYAu2sL+3CL75SyFD2whMxvoQQRrn4JdbeUI
        9XulB573oJe0u/fjfjnfPVsRFd4PfMuyufU6MDd4eY+BZxN/XsZ1AcEX8jvJC5g4ebH1xpyMWERF7
        9cWrmGfaBx73Ap5ZKIl6mtmJY1HsIuhxldTVVWxBIzQFieBaYN7FyP/kwql8DLueIiRb1JCK9V0PN
        detUKQ5QL2euU1ySpNM2Ti5B;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1UwM-005rvx-FF; Wed, 15 Jun 2022 15:28:18 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 11/14] rdma/siw: use error and out logic at the end of siw_connect()
Date:   Wed, 15 Jun 2022 17:26:49 +0200
Message-Id: <5da05688aba3d09db5c46a80915f13729c807245.1655305567.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655305567.git.metze@samba.org>
References: <cover.1655305567.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 307494c6707a..66d90fc77cef 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1502,14 +1502,19 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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
2.34.1

