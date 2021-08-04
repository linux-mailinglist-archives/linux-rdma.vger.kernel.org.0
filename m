Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C11E3DF908
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 02:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhHDAvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 20:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhHDAvv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Aug 2021 20:51:51 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA53C06175F
        for <linux-rdma@vger.kernel.org>; Tue,  3 Aug 2021 17:51:39 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y7so1561875ybo.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Aug 2021 17:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXhuxhSXvQkgWbuiR9eLR0Tjm5vScd0fEHtHmfZBRq0=;
        b=Prt7m4I1Yc4kSFXQMhfJfhEKu0PyAjarqN3Z+p59qlaHnmgPrlQfSqtgN+SDOlhBEr
         YT/ltu4gE00UFQSSqIPUhipizUAX/25Hvkqc1JKBBqwM3Z/ejxAPUq3UJ2aIGH2MXnh6
         GCa7S76EBeZ2M+8IElTnTtqlQyyBoHrKDUTEBwqa6hYA45Ab0DqXsRtOt8gen3h1uunt
         6yWqe3y/24eXGBmN+H2o5AJVECQAVT5OVKi0TemvlNjtUYyVsI1yC5+QUHP9tBSj56BO
         7zdRnNOrIjnb3LrKknEdJkAtRhq/jQroQmGO1q5UUsIJeoYmQftOiQVZdzd0ro0ZQErB
         74pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXhuxhSXvQkgWbuiR9eLR0Tjm5vScd0fEHtHmfZBRq0=;
        b=PSifblboiJXOP1qwu2vTKeKiHUG5BT5izUYbDiBA+Cd+/8wxuxsKy3F6p3ctuoQ5wi
         H+gTdYU3WDlmXciigCw1dB4zikAdnYo8w9aTaGKYsfZ233l0h+NSxEA8lpaie7V10zzo
         nMS3o2GkkUOxf1BcFu7nSZhIaWSs7j1rVJm3M/OOE1QE4voDJqT7VNMWh3KebdOPNnVB
         pGISorSLxyxXVEy9JJE8G2hED57lFcn6hQzzK72kWWigVwHACxVmgqZ+Y8fAeW6Y0hBa
         Bt3tQlgcewnGolQCZ/EDqBX4FzKxZ3k4WFCMEojowSp+cBonSDlF3wKr3A2RST4XpmZ2
         jf4Q==
X-Gm-Message-State: AOAM533wAhto50YaGx25Xow1Tupq1sNnwCTKiw6mInQc4qVRGiwdQ1xp
        TvCsKDZKCwz+ubk8YCUfP3XdTiWbK0ZSkBoAniA=
X-Google-Smtp-Source: ABdhPJyM3ntvnHYtHkxeWjD7gYJ1bWNV7vZtaPmRLth6lg3evQrVOUk51HQ9dm3Nn/fB7ws3t3LteBZNONv5fuPjHV0=
X-Received: by 2002:a25:ba83:: with SMTP id s3mr30479727ybg.450.1628038298989;
 Tue, 03 Aug 2021 17:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com> <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca> <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com> <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com> <20210729195034.GF543798@ziepe.ca>
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
 <14b9f35a-0086-834a-c05f-361a26befc13@oracle.com> <90ab34d4-92d1-986d-80e5-4253d208d073@oracle.com>
In-Reply-To: <90ab34d4-92d1-986d-80e5-4253d208d073@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 4 Aug 2021 08:51:27 +0800
Message-ID: <CAD=hENdFbF9VKhgLhSBomvQ7KvDFJhTNiPt-AfdWsKBVfo58MQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 4, 2021 at 7:53 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
> Hi Zhu,
>
> Any update on your testing after applying Bob's fixes

Do you read my problem carefully?
I mean that before your commit, the whole rxe can work well.
After your commit, the rxe can not work well.
Please reproduce this problem in your host and fix it.

Zhu Yanjun

>
> Shoaib
>
> On 7/29/21 5:34 PM, Shoaib Rao wrote:
> > Thanks Bob.
> >
> > Zhu can you please apply those patches and test.
> >
> > Shoaib
> >
> > On 7/29/21 4:08 PM, Pearson, Robert B wrote:
> >> I found another rxe bug (for SRQ) and sent three bug fixes in a set
> >> including the one you mention. They should all be applied.
> >>
> >> -----Original Message-----
> >> From: Jason Gunthorpe <jgg@ziepe.ca>
> >> Sent: Thursday, July 29, 2021 2:51 PM
> >> To: Shoaib Rao <rao.shoaib@oracle.com>
> >> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>; RDMA mailing list
> >> <linux-rdma@vger.kernel.org>
> >> Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values
> >> used via uverbs
> >>
> >> On Thu, Jul 29, 2021 at 12:33:14PM -0700, Shoaib Rao wrote:
> >>
> >>> Can we please accept my initial patch where I bumped up the values of
> >>> a few parameters. We have extensively tested with those values. I will
> >>> try to resolve CRC errors and panic and make changes to other
> >>> tuneables later?
> >> I think Bob posted something for the icrc issues already
> >>
> >> Please try to work in a sane fashion, rxe shouldn't be left broken
> >> with so many people apparently interested in it??
> >>
> >> Jason
