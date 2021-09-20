Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93E4110B8
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Sep 2021 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhITIO7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Sep 2021 04:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbhITIOt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Sep 2021 04:14:49 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB47C061760
        for <linux-rdma@vger.kernel.org>; Mon, 20 Sep 2021 01:13:22 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w206so12067876oiw.4
        for <linux-rdma@vger.kernel.org>; Mon, 20 Sep 2021 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5BAPARJTtiVFfMMuMGBWZxoSQxuWkqwV1CsHjlrsy8=;
        b=IXVYXtWjaS6WnjF/GBaSGmiOymf6Ep1HdyLNtkAHIt2EtYrsv4MLiZnmGFIz5x66zV
         hqJrZcTybJYSQmmMU8xGV0KLyHBIAY8Fenli/jYiozAdPSEv41JjJhd8d/8olt6FYhu2
         /dGjD7iUR8UnOsFwHJ388tN9HuCplCvL/2g8mclOlZ7KmUL++YgHPWatUO9WjRXglTHV
         ed/sfrc2j+VM03plAOOewyr2LyEdWSSG1IP0yKhLneQxNKwtLv7K3M9LldNz+A90LO/f
         KWs7Df85MwqhBXTwwjEbOcDu7qikNWnrLwqJjHwR5QOrf0yYN6D2+nZS5YqB3QONwWXq
         zoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5BAPARJTtiVFfMMuMGBWZxoSQxuWkqwV1CsHjlrsy8=;
        b=ncHgURs1SOji5G9MuL9Ppi4Wg/LgftufZ+pkuLSdnhT5fPEjsw0PgSWDQRx3wstSdt
         ctYzeHPVxnOXrgJLN12t68xEPzcQ/Wn7nRhoghEfDU3yEuyDS9C70GkuKTUyPLboyrS2
         2C7V9aQQnOrHpWyo8rlNbtq6uXT8NMERPYmtPHIaCXh/gxmeKTwqc+UNLT/U5074Rmqy
         T2ZAnmJ/tgzP+OQqeTPUlNKjWe+pMVKfzRpoJY3AKwFb6AQtADjwFLBUah9WJR1CL1RA
         WwVioZuEgrbRKPrjduPELd3bgr2+y+WJ5OG9NDBNpI1atfKfDgtfO7YxNASKxTi9NAAA
         gX9A==
X-Gm-Message-State: AOAM531AawVh8KIL45d91Jy1lf1makVgj6ExrWpw7OCLNKj89MNEJwXa
        tiBtMCNZiEp0iRZoVGjIY1sCSmWqAEJzHjFWRMYVJuzZ1kU=
X-Google-Smtp-Source: ABdhPJx1de7EYZSdzABNRhbsjOLpVzwMw3nbrsrZbpw2Vcw8IHCqSH7SrmSY+BDJVNxBNo4F2LTeb68/3nHA6Si6lS0=
X-Received: by 2002:a54:4005:: with SMTP id x5mr21110427oie.160.1632125601620;
 Mon, 20 Sep 2021 01:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ffdae005cc08037e@google.com> <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
 <20210916130459.GJ3544071@ziepe.ca> <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
 <20210916162850.GQ3544071@ziepe.ca>
In-Reply-To: <20210916162850.GQ3544071@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Sep 2021 10:13:10 +0200
Message-ID: <CACT4Y+aq+m8DkB+8Zvh0G5Ehmtd2kgapDr9eJEP0Mq5WLCOWMg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 16 Sept 2021 at 18:28, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Sep 16, 2021 at 04:45:27PM +0200, Dmitry Vyukov wrote:
>
> > Answering your question re what was running concurrently with what.
> > Each of the syscalls in these programs can run up to 2 times and
> > ultimately any of these calls can race with any. Potentially syzkaller
> > can predict values kernel will return (e.g. id's) before kernel
> > actually returned them. I guess this does not restrict search area for
> > the bug a lot...
>
> I have a reasonable theory now..
>
> Based on the ops you provided this FSM sequence is possible
>
> RDMA_USER_CM_CMD_RESOLVE_IP
>   RDMA_CM_IDLE -> RDMA_CM_ADDR_QUERY
>   does rdma_resolve_ip(addr_handler)
>
>                           addr_handler
>                             RDMA_CM_ADDR_QUERY -> RDMA_CM_ADDR_BOUND
>                             [.. handler still running ..]
>
> RDMA_USER_CM_CMD_RESOLVE_IP
>   RDMA_CM_ADDR_BOUND -> RDMA_CM_ADDR_QUERY
>   does rdma_resolve_ip(addr_handler)
>
> RDMA_DESTROY_ID
>   rdma_addr_cancel()
>
> Which, if it happens fast enough, could trigger a situation where the
> '&id_priv->id.route.addr.dev_addr' "handle" is in the req_list twice
> beacause the addr_handler work queue hasn't yet got to the point of
> deleting it from the req_list before the the 2nd one is added.
>
> The issue is rdma_addr_cancel() has to be called rdma_resolve_ip() can
> be called again.
>
> Skipping it will cause 'req_list' to have two items in the internal
> linked list with the same key and it will not cancel the newest one
> with the active timer. This would cause the use after free syndrome
> like this trace is showing.
>
> I can make a patch, but have no way to know if it is any good :\

Good detective work!

But if you have a theory of what happens, it's usually easy to write a
reproducer that aims at triggering this exact scenario. Isn't it the
case here? I would assume you need it to add as a test anyway.
