Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11C13EFDB4
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 09:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhHRHV4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 03:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbhHRHVp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 03:21:45 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C075C061764
        for <linux-rdma@vger.kernel.org>; Wed, 18 Aug 2021 00:21:11 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u25so3285053oiv.5
        for <linux-rdma@vger.kernel.org>; Wed, 18 Aug 2021 00:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ToIQIVW28dcgoxDMhrjV8ExdOpZX9I17S+AC3Hb7rCs=;
        b=Y4DyKQfGf+7z4iBbngybUmJDz2h7Pd+cqRfMAzUnN/FnTwHXZK0PG7u1paR9oE6++d
         joQ8CcylbVM+8SXo7FwRckc9n3bdPJLad9Qdv56MUcw7KZ2DRJLIlZ2k+HR8HGFw9VjN
         An1pBHZ3BMNF92Zsh/DuzXwk4Au9O7p4TkUfLVwpj3+W0qjQh+oahCF4+TN8Li2RlIpq
         GKv4P6m7Bs41k13G/KEkLLib+9BidGh9LuznvvJmR8bSjQKb8q4QFOxDtYtaVLlOE9zR
         UADY89NzsQE4wluLebsoRx/GEaHkwKGtNqMpVQ2ARZAovb9D6QFnoF72moIBexG1WiNj
         9CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ToIQIVW28dcgoxDMhrjV8ExdOpZX9I17S+AC3Hb7rCs=;
        b=L/gltRexTqvoLASbzH50i2+zeolP8U5OlRFDjOADCQwNlTCrf3gVjI8n7d3DoXGNWI
         KZ7FjqOZ54rHLCe4itLXyYXLIJcq3zfQlWP/eJdlbH5OcB6E2Y6bVvJDDBVa9LGlzG9y
         EHys2wEmMHyktVt8Tirf2+v2G71TWH8UdFFUQvKgdLXG8YnXhw7EPM69TOvJmLJe6mMd
         MLrLtLaRXlZfD4YAnW3Xx1w6GNXO+6K9VZki94GhEiV90XhPVwIehA+p/0sla0fy77pR
         IS0vcv/DnTqd4DPmKYJZ+W1NAFmg2z/+rYF8cvnbv1/VQCk79jh9+86D7n8jKVm5bhZn
         hZFQ==
X-Gm-Message-State: AOAM530oHt3W1S+2RtC+iuaQ3qTbei0UHPCSDWSBxlIfV1rob/zM+VR4
        FJ2fi93lNhGq/CAKTzHdBaYgBRB4RrEyEzpYfEI=
X-Google-Smtp-Source: ABdhPJzY6HY+YSMbhQcln4pEHnGq0ElJ6/O6qiLtquIlqpoFYkz+bQt9YTCg56T7s/ebFI7cLqG1I/d6Xwu427L9h9g=
X-Received: by 2002:aca:2216:: with SMTP id b22mr5710143oic.163.1629271270615;
 Wed, 18 Aug 2021 00:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <YQmF9506lsmeaOBZ@unreal> <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
 <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
 <YQoogK7uWCLHUzcs@unreal> <CAD=hENcnUd-rTHGPq2DjyF7tDHVzCebDO2gtwZa9pw0M_QvaPA@mail.gmail.com>
 <CAN-5tyG4kBYBEaCDPGr=gUTNGkcoznMUy8e4BwCzWZkSPG-=+Q@mail.gmail.com>
 <CAD=hENdqho3mRy=gUSE-vuXzLvZPkwJ7kEFrjRN-AxLwvQP18Q@mail.gmail.com> <611CABE6.3010700@fujitsu.com>
In-Reply-To: <611CABE6.3010700@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 18 Aug 2021 15:20:59 +0800
Message-ID: <CAD=hENezpPKyGFVB121fjhhniE02fwspULi5vaScU1dWcbY7gA@mail.gmail.com>
Subject: Re: RXE status in the upstream rping using rxe
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 2:43 PM yangx.jy@fujitsu.com
<yangx.jy@fujitsu.com> wrote:
>
> =E4=BA=8E 2021/8/17 10:28, Zhu Yanjun =E5=86=99=E9=81=93:
> > On Fri, Aug 6, 2021 at 10:37 AM Olga Kornievskaia<aglo@umich.edu>  wrot=
e:
> >> On Wed, Aug 4, 2021 at 5:05 AM Zhu Yanjun<zyjzyj2000@gmail.com>  wrote=
:
> >>> On Wed, Aug 4, 2021 at 1:41 PM Leon Romanovsky<leon@kernel.org>  wrot=
e:
> >>>> On Wed, Aug 04, 2021 at 09:09:41AM +0800, Zhu Yanjun wrote:
> >>>>> On Wed, Aug 4, 2021 at 9:01 AM Zhu Yanjun<zyjzyj2000@gmail.com>  wr=
ote:
> >>>>>> On Wed, Aug 4, 2021 at 2:07 AM Leon Romanovsky<leon@kernel.org>  w=
rote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> Can you please help me to understand the RXE status in the upstre=
am?
> >>>>>>>
> >>>>>>> Does we still have crashes/interop issues/e.t.c?
> >>>>>> I made some developments with the RXE in the upstream, from my usa=
ge
> >>>>>> with latest RXE,
> >>>>>> I found the following:
> >>>>>>
> >>>>>> 1. rdma-core can not work well with latest RDMA git;
> >>>>> The latest RDMA git is
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> >>>> "Latest" is a relative term, what SHA did you test?
> >>>> Let's focus on fixing RXE before we will continue with new features.
> >>> Thanks a lot. I agree with you.
> >> I believe simple rping still doesn't work linux-to-linux. The last
> >> working version (of rping in rxe) was 5.13 I think. I have posted a
> >> number of crashes rping encounters (gotta get that working before I
> >> can even try NFSoRDMA).
> > The following are my tests.
> >
> > 1. Modprobe rdma_rxe
> > 2. Modprobe -v -r rdma_rxe
> > 3. Rdma link add rxe
> > 4. Rdma link del rxe
> > 5. Latest rdma-core&&  latest kernel upstream;
> > 6. Latest kernel<  ------rping---->  5.10.y stable
> > 7. Latest kernel<  ------rping---->  5.11.y stable
> > 8. Latest kernel<  ------rping---->  5.12.y stable
> > 9. Latest kernel<  ------rping---->  5.13.y stable
> >
> > It seems that the latest kernel upstream (5.14-rc6) can rping other
> > stable kernels.
> > Can you make tests again?
> >
> > Zhu Yanjun
> Hi,
>
> I still get two simliar panic by rping or rdma_client/server on latest ke=
rnel vs 5.13:
> Panic1:
> --------------------------------------------------------
> [  268.248642] BUG: unable to handle page fault for address: ffff9ae2c07a=
1414
> [  268.251049] #PF: supervisor read access in kernel mode
> [  268.252491] #PF: error_code(0x0000) - not-present page
> [  268.253919] PGD 1000067 P4D 1000067 PUD 0
> [  268.255052] Oops: 0000 [#1] SMP PTI
> [  268.256055] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.14.0-rc6+ #1
> [  268.257893] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.12.0-2.fc30 04/01/2014
> [  268.259995] RIP: 0010:copy_data+0x2d/0x2a0 [rdma_rxe]
> [  268.261114] Code: 00 00 41 57 41 56 41 55 41 54 55 53 48 83 ec 20 48 8=
9 7c 24 08 89 74 24 10 44 89 4c 24 14 45 85 c0 0f 84 e8 00 00 00 45 89 c7<4=
4>  8b 42 04 49 89 d6 44 89 44 24 18 45 39 f8 0f 8c 20 02 00 00 8b
> [  268.265005] RSP: 0018:ffff9ae2404108b8 EFLAGS: 00010202
> [  268.266145] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8f7a8=
bf9da76
> [  268.267703] RDX: ffff9ae2c07a1410 RSI: 0000000000000001 RDI: ffff8f7a7=
1874400
> [  268.269291] RBP: ffff8f7a482f87cc R08: 0000000000000010 R09: 000000000=
0000000
> [  268.270871] R10: 00000000000000cb R11: 0000000000000001 R12: ffff8f7a4=
82f8000
> [  268.272468] R13: ffff8f7a8c038928 R14: ffff8f7a482f8008 R15: 000000000=
0000010
> [  268.274080] FS:  0000000000000000(0000) GS:ffff8f7abec00000(0000) knlG=
S:0000000000000000
> [  268.275899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  268.277205] CR2: ffff9ae2c07a1414 CR3: 000000000263c002 CR4: 000000000=
0060ee0
> [  268.278825] Call Trace:
> [  268.279358]<IRQ>
> [  268.279747]  rxe_responder+0x11b1/0x2490 [rdma_rxe]
> [  268.280798]  rxe_do_task+0x9c/0xe0 [rdma_rxe]
> [  268.281895]  rxe_rcv+0x286/0x8e0 [rdma_rxe]
> ...
> ------------------------------------------------------
>
> Panic2:
> --------------------------------------------------------
> [  212.526854] BUG: unable to handle page fault for address: ffffbb97142a=
cc14
> [  212.530688] #PF: supervisor read access in kernel mode
> [  212.533030] #PF: error_code(0x0000) - not-present page
> [  212.535428] PGD 1000067 P4D 1000067 PUD 0
> [  212.536970] Oops: 0000 [#1] SMP PTI
> [  212.537748] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.14.0-rc6+ #1
> [  212.538984] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.12.0-2.fc30 04/01/2014
> [  212.540853] RIP: 0010:copy_data+0x2d/0x2a0 [rdma_rxe]
> [  212.541957] Code: 00 00 41 57 41 56 41 55 41 54 55 53 48 83 ec 20 48 8=
9 7c 24 08 89 74 24 10 44 89 4c 24 14 45 85 c0 0f 84 e8 00 00 00 45 89 c7<4=
4>  8b 42 04 49 89 d6 44 89 44 24 18 45 39 f8 0f 8c 20 02 00 00 8b
> [  212.546041] RSP: 0018:ffffbb9640410898 EFLAGS: 00010202
> [  212.547200] RAX: ffffbb97142acc00 RBX: ffff95510ee6d000 RCX: ffff95510=
a802076
> [  212.548782] RDX: ffffbb97142acc10 RSI: 0000000000000001 RDI: ffff95510=
ca00700
> [  212.550369] RBP: 0000000000000010 R08: 0000000000000010 R09: 000000000=
0000000
> [  212.551992] R10: 0000000000000001 R11: 0000000000000001 R12: ffff95510=
a802076
> [  212.553613] R13: ffff9550f29acd28 R14: ffff95510ee6d008 R15: 000000000=
0000010
> [  212.555225] FS:  0000000000000000(0000) GS:ffff95513ec00000(0000) knlG=
S:0000000000000000
> [  212.556749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  212.557846] CR2: ffffbb97142acc14 CR3: 0000000003b66005 CR4: 000000000=
0060ee0
> [  212.559177] Call Trace:
> [  212.559655]<IRQ>
> [  212.560055]  send_data_in+0x55/0x73 [rdma_rxe]
> [  212.560903]  rxe_responder.cold+0xea/0x1f8 [rdma_rxe]
> [  212.561865]  rxe_do_task+0x9c/0xe0 [rdma_rxe]
> [  212.562699]  rxe_rcv+0x286/0x8e0 [rdma_rxe]
> ...
> ------------------------------------------------------
>
> Note: it is easy to reproduce the panic on the lastest kernel.

Can you let me know how to reproduce the panic?

1. linux upstream < ----rping---- > linux upstream?
2. just run rping?
3. how do you create rxe? with rdma link or rxe_cfg?
4. do you make other operations?
5. other operations?

Thanks.
Zhu Yanjun

>
> Best Regards,
> Xiao Yang
>
>
>
> >> Thank you for working on the code.
> >>
> >> We (NFS community) do test NFSoRDMA every git pull using rxe and siw
> >> but lately have been encountering problems.
> >>
> >>> rdma-core:
> >>> 313509f8 (HEAD ->  master, origin/master, origin/HEAD) Merge pull
> >>> request #1038 from selvintxavier/master
> >>> 2d3dc48b Merge pull request #1039 from amzn/pyverbs-mac-fix-pr
> >>> 327d45e0 tests: Add missing MAC element to args list
> >>> 66aba73d bnxt_re/lib: Move hardware queue to 16B aligned indices
> >>> 8754fb51 bnxt_re/lib: Use separate indices for shadow queue
> >>> be4d8abf bnxt_re/lib: add a function to initialize software queue
> >>>
> >>> kernel rdma:
> >>> 0050a57638ca (HEAD ->  for-next, origin/for-next, origin/HEAD)
> >>> RDMA/qedr: Improve error logs for rdma_alloc_tid error return
> >>> 090473004b02 RDMA/qed: Use accurate error num in qed_cxt_dynamic_ilt_=
alloc
> >>> 991c4274dc17 RDMA/hfi1: Fix typo in comments
> >>> 8d7e415d5561 docs: Fix infiniband uverbs minor number
> >>> bbafcbc2b1c9 RDMA/iwpm: Rely on the rdma_nl_[un]register() to ensure
> >>> that requests are valid
> >>> bdb0e4e3ff19 RDMA/iwpm: Remove not-needed reference counting
> >>> e677b72a0647 RDMA/iwcm: Release resources if iw_cm module initializat=
ion fails
> >>> a0293eb24936 RDMA/hfi1: Convert from atomic_t to refcount_t on
> >>> hfi1_devdata->user_refcount
> >>>
> >>> with the above kernel and rdma-core, the following messages will appe=
ar.
> >>> "
> >>> [   54.214608] rdma_rxe: loaded
> >>> [   54.217089] infiniband rxe0: set active
> >>> [   54.217101] infiniband rxe0: added enp0s8
> >>> [  167.623200] rdma_rxe: cqe(32768)>  max_cqe(32767)
> >>> [  167.645590] rdma_rxe: cqe(1)<  current # elements in queue (6)
> >>> [  167.733297] rdma_rxe: cqe(32768)>  max_cqe(32767)
> >>> [  169.074755] rdma_rxe: check_rkey: no MW matches rkey 0x1000247
> >>> [  169.074796] rdma_rxe: qp#27 moved to error state
> >>> [  169.138851] rdma_rxe: check_rkey: no MW matches rkey 0x10005de
> >>> [  169.138889] rdma_rxe: qp#30 moved to error state
> >>> [  169.160565] rdma_rxe: check_rkey: no MW matches rkey 0x10006f7
> >>> [  169.160601] rdma_rxe: qp#31 moved to error state
> >>> [  169.182132] rdma_rxe: check_rkey: no MW matches rkey 0x1000782
> >>> [  169.182170] rdma_rxe: qp#32 moved to error state
> >>> [  169.667803] rdma_rxe: check_rkey: no MR matches rkey 0x18d8
> >>> [  169.667850] rdma_rxe: qp#39 moved to error state
> >>> [  198.872649] rdma_rxe: cqe(32768)>  max_cqe(32767)
> >>> [  198.894829] rdma_rxe: cqe(1)<  current # elements in queue (6)
> >>> [  198.981839] rdma_rxe: cqe(32768)>  max_cqe(32767)
> >>> [  200.332031] rdma_rxe: check_rkey: no MW matches rkey 0x1000887
> >>> [  200.332086] rdma_rxe: qp#58 moved to error state
> >>> [  200.396476] rdma_rxe: check_rkey: no MW matches rkey 0x1000b0d
> >>> [  200.396514] rdma_rxe: qp#61 moved to error state
> >>> [  200.417919] rdma_rxe: check_rkey: no MW matches rkey 0x1000c40
> >>> [  200.417956] rdma_rxe: qp#62 moved to error state
> >>> [  200.439616] rdma_rxe: check_rkey: no MW matches rkey 0x1000d24
> >>> [  200.439654] rdma_rxe: qp#63 moved to error state
> >>> [  200.933104] rdma_rxe: check_rkey: no MR matches rkey 0x37d8
> >>> [  200.933153] rdma_rxe: qp#70 moved to error state
> >>> [  206.880305] rdma_rxe: cqe(32768)>  max_cqe(32767)
> >>> [  206.904030] rdma_rxe: cqe(1)<  current # elements in queue (6)
> >>> [  206.991494] rdma_rxe: cqe(32768)>  max_cqe(32767)
> >>> [  208.359987] rdma_rxe: check_rkey: no MW matches rkey 0x1000e4d
> >>> [  208.360028] rdma_rxe: qp#89 moved to error state
> >>> [  208.425637] rdma_rxe: check_rkey: no MW matches rkey 0x1001136
> >>> [  208.425675] rdma_rxe: qp#92 moved to error state
> >>> [  208.447333] rdma_rxe: check_rkey: no MW matches rkey 0x10012d8
> >>> [  208.447370] rdma_rxe: qp#93 moved to error state
> >>> [  208.469511] rdma_rxe: check_rkey: no MW matches rkey 0x100137a
> >>> [  208.469550] rdma_rxe: qp#94 moved to error state
> >>> [  208.956691] rdma_rxe: check_rkey: no MR matches rkey 0x5670
> >>> [  208.956731] rdma_rxe: qp#100 moved to error state
> >>> [  216.879703] rdma_rxe: cqe(32768)>  max_cqe(32767)
> >>> [  216.902199] rdma_rxe: cqe(1)<  current # elements in queue (6)
> >>> [  216.989264] rdma_rxe: cqe(32768)>  max_cqe(32767)
> >>> [  218.363765] rdma_rxe: check_rkey: no MW matches rkey 0x10014d6
> >>> [  218.363808] rdma_rxe: qp#119 moved to error state
> >>> [  218.429474] rdma_rxe: check_rkey: no MW matches rkey 0x10017e4
> >>> [  218.429513] rdma_rxe: qp#122 moved to error state
> >>> [  218.451443] rdma_rxe: check_rkey: no MW matches rkey 0x1001895
> >>> [  218.451481] rdma_rxe: qp#123 moved to error state
> >>> [  218.473869] rdma_rxe: check_rkey: no MW matches rkey 0x1001910
> >>> [  218.473908] rdma_rxe: qp#124 moved to error state
> >>> [  218.963602] rdma_rxe: check_rkey: no MR matches rkey 0x757b
> >>> [  218.963641] rdma_rxe: qp#130 moved to error state
> >>> [  233.855140] rdma_rxe: cqe(32768)>  max_cqe(32767)
> >>> [  233.877202] rdma_rxe: cqe(1)<  current # elements in queue (6)
> >>> [  233.963952] rdma_rxe: cqe(32768)>  max_cqe(32767)
> >>> [  235.305274] rdma_rxe: check_rkey: no MW matches rkey 0x1001ac2
> >>> [  235.305319] rdma_rxe: qp#149 moved to error state
> >>> [  235.368800] rdma_rxe: check_rkey: no MW matches rkey 0x1001db8
> >>> [  235.368838] rdma_rxe: qp#152 moved to error state
> >>> [  235.390155] rdma_rxe: check_rkey: no MW matches rkey 0x1001e4d
> >>> [  235.390192] rdma_rxe: qp#153 moved to error state
> >>> [  235.411336] rdma_rxe: check_rkey: no MW matches rkey 0x1001f4c
> >>> [  235.411374] rdma_rxe: qp#154 moved to error state
> >>> [  235.895784] rdma_rxe: check_rkey: no MR matches rkey 0x9482
> >>> [  235.895828] rdma_rxe: qp#161 moved to error state
> >>> "
> >>> Not sure if they are problems.
> >>> IMO, we should make further investigations.
> >>>
> >>> Thanks
> >>> Zhu Yanjun
> >>>> Thanks
> >
