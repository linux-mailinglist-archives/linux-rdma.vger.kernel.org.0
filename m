Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2553DDAF1
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhHBO0O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 10:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbhHBOYQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 10:24:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FC0C09B132
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 07:16:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m9so24101137ljp.7
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKR71WZG0Mz69wwsAVJWvm3+d0jX4yT+6Xbar+lLW9A=;
        b=HyvRBKBTLAZ7m2LF0yKnrgQreU1tUkn885VW0OdFozO8yI0A34/UR7pw0cnC+HgAm0
         bCNufq4k3thY1LlQnFsFGrXV4ujT2/uQql56GeyQhARMvqD3JBiZz5fwCBODT31/is3J
         NIsP2bC8n7q42oIXBSeZJ+EPCSm+aijE9sh357o2FFbZtV1GO0lluM3Hh3wOXyVJ4iRe
         MP8O5jm2wvLFUxD+pPKneg6dvNyjfoxmS05plTFJ5pR67g/vIaUrZUB4IMVIUucDn0sr
         0U03dysZy7orfqNz1fUp/z2zxrByk+LHH+cCXpNeGtDPU3u9r2AFWiRlPzTkM0MmZbq6
         mPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKR71WZG0Mz69wwsAVJWvm3+d0jX4yT+6Xbar+lLW9A=;
        b=Csc+e4LLXofZciLT0kiujCQjII8zESOux/5M+mY4uZ6Siyw83sEc7A+8BV71n5RlMg
         /I1/kai62WPsN2PWnxstHnlQdcdCQAdMCyQHhtUnW1rqfdwRX/DHKRYzUCyYRzhf23G/
         NT73ktJo3KNUEYipBLIl1K5DwbnusX7oFE5l3SF4ylEAub+/tFjUTFnBg+hvC345Sqjq
         eFcgB8tyZsAJtUGiGC2cKTwkEaOtQWah/nttpLpbIK0Ej78VqwteZIFn6vD/9hr1nPN1
         inLrOPQFYM28U9y6jUg4liyTYSPU8aSr+QfkfXbkP9azifKIIFgSEJEcvsLiQOOUfs6H
         SXYg==
X-Gm-Message-State: AOAM532SYJNZQOO960XSYYp7q3eYKrCwsN6p0A1BuQvMEB6rNwKPLGX1
        ya6ZJ6mK8/Ghbs3klFhpyH8u6kgrO6EX3ZVScTrJJCyYtcU=
X-Google-Smtp-Source: ABdhPJxjMccUQ64Lh4BTlKk17APS/Dij39lWs52otW0g648/dkUZpTJ9yJu1nU3h5+EaoOx6Qf9fjHytrKW4UMBBnqo=
X-Received: by 2002:a05:651c:93:: with SMTP id 19mr11272057ljq.421.1627913815010;
 Mon, 02 Aug 2021 07:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210730131832.118865-1-jinpu.wang@ionos.com> <20210730131832.118865-11-jinpu.wang@ionos.com>
 <YQefqauic265deCw@unreal>
In-Reply-To: <YQefqauic265deCw@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 2 Aug 2021 16:16:44 +0200
Message-ID: <CAJpMwyj-sNQ0puLr-kVWipTr2=zsc+6rsEBcLLTxKQXm20pC7Q@mail.gmail.com>
Subject: Re: [PATCH for-next 10/10] RDMA/rtrs: remove (void) casting for functions
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Gioh Kim <gi-oh.kim@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 2, 2021 at 9:33 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jul 30, 2021 at 03:18:32PM +0200, Jack Wang wrote:
> > From: Gioh Kim <gi-oh.kim@ionos.com>
> >
> > As recommended by Leon
> > https://www.spinics.net/lists/linux-rdma/msg102200.html
> > this patch removes (void) casting because that does nothing.
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
>
> I would write the commit message differently:
>
> ------
>
> Casting to (void) does nothing, remove them.
>
> Link: https://www.spinics.net/lists/linux-rdma/msg102200.html
> Suggested-by: Leon Romanovsky <leon@kernel.org>

Thanks Leon. Will change and resend.

> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
