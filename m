Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A046038FA0A
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 07:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEYFqs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 01:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhEYFqr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 01:46:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80925C061574
        for <linux-rdma@vger.kernel.org>; Mon, 24 May 2021 22:45:17 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so16972661oty.7
        for <linux-rdma@vger.kernel.org>; Mon, 24 May 2021 22:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o8AqtxsHtiy4pjnPDRS+LrS3CYGfSWy0jHfhU8QenaE=;
        b=I3Ef8xNqQ4OgGwZIjBfbbDnrwEOnMxUwW4bEA7Y+RuqaaGKfgut7XoZxaPgMuW/caH
         HQ+Po9BYxb+WhOp58L0jkUXazRJKAAIDOSWfVq09zDDGmX4R7xVSbO5qk50wvucJdWEr
         nwT97ffoWjY+JABuqMrbNIPe2h8eXjy0ITlm8+0lvQiXb0O57fuHzI34m8UQ6s8/H/Ms
         54cU53npd/IvTSspn1rVCpkPDdlDQ8Mqln0tCFBT/VPZ8/7a1LaSl79K53/BwEtSTxLe
         0GzFtQ7NrmLu+hInsoSA34rGw3WwzB6cvW6wXMMglLf4kendqiHMkGfqp6onoDjLUEuN
         dTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o8AqtxsHtiy4pjnPDRS+LrS3CYGfSWy0jHfhU8QenaE=;
        b=d23XrH5jCmPZNKYAbpzAn1GHWmBpmsiIQYbJ6MKhk7iyhI5CW3qMPhLJMy8TgsBWaL
         Zafc/F5V1HD8GjR3DsKfgWzBFlX/V/uel483x6LZj4MXFmhxgs7nfveYSv1sKHT1ly2h
         ZCOTmc0NElSkbx2QDTtuky9y8YNhkWWa1D430f0aZM4RQP93zfXZhI0Vb4MzMaEo5QYr
         l8WtDKFle6Q+FviHd4uMmDXx3PUPXJkx6efAEc+cgOqwue6N79ZjKSHICnAu2FgR9ZLO
         kZDfjUHSLH8PSOR6wwKGH4Ymx7o1rG0mumvitsdy8zhHQzN+4Gph9pJ+DdQv7MRsK+re
         wn5A==
X-Gm-Message-State: AOAM532LzaEmuGipbdI+yuplb/uXpnFvwkr8s2LejLeoRnvKr2N8VRBk
        yS61TeDPLpWG0IrJAJqwuH0lu2Fe09krzUTBijA=
X-Google-Smtp-Source: ABdhPJxV2SsfLpw02U0PUC4v3x0ab791eRxX0YgUa/Zazwij5RSfDyZpCEz0iuYbjnJnJg3CiunvsA0XQ8U2nP2eL7o=
X-Received: by 2002:a9d:614b:: with SMTP id c11mr22186654otk.59.1621921516936;
 Mon, 24 May 2021 22:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
 <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com>
 <dd81d60d-f4fa-feae-90a0-201ee995e07f@gmail.com> <CAD=hENeP=wh2gHAzkyi9KyZrKmDcmQeR3GB46Re-7ufL-CJqXw@mail.gmail.com>
 <CS1PR8401MB1096CDA5C1FF0BD22611015FBC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <CAD=hENdi4XC=ZQDnm4TGx2CHTgkQuFWd2ET7GbXOMz1zsz_JRg@mail.gmail.com> <CS1PR8401MB10960767E276430FB619CC6ABC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <CS1PR8401MB10960767E276430FB619CC6ABC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 25 May 2021 13:45:05 +0800
Message-ID: <CAD=hENcFtc-U1aAPdVpb6gqzviT1hD7pBD8oU9pWmdqRcYWTyQ@mail.gmail.com>
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

On Tue, May 25, 2021 at 1:27 PM Pearson, Robert B
<robert.pearson2@hpe.com> wrote:
>
> There's nothing to change. There is no problem. Just get the headers sync=
'ed.

I delved into the errors. I found that the following would fix these
errors in rdma-core.

diff --git a/kernel-headers/rdma/rdma_user_rxe.h
b/kernel-headers/rdma/rdma_user_rxe.h
index 068433e2..90ea477f 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -99,7 +99,17 @@ struct rxe_send_wr {
                        __u32   remote_qkey;
                        __u16   pkey_index;
                } ud;
+               struct {
+                       __aligned_u64   addr;
+                       __aligned_u64   length;
+                       __u32           mr_lkey;
+                       __u32           mw_rkey;
+                       __u32           rkey;
+                       __u32           access;
+                       __u32           flags;
+               } mw;
                /* reg is only used by the kernel and is not part of the ua=
pi */
+#ifdef __KERNEL__
                struct {
                        union {
                                struct ib_mr *mr;
@@ -108,6 +118,7 @@ struct rxe_send_wr {
                        __u32        key;
                        __u32        access;
                } reg;
+#endif
        } wr;
 };

Zhu Yanjun

> If that doesn't fix your issues your tree has gotten corrupted somehow. B=
ut, I don't think that is the issue. I saw the same type of errors you repo=
rted when rdma_core is built with the old header file. That definitely will=
 cause problems. The size of the send queue WQEs changed because new fields=
 were added. Then user space and the kernel immediately get off from each o=
ther.
>
> Good luck,
>
> Bob
>
> -----Original Message-----
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> Sent: Tuesday, May 25, 2021 12:18 AM
> To: Pearson, Robert B <robert.pearson2@hpe.com>
> Cc: Pearson, Robert B <rpearsonhpe@gmail.com>; Jason Gunthorpe <jgg@nvidi=
a.com>; RDMA mailing list <linux-rdma@vger.kernel.org>
> Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
>
> On Tue, May 25, 2021 at 12:57 PM Pearson, Robert B <robert.pearson2@hpe.c=
om> wrote:
> >
> > Zhu,
> >
> > I'm not sure about the script. Starting from where you were I copied
> > <LINUX>/include/uapi/rdma/rdma_user_rxe.h to
> > <RDMA_CORE>/kernel-headers/rdma/rdma_user_rxe.h. After running the
> > script you should be able to just diff these two files to make sure
> > they are the same. If they aren't copy the header file over. After the
> > shift to 5.13
> > rc1+ I re-pulled both trees and applied the kernel patches and then
> > rc1+ built everything. The python test cases look like
> >
> > .............sssssssss.............sssssssssssssssssssssssssssssssssss
> > ssssssssssssssssssssssssssssssssssss.ssssssssssssssssssssssssss....sss
> > s.............s.....s.......ssssssssss..ss
> > ----------------------------------------------------------------------
> > Ran 182 tests in 0.380s
>
> Thanks. Please submit a new patch for this problem.
>
> >
> > OK (skipped=3D124)
> >
> > There are a lot of skips but no errors. The skips are from features tha=
t rxe does not support.
> >
> > Adding the MW rdma_core patch picks up a small number of additional tes=
t cases involving memory windows.
>
> Thanks a lot. Look forward to these additional test cases involving memor=
y windows.
>
> Zhu Yanjun
>
> >
> > Regards,
> >
> > Bob
> >
> > -----Original Message-----
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> > Sent: Monday, May 24, 2021 9:09 PM
> > To: Pearson, Robert B <rpearsonhpe@gmail.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>; RDMA mailing list
> > <linux-rdma@vger.kernel.org>
> > Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory
> > windows
> >
> > On Tue, May 25, 2021 at 12:04 AM Pearson, Robert B <rpearsonhpe@gmail.c=
om> wrote:
> > >
> > > On 5/23/2021 10:14 PM, Zhu Yanjun wrote:
> > > > On Sat, May 22, 2021 at 4:19 AM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
> > > >> This series of patches implement memory windows for the rdma_rxe
> > > >> driver. This is a shorter reimplementation of an earlier patch set=
.
> > > >> They apply to and depend on the current for-next linux rdma tree.
> > > >>
> > > >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > > >> ---
> > > >> v7:
> > > >>    Fixed a duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c=
.
> > > > With this patch series, there are about 17 errors and 1 failure in =
rdma-core.
> > >
> > > Zhu,
> > >
> > > You have to sync the kernel-header file with the kernel.
> >
> > From the link
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre
> > e/Documentation/kbuild/headers_install.rst?h=3Dv5.13-rc3
> > you mean "make headers_install"?
> >
> > In fact, after "make headers_install", these patches still cause errors=
 and failures in rdma-core.
> >
> > I will delve into these errors of rdma-core. Too many errors.
> >
> > Zhu Yanjun
> >
> > >
> > > Bob
> > >
> > > > "
> > > > ------------------------------------------------------------------
> > > > --
> > > > --
> > > > Ran 183 tests in 2.130s
> > > >
> > > > FAILED (failures=3D1, errors=3D17, skipped=3D124) "
> > > >
> > > > After these patches, not sure if rxe can communicate with the
> > > > physical NICs correctly because of the above errors and failure.
> > > >
> > > > Zhu Yanjun
> > > >
> > > >> v6:
> > > >>    Added rxe_ prefix to subroutine names in lines that changed
> > > >>    from Zhu's review of v5.
> > > >> v5:
> > > >>    Fixed a typo in 10th patch.
> > > >> v4:
> > > >>    Added a 10th patch to check when MRs have bound MWs
> > > >>    and disallow dereg and invalidate operations.
> > > >> v3:
> > > >>    cleaned up void return and lower case enums from
> > > >>    Zhu's review.
> > > >> v2:
> > > >>    cleaned up an issue in rdma_user_rxe.h
> > > >>    cleaned up a collision in rxe_resp.c
> > > >>
> > > >> Bob Pearson (9):
> > > >>    RDMA/rxe: Add bind MW fields to rxe_send_wr
> > > >>    RDMA/rxe: Return errors for add index and key
> > > >>    RDMA/rxe: Enable MW object pool
> > > >>    RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
> > > >>    RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
> > > >>    RDMA/rxe: Move local ops to subroutine
> > > >>    RDMA/rxe: Add support for bind MW work requests
> > > >>    RDMA/rxe: Implement invalidate MW operations
> > > >>    RDMA/rxe: Implement memory access through MWs
> > > >>
> > > >>   drivers/infiniband/sw/rxe/Makefile     |   1 +
> > > >>   drivers/infiniband/sw/rxe/rxe.c        |   1 +
> > > >>   drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
> > > >>   drivers/infiniband/sw/rxe/rxe_loc.h    |  29 +-
> > > >>   drivers/infiniband/sw/rxe/rxe_mr.c     |  79 ++++--
> > > >>   drivers/infiniband/sw/rxe/rxe_mw.c     | 356 +++++++++++++++++++=
++++++
> > > >>   drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
> > > >>   drivers/infiniband/sw/rxe/rxe_opcode.h |   3 +-
> > > >>   drivers/infiniband/sw/rxe/rxe_param.h  |  19 +-
> > > >>   drivers/infiniband/sw/rxe/rxe_pool.c   |  45 ++--
> > > >>   drivers/infiniband/sw/rxe/rxe_pool.h   |   8 +-
> > > >>   drivers/infiniband/sw/rxe/rxe_req.c    | 102 ++++---
> > > >>   drivers/infiniband/sw/rxe/rxe_resp.c   | 110 +++++---
> > > >>   drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
> > > >>   drivers/infiniband/sw/rxe/rxe_verbs.h  |  38 ++-
> > > >>   include/uapi/rdma/rdma_user_rxe.h      |  34 ++-
> > > >>   16 files changed, 691 insertions(+), 151 deletions(-)
> > > >>   create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
> > > >> --
> > > >> 2.27.0
> > > >>
