Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AC338F9DD
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 07:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhEYFTw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 01:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhEYFTv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 01:19:51 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92A7C061574
        for <linux-rdma@vger.kernel.org>; Mon, 24 May 2021 22:18:21 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so16926787oty.7
        for <linux-rdma@vger.kernel.org>; Mon, 24 May 2021 22:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dwEMX0E+6LYEAYsrLELhBwbf88MYccJjOaUPfMKrCRM=;
        b=N3AHPCsj2qurDxzU1ae8ao4NooG1TYRhx2lIcLPXJ3cZAK92NCp5/j32XZjq4MZPSH
         4AXDlXVVsXUS0krf7vDTcPS2U/k5MT0+11AkWEPCyoLv1OducE53iTyB6XncmC3LKItH
         0ppW91klodguIKq+MGWLW0GdnchMz6tj498TcX+I696gmfBTekQj0vBUqxIzRiHbkY4l
         EeAlqIJej8G9a9Y1FPEw155ajrMQ+7l6fmXq13WeDHEITMQalp432duEODUKMqZcqpkF
         XQV7ilKhWEUb7OALEOY4S+lEFrAbRvuOnIWiL++EwaEl3V54bB+oi9nbleuoKoQfUQoC
         qoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dwEMX0E+6LYEAYsrLELhBwbf88MYccJjOaUPfMKrCRM=;
        b=NQYIyBSDigud1lXoCCuxKztRQnrZOhrG2FA5wLIJcNeca+eEZ46JHJfQugFHKv6nrN
         /XGRaKVcCbCSrih+MbCbiyzuE309N9CwBWEcIfpPDXQYui7eHHu20kTCrQjuLaT/llvG
         pBRuDJWZ9etANEert2Wc//05A/fQrLYZFbEfJJcviKsjl6w9w4HROy9/Bys0k9y7IGVO
         Mmtd49LPCdk16IOQOzP6QQOLZBDaMOAOf+coEDivtFKNCVzLk9B3/UoEh1UIbORcpTJu
         GCqwSbxppVOZVs2UY/NEVjZBH0i5BghuoC8zR1vtv1cac77ZCm309moE5l3pqzXuOFMy
         4cpQ==
X-Gm-Message-State: AOAM5332HXZUfcTyaOaB3pVatLVrKIb/RcmfrEI7qx3cx5mP6AwSP4it
        e9Va+9SZkzaWr1qwYJuQRwkiFl6TuCK0RneRJsU=
X-Google-Smtp-Source: ABdhPJzQlmBA+QfUr51LFXDC/ZNRA2bV/lm9VRau1whFrOGI3OCOtsX1RYANBjAWbMhzrHQtZU8P66CtGW3CGbuyVno=
X-Received: by 2002:a05:6830:1388:: with SMTP id d8mr21298433otq.53.1621919900966;
 Mon, 24 May 2021 22:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
 <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com>
 <dd81d60d-f4fa-feae-90a0-201ee995e07f@gmail.com> <CAD=hENeP=wh2gHAzkyi9KyZrKmDcmQeR3GB46Re-7ufL-CJqXw@mail.gmail.com>
 <CS1PR8401MB1096CDA5C1FF0BD22611015FBC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <CS1PR8401MB1096CDA5C1FF0BD22611015FBC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 25 May 2021 13:18:09 +0800
Message-ID: <CAD=hENdi4XC=ZQDnm4TGx2CHTgkQuFWd2ET7GbXOMz1zsz_JRg@mail.gmail.com>
Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     "Pearson, Robert B" <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 12:57 PM Pearson, Robert B
<robert.pearson2@hpe.com> wrote:
>
> Zhu,
>
> I'm not sure about the script. Starting from where you were I copied <LIN=
UX>/include/uapi/rdma/rdma_user_rxe.h to <RDMA_CORE>/kernel-headers/rdma/rd=
ma_user_rxe.h. After running the script you should be able to just diff the=
se two files to make sure they are the same. If they aren't copy the header=
 file over. After the shift to 5.13
> rc1+ I re-pulled both trees and applied the kernel patches and then built=
 everything. The python test cases look like
>
> .............sssssssss.............ssssssssssssssssssssssssssssssssssssss=
sssssssssssssssssssssssssssssssss.ssssssssssssssssssssssssss....ssss.......=
......s.....s.......ssssssssss..ss
> ----------------------------------------------------------------------
> Ran 182 tests in 0.380s

Thanks. Please submit a new patch for this problem.

>
> OK (skipped=3D124)
>
> There are a lot of skips but no errors. The skips are from features that =
rxe does not support.
>
> Adding the MW rdma_core patch picks up a small number of additional test =
cases involving memory windows.

Thanks a lot. Look forward to these additional test cases involving
memory windows.

Zhu Yanjun

>
> Regards,
>
> Bob
>
> -----Original Message-----
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> Sent: Monday, May 24, 2021 9:09 PM
> To: Pearson, Robert B <rpearsonhpe@gmail.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; RDMA mailing list <linux-rdma@vger.=
kernel.org>
> Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
>
> On Tue, May 25, 2021 at 12:04 AM Pearson, Robert B <rpearsonhpe@gmail.com=
> wrote:
> >
> > On 5/23/2021 10:14 PM, Zhu Yanjun wrote:
> > > On Sat, May 22, 2021 at 4:19 AM Bob Pearson <rpearsonhpe@gmail.com> w=
rote:
> > >> This series of patches implement memory windows for the rdma_rxe
> > >> driver. This is a shorter reimplementation of an earlier patch set.
> > >> They apply to and depend on the current for-next linux rdma tree.
> > >>
> > >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > >> ---
> > >> v7:
> > >>    Fixed a duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c.
> > > With this patch series, there are about 17 errors and 1 failure in rd=
ma-core.
> >
> > Zhu,
> >
> > You have to sync the kernel-header file with the kernel.
>
> From the link https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/tree/Documentation/kbuild/headers_install.rst?h=3Dv5.13-rc3
> you mean "make headers_install"?
>
> In fact, after "make headers_install", these patches still cause errors a=
nd failures in rdma-core.
>
> I will delve into these errors of rdma-core. Too many errors.
>
> Zhu Yanjun
>
> >
> > Bob
> >
> > > "
> > > --------------------------------------------------------------------
> > > --
> > > Ran 183 tests in 2.130s
> > >
> > > FAILED (failures=3D1, errors=3D17, skipped=3D124) "
> > >
> > > After these patches, not sure if rxe can communicate with the
> > > physical NICs correctly because of the above errors and failure.
> > >
> > > Zhu Yanjun
> > >
> > >> v6:
> > >>    Added rxe_ prefix to subroutine names in lines that changed
> > >>    from Zhu's review of v5.
> > >> v5:
> > >>    Fixed a typo in 10th patch.
> > >> v4:
> > >>    Added a 10th patch to check when MRs have bound MWs
> > >>    and disallow dereg and invalidate operations.
> > >> v3:
> > >>    cleaned up void return and lower case enums from
> > >>    Zhu's review.
> > >> v2:
> > >>    cleaned up an issue in rdma_user_rxe.h
> > >>    cleaned up a collision in rxe_resp.c
> > >>
> > >> Bob Pearson (9):
> > >>    RDMA/rxe: Add bind MW fields to rxe_send_wr
> > >>    RDMA/rxe: Return errors for add index and key
> > >>    RDMA/rxe: Enable MW object pool
> > >>    RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
> > >>    RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
> > >>    RDMA/rxe: Move local ops to subroutine
> > >>    RDMA/rxe: Add support for bind MW work requests
> > >>    RDMA/rxe: Implement invalidate MW operations
> > >>    RDMA/rxe: Implement memory access through MWs
> > >>
> > >>   drivers/infiniband/sw/rxe/Makefile     |   1 +
> > >>   drivers/infiniband/sw/rxe/rxe.c        |   1 +
> > >>   drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
> > >>   drivers/infiniband/sw/rxe/rxe_loc.h    |  29 +-
> > >>   drivers/infiniband/sw/rxe/rxe_mr.c     |  79 ++++--
> > >>   drivers/infiniband/sw/rxe/rxe_mw.c     | 356 +++++++++++++++++++++=
++++
> > >>   drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
> > >>   drivers/infiniband/sw/rxe/rxe_opcode.h |   3 +-
> > >>   drivers/infiniband/sw/rxe/rxe_param.h  |  19 +-
> > >>   drivers/infiniband/sw/rxe/rxe_pool.c   |  45 ++--
> > >>   drivers/infiniband/sw/rxe/rxe_pool.h   |   8 +-
> > >>   drivers/infiniband/sw/rxe/rxe_req.c    | 102 ++++---
> > >>   drivers/infiniband/sw/rxe/rxe_resp.c   | 110 +++++---
> > >>   drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
> > >>   drivers/infiniband/sw/rxe/rxe_verbs.h  |  38 ++-
> > >>   include/uapi/rdma/rdma_user_rxe.h      |  34 ++-
> > >>   16 files changed, 691 insertions(+), 151 deletions(-)
> > >>   create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
> > >> --
> > >> 2.27.0
> > >>
