Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAFB14F030
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2020 16:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgAaPyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jan 2020 10:54:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39014 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgAaPyC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jan 2020 10:54:02 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so8669046ioh.6
        for <linux-rdma@vger.kernel.org>; Fri, 31 Jan 2020 07:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RykGlF+AYDOu7d4iLsy+CTTcBpK+b6FTtu0QGGuwg2g=;
        b=gWHypgl2B1Abx7J8mgH7HY6PJ7WHagMWWcYGjaZ8LrKI1JdqvYnc8NAhbh3IvkXwy4
         R9LFaWf/nFtUG9ELfjMTLM9CgxAY7+6bIWIBttVtNwzECeLqhcmyVIeA8b6UaDrMNiVy
         68zkeXd4fQOanXfG8jRQIdxZKA5/JnU0K/TWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RykGlF+AYDOu7d4iLsy+CTTcBpK+b6FTtu0QGGuwg2g=;
        b=S3CeBCTYzBmU2xg65ZbQtNETnM2fPMfnSDig/GZAoXcDlXQ5LnLpI6yCTi9cDoCUZb
         Fsa5ndxEYVY26hPNzRFqIZxqpAgBxKsWjuOVrc8bUNplollbCZIhZLY9pXOoELWJJsCW
         y3MoqAAe5ct3a2y3cOyG4+124NVna0VE7yNcfWgTYtSdryOz1FziVVl9PDEn+0zVMJQG
         YKeSpCqz+EvP5upS/oN8PUcl0IyGjaP7hkW7cHMHsRDX+lmgggCKTvSLHj3MAl+xmiBB
         Be7C3T3zdIJTc1887ysqevxg/g3lbjyr1W0k39hD27bW+MUrgXMU1VBy8n/iZXCCAkyw
         K/LQ==
X-Gm-Message-State: APjAAAVd+GvTJrVkZe9vlrgFr3+53iuyT9dgtjrRleIa1BwLSlYoQ2bx
        KNN0f8zHCbujwpDBtIcoykqcGWtL7uDlpT11A0TvDBLd
X-Google-Smtp-Source: APXvYqwKroFhgJd6570A5B/qCHHfjVLLriQ6sIddo1klBHViUykUDWP0t9b1bfJEkaTFsfAJUmjaMKgVc4/mpm6w2NY=
X-Received: by 2002:a6b:c9c6:: with SMTP id z189mr8743270iof.285.1580486041689;
 Fri, 31 Jan 2020 07:54:01 -0800 (PST)
MIME-Version: 1.0
References: <1580466773-24342-1-git-send-email-devesh.sharma@broadcom.com>
 <AM0PR05MB48663242B41CEB51D3535AF9D1070@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CANjDDBgtVSLK7sBLLSr3-RBt7W+TeJeSo=Df+wDMS6mhowudgA@mail.gmail.com>
In-Reply-To: <CANjDDBgtVSLK7sBLLSr3-RBt7W+TeJeSo=Df+wDMS6mhowudgA@mail.gmail.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Fri, 31 Jan 2020 21:23:25 +0530
Message-ID: <CANjDDBiZaSPhZk=G4wC4dvP6oULOXaqKLq2gWJWm-jk0xyp=mQ@mail.gmail.com>
Subject: Re: [PATCH] rdma-core/libibverbs: display gid type in ibv_devinfo
To:     Parav Pandit <parav@mellanox.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 31, 2020 at 9:10 PM Devesh Sharma
<devesh.sharma@broadcom.com> wrote:
>
> On Fri, Jan 31, 2020, 16:30 Parav Pandit <parav@mellanox.com> wrote:
> >
> > Hi Devesh,
> >
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Devesh Sharma
> >
> >
> > [..]
> >
> > >  static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int
> > > tbl_len)  {
> > > +     enum ibv_gid_type type;
> > >       union ibv_gid gid;
> > >       int rc = 0;
> > >       int i;
> > > @@ -175,8 +185,16 @@ static int print_all_port_gids(struct ibv_context *ctx,
> > > uint8_t port_num, int tb
> > >                              port_num, i);
> > >                       return rc;
> > >               }
> > > +
> > > +             rc = ibv_query_gid_type(ctx, port_num, i, &type);
> > > +             if (rc) {
> > > +                     fprintf(stderr, "Failed to query gid type to port %d,
> > > index %d\n",
> > > +                             port_num, i);
> > > +                     return rc;
> > GID table can have holes depending on how IP addresses, vlan configured/removed.
> > ibv_query_gid_type() is masking the EINVAL error with RoCEv1 type so here return is ok.
> > But as good practice, instead of bailing out the loop, if it returns failure, skip the particular GID entry print.
> > This way rest of valid entries can be still printed.
>
> Okay, will send V2 shortly.

Is this what you want:
if (rc) {
   print msg;
   save rc in tmp var;
   continue;
}

in the end after loop over
return saved-rc-tmp-var;
Alter saved-rc-tmp-var accordingly for good cases.
