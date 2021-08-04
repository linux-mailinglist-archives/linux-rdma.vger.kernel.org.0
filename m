Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A483DF954
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 03:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhHDBj3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 21:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhHDBj2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Aug 2021 21:39:28 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33176C06175F
        for <linux-rdma@vger.kernel.org>; Tue,  3 Aug 2021 18:39:16 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so277921oth.7
        for <linux-rdma@vger.kernel.org>; Tue, 03 Aug 2021 18:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1kLQbNOb5/t7Es9xC1Zmm/T92ZlFUnnCCpVbDf9Ycs=;
        b=k1b05GBrReFxeIGtydawg5U6xbN8oTdiLIYjwpnOfrNgTWG1SSy9jcNoVs49NuP/ro
         1/gZ8YnoS7Dh6jKOnHQ49uvGl427PJLDiuzauzP/WHMRTUvratpeGCe/f6vJkaPY1byM
         on+Jr39reMAVZ4BQLE4JnDM6x5FgZy9QwOVn0LzMWV0N9qx2VCpD6Rf/fFNkDDcvjlG3
         ZZsJn0ndC4Vjsr6yEAg4qj8NJ+g1qGzZKkQQKnZjK/oZHTS5abS9fP6+sWK/KfRJ+Rkn
         Y1kNTp/h4KjfNfloS4M6mmfJ1HJWxnZ6bEEXYvKjE48y6PZ2PqiQd67lUuSOLqUKioq4
         wTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1kLQbNOb5/t7Es9xC1Zmm/T92ZlFUnnCCpVbDf9Ycs=;
        b=iqxqweYyub70DPzB/x5g9v2+XinGVKDSC5N1QsTl9BacdNg2/XnpyzHqOFyEEsgVFV
         Y9wrgAk5LlELgGDZcw5nU6vjNgctRqai/ADOrEbbJ+5QJtORM89kT4zIVmreFA9nGY+T
         jShUrBZa09YJdIo5GgCO4TClWnyfgXFdEVuABuSWcFX2pOJEqCVBkb1poKEAMgxHSG6C
         i53UoM7PP+VjzC1ZrgzXhmJRIcR1u5LONM4NtsU3sv8M80A6r1hfmYYVi0zVh+borBvu
         B+FsRZsnuSUv1GEIWehFh1hqwVnffbhTY9fyrsz/QRDn9TnsYloLJp6EHy+A05uBHhfx
         byDA==
X-Gm-Message-State: AOAM531BZWr76cbEcO5TQC3TjK06WOPQbZUPCeMgJM/JJ47+gNgcUmuk
        NjSEIb+wXMn9wZBJl3cpCurnRdkhaWzsDRElrEg=
X-Google-Smtp-Source: ABdhPJwMO06BCQalfUGkuZ/it/mqpBj4fzunn8TFvTqCrBOspHHjyBsyBAgXy2vu6IkPQyIV6cDXpiPP9rB/79+HPJ8=
X-Received: by 2002:a05:6830:4188:: with SMTP id r8mr17469882otu.53.1628041155615;
 Tue, 03 Aug 2021 18:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210729220039.18549-1-rpearsonhpe@gmail.com> <20210803155814.GC2886223@nvidia.com>
In-Reply-To: <20210803155814.GC2886223@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 4 Aug 2021 09:39:04 +0800
Message-ID: <CAD=hENc0QMKKHcK+XTTq6TRJHOab-8GvY6e=a5sPDQMH1NbyGg@mail.gmail.com>
Subject: Re: [PATCH for-next v2 0/3] Three rxe bug fixes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 3, 2021 at 11:58 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Jul 29, 2021 at 05:00:37PM -0500, Bob Pearson wrote:
> > These patches fix three bugs currently in the rxe driver.
> > One of these was released earlier. In this v2 version two other bug
> > fixes are added.
> >
> > Bob Pearson (3):
> >   RDMA/rxe: Fix bug in get_srq_wqe() in rxe_resp.c
> >   RDMA/rxe: Fix bug in rxe_net.c
>
> I fixed these up and applied them to for-rc

I will focus on the other 2 commits except the commit "RDMA/rxe: Fix
bug in rxe_net.c" since this commit is reviewed and tested.

Zhu Yanjun

>
> Please be careful that the fixes lines are correct and subjects should
> be self descriptive not 'fix a bug in x'
>
> >   RDMA/rxe: Add memory barriers to kernel queues
>
> This one can go to for-next
>
> Jason
