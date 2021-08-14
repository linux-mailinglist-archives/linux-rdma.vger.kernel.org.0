Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D43EC0BB
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Aug 2021 07:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhHNFci (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 Aug 2021 01:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231890AbhHNFch (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 14 Aug 2021 01:32:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C10C60F14;
        Sat, 14 Aug 2021 05:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628919129;
        bh=Ce6FpzVo476VXt839BLLHJmvrG+cLVPcp+yI16NLGkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ircDee17gATFXAY0WKeVPIZWDbxx6WqiNvYfMAZ2NmL6JbQg5SINtH7F73osNiTcZ
         KlNCLe2tfOeofGdDPIoK8DcRmOwQ1sk2ubU07yGVPm9bEDYhYyftgKxVsyo+nM4jDi
         tai8kqk0SggeBXQrTh0PmGlnbAiw+yFMqOwWe4dw8wpcfZ8gFLzcTzQ2doyi7aRePM
         OUl1lbQ5/hIKkfB9wyZHJMGeJMqfZH29xTjR+EeLMpovL3KiykwrIGkyQy/a5d6BtT
         FdSmUdybHwmMCPALJ/qLZiQ4W4u1Fl6bnVPa19uCIZiOlV59BRcEVHZ4XRO7rv6HoO
         r/xCJXgI8Uo7g==
Date:   Sat, 14 Aug 2021 08:32:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: RXE status in the upstream rping using rxe
Message-ID: <YRdVVXPZ7Dquk3mZ@unreal>
References: <YQmF9506lsmeaOBZ@unreal>
 <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
 <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
 <YQoogK7uWCLHUzcs@unreal>
 <CAD=hENcnUd-rTHGPq2DjyF7tDHVzCebDO2gtwZa9pw0M_QvaPA@mail.gmail.com>
 <3243d639-fef0-0f76-6262-ff7c4a1daca2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3243d639-fef0-0f76-6262-ff7c4a1daca2@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 13, 2021 at 04:53:56PM -0500, Bob Pearson wrote:
> On 8/4/21 4:05 AM, Zhu Yanjun wrote:
> > On Wed, Aug 4, 2021 at 1:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> >>
> >> On Wed, Aug 04, 2021 at 09:09:41AM +0800, Zhu Yanjun wrote:
> >>> On Wed, Aug 4, 2021 at 9:01 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >>>>
> >>>> On Wed, Aug 4, 2021 at 2:07 AM Leon Romanovsky <leon@kernel.org> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> Can you please help me to understand the RXE status in the upstream?
> >>>>>
> >>>>> Does we still have crashes/interop issues/e.t.c?
> >>>>
> >>>> I made some developments with the RXE in the upstream, from my usage
> >>>> with latest RXE,
> >>>> I found the following:
> >>>>
> >>>> 1. rdma-core can not work well with latest RDMA git;
> >>>
> >>> The latest RDMA git is
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> >>
> >> "Latest" is a relative term, what SHA did you test?
> >> Let's focus on fixing RXE before we will continue with new features.
> > 
> > Thanks a lot. I agree with you.
> > 
> > rdma-core:
> > 313509f8 (HEAD -> master, origin/master, origin/HEAD) Merge pull
> > request #1038 from selvintxavier/master
> > 2d3dc48b Merge pull request #1039 from amzn/pyverbs-mac-fix-pr
> > 327d45e0 tests: Add missing MAC element to args list
> > 66aba73d bnxt_re/lib: Move hardware queue to 16B aligned indices
> > 8754fb51 bnxt_re/lib: Use separate indices for shadow queue
> > be4d8abf bnxt_re/lib: add a function to initialize software queue
> > 
> > kernel rdma:
> > 0050a57638ca (HEAD -> for-next, origin/for-next, origin/HEAD)
> > RDMA/qedr: Improve error logs for rdma_alloc_tid error return
> > 090473004b02 RDMA/qed: Use accurate error num in qed_cxt_dynamic_ilt_alloc
> > 991c4274dc17 RDMA/hfi1: Fix typo in comments
> > 8d7e415d5561 docs: Fix infiniband uverbs minor number
> > bbafcbc2b1c9 RDMA/iwpm: Rely on the rdma_nl_[un]register() to ensure
> > that requests are valid
> > bdb0e4e3ff19 RDMA/iwpm: Remove not-needed reference counting
> > e677b72a0647 RDMA/iwcm: Release resources if iw_cm module initialization fails
> > a0293eb24936 RDMA/hfi1: Convert from atomic_t to refcount_t on
> > hfi1_devdata->user_refcount
> > 
> > with the above kernel and rdma-core, the following messages will appear.
> > "
> > [   54.214608] rdma_rxe: loaded
> > [   54.217089] infiniband rxe0: set active
> > [   54.217101] infiniband rxe0: added enp0s8
> > [  167.623200] rdma_rxe: cqe(32768) > max_cqe(32767)
> > [  167.645590] rdma_rxe: cqe(1) < current # elements in queue (6)
> > [  167.733297] rdma_rxe: cqe(32768) > max_cqe(32767)
> > [  169.074755] rdma_rxe: check_rkey: no MW matches rkey 0x1000247
> > [  169.074796] rdma_rxe: qp#27 moved to error state
> > [  169.138851] rdma_rxe: check_rkey: no MW matches rkey 0x10005de
> > [  169.138889] rdma_rxe: qp#30 moved to error state
> > [  169.160565] rdma_rxe: check_rkey: no MW matches rkey 0x10006f7
> > [  169.160601] rdma_rxe: qp#31 moved to error state
> > [  169.182132] rdma_rxe: check_rkey: no MW matches rkey 0x1000782
> > [  169.182170] rdma_rxe: qp#32 moved to error state
> > [  169.667803] rdma_rxe: check_rkey: no MR matches rkey 0x18d8
> > [  169.667850] rdma_rxe: qp#39 moved to error state
> > [  198.872649] rdma_rxe: cqe(32768) > max_cqe(32767)
> > [  198.894829] rdma_rxe: cqe(1) < current # elements in queue (6)
> > [  198.981839] rdma_rxe: cqe(32768) > max_cqe(32767)
> > [  200.332031] rdma_rxe: check_rkey: no MW matches rkey 0x1000887
> > [  200.332086] rdma_rxe: qp#58 moved to error state
> > [  200.396476] rdma_rxe: check_rkey: no MW matches rkey 0x1000b0d
> > [  200.396514] rdma_rxe: qp#61 moved to error state
> > [  200.417919] rdma_rxe: check_rkey: no MW matches rkey 0x1000c40
> > [  200.417956] rdma_rxe: qp#62 moved to error state
> > [  200.439616] rdma_rxe: check_rkey: no MW matches rkey 0x1000d24
> > [  200.439654] rdma_rxe: qp#63 moved to error state
> > [  200.933104] rdma_rxe: check_rkey: no MR matches rkey 0x37d8
> > [  200.933153] rdma_rxe: qp#70 moved to error state
> > [  206.880305] rdma_rxe: cqe(32768) > max_cqe(32767)
> > [  206.904030] rdma_rxe: cqe(1) < current # elements in queue (6)
> > [  206.991494] rdma_rxe: cqe(32768) > max_cqe(32767)
> > [  208.359987] rdma_rxe: check_rkey: no MW matches rkey 0x1000e4d
> > [  208.360028] rdma_rxe: qp#89 moved to error state
> > [  208.425637] rdma_rxe: check_rkey: no MW matches rkey 0x1001136
> > [  208.425675] rdma_rxe: qp#92 moved to error state
> > [  208.447333] rdma_rxe: check_rkey: no MW matches rkey 0x10012d8
> > [  208.447370] rdma_rxe: qp#93 moved to error state
> > [  208.469511] rdma_rxe: check_rkey: no MW matches rkey 0x100137a
> > [  208.469550] rdma_rxe: qp#94 moved to error state
> > [  208.956691] rdma_rxe: check_rkey: no MR matches rkey 0x5670
> > [  208.956731] rdma_rxe: qp#100 moved to error state
> > [  216.879703] rdma_rxe: cqe(32768) > max_cqe(32767)
> > [  216.902199] rdma_rxe: cqe(1) < current # elements in queue (6)
> > [  216.989264] rdma_rxe: cqe(32768) > max_cqe(32767)
> > [  218.363765] rdma_rxe: check_rkey: no MW matches rkey 0x10014d6
> > [  218.363808] rdma_rxe: qp#119 moved to error state
> > [  218.429474] rdma_rxe: check_rkey: no MW matches rkey 0x10017e4
> > [  218.429513] rdma_rxe: qp#122 moved to error state
> > [  218.451443] rdma_rxe: check_rkey: no MW matches rkey 0x1001895
> > [  218.451481] rdma_rxe: qp#123 moved to error state
> > [  218.473869] rdma_rxe: check_rkey: no MW matches rkey 0x1001910
> > [  218.473908] rdma_rxe: qp#124 moved to error state
> > [  218.963602] rdma_rxe: check_rkey: no MR matches rkey 0x757b
> > [  218.963641] rdma_rxe: qp#130 moved to error state
> > [  233.855140] rdma_rxe: cqe(32768) > max_cqe(32767)
> > [  233.877202] rdma_rxe: cqe(1) < current # elements in queue (6)
> > [  233.963952] rdma_rxe: cqe(32768) > max_cqe(32767)
> > [  235.305274] rdma_rxe: check_rkey: no MW matches rkey 0x1001ac2
> > [  235.305319] rdma_rxe: qp#149 moved to error state
> > [  235.368800] rdma_rxe: check_rkey: no MW matches rkey 0x1001db8
> > [  235.368838] rdma_rxe: qp#152 moved to error state
> > [  235.390155] rdma_rxe: check_rkey: no MW matches rkey 0x1001e4d
> > [  235.390192] rdma_rxe: qp#153 moved to error state
> > [  235.411336] rdma_rxe: check_rkey: no MW matches rkey 0x1001f4c
> > [  235.411374] rdma_rxe: qp#154 moved to error state
> > [  235.895784] rdma_rxe: check_rkey: no MR matches rkey 0x9482
> > [  235.895828] rdma_rxe: qp#161 moved to error state
> > "
> > Not sure if they are problems.
> > IMO, we should make further investigations.
> > 
> > Thanks
> > Zhu Yanjun
> >>
> >> Thanks
> 
> 
> 
> All of the messages are from the rxe driver caused by the python tests intentionally causing
> 
> errors. Here is a test run with messages. No errors occurred. This is run on current rdma_core and
> for_next. Does not answer the question about rping. That needs more testing.
> (so ru is short for "./build/bin/run_tests.py --dev rxe_1")
> 
> Bob
> 
> rpearson:rdma-core$ sudo dmesg -C
> 
> rpearson:rdma-core$ so ru
> 
> .............sssssssss.............sssssssssssssss.sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss........sssssssssssssssssss....ssss........s...s.s..s..........ssssssssss..ss
> 
> ----------------------------------------------------------------------
> 
> Ran 199 tests in 0.418s
> 
> 
> 
> OK (skipped=134)
> 
> rpearson:rdma-core$ sudo dmesg
> 
> [ 9396.038090] rdma_rxe: cqe(32768) > max_cqe(32767)
> 
> [ 9396.042414] rdma_rxe: cqe(1) < current # elements in queue (6)
> 
> [ 9396.056685] rdma_rxe: cqe(32768) > max_cqe(32767)
> 
> [ 9396.273114] rdma_rxe: check_rkey: no MW matches rkey 0x1000256
> 
> [ 9396.273120] rdma_rxe: qp#27 moved to error state
> 
> [ 9396.283112] rdma_rxe: check_rkey: no MW matches rkey 0x10005be
> 
> [ 9396.283116] rdma_rxe: qp#30 moved to error state
> 
> [ 9396.286497] rdma_rxe: check_rkey: no MW matches rkey 0x100063d
> 
> [ 9396.286501] rdma_rxe: qp#31 moved to error state
> 
> [ 9396.289917] rdma_rxe: check_rkey: no MW matches rkey 0x10007a6
> 
> [ 9396.289922] rdma_rxe: qp#32 moved to error state
> 
> [ 9396.364850] rdma_rxe: check_rkey: no MR matches rkey 0x1868
> 
> [ 9396.364854] rdma_rxe: qp#37 moved to error state

You shouldn't print these errors by default, they need be *_dbg() level,

Thanks

> 
> 
> 
> 
