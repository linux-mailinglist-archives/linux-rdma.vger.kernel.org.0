Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DA839B216
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 07:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhFDFk4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 01:40:56 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39433 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDFk4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Jun 2021 01:40:56 -0400
Received: by mail-ot1-f43.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so6987785otu.6
        for <linux-rdma@vger.kernel.org>; Thu, 03 Jun 2021 22:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OMbtXauQ637WB3Ld1z/XYmV9foAbWAKR5R5URhZOkM=;
        b=Rw1baLgH6N86pbZC98haNKYnTcQbgPV3HVY2L04ELv2ccALrLCD086sWV6hxkSDqS4
         q+CuBiK4qLLN5OlLuKWJApf1pCM9fXHA3ZYrejlTNPbBLLQm9Qc23kIY5zzxkR1enJ95
         GjDd+E0CxrxjoxSkJsdUwLK/MP2pWzrbFd7HVxM2ZYkvXs0TcxdqQj37SxyzYSdhIbmh
         73ZQ2jhfjxCw4RxoaE2+9fi9zSHA6nwgriufda+rALO/0YwC7AiZcivpVYm4hUaU48/R
         3ww8RoSVoOSEN9yqdi0Q/rgphdCWCIukcHlsg9Pd1crAckSWWpK5F5U5lapOyH3Wm0f4
         dFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OMbtXauQ637WB3Ld1z/XYmV9foAbWAKR5R5URhZOkM=;
        b=maJ892/hkb13XiEyoiBBmAEmHWAtmdK3b8mW4fxRofFNZrtPB3to4WA5I+91Tm87GF
         q15EnBKbwGmytHEuRriMNaIGs+34pDASXmaCF9jNBNuzbIlFZhY6SigXMyrmwpsiMDJi
         807Aj/59sl1Zv5xDV5/FTioC8ssOZp2kQxwqCUkLl18CZOWk4BQEQPi0YblhoBY+wXO+
         HYKUc5queUKVWxLX0KQyXWZ2k0MRiNGiaAquxPwcnYh9Sq9JpIgvFAj4KAu7fRegyVzJ
         eDbi9TKjjFsDtveEhjNqfUsXzihkFA1Rw7o+5CtVwfH3Rl4WyV9ZOSqI2UB3ZJ/0V8pC
         1KFg==
X-Gm-Message-State: AOAM531kTSgt9MGu0nKbKAn/gjP9acYaSxVU5ExrQrewOKnLwlIsL0wu
        vlUfJzy9oievrA5+rkA4GlSRc/rz+t5NCcViCPw=
X-Google-Smtp-Source: ABdhPJz0euhutHzJjBDaqBHeYfpTln3v/F0JIHjYmGqivTdB+BJUFdmTK9+jqT0qeiEBLOuqwCjFLj38Xw3GOmb2ohw=
X-Received: by 2002:a05:6830:1388:: with SMTP id d8mr2375572otq.53.1622785077486;
 Thu, 03 Jun 2021 22:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210525213751.629017-1-rpearsonhpe@gmail.com> <20210603185804.GA317620@nvidia.com>
In-Reply-To: <20210603185804.GA317620@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 4 Jun 2021 13:37:46 +0800
Message-ID: <CAD=hENeqZrtLbJF2J-HuetJec8MNfAVDHmcwkWmMNAfeX4-vng@mail.gmail.com>
Subject: Re: [PATCH for-next v8 00/10] RDMA/rxe: Implement memory windows
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, zyj2000@gmail.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

"
[ 1041.051398] rdma_rxe: loaded
[ 1041.054536] infiniband rxe0: set active
[ 1041.054540] infiniband rxe0: added enp0s8
[ 1086.287975] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1086.311546] rdma_rxe: cqe(1) < current # elements in queue (6)
[ 1086.399826] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1090.232785] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1090.255985] rdma_rxe: cqe(1) < current # elements in queue (6)
[ 1090.345427] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1094.024322] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1094.047569] rdma_rxe: cqe(1) < current # elements in queue (6)
[ 1094.136103] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1098.989344] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1099.015065] rdma_rxe: cqe(1) < current # elements in queue (6)
[ 1099.112970] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1103.040076] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1103.062831] rdma_rxe: cqe(1) < current # elements in queue (6)
[ 1103.151157] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1116.121772] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1116.144951] rdma_rxe: cqe(1) < current # elements in queue (6)
[ 1116.234607] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1131.655486] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1131.678700] rdma_rxe: cqe(1) < current # elements in queue (6)
[ 1131.766776] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1175.517166] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1175.540258] rdma_rxe: cqe(1) < current # elements in queue (6)
[ 1175.628214] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1190.760122] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1190.783243] rdma_rxe: cqe(1) < current # elements in queue (6)
[ 1190.871167] rdma_rxe: cqe(32768) > max_cqe(32767)
[ 1249.651921] rdma_rxe: rxe-pd pool destroyed with unfree'd elem
[ 1249.651927] rdma_rxe: rxe-qp pool destroyed with unfree'd elem
[ 1249.651929] rdma_rxe: rxe-cq pool destroyed with unfree'd elem
[ 1255.227916] rdma_rxe: unloaded
"

After I added a rxe device on the netdev, then run rdma-core test tools.
Then I remove rxe device, in the end, I unloaded rdma_rxe kernel modules.
I found the above logs.
"
[ 1249.651921] rdma_rxe: rxe-pd pool destroyed with unfree'd elem
[ 1249.651927] rdma_rxe: rxe-qp pool destroyed with unfree'd elem
[ 1249.651929] rdma_rxe: rxe-cq pool destroyed with unfree'd elem
"

It seems that  some resources leak.

I will make further investigations.

Zhu Yanjun

On Fri, Jun 4, 2021 at 2:58 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, May 25, 2021 at 04:37:42PM -0500, Bob Pearson wrote:
> > This series of patches implement memory windows for the rdma_rxe
> > driver. This is a shorter reimplementation of an earlier patch set.
> > They apply to and depend on the current for-next linux rdma tree.
> >
> > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > ---
> > v8:
> >   Dropped wr.mw.flags in the rxe_send_wr struct in rdma_user_rxe.h.
> > v7:
> >   Fixed a duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c.
> > v6:
> >   Added rxe_ prefix to subroutine names in lines that changed
> >   from Zhu's review of v5.
> > v5:
> >   Fixed a typo in 10th patch.
> > v4:
> >   Added a 10th patch to check when MRs have bound MWs
> >   and disallow dereg and invalidate operations.
> > v3:
> >   cleaned up void return and lower case enums from
> >   Zhu's review.
> > v2:
> >   cleaned up an issue in rdma_user_rxe.h
> >   cleaned up a collision in rxe_resp.c
> >
> > Bob Pearson (10):
> >   RDMA/rxe: Add bind MW fields to rxe_send_wr
> >   RDMA/rxe: Return errors for add index and key
> >   RDMA/rxe: Enable MW object pool
> >   RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
> >   RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
> >   RDMA/rxe: Move local ops to subroutine
> >   RDMA/rxe: Add support for bind MW work requests
> >   RDMA/rxe: Implement invalidate MW operations
> >   RDMA/rxe: Implement memory access through MWs
> >   RDMA/rxe: Disallow MR dereg and invalidate when bound
>
> This is all ready now, right?
>
> Can you put the userspace part on the github please?
>
> Jason
