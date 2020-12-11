Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198DF2D705A
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 07:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436524AbgLKGva (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 01:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395567AbgLKGvG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Dec 2020 01:51:06 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327EBC0613D6
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 22:50:26 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f23so10895758ejk.2
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 22:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOyH91HYE+ecPMqr9RDNeOMk/juwGLFp3UZjYGKos0Y=;
        b=Ceqw4olq/sAJC8ut4FwudzBPTgTLzdSg1R0elmKcY4TQTJVvz6ATPUvSrpGIxs+n47
         ggA+/7oKp1P+G2/j2gnknwjocNnCaVCvzSuanlGhMgCVTFbeCXqHvii0J+WV623XuVGh
         lmLG/66N7kjOyw60lXpGkU7aiPvx/JIM0yeC17Q5jjX+roK/8h/fyRXvM22ZuritV+af
         ju8IlBrgn6V6q85USRimr7F8ITP9nQWn+aoTR30wc55BSIVebTcv0pJbUbzLnOIa/iX7
         aSm0uIzT+Dg0VYA8PtlUW4b2T7+//HvmxGEO9oDOpB0Ek0pvRbvtLCXxPKy5TrC4cvJW
         oi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOyH91HYE+ecPMqr9RDNeOMk/juwGLFp3UZjYGKos0Y=;
        b=C7X6XlagccmVVkGohwmrJ2EyA1uKUsbm5VGflfdZgO/MR8ZSg5yotU7DRc0+SdBjo3
         uapdy1jrRVoeDF92M5hNRSmUtVCr84eOMKJ8ODlipx9wgnHp712p/Y92E0mlcxTEvK5k
         XhO7MsHXSFuJx/WNDUlPOm/p/Xccn2V9WPhAUI6Q/I9xu4Yt780gbR+4QIHGxOs4ak73
         WN5zSB8wbbzO2SNIQzhjSwS7IIo283i/+EagGsPCK86gJsQIgedfdqPykTLizpr5ELxB
         O0bxyts2jF4myGyYr8GzVke0+mUUvQ34Gykhau3/lm0kGuUWh3y4t+JOGkp+tXzlMk24
         1FgA==
X-Gm-Message-State: AOAM531tN/ja/zfr5Nkj/7tAm/wQajfr58X6SFKPb7mXQXCTItnXHGho
        XmUJx7+2qHvNzeikGNKdIQ4bocM5Re/6zicNLZm27w==
X-Google-Smtp-Source: ABdhPJzwzI3I0JFYELFCEqzjr7jszBkX0BG0k3qz6ObZMpxeSdLACYTmE5uEb/7LTxPC3oUmZsuCDllSJ9bCrWgNtaE=
X-Received: by 2002:a17:906:16da:: with SMTP id t26mr9404230ejd.478.1607669424958;
 Thu, 10 Dec 2020 22:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
 <20201209164542.61387-3-jinpu.wang@cloud.ionos.com> <CAMGffE=_axtHU=pAV3qx5FVY2pB786z3kffQwDzinOaH=yS5Ag@mail.gmail.com>
 <e841a2c3-2774-ca8f-302a-cd43c3b3161e@cloud.ionos.com>
In-Reply-To: <e841a2c3-2774-ca8f-302a-cd43c3b3161e@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 11 Dec 2020 07:50:13 +0100
Message-ID: <CAMGffEmKAzy3dXVKhoZDAqLpZ6DiQiaYNQn8_0Fd+MQUXbn_eA@mail.gmail.com>
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 11, 2020 at 3:35 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 12/10/20 15:56, Jinpu Wang wrote:
> > On Wed, Dec 9, 2020 at 5:45 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
> >>
> >> If there are many establishments/teardowns, we need to make sure
> >> we do not consume too much system memory. Thus let on going
> >> session closing to finish before accepting new connection.
> >>
> >> Inspired by commit 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
> >> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> >> Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > Please ignore this one, it could lead to deadlock, due to the fact
> > cma_ib_req_handler is holding
> > mutex_lock(&listen_id->handler_mutex) when calling into
> > rtrs_rdma_connect, we call close_work which will call rdma_destroy_id,
> > which
> > could try to hold the same handler_mutex, so deadlock.
> >
>
> I am wondering if nvmet-rdma has the similar issue or not, if so, maybe
> introduce a locked version of rdma_destroy_id.
>
> Thanks,
> Guoqing

No, I was wrong. I rechecked the code, it's not a valid deadlock, in
cma_ib_req_handler, the conn_id is newly created in
https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/core/cma.c#L2185.

Flush_workqueue will only flush close_work for any other cm_id, but
not the newly created one conn_id, it has not associated with anything
yet.

The same applies to nvme-rdma. so it's a false alarm by lockdep.

Regards!
Jack
