Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EEB5094F5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 04:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiDUCQ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 22:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUCQ2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 22:16:28 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CDFB21
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 19:13:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r18so4098113ljp.0
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 19:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzAxVA3Dd0I4+OisN9Y7mpHi1LLunj5Mtvbv/sqe5tg=;
        b=GxnIn6bslGoMghuwNpk9ZYsWmkXlEYPzfZt8TAgJvWxdnIaBhcOi9THOFsFadBwVZD
         dhX9ZbEjPlbgnIr/KzReH41kbtOe8G+Et3qnasrwQyB1fVjgxi3zj7w15DDzXvqXZLio
         DiMqBdVwllixXj6hJrrQN1kTLciR9crd+VrJo7KWYpTaNU9DWvQM0BHd1GGm64QQbWSa
         1A/eX8Atf5oCKio7nQqV1TdvJE3ioaCb51aCWsXbgPdnDwabR09OI9qiRYT41gzOUPbU
         p+oWSKIdBtq+CRsmGv/Rx2mlkmxCCt355g7xYJQfiWBNqyKcU+Tm+7/LOJj3LyMsLg3z
         AeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzAxVA3Dd0I4+OisN9Y7mpHi1LLunj5Mtvbv/sqe5tg=;
        b=hPazIBGgyFul+9NavZ1H+NkvnO4z/PhpIvzw9tvnZM46HVMW+bn8pNZ01DyXehVm1o
         esRXxWSm1lWplO1qBIwgHL6NTn+PFi0HLfNiDPThIw45W21EdnRL4dW2TUVln5+zhjoG
         iSWPjAhOnHPWbF2iVZWIo6VeB4Jz4Tb2xVUj78vEwV8tNjoS+CqpblMfQDleJq/lMpU7
         RIjtSDPym6ryA/w2hckR1feVGiEBL2DuVsisqqTqfgDvDzPHKql0mIv73pXsmMCmYXyk
         3NUfKtGlhGKJ5DtbPiE7rD0x7X26u3ylaD0k1I+lEibDvsYmT2SH43wncuAcgZ3RWj50
         wF7w==
X-Gm-Message-State: AOAM533dgFMolV7qRFcja8fD58QUqapjGN5sZURXg/PqXw5tJuTevJMt
        EDctblRouLXQToGLT3jIWWXdB7t0hVsU2KL0E0E=
X-Google-Smtp-Source: ABdhPJw+I/fHjZluUHKQyVmoy95PBlY3RQ9BTBDBiEgJbe6Ptlf0qAEpAng0B0Fj6cvw8kzQVaFyyduU3x/ujhMCEfg=
X-Received: by 2002:a2e:7005:0:b0:24c:fb20:f172 with SMTP id
 l5-20020a2e7005000000b0024cfb20f172mr15130242ljc.318.1650507218227; Wed, 20
 Apr 2022 19:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220404215059.39819-1-rpearsonhpe@gmail.com> <20220408180659.GA3646477@nvidia.com>
 <fe069eac-889a-460f-ffb6-fc4e46ff3267@gmail.com>
In-Reply-To: <fe069eac-889a-460f-ffb6-fc4e46ff3267@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 21 Apr 2022 10:13:26 +0800
Message-ID: <CAD=hENfKUe5Q8yg4P7ms+FxyU1+cAPMJWPXL_Ps=u+JMznmT7w@mail.gmail.com>
Subject: Re: [PATCH for-next v13 00/10] Fix race conditions in rxe_pool
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 21, 2022 at 7:04 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 4/8/22 13:06, Jason Gunthorpe wrote:
> > On Mon, Apr 04, 2022 at 04:50:50PM -0500, Bob Pearson wrote:
> >> There are several race conditions discovered in the current rdma_rxe
> >> driver.  They mostly relate to races between normal operations and
> >> destroying objects.  This patch series
> >>  - Makes several minor cleanups in rxe_pool.[ch]
> >>  - Adds wait for completions to the paths in verbs APIs which destroy
> >>    objects.
> >>  - Changes read side locking to rcu.
> >>  - Moves object cleanup code to after ref count is zero
> >
> > This all seems fine to me now, except for the question about the
> > tasklets
> >
> > Thanks,
> > Jason
>
> There has been a long delay because of the mr = NULL bug and the locking
> problems. With the following patches applied (last to first) I do not
> see any lockdep warnings, seg faults or anything else in dmesg for
> long runs of
>
>         pyverbs
>         perftests (ib_xxx_bw, ib_xxx_lat)
>         rping (node to node)
>         blktests (srp)
>
> These patches were in v13 of the "Fix race conditions" patch. I will send v14 today.
> 8d342cb8d7ce RDMA/rxe: Cleanup rxe_pool.c
>
> 6e4c52e04bc9 RDMA/rxe: Convert read side locking to rcu
>
> e3e46d864b98 RDMA/rxe: Stop lookup of partially built objects
>
> e1fb6b7225d0 RDMA/rxe: Enforce IBA C11-17
>
> 2607d042376f RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
>
> ca082913b915 RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
>
> 394f24ebc81b RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
>
>
> 3fb445b66e5c RDMA/rxe: Add rxe_srq_cleanup()
>
> 4730b0ed751a RDMA/rxe: Remove IB_SRQ_INIT_MASK
>
>
> These patches are already submitted
> d02e7a7266cf RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"
>
> 569aba28f67c RDMA/rxe: Fix "Replace mr by rkey in responder resources(2)"
>  or whatever you called it.
> 5e74a5ecfb53 RDMA/rxe: Fix "Replace mr by rkey in responder resources"
>
> 007493744865 RDMA/rxe: Fix typo: replace paylen by payload
>
>
> This patch was submitted to scsi by Bart and addressed long timeouts that
> were not rxe related (same issue also happens with siw)
> cdd844a1ba45 Revert "scsi: scsi_debug: Address races following module load"
>
> If Zhu is not OK with this let know what bugs remain that need fixing.

How do you get this conclusion that I am not OK with this?

Zhu Yanjun

>
> Bob
