Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45C662B6DA
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 10:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiKPJqf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 04:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiKPJqe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 04:46:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01A0616E
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 01:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668591938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4EAqsQwxyeW5W1Mia2wWmnvRUmqjVlYjuvgN/Efzygc=;
        b=E/c/13F/J97/3L3hsAA0WLPvDNZsrmphbIB5z9pGNmTz8dvd2mjn/d4jBN5arj4xgdeokR
        pbfDtosZIFJNCL6EFzXARSd4cwsI29pluIB9FkTP30gxjrgs20SAGufJ4fa1A4QZMnlzNI
        6Lm8cGq0gjJGnYnEhX6wLmm9JYA6osY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-S63VYrPBOAOxkQqM0-0EfA-1; Wed, 16 Nov 2022 04:45:37 -0500
X-MC-Unique: S63VYrPBOAOxkQqM0-0EfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9E5B185A7AC;
        Wed, 16 Nov 2022 09:45:36 +0000 (UTC)
Received: from raketa.redhat.com (ovpn-193-253.brq.redhat.com [10.40.193.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04AA040C6EC3;
        Wed, 16 Nov 2022 09:45:35 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     sagi@grimberg.me
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH] infiniband: use the ISCSI_LOGIN_CURRENT_STAGE macro
Date:   Wed, 16 Nov 2022 10:45:35 +0100
Message-Id: <20221116094535.138298-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the proper macro to get the current_stage value.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index b360a1527cd1..75404885cf98 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -993,9 +993,8 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 		 * login request PDU.
 		 */
 		login->leading_connection = (!login_req->tsih) ? 1 : 0;
-		login->current_stage =
-			(login_req->flags & ISCSI_FLAG_LOGIN_CURRENT_STAGE_MASK)
-			 >> 2;
+		login->current_stage = ISCSI_LOGIN_CURRENT_STAGE(
+				login_req->flags);
 		login->version_min	= login_req->min_version;
 		login->version_max	= login_req->max_version;
 		memcpy(login->isid, login_req->isid, 6);
-- 
2.31.1

