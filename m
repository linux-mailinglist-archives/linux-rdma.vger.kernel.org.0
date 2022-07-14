Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E9357568B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 22:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbiGNUq5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 16:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGNUq4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 16:46:56 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32EE4D16D
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 13:46:54 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-f2a4c51c45so3906230fac.9
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 13:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mAJmPyhY7V6JSIyoPXddtDfme/xr7+d61iYnp8ebvFk=;
        b=QpsCISZW0YIXUoNJBWBp3Rv30LEHGBltj/bhpPC5w/0wDy7rWkdr0VPO/iGK4sSocy
         7Pr5UFd19AdpL866Bk0Cugk7hyMjeaPAmJ6tUidQZJuYZASwGaTLFKfGE3gupif3Pp39
         jNmKSi0v7RpmEQxBwxmjkgTvq24UAKsQc3zaCqUjAhbWM5mNbTgo6vvlvlDHraah6sOB
         h0VgfcVwXBYzSCN/ppgRdPrFruKgrOARVD8XIfhZIE6eX/yvAqhY7FffmfZZzq3IFx4e
         7H3f7XZyukUuolGmgnLWlSeKU5aDcCex4lvz6Vjt8GM8hpO/AD5EgAlXQMdwRKoybILu
         Oneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mAJmPyhY7V6JSIyoPXddtDfme/xr7+d61iYnp8ebvFk=;
        b=RnqighpozdnhBm39Myz8lnQ/fcBChGUItsjspprmHsTtnnw+7TKROx9vUWXKqT9oF+
         dL+kIC8h6h8W4z5Eyg/AwrGNFWblWcaISNmEkJsQ1HSh2zC4xvDMNi0Ii33QwpONDr2a
         8gYCjX/1qc9BF63AQvUx32R3F1oz3ObGuHOsydRqeCIZazrkEDPG9g1WE0Mh6m+jd3Km
         PiNRpQVZ2E+BpViyjLTRIuz4xpz+k2c+sisM5Y9q2OoQafYXsDELp0VVc/l9byZj47rR
         u0ihDkieDeLWlAeiioeLUF+uWyFYcrcW3aVpkBDmHhQnZK0MNXiFEN5motZZ+SkYvLQ9
         jJdQ==
X-Gm-Message-State: AJIora+S080RdY/xnEFQw37kIlfxSBchvJ6nU4i+VS8o1iRroFjeodhr
        J5g7e8Ghg0g4kC1BdTPKzpOr+lhCjDU=
X-Google-Smtp-Source: AGRyM1vhQsxpSDRo/b6ghoJn51g18dp58VU9y+dd1H/rWbDmSY35TrikGp/EnUZOV6rjOxRxoBMZdg==
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id em4-20020a0568705b8400b0010cd1fa2f52mr5778245oab.92.1657831614071;
        Thu, 14 Jul 2022 13:46:54 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id z34-20020a056870d6a200b0010c5005d427sm1325154oap.33.2022.07.14.13.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 13:46:53 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix mw bind to allow any consumer key portion
Date:   Thu, 14 Jul 2022 15:46:20 -0500
Message-Id: <20220714204619.13396-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The current implementation of rxe_check_bind_mw() in rxe_mw.c
is incorrect since it requires the new key portion provided by
the mw consumer to be different than the previous key portion.
This is not required by the IBA. This patch removes that test.

Link: https://lore.kernel.org/linux-rdma/fb4614e7-4cac-0dc7-3ef7-766dfd10e8f2@gmail.com/
Fixes: 32a577b4c3a9 ("Add support for bind MW work requests")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index bb6a1edaaee8..cfd75c48e4b0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -50,8 +50,6 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			 struct rxe_mw *mw, struct rxe_mr *mr)
 {
-	u32 key = wqe->wr.wr.mw.rkey & 0xff;
-
 	if (mw->ibmw.type == IB_MW_TYPE_1) {
 		if (unlikely(mw->state != RXE_MW_STATE_VALID)) {
 			pr_err_once(
@@ -89,11 +87,6 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		}
 	}
 
-	if (unlikely(key == (mw->rkey & 0xff))) {
-		pr_err_once("attempt to bind MW with same key\n");
-		return -EINVAL;
-	}
-
 	/* remaining checks only apply to a nonzero MR */
 	if (!mr)
 		return 0;

base-commit: 2635d2a8d4664b665bc12e15eee88e9b1b40ae7b
-- 
2.34.1

