Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8511914D652
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 07:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgA3GFN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 01:05:13 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34884 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgA3GFN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jan 2020 01:05:13 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so2107439ild.2
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2020 22:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIo/MVYk7IdBn5Jp+k6hflssVClGHGjOFXzQtXEiXkg=;
        b=YkuT0xc6uSlbFdjVHqL6EcdDyHORMR83b1/+UFy1CnZ0cfvYxvgPwr36DqEI61B5iR
         X+1E0v7txRDOXAjTgCMd/V7KW2UyW1Iiakbh2xPjUc4nJd27piGwW7rTGsZ0O4ingNBc
         w+z+lEplol01wVqVkNkf6WCljnc8/etFRwKcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIo/MVYk7IdBn5Jp+k6hflssVClGHGjOFXzQtXEiXkg=;
        b=eufEPl40HJqomA9oEgtV+soHbAvL73EKTZygbjLEnYyl1cm7KzrSQn58XwUFTAvgQP
         jO+xeSIIqAHDoVut1YyPc4rqmTFKc8NynAPGc6gZ3QSUs6B7bexR3BUQTTPWjfad/UyZ
         kviFK0ZIYYyJj+dQ1077kXmMYsrhQDQIG9mUGcxnmLgl5nGlRSHhRHpcAIE86HGA+WLN
         Rk8H16WMg55iuTgN0rKyjantyf03RIXL3tX5+3gmEg8KpepfRp0TPSk1wLPk5FwQtHQf
         LXB4+oRBk+0VzzTP/ZZoJdZprmPmpTvefc02kIWRhMCqPfMFkcKN+p00CccaiAkdwKsq
         cKPQ==
X-Gm-Message-State: APjAAAXka6pFzPYUVaiYrOzExh4evdIlayk01+qouv6yI5cwUoSbDebK
        3wfragG74lGu4295OmKEwdhSkw+E5zaEwow8TIUtWUj5zkI=
X-Google-Smtp-Source: APXvYqzcIX0fz4XVdm0ALjd0Fnc6ccEYTk7VjHwIkofdNRw/rrX0a5jLnW9Z3qcMuXxHETfCW7EsR92PBvHNdm501BQ=
X-Received: by 2002:a92:c703:: with SMTP id a3mr2786063ilp.89.1580364312470;
 Wed, 29 Jan 2020 22:05:12 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
 <20200124112347.GA35595@unreal> <CANjDDBjJygjcbbwDFtwVS--GF5YtYAiZL78_jiqHf+TMkQ7j+g@mail.gmail.com>
 <20200125185045.GB2993@unreal> <CANjDDBh=v2xzx42uX+VkBstBdeBptDrL0wMg2UgL6nUigd3qmA@mail.gmail.com>
In-Reply-To: <CANjDDBh=v2xzx42uX+VkBstBdeBptDrL0wMg2UgL6nUigd3qmA@mail.gmail.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 30 Jan 2020 11:34:35 +0530
Message-ID: <CANjDDBga=DX9kGySOvJbinKXifaCOUahZxETJZp1h++BhzBckw@mail.gmail.com>
Subject: Re: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation code
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 1:09 PM Devesh Sharma
<devesh.sharma@broadcom.com> wrote:
>
> On Sun, Jan 26, 2020 at 12:20 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sat, Jan 25, 2020 at 10:33:41PM +0530, Devesh Sharma wrote:
> > > On Fri, Jan 24, 2020 at 4:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 24, 2020 at 12:52:39AM -0500, Devesh Sharma wrote:
> > > > > Restructuring the bnxt_re_create_qp function. Listing below
> > > > > the major changes:
> > > > >  --Monolithic central part of create_qp where attributes are
> > > > >    initialized is now enclosed in one function and this new
> > > > >    function has few more sub-functions.
> > > > >  --Top level qp limit checking code moved to a function.
> > > > >  --GSI QP creation and GSI Shadow qp creation code is handled
> > > > >    in a sub function.
> > > > >
> > > > > Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> > > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > > > > ---
> > > > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  13 +-
> > > > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 635 ++++++++++++++++++++-----------
> > > > >  drivers/infiniband/hw/bnxt_re/main.c     |   3 +-
> > > > >  3 files changed, 434 insertions(+), 217 deletions(-)
> > > > >
> > > >
> > > > Please remove dev_err/dev_dbg/dev_* prints from the driver code.
> > > Sure I can do that, are you suggesting to add one more patch in this series?
> > > I guess it should be okay to follow the hw/efa way to  have debug msgs still on.
> >
> > It is ok to use ibdev_* prints, it is not ok to use dev_* prints.
> Okay, I will add a new patch to this series
> >
> > Thanks
> >
Done added a new patch in V2 of this series.
> > > >
> > > >
> > > > Thanks
