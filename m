Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C471E38893D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 10:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbhESITp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbhESITp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 04:19:45 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E42C06175F
        for <linux-rdma@vger.kernel.org>; Wed, 19 May 2021 01:18:25 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so517328oty.7
        for <linux-rdma@vger.kernel.org>; Wed, 19 May 2021 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YV0fUfHkHKZ5z2K26ou5yO7MPUv9KumZtKWtdS5qRdc=;
        b=jTwzhOrhSo8mgQ8jPf1RcyS58QDbUAD8r9fSf0feGeL6DqBzomOgRECaPWAYrVKvss
         HSIqRR52kufEy/WgxUVsLNVUBPjVY1SN8L+Di2DMAhI1U+H/BuyKV/Bce1DXRVJBhu5t
         Nh02d9T4Bz/0H7zRre2dN4CEVYqU9KiH/dRj3cTqsshZQJR32fXVb866sPRIc0A/yjVG
         OvOzOUgzqLYOSKh0vLvbSt2q0YZqAr47KWwFqDr0WU68tKlGDMZP/MhNLLf+g6vwtRzP
         nXGCdmOONOfbVTT5B1ZilLAK//TU6agkYID1RNeW2MpuwbKB0axmMn30BltS9ucJmWnu
         1KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YV0fUfHkHKZ5z2K26ou5yO7MPUv9KumZtKWtdS5qRdc=;
        b=eEHmstqaCFtBrFmWmC+vUsNko8pYSIgk/UHFzor6IWTO2fZmrzAfFMLKZq3ygKsIrM
         HoQ4rAFoOD/dJQsho4TmOCmN6jwY+dfYkxxIoJm6JU3+NsL8KmKwTJhpqjRL8ZFJnixX
         8QY4IYL73X8a+XB3IK94kxYJzDGBW+B48HrDhi2ifq+0TsssrbnKtgvepEXcFz9/BsG1
         ou6fA6T2/h52+gWn5AWTcVQwCtNgDOZQqSSv6RlaQb296qknzKShwfFbJoQs/GH7BVw0
         uNAbmQpBimuvdzJJv45jz66lrc2qBFrUcw8bOxjYvvNmpm8dVqErax3uQ81ulPhwp1Lp
         TAYg==
X-Gm-Message-State: AOAM53197Bkq4iy2iQdsouJ8WXhAV4WOUq6P1i6NLhzr4247V79kh0hf
        TrZSk/HHM2hZiYbUy4r3kyyYurClSc4+8KrI1bM=
X-Google-Smtp-Source: ABdhPJx49kmM3AcocXPOeJdxukaZqWCuBi30KtiNFDjtXbf8XpLzoUUpfJaNdlRvLJLyVGA+jzwwkmNzHS4y75o9l7k=
X-Received: by 2002:a9d:260a:: with SMTP id a10mr7916467otb.278.1621412304717;
 Wed, 19 May 2021 01:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210429184855.54939-1-rpearson@hpe.com> <20210429184855.54939-5-rpearson@hpe.com>
 <20210518200901.GA2489365@nvidia.com>
In-Reply-To: <20210518200901.GA2489365@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 19 May 2021 16:18:13 +0800
Message-ID: <CAD=hENdT9abE5gWhLXVSEY4orvQMNPZQS+vceyOsCMMpX1VoSA@mail.gmail.com>
Subject: Re: [PATCH for-next v6 04/10] RDMA/rxe: Add ib_alloc_mw and
 ib_dealloc_mw verbs
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Bob

Based on the latest rdma

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
6efb943b8616 (tag: v5.13-rc1, origin/wip/for-testing, origin/linus,
origin/for-next, origin/HEAD) Linux 5.13-rc1

and rdma-core

https://github.com/linux-rdma/rdma-core.git
53d52f54 (HEAD -> master, origin/master, origin/HEAD) Merge pull
request #1003 from yishaih/mlx5_dv

After applying your patch series:

19d8361223ff (HEAD -> for-next) RDMA/rxe: Disallow MR dereg and
invalidate when bound
31f6a56c0039 RDMA/rxe: Implement memory access through MWs
c6684f842a96 RDMA/rxe: Implement invalidate MW operations
ac107e28e8ce RDMA/rxe: Add support for bind MW work requests
a93e19c5bf98 RDMA/rxe: Move local ops to subroutine
ab284077b5a1 RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
e7f66570e3a1 RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
959efd04eff5 RDMA/rxe: Enable MW object pool
6860a2129427 RDMA/rxe: Return errors for add index and key
4cda80602bfa RDMA/rxe: Add bind MW fields to rxe_send_wr

Then I run "run_tests.py", the following test results. Can you have
time to check it?

======================================================================
ERROR: test_cq_events_rc (tests.test_cq_events.CqEventsTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_cq_events.py", line 54, in test_cq_events_rc
    traffic(client, server, self.iters, self.gid_index, self.ib_port)
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_cq_events_ud (tests.test_cq_events.CqEventsTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_cq_events.py", line 50, in test_cq_events_ud
    traffic(client, server, self.iters, self.gid_index, self.ib_port)
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_rc_traffic_cq_ex (tests.test_cqex.CqExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_cqex.py", line 73, in test_rc_traffic_cq_ex
    u.traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 567, in poll_cq_ex
    raise PyverbsRDMAErrno('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is 4. Errno:
28, No space left on device

======================================================================
ERROR: test_ud_traffic_cq_ex (tests.test_cqex.CqExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_cqex.py", line 68, in test_ud_traffic_cq_ex
    u.traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 567, in poll_cq_ex
    raise PyverbsRDMAErrno('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is 4. Errno:
28, No space left on device

======================================================================
ERROR: test_mr_rereg_access_bad_flow (tests.test_mr.MRTest)
Test that cover rereg MR's access with this flow:
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_mr.py", line 129, in
test_mr_rereg_access_bad_flow
    u.rdma_traffic(**self.traffic_args, send_op=e.IBV_WR_RDMA_WRITE)
  File "/root/rdma-core/tests/utils.py", line 869, in rdma_traffic
    poll_cq(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_mr_rereg_pd (tests.test_mr.MRTest)
Test that cover rereg MR's PD with this flow:
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_mr.py", line 145, in test_mr_rereg_pd
    u.traffic(**self.traffic_args)
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_qp_ex_rc_atomic_cmp_swp (tests.test_qpex.QpExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_qpex.py", line 249, in
test_qp_ex_rc_atomic_cmp_swp
    u.rdma_traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 869, in rdma_traffic
    poll_cq(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Remote
access error. Errno: 10, No child processes

======================================================================
ERROR: test_qp_ex_rc_atomic_fetch_add (tests.test_qpex.QpExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_qpex.py", line 261, in
test_qp_ex_rc_atomic_fetch_add
    u.rdma_traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 869, in rdma_traffic
    poll_cq(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Remote
access error. Errno: 10, No child processes

======================================================================
ERROR: test_qp_ex_rc_rdma_read (tests.test_qpex.QpExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_qpex.py", line 237, in
test_qp_ex_rc_rdma_read
    u.rdma_traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 869, in rdma_traffic
    poll_cq(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Remote
access error. Errno: 10, No child processes

======================================================================
ERROR: test_qp_ex_rc_rdma_write (tests.test_qpex.QpExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_qpex.py", line 218, in
test_qp_ex_rc_rdma_write
    u.rdma_traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 869, in rdma_traffic
    poll_cq(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_qp_ex_rc_rdma_write_imm (tests.test_qpex.QpExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_qpex.py", line 227, in
test_qp_ex_rc_rdma_write_imm
    u.traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_qp_ex_rc_send (tests.test_qpex.QpExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_qpex.py", line 191, in test_qp_ex_rc_send
    u.traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_qp_ex_rc_send_imm (tests.test_qpex.QpExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_qpex.py", line 205, in test_qp_ex_rc_send_imm
    u.traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_qp_ex_ud_send (tests.test_qpex.QpExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_qpex.py", line 186, in test_qp_ex_ud_send
    u.traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_qp_ex_ud_send_imm (tests.test_qpex.QpExTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_qpex.py", line 200, in test_qp_ex_ud_send_imm
    u.traffic(client, server, self.iters, self.gid_index, self.ib_port,
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_ro_rc_traffic (tests.test_relaxed_ordering.RoTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_relaxed_ordering.py", line 52, in
test_ro_rc_traffic
    traffic(client, server, self.iters, self.gid_index, self.ib_port)
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
ERROR: test_ro_ud_traffic (tests.test_relaxed_ordering.RoTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_relaxed_ordering.py", line 56, in
test_ro_ud_traffic
    traffic(client, server, self.iters, self.gid_index, self.ib_port)
  File "/root/rdma-core/tests/utils.py", line 667, in traffic
    poll(client.cq)
  File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Local
protection error. Errno: 4, Interrupted system call

======================================================================
FAIL: test_resize_cq (tests.test_cq.CQTest)
Test resize CQ, start with specific value and then increase and decrease
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_cq.py", line 132, in test_resize_cq
    self.client.cq.resize(new_cq_size)
AssertionError: PyverbsRDMAError not raised

----------------------------------------------------------------------
Ran 183 tests in 2.071s

FAILED (failures=1, errors=17, skipped=125)

On Wed, May 19, 2021 at 4:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Apr 29, 2021 at 01:48:49PM -0500, Bob Pearson wrote:
> > @@ -1106,6 +1108,7 @@ static const struct ib_device_ops rxe_dev_ops = {
> >
> >       INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
> >       INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
> > +     INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
> >       INIT_RDMA_OBJ_SIZE(ib_pd, rxe_pd, ibpd),
> >       INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
> >       INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
>
> ib_mw is already listed below:
>
>         INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
>
> ?
>
> You added it in
>
>  RDMA/rxe: Split MEM into MR and MW
>
> Jason
