Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5245085E3
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 12:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbiDTKbk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 06:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiDTKbj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 06:31:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A763D1EF
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 03:28:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq30so2168285lfb.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vpWdVGrHUeSUMvqPJAukxoE0PGiwXp4w08ep9pXOCPU=;
        b=XyjdUz64W3PKQLvO3dZXf8bwz3GRvc390JLLmhPuctZh2NUDhTfVNYxGugbX+8gRPR
         ajvTx4hH41Ypa0Kc8imvhAl5XKNXrOUSPfIlpl27/Jwo6zJ7Ihp+gsUZcvArTMitOTie
         7KDY8cAS0zK/XhJaupBwYDvdt9fDBvwbSjwdlXYWSWxZy4Cgrxee3spfH+6Ey5HTu2+q
         LnqvUvA/0laihJzN3Y/o+JQ/Q4gYuSVBaydXGeMemUqHsPTuTD+UsZx7Xw07vohg99el
         R/Tp2UVUycSTQ1mAXwSHNpXn7JQQWfEF1C+5Wp+GF9vT8uufEFrRcjsymu7cImnW/V0q
         b81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vpWdVGrHUeSUMvqPJAukxoE0PGiwXp4w08ep9pXOCPU=;
        b=VqEz/z9Pv9uzmEmchdaIZmurOT5sfuWAM63D2tsI0IV0jqXdldEkc8j6MmC+XJF9Xj
         jJkWPlOANapQZt+/mmA7KVGxv8fAavp7rA7LXdpAvjZT3jO1+hHIVHviepco72EzFcP4
         St0ID1pfM+h3fuLfDz8T1R+PqrKUAz7UpYiC5DJPtcEf4GiuD/WUDHzEx9Z1ZwWP31vP
         NY4Zan01E3mZIM/+uBQwOB49UPLQ1Fhu6apJVVDpPTEL2/2mBGU/+SE2VzH18eN3qXoq
         iqe5SDo7x9oal7DXLEclabnMAyU8JQN2oT5wOrpIIaCIUe18vgvk0R4OuNe5hq8VOcX5
         moRA==
X-Gm-Message-State: AOAM531fiK3SBmr/+izIXhQ3u4ADSvUy/i2QvreCBxVBYh2t0xisvUJQ
        jsYIlZg7LgmNaiy9KiYlAMiyJ8dGUe7RDi06XjMsZ1JXIw2IMg==
X-Google-Smtp-Source: ABdhPJwiTLh04KqjbN8O9rpes9cNN1HXl/GjhKggiwT/+AjyZzbIWbkW8vATgTCUGaWm6yC2kbiSk6cflgv1WSfOtm8=
X-Received: by 2002:a05:651c:4ce:b0:24d:b887:2113 with SMTP id
 e14-20020a05651c04ce00b0024db8872113mr9977730lji.111.1650450531332; Wed, 20
 Apr 2022 03:28:51 -0700 (PDT)
MIME-Version: 1.0
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 20 Apr 2022 12:28:40 +0200
Message-ID: <CAJpMwygqY4qwXfHd88wYs+KdKDEB=z=CzFd7jTVos-S3XNT5Yg@mail.gmail.com>
Subject: Encountering errors while using RNBD over rxe for v5.14
To:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        yanjun.zhu@linux.dev
Cc:     Jinpu Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

We are facing some issues with the rxe driver in v5.14 (tested with 5.14.21)

After mapping a single RNBD device with 2 rxe interfaces, and with the
below fio config,

[global]
description=Emulation of Storage Server Access Pattern
bssplit=512/20:1k/16:2k/9:4k/12:8k/19:16k/10:32k/8:64k/4
fadvise_hint=0
rw=randrw:2
direct=1
random_distribution=zipf:1.2
time_based=1
runtime=60
ramp_time=1
ioengine=libaio
iodepth=128
iodepth_batch_submit=128
iodepth_batch_complete_min=1
iodepth_batch_complete_max=128
numjobs=1
group_reporting

[job1]
filename=/dev/rnbd0


We observe the following error,

[Fri Mar 25 19:08:03 2022] rtrs_client L353: <blya>: Failed
IB_WR_LOCAL_INV: WR flushed
[Fri Mar 25 19:08:03 2022] rtrs_client L333: <blya>: Failed
IB_WR_REG_MR: WR flushed
[Fri Mar 25 19:08:03 2022] rtrs_client L333: <blya>: Failed
IB_WR_REG_MR: WR flushed
[Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>: Failed
IB_WR_LOCAL_INV: WR flushed
[Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>: Failed
IB_WR_LOCAL_INV: WR flushed
[Fri Mar 25 19:08:34 2022] rtrs_client L448: <blya>: IO request
failed: error=-103 path=ip:192.168.123.77@ip:192.168.123.206
[mlx4_1:1] notify=0
[Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>: Failed
IB_WR_LOCAL_INV: WR flushed
[Fri Mar 25 19:08:34 2022] rtrs_client L448: <blya>: IO request
failed: error=-103 path=ip:192.168.123.77@ip:192.168.123.206
[mlx4_1:1] notify=0

This is only happening for writes. If I change the above fio to rand
read only, there is no error.

I digged into the reason why this error is happening.

During the processing of an rxe packet, while doing lookup_mr, it
discovers that the state of the mr in not RXE_MR_STATE_VALID; and is
RXE_MR_STATE_FREE.

The code path of the error is
rxe_requester -> finish_packet -> copy_data -> lookup_mr

The mr for which this lookup is happening is the wqe dma.


I tried bisecting the branch to try to find the rouge commit, but it
lands up in the below commit.

$ git show e04360a2ea01bf42aa639b65aad81f502e896c7f
commit e04360a2ea01bf42aa639b65aad81f502e896c7f (refs/bisect/bad)
Merge: 514798d36572 3d8287544223
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu Jul 1 14:54:03 2021 -0700

Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma

So I found out all the commits that went into this merge commit. The
starting and the end commits of that merge commit are as follows,
591f762b2750
3d8287544223

So I checked out the last commit, (below), but that somehow doesn't
have the error.

commit 3d8287544223a3d2f37981c1f9ffd94d0b5e9ffc (HEAD)
Author: Leon Romanovsky <leonro@nvidia.com>
Date:   Tue Jun 29 09:49:33 2021 +0300

    RDMA/core: Always release restrack object

(At this point rxe is actually broken, so I have to backport 3 commits
for even rnbd mapping to work).

The 3 backported commits are as follows,

From db4657afd10e45855ac1d8437fcc9a86bd3d741d Mon Sep 17 00:00:00 2001
From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date: Thu, 29 Jul 2021 14:26:22 -0400
Subject: [PATCH 1/3] RDMA/cma: Revert INIT-INIT patch

From e2a05339fa1188b6b37540f4611893ac4c534fa2 Mon Sep 17 00:00:00 2001
From: Bob Pearson <rpearsonhpe@gmail.com>
Date: Thu, 29 Jul 2021 17:00:38 -0500
Subject: [PATCH 2/3] RDMA/rxe: Use the correct size of wqe when processing SRQ

From ef4b96a5773d7f6568363b3d0c3c3f371fb690bd Mon Sep 17 00:00:00 2001
From: Bob Pearson <rpearsonhpe@gmail.com>
Date: Thu, 29 Jul 2021 17:00:39 -0500
Subject: [PATCH 3/3] RDMA/rxe: Restore setting tot_len in the IPv4 header


Any thoughts as to why this error could be happening?

(PS, I tried the other newer branches, 5.15, 5.16 and 5.17, there are
some other issues with them).

Regards
-Haris
