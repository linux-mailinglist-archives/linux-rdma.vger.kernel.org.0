Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE44D0205
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Mar 2022 15:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbiCGOxj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Mar 2022 09:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbiCGOwn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Mar 2022 09:52:43 -0500
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8924091367
        for <linux-rdma@vger.kernel.org>; Mon,  7 Mar 2022 06:51:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1646664665; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=iKKKavNSMWt9rbN8RE5EhJyYQ/qY7taU//O/xQ5UMQhzBNBFVpdqjxg30UL1ajLKqsGeSm8Y8zTbtO4PL1xC5OqJPOPn2wCpCUws/OGXIWCcdBVR3rwABKXu6KYeJMMMce3DbyAFpYMOmXMFZqZw1CSQUGRpYEXxQ+ewlgmqPjM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1646664665; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/vufxB3vaUeqJCvsW1eavYn6EjNLI3YthXGG6Bjkask=; 
        b=GLcS/6zy/6UQVQ0lQpUKlQg85CMmwffSah4ubGqYB5MJLxVAG2fygCPdsX93JGrXoMF0wj2YSgmStzYq7KmhZYbmWy8IRK3tMRqO3lNXzTfl3RHzBr/PC220sr7/EkT+AzK21TCQ1pYbSAgCYLdCA85/duoqAmecK7p/1IlypnI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1646664665;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=/vufxB3vaUeqJCvsW1eavYn6EjNLI3YthXGG6Bjkask=;
        b=YaRsezzqr9KKZzqCYdUjtBOEq8xOumDormmRgKPCmWdeuNb0JzdmzG6ZBl46tgeY
        pvAGNdlkgsk2BjjCsdA5+Lk4L6wU2s88rLJvtkbSfP23neGGjOiRYNAOja6WyOw4jFB
        XKbetA7dp1FdV12HulJmtVd37MdiFEqhrEUb0sjo=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1646664663068265.8581659973586; Mon, 7 Mar 2022 22:51:03 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20220307145047.3235675-2-cgxu519@mykernel.net>
Subject: [PATCH v2 2/2] RDMA/rxe: remove useless argument for update_state()
Date:   Mon,  7 Mar 2022 22:50:47 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307145047.3235675-1-cgxu519@mykernel.net>
References: <20220307145047.3235675-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The argument 'payload' is not used in update_state(),
so just remove it.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rx=
e/rxe_req.c
index b28036a7a3b8..a3c78b4ac9f1 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -540,7 +540,7 @@ static void rollback_state(struct rxe_send_wqe *wqe,
 }
=20
 static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-=09=09=09 struct rxe_pkt_info *pkt, u32 payload)
+=09=09=09 struct rxe_pkt_info *pkt)
 {
 =09qp->req.opcode =3D pkt->opcode;
=20
@@ -747,7 +747,7 @@ int rxe_requester(void *arg)
 =09=09goto err;
 =09}
=20
-=09update_state(qp, wqe, &pkt, payload);
+=09update_state(qp, wqe, &pkt);
=20
 =09goto next_wqe;
=20
--=20
2.27.0


