Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA71496C2
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2020 18:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAYREU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 12:04:20 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35493 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgAYREU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jan 2020 12:04:20 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so5389871iob.2
        for <linux-rdma@vger.kernel.org>; Sat, 25 Jan 2020 09:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyX/+M4OKw5drSirNdKZc8DPF10ujeRyPZNWwSlKIAc=;
        b=WUt5M8jEe4U2Av11Dty6qI8MziMbHRkJRfV8DUCcUzGuqxPi0rziTZvo9eIm5yM6bO
         16rRAICB3wqSBD2Jl+2VIH+2U7KwuG1PPIlVqr+t1sHgcn7iyjSgZXlBbSh9LNUB2uDk
         IlVIEdjjXXovYAA1sflqFwUXXK2JTkl1W6xHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyX/+M4OKw5drSirNdKZc8DPF10ujeRyPZNWwSlKIAc=;
        b=UsqYiWQXKtEuzh+q0ZKu+jVGHsXEBHpON+aLAlMrJUI0uqJiRQnRJiKf0c7FQTZO1R
         Ik2pa26ghwa575mz6JjdGx2qtl2JrPcXF6MjqDZkuo/BA1uAjrvtMyCA/kXNV1mKBlZv
         e3LPfofz6N4ucRTCPwh9/OTIakop3dJGIraNf2rr1XJcwpFu0cIo0XXx8LFLzVIrlNKY
         1r1sfhFQv32W5n1aduirIItWmCZU+ZFqH7/wwQjj4qzg6iSUtqEF30D+LiLEtTpzIrVe
         MOcbvNvXMMRZ7EOKxxxDvfNlU+geX7Ksq47UQhuCIB0/jUvwWrzxwS8qe9vylc/qyyhP
         93kA==
X-Gm-Message-State: APjAAAU1hocqlKW6Zysp3hI38QId4vNKfhlbsBQV8uFyb8cPfq5xUnjX
        W7gEuzOBUIB3c4pnNlHP6QwKtx3oAtz8GOC06o5DzA==
X-Google-Smtp-Source: APXvYqzKvda/2nqz4tTSHmw3ATlA1ev+OxRrm8bTPStut7WK6uvMoSk19R3sxR+96CyC3c2knZfUXXZVNZfai58rMzE=
X-Received: by 2002:a6b:7113:: with SMTP id q19mr6753140iog.87.1579971858259;
 Sat, 25 Jan 2020 09:04:18 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com> <20200124112347.GA35595@unreal>
In-Reply-To: <20200124112347.GA35595@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Sat, 25 Jan 2020 22:33:41 +0530
Message-ID: <CANjDDBjJygjcbbwDFtwVS--GF5YtYAiZL78_jiqHf+TMkQ7j+g@mail.gmail.com>
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

On Fri, Jan 24, 2020 at 4:53 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jan 24, 2020 at 12:52:39AM -0500, Devesh Sharma wrote:
> > Restructuring the bnxt_re_create_qp function. Listing below
> > the major changes:
> >  --Monolithic central part of create_qp where attributes are
> >    initialized is now enclosed in one function and this new
> >    function has few more sub-functions.
> >  --Top level qp limit checking code moved to a function.
> >  --GSI QP creation and GSI Shadow qp creation code is handled
> >    in a sub function.
> >
> > Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  13 +-
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 635 ++++++++++++++++++++-----------
> >  drivers/infiniband/hw/bnxt_re/main.c     |   3 +-
> >  3 files changed, 434 insertions(+), 217 deletions(-)
> >
>
> Please remove dev_err/dev_dbg/dev_* prints from the driver code.
Sure I can do that, are you suggesting to add one more patch in this series?
I guess it should be okay to follow the hw/efa way to  have debug msgs still on.
>
>
> Thanks
