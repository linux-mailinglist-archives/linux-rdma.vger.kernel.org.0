Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0C377694
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 14:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhEIMXK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 08:23:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhEIMXK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 08:23:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60198611F0;
        Sun,  9 May 2021 12:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620562927;
        bh=lEO8yO22ATuGlKgnIwBYkRrOVBA6TCUPdeIHiqwhKM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwEYYeUCwgdUgCTEDUlxsukqcBWIiHWnX9OgtvJDyBqZ0rOpBFa26YKPrLtmAu7bC
         BZGxv6IitxIYwadjhZoawibregCVoHX25fDaG41NmDom+eGHZgDomUVSQc7ywePLzf
         jsvdJNWtSUiDAH+5wnynJTFn8+ifMhM+cxawJBeZgNDD4vNzgPkyXcQxmSRD9i3tZK
         O1KexpKu11oLV9TTJSq/g52+z9X6HN0gPNScWI/oULplyS00EgVHmHqxtlX7WYcMAK
         dnyMbi5QZcODq2Qs+LnArDZ4wV8p/hpFcfjt/pl74ozR05rDrWZKpa7EwTPRB5Zhmq
         m8sT3ussFwG9w==
Date:   Sun, 9 May 2021 15:22:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?utf-8?B?6Zmz5YGJ6YqY?= <jj251510319013@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] i40iw: Use fallthrough pseudo-keyword
Message-ID: <YJfT66KM189Y8PcN@unreal>
References: <20210509083135.14575-1-jj251510319013@gmail.com>
 <YJe+XDO5PEr4SF0l@unreal>
 <CAJwFiGLyH5aOY=MGvCawWBm7fXuPkndBO83jkT9dWhPpnrd+cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJwFiGLyH5aOY=MGvCawWBm7fXuPkndBO83jkT9dWhPpnrd+cw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 09, 2021 at 08:12:42PM +0800, 陳偉銘 wrote:
> Hi,
> 
> thanks for reply
> 
> the purpose for the patch is to follow the regulation in this doc(
> https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> )
> 
> the following paragraph is written in the doc:
> [image: image.png]
> 
> Not sure if I misunderstood anything, or actually we don't need to follow
> the regulation if no code in "case"?

Please don't top-post, use HTML emails and always CC mailing list.

I'm saying that there is a difference between two following snippets:
switch (value) {
case STATE_ONE:
        do_something();
case STATE_TWO:
        do_other();
        break;
default:
        WARN("unknown state");
}
and 

switch (value) {
case STATE_ONE:
case STATE_TWO:
        do_other();
        break;
default:
        WARN("unknown state");
}

While the first one needs "fallthrough" keyword, the second one doesn't.

Thanks

> 
> Thanks
> 
> Wei Ming Chen
> 
> Leon Romanovsky <leon@kernel.org> 於 2021年5月9日 週日 下午6:50寫道：
> 
> > On Sun, May 09, 2021 at 04:31:35PM +0800, Wei Ming Chen wrote:
> > > Add pseudo-keyword macro fallthrough[1]
> > >
> > > [1]
> > https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > >
> > > Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> > > ---
> > >  drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 1 +
> > >  drivers/infiniband/hw/i40iw/i40iw_uk.c   | 1 +
> > >  2 files changed, 2 insertions(+)
> >
> > What exactly are you fixing?
> > "case" without any code doesn't need "fallthrough".
> >
> > Thanks
> >
> > >
> > > diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
> > b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
> > > index eaea5d545eb8..c6081283217c 100644
> > > --- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
> > > +++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
> > > @@ -2454,6 +2454,7 @@ static enum i40iw_status_code
> > i40iw_sc_qp_init(struct i40iw_sc_qp *qp,
> > >                       return ret_code;
> > >               break;
> > >       case 5: /* fallthrough until next ABI version */
> > > +             fallthrough;
> > >       default:
> > >               if (qp->qp_uk.max_rq_frag_cnt >
> > I40IW_MAX_WQ_FRAGMENT_COUNT)
> > >                       return I40IW_ERR_INVALID_FRAG_COUNT;
> > > diff --git a/drivers/infiniband/hw/i40iw/i40iw_uk.c
> > b/drivers/infiniband/hw/i40iw/i40iw_uk.c
> > > index f521be16bf31..e1c318c291c0 100644
> > > --- a/drivers/infiniband/hw/i40iw/i40iw_uk.c
> > > +++ b/drivers/infiniband/hw/i40iw/i40iw_uk.c
> > > @@ -1004,6 +1004,7 @@ enum i40iw_status_code i40iw_qp_uk_init(struct
> > i40iw_qp_uk *qp,
> > >                       i40iw_get_wqe_shift(info->max_rq_frag_cnt, 0,
> > &rqshift);
> > >                       break;
> > >               case 5: /* fallthrough until next ABI version */
> > > +                     fallthrough;
> > >               default:
> > >                       rqshift = I40IW_MAX_RQ_WQE_SHIFT;
> > >                       break;
> > > --
> > > 2.25.1
> > >
> >


