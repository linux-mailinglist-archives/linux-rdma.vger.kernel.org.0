Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BF63F255C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 05:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbhHTDcp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 23:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbhHTDcm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Aug 2021 23:32:42 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF75C061575
        for <linux-rdma@vger.kernel.org>; Thu, 19 Aug 2021 20:32:05 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u10so11422602oiw.4
        for <linux-rdma@vger.kernel.org>; Thu, 19 Aug 2021 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKT3g3xjVz+lJRO/NfyP1oKBqnxAQNnE0uZo/KDRS3Y=;
        b=fPtdHOEhz9PxfoczBScsKUiKS3AEzRTJX/gYew/VdWechbwbSFN6zPpTDuuwAqxihP
         7kSZuZbbGtHAhgt4AJ8DtqMj7PDRTb5D2Bfnz0PCIqeFiwzikx88aBdNKAOCLcIgn/UP
         yDiphyAd6Nk9CoCOUkyQyLrr546mVuGynC4O6DIKZdJ4RGMVUircVu8k1/R35/ecapce
         vNjH//B5pVcmnnqoA8V06DBpVgsqWn3ihYnNMru7SXfWCP1CIluAOkkVLNmDSgTbZHsa
         SbjQvvIxlZI6d7R+3BAbvzkmCJo+THbrvuStbDl/wfJZfzNs+TJp7y3PKQCXZs7DaUWZ
         jonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKT3g3xjVz+lJRO/NfyP1oKBqnxAQNnE0uZo/KDRS3Y=;
        b=N99lqVdLZ5msF5q1j9GL9/0O1i3Z5b+mA422uZ0mwXlgjNvSzktaf4khxChYKCUdIE
         Q/jbGBpoqmA1ZvKZX0kAD19nQXRrkVy4yZ2eY43bBtcaDAutkFoI0jvuXlk1AzjtaWpP
         64+B6N2mWkqoh7jliCDoG3FyFrS+HnHb1bo88Jo7c2mww5MR2bdblM29YJMBKSTzhxJ8
         2wnr9zRf2m/HFDqVsjHVVmfWnfp9LHmgRM0zYndBQ0aKvfTLC1kT2D0uNnO/De2NL4wA
         a0zdTSM74PCjWlM2sEIvW4cQfE6lag6S1wFVrVI3frqppuR4L/kQ/9C0Wmws/biDS5hT
         JVZg==
X-Gm-Message-State: AOAM533k1hApBMUPX3lUjxwbOqYlcrxpBjTqTUF8dTjR38Xa/SgA9E6h
        Utyy6gjOopI51d39Q5iefnKjsrDWP1hNT+rr4uQ=
X-Google-Smtp-Source: ABdhPJwXXI8ugYB3Qw3J9SABn9hKX7YCoamE8rIYxb51s8PRpLZ8Om6xV4m4PkPGAfpl0DsbBiTTnywiAoMy8D9+w68=
X-Received: by 2002:aca:2814:: with SMTP id 20mr1405654oix.89.1629430324660;
 Thu, 19 Aug 2021 20:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <YQmF9506lsmeaOBZ@unreal> <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
 <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
 <YQoogK7uWCLHUzcs@unreal> <CAD=hENcnUd-rTHGPq2DjyF7tDHVzCebDO2gtwZa9pw0M_QvaPA@mail.gmail.com>
 <CAN-5tyG4kBYBEaCDPGr=gUTNGkcoznMUy8e4BwCzWZkSPG-=+Q@mail.gmail.com>
 <CAD=hENdqho3mRy=gUSE-vuXzLvZPkwJ7kEFrjRN-AxLwvQP18Q@mail.gmail.com>
 <611CABE6.3010700@fujitsu.com> <CAD=hENezpPKyGFVB121fjhhniE02fwspULi5vaScU1dWcbY7gA@mail.gmail.com>
 <611CBA42.9020002@fujitsu.com> <CAD=hENcE12nKdRn04K9Zbd1CyOQureYb44fp9occ=R4P6XrgZQ@mail.gmail.com>
 <611D1A3E.20701@fujitsu.com>
In-Reply-To: <611D1A3E.20701@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 20 Aug 2021 11:31:53 +0800
Message-ID: <CAD=hENeYiTrfxDTAS9UkF8tn7=wa49H0DQuCBKeHpd+L6qM4SQ@mail.gmail.com>
Subject: Re: RXE status in the upstream rping using rxe
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 10:33 PM yangx.jy@fujitsu.com
<yangx.jy@fujitsu.com> wrote:
>
> On 2021/8/18 16:28, Zhu Yanjun wrote:
> > On Wed, Aug 18, 2021 at 3:44 PM yangx.jy@fujitsu.com
> > <yangx.jy@fujitsu.com>  wrote:
> >> On 2021/8/18 15:20, Zhu Yanjun wrote:
> >>> Can you let me know how to reproduce the panic?
> >>>
> >>> 1. linux upstream<   ----rping---->   linux upstream?
> >> rdma_client on v5.13<   --->   rdma_server on upstream kernel.
> >>
> >>> 2. just run rping?
> >> Running rdma_client on v5.13 and rdma_server on upstream can reproduce
> >> the issue.
> >>
> >> Note: running rping can reproduce the issue as well.
> > rping and rdma_server/rdma_client are from the latest rdma-core?
> Yes, use the latest rdma-core from
> https://github.com/linux-rdma/rdma-core (master branch).

Latest kernel + latest rdma-core < ------rping---- > 5.10.y stable +
latest rdma-core
Latest kernel + latest rdma-core < ------rping---- > 5.11.y stable +
latest rdma-core
Latest kernel + latest rdma-core < ------rping---- > 5.12.y stable +
latest rdma-core
Latest kernel + latest rdma-core < ------rping---- > 5.13.y stable +
latest rdma-core

The above works well.

Zhu Yanjun

> > Thanks
> > Zhu Yanjun
> >
> >>> 3. how do you create rxe? with rdma link or rxe_cfg?
> >> rdma link add
> >>> 4. do you make other operations?
> >> No
> >>> 5. other operations?
> >> No
> >>> Thanks.
> >>> Zhu Yanjun
> >>>
