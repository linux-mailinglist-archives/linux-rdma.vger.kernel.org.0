Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73D359A74
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Apr 2021 11:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhDIJ66 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Apr 2021 05:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbhDIJ56 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Apr 2021 05:57:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64E0C0613E2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Apr 2021 02:57:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r12so7728015ejr.5
        for <linux-rdma@vger.kernel.org>; Fri, 09 Apr 2021 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9vjeDIq4ZMTrGb//SJ+YMICh7YJ4BNlbXxJJdfevNY=;
        b=bzrR3or/bP+YKw44BmfouMLKsWxi/3nQ1zha+Rff7KCJOo1aFAmcJkdMV00CfHTIUl
         9lKVQSHr0Q5qcEDNuhxY+5WnCCr/4nFthcF69kyLCON8ZTTm+dxFO9ZlewBFxmZbYiMk
         9pQukfN8aRh80kvih6BYaYPJL33mSrzBWO8J18oSNw3V11LJZp1YiAXg1DHjYu1eQ94L
         QAkVCJI7Olch7e+ovsUR0Bf59PJwOM0kp+aPztlrmFgwccqH1OUIGYKBlIRZN3myPzBp
         JLxcmBmXcDOUkdl8gSQdo3xpeKCiBfkJcvyzmb8ig/qMy2+UXKioznNrL5jKx2TeWJXN
         7tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9vjeDIq4ZMTrGb//SJ+YMICh7YJ4BNlbXxJJdfevNY=;
        b=t7euFFe4nP2xSZ8jihW3zmS1ojPzX4lR2hL9YDHrTATtysN0VwDAGhf9mv2Zfcw/Po
         KVmulwZmaoX3KePJuFRVrrh71ygH00NRbHUMqdLgK8FoexRoNEXgf2vfSoquYq+XILnc
         I04kCOZMfFPbpkZPv/zf45PFR3Ih1NOmaMHrR20eNtTkHRPcnel/P1aBCBoz8Pu7Pmmt
         zGjsB6H35xjgjdyLnyrdgqTteZlMJxVyqViEQ1fmxwJzpKAc5uv3qDtFrEVQ607ix0JI
         h2Ek9w46DHPV3oG4hm5Qhgi/5jv/A+msqEEJXya8oyH5zEat17X/pYtb6/IL0RIjOoMh
         0a6A==
X-Gm-Message-State: AOAM530Rfqx95lhgjgN4rBHu2/hfppUM2Zjz/UqtZRfTHhrUn1/aRMrA
        wQeVymTDz5PvSiYJXCxBejaNhrqwYppQNgsDnIi+Dw==
X-Google-Smtp-Source: ABdhPJz/pst9Dtqs2xAaBLpTXdTg7PpZ4UZL3ajzn3xUUfKnlbgflz9oKsHbqZ1eMrpazll2Z6FMoB0mtovjO5QpJ7c=
X-Received: by 2002:a17:906:f42:: with SMTP id h2mr14393452ejj.317.1617962264382;
 Fri, 09 Apr 2021 02:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210406123639.202899-1-gi-oh.kim@ionos.com> <20210406123639.202899-2-gi-oh.kim@ionos.com>
 <YGxXD/TODlXHp2sK@unreal>
In-Reply-To: <YGxXD/TODlXHp2sK@unreal>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Fri, 9 Apr 2021 11:57:08 +0200
Message-ID: <CAJX1YtZ9DPHzdBBVPff2+=eRMRPnVXvzccMA1h6tUj1vYa=Yrg@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 1/3] RDMA/rtrs-clt: Print more info when an
 error happens
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 6, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Apr 06, 2021 at 02:36:37PM +0200, Gioh Kim wrote:
> > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> >
> > Client prints only error value and it is not enough for debugging.
> >
> > 1. When client receives an error from server:
> > the client does not only print the error value but also
> > more information of server connection.
> >
> > 2. When client failes to send IO:
> > the client gets an error from RDMA layer. It also
> > print more information of server connection.
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 33 ++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 5062328ac577..a534b2b09e13 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -437,6 +437,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
> >       req->in_use = false;
> >       req->con = NULL;
> >
> > +     if (unlikely(errno)) {
>
> I'm sorry, but all your patches are full of these likely/unlikely cargo
> cult. Can you please provide supportive performance data or delete all
> likely/unlikely in all rtrs code?
>
> Thanks

Hi Leon,

Let me check my colleagues if there is any data about it.
I will inform you soon.
