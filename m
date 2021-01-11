Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DD92F1CF6
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 18:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbhAKRsK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 12:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389895AbhAKRsK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 12:48:10 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9324C061794
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jan 2021 09:47:29 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id f132so127522oib.12
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jan 2021 09:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+v4loQqoKnSU01DgtTKZQGSh8k+FidOwtUdREUyZeI=;
        b=KA/O4HM+2QgVEYB9kebla4ZOxx0dvDk9Hbf3kFJNxD/x++j+7IhrRtYBqYUv43RuN/
         DqvXOHw8pecKm+Sdf7fmQIyJydFOjAO+EwnkgTR/DvXYht/SMy3+UZvmJl18TgK3xhXB
         utueB43a4O1JoLC3RqTcMPaqoKDCQu6gq6rTSJgOemiLal/XBBBXfe8uQwJcOqB4UcIZ
         WsW3NN66DoNalxNtFM5wSJm8mw90Jk8Ofs9F/JX7SluBwebqyz2sBWP6n2HhhCc2xMaN
         7Pmlf8Wjvrh/SpsAoiLSD3eWZdS4ZXmUzMRv/5/CpD48ifbYR0pOa2SBGUHdf9HSJOCJ
         uSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+v4loQqoKnSU01DgtTKZQGSh8k+FidOwtUdREUyZeI=;
        b=dCGVR2NW7QW+/yhhbK+kckviwEQSwmOwb8rpITwzoV9MQyn9RabvghW4bXlBLaUSiv
         hUlzAlgT+8XQTh4jI6FlEUCK5qgFZtDMFKAvebC8G2T9Bfph/G8bx5JXv+WsKSw8+zhC
         jhu0FO0gNss8HY3NyszGqva2jN6STZEWfqACidcbUiwoyXLRBL3+dAHSawsHQtnKkSp1
         kgw+IDEZb2ZEwrogIM4tHjIl3eeGFrcK/HifdCZguc1f4PFTPtf6xBtQvuVQIkmN7zXp
         WjJmTWz9Rddgcu3rw4v03OBjW1esA/Y1SJnm+L7qkKnQqNRq/8K+i2EgXPwmNeXFq1V1
         bbqA==
X-Gm-Message-State: AOAM532LOqskEKeFlC4ANR7BIvOfQGcZj6WaA4WjWY5JqPY2E0CJ6bdV
        AUe+yBt3ijoH+Gvam1CuYjDxI7yDbeq2qaO490s=
X-Google-Smtp-Source: ABdhPJzzsn/agYq0JoX8BF6YJaVV8lO0HKlPCKKUF4t7McrULCj/fgpm6BlBIYGnvjZdinNDvOpPnMpfKyRKizL96MY=
X-Received: by 2002:aca:6202:: with SMTP id w2mr312851oib.5.1610387249370;
 Mon, 11 Jan 2021 09:47:29 -0800 (PST)
MIME-Version: 1.0
References: <1608067636-98073-1-git-send-email-jianxin.xiong@intel.com>
 <MW3PR11MB4555CCCDD42F1ADEC61F7ACAE5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20210111154245.GL504133@ziepe.ca> <MW3PR11MB4555953F638E8EDCD9F2CA90E5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
In-Reply-To: <MW3PR11MB4555953F638E8EDCD9F2CA90E5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Jan 2021 12:47:18 -0500
Message-ID: <CADnq5_NTwynVt=ZPF-hiNFaWfEWiDnoTQCS0k1zx421=UAFSNA@mail.gmail.com>
Subject: Re: [PATCH v16 0/4] RDMA: Add dma-buf support
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 11, 2021 at 12:44 PM Xiong, Jianxin <jianxin.xiong@intel.com> wrote:
>
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Monday, January 11, 2021 7:43 AM
> > To: Xiong, Jianxin <jianxin.xiong@intel.com>
> > Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> > <leon@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian Koenig <christian.koenig@amd.com>; Vetter, Daniel
> > <daniel.vetter@intel.com>
> > Subject: Re: [PATCH v16 0/4] RDMA: Add dma-buf support
> >
> > On Mon, Jan 11, 2021 at 03:24:18PM +0000, Xiong, Jianxin wrote:
> > > Jason, will this series be able to get into 5.12?
> >
> > I was going to ask you where things are after the break?
> >
> > Did everyone agree the userspace stuff is OK now? Is Edward OK with the pyverbs changes, etc
> >
>
> There is no new comment on the both the kernel and userspace series. I assume silence
> means no objection. I will ask for opinions on the userspace thread.

Do you have a link to the userspace thread?

Thanks,

Alex
