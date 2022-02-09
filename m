Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841444AF10A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 13:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiBIMKH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 07:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiBIMJE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 07:09:04 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D9AC0018ED
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 03:09:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f23so3449829lfe.5
        for <linux-rdma@vger.kernel.org>; Wed, 09 Feb 2022 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kYNFKDicdcZwa4Tk+5j9IN1MSqrvv79+lCJNoXAgGk=;
        b=G8AxKHb/BhnE2FJtjxWZvjnPVnkz9b/7aIPfSwiSjnHTgWBq6qwud/9Ok4V/ARl5A/
         rETGiI5w+IDYhOLJ9nZNTv4Varuz/Q1ygDXlNhn+sLU9xrQyY302+tNL2r5FKeersah9
         b/BuXg6wN25tMt7JOTMvIpASgQYYZgw8cUgfAm2YgiYpdfFOPxV7O6Ew2Iw9rNWcREpl
         upr7O5O4RjKGCxI6XmU9zmZrbXeFV6haBSgC4IydaxgGC9SAQQBa2V6VXaHhXd6ZXwpM
         27HyW/o7hX5QV2G0Mv7fqPY/mhjmje0ZRochslASmDPvL/ru2eyEfqCxIrLLiJBF+vUK
         O1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kYNFKDicdcZwa4Tk+5j9IN1MSqrvv79+lCJNoXAgGk=;
        b=6pE1cZk9odh6BSxuRcDylps6bB9sg3qDFa/I7JjSgNaXoYh8+CdMjKfRrnoe1LT0L4
         Hc99CprMhst/RWWeS4S4wK5c2Qrl1mj3eZT5t+72ZX8RpUuvO42W+wMxFFKVP6ARHazo
         rE4lqv38WZ9l9kZXvRZMStpiMc0TkvNqSA1PR6BnezzKW+lpjVrL7YJGX+/Ypjxr1ba2
         mZuL/ofU5Cs78kgqtJGaeDkR0VTbkRjMKhH0/kwsCFCKesbBGsADOBZ4l2iYDpRYKDVI
         jtIKgb1mKdxjHZpibVFql/FldejSRblnArujYqW18RAcdhZ8c3y6PfJF9BcmonoEpK9x
         0nGw==
X-Gm-Message-State: AOAM533Qx/DPy/Si1WlJL6JLAbbf1Cv/kt1roCzqgkWz5cFPzNG0VGrB
        Bs6SeATzskWfbqn30x7RwRkBa+IGvEFBvlAxV5tSTw==
X-Google-Smtp-Source: ABdhPJwrglVd8FQb4mcVbB3j8YOf2KEC+eoAM+dJezuESqC5DoUs1u3mP4P3JXRUD3sNA/XGoSf7duyky7bYgdanESU=
X-Received: by 2002:a05:6512:e86:: with SMTP id bi6mr1250278lfb.321.1644404969277;
 Wed, 09 Feb 2022 03:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20220202150855.445973-1-haris.iqbal@ionos.com> <20220208164835.GA180654@nvidia.com>
In-Reply-To: <20220208164835.GA180654@nvidia.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 9 Feb 2022 12:09:18 +0100
Message-ID: <CAJpMwyhEvKDXbD5KTOw7Ev+xmrGgTnwchQgzOOO5PG1zcpxkrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] RDMA/rtrs-clt: Fix possible double free in error case
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 8, 2022 at 5:48 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Feb 02, 2022 at 04:08:54PM +0100, Md Haris Iqbal wrote:
> > Callback function rtrs_clt_dev_release() for put_device() calls kfree(clt)
> > to free memory. We shouldn't call kfree(clt) again, and we can't use the
> > clt after kfree too.
> >
> > Replace device_register with device_initialize and device_add so that
> > dev_set_name can be used appropriately.
> >
> > Move mutex_destroy to release function so it can be called in alloc_clt err
> > path.
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 37 ++++++++++++++------------
> >  1 file changed, 20 insertions(+), 17 deletions(-)
>
> These patches don't apply, please resend them

Sure. Will resend.

>
> Jason
