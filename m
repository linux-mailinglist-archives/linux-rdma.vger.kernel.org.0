Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB85607F7C
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJUUDe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJUUD0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:03:26 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFBA263B7E
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:03:18 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13ae8117023so4889373fac.9
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRM3ISXSCOAgWY0giM3tFNjXOHiP7T6JUSVvbmPDS/M=;
        b=NwclfFzSDQlfEjq3w5Oi8QFSACawhKDuyOPc8tcQzT/oS0n8fr1Hg26xmqpRVnOMC3
         gUnT6fLdtH9LxnSeRJO72AtF+7Eas9SNA3M+Wj+e1Q4Wy3Ju4JbtayedY1evUzs0jgWe
         tjhsbvKOnucIiMZ0M7nmVnbjCiut+6wbb0tUy2lH6tVGAgfzaAa4QxBAfeGIUrZ/RcxP
         U12PPiwfPG74IsqVmsNWeKXo2KozjXqLsOpPB3bqMM5up8+FxPEDW69xZd8jKaJ3SfbX
         mjId7tgqSHr0ZJfsANCPY/8qtV/UvOBaCDUgyBSY4J+abivz+PChllWxARxzsxqrAMW8
         CVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRM3ISXSCOAgWY0giM3tFNjXOHiP7T6JUSVvbmPDS/M=;
        b=i76jaKqun+VOBgIpcXZMnX8acVjOaRgl8vb2rplaDVJYYoQwbyib7RWl66Fi0SEg9D
         PchazA4ed2vvpfXNFQveMfYBKTFKFYfR95o/VQei1N0P5tysXKSuANr3XD3lYAgKSs4e
         tT9WY4gXMSRMHQrVjh/9UrXv1TqSm596GZtFoWJy1RfHKa/YUxZbK8lPS8Bb+3pRxjUs
         zn+B2CTXUKh949T+Nz2E8CYAYWnq9b4F4WwkaBYy5OLb5KQ65MReFsU6wM+6A/xR/5gd
         MWm4QUkc/G2peHr5J/Fz8UbOuAnmBWdiQi63K8doNMT0vVASdSg24wMhQWPp0nNhNehe
         9joA==
X-Gm-Message-State: ACrzQf3d+soI0Gb8PR0oZoELqA/Uohp5pEdPcOwCflGtoZrYVy4xsYNa
        7P8kA6aD75RCgA3hS2Ykb06oj02CG1k=
X-Google-Smtp-Source: AMsMyM46N+WRFsr4Ucjc1Fw90cQSCr+iWq6wGfWcVPXN2MtbZ/+cE9yNLp4XrFdPTdQV9/PzZqwknw==
X-Received: by 2002:a05:6870:a2c7:b0:131:d098:9e37 with SMTP id w7-20020a056870a2c700b00131d0989e37mr13151526oak.152.1666382505876;
        Fri, 21 Oct 2022 13:01:45 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:01:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 00/18] Implement work queues for rdma_rxe
Date:   Fri, 21 Oct 2022 15:01:01 -0500
Message-Id: <20221021200118.2163-1-rpearsonhpe@gmail.com>
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

It is expected that the work queue version will take the place of
the tasklet version once this patch series is accepted and moved
upstream. However, for now it is convenient to keep the option of
easily switching between the versions to help benchmarking and
debugging.

This patch series is derived from an earlier patch set developed by
Ian Ziemba at HPE which is used in some Lustre storage clients attached
to Lustre servers with hard RoCE v2 NICs.

This v2 version of the patch set has some minor changes that address
comments from Leon Romanovsky regarding locking of the valid parameter
and the setup parameters for alloc_workqueue. It also has one
additional cleanup patch.

Bob Pearson (18):
  RDMA/rxe: Remove redundant header files
  RDMA/rxe: Remove init of task locks from rxe_qp.c
  RDMA/rxe: Removed unused name from rxe_task struct
  RDMA/rxe: Split rxe_run_task() into two subroutines
  RDMA/rxe: Make rxe_do_task static
  RDMA/rxe: Rename task->state_lock to task->lock
  RDMA/rxe: Make task interface pluggable
  RDMA/rxe: Split rxe_drain_resp_pkts()
  RDMA/rxe: Simplify reset state handling in rxe_resp.c
  RDMA/rxe: Handle qp error in rxe_resp.c
  RDMA/rxe: Cleanup comp tasks in rxe_qp.c
  RDMA/rxe: Remove __rxe_do_task()
  RDMA/rxe: Make tasks schedule each other
  RDMA/rxe: Implement disable/enable_task()
  RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
  RDMA/rxe: Replace task->destroyed by task state INVALID.
  RDMA/rxe: Add workqueue support for tasks
  RDMA/rxe: Add parameters to control task type

 drivers/infiniband/sw/rxe/rxe.c       |   9 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |  35 ++-
 drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  87 +++----
 drivers/infiniband/sw/rxe/rxe_req.c   |  10 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  75 ++++--
 drivers/infiniband/sw/rxe/rxe_task.c  | 339 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_task.h  |  77 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |   8 +-
 9 files changed, 427 insertions(+), 217 deletions(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.34.1

