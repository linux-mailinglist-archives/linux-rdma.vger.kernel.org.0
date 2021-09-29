Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2FF41BEAD
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 07:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244208AbhI2FZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 01:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbhI2FZE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Sep 2021 01:25:04 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78242C06161C
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 22:23:24 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so1457749otv.4
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 22:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0WQerXvv5DldRc1Y7/NXZtYkDaOb1s4/NS65UoBR0U=;
        b=JZTCccAGVomrj9mvKmJiouoyfzpks4A74px1SJgBK/KLuRCYpvdGnfNLCBuT8UDgCK
         kqJ4az1dm4m4/SXTC9qeI9zU33hAc5vqGOG5Q74+8T8HU5D76DLMrkBmA5+87ZgufuvY
         7etPvYYrNIa/bW0HcuHDOZWuH+fbDaxWowSWw/+FXRU0eTVdw1bBzrCIknVupeMcC1JR
         5VlW/fzE0AVd3/T0xiyj7JiFo1UEMPsF9emal9sy49vK6G5p8DAPWOTdSwaOZ7iXnE7/
         sGT4FliSAYDFAKzzFG+gyxZH6siMeAeP+VCQiJoZeL1mk0qWPykTOfk6hj5a7WkYRpKm
         IIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0WQerXvv5DldRc1Y7/NXZtYkDaOb1s4/NS65UoBR0U=;
        b=tXwud9y3mV1ODE5d0OpqlxTmsBIY5PhKg0/mA82jXjLk8nqz4TWLRXRECrafeJlOg3
         hnmtCIRUNq+knyFc0KhEBLXuQiIh8Rz50ATOT+wup9uZAmmctHt8KNrg+iEju68GcDZO
         Qa3l+3qh5BthhHA3LpMkoOzGAoa4dtDtutP/S5TXfhRdTZZYAQ8+9wpqoUKKcymS4fqr
         ycbMvwSAZLooOBOA8ImwpzWD+5PW+IW5roEA9xl/ubm8wF9pwAY5Mrsp6JXedYqw1ULh
         IuKMXDnzjwd5Yx1hujCLj5/UGJ7eL2XqhOwWGLRMmNmVN7lX98950dXpP5lhmju31NL2
         BZRw==
X-Gm-Message-State: AOAM53057hyPCv127gxDGD9mGTv+gMC9imHPMA4lA9VW9z1DobQet8L4
        WUR/g+g7fVje4ipjhU4COfXx62OQUCS5mUxfRXA=
X-Google-Smtp-Source: ABdhPJwuJeCMqSQU+vPRttIZlVzYZcKXccgNBeazXx6O9VDVe5zfh4GwbEwozPZilZAobuncA8maQdofktKDIhCFUjQ=
X-Received: by 2002:a9d:4e91:: with SMTP id v17mr8718626otk.297.1632893003881;
 Tue, 28 Sep 2021 22:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
 <20210927191907.GA1582097@nvidia.com> <CAD=hENd0BDMS6BL_M2rDT7N8sZySQHLbzDEfWZ0AvSd6nmFmoQ@mail.gmail.com>
 <6a6cede4-32c3-45aa-86f9-4cd35d90ab4f@oracle.com> <CAD=hENeQrNPxjgxbPN0KuKF1XHT+GbEADKX1D3pP0qv=gNXN2Q@mail.gmail.com>
 <24e4ea29-557d-b2f6-8bef-30af19613b16@oracle.com> <CAD=hENcn6vZMx4YM3n4Kdo_kBCM_aHK8NOa+QgaAPnNk9jK60w@mail.gmail.com>
 <cd243ca0-859f-42b5-6851-6b0be7385a7e@oracle.com>
In-Reply-To: <cd243ca0-859f-42b5-6851-6b0be7385a7e@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 29 Sep 2021 13:23:12 +0800
Message-ID: <CAD=hENdN=rzZ0D-9Kk+yjRY8aLbYUWpiz_SuiWSDd2j1YPFkAw@mail.gmail.com>
Subject: Re: [PATCH v1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 29, 2021 at 12:02 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
>
> On 9/28/21 2:58 AM, Zhu Yanjun wrote:
> > On Tue, Sep 28, 2021 at 5:41 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
> >>
> >> On 9/27/21 11:55 PM, Zhu Yanjun wrote:
> >>> On Tue, Sep 28, 2021 at 12:38 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
> >>>> On 9/27/21 6:46 PM, Zhu Yanjun wrote:
> >>>>> On Tue, Sep 28, 2021 at 3:19 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>>>>> On Tue, Sep 14, 2021 at 06:12:20PM -0700, Rao Shoaib wrote:
> >>>>>>> In our internal testing we have found that
> >>>>>>> default maximum values are too small.
> >>>>>>> Ideally there should be no limits, but since
> >>>>>>> maximum values are reported via ibv_query_device,
> >>>>>>> we have to return some value. So, the default
> >>>>>>> maximums have been changed to large values.
> >>>>>>>
> >>>>>>> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> Resubmitting the patch after applying Bob's latest patches and testing
> >>>>>>> using via rping.
> >>>>>>>
> >>>>>>>     drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
> >>>>>>>     1 file changed, 16 insertions(+), 14 deletions(-)
> >>>>>> So are we good with this? Bob? Zhu?
> >>>>> I have already checked this commit. And I have found 2 problems with
> >>>>> this commit.
> >>>>> This commit changes many MAXs.
> >>>>> And now rxe is not stable enough. Not sure this commit will cause the
> >>>>> new problems.
> >>>>>
> >>>>> Zhu Yanjun
> >>>> Hi Zhu,
> >>>>
> >>>> A generic statement without any technical data does not help. As far as
> >>>> I am aware, currently there are no outstanding issues. If there are,
> >>>> please provide data that clearly shows that the issue is caused by this
> >>>> patch.
> >>> Hi, Shoaib
> >>>
> >>> With this commit, I found 2 problems.
> >>> This is why I suspect that this commit will introduce risks.
> >> Hi Zhu,
> >>
> >> I did full testing before I sent the patch, that is how I found that
> >> rping did not work. What are the issues that you found? How to I
> >> reproduce those issues?
> > Sorry. What tests do you make?
> >
> > Do you make tests with the followings:
> >
> > 1. your commit + latest kernel  <------rping------- > 5.10 stable kernel
> > 2. your commit + latest kernel < ------rping------- > 5.11 stable kernel
> > 3. your commit + latest kernel < ------rping------- > 5.12 stable kernel
> > 4. your commit + latest kernel < ------rping------- > 5.13 stable kernel
> > 5. your commit + latest kernel < ------rping------- > 5.14 stable kernel
> > 6. rdma-core tests with your commit + latest kernel
> >
> > Zhu Yanjun
>
> Hi Zhu,
>
> With all due respect, I am a little surprised by the special treatment
> being given to this rather simple patch. Normally comments to a patch
> are submitted with technical data to back them up. In this case none
> have been provided. If we are going by gut feelings, then there are more
> involved patches that are being accepted without any tests as listed above.

All the commits that I reviewed will pass the mentioned tests. But your commit
failed to pass the tests at least 2 times. So I suggest that you make the above
tests in your local hosts. This will save us time.
I do not treat your commit specially.

>
> My initial patch increased the value of 3 variables but the community
> suggested that values of other variables should be increased as well.
> The discussion happened on this mailing list and no objections were raised.
>
> The two issues that you mention were mechanical issues, (one reported by
> you and one by the kernel bot) that have been fixed. They had nothing to
> do with the values being increased. As I have said I have tested the
> patch several times, most recently about a week or so ago with Bob's
> latest change.

I do not know how you tested your patch in your host. If your tests include
backward compatibility and rdma-core tests that I mentioned in the above mail,
I am fine with this commit.

Zhu Yanjun

>
> I am not keen on changing the values of any other parameters, but the 3
> that were contained in my original patch. The link to those patches is
>
> https://www.spinics.net/lists/linux-rdma/msg103570.html
>
> Please let me know if those are acceptable. They have been tested
> *extensively* running several different kinds of Oracle DB workloads.
>
> Regards,
>
> Shoaib
>
> >
> >> Shoaib
> >>
> >>> Before a commit is sent to the upstream, please make full tests with it.
> >>>
> >>> Zhu Yanjun
> >>>
> >>>> Thanks you.
> >>>>
> >>>> Shoaib
> >>>>
> >>>>>>> -     RXE_MAX_MR_INDEX                = 0x00010000,
> >>>>>>> +     RXE_MAX_MR_INDEX                = DEFAULT_MAX_VALUE,
> >>>>>>> +     RXE_MAX_MR                      = DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
> >>>>>> Bob, were you saying this was what needed to be bigger to pass
> >>>>>> blktests??
> >>>>>>
> >>>>>> Jason
