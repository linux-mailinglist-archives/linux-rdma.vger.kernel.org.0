Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873E0158141
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 18:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgBJRVK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 12:21:10 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34645 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBJRVK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Feb 2020 12:21:10 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so8467925iof.1
        for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2020 09:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w401yAJOcr28U6VpoNC5T/zLWt9iA6oymLr2FNlpEzs=;
        b=FDeon6mlvrIgPHY+fvHrcHDAeDDLcPdeRSzHxjtc/eBh6XcWMtRieu19V+OqLIWhcI
         F1aXIXhnvfrgioyd9DdYGYsM/2j2txGYdS3mrSKvvQgO6pXGisnrMaBU1/FBIiUbOp/S
         xGZqaJQ6zPpz17XTsKx0pRRYITx93cahEDzDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w401yAJOcr28U6VpoNC5T/zLWt9iA6oymLr2FNlpEzs=;
        b=kvPlzHYPqytH3ibW4WZy4JM3vl5r7Mj5RkeTqNP2b1svj/X33GUZxP6ekV+jDOgLw3
         qD0r8rVNAqIX365g2vTnQLA0iWCSKhkP28OsyCn9IqnTGy1Wtziyy32jXByB/YWg8NzA
         rAnMttRUQ8jN/YsuGD3ewOkLhhwNzqO5Dr5fxgZVc3QEV/OjJGf7Z3CCmP5Z2krd5mtt
         /VKwSGzpYat1QE4rj/qdwTag0YFbvMNbb2kWNSMU3/qsuKL1rqBYaZZzn9+dwBF7/Z3P
         2VZLdEiCP9mYhcakI4cgJPKThj7MgSZqoILWBslCiJCxxVezUcrl4W4ZS8+WXA+HWdxd
         a1hw==
X-Gm-Message-State: APjAAAXAifFPKcmPYjm6zXByGMXq60RUNRF6h4qbBjp4wL8M59aHalL4
        IjvqyCQNHIxlUq2G4igmlSmiC4xXQzMv40dSU6reZA==
X-Google-Smtp-Source: APXvYqzpt/fZiJOKYd0fBMJ0/vEv3+m9OZeZ/x37luCdqlq8UgZoCJvvSjJDTSKiuiUE0I6AA58mpmNGEqrCmKe7CLk=
X-Received: by 2002:a5d:8908:: with SMTP id b8mr9663906ion.89.1581355269808;
 Mon, 10 Feb 2020 09:21:09 -0800 (PST)
MIME-Version: 1.0
References: <1580967842-11220-1-git-send-email-devesh.sharma@broadcom.com>
 <88498668-9723-9695-b4e7-3384dde76c36@mellanox.com> <CANjDDBgdX1REcRRKKdqaWNR2Y+Om-Kwb0vm_JuP703m0VLe_6g@mail.gmail.com>
 <20200207141339.GD4509@mellanox.com>
In-Reply-To: <20200207141339.GD4509@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 10 Feb 2020 22:50:33 +0530
Message-ID: <CANjDDBiLeXjZad_QUvoJ3YbEy6-_0zKs=epqZ_tdSnbY+Y5Cfw@mail.gmail.com>
Subject: Re: [PATCH v7] libibverbs: display gid type in ibv_devinfo
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Bloch <markb@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 7, 2020 at 7:43 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Feb 07, 2020 at 06:07:34PM +0530, Devesh Sharma wrote:
> > > > -static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tbl_len)
> > > > +#define DEVINFO_INVALID_GID_TYPE     2
> > > > +static const char *gid_type_str(enum ibv_gid_type type)
> > > >  {
> > > > +     switch (type) {
> > > > +     case IBV_GID_TYPE_IB_ROCE_V1: return "IB/RoCE v1";
> > >
> > > You call this function only if link layer is ethernet, why do you need the "IB/" part?
> > Jason do you have any suggestion here, "IB/ROCE v1" is the standard
> > string rdma-cm and
> > /sys/class/infiniband/bnxt_re0/ports/1/gid_attrs/types/* use to
> > distinguish v2 gid from v1/IB gids.
>
> I would ignore the sysfs
>
> If you know for sure it is RoCE v1 then say so
>
> IB doesn't have types so it shouldn't show anything
Sent out a v8 for this change.
>
> Jason
