Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483DD41AC7E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 11:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhI1KAf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 06:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbhI1KAe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Sep 2021 06:00:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71900C061575
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 02:58:55 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t189so29322316oie.7
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JuGatQ36FUOGfAS7kR2jHw8KpjE4x1ixFXoJnrrwbfk=;
        b=n3HQf2qSNO3uS/SU/TXAV1pEzRgIQLe45BlP++o2inc49TfKN+sNQl9vBbkK1v7OIY
         I+1cLy7NoVPnPp8XAxZkOQWVsKH6GxMtzz4i3zSMgzW0+CCcFR6fnfx5xjjjVY7n1eDQ
         w6IwMpo6sOtMNGgCNKaIDB78zyYqMFe5YbBoZooQohRTNWhcpPbtWwH1tRZUyY20W1MA
         Hb2Y9nUB1Sa76uS4V2IQG1inKKmOT2k0yaypOdDzcKjf1kVHq6r0MSA5v4N+QRw4ZU+o
         fLcvkWn9cF/yl5W1lphtmuflRnGf+te1m/9v6flsd3+36l/TTXqaRtVa6iM3ik314lMg
         x6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JuGatQ36FUOGfAS7kR2jHw8KpjE4x1ixFXoJnrrwbfk=;
        b=JL2R+vG7bRTz7yKEQRlhyYJtPLqN+aaTjLZ+37sJ/UAvKyQRo6ov1G/jhzp6d7eVKa
         6NTxnO+SboPmAI/98mEW1Z15gAtavXQrY5hwMtmygFgsHsWjDWin8olkAxek82j+kC2q
         s0N9aGdAjRawW0kryX4SkRTSxBEEMWGkny7+01LvvSYxKgKngr9nauPWUV9yRAxVctOp
         3c/I8Fta1jqWd2uvrBvbR+1OBMR2G7E5Ann/XtektIlyD7IoUcd1R2a9iMrDZ7X0okUs
         1azKQLCtnmMXibNpSC+WP1ziiv0nUSESEiY5NnJ0MI1Ocxd81YdrMfxXcX6DmSmsDmsy
         ZaBw==
X-Gm-Message-State: AOAM532aDnZEUDY8W8/4o4hWK0YJZ/c8b5fG7qz3sCHgJJ6BctNqMLEY
        RqySWwkLUtLzVPPwL73jbCGHcJbZW+4k3fMTWyU=
X-Google-Smtp-Source: ABdhPJxYaDjeeZ61toPOj495nhP5Gj6T5K6GKTAESonmdrCU8OzZBMBkDnAjf58k5bPBa7JcbXVTJ/FyVQDnLYsZMTc=
X-Received: by 2002:aca:c615:: with SMTP id w21mr2915245oif.169.1632823134882;
 Tue, 28 Sep 2021 02:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
 <20210927191907.GA1582097@nvidia.com> <CAD=hENd0BDMS6BL_M2rDT7N8sZySQHLbzDEfWZ0AvSd6nmFmoQ@mail.gmail.com>
 <6a6cede4-32c3-45aa-86f9-4cd35d90ab4f@oracle.com> <CAD=hENeQrNPxjgxbPN0KuKF1XHT+GbEADKX1D3pP0qv=gNXN2Q@mail.gmail.com>
 <24e4ea29-557d-b2f6-8bef-30af19613b16@oracle.com>
In-Reply-To: <24e4ea29-557d-b2f6-8bef-30af19613b16@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 28 Sep 2021 17:58:43 +0800
Message-ID: <CAD=hENcn6vZMx4YM3n4Kdo_kBCM_aHK8NOa+QgaAPnNk9jK60w@mail.gmail.com>
Subject: Re: [PATCH v1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 28, 2021 at 5:41 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
>
> On 9/27/21 11:55 PM, Zhu Yanjun wrote:
> > On Tue, Sep 28, 2021 at 12:38 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
> >>
> >> On 9/27/21 6:46 PM, Zhu Yanjun wrote:
> >>> On Tue, Sep 28, 2021 at 3:19 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>>> On Tue, Sep 14, 2021 at 06:12:20PM -0700, Rao Shoaib wrote:
> >>>>> In our internal testing we have found that
> >>>>> default maximum values are too small.
> >>>>> Ideally there should be no limits, but since
> >>>>> maximum values are reported via ibv_query_device,
> >>>>> we have to return some value. So, the default
> >>>>> maximums have been changed to large values.
> >>>>>
> >>>>> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> >>>>> ---
> >>>>>
> >>>>> Resubmitting the patch after applying Bob's latest patches and testing
> >>>>> using via rping.
> >>>>>
> >>>>>    drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
> >>>>>    1 file changed, 16 insertions(+), 14 deletions(-)
> >>>> So are we good with this? Bob? Zhu?
> >>> I have already checked this commit. And I have found 2 problems with
> >>> this commit.
> >>> This commit changes many MAXs.
> >>> And now rxe is not stable enough. Not sure this commit will cause the
> >>> new problems.
> >>>
> >>> Zhu Yanjun
> >> Hi Zhu,
> >>
> >> A generic statement without any technical data does not help. As far as
> >> I am aware, currently there are no outstanding issues. If there are,
> >> please provide data that clearly shows that the issue is caused by this
> >> patch.
> > Hi, Shoaib
> >
> > With this commit, I found 2 problems.
> > This is why I suspect that this commit will introduce risks.
>
> Hi Zhu,
>
> I did full testing before I sent the patch, that is how I found that
> rping did not work. What are the issues that you found? How to I
> reproduce those issues?

Sorry. What tests do you make?

Do you make tests with the followings:

1. your commit + latest kernel  <------rping------- > 5.10 stable kernel
2. your commit + latest kernel < ------rping------- > 5.11 stable kernel
3. your commit + latest kernel < ------rping------- > 5.12 stable kernel
4. your commit + latest kernel < ------rping------- > 5.13 stable kernel
5. your commit + latest kernel < ------rping------- > 5.14 stable kernel
6. rdma-core tests with your commit + latest kernel

Zhu Yanjun

>
> Shoaib
>
> >
> > Before a commit is sent to the upstream, please make full tests with it.
> >
> > Zhu Yanjun
> >
> >> Thanks you.
> >>
> >> Shoaib
> >>
> >>>>> -     RXE_MAX_MR_INDEX                = 0x00010000,
> >>>>> +     RXE_MAX_MR_INDEX                = DEFAULT_MAX_VALUE,
> >>>>> +     RXE_MAX_MR                      = DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
> >>>> Bob, were you saying this was what needed to be bigger to pass
> >>>> blktests??
> >>>>
> >>>> Jason
