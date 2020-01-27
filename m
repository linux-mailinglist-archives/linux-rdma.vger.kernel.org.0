Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D421149F47
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 08:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgA0HkY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 02:40:24 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40423 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgA0HkY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 02:40:24 -0500
Received: by mail-il1-f193.google.com with SMTP id i7so3486251ilr.7
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jan 2020 23:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlqpRIqVOFDJFRKcl0cPLFB239gvFIpyyO8FQz7219A=;
        b=SwPoUg/ZntyEufHuuNzTSKwiUYkFxDDoDytjZppiohHfTJCGfqT5Nj63S3GwFfN7KJ
         nBbkXc6Cq0LgdsnOqtUoQHMXT9cUQIB6+QBVRbDlmT2dcLO968fh1cf03dOcVY02yhHa
         V6yMAT2Bw0gKNPQfO33Y/GODgzFiYfpDs3r5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlqpRIqVOFDJFRKcl0cPLFB239gvFIpyyO8FQz7219A=;
        b=cqq1lc9YQz2xxuE8Oy82KS37noS57lL5IJ9jXs5e16ZXZ8UY9NUH8TQuMMpMiTERKF
         glQZtJvuX+pzDne6AN6Nz5uQ6BjUR+FdXcx2OiY44WF3FWAPUxu7oGiNNpmqsfSeBihC
         EZsLV/cJm5wgRIFzlyayWiW7tM/QnTBmSDmLzcbSGePoxRVjOURN0UIGgKddrPJRiYnY
         WjyOrxlWDcUjoXp3JcZtRwvHSVTOqx/UcMCdGNmNOONiv4+1VgIHpK/DZ20kuxqM9aCi
         EryyDOa4dlWmDYCMbS0BAZKBAFLjNjJxydJ0HGTre9K51BQLT36fDGIURee3+uK92/s2
         YRHQ==
X-Gm-Message-State: APjAAAXCEnU37yh9bNQFhjUd753G/R10yqeLfK+F9iywdlgiNmdn3awC
        +fg9Dco3/keILjE/j6trAyQZxithOzrTmoosU7rqCQ==
X-Google-Smtp-Source: APXvYqxnwpDC8AKeRaF5nS6iIlkLhzSbkYY9DPFwdRB09QFXOmI7HmSYD5bljDFBWxgRObRP35CsrczbByAUmGqV1Nk=
X-Received: by 2002:a92:5d8d:: with SMTP id e13mr13509404ilg.285.1580110823273;
 Sun, 26 Jan 2020 23:40:23 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-3-git-send-email-devesh.sharma@broadcom.com> <20200125180252.GD4616@mellanox.com>
In-Reply-To: <20200125180252.GD4616@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 27 Jan 2020 13:09:46 +0530
Message-ID: <CANjDDBiSLY55v=cA+gMC6QFAqxUxiiFCy3y3_Rw9vF+v40LgDQ@mail.gmail.com>
Subject: Re: [PATCH for-next 2/7] RDMA/bnxt_re: Replace chip context structure
 with pointer
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 25, 2020 at 11:33 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Jan 24, 2020 at 12:52:40AM -0500, Devesh Sharma wrote:
> >  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
> >  {
> > +     struct bnxt_qplib_chip_ctx *chip_ctx;
> > +
> > +     if (!rdev->chip_ctx)
> > +             return;
> > +     chip_ctx = rdev->chip_ctx;
> > +     rdev->chip_ctx = NULL;
> >       rdev->rcfw.res = NULL;
> >       rdev->qplib_res.cctx = NULL;
> > +     kfree(chip_ctx);
> >  }
>
> Are you sure this kfree is late enough? I couldn't deduce if it was
> really safe to NULL chip_ctx here.
With the current design its okay to free this here because
bnxt_re_destroy_chip_ctx is indeed the last deallocation performed
before ib_device_dealloc() in any exit path. Further, the call to
bnxt_re_destroy_chip_ctx is protected by rtnl.
following is the exit sequence anyewere in the driver control path
bnxt_re_ib_unreg(rdev); --->> the last deallocation in this func is
destroy_chip_ctx().
bnxt_re_remove_one(rdev); -->> this is a single line function just to
put pci device reference
bnxt_re_dev_unreg(rdev); -->> the first deallocation in this func is
ib_device_dealloc().


>
> IMHO you should free it as part of the ib device dealloc.
>
> Jason
