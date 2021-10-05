Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98472422776
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Oct 2021 15:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhJENNS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbhJENNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 09:13:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEBAC061749;
        Tue,  5 Oct 2021 06:11:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i4so86790075lfv.4;
        Tue, 05 Oct 2021 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DD50t/ui3X4BJA4oPKNwBkzyGqWUMXT+Evme1qr8OjQ=;
        b=CFiQjJLEQNEWaSqiukj6Yi1DQK7ITQjDfkZy3V9E7r+HL3RFn3+jWhENFuFdPHZp38
         0vvXYXVsXCkjAITsd3U+rBhI5Bl4MjagjgitHOfRRZxnMF/fD9dapeZkUA5hEGS3Xfpa
         +K+/1usTFWLMWShpZ6CJm2o6WTaPdW8f3xtoENfZ5h13Vvj9w0yuFVbXqRZ0wlwkHywx
         2nTlOXrD5gMUlyidojpYd4E8bT6fVXiPeBp+Q1a1BoESbSiI6oCRaGzv60xpwymIBLXm
         dSkukEg3TbIhac1upWK0sNDgO4rOu4JZR3EMD0+Do8ZSzU9i4aX55EMKeUbK8cLdhelU
         JE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DD50t/ui3X4BJA4oPKNwBkzyGqWUMXT+Evme1qr8OjQ=;
        b=mYhHFpUG4IUcrCRR9UCO4qRWQP2U794qAzEv3OFTXuEW3NYzhIIBFnevLRmkut2tcz
         A/tDJdPz+GGI9AfXyCuC+J5AQdIONd4g/KXLQgUf6o72QmTI10W70m9lqeNPipfL6iAg
         db+wGYoZUMIAyySjLFhi8Ed+fzq76HVL6/i32ep3ESpTbN1Egevg1xZ7sgzA5eNKR63C
         AtkAk+jNCmjYpJeYVwn/+1TKAKi/diZkFeJMsMJrC1yUliRJmPV/tQX9f/W0sUk6Cn7u
         kY4tjsBHKjdw/kpksmJaH3yBc2QG4VFnIEgGrKBNfFkK7mDr0N/l/xjRp6WSKknMTMLe
         iDoQ==
X-Gm-Message-State: AOAM533ayMlOWrUsILFbTn4h9uxJzyyllAiYKlKOLu9vxe65e+u9HJj/
        XqFWESMp5Qy+Sj1qsj8/jZyaj/5onXx9EDRl9Og=
X-Google-Smtp-Source: ABdhPJyAy5Ik2LRfLIdu3c2J8dVoYNL8r4xOvoOfYaEuSRgFDkaWKzdlD1WMzn2Y64lyCIPxnCA/ky1ANqMk9EtaiLY=
X-Received: by 2002:a2e:1645:: with SMTP id 5mr21020950ljw.123.1633439483776;
 Tue, 05 Oct 2021 06:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005a800a05cd849c36@google.com> <CACT4Y+ZRrxmLoor53nkD54sA5PJcRjWqheo262tudjrLO2rXzQ@mail.gmail.com>
 <20211004131516.GV3544071@ziepe.ca> <CACT4Y+bTB3DCGnem7V2ODpwgmiQdGuJae+h93kfniYn1Pr_x2g@mail.gmail.com>
 <4F4604B1-6EF7-4435-BB12-87664EF852C3@oracle.com>
In-Reply-To: <4F4604B1-6EF7-4435-BB12-87664EF852C3@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 5 Oct 2021 21:11:12 +0800
Message-ID: <CAD=hENdbCdjPCEnfz0-to81qGGAN4ONkHdrhQEPc1bC+-peYMQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: RESTRACK detected leak of resources
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        syzbot <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 5, 2021 at 1:56 AM Haakon Bugge <haakon.bugge@oracle.com> wrote=
:
>
>
>
> > On 4 Oct 2021, at 15:22, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, 4 Oct 2021 at 15:15, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>
> >> On Mon, Oct 04, 2021 at 02:42:11PM +0200, Dmitry Vyukov wrote:
> >>> On Mon, 4 Oct 2021 at 12:45, syzbot
> >>> <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> syzbot found the following issue on:
> >>>>
> >>>> HEAD commit:    c7b4d0e56a1d Add linux-next specific files for 20210=
930
> >>>> git tree:       linux-next
> >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D104be6cb=
300000
> >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc9a1f668=
5aeb48bd
> >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3a992c9e4f=
d9f0e6fd0e
> >>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU B=
inutils for Debian) 2.35.2
> >>>>
> >>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>
> >>>> IMPORTANT: if you fix the issue, please add the following tag to the=
 commit:
> >>>> Reported-by: syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com
> >>>
> >>> +RESTRACK maintainers
> >>>
> >>> (it would also be good if RESTRACK would print a more standard oops
> >>> with stack/filenames, so that testing systems can attribute issues to
> >>> files/maintainers).
> >>
> >> restrack certainly should trigger a WARN_ON to stop the kernel.. But I
> >> don't know what stack track would be useful here. The culprit is
> >> always the underlying driver, not the core code..
> >
> > There seems to be a significant overlap between
> > drivers/infiniband/core/restrack.c and drivers/infiniband/sw/rxe/rxe.c
> > maintainers, so perhaps restrack.c is good enough approximation to
> > extract relevant people (definitely better then no CC at all :))
>
> Looks to me as this is rxe:
>
> [ 1892.778632][ T8958] BUG: KASAN: use-after-free in __rxe_drop_index_loc=
ked+0xb5/0x100
> [snip]
> [ 1892.822375][ T8958] Call Trace:
> [ 1892.825655][ T8958]  <TASK>
> [ 1892.828594][ T8958]  dump_stack_lvl+0xcd/0x134
> [ 1892.833273][ T8958]  print_address_description.constprop.0.cold+0x6c/0=
x30c
> [ 1892.840316][ T8958]  ? __rxe_drop_index_locked+0xb5/0x100
> [ 1892.845864][ T8958]  ? __rxe_drop_index_locked+0xb5/0x100
> [ 1892.851424][ T8958]  kasan_report.cold+0x83/0xdf
> [ 1892.856200][ T8958]  ? __rxe_drop_index_locked+0xb5/0x100
> [ 1892.861761][ T8958]  kasan_check_range+0x13d/0x180
> [ 1892.866780][ T8958]  __rxe_drop_index_locked+0xb5/0x100
> [ 1892.872164][ T8958]  __rxe_drop_index+0x3f/0x60
> [ 1892.876850][ T8958]  rxe_dereg_mr+0x14b/0x240
> [ 1892.881381][ T8958]  ib_dealloc_pd_user+0x96/0x230
> [ 1892.886566][ T8958]  rds_ib_dev_free+0xd4/0x3a0
>
> So, RDS de-allocs its PD, ib core must first de-register the PD's local M=
R, calls rxe_dereg_mr(), ...

int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
{
        struct rxe_mr *mr =3D to_rmr(ibmr);

        if (atomic_read(&mr->num_mw) > 0) {
                pr_warn("%s: Attempt to deregister an MR while bound to MWs=
\n",
                        __func__);
                return -EINVAL;
        }

        mr->state =3D RXE_MR_STATE_ZOMBIE;
        rxe_drop_ref(mr_pd(mr));
        rxe_drop_index(mr);            <-------This is call trace beginning=
.
        rxe_drop_ref(mr);

        return 0;
}

struct rxe_mr {
        struct rxe_pool_entry   pelem; <-----A ref_cnt in this struct.
        struct ib_mr            ibmr;

        struct ib_umem          *umem;

struct rxe_pool_entry {
        struct rxe_pool         *pool;
        struct kref             ref_cnt;        <-------This ref_cnt may he=
lp.
        struct list_head        list;

Zhu Yanjun

>
>
> Thxs, H=C3=A5kon
>
>
> >
> >> Anyhow, this report is either rxe or rds by the look of it.
> >>
> >> Jason
>
