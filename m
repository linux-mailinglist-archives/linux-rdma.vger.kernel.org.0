Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05CE216BE63
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 11:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgBYKOU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 05:14:20 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34514 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgBYKOT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Feb 2020 05:14:19 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so12018156oig.1
        for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2020 02:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIx16FQOi5EnhyZcfyn7UOXfrDq9r3NcayIu9CQNStU=;
        b=R/qZm2mon1QR5/hagPxbxMTW8PJKhu9t4X3mqAZILAjok/GhZfJ9RlvUynTtpPvMBY
         GDOLeWzRSW1faaMBP6+eQBuppY0LGtvqHlwyLdz20VQHj2mKTqOkRJxbm3jUyY7fwlWl
         V2FJ9HIO4J2UuPugajVK9UQEUqLXZPUpfC68A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIx16FQOi5EnhyZcfyn7UOXfrDq9r3NcayIu9CQNStU=;
        b=K/2WwxoA9mDdz0OAOUoDBwpsMOHlVq0O4rmwJa81kyyq8OW6kWOJ0U2GkELbTIKWzx
         UVRXAC1GKaY35Bikla/X3SMRZ7XwVyQiiI4n/v7Y6JFZi0Icn0tZj3Hd6SQVWzCZZesu
         NlibnUBK2F+Xy9seEcsnK7w/E7KCbceCOGWZHss5SvrXjQhdQty+hZklXg8j77vWmAo9
         0jLE0KOrzZ2IOKSJP9AcLIUmeI12OPucRHEWygLajrHEakb7qlRJpbrOl8F+qS6uDtcO
         KtBek/BCZnxzDbxFufm2zgQ8drz+YF23QkJZuHGfBnLpXI6mheIwAImCPNcau1K0C59B
         XgFg==
X-Gm-Message-State: APjAAAULcp/W7l/douqMr+U99WiIiY0u/x3NLEdYIvZAP1vS/wDz1MF/
        /99jwW22AO+zgWygYKYgcIDo/JLivlgQ2bSPFs3wyA==
X-Google-Smtp-Source: APXvYqyvyNJAOpbOP93u0nRyjEH3hlhNTQ6VXTs80crJhCiJpA040MW4N/0rfERWYy/nnx94CRIS2XiMIDMOnBGw6g4=
X-Received: by 2002:aca:eccd:: with SMTP id k196mr2692709oih.95.1582625658699;
 Tue, 25 Feb 2020 02:14:18 -0800 (PST)
MIME-Version: 1.0
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
 <1582541395-19409-2-git-send-email-selvin.xavier@broadcom.com> <20200224134828.GI26318@mellanox.com>
In-Reply-To: <20200224134828.GI26318@mellanox.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 25 Feb 2020 15:44:07 +0530
Message-ID: <CA+sbYW2saCOoRs_E83J0raaMQ-=zaLUygYYk3NSkq4ZdMEcs9w@mail.gmail.com>
Subject: Re: [PATCH for-next v2 1/3] RDMA/bnxt_re: Add more flags in device
 init and uninit path
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 7:18 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Feb 24, 2020 at 02:49:53AM -0800, Selvin Xavier wrote:
> > Add more flags for better granularity in in device init/uninit path
> >
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h | 16 +++++++++----
> >  drivers/infiniband/hw/bnxt_re/main.c    | 41 ++++++++++++++++-----------------
> >  2 files changed, 31 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > index c736e82..0babc66 100644
> > +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > @@ -135,11 +135,17 @@ struct bnxt_re_dev {
> >  #define BNXT_RE_FLAG_IBDEV_REGISTERED                1
> >  #define BNXT_RE_FLAG_GOT_MSIX                        2
> >  #define BNXT_RE_FLAG_HAVE_L2_REF             3
> > -#define BNXT_RE_FLAG_RCFW_CHANNEL_EN         4
> > -#define BNXT_RE_FLAG_QOS_WORK_REG            5
> > -#define BNXT_RE_FLAG_RESOURCES_ALLOCATED     7
> > -#define BNXT_RE_FLAG_RESOURCES_INITIALIZED   8
> > -#define BNXT_RE_FLAG_ISSUE_ROCE_STATS          29
> > +#define BNXT_RE_FLAG_ALLOC_RCFW                      4
> > +#define BNXT_RE_FLAG_NET_RING_ALLOC          5
> > +#define BNXT_RE_FLAG_RCFW_CHANNEL_EN         6
> > +#define BNXT_RE_FLAG_ALLOC_CTX                       7
> > +#define BNXT_RE_FLAG_STATS_CTX_ALLOC         8
> > +#define BNXT_RE_FLAG_STATS_CTX2_ALLOC                9
> > +#define BNXT_RE_FLAG_RCFW_CHANNEL_INIT               10
> > +#define BNXT_RE_FLAG_QOS_WORK_REG            11
> > +#define BNXT_RE_FLAG_RESOURCES_ALLOCATED     12
> > +#define BNXT_RE_FLAG_RESOURCES_INITIALIZED   13
> > +#define BNXT_RE_FLAG_ISSUE_ROCE_STATS                29
>
> The error unwind is better than adding these endless flags.
>
> It is hard to understand the flow with all this needless conditional,
> really if you want to change this I'd delete the test_bit scheme and
> stick to the normal goto error unwind.
The existing code was doing few  error unwinding. I thought it would
be simple to collect everything under bnxt_re_ib_unreg function and
cleanup with these flags. I am ok with both the approaches. Maybe,
I can drop this patch and post the remaining series.

>
> Jason
