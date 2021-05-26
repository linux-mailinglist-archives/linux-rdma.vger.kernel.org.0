Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D823913A9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhEZJaZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 05:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhEZJaY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 05:30:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730DDC061574
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 02:28:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b26so1528730lfq.4
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8w2Jy5Cq5f1+0bPseflhgS2YKhSClT6YBD1zn0iGl2w=;
        b=Kt4WvM55V3zfA2F7KwwNllmANkMG7JyTxcO36MM458Q+wkM7DyDCpjEztFJYQ11k+f
         uqpQ9jiwrXBrzP18Oq5cSSd7cJwkEvhcW76mlbl4ndMNwyRbq/xwAkOZu9ELqLMoJlH6
         UXzIQFDcVenaATOfEQ7CVgQDF9AP6HkHrxfBnH6YAEEQUzaRYFtSp9u/Tj4IR6139zVe
         Ev4L2JarwSHTZpwZF2syoEFcwNTAOIS4PfX2KNdO3Z7MYMz4D2U3AFEXDv0tfqsvGqdE
         RjeY1kEicHhONXnMbIeFb6vXWjhdkOxUIgtasW5voddcON28BNBmfRIuivUolPOQZvEK
         N6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8w2Jy5Cq5f1+0bPseflhgS2YKhSClT6YBD1zn0iGl2w=;
        b=LLH2vtspk1yO3cwqSabK9D4spxLjdzJ3v7GVod2C5Q6mqqhujfKLDmm09VUUpTsRZ6
         0FC/OYwkvpDa3bkQCxh+TRTLWrZpCyiBG6CkmMP4/NAvuX+e0RZDhgoP16sXHRKfseqK
         hV9GABH/1w6pPsTaviReJwVlddbRqVZ3OvQ4h9dH0zQXM86zIi6bmBDOOFkFk4gGT0w4
         inV2RkRhk/yUFWDyhXg5/bnknIbfnjEiTBxq4SzMSntbhjTAwhyk6ioCoDZcJmEymKEf
         bmrNe5uoMMu35U2f9urHqXMnf8Nz2yChMRou/RLwM4UWZ29X0STjqsKReGIdESLsyv/s
         17UQ==
X-Gm-Message-State: AOAM532httIhY0VbsJOF1AnTzSTeVfpUG4XEpj91Kx3zdHf9SmyN+liu
        qce89zbeDfvtkG0cE180c/2g8bpnjxrZlaORuu77Fg==
X-Google-Smtp-Source: ABdhPJzlT2ku9iM7YcKLlvQF7pFRvCalUJJAY2xu95Rbq6UoOk7hPgXOjIubGB4dXe6a6MQNuWtebNT6bKKNL/xj4f8=
X-Received: by 2002:ac2:533a:: with SMTP id f26mr1554551lfh.424.1622021331782;
 Wed, 26 May 2021 02:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210517091844.260810-1-gi-oh.kim@ionos.com> <20210517091844.260810-4-gi-oh.kim@ionos.com>
 <20210525201823.GA3482566@nvidia.com>
In-Reply-To: <20210525201823.GA3482566@nvidia.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 26 May 2021 11:28:41 +0200
Message-ID: <CAJpMwyg+SZjaYOi4z01gjphzzvVsG74dKkXzLQHG94=R5Lx3Dg@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 03/19] RDMA/rtrs-srv: Add error messages for
 cases when failing RDMA connection
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 10:18 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, May 17, 2021 at 11:18:27AM +0200, Gioh Kim wrote:
> > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> >
> > It was difficult to find out why it failed to establish RDMA
> > connection. This patch adds some messages to show which function
> > has failed why.
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index 3d09d01e34b4..df17dd4c1e28 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> >        * If this request is not the first connection request from the
> >        * client for this session then fail and return error.
> >        */
> > -     if (!first_conn)
> > +     if (!first_conn) {
> > +             pr_err("Error: Not the first connection request for this session\n");
> >               return ERR_PTR(-ENXIO);
>
> You really shouldn't be printing based on attacker controlled data..

I want to make sure I understand correctly. Did you mean that an
attacker can bombard a server with such connection request, which can
lead to uncontrolled prints, and possibly DOS?

If so, would a ratelimited print be better?


>
> Jason
