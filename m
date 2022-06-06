Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3553EBED
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbiFFOj2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiFFOj0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 10:39:26 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE1814FC83
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 07:39:25 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id p129so15281638oig.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jun 2022 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6YOLnAqT9lBG6SvNDSFCMwjRgN6KbCRStio5QlMzKc=;
        b=AXtN6BBnapQ2DybMHpilHyDbP3kiVCrz2yYavwdtPc0tqLM3/k/IHNa12Es1gbP56p
         LghobDJ/hQDPm6ibkQHRee5A9CkHWm2nRNreyrJTnYm1NI8Ck8vnt6Mbk8zSsqH1H4d8
         2jSleWEAfStTCGobkKU5tuzuGyBEyTrVOnoSHzAGwQ6FbwL4eBHDX88eODqnOhZnWMa0
         iNqz20nuLNjjqgYSLDWgWMsIz9ITvWb5TtHkVOJxT6RcLqTBZ0Mnvy5nhI89TJeJpbSt
         7k76NGtX9jkwJg55kPUiFsVVYta3uXcPqpCAyBp8LrEwzYD85ywKia1ylDEZubo8ZxH/
         mAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6YOLnAqT9lBG6SvNDSFCMwjRgN6KbCRStio5QlMzKc=;
        b=YKJ+CFnLjbm9vEBqrBR5ibfYm1eZbVAlMB4l4saTEMYmdLhN81FJHNwTAlfHNsrjlT
         s3FANcO11iTyMwledYaZeB+0mPHZA6Y1k+Tr0E9Xmo5KxK2MNPwhrsAGGWsw45PWntmY
         K4JBQiYX4cjMHjFAcijOyxFmseWN+H+rmbx6CLR6S9bNzQzCkB6vL1fhAk5zqVvSTkha
         diJTaWWiW9k9hRyUZdHkveLZe7RYsmqhfbm4KEAakHC6DqDnJG/pX6n15eOgfSCVuKI4
         jVtAsNI9Z6GxBS24dIMhxUForsyMURue0jjsC2aXp053cXSybL9XZj/6t8JJF68bwXyp
         1h9g==
X-Gm-Message-State: AOAM531n3MiYZoeWmWfwCprYNWZnJPX747L5wRCEP2bUFaexsaDx4nZe
        e9I4ywDVeZnKDLE3JxsHVDo=
X-Google-Smtp-Source: ABdhPJyFRBGG0ZTd859YeyMoJo78Vpo5O19mWOCTmqmXVS/kUqIBy4N5fStUJnPyQY835UtzqUjMOA==
X-Received: by 2002:aca:3a84:0:b0:32e:418e:a693 with SMTP id h126-20020aca3a84000000b0032e418ea693mr12359856oia.205.1654526364402;
        Mon, 06 Jun 2022 07:39:24 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id q28-20020a05683022dc00b0060c00c3fde5sm658335otc.72.2022.06.06.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:39:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        frank.zago@hpe.com, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/5] Fix incorrect atomic retry behavior
Date:   Mon,  6 Jun 2022 09:38:32 -0500
Message-Id: <20220606143836.3323-1-rpearsonhpe@gmail.com>
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

Restructure the design of the atomic retries in rxe_resp.c modeled
on the design of RDMA read reply. This fixes failures which
occur when an atomic ack packet is lost as observed in the
pyverbs test suite with a patch to randomly drop packets.

Link: https://lore.kernel.org/linux-rdma/84aaf934-9cac-30ae-0fa5-1e40819a519e@gmail.com/
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---

Bob Pearson (5):
  RDMA/rxe: Move code to rxe_prepare_atomic_res()
  RDMA/rxe: Add a responder state for atomic reply
  RDMA/rxe: Move atomic responder res to atomic_reply
  RDMA/rxe: Move atomic original value to res
  RDMA/rxe: Merge normal and retry atomic flows

 drivers/infiniband/sw/rxe/rxe_qp.c    |   2 -
 drivers/infiniband/sw/rxe/rxe_resp.c  | 132 ++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_verbs.h |   3 +-
 3 files changed, 81 insertions(+), 56 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.34.1

