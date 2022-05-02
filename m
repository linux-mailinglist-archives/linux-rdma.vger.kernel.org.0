Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA8516A75
	for <lists+linux-rdma@lfdr.de>; Mon,  2 May 2022 07:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357900AbiEBF6a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 May 2022 01:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiEBF6a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 May 2022 01:58:30 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 01 May 2022 22:55:01 PDT
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC73FBDB
        for <linux-rdma@vger.kernel.org>; Sun,  1 May 2022 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1651469975;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=YmYbdCZgSkUFIeTNYDYHikphekilUEQkctqzm4qj0Vk=;
        b=Vfsbd71Eq0EpR7UdbU/ucug1+R0uhDbecTaPOFB1Y+Uk4pSXCd9K86/uiunnLKM6
        3l0jWD8SIXI9dRtdR9BI12N+725IaLv6NMG5Bl5706+P+58+M7BjeouJ+ln1uP+smKZ
        j0+LLgOKZdBgSJeIwmnNLemGrumyvqPY9gWfL2uA=
Received: from GigGun.. (113.116.156.201 [113.116.156.201]) by mx.zoho.com.cn
        with SMTPS id 16514699734651004.6165712235154; Mon, 2 May 2022 13:39:33 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20220502053907.6388-1-cgxu519@mykernel.net>
Subject: [RFC PATCH] RDMA/rxe: skip adjusting remote addr for write in retry operation
Date:   Mon,  2 May 2022 01:39:07 -0400
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For write request the remote addr will be sent only with first packet
so we don't have to adjust wqe->iova in retry operation.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rx=
e/rxe_req.c
index ae5fbc79dd5c..f08010651ef7 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -33,8 +33,6 @@ static inline void retry_first_write_send(struct rxe_qp *=
qp,
 =09=09} else {
 =09=09=09advance_dma_data(&wqe->dma, to_send);
 =09=09}
-=09=09if (mask & WR_WRITE_MASK)
-=09=09=09wqe->iova +=3D qp->mtu;
 =09}
 }
=20
--=20
2.35.1


