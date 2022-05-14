Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283B8526F2B
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiENDGz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 23:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiENDGy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 23:06:54 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F16314BCE
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:06:50 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-ed9a75c453so12718287fac.11
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8w5ZZifMY06ekPW6vcK4kUg4CJobAbeUfSNDqles2A=;
        b=huhQcrsGnMnwf54uGlBzqEwU7mlLMAmjApbSW6ynaWJkMFcYj3iDlt8zhoqK5Qmi2l
         LynU4subL3Khr6PodPGhGRT/cxFm41pUYzxMaAkwNet7GcHtjEOABRzgvjz6Wvptgtvp
         uO9yUFIn/wjIh9cvpwHFku3MaCYde5dayp85wz8M9pwsq5B7+bT3aMjnD2q4XDIeq9ml
         G4f5JqfZ70YmhO1i7OMsp+9K4Zrm4/tO7fTnEl99XcF8BwPl5Ww2lS/J5F0V2qStQmKV
         pcaxc8msEbDj3OPs89f1QR1yYUKfTgw/5O4SCE1TriP9NpRR/Ut0QWtDzclGGKZhS2qR
         LLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8w5ZZifMY06ekPW6vcK4kUg4CJobAbeUfSNDqles2A=;
        b=cB1B2YDVjDixG7GPIpRyahZqvlRxkWZuT8ZaTFkeNMER9nH4cMIrU/pYlnEcC/CsjP
         evKVTOIFh1gsCgiCCf1HcpdxvckfXLoxMHka8owZYEMo2bv/cnzV0EJ0E2adkIBrjtCn
         6+Z/ntbKlYu9axUyLoZ/0QaYCBmLzrlXiRitTK28NZ1gzrccqFDRfDON9afKjc1pQK7o
         ZGQNoGRCEKynV+LiUNRCGBq7S5IY2HSlfvd7bVXktP52X/NLvH+AsHujdf4pyov2Kw/y
         26K9AuU23wrsJw9LRkbBWql07BUePsxnP/ZIAwQKyMjZ2aBZC+oIEwf3kHVaTblSJ6+U
         Un2g==
X-Gm-Message-State: AOAM531YNCVnHofTek5l1OHnvFpQ7v2tYKuSEysL+rHXtkKr4wRhspYB
        5GucLSvkza37BNsrLJ+ZdktVVdaCjX8=
X-Google-Smtp-Source: ABdhPJwe92sPa8aZsydm1DWhT+f/KSxF2WEOXdXc3zveFbDPq6hAM/C5SfEGoA86lFnUmlUGc62UZg==
X-Received: by 2002:a05:6870:c8a5:b0:f1:65c3:b1e9 with SMTP id er37-20020a056870c8a500b000f165c3b1e9mr1970036oab.36.1652497609881;
        Fri, 13 May 2022 20:06:49 -0700 (PDT)
Received: from u-22.tx.rr.com (2603-8081-140c-1a00-0642-4ec7-2b63-14d6.res6.spectrum.com. [2603:8081:140c:1a00:642:4ec7:2b63:14d6])
        by smtp.googlemail.com with ESMTPSA id h64-20020a9d2f46000000b0060603221262sm1691176otb.50.2022.05.13.20.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:06:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, tom@talpey.com,
        linux-rdma@vger.kernel.org, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v2 0/4] RDMA/rxe: Cleanup retransmit and rnr retry
Date:   Fri, 13 May 2022 22:04:32 -0500
Message-Id: <20220514030435.91155-1-rpearsonhpe@gmail.com>
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

This series of patches makes some minor cleanups of retry related
code in rdma_rxe. It fixes incorrect behavior in rnr retry and
reduces the number of spurious retransmit retry events.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  The 3/4 patch was previously submitted alone and is now modified to
  respond to suggestions made by Tom Talpey.

  The other 3 patches are newly added.

Bob Pearson (4):
  RDMA/rxe: Rename qp->qp_timeout_jiffies
  RDMA/rxe: Add a pkt->mask bit for ack_req
  RDMA/rxe: Fix rnr retry behavior
  RDMA/rxe: Reduce spurious retransmit timeouts

 drivers/infiniband/sw/rxe/rxe_comp.c   | 58 ++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_opcode.h |  1 +
 drivers/infiniband/sw/rxe/rxe_qp.c     |  9 ++--
 drivers/infiniband/sw/rxe/rxe_req.c    | 51 ++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  8 ++--
 5 files changed, 94 insertions(+), 33 deletions(-)


base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
-- 
2.34.1

