Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6470F4CA7FB
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Mar 2022 15:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbiCBO10 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Mar 2022 09:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiCBO1Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Mar 2022 09:27:25 -0500
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 06:26:41 PST
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0B5C5DB2
        for <linux-rdma@vger.kernel.org>; Wed,  2 Mar 2022 06:26:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1646230276; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=KtEgfK2zTfmJdxvKKYyTgc7wv3miOToDyg9ZYjgdX61/XpMs+XdGhcLZIagsAaLWui037TJGdkohhZ2JYEQGRVaVHo/IJ0GX0ug1Lh7VhmbxjikX/W1AQHfd54vR+lxxemSwRFJagUuotOVoPhf3k59TvAt6OwCD/y3br7NSqMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1646230276; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=8oZTf5fSTDp2JzGy44/yp5LZt47Z5IXbWJ0r+qSC+Gg=; 
        b=fRlFJZE0Kg5JJTMWhfTQswdy2xF4z2EFuiVURkUh/MR8BMbFWIlPDJs3F0bEPfRFWdBFmfDgSo9yqhhlWaMQjzwSs3X5KPR4KLnInIC40y3H2E+WaQQpaKKJOlCPhbYQuukL5ft0vZ0aObkp/CH1AAu8ly7tdXA11W60pP3j2wY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1646230276;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=8oZTf5fSTDp2JzGy44/yp5LZt47Z5IXbWJ0r+qSC+Gg=;
        b=LCoG//ue3g8hGmeueJsI7YMwW+069wVV+qK1u10Y3OcO/KDMG1peJSS0Pe7olAsr
        I5z6muy50aRsArCAsO1wYoPrtVbzZJcQPvOXoxebVvWCFAZeDYxXoqVvkC83nt9hvGl
        RQxCLFcCNoK1V7HIPEGpy/keR7o/jUctMYgR+bck=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1646230275473199.50784784469477; Wed, 2 Mar 2022 22:11:15 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20220302141054.2078616-1-cgxu519@mykernel.net>
Subject: [PATCH] RDMA/rxe: change payload type to u32 from int
Date:   Wed,  2 Mar 2022 22:10:54 +0800
X-Mailer: git-send-email 2.27.0
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

The type of wqe length is u32 so change variable payload
to type u32 to avoid overflow on large wqe length.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rx=
e/rxe_req.c
index 5eb89052dd66..e989ee3a2033 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -612,7 +612,7 @@ int rxe_requester(void *arg)
 =09struct sk_buff *skb;
 =09struct rxe_send_wqe *wqe;
 =09enum rxe_hdr_mask mask;
-=09int payload;
+=09u32 payload;
 =09int mtu;
 =09int opcode;
 =09int ret;
--=20
2.27.0


