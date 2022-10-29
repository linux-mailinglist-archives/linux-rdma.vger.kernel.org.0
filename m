Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E12611F9B
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJ2DKq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ2DKm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:42 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D3B29357
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:18 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so1012009ooo.8
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8btd9ncQ/MSFSzv01OHi2W8mdY0Le48EqGxGfxU2t60=;
        b=Cv97KIKJ+qr/RDFJEILIWUDFIZYrfFwaFWp/+YAqwTm5prbGnHZs+JvK7Dwa53q2oQ
         NdgBfINRPfjhLXXxPioWf1fLfODj8w5GmxDT0wduvrL0VCxWGq+aantymhbpqLmPQroL
         KV7JcYRiTBRhrSAJuu7VkEmrY4Rg9sQ2g1fTt1MjliqrQ16di7zThrar7cg1WYY4Tr7J
         aQbdloJRI4ym6Z6w4bvk18U6cH8x9fQhAJ95P/fygPaiC1GWtzqcTJIDqLwSgsVOVC8N
         dzecOh+BH4s6RwEgaGaPm5jF+Yv7gdZl5kRa60VeUHNtjSkDx6IRIg0DpZLpzkhz07bF
         P2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8btd9ncQ/MSFSzv01OHi2W8mdY0Le48EqGxGfxU2t60=;
        b=zXZxuXzRT4rwfh7GP6wB9LAMv225dSQjwquHOmYF99ySZNkpjoI74z7TH1KfkrWsRd
         hD31wma9MZkW2bysD8ETRFijfU6Mjpq7WbwK7iHmhTI+B2nhGuT7VApGuxO1ERbLrGQk
         ktkap0dJiCLx6cn4CSaoKYcWwOjB3euoG7bXSWf4qon8XzXwWiaftRK/dzpk3tzT2x5X
         dmxXRhbXmc0E+CVG3F/rL3IODyvM9twsK/A4+0CWll45VpZg2FN5nXWm3nNvVwjlu1hF
         OrmPqt8Gu8B79IP4ya9OmPc6Dw6oRgS/Vqchs5IiCEPlUkgGJzfr1wizrDp8WuveyT4K
         +JqA==
X-Gm-Message-State: ACrzQf2h1ZCgWnSrxptW9EecWI1tLg7O3KEc5Na9fDKfme6IQ2RHXOSQ
        FHk6k9MZciwidQ83iGI/bVLeuAiAbDg=
X-Google-Smtp-Source: AMsMyM5XP5gWHYVsSD8wH0V6iyb94jLr/AwDB8b5VdQQMj8TAuevuDFyp5O7Aats7E8PVB0WbDHA0Q==
X-Received: by 2002:a4a:e587:0:b0:47f:7e7c:f7e5 with SMTP id o7-20020a4ae587000000b0047f7e7cf7e5mr1107051oov.52.1667013018017;
        Fri, 28 Oct 2022 20:10:18 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 00/13] Implement work queues for rdma_rxe
Date:   Fri, 28 Oct 2022 22:09:57 -0500
Message-Id: <20221029031009.64467-1-rpearsonhpe@gmail.com>
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
the main tasklets in the rdma_rxe driver. The patch series starts
with a patch that makes the internal API for task execution pluggable
and implements an inline and a tasklet based set of functions.
The remaining patches cleanup the qp reset and error code in the
three tasklets and modify the locking logic to prevent making
multiple calls to the tasklet scheduling routine. After
this preparation the work queue equivalent set of functions is
added and the tasklet version is dropped. 

The advantages of the work queue version of deferred task execution
is mainly that the work queue variant has much better scalability
and overall performance than the tasklet variant.  The perftest
microbenchmarks in local loopback mode (not a very realistic test
case) can reach approximately 100Gb/sec with work queues compared to
about 16Gb/sec for tasklets.

This version of the patch series drops the tasklet version as an option
but keeps the option of switching between the workqueue and inline
versions.

This patch series is derived from an earlier patch set developed by
Ian Ziemba at HPE which is used in some Lustre storage clients attached
to Lustre servers with hard RoCE v2 NICs.

It is based on the current version of wip/jgg-for-next.

v3:
Link: https://lore.kernel.org/linux-rdma/202210220559.f7taTL8S-lkp@intel.com/
The v3 version drops the first few patches which have already been accepted
in for-next. It also drops the last patch of the v2 version which
introduced module parameters to select between the task interfaces. It also
drops the tasklet version entirely. It fixes a minor error caught by
the kernel test robot <lkp@intel.com> with a missing static declaration.

v2:
The v2 version of the patch set has some minor changes that address
comments from Leon Romanovsky regarding locking of the valid parameter
and the setup parameters for alloc_workqueue. It also has one
additional cleanup patch.

Bob Pearson (13):
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
  RDMA/rxe: Make WORKQUEUE default for RC tasks
  RDMA/rxe: Remove tasklets from rxe_task.c

 drivers/infiniband/sw/rxe/rxe.c      |   9 +-
 drivers/infiniband/sw/rxe/rxe_comp.c |  24 ++-
 drivers/infiniband/sw/rxe/rxe_qp.c   |  80 ++++-----
 drivers/infiniband/sw/rxe/rxe_req.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c |  70 +++++---
 drivers/infiniband/sw/rxe/rxe_task.c | 258 +++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_task.h |  56 +++---
 7 files changed, 329 insertions(+), 172 deletions(-)


base-commit: 692373d186205dfb1b56f35f22702412d94d9420
-- 
2.34.1

