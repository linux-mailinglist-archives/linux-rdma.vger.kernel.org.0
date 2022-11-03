Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48C16185DF
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiKCRLq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiKCRKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708AF2BE8
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so1342002oti.5
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3qUaL73HopC3u45EXiZCzo0Ny/2NSAYaT7GrRPaNG8=;
        b=Tt0cjnqi3YJhYL1qu+kHgw7+9u2u4cbv2Rqc/+oR5gVbyPIruKhb1I5VMfbn+iEgHl
         JE7kn7mkDZ1vw/Xz1EyvWTDwhQdt5NVWjoBSXIgpotAw2sq2w3FA4B+CG4pxc6ON6EEN
         39U+MJGVJD0J0Pky89JUYnoh7yQB0DrRq6GhkMii5ApQEUvfo0jXeNFEpMTR1IiFfKpx
         vj4RYEH8tsf16nSTUHbHXcCOw9I9jPd/PasNhx74HQdwhmgi2lhwfh/0+p4ixo/GyieE
         sHAkkkOi1R5BafRpmthqFfGj1ZMWyy7DcDQfBAMeg5tDFk5pYAnaBjXiSMAPaD2f/pAJ
         ASAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3qUaL73HopC3u45EXiZCzo0Ny/2NSAYaT7GrRPaNG8=;
        b=GIg2106KH2H1zf8q4ZcXnV0GkqdxOWhiASZCxpIZEkD1RazmrpilzfZfoFiWlfKD77
         MVT17K/xOIkJWXTSnMyrsh38IuNxzzFeu6UBYkZQGMVl+g5vMcG9MYKp5uLqoxEsHBex
         Xd75px6TbSPJsulfp811+M2/CkWFgAq119yasYqD1wO5Ea98+NAjoDHL4LxEelypzfUb
         lVzQ5lwAeQrIobYCZQGGtmvwRyXRdzAtKWSvaIuPAccIDvn4odv/0JuHT/flMNMlHepO
         T0JE30IGJNIzkfzXPx+mvybqLzBko7Ppwh41unF1PfKBpVV2CSFu0OVadICUCr+fsQvk
         aepg==
X-Gm-Message-State: ACrzQf2AYgaRbsIJsW9SFKzpxCRA9B/mLUM7fspkoOrIVlEF1Mpn3xoN
        ZJmRgoA5fIR/GlaoHn8WvLU=
X-Google-Smtp-Source: AMsMyM6Y38TA89gjhEqexXfTM2KbS+5+Ht2J2QnrOPxIceX+8O8YW6y+Lppbj89M266Y7yKr61wxAg==
X-Received: by 2002:a9d:6417:0:b0:661:ab18:a361 with SMTP id h23-20020a9d6417000000b00661ab18a361mr14908364otl.100.1667495445797;
        Thu, 03 Nov 2022 10:10:45 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 11/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_verbs.c
Date:   Thu,  3 Nov 2022 12:10:09 -0500
Message-Id: <20221103171013.20659-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace calls to pr_xxx() in rxe_verbs.c with rxe_dbg_xxx().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 510ae471ac7a..e6eca21c54e6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1103,7 +1103,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
-		pr_warn("%s failed with error %d\n", __func__, err);
+		rxe_dbg(rxe, "failed with error %d\n", err);
 
 	/*
 	 * Note that rxe may be invalid at this point if another thread
-- 
2.34.1

