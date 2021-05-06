Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83D375D8E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhEFXjh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhEFXjg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:39:36 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FF2C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=ZWc9RZj6x+/FMj7iLvPpV4BtuYQEsZX3sqTosGD6gB0=; b=UYvwFwxpzFjWPkOWYDfW1Pablw
        yJGXpoowheWqKBNORcaLKNMZOORMIs/HkBYJ9dZBcp2dPEWm52k7cA5aPRcT8tKCKEPdfL+aAOcbH
        OozTtUVXwyau0ZsMOUl3zFPAkrz816kebrLQvdfMKsdu4Lqip7MF2L+0RvzeZqbu7CCFSUEw0iXUF
        n/XG6cpkr07R14oyCtjN/yA6mSs1cj61HkuSTjana/D1p0IDc/8Pfjx8598KiLoEVzq8XcWdfGHIC
        6mEb90KZfFlAIzFcb4RbsboMt3g52hUmwJoU6klj8rTLifyfarh+4Dwx3acyC+c7cfoAN4Lt2RCxx
        8eJANSHBUbvJGq3v/5Yzecegn+vPgNZjZwD7cHsdRS1UyoypskIiGZDoMN7/eE+WC874gNunM1Gpt
        SjBlXmNulofXdhXvBDVDILt2RWNiYuFiwBXFZslH5kLCx1GqUU+w7kJIod546dGO6YqAiJEl4gnz8
        E52CZMOJqH/3ow7+1kvFwfEv;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenZj-0004LS-9B; Thu, 06 May 2021 23:38:35 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 15/31] rdma/siw: create a temporary copy of private data
Date:   Fri,  7 May 2021 01:36:21 +0200
Message-Id: <a382dd6f7560b1a311484c656216fcdb9de56ff6.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 027bc18cb801..41d3436985a6 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1519,13 +1519,25 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	memcpy(cep->mpa.hdr.key, MPA_KEY_REQ, 16);
 
+	cep->mpa.pdata = kmemdup(params->private_data, pd_len, GFP_KERNEL);
+	if (IS_ERR_OR_NULL(cep->mpa.pdata)) {
+		rv = -ENOMEM;
+		goto error;
+	}
+	cep->mpa.hdr.params.pd_len = pd_len;
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
2.25.1

