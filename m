Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5EEB65E4F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 19:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfGKRQ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 13:16:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46314 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfGKRQ4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 13:16:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so3341101plz.13
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCizNin/YuQ8CqFX75d8uBly25uZLZWRMwnAi+o26d8=;
        b=mDkIXhZDwmAfFt75IUi6h+IS+ueAuxHBdiqTKeKrZVFrNA1vDM495IZLbRasMReS9B
         0B+tu/TZrug73T7zVlHPsmzJKnHRaZhR1T0Xyhp8uiAHroHrxDhauOxrM6dtguzXEGfA
         vmmI7gxQqCyq8iBVJ1YZ9ITf8Z9Mu8B5s1ux6EdAjYpRjNpr35dBTesy3Mg/AMGq0Jd8
         dh6VQSIXUb9+5SRfu+ZWQE2BmU8oVgi0tDM7E6q7TCup0r5pKrddHpi92sJtkWJfX7a0
         h7h5+RcJJOArAIfQjvM9lqj/n7BCh5WeDau6otU3NskqphB816ftN2cVrUZxLZd4t7Aq
         7Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCizNin/YuQ8CqFX75d8uBly25uZLZWRMwnAi+o26d8=;
        b=scJvSeLN8fmt/N5s80gI2wh8EcSPPK9ZkWaVh5MgxnkCOOZKZQy5hJ+frIYn5CrXUx
         BUJTZV6AZOqEBsESHEWUW/o8rz6xWtmFalk9C+4Sn4PErdPT71SC2hfW2pAuPzhiUGSo
         XzKArSVBV7zHQ1YTvTNuO9WmvSvxJd444IauO0C/3WfMKHYYWSoOMJJqv1uJ2rKx14+j
         0OeaiNo2tDiZSdhkmMkBaKN2YlDqeOBOQIAdc5QSZmYv83cEqxRk9YSMHtnbMpRObP4g
         vKJc3jUL6zlTDlYotLB5DfyX4upNaaAKoxRJMhRh/IIUMZr0QSCo2iFT44uQ01lJXtoP
         NwHA==
X-Gm-Message-State: APjAAAXbsIPACLTTGPalFgLpxz3U0H8xO4xy2z/T73qxEb6Q41S6fNRo
        QnJpoQI0kwxYyI4CZlDK+gA8HOuV/zXzMC44LJ5fvQ==
X-Google-Smtp-Source: APXvYqx+LKdPWY7QUEwDHjZ4T8lEaM4hx232WgllbGz/r5PjAl6YmOZzCwbLv8i25PkI8phRZL4RlpXGPVWWtpDKC1A=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr5789107plq.223.1562865415492;
 Thu, 11 Jul 2019 10:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper> <20190711133915.GA25807@ziepe.ca>
In-Reply-To: <20190711133915.GA25807@ziepe.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jul 2019 10:16:44 -0700
Message-ID: <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 6:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jul 11, 2019 at 01:14:34AM -0700, Nathan Chancellor wrote:
> > Maybe time to start plumbing Clang into your test flow until it can get
> > intergrated with more CI setups? :) It can catch some pretty dodgy
> > behavior that GCC doesn't:
>
> I keep asking how to use clang to build the kernel and last I was told
> it still wasn't ready..
>
> Is it ready now? Is there some flow that will compile with clang
> warning free, on any arch? (at least the portion of the kernel I check)

$ make CC=clang ...

Let us know if you find something we haven't already.
https://clangbuiltlinux.github.io/
https://github.com/ClangBuiltLinux/linux/issues
-- 
Thanks,
~Nick Desaulniers
