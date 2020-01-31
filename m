Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3392D14EFE3
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2020 16:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAaPlU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jan 2020 10:41:20 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37182 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgAaPlU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jan 2020 10:41:20 -0500
Received: by mail-io1-f68.google.com with SMTP id k24so8629886ioc.4
        for <linux-rdma@vger.kernel.org>; Fri, 31 Jan 2020 07:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TShKAwQdBBlnopJ5mtRi2HgyMpjheFBfurHhQQ8X8jk=;
        b=S3ZPUew4G1hKwEoik6cE5zU7vfRXVrf/GBfnGosdfcrI64zRiPGe3TPWDrbh03Qx6g
         tad0LY7gsT3/vpONuCT7ol4ctq0sThTzIUGzmW973ca8qCIaME6I0ndrkJxeqMgr0vd3
         b4Y1ffhAK9z/ErDfLHkWMek0Z0kVVCY4M4w90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TShKAwQdBBlnopJ5mtRi2HgyMpjheFBfurHhQQ8X8jk=;
        b=uXVeppDwf6fk1iwtv3p8H/7GBh53vxNLKKjvnX1bOgsG0gQ3Crm27b8cFDryHlpMll
         uKD8vLoSaJS/bmWZxgcyJatytuIrV7+QEscTfeBlb+ifxhBTvPnLLs/yPpQj8Wd4lupE
         z9uJo0mRvDyuGP/2HZ5Nwc3ce5jlVF7yl8CzGL8GF3gS5kzBVA+8uPUrpcZroXEw4WvT
         b/THUa5c5/OivVnafouPDxx4IhkyYSx0vj6eC7RPqU1TIVD1gHbjkqlH63M3OZpxpuTf
         tjCZQSejGCgxE7/1sJpaqGwEwDQrtlG2Z3HBG3Ig9zsHk4gU1jP9tLbgOwYr1IRRc/sd
         ns1w==
X-Gm-Message-State: APjAAAWV5RbmcB+u6U7npi+10Q2U76aoKOWTfqE0jDnvbDtQCN4gVSqo
        UVqU/qna9v1mdHXMymTqSshuOytYcC0NVl+cghZqT50M
X-Google-Smtp-Source: APXvYqxwiRxVKzJLaXLF/uDuCrpAI/ipG7X8uf8Yk+13bJu2AEdsbnpMFbd4EnnTBkB4nH+ZWOZD1+soL42jU4/SAps=
X-Received: by 2002:a02:13c2:: with SMTP id 185mr9158101jaz.0.1580485277391;
 Fri, 31 Jan 2020 07:41:17 -0800 (PST)
MIME-Version: 1.0
References: <1580466773-24342-1-git-send-email-devesh.sharma@broadcom.com> <AM0PR05MB48663242B41CEB51D3535AF9D1070@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB48663242B41CEB51D3535AF9D1070@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Fri, 31 Jan 2020 21:10:41 +0530
Message-ID: <CANjDDBgtVSLK7sBLLSr3-RBt7W+TeJeSo=Df+wDMS6mhowudgA@mail.gmail.com>
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

On Fri, Jan 31, 2020, 16:30 Parav Pandit <parav@mellanox.com> wrote:
>
> Hi Devesh,
>
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Devesh Sharma
>
>
> [..]
>
> >  static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int
> > tbl_len)  {
> > +     enum ibv_gid_type type;
> >       union ibv_gid gid;
> >       int rc = 0;
> >       int i;
> > @@ -175,8 +185,16 @@ static int print_all_port_gids(struct ibv_context *ctx,
> > uint8_t port_num, int tb
> >                              port_num, i);
> >                       return rc;
> >               }
> > +
> > +             rc = ibv_query_gid_type(ctx, port_num, i, &type);
> > +             if (rc) {
> > +                     fprintf(stderr, "Failed to query gid type to port %d,
> > index %d\n",
> > +                             port_num, i);
> > +                     return rc;
> GID table can have holes depending on how IP addresses, vlan configured/removed.
> ibv_query_gid_type() is masking the EINVAL error with RoCEv1 type so here return is ok.
> But as good practice, instead of bailing out the loop, if it returns failure, skip the particular GID entry print.
> This way rest of valid entries can be still printed.

Okay, will send V2 shortly.
