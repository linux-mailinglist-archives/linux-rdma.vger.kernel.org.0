Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAA3D18D5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 23:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhGUUe6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 16:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhGUUe5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 16:34:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F612C061575
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 14:15:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w14so4155873edc.8
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYGtT9th5akHaXbl1CreYNk4Ul2/NGj//xYVdEeZwTM=;
        b=dA/YVtnkcO/ImsuZzjsFD2dS/kSK/p87ocBFDb3uEgJ2koTPdSArnrVjSvXShiV8oZ
         lBXbcvUli4uhK+3DSOS069dUAEuReElOAld5M0C6kSbYSGKkIerDkYg4T+PlWhOc3SX7
         Lq8WUVNQ0CbiU/xM/AAhlE+sW4B2xp0NT4fzpAP6VajpFz4Gg5AFcBAP0maEpVT+FvdV
         N3qfImplz081m4JD6kgwInN1Ldww6MLuOjtZWaFSVcIjVJqAjQ9QfMfOJjYUoow6TxAL
         MPvqabAOl+3I2LnC8msB5GlEpxHQ7Ent0aBK1WHonIcjVZ6C2SrWKlpDTGNc2POeTVMV
         GtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYGtT9th5akHaXbl1CreYNk4Ul2/NGj//xYVdEeZwTM=;
        b=O1L7wDufbVyGqBQOeUB69JTPBwZYDeUWlvc0X542qSNTw2hoBxmIUpln0JMJDtR72N
         c8Vk6VgLMORhVyOhqQfTt6G4uNTOcMZFD3qCzjQ+s670Ou9GOUb/nEaOxTsLhRw2fx4D
         K2VSRFSnS+9X3gbFlbkGb8cFKcjj7xcGiO7NPk96hoUXOpz31YTf4/vroIch+bJFYVyi
         CXmRzjnySriJChIzxYvF2N7MRNVqAio3aeRk6d3kntzHKE/jn6I+KOdgof3B8FtoTjm4
         9SptAD56dScLe3M/Ka7if6il5ZxX9uqdY1ywOALtpxNkEIK49h4Wddqhms9RsX1aae84
         +Rag==
X-Gm-Message-State: AOAM532zRzxBg8/3gCucAOteSdk7IdDRphun4WJnCTY7eirmbCf0mDQG
        suB5O/86mr5oqtqfF1MP6VtnFmS/MTtvqRN9c4Y=
X-Google-Smtp-Source: ABdhPJyVpdyITO31HApNrn7sTuzPap9kjFSJK+EYVoj4IAHAnWHOsGq3ByCIKap5MdJWC1Ng6HNVwDgzX9sicjyAYqw=
X-Received: by 2002:a05:6402:1d4d:: with SMTP id dz13mr50592887edb.67.1626902131188;
 Wed, 21 Jul 2021 14:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGbmTjiT+nxXB7BMp6mwpUs+HVUGy-CGXBBrC04jQ3grA@mail.gmail.com>
 <63d7f374-1252-82c8-769d-2d1a540466fd@gmail.com> <CAN-5tyFQd3wzRXtcQoO0wC-bU1Ggk05K7ikokY_ZGZidG=CP5A@mail.gmail.com>
 <YPe02wEIHJffalro@unreal>
In-Reply-To: <YPe02wEIHJffalro@unreal>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 21 Jul 2021 17:15:20 -0400
Message-ID: <CAN-5tyEDF+KvSLxBNR_1vPdiJTDJMt1hc_ztk3E-J109x+Z4SA@mail.gmail.com>
Subject: Re: RDMA/rxe is broken (impacting running NFSoRDMA over softRoCE)
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 1:47 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Jul 20, 2021 at 05:48:03PM -0400, Olga Kornievskaia wrote:
> > On Tue, Jul 20, 2021 at 2:27 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> <...>
>
> > There were a number of commits that lead to crashes. commit
> > ec9bf373f2458f4b5f1ece8b93a07e6204081667 "RDMA/core: Use refcount_t
> > instead of atomic_t on refcount of ib_uverbs_device" leads to the
> > following kernel oops. commit 205be5dc9984b67a3b388cbdaa27a2f2644a4bd6
> > "RDMA/irdma: Fix spelling mistake "Allocal" -> "Allocate"" also leads
> > to the kernel oops.
>
> The commits above aren't relevant to RXE at all.
>
> If first commit is wrong, all drivers will experience crashes and second
> commit is in irdma and not in RXE.
>
> And both of them are legit commits.

Yes I realize they are problems outside of rxe but I didn't run into
any crashes when I ran rpring on the 5.14-rc1 (it was hanging and
that's what I reported here) so I thought perhaps later patches have
addressed the crashes I've seen.

Would you like me to post a separate email report on the crash(es) (I
don't recall if it's the same one or two different ones)?

>
> Thanks
