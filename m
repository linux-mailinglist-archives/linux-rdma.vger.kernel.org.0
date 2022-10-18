Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD7C60234F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJREgB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJREgA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:00 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0DFA0240
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:35:56 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id l5so14398152oif.7
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3/gQQYPozHD+m1h9dT5rO68+c96fdSSFKRiOIFCeDk=;
        b=JZso/cz3bUcGGhAyP0QMoyE1oHUz9mcwE0eHL8xz2KEl502c3fmdQvBlgQVXukqFMD
         XrkRCoApIcTfw3vQ2fDGRRMonYUwNWYYtQoH6E54ViqjN4q5AJjtjrM4EZiUrrVS5eIP
         VO5QNLNiQ8B4UoYdukvbd4pejJsRlWsUqr4HnlWWOipMWMwR08oHgIMB0myjaL7wSs2D
         A4tJZWrml/Nt1DkvDP1yUlzVjpVZ+q9pYBDIYYNn6aoUJD2TRE6i6UZLIk67KULRFm94
         P9QxeMn+OyM5xRQnzxXRja+7r4NjgJGwlfptFDXFHM34LdpFMNMQHp+KsoVqVEEVvlJZ
         563g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3/gQQYPozHD+m1h9dT5rO68+c96fdSSFKRiOIFCeDk=;
        b=SFjnuyLVpbY08V29FIJGiWcdJnibU12XkQWVmjAI3F4mvSMBxw9cV2iykw38L2tBlh
         4BRtdOisaBkGB5GjehjD+nza7fjpogZCDikp2rsaGt0YVh1jCtuat4yr7DFQVnxYLvlN
         V8KpbuDRd9zOH59VhjvmmmCjCBT1ywO8VfcS2/1SwSVuczz1ABWNY8+ccrRVknSDAJM9
         fiIfgK++kDJ8u1yX0UUnrVRtd2YgTCEfSaJ7kkFMxhEBMQSnIdWN66SyPuoUSXY4H1a3
         GLqBdanpyJT605nz5PzEI5xNeaLKj0yuIBaoUQPAwzypdVXRFxNboB9fXkwcmLaij00g
         AdJA==
X-Gm-Message-State: ACrzQf3811Od4Z3y1PON0PxoH0XEGv3c7dygJB2RSAcxsb1CyeOd/s14
        y2L5dKxjS28hlAhmXvqE8Lkuum8bKfByDw==
X-Google-Smtp-Source: AMsMyM5dUQSQIEBiIPYsPBuH/n2PTiYnWwxksjuZcGT1DNcow7wAD01lCAZInin88DxFk/il/ULf2Q==
X-Received: by 2002:a05:6808:1481:b0:355:454b:5b02 with SMTP id e1-20020a056808148100b00355454b5b02mr556804oiw.186.1666067756026;
        Mon, 17 Oct 2022 21:35:56 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:35:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 00/16] Implement work queues for rdma_rxe
Date:   Mon, 17 Oct 2022 23:33:30 -0500
Message-Id: <20221018043345.4033-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch series implements work queues as an alternative for
the main tasklets in the rdma_rxe driver. The first few patches
perform some cleanups of the current tasklet code followed by a
patch that makes the internal API for task execution pluggable and
implements an inline and a tasklet based set of functions.
The remaining patches cleanup the qp reset and error code in the
three tasklets and modify the locking logic to prevent making
multiple calls to the tasklet scheduling routine. Finally after
this preparation the work queue equivalent set of functions is
added and module parameters are implemented to allow tuning the
task types.

The advantages of the work queue version of deferred task execution
is mainly that the work queue variant has much better scalability
and overall performance than the tasklet variant. The tasklet
performance saturates with one connected queue pair and stays constant.
The work queue performance is slightly better for one queue pair but
scales up with the number of connected queue pairs. The perftest
microbenchmarks in local loopback mode (not a very realistic test
case) can reach approximately 100Gb/sec with work queues compared to
about 16Gb/sec for tasklets.

This patch series is derived from an earlier patch set developed by
Ian Ziemba at HPE which is used in some Lustre storage clients attached
to Lustre servers with hard RoCE v2 NICs.

Bob Pearson (16):
  RDMA/rxe: Remove init of task locks from rxe_qp.c
  RDMA/rxe: Removed unused name from rxe_task struct
  RDMA/rxe: Split rxe_run_task() into two subroutines
  RDMA/rxe: Make rxe_do_task static
  RDMA/rxe: Rename task->state_lock to task->lock
  RDMA/rxe: Make task interface pluggable
  RDMA/rxe: Simplify reset state handling in rxe_resp.c
  RDMA/rxe: Split rxe_drain_resp_pkts()
  RDMA/rxe: Handle qp error in rxe_resp.c
  RDMA/rxe: Cleanup comp tasks in rxe_qp.c
  RDMA/rxe: Remove __rxe_do_task()
  RDMA/rxe: Make tasks schedule each other
  RDMA/rxe: Implement disable/enable_task()
  RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
  RDMA/rxe: Add workqueue support for tasks
  RDMA/rxe: Add parameters to control task type

 drivers/infiniband/sw/rxe/rxe.c       |   9 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |  35 ++-
 drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  87 +++----
 drivers/infiniband/sw/rxe/rxe_req.c   |  10 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  75 ++++--
 drivers/infiniband/sw/rxe/rxe_task.c  | 354 ++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_task.h  |  76 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |   8 +-
 9 files changed, 451 insertions(+), 207 deletions(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.34.1

