Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8610B129
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 15:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfK0OYV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 09:24:21 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45100 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK0OYV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Nov 2019 09:24:21 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so14133922ioi.12
        for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2019 06:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4FcCBT6eKjm8pgoPga08T5B5ddKunRdKIE/L77nFAU=;
        b=pwtx84AsEokVLT5gOBaK0I6oXBHzIAvBMa9ibSeOpyA5QPLcwa2tuHR3bvgMg1CwLT
         2kspFwUVYo8aPPVU30oemugDdO9qdJZisJ3819nXZ6J1Tq1Yqjz0CwVw+hrIk0783bad
         kvQS6zqEXxisq3XOiql49q/b/Wr2xFmHn9B4mFaw8cDhR4OBmeVxqm4MFPUU01EPvF+F
         kIJeRC1NQGC6b/RDrkQo6nU5sUgIUr6QYusH0eJUzGG/CHyCYR620ISyKNSPjGve4lN1
         oeW7NQcuPRTiJmLp8Ddoht8Q7POTff69Jh+Mu97hFbsd5ZhkBmDZ8McR/ebcqLEQ//0C
         Q0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4FcCBT6eKjm8pgoPga08T5B5ddKunRdKIE/L77nFAU=;
        b=AQUKwC2JcVzf5N/lnDKnWS1n91D6U51MDWzx28T4UxAjI1Qyf4DzwEgTQNN1jznPr7
         EHkTSvNjZoa7WZArtp/DYO0Fgc4Td38S7W7bQFlgBL4JugTv4JerBfJg6zg4JUYys/Oe
         6HYogSqfwiopH6W11Uuvdi6Rf/EnJYLCm5P/GulTgnMjq7OcgZidecTn3N12IOk6gyKa
         qXuh66iZhqxgRq2k24UPB2quJDAg3EO50Pue7KzEzsJvEu8hkXyn5iw3fw6ILMgU6eTs
         rWDDylmY70bYhm1bx08/ogUA/ONoXrSeiG8de2Oh/RaRcSFN16sj71kDWgsn7TayQRUV
         FeUg==
X-Gm-Message-State: APjAAAUUIV175vGA9tBc3qf/JhzUU5I3WEEzyuGIHmsUIP4Ux/kC1AME
        PZyHyhRCfu5LP2dtddu6JKPpwYG0PG6/5hiuXFreDg==
X-Google-Smtp-Source: APXvYqx58nLRhqVuOq04xayY6Whu89NJKy81nUsVhTufAJf6Pla53PuGwKcYKEneO08rjBg6QbXd9y9q+dr+JTst3dU=
X-Received: by 2002:a02:7708:: with SMTP id g8mr4731069jac.9.1574864660592;
 Wed, 27 Nov 2019 06:24:20 -0800 (PST)
MIME-Version: 1.0
References: <53ed2e18-c58e-1e9c-55f8-60b14dfa2052@zju.edu.cn>
 <4433c97d-218a-294e-3c03-214e0ef1379f@acm.org> <20191127111008.GC10331@unreal>
In-Reply-To: <20191127111008.GC10331@unreal>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Wed, 27 Nov 2019 08:24:08 -0600
Message-ID: <CADmRdJfEr405W1+m=jYDYV=MZtk_0mEamUA7UXt6rKangnAC1g@mail.gmail.com>
Subject: Re: [question]can hard roce and soft roce communicate with each other?
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        wangqi <3100102071@zju.edu.cn>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I've recently uncovered a bug in RXE that causes iCRC errors when
running between RXE and a correct RoCE implementation.  The bug is
that RXE is not including pad bytes in its iCRC calculations.  So if
the application payload is not 4B aligned then you'll hit this bug.
You can see this by running ib_write_bw, for example, between mlnx_ib
and rxe.

works:  ib_write_bw -s 32 -n 5
fails: ib_write_bw -s 33 -n 5

I'll post a patch this coming weekend hopefully.

Steve.

On Wed, Nov 27, 2019 at 5:10 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Nov 26, 2019 at 04:53:14PM -0800, Bart Van Assche wrote:
> > On 11/21/19 11:19 PM, wangqi wrote:
> > >      Do you know how to make soft-roce (on server) can send message
> > > to the hard-roce (like Mellanox cx4 card) on a client? We tried rdma-core
> > > 25.0 and 26.0. The rdma-core can support both soft-roce and hard-roce.
> > >
> > > But it seems that the soft-roce (server) and hard-roce (client) can not
> > > communicate via "ib_send_bw", "ib_read_bw" and so on, but can
> > > communicate via "rping".
> > >
> > >      Do you ever try to use soft-roce and hard-roce together?
> > > Do they work well? I really wonder why they can not communicate with
> > > each other. Best wishes,
> >
> > I think this should be possible. The diagram on the following web page shows
> > a RoCE NIC and softROCE connected to each other:
> >
> > http://www.roceinitiative.org/software-based-roce-a-new-way-to-experience-rdma/
>
> It should work, but it didn't work for me now :)
>
> Thanks
>
> >
> > Bart.
