Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4842481C4
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 11:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHRJTf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 05:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRJTe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 05:19:34 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00EEC061389;
        Tue, 18 Aug 2020 02:19:34 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l204so17346333oib.3;
        Tue, 18 Aug 2020 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPrtzmbRGNWaNnH3sS85IwKsEQNBiDa2S7qZVgUqdV0=;
        b=uwZdr1drv1Ffv9Xzzpo9foaY/76wFKIYjODaXwbDePsqoYcvqDhJmGI4HUx8kWwHLa
         6xk72QeNWiJ8ZyoVNETOQnKBdig0310Kgo7+32xRcAqF6xvhUHchqRhqiDCawSbIk6Us
         ab65eZMrC1YpfEPvCsKwxhstK20yEyb4TG4Aj07i2I+hshwHuZDqfsxJ3POjGClB8r2j
         CqCjAY9xz4mYpElYZ1N2H8h+4NGoCpVjz42b69/LpB/AGZhOFTXK866IOQnk4hQuRG5t
         4cZLyZtDEfHm7knoy6f0gd3Z5ZMrPeDaUWZMAUN2PRPpDOnGdL6jQY/ERAhYEUxXYk69
         2Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPrtzmbRGNWaNnH3sS85IwKsEQNBiDa2S7qZVgUqdV0=;
        b=LRHjTBLcbHsM63U0BpVYA4SlyTxbS5KKephOSXm433u23Tb2HRF7Nboi5orydVmIYc
         oKCsiWw5VdEu2wUHmexPr9FJcozuFXjD2qE5SjzW+WO4LTPMfQTE5GHSzXBy361o49Cx
         gcz1QnDWqeUTHYTwIf+MpcAjJrfgc+4ZJECwvMELc1eaHtMQRXj9nHmkk0Qw7sqEPb49
         G3SnBGs9s89zjHIgcpRe3JH2LUMAbWPfY+sMq/FfQn54KEI5BDH8u3zJmBtsLEUAkJfQ
         NdLEpIjjz3u4YMOc8YgT9PkLQpwdnleBFDLun9//tb6EvoN/F0byry32ryU/Om2pri8K
         4+vg==
X-Gm-Message-State: AOAM5315jizFMZ4HLNT/ILs4Rid0gXGy1jkb2EX3iULyAaf0DCQd4Ym0
        Jf0W0DTxbXm94PvpNUVRlu7cVJ6Vs34ZMiv2/9A=
X-Google-Smtp-Source: ABdhPJwaWzGptyRfJAitJy797Axdef9a5WOyIDLI2WzlDJ19r7bFoze/coeM8H5xGegNsEzzrGuNJ9zDhm5pItH4Obc=
X-Received: by 2002:a05:6808:4c5:: with SMTP id a5mr12626963oie.175.1597742373280;
 Tue, 18 Aug 2020 02:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200817082844.21700-1-allen.lkml@gmail.com> <20200817082844.21700-2-allen.lkml@gmail.com>
 <20200817175318.GW24045@ziepe.ca>
In-Reply-To: <20200817175318.GW24045@ziepe.ca>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 18 Aug 2020 14:49:21 +0530
Message-ID: <CAOMdWS+YQAWY=L5KqTKhZsg3faK8Z6mUzZ_U6rZ+Y3ybrHF1qQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] infiniband: bnxt_re: convert tasklets to use new
 tasklet_setup() API
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com, Kees Cook <keescook@chromium.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > index 4e211162acee..7261be29fb09 100644
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > @@ -50,7 +50,7 @@
> >  #include "qplib_sp.h"
> >  #include "qplib_fp.h"
> >
> > -static void bnxt_qplib_service_creq(unsigned long data);
> > +static void bnxt_qplib_service_creq(struct tasklet_struct *t);
> >
> >  /* Hardware communication channel */
> >  static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
> > @@ -79,7 +79,7 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
> >               goto done;
> >       do {
> >               mdelay(1); /* 1m sec */
> > -             bnxt_qplib_service_creq((unsigned long)rcfw);
> > +             bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
> >       } while (test_bit(cbit, cmdq->cmdq_bitmap) && --count);
> >  done:
> >       return count ? 0 : -ETIMEDOUT;
> > @@ -369,10 +369,10 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
> >  }
> >
> >  /* SP - CREQ Completion handlers */
> > -static void bnxt_qplib_service_creq(unsigned long data)
> > +static void bnxt_qplib_service_creq(struct tasklet_struct *t)
> >  {
> > -     struct bnxt_qplib_rcfw *rcfw = (struct bnxt_qplib_rcfw *)data;
> > -     struct bnxt_qplib_creq_ctx *creq = &rcfw->creq;
> > +     struct bnxt_qplib_creq_ctx *creq = from_tasklet(creq, t, creq_tasklet);
>
> This is just:
>
>   struct bnxt_qplib_rcfw *rcfw = from_tasklet(rcfw, t, crew.creq_tasklet);
>
> No need for the extra container_of

Sure, will fix it and spin V2.

Thanks.
>
> Jason



-- 
       - Allen
