Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A9F6063BF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Oct 2022 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJTPCu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Oct 2022 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJTPCt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Oct 2022 11:02:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1E11C5A68
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 08:02:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i9so1817406wrv.5
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lFzxi2+Pf+HJE5P7sThuX6Zki3A70pmMtyRywO5tUKM=;
        b=hVVXBM7KI3HqP0blB/bo5BAPz2oImUmgGg78jo+2oaufmLq6wZLI3TVRwYVa3bz7K8
         SFt/GGv4C2jYohfvE3KBG1F5zxeUfZrZwTTlO515VuSSVYG1OGgEudje9EBFk5Xb9cIC
         jBavLuTtstKQLmFzIVAEtfhaukF3AGQPZIaViKWldYV3tQPY/r5gTDwFN5RwjfaZch9c
         VhKfJT6UI16pACoN4Rt05q1M8mlVo0BoDVlbaKuBxFn6jvg5FmYXRqu6gkxG5m6ibhj2
         hMgAaeFe1AI/YrQMkkBRxE7BnjfB7EXOeqUqSv2RVQ/jbnNjYNR9ISclAH3G/ONjw1GK
         jNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFzxi2+Pf+HJE5P7sThuX6Zki3A70pmMtyRywO5tUKM=;
        b=71kGjjm48t7GvkGC0STul1Eo1Ll3Nzze9l41g3XuSXtG+GFd8u/GE2WJGJpmjnHMAC
         KIj1tMqGVRAPaxyENpoBF1LNPMiHJyzsEm2XYTpNRWpSVvnAnWaXA2zFvcAaO47lB0/o
         LjD92NYlMxZHDC+Ul+sU3bMw413ArI2O+05KbiBo2uk8mrls3vK+byXkkUyYuuG54Lov
         C7kVREsG16e5wINdgGKKIaDqrQavx1r8WUBhoJFXUgZUg9go2S7knXxHDAAqCMOYNZaZ
         XqLad7qHk2Vgzv37USmELcXXUpF9xbKWUtbQ3zfTRegMK3xhdIQ7hffdfulxTUPwJUfA
         dSLg==
X-Gm-Message-State: ACrzQf0OMyosnHrbCSFSLf/TghMgTyt60Sc5/DhnyuHkWFu7zK95u8J0
        8plrM9ZC7OXmi9oJtH5byFn9tehdXsxfveCk268=
X-Google-Smtp-Source: AMsMyM6rzHGFkETs1A3jOh8DSNA0+8Mv/fTdEnljv7/WefxwCuaxZaQj8gcOd1wZe+zsUOEIaXhYMpWTmeujrE/MC8k=
X-Received: by 2002:a05:6000:18a2:b0:22e:72fd:c5d0 with SMTP id
 b2-20020a05600018a200b0022e72fdc5d0mr8727683wri.682.1666278167118; Thu, 20
 Oct 2022 08:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
In-Reply-To: <20221018043345.4033-1-rpearsonhpe@gmail.com>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Thu, 20 Oct 2022 17:02:20 +0200
Message-ID: <CAE_WKMz8kTWY_-BCheuqj+szpS9rkSrE+NFGLa-0-WXcKr5Sug@mail.gmail.com>
Subject: Re: [PATCH for-next 00/16] Implement work queues for rdma_rxe
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 18, 2022 at 6:39 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> This patch series implements work queues as an alternative for
> the main tasklets in the rdma_rxe driver. The first few patches
> perform some cleanups of the current tasklet code followed by a
> patch that makes the internal API for task execution pluggable and
> implements an inline and a tasklet based set of functions.
> The remaining patches cleanup the qp reset and error code in the
> three tasklets and modify the locking logic to prevent making
> multiple calls to the tasklet scheduling routine. Finally after
> this preparation the work queue equivalent set of functions is
> added and module parameters are implemented to allow tuning the
> task types.
>
> The advantages of the work queue version of deferred task execution
> is mainly that the work queue variant has much better scalability
> and overall performance than the tasklet variant. The tasklet
> performance saturates with one connected queue pair and stays constant.
> The work queue performance is slightly better for one queue pair but
> scales up with the number of connected queue pairs. The perftest
> microbenchmarks in local loopback mode (not a very realistic test
> case) can reach approximately 100Gb/sec with work queues compared to
> about 16Gb/sec for tasklets.
>
> This patch series is derived from an earlier patch set developed by
> Ian Ziemba at HPE which is used in some Lustre storage clients attached
> to Lustre servers with hard RoCE v2 NICs.
>
> Bob Pearson (16):
>   RDMA/rxe: Remove init of task locks from rxe_qp.c
>   RDMA/rxe: Removed unused name from rxe_task struct
>   RDMA/rxe: Split rxe_run_task() into two subroutines
>   RDMA/rxe: Make rxe_do_task static
>   RDMA/rxe: Rename task->state_lock to task->lock
>   RDMA/rxe: Make task interface pluggable
>   RDMA/rxe: Simplify reset state handling in rxe_resp.c
>   RDMA/rxe: Split rxe_drain_resp_pkts()
>   RDMA/rxe: Handle qp error in rxe_resp.c
>   RDMA/rxe: Cleanup comp tasks in rxe_qp.c
>   RDMA/rxe: Remove __rxe_do_task()
>   RDMA/rxe: Make tasks schedule each other
>   RDMA/rxe: Implement disable/enable_task()
>   RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
>   RDMA/rxe: Add workqueue support for tasks
>   RDMA/rxe: Add parameters to control task type
>
>  drivers/infiniband/sw/rxe/rxe.c       |   9 +-
>  drivers/infiniband/sw/rxe/rxe_comp.c  |  35 ++-
>  drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c    |  87 +++----
>  drivers/infiniband/sw/rxe/rxe_req.c   |  10 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  |  75 ++++--
>  drivers/infiniband/sw/rxe/rxe_task.c  | 354 ++++++++++++++++++++------
>  drivers/infiniband/sw/rxe/rxe_task.h  |  76 +++---
>  drivers/infiniband/sw/rxe/rxe_verbs.c |   8 +-
>  9 files changed, 451 insertions(+), 207 deletions(-)
>
>
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780

The patch series is not applying cleanly over the mentioned commit for
me. Patch 'PATCH for-next 05/16] RDMA/rxe: Rename task->state_lock to
task->lock.' fails at "drivers/infiniband/sw/rxe/rxe_task.c:103".
I corrected that manually, then it fails in the next commit. Didn't
check after that. Is it the same for others or is it just me?

> --
> 2.34.1
>
