Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87D93DF9A2
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 04:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbhHDCWO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 22:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhHDCWO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Aug 2021 22:22:14 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8943DC06175F
        for <linux-rdma@vger.kernel.org>; Tue,  3 Aug 2021 19:22:01 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 26so1236152oiy.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Aug 2021 19:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miRRUUydIh317RPbFnMCM8lB2aW75lYmlisa2iFdAw8=;
        b=dAQCBSy9W9aVOWYGKaAG7UNdymgb67qCc8rEQanyKNS1EZLacpCcS9CANe6WmjMprV
         a3vvE3YG1mRr+TH7GrVilVPuVmHyPzUexca4FhEKJr997in0P9zHeqrhfKqsQZJg/IkV
         4aTbWaEI+EmRVj+gOiPLArVSJP0SIWv0ZBlEu9f58pGXpew4uLXyD3exYNiuWhrKI0Ci
         /T8jw6jRUHBLXVdlyZ0UEOM7XOFH0/yfhLmAhckFyFhuj0uF84uuqMTaDARW9UfbD7n5
         OK3dDYa2F1/z138grkPUY/znFirjsNeRax4Fc3QJDY37nRgX234BKxMMVDmJ0UKgBzp0
         5Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miRRUUydIh317RPbFnMCM8lB2aW75lYmlisa2iFdAw8=;
        b=My09Wu8ql1dUbcjsY6PQSZs0j/9WzZq9SZm4yHQx+lOBFqaEbc/ChlBJUymfNNvFU0
         ytWj7iUkgs38Rl1pX20qw3Tn7g68ly32ps0xZcdXTd5kcLeF962ZMx4jM+KQhXGXe1Am
         MANIa4rul7f8lyFiJlnalfK5Lp4aCKx1UGKy8BdlSLksDaNuC93s3Vy3WR+YOW6OlNhX
         BPlBIIOLIOpQIfBLtxFTXvU/Lr4P10AkmbO++1+/UT9iZGzFcCLSopfjBxT3Qfpb7nQT
         D3KvkbSxKID21LboEhIK6zaRIzjJ3vsBC0j3goegz72jKBQniCex28IbquusFQ7z2S24
         f98A==
X-Gm-Message-State: AOAM532pxfSrgJQnDxfyBtabBijOwoKXr0d18oupsLM1REMpawvi/ub/
        MmC0TF2aKYpMirBlJAUVJdXlccrLpvOKMNIR0lk=
X-Google-Smtp-Source: ABdhPJwELo4YYrr0Hno3mQKdWdF7kEDpqXyA71F5+wlqzGb2oGEVpSsneyXqeWV5n5R/jWhVKrWD+sLvD9lZvyfAssk=
X-Received: by 2002:a05:6808:bc2:: with SMTP id o2mr5039265oik.163.1628043721027;
 Tue, 03 Aug 2021 19:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com> <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca> <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com> <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com> <20210729195034.GF543798@ziepe.ca>
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
 <14b9f35a-0086-834a-c05f-361a26befc13@oracle.com> <90ab34d4-92d1-986d-80e5-4253d208d073@oracle.com>
 <CAD=hENdFbF9VKhgLhSBomvQ7KvDFJhTNiPt-AfdWsKBVfo58MQ@mail.gmail.com> <7a1881c3-4955-5a24-7f90-4d60f2a607a8@oracle.com>
In-Reply-To: <7a1881c3-4955-5a24-7f90-4d60f2a607a8@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 4 Aug 2021 10:21:49 +0800
Message-ID: <CAD=hENeupnOm1Jie+VM-t7dgEAtTp85HXjnFB+tj6bPihp5JKQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 4, 2021 at 10:03 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
>
> On 8/3/21 5:51 PM, Zhu Yanjun wrote:
> > On Wed, Aug 4, 2021 at 7:53 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
> >> Hi Zhu,
> >>
> >> Any update on your testing after applying Bob's fixes
> > Do you read my problem carefully?
> > I mean that before your commit, the whole rxe can work well.
> > After your commit, the rxe can not work well.
> > Please reproduce this problem in your host and fix it.
> >
> > Zhu Yanjun
>
> You posted
>
> > In my daily tests, I found that one host 5.12-stable, the other host
> > is 5.14.-rc3 + this commit.
> > rping can not work. Sometimes crash will occur.
> >
> > It seems that changing maximum values breaks backward compatibility.
> >
> > But without this commit, that is, 5.12-stable <-------> 5.14-rc3,
> > rping can work well.
> >
> > Zhu Yanjun
> I am not sure how you made rxe to work because it did not work for me
> and neither for Bob. Since then, Bob has posted patches for the issue. I
> also posted that my changes work on 5.13.6 kernel. emails attached.
>
> Even if rxe in 5.14 is working for you some how, please apply Bob's
> patches and then mine and test.

I have already applied this commit
https://patchwork.kernel.org/project/linux-rdma/patch/20210729220039.18549-3-rpearsonhpe@gmail.com/.

And with your commit, rxe can not work well.

Zhu Yanjun

>
> Thanks,
>
> Shoaib
>
>
> >
> >> Shoaib
> >>
> >> On 7/29/21 5:34 PM, Shoaib Rao wrote:
> >>> Thanks Bob.
> >>>
> >>> Zhu can you please apply those patches and test.
> >>>
> >>> Shoaib
> >>>
> >>> On 7/29/21 4:08 PM, Pearson, Robert B wrote:
> >>>> I found another rxe bug (for SRQ) and sent three bug fixes in a set
> >>>> including the one you mention. They should all be applied.
> >>>>
> >>>> -----Original Message-----
> >>>> From: Jason Gunthorpe <jgg@ziepe.ca>
> >>>> Sent: Thursday, July 29, 2021 2:51 PM
> >>>> To: Shoaib Rao <rao.shoaib@oracle.com>
> >>>> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>; RDMA mailing list
> >>>> <linux-rdma@vger.kernel.org>
> >>>> Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values
> >>>> used via uverbs
> >>>>
> >>>> On Thu, Jul 29, 2021 at 12:33:14PM -0700, Shoaib Rao wrote:
> >>>>
> >>>>> Can we please accept my initial patch where I bumped up the values of
> >>>>> a few parameters. We have extensively tested with those values. I will
> >>>>> try to resolve CRC errors and panic and make changes to other
> >>>>> tuneables later?
> >>>> I think Bob posted something for the icrc issues already
> >>>>
> >>>> Please try to work in a sane fashion, rxe shouldn't be left broken
> >>>> with so many people apparently interested in it??
> >>>>
> >>>> Jason
