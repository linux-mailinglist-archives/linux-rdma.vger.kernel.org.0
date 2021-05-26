Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11650391CAF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhEZQJM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhEZQJM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 12:09:12 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD7C061574
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 09:07:39 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ee9so985409qvb.8
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uZqaN2o5VFcBSNv4DNdHlAt+8zkdTG3/0HZt6gpSAQ4=;
        b=Am1NJawxfGPgupgR1mUedktVCyH+OnSEn+RWf6l8AXGJoPpHNYEZMU3a8yLXN9XfeP
         /rrtit+WyGhexDBKFuueSN4S5ur+JBt6xFh5bYCn2IdPntnbRupjFuboiy3HItKam6f6
         ATc55+1fvISK00C6waAcFEe6k1khFqtWUOz9TxNkYgSoaLDKl01WaJcpnE/DMI1u+fkQ
         FN17LsrJ8BGep6tjJakahXuEB8RgoOL3EMWEJjnIFejmcle6uz5Ngv6che+jGrwbcceW
         iW0AUDccyTDiubQnBByCl28LKKq9efP7joZMDDxtbVUrAU1SxoLEUWCXLrQSt98gHM39
         q+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uZqaN2o5VFcBSNv4DNdHlAt+8zkdTG3/0HZt6gpSAQ4=;
        b=GK9bv40AIyRw0Ikm/QiRg3Mg/O0FYKlim1K9LI1d9MEOuJYM4mKkeayTzfMkSaHfJO
         gI8mNIIgNKRGopMphlFW+fjAGmRh0jq6rmLVAgUUr5STC25yi72oQU2Z++6Pg1KEUKPp
         e98x61nAtLtZd9iYaW+iYxaZC4ebJtsFDTIOMIs5bdpPxhvWJIeKcMH+Ew2NGu7r0w76
         2sAkcbUl+VSDXq/rZR64umdg66PxrRxgbZaeVJ9sfWAmWiJ+EAUgCAOHop2FQr3P+Siw
         ymbOcsbPaoqphWdGWsJEsAX9QPtgBILaqOECZSru391BPsT6Q78KcDJkg5C3D8GYUsKP
         VZcw==
X-Gm-Message-State: AOAM532ffxsxaigwFyPP1C8dXDoaycG0be6q4eeFqBensqogkmliq3Fl
        ZPbqPBeyhLMv3BTQBBkmvIsFhw==
X-Google-Smtp-Source: ABdhPJwwD04CggYC6pNohCyomAhGK6OX4BL+teA7ng5rt+BaN//m2j/klA9j5SCExlnsW1VlmOgqnA==
X-Received: by 2002:a05:6214:1083:: with SMTP id o3mr11253590qvr.9.1622045258357;
        Wed, 26 May 2021 09:07:38 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f8sm1812145qko.131.2021.05.26.09.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:07:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1llw4G-00FCjM-5t; Wed, 26 May 2021 13:07:36 -0300
Date:   Wed, 26 May 2021 13:07:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 03/19] RDMA/rtrs-srv: Add error messages for
 cases when failing RDMA connection
Message-ID: <20210526160736.GB1096940@ziepe.ca>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
 <20210517091844.260810-4-gi-oh.kim@ionos.com>
 <20210525201823.GA3482566@nvidia.com>
 <CAJpMwyg+SZjaYOi4z01gjphzzvVsG74dKkXzLQHG94=R5Lx3Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyg+SZjaYOi4z01gjphzzvVsG74dKkXzLQHG94=R5Lx3Dg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 11:28:41AM +0200, Haris Iqbal wrote:
> On Tue, May 25, 2021 at 10:18 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Mon, May 17, 2021 at 11:18:27AM +0200, Gioh Kim wrote:
> > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > >
> > > It was difficult to find out why it failed to establish RDMA
> > > connection. This patch adds some messages to show which function
> > > has failed why.
> > >
> > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > index 3d09d01e34b4..df17dd4c1e28 100644
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > @@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> > >        * If this request is not the first connection request from the
> > >        * client for this session then fail and return error.
> > >        */
> > > -     if (!first_conn)
> > > +     if (!first_conn) {
> > > +             pr_err("Error: Not the first connection request for this session\n");
> > >               return ERR_PTR(-ENXIO);
> >
> > You really shouldn't be printing based on attacker controlled data..
> 
> I want to make sure I understand correctly. Did you mean that an
> attacker can bombard a server with such connection request, which can
> lead to uncontrolled prints, and possibly DOS?

Yes

> If so, would a ratelimited print be better?

Probably

Jason
