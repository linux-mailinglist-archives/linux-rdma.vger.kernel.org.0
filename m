Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2456A671D
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 05:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCAEwm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 23:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAEwl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 23:52:41 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995669757
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:40 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q15so9837160oiw.11
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g0EuiMX6POWXkAkP3FkRqTUzvLxPW1Dg5W+nWJLnl84=;
        b=a/A7KQaCFqyGESCPkYKGWUGSc2aXRLhGLq7pgYrNLLljaCWY5DuXyHo53Rb3e/RuFr
         lrJ97nledi2TjPNIT4gYT7fBu7WuI5KsfIHCxgG4UOvVcuOe4jD2gKMM5YgaoCz/chOT
         aNH2Otbl9iK/9REkQqwE7IZzcElLeZRnZZ9xhfBciwt5VM3CFfcduOjCXZFVTFfP1FRb
         2Y4jQ5S7PnHqjyz7564IcIEe9jeZYCfnvvmg25muOFHcJ/v/3kEMQNWyKqqzQcyc1CRz
         YpFKr+fSvPXRkqe4r7RmZIsnZmqeiT+JD4b8JkTW8FUOpgkOLF1Z+GVW6UiHVODpYSYR
         lDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0EuiMX6POWXkAkP3FkRqTUzvLxPW1Dg5W+nWJLnl84=;
        b=wI/q60OaTlNk+aBOvssdoPTqUSySCGPx/r8N2JF/s29+G2DkS7p0A7P+IhHC4dn+jj
         1wbntCDQirM8XsC0Gw8TdZtYjfd05pQZDBQ/vor6vgwnaHjznTd2fyeSIZaqTUzJCdyg
         WLHCNwFIEZ7BSimZ1kVrPX3oOopYZxWZqv0WlhV9rIN25zAXxnXEBPbzpbQxsDjNrygL
         3u+T/A4BlSnO9Qw4Gez1pfpf583Ls2tKZve/FElR+b6Eix9Rxz/z+HpxMOBqKoe1i7Oo
         zgzyfrUTNe5i1C3nFnlh8b5mZcjTcKd6KsfTtuRg4RkqDkOlmDWjbF0+9CbXxWwXZFv5
         yOBA==
X-Gm-Message-State: AO0yUKUuXTo/rtFQEwHCVLhdPUcSdpw0hgwySUQ6oFe0Y1cgG7HmNdkQ
        XsmB6lZ7ZRqk4FvnWRm5M9A=
X-Google-Smtp-Source: AK7set94mn0B6Ymey1UhdEjheTGQtHrVGp97y9bDDb0Tzy6t0Y94E9q6UknLAgbyshk9ZrVG6k70NQ==
X-Received: by 2002:aca:2407:0:b0:384:f4c:7ee2 with SMTP id n7-20020aca2407000000b003840f4c7ee2mr2586603oic.30.1677646359930;
        Tue, 28 Feb 2023 20:52:39 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm5309604oib.13.2023.02.28.20.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:52:39 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 0/8] RDMA/rxe: Correct qp reference counting
Date:   Tue, 28 Feb 2023 22:51:47 -0600
Message-Id: <20230301045154.23733-1-rpearsonhpe@gmail.com>
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

v2:
  This version of this series split off the changes to rxe debug code
  which have been submitted as "RDMA/rxe: Add error logging to rxe".
  One unrelated patch was dropped and other patches earlier included
  in a series to convert from tasklets to workqueues were moved into
  this series because they are relevant both for the tasklet version
  and the workqueue version of the driver.

Bob Pearson (8):
  RDMA/rxe: Convert tasklet args to queue pairs
  RDMA/rxe: warn if refcnt zero in rxe_put
  RDMA/rxe: Cleanup reset state handling in rxe_resp.c
  RDMA/rxe: Cleanup error state handling in rxe_comp.c
  RDMA/rxe: Remove qp reference counting in tasks
  RDMA/rxe: Remove __rxe_do_task()
  RDMA/rxe: Make tasks schedule each other
  RDMA/rxe: Rewrite rxe_task.c

 drivers/infiniband/sw/rxe/rxe.h      |   1 -
 drivers/infiniband/sw/rxe/rxe_comp.c |  71 +++++--
 drivers/infiniband/sw/rxe/rxe_loc.h  |   6 +-
 drivers/infiniband/sw/rxe/rxe_pool.c |   2 +
 drivers/infiniband/sw/rxe/rxe_qp.c   |  56 ++----
 drivers/infiniband/sw/rxe/rxe_req.c  |  12 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 114 ++++++------
 drivers/infiniband/sw/rxe/rxe_task.c | 268 +++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_task.h |  23 ++-
 9 files changed, 352 insertions(+), 201 deletions(-)


base-commit: bceed5834cd43a0ed67e35ec16197a5c882d3a6d
-- 
2.37.2

