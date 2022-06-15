Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B58D54C3B7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346460AbiFOIle (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 04:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346596AbiFOIl3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 04:41:29 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F012D4AE10
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 01:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=NdCH8KXK+QOpawcMPiDpjErRzx6oy04IxS+cwW7QQVo=; b=gfqT/BYdMGHi+vc+g7zOkU77lh
        rAte9UDQ0Rrn1mrDltAjCAULYsK1tr7LyJJRR1kN/1+rZBP/xplbXk0hwsxM+6eD2t+lCYyAXdSGR
        nPltTQzkU12SiiX6E0ilElMpyfleoov2XiC3qZ+CZTuNNCm43g5uqFHNiq2T5jWw+DKo5sKE7O2S1
        sxgGJIEafINDWxupESGPN9Sf9N+hI2X4ENd4L4VXQKsRc4fJbUFWKfPhbUdNnDx2kVyBuJM1WYuYs
        mJp/2nA22Xpm/VXrGGuzKU9wVX87r7R/wA6DLqCrwH1W4ApaHy8HWaPtCYwd03dyr2OS++jDUj0Nh
        B9T/w1Ys5qgvrJAl1O+SQMb40/+fUoshTaBuY5dM7Avic/B8MXRk/SAYE0SkoPtEiN3pZ5zwgD38e
        kXrmd6MeLggYCvMYwBHLTSZY2NqFgXHWXrmLDHtRRXxRQslIquURNfUEEdm9LfGTBN47anH5TcT06
        e/nVVNKf/wi7CaY+Ft0aFa2k;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Oab-005p9Z-Uf; Wed, 15 Jun 2022 08:41:26 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 3/7] rdma/siw: create a temporary copy of private data
Date:   Wed, 15 Jun 2022 10:40:03 +0200
Message-Id: <128fce3f256c46feb2e4d31e27da572ff7ed1336.1655248086.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655248086.git.metze@samba.org>
References: <cover.1655248086.git.metze@samba.org>
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

The final patch will implement a non-blocking connect,
which means that siw_connect() will be split into
siw_connect() and siw_connected().

kernel_bindconnect() will be the last action
in siw_connect(), while the MPA negotiation
is deferred to siw_connected().

We should not rely on the callers private data
pointers to be still valid when siw_connected()
is called, so we better create a copy.

Also note that __siw_cep_dealloc() already calls
kfree(cep->mpa.pdata), so we already have the required cleanup
when we'll split out siw_connected() and an error will
prevent siw_connected() being called at all.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 8d1e7f497cf9..0e53219d29de 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1467,13 +1467,27 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	memcpy(cep->mpa.hdr.key, MPA_KEY_REQ, 16);
 
+	if (pd_len > 0) {
+		cep->mpa.pdata = kmemdup(params->private_data, pd_len, GFP_KERNEL);
+		if (IS_ERR_OR_NULL(cep->mpa.pdata)) {
+			rv = -ENOMEM;
+			goto error;
+		}
+		cep->mpa.hdr.params.pd_len = pd_len;
+	}
+
 	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
 
-	rv = siw_send_mpareqrep(cep, params->private_data, pd_len);
+	rv = siw_send_mpareqrep(cep, cep->mpa.pdata,
+				cep->mpa.hdr.params.pd_len);
 	/*
 	 * Reset private data.
 	 */
-	cep->mpa.hdr.params.pd_len = 0;
+	if (cep->mpa.hdr.params.pd_len) {
+		cep->mpa.hdr.params.pd_len = 0;
+		kfree(cep->mpa.pdata);
+		cep->mpa.pdata = NULL;
+	}
 
 	if (rv >= 0) {
 		rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
-- 
2.34.1

