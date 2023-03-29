Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E315E6CD21B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 08:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjC2Gar (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 02:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjC2Gaq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 02:30:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A87C2D57
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 23:30:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d17so14465187wrb.11
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680071437;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ek9xJrdFx3kViRSaiQrcL3YJMjjS9+ARqI+2xiES+cY=;
        b=i2KcprwSxL2iwyw6EyzW71gUxDSr/6EWW0P+Q2w1B9y3GZOFHVa/gMCWgEYPAYmHzx
         SoSmOLcT/LErZG18kvbYuTRZQKmZtFf4EMkSPufefMahQIafMibgCCb6rs3fnz3j6a9a
         OVPO0XKMWrgzIrH6da9BFuEeO164SSYP3EyCG1sd7txW3KLYEfy9iJlaLTMahu9m24dt
         t0M59s+3jzFZi7cwaVS46z3wtdRNEBmxKKaZGMB53E22JXeTKEPOm6bheecCr4cOK6Zw
         Rl3b0e003VV16nbUti5cT6lNiV0RXLVbJ8LQCjDcuDfRuy+9NB3l5FjHT3WDttic/af3
         3l4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680071437;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ek9xJrdFx3kViRSaiQrcL3YJMjjS9+ARqI+2xiES+cY=;
        b=HAIAzCBsVb/zkR1cyvrRbAdbfzguvyGG7GqlCUYMtuOStfKU0aYMetDOFdbs8G+Cyn
         FjbWZWEs6T61ehAdnIsT+lauycRWyxvQoaTjOjorEEwAi9xqPlnaGRucSNflRMnROpB7
         zR6O01C/m/jxqudIpeq8seHs3/NS7b3WqB3vfxFw1XFtJlYK506z+ye0ZHMM6llkOw42
         VSe4UhqK5aKrWFUcSINGCtLdDtcAXhVb5zPisqa+ZtIhAuIpYlWCTK/avTZ9/nxLAh7Z
         UgLQa5K5yiUm/hKWcsGIZ0hiWX8pJzXXmU/t2ZHXsfiNPxt4GUl3Todq1oUS4z/IckuX
         y3qQ==
X-Gm-Message-State: AAQBX9dUYOIKjjqeKRaZImdRj6CFMt0hrS4A8CKZmdXklKrPH+FIUijb
        OKagcRz4ZOE35hPwaoWTNAE=
X-Google-Smtp-Source: AKy350baO45bp+V351Qn38hNU/TlTFfH6BCVSQgEUTCvf0aUIbTN5JExsGp6W/79j2cIN+fAeD3KEA==
X-Received: by 2002:a5d:4d4c:0:b0:2ce:aad8:9bee with SMTP id a12-20020a5d4d4c000000b002ceaad89beemr14606941wru.46.1680071437265;
        Tue, 28 Mar 2023 23:30:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c15-20020adffb4f000000b002c7107ce17fsm29409502wrs.3.2023.03.28.23.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 23:30:36 -0700 (PDT)
Date:   Wed, 29 Mar 2023 09:30:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     rpearsonhpe@gmail.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/rxe: Add error messages
Message-ID: <ea43486f-43dd-4054-b1d5-3a0d202be621@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Bob Pearson,

The patch 5bf944f24129: "RDMA/rxe: Add error messages" from Mar 3,
2023, leads to the following Smatch static checker warning:

	drivers/infiniband/sw/rxe/rxe_verbs.c:1294 rxe_alloc_mr()
	error: potential null dereference 'mr'.  (kzalloc returns null)

drivers/infiniband/sw/rxe/rxe_verbs.c
    1276 static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
    1277                                   u32 max_num_sg)
    1278 {
    1279         struct rxe_dev *rxe = to_rdev(ibpd->device);
    1280         struct rxe_pd *pd = to_rpd(ibpd);
    1281         struct rxe_mr *mr;
    1282         int err, cleanup_err;
    1283 
    1284         if (mr_type != IB_MR_TYPE_MEM_REG) {
    1285                 err = -EINVAL;
    1286                 rxe_dbg_pd(pd, "mr type %d not supported, err = %d",
    1287                            mr_type, err);
    1288                 goto err_out;
    1289         }
    1290 
    1291         mr = kzalloc(sizeof(*mr), GFP_KERNEL);
    1292         if (!mr) {
    1293                 err = -ENOMEM;
--> 1294                 rxe_dbg_mr(mr, "no memory for mr");
                                    ^^
NULL dereference.

    1295                 goto err_out;
    1296         }
    1297 
    1298         err = rxe_add_to_pool(&rxe->mr_pool, mr);
    1299         if (err) {
    1300                 rxe_dbg_mr(mr, "unable to create mr, err = %d", err);
                                    ^^
mr->ibmr.device is not set yet so this doesn't work.

    1301                 goto err_free;
    1302         }
    1303 
    1304         rxe_get(pd);
    1305         mr->ibmr.pd = ibpd;
    1306         mr->ibmr.device = ibpd->device;
                 ^^^^^^^^^^^^^^^

    1307 
    1308         err = rxe_mr_init_fast(max_num_sg, mr);
    1309         if (err) {
    1310                 rxe_dbg_mr(mr, "alloc_mr failed, err = %d", err);
    1311                 goto err_cleanup;
    1312         }
    1313 
    1314         rxe_finalize(mr);
    1315         return &mr->ibmr;
    1316 
    1317 err_cleanup:
    1318         cleanup_err = rxe_cleanup(mr);
    1319         if (cleanup_err)
    1320                 rxe_err_mr(mr, "cleanup failed, err = %d", err);
    1321 err_free:
    1322         kfree(mr);
    1323 err_out:
    1324         rxe_err_pd(pd, "returned err = %d", err);
    1325         return ERR_PTR(err);
    1326 }

regards,
dan carpenter
