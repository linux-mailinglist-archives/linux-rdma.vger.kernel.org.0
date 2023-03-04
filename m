Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830506AABA6
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 18:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCDRqp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 12:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCDRqo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 12:46:44 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CFA1B54A
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 09:46:43 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso3179574oti.8
        for <linux-rdma@vger.kernel.org>; Sat, 04 Mar 2023 09:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677952003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M0pQTETyvKDP9QDWdtVch6PxMliqVmZtvRGX0toWUPM=;
        b=JmGq0gR9T4zIBbm/f6WVQhFoybemHyXlewIeq3kJRLMzr+av/oipw0uikCcgjO+gN9
         5EKu7lxtcPsgd2gjcnbHqSMunXz4dvS6gagi0kuTjJlpd26/qMrtXWMdUEfQa4Utjtk+
         hvusGgv1FI8lpQ9Zkn6cqJRDueFfAYva+rCv9ekOAL+C85e3bdAZDOt7M1Ki2r5qJKBq
         f+7zjw3Pnl0pG649FHnmicdtZFhKMXriB2zQNE5CiiIQyfFVGllNnYLCu9UbS0RBZyZ0
         H05rtg1yhXAybj/P1rtjIsgWL2SWp6WK/1SDvy4Fq/HTWZTyV0SLhjTrRuUZcCm4qTev
         KF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677952003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0pQTETyvKDP9QDWdtVch6PxMliqVmZtvRGX0toWUPM=;
        b=75SfoJUx4erNqO11sly768s25Msukm42kKUe1Nud7sHC/6MUf5XbcPDB5KS5pjcQr4
         vOo7LYrHGifLNJIj+/QwJ1+2k2uPOWYu/1X8hC8pntiYTglKSQ2UwyBW8amSsQ/OcqIu
         ORF0xJ5FAW9IxCEItPFSkyp/OMaL/bPRcjVdytX2ZESvFmYAUf3BCF/VtHCiTA0dYJgC
         lF2jRDeeITAQyUEkWcKub6ApLc0+XutghTEGepRlYbiMvT28zmSQNIzv+myJmCCoRYgs
         Gl7v1cTwXwvqUnvmBCbNmoHMOrWpTqPwtF4Zm+NZiv0adLevWF09cUiiwD3zDJkTDKhN
         Inyg==
X-Gm-Message-State: AO0yUKVynuCaaII2bBV0dA9OMfh6PEkPqw2/rOUfdBZ/ITAbkT+SJBnI
        vrvVW96XsawEyUvMD+2Uf4ETTOM60rw=
X-Google-Smtp-Source: AK7set8TUzYrP/Of59QWgr+huvegkkZRupTOTlafl6scoV9BA4EL39G+8Un7pld+CE7YWOX02xhKvA==
X-Received: by 2002:a9d:378:0:b0:68b:c06f:5e67 with SMTP id 111-20020a9d0378000000b0068bc06f5e67mr2395208otv.37.1677952003219;
        Sat, 04 Mar 2023 09:46:43 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-f848-0c36-f4e0-0517.res6.spectrum.com. [2603:8081:140c:1a00:f848:c36:f4e0:517])
        by smtp.gmail.com with ESMTPSA id a1-20020a056830008100b0068bcadcad5bsm2311227oto.57.2023.03.04.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 09:46:42 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 0/8] RDMA/rxe: Correct qp reference counting
Date:   Sat,  4 Mar 2023 11:45:26 -0600
Message-Id: <20230304174533.11296-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
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

This patch series corrects qp reference counting issues
related to deferred execution of tasklets. These issues were
discovered in attempting to resolve soft lockups of the rxe
driver observed by Daisuke Matsuda in a version of the driver
using work queues where the workqueue implementation was based
on the current tasklet based driver. An attempt to find the
root cause of those lockups lead to an error in the tasklet
implementation that has been present since the driver went
upstream. This patch series corrects that error.

With this patch series applied the rxe driver is more stable and
has run the test cases reported by Matsuda for over 24 hours without
errors.

The series also corrects some errors in qp reference counting
related to qp cleanup.

This series depends on the RDMA/rxe: Add error logging to rxe"
series as a prerequisite.

Link: https://lore.kernel.org/linux-rdma/TYCPR01MB845522FD536170D75068DD41E5099@TYCPR01MB8455.jpnprd01.prod.outlook.com/
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

v3:
  Fixed an error in patch 4/8 "RDMA/rxe: Cleanup error state handling in
  rxe_comp.c". Didn't set wqe.status to IB_WC_WR_FLUSH_ERR when
  flushing send queue. This broke blktests which calls modify qp to
  set qp to IB_QPS_ERR and waits for the flushed cqe's.

v2:
  This version of this series split off the changes to rxe debug code
  which have been submitted as "RDMA/rxe: Add error logging to rxe".
  One unrelated patch was dropped and other patches earlier included
  in a series to convert from tasklets to workqueues were moved into
  this series because they are relevant both for the tasklet version
  and the workqueue version of the driver.

Bob Pearson (8):
  RDMA/rxe: Convert tasklet args to queue pairs
  RDMA/rxe: Warn if refcnt zero in rxe_put
  RDMA/rxe: Cleanup reset state handling in rxe_resp.c
  RDMA/rxe: Cleanup error state handling in rxe_comp.c
  RDMA/rxe: Remove qp reference counting in tasks
  RDMA/rxe: Remove __rxe_do_task()
  RDMA/rxe: Make tasks schedule each other
  RDMA/rxe: Rewrite rxe_task.c

 drivers/infiniband/sw/rxe/rxe.h      |   1 -
 drivers/infiniband/sw/rxe/rxe_comp.c |  71 +++++--
 drivers/infiniband/sw/rxe/rxe_cq.c   |   1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |   6 +-
 drivers/infiniband/sw/rxe/rxe_pool.c |   2 +
 drivers/infiniband/sw/rxe/rxe_qp.c   |  56 ++----
 drivers/infiniband/sw/rxe/rxe_req.c  |  12 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 114 ++++++------
 drivers/infiniband/sw/rxe/rxe_task.c | 268 +++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_task.h |  23 ++-
 10 files changed, 353 insertions(+), 201 deletions(-)


base-commit: c48438c1e307a86a2c20c4c42120e580de4d8dbc
-- 
2.37.2

