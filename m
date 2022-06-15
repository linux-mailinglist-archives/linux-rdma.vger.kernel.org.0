Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6A654C3BE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 10:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbiFOIlp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 04:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346684AbiFOIln (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 04:41:43 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9624B403
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=2bnt6S+jT4KW1xKlfXKsfg8/BcScuy9VEIFYJAE2HlI=; b=e+ZTFD8TCiZTDF9Ga0NuCX9O2r
        s1hgiXmZk4WcJ9Fyfg5Zn6DAXcNKqtrHF8uyruiEKQgwQJ0YBboR184R0w4YXeT99od2pl0aZ7cWJ
        F0KVxOvxhfFxapK4tQxPVB8lKhI9fipmdljjtqG+ye07TjJ3WMrGdccseHbV1gq0B//we0o1Tu38q
        5bID0ogLTQxRzJzPqRhDIBqjZSJMUfR1XVJVBFRabRzbCxpx+jctwqTkkf87ez6jtQdsIbAvyeEMy
        8u8YhTG0ZLocGexIbWZ38TTX6LyQkrdfNCcb9ZKVtdWmMKyGdeCxNgl8pjYisxyTcFeUdtzTxs2Jm
        YhqGbGIJdcfXU7v2BfZf06occfuMV2uznv0uzcGH5BZj4p857YUNzbETZIwf25BA/mKv2Lg6ehAzM
        7DahDAiJMXrikOuACTfLcgDUAXmS2Z8Bkt6r4gxYlBc/2JcQ3M2dF2UIdYSCkMtTGzMq0scFvOezC
        XX7b39InrDAfrjDQNWCFwc3z;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Oao-005pA2-UC; Wed, 15 Jun 2022 08:41:39 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 5/7] rdma/siw: start mpa timer before calling siw_send_mpareqrep()
Date:   Wed, 15 Jun 2022 10:40:05 +0200
Message-Id: <505a18c83a283963174c9e567ce73d055e26ec7b.1655248086.git.metze@samba.org>
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

The mpa timer will also span the non-blocking connect
in the final patch.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index b19a2b777814..3fee1d4ef252 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1476,6 +1476,11 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		cep->mpa.hdr.params.pd_len = pd_len;
 	}
 
+	rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
+	if (rv != 0) {
+		goto error;
+	}
+
 	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
 
 	rv = siw_send_mpareqrep(cep, cep->mpa.pdata,
@@ -1493,11 +1498,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		goto error;
 	}
 
-	rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
-	if (rv != 0) {
-		goto error;
-	}
-
 	siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
 	siw_cep_set_free(cep);
 	return 0;
@@ -1506,6 +1506,8 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_dbg(id->device, "failed: %d\n", rv);
 
 	if (cep) {
+		siw_cancel_mpatimer(cep);
+
 		siw_socket_disassoc(s);
 		sock_release(s);
 		cep->sock = NULL;
-- 
2.34.1

