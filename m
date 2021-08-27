Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA893F92D4
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 05:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbhH0DTJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 23:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244100AbhH0DTJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Aug 2021 23:19:09 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BC5C061757;
        Thu, 26 Aug 2021 20:18:20 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c79so7638585oib.11;
        Thu, 26 Aug 2021 20:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkiUCwn+INwVF7n2fHOf14UuZAzqGm715MmqTg6MEAA=;
        b=KTKbytqUsklpN0IGxbIplhgOTdO07otuT08QHpjqgrRzhF71OInEO9qOYwDktesG1H
         kaPN/YbW0Zp7SFBmNBiNzAjraqPm+5xHdK4mozHej7eOsdOUhH8VwyNrlAYLWl2DFC0B
         SiPBRGWDPvTnPf8Yt+54r24eemAStR+hWIuceiMu60q1JX1cNlJ/x1YKqrbQzwPzcmmS
         LakqYFQILf+ZYBrrHhlRsoDjD9foHY8znT8dPGnL4eDD6n/xiML/LWpNGFEIx9hpyqZk
         b/ZjQHeAqR1bIteBtb2YW4kxwcO74A4TxCq5oui3ed7tN430xALxJ42ESERFnXs9FPkH
         HO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkiUCwn+INwVF7n2fHOf14UuZAzqGm715MmqTg6MEAA=;
        b=uAjcnAIsNS1sX+1Xyc4rjmXoSTHQ0islOPqXqteBxYv0FPouBgxhOjacMYmmYMowhE
         RA4/C0P5QRIRWrW1uN70M0RX2t/tDGd9pjcpQwAajI1tRo1We8vKGAJen84098V2EaIr
         LYSZKVr9QM7NUwNVJWWzwFrsfaCkfe9KoieJpm7fr6GHzbOfRUdBrJZCxTn/nkOc9cFk
         HiBILQBa/gxa1vGdYFvBLKAjxzMwkQHlE2XtmX+M0mwlv81j/G/6udfXbnf0MbBv/kCN
         K7YNS5bZJm6/ZLbqsF9QNtcg7NoCJyKBqPyscrhwE2H/m8YDgZw4JzZrRF/L1s53c0E0
         O5+Q==
X-Gm-Message-State: AOAM531/Q+YQL5mam2lYBpNZUkoeu6/mxeR1F0j631PfCh6UH2afr2bb
        bH5UiUm5hyEEW70DdmGK4cH8w2OJD/slT+xyxm5SjJex
X-Google-Smtp-Source: ABdhPJyBeovfknMfzqNbVIN5r2wmR5Az7NPNz+7BFNncrnIwQyLmtSnS6jaeZg66/i6YQBzP9Sb1JovrdrbCJyY3Se4=
X-Received: by 2002:aca:2814:: with SMTP id 20mr12989870oix.89.1630034300095;
 Thu, 26 Aug 2021 20:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org> <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
 <20210825163219.GY543798@ziepe.ca> <5ab2f7f1-2e76-b3f2-7dee-39d38dfeb25e@gmail.com>
In-Reply-To: <5ab2f7f1-2e76-b3f2-7dee-39d38dfeb25e@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 27 Aug 2021 11:18:08 +0800
Message-ID: <CAD=hENcgJSFoU0a0M8HMdLRcssfAmv73LjS=2n-yrFmOhwTJKA@mail.gmail.com>
Subject: Re: v5.14 RXE driver broken?
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 27, 2021 at 3:03 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 8/25/21 11:32 AM, Jason Gunthorpe wrote:
> > On Wed, Aug 25, 2021 at 11:02:14AM +0800, Zhu Yanjun wrote:
> >> On Tue, Aug 24, 2021 at 11:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >>>
> >>> Hi Bob,
> >>>
> >>> If I run the following test against Linus' master branch then that test
> >>> passes (commit d5ae8d7f85b7 ("Revert "media: dvb header files: move some
> >>> headers to staging"")):
> >>>
> >>> # export use_siw=1 && modprobe brd && (cd blktests && ./check -q srp/002)
> >>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]
> >>>     runtime    ...  48.849s
> >>>
> >>> The following test fails:
> >>>
> >>> # export use_siw= && modprobe brd && (cd blktests && ./check -q srp/002)
> >>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
> >>>     runtime  48.849s  ...  15.024s
> >>>     +++ /home/bart/software/blktests/results/nodev/srp/002.out.bad      2021-08-23 19:51:05.182958728 -0700
> >>>     @@ -1,2 +1 @@
> >>>      Configured SRP target driver
> >>>     -Passed
> >>
> >> Can this commit "RDMA/rxe: Zero out index member of struct rxe_queue"
> >> in the link https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc
> >> fix this problem?
> >>
> >> And the commit will be merged into linux upstream very soon.
> >
> > Please let me know Bart, if the rxe driver is still broken I will
> > definitely punt all the changes for RXE to the next cycle until it can
> > be fixed.
> >
> > Jason
> >
>
> Jason, Bart, Zhu
>
> I have succeeded in getting blktest to pass on 5.14. There is a bug in rxe that I had to fix. In
> loopback mode when an RNR NAK is received it requests the requester to start a retry sequence
> before the rnr timer fires which results in the command being retried immediately regardless of the
> value of the timeout. I made a small change which requires the requester to wait for either the
> timer to fire or an ack to arrive. The srp/002 test case in blktest spends a long time before posting

Can this problem be reproduced with 5.13? From Bart, this problem will
not occur with v5.13.

Thanks
Zhu Yanjun

> a receive in some cases which caused a soft lockup. There is a second non-bug which is the number of
> MRs was too small to run the test. I increased these by a factor of 256 which fixed that.
>
> My test setup has for-next + 5 recent rxe fix patches applied in addition to the RNR timing one above.
>
> I will submit a patch for the rnr fix.
>
> Bob
>
