Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24293496B9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhCYQYF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 12:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhCYQXv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 12:23:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC043C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 09:23:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b7so3923875ejv.1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omq8bBLBDy7uYQDOJRAFAv3BusCdmAfBms7xhT9LCCE=;
        b=ZITvLlzMAfOwwuOmTCQlw71uJiuOKqNVezPBzBqw3lZef32A8GOAZliGQ57tmrnPoA
         7lUSWdjpFcSbaaqr8WPDgvxAyuT9I4Bc5S5CYVhD5rmcSIjbli2k/kXsxWVAxitB9+eI
         YLTW1nclGq6mjpixVpiDv7ckex53FG9C0Ue7v/FNeQI/B9eVfWvuiHFM1eX1cthO1O8y
         86sFjMMiiVUZfYCMgeJhMeJjSQGN41AyElVRvNbRAXARrxjqEuqoTLmX2p1RT/OXRVi8
         BX4hcTYhN4/m4sBznRFFAKPwoCM+G0QI3K99/fO/JJNDRKqfuw9RnUxfW6o5iWsJR8vH
         +KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omq8bBLBDy7uYQDOJRAFAv3BusCdmAfBms7xhT9LCCE=;
        b=PivUMk5ku/v5GwvJifHzc64rqA8cr44Si142Twfm47rjIuncwolrqHs2h93cj/pero
         FhbqgcJqIHpf8Cwpy0BfTkz0d+1YqflIpnAuYDys8nKhG1UL/Jh7uAa0IHuOsDKM0Vsa
         xUMrOypHdmvWBdSoGicPsv6Oa+A/UMDxgUc+LoTndqintNCGLc15lkSzdu8qE1Km7JLQ
         snZij2riDlF0hZsc9+6vQtwuPN+61wmJt/uY/ULLM/wPbjrS1IKNghm6eT2BW76YO0xV
         22b9UUC0/C1BA9ZkbIgFnvL0BGGifiPoZs3NeVpi5VOEHUTm964ZmAcZ6safmNpUGg+2
         MOdg==
X-Gm-Message-State: AOAM531OT8S0qVifBVfssxj2iwFOp1ems6XoByIb+6GJ0GEVRzf2XN9W
        Ir7HLAABC85qV9zEiK1pm6HpSO0xlNF7eRMGhj6Vvg==
X-Google-Smtp-Source: ABdhPJzaeXaxAXQnO/MwgJNjFLE2eEUWsGGUBUclmbJGLwTS+0OJjAkbjLuaEl0/o3w4q+aAh0TaCxHr5V2I3DvxW7Q=
X-Received: by 2002:a17:906:c102:: with SMTP id do2mr10372624ejc.305.1616689429647;
 Thu, 25 Mar 2021 09:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com> <20210325152911.1213627-14-gi-oh.kim@ionos.com>
 <YFy2WJEpOpjBxx7f@unreal>
In-Reply-To: <YFy2WJEpOpjBxx7f@unreal>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Thu, 25 Mar 2021 17:23:14 +0100
Message-ID: <CAJX1YtYgLMsV+PUxxPt6fEtgk3sNPui64iAs4VDy8n44_vq7Ag@mail.gmail.com>
Subject: Re: [PATCH for-rc 13/24] block/rnbd-clt: Replace {NO_WAIT,WAIT} with RTRS_PERMIT_{WAIT,NOWAIT}
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 5:12 PM Leon Romanovsky <leonro@nvidia.com> wrote:
>
> On Thu, Mar 25, 2021 at 04:29:00PM +0100, Gioh Kim wrote:
> > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> >
> > They are defined with the same value and similar meaning, let's remove
> > one of them, then we can remove {WAIT,NOWAIT}.
> >
> > Also change the type of 'wait' from 'int' to 'enum wait_type' to make
> > it clear.
> >
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Cc: Leon Romanovsky <leonro@nvidia.com>
> > Cc: linux-rdma@vger.kernel.org
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
> > Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/block/rnbd/rnbd-clt.c          | 42 +++++++++++---------------
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c |  4 +--
> >  drivers/infiniband/ulp/rtrs/rtrs.h     |  6 ++--
> >  3 files changed, 22 insertions(+), 30 deletions(-)
>
> <...>
>
> > @@ -535,7 +527,7 @@ static void msg_open_conf(struct work_struct *work)
> >                        * If server thinks its fine, but we fail to process
> >                        * then be nice and send a close to server.
> >                        */
> > -                     (void)send_msg_close(dev, device_id, NO_WAIT);
> > +                     (void)send_msg_close(dev, device_id, RTRS_PERMIT_NOWAIT);
>
> This (void) casting is not needed.
I will fix them.
Thank you.

>
> Thanks
