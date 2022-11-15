Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C942B629AE9
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiKONop (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 08:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiKONoo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 08:44:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631423BEA
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 05:44:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y16so24332856wrt.12
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 05:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDmLuqXwYmVdbmWSZ+GecMD+zyy/1poKx+xtJEviWDg=;
        b=PcPJLqj4j3iGCsy3o7Kniq/bXyR8LrHEFjBvLMpbt0t4jYQGGwqRIox3kEg4qk8iTR
         ZxY1FGULDhZ5sqHwLqptXCf84rtm57OBg9S0Eo08rkkwJDduP5po2q+NGo7zWIgX74lI
         XXpMQn1/XANqfVcEJxdd0xH+QSFuj3rD/A04v7gIIkL/ReHZsU7FEb/xg3KLPUkAqfBO
         W4cw1bx+uoYPdkTSsMPfoHT6FQml8656w3gijDq1kqnTZzh0H4LdfHSs5feLgFVr5lul
         WRd5BXUbQrQacHN/oAa+7SINv8Tth/SCEkRGDrzzsCGGlGJiEoVhPQXUNtAFvFFUrXNt
         SbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDmLuqXwYmVdbmWSZ+GecMD+zyy/1poKx+xtJEviWDg=;
        b=cajG0wyI545AwR0YFBSiDj7ZVO1TzeYpUwhpfH2BxQWt1wm3T6ijw5LOqujMdok+ue
         nPf+MxsGhA5jYI3UVKZtFGBYstjvOSNjIg4I700czpNwrnSbrPSZwoCVMCR/gZYPvoHq
         Vp/LxYtUJoiI5VGJvCAdnz4pWN1850ifFL8g93Q1bQHu4fzzHhuQOmTJ4A04fioIpmMk
         b8Y5t8EOwZ+GBUEetdGu4HGz1nCNnF+mds2KZBAKl9qzLtkAo0DYQlUnps+ICDm6gZSj
         N+/gy0RpciczHbFXM/S+PRgWVqUgjVFw5APUKhdi5ybEdEFXi65ED/G4kr1sjIRuuxJo
         /O9g==
X-Gm-Message-State: ANoB5pl+9JE3d0F/51c9/9p2EVjJpcO+cC7sPd+2tSPv8PcPMuQz/aG4
        O0v4RS2YZNkDHa4PVWAHLqc=
X-Google-Smtp-Source: AA0mqf6KfRDxsET25+hLVuzL3RZ3pDrjHO/otWFL+zH+WxCdywsBVz5NIlsE+zMi10NIMtOka3OJ8g==
X-Received: by 2002:adf:f4c3:0:b0:22e:3498:9adb with SMTP id h3-20020adff4c3000000b0022e34989adbmr11339013wrp.335.1668519882409;
        Tue, 15 Nov 2022 05:44:42 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003a84375d0d1sm24072166wmq.44.2022.11.15.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:44:42 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:44:38 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/siw: Fix immediate work request flush to
 completion queue
Message-ID: <Y3OXxkGXUFqgU/Oa@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Bernard Metzler,

The patch bdf1da5df9da: "RDMA/siw: Fix immediate work request flush
to completion queue" from Nov 7, 2022, leads to the following Smatch
static checker warning:

	drivers/infiniband/sw/siw/siw_cq.c:96 siw_reap_cqe()
	error: buffer overflow 'map_cqe_status' 10 <= 21

drivers/infiniband/sw/siw/siw_cq.c
    48 int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
    49 {
    50         struct siw_cqe *cqe;
    51         unsigned long flags;
    52 
    53         spin_lock_irqsave(&cq->lock, flags);
    54 
    55         cqe = &cq->queue[cq->cq_get % cq->num_cqe];
    56         if (READ_ONCE(cqe->flags) & SIW_WQE_VALID) {
    57                 memset(wc, 0, sizeof(*wc));
    58                 wc->wr_id = cqe->id;
    59                 wc->byte_len = cqe->bytes;
    60 
    61                 /*
    62                  * During CQ flush, also user land CQE's may get
    63                  * reaped here, which do not hold a QP reference
    64                  * and do not qualify for memory extension verbs.
    65                  */
    66                 if (likely(rdma_is_kernel_res(&cq->base_cq.res))) {
    67                         if (cqe->flags & SIW_WQE_REM_INVAL) {
    68                                 wc->ex.invalidate_rkey = cqe->inval_stag;
    69                                 wc->wc_flags = IB_WC_WITH_INVALIDATE;
    70                         }
    71                         wc->qp = cqe->base_qp;
    72                         wc->opcode = map_wc_opcode[cqe->opcode];
    73                         wc->status = map_cqe_status[cqe->status].ib;
    74                         siw_dbg_cq(cq,
    75                                    "idx %u, type %d, flags %2x, id 0x%pK\n",
    76                                    cq->cq_get % cq->num_cqe, cqe->opcode,
    77                                    cqe->flags, (void *)(uintptr_t)cqe->id);
    78                 } else {
    79                         /*
    80                          * A malicious user may set invalid opcode or
    81                          * status in the user mmapped CQE array.
    82                          * Sanity check and correct values in that case
    83                          * to avoid out-of-bounds access to global arrays
    84                          * for opcode and status mapping.
    85                          */
    86                         u8 opcode = cqe->opcode;
    87                         u16 status = cqe->status;
    88 
    89                         if (opcode >= SIW_NUM_OPCODES) {
    90                                 opcode = 0;
    91                                 status = IB_WC_GENERAL_ERR;

IB_WC_GENERAL_ERR is 21.

    92                         } else if (status >= SIW_NUM_WC_STATUS) {
    93                                 status = IB_WC_GENERAL_ERR;

Here too.

    94                         }
    95                         wc->opcode = map_wc_opcode[opcode];
--> 96                         wc->status = map_cqe_status[status].ib;
                                            ^^^^^^^^^^^^^^^
Out of bounds.

    97 
    98                 }
    99                 WRITE_ONCE(cqe->flags, 0);
    100                 cq->cq_get++;
    101 
    102                 spin_unlock_irqrestore(&cq->lock, flags);
    103 
    104                 return 1;
    105         }
    106         spin_unlock_irqrestore(&cq->lock, flags);
    107 
    108         return 0;
    109 }

regards,
dan carpenter
