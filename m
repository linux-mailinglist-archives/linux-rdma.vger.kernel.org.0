Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E497A69FF99
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Feb 2023 00:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjBVXfg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 18:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjBVXff (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 18:35:35 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB4474F7
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:23 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id v17-20020a0568301bd100b0068dc615ee44so1833405ota.10
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dfau05t/szdUqvGJGr72ktanrWPm1nUDAg0gheyIgp4=;
        b=P5d5TuWkJQnAwxvlADRZeE0fS590duHfg67dgvSzxLnxYOuLOnVZCJVLZ0Bh69oiKs
         UvTtnxGPPtY6Hv+LKlKxcqMioeptA34v+csxxL+3E7jqjTDuH4E3JGkQOFwUtIg5cYQ+
         8yCDpc7K/a17LLy0lt3RfeIZ+VbwSezXVoiSM8rKclb1P1Pk9oXHVGsahM+Bk7nQyVkc
         73PaSlF480na0Ntiurc0tqHWE9YGVJcHAlGnxXtD42xEALUbeMHhAcM4nBwEuMGkJgXi
         dxQUsS/PAXqC2seXMuhwc0zUXBhV6l0rbHF095lb8rOnM7639cBnMwujW27+HT2Ph9sY
         85bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dfau05t/szdUqvGJGr72ktanrWPm1nUDAg0gheyIgp4=;
        b=bLvNHrUe/1rQ0iqTGpuztoWjVB3sdQ6/kVlH35jpYnjX5oROPM78DNxCZBeQcpnIfS
         5fOo4V2aFLDTJofOP7WTRi8lVZI6UCIXmClIY9lnETOxn4A9cZKMtzun8JTQ5V73iVcD
         waMA0Yu9HoXLa/AYXX2L0ENalFxk7vsuE63dlyXqG1RLXPM6CvaqgIzEQUCC2+setfdg
         mSeDbz1E2sUjE3phbCt+gK34Wl38xFWJFga/HpRc3+EHxSQ+pHA+khS6z/t2hzc//4/F
         Szzbl/kn36ZrCUeaWHpB9E/ucdEChFWKC+RHridJMZ1905fid3NTaF82+NcINrNbg3As
         QHew==
X-Gm-Message-State: AO0yUKXrN5K2nDTuNrBBxkQmcHcQ7e7a0gglqrMJkHLKVutPFMr4BmCx
        L0D+Glug++Xyg0rmlo97a4c=
X-Google-Smtp-Source: AK7set+6exJ/fFRXkBAOH3aSw0dnKEQmSMIG4ETGAzmcof7VZ535op2sF/P70+dPpmCPjGktoYGrFA==
X-Received: by 2002:a9d:848:0:b0:68b:c6c4:f665 with SMTP id 66-20020a9d0848000000b0068bc6c4f665mr5004355oty.16.1677108922801;
        Wed, 22 Feb 2023 15:35:22 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e92c-8850-3fad-351f.res6.spectrum.com. [2603:8081:140c:1a00:e92c:8850:3fad:351f])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7093000000b0068663820588sm2723281otj.44.2023.02.22.15.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:35:21 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/9] RDMA/rxe: Correct qp reference counting
Date:   Wed, 22 Feb 2023 17:32:29 -0600
Message-Id: <20230222233237.48940-1-rpearsonhpe@gmail.com>
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

In the course of this work it was necessary to improve the
logging capabilities of the driver and these are included as
well.

This patch series is based on the current for-next branch. It
has been tested with long simultaneous runs of pyverbs
and perftest.

Link: https://lore.kernel.org/linux-rdma/TYCPR01MB845522FD536170D75068DD41E5099@TYCPR01MB8455.jpnprd01.prod.outlook.com/
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Bob Pearson (9):
  RDMA/rxe: Extend debug log messages
  RDMA/rxe: Add error messages
  RDMA/rxe: Convert tasklet args to queue pairs
  RDMA/rxe: Remove extra rxe_get(qp) in rxe_rcv_mcast_pkt
  RDMA/rxe: Add a warning if refcnt zero in rxe_put
  RDMA/rxe: Replace some __rxe_do_task by rxe_sched_task
  RDMA/rxe: Check for unsupported wr opcodes
  RDMA/rxe: Remove qp reference counting in tasks
  RDMA/rxe: Rewrite rxe_task.c

 drivers/infiniband/sw/rxe/rxe.c       |  28 +-
 drivers/infiniband/sw/rxe/rxe.h       |  45 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |  11 +-
 drivers/infiniband/sw/rxe/rxe_cq.c    |   6 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   7 +-
 drivers/infiniband/sw/rxe/rxe_mmap.c  |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  13 -
 drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  |   2 +
 drivers/infiniband/sw/rxe/rxe_qp.c    |  53 +-
 drivers/infiniband/sw/rxe/rxe_recv.c  |   1 -
 drivers/infiniband/sw/rxe/rxe_req.c   |   8 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  11 +-
 drivers/infiniband/sw/rxe/rxe_srq.c   |   6 +-
 drivers/infiniband/sw/rxe/rxe_task.c  | 275 ++++++--
 drivers/infiniband/sw/rxe/rxe_task.h  |  17 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 866 +++++++++++++++++++-------
 18 files changed, 969 insertions(+), 394 deletions(-)


base-commit: 66fb1d5df6ace316a4a6e2c31e13fc123ea2b644
-- 
2.37.2

