Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3F83EA244
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Aug 2021 11:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhHLJpL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Aug 2021 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhHLJpL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Aug 2021 05:45:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA30C061765
        for <linux-rdma@vger.kernel.org>; Thu, 12 Aug 2021 02:44:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso6619745wmq.3
        for <linux-rdma@vger.kernel.org>; Thu, 12 Aug 2021 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=poedIdtczPM0nR5Uw7XJHeDTESq+tc78leZVLXve9xg=;
        b=Ttv9CDgdfgQrBALlc+5ddOoQUMZK91eXmUomR3KuyDBsi5YNrNbLxUE6QDz/l2HCUq
         9vzfM9Lo2ID9DjeNXLPD2ePIQ2Zqm8T0x6bEF/miqAoUZEZgsHKmVOVzOf2YwtaDm1Pq
         BOwG1rnN3x0uUzvCdDozwAo7/fdwSkRh3tKc3o11hAz59uIeMhBEMVrtN3k6zu802a3E
         lgT4L15xEwARmJ9Sxj5BRiEDfpwtTWvz/Zf8gqSXLbR/IahP3yQgbjG0Hm7bpTOyQp5+
         s8cx6S79sFwzArW5BUFQR7BzQVWQEJ9bWmtNqXNpJX4tLLMyqkJKXuY11fuBVjVPXwjP
         yuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=poedIdtczPM0nR5Uw7XJHeDTESq+tc78leZVLXve9xg=;
        b=jdNMX4HIYoOmb7t05oWFPML1nmdnUt5dYOt6hVCWSpzDshKdit9MpmYXleBpYXvWEM
         R5kX3UBurUrbhQyUP7QOJDZf7jeA/NOEKWaDAfmr1hgk30H00j+nROH9SGfShLHk1/G6
         Kq0T4RehJitO1cEYo6Ygbm0qrelqc2VjA6veHNNDVjLSiUJvgg7Qtl+8q45rlNuNcyky
         E8xA7y+8orHgGVjSmqEE4sv1gRGlI+jF02pukJ8cOtvux6HfeieEP0xSy/i0+nadiWbq
         CnF8qQ5TTNp/Cs81f2EmuXPjfDMcPcmFT48oFmb2ikYF42MJO5TO85vBvFW/eA13cwsQ
         TrFg==
X-Gm-Message-State: AOAM533hAyevr1ZchBHY72q7NezBLhiedOiVp0IApKJXn2DPlTp5s0Nb
        RDK0lvdOE0eDH/yYcY6kZhYIvW5Pil0WzschV5k=
X-Google-Smtp-Source: ABdhPJwzcjFfLe+ZEM5Z3KJhFsDCsM26BB2zsA5xnERxK9PYa3UbaL0rZosBol0VBolSrUpzOyq+u3OJZa1GYKP1DXk=
X-Received: by 2002:a05:600c:2242:: with SMTP id a2mr3048929wmm.180.1628761484627;
 Thu, 12 Aug 2021 02:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210811051650.14914-1-pkushwaha@marvell.com> <20210811114458.GA7008@nvidia.com>
In-Reply-To: <20210811114458.GA7008@nvidia.com>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Thu, 12 Aug 2021 15:14:08 +0530
Message-ID: <CAJ2QiJLi+MQbkj4KVXYBZjsbj-YuAdLWKP56nJ=tDKaO+JgHcw@mail.gmail.com>
Subject: Re: [PATCH for-next] qedr: Move variables reset to qedr_set_common_qp_params()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Prabhakar Kushwaha <pkushwaha@marvell.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com,
        Michal Kalderon <mkalderon@marvell.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shai Malin <smalin@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Shai Malin <malin1024@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear Jason,

On Wed, Aug 11, 2021 at 5:15 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Aug 11, 2021 at 08:16:50AM +0300, Prabhakar Kushwaha wrote:
> > Qedr code is tightly coupled with existing both INIT transitions.
> > Here, during first INIT transition all variables are reset and
> > the RESET state is checked in post_recv() before any posting.
> >
> > Commit dc70f7c3ed34 ("RDMA/cma: Remove unnecessary INIT->INIT
> > transition") exposed this bug.
>
>
> Since we are reverting this the patch still makse sense? Certainly
> having a driver depend on two init->init transitions seems wrong to me
>

Yes, definitely still makes sense, thanks.

-- prabhakar (pk)
