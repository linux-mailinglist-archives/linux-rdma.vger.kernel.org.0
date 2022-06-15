Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E1654CCDD
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349593AbiFOP2T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352845AbiFOP1t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:27:49 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD196483A1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=x/l0VzagZh3qsHeJoVHY5Rfk0xYZjmhFup2+zDP4VNc=; b=JNLuITWWDdWuZSDRJ2yLMgXsKL
        9WaTg+fJW3IJ4copvzeVK3CzD/+RX3RvbAk5DgQBWjJbZAdYcRtjbYWwFtRvK4A8Tno+Bksd/cUPI
        mfcLR3tgOQihQbDkS1kUsGI7ytarOfdEAsBQ6tdbjc90nZYvDI0DqHpYLPZOKnxzYkrr/kxgOVrw6
        6/nP1Y6l7eW6TzXPt2xNIgy38HBRCHQyoFLho8WfF/wykcde9HyRhhaZKa9Lem0wKK7qpgs7PmB3h
        GYuZnYVTDW8BIq0sADVO8O6rtXBBhFEEehmS8Jxs3y0NUf0sfhV34GEExDUr2hpawqFCs8wpcfE1Z
        IUvcpi8lx1OUEr5mSinPgbJXA7pyFh41InCsxh/1C7HqhT6pifiXrYueLcYXivi1UuPURgEWVmpdR
        uKCeJid9Svo6OswUDg5q46A4FyLAhHchLQtDCTUm5l4dXeqtAXLDZG+UKAHTvdCKmSZZQVhniBxoc
        clbDM6pOuTCIBjowZRhm3qqj;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1UvM-005rtC-CE; Wed, 15 Jun 2022 15:27:16 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 02/14] rdma/siw: make siw_cm_upcall() a noop without valid 'id'
Date:   Wed, 15 Jun 2022 17:26:40 +0200
Message-Id: <bc7368632a151ba00d5932a951f128e344189b27.1655305567.git.metze@samba.org>
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

This will simplify the callers.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index a8e546670d05..eeb366edba2a 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -322,6 +322,9 @@ static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 	} else {
 		id = cep->cm_id;
 	}
+	if (id == NULL)
+		return status;
+
 	/* Signal IRD and ORD */
 	if (reason == IW_CM_EVENT_ESTABLISHED ||
 	    reason == IW_CM_EVENT_CONNECT_REPLY) {
-- 
2.34.1

