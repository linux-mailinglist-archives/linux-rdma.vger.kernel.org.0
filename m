Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F990150F4B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBCSYY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 13:24:24 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41642 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgBCSYY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 13:24:24 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so13468504ils.8
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 10:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEsWSLewjaWpjKWZKWoPoUnbOlLGYeKRbK8F/cYSglo=;
        b=D+sKJI3dX7Z5GyLrgdBa2jeHgL8wP+fPWz1a8uz+ZAIZT934p3HuZEWHew5Ovf+b2K
         6lRjUV8eK2bVidU85VINpErCy5NOgHGr/x5L7Thj1hNTT2ka+iQrRBHD7VlE9ZfzIs4U
         5Z0MEwFobZEJFbphbOgSW06/e1BZScFeDTnes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEsWSLewjaWpjKWZKWoPoUnbOlLGYeKRbK8F/cYSglo=;
        b=OsxPrB3NY6xWWDcR9iXWe1h5oTg9WwgW6tmVacgxGTVi0muSEp1l01xIVCGRN6rh8i
         OeE5hryvQBsdzDZGzB0W3/ye/aSZk4QAh/h9/34DYXuiZOXjpxRbCxItBrpe5m/Ukxe1
         nNM6d4LcII/l1bdMvcjZYNYgW1Ch8p7F2mNL5Wd/7Vul6NqATEGZg/o3WT7nI8drwcyR
         avyd84z/G2NoVFKvS1DOrVUbL6MuUTKbGfvB3e5tMePV+gRk2U/i1i91tFsqbHiAQ+Bn
         tyiUcynT54bR9KBjufMtL6pKYUoj2bHT1KbPxgt/kQtHr0aGV/QxWK1h11Dwvp5ma6bt
         jCgQ==
X-Gm-Message-State: APjAAAVxypCwWCSkGkuTHq7UHyAAjW+S/PvTlMLmn7g4JQZ09tJ+mosP
        DFdIRFuMKo8Rs9FMzHx9BXrlXrHuAEjTSFdTOrpYKwhY
X-Google-Smtp-Source: APXvYqySBE+WqnjkcXMuX5VA+4EilfEZN/456m8wgred/qmlVDps9sl11YPqu+trX+Lb9wpZuj7hE/ieJscj74lJP28=
X-Received: by 2002:a92:c703:: with SMTP id a3mr15617518ilp.89.1580754263396;
 Mon, 03 Feb 2020 10:24:23 -0800 (PST)
MIME-Version: 1.0
References: <1580745415-19744-1-git-send-email-devesh.sharma@broadcom.com> <b9fc34ae-6da8-0d12-e069-cdbf9dc06e25@amazon.com>
In-Reply-To: <b9fc34ae-6da8-0d12-e069-cdbf9dc06e25@amazon.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 3 Feb 2020 23:53:47 +0530
Message-ID: <CANjDDBimureiVPqd6Pis46=FiELQHWWjuAm85ZoPYEekBWVs7A@mail.gmail.com>
Subject: Re: [PATCH v4] libibverbs: display gid type in ibv_devinfo
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 3, 2020 at 11:48 PM Gal Pressman <galpress@amazon.com> wrote:
>
> On 03/02/2020 17:56, Devesh Sharma wrote:
> > diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> > index a0e6f89..fc0699d 100644
> > --- a/libibverbs/driver.h
> > +++ b/libibverbs/driver.h
> > @@ -84,6 +84,7 @@ enum verbs_qp_mask {
> >  enum ibv_gid_type {
> >       IBV_GID_TYPE_IB_ROCE_V1,
> >       IBV_GID_TYPE_ROCE_V2,
> > +     IBV_GID_TYPE_INVALID
> >  };
>
> I don't think that's right.
> You're adding a new enum value to libibverbs, but it's not really
> used/implemented there.
> If devinfo needs an invalid GID value, make it local to that program.

the enum can be used by other applications too, if those are yet to be
coded in future. I thought its a good practice to put things at one
place once for all.
