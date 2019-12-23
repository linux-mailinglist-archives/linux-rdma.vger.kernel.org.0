Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE703129247
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2019 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfLWHjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Dec 2019 02:39:04 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40535 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfLWHjE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Dec 2019 02:39:04 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so15284047iop.7
        for <linux-rdma@vger.kernel.org>; Sun, 22 Dec 2019 23:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeye+q53rZmux/Iau8xNLxQp7lO05n5+p3pMzBVRFf8=;
        b=asbgCvJsJwZ0p1J1IYLFjlmcXtT1c+RjctZqZh/gsHJe16G98SpIq9tjPn/oKINtKE
         P8GGt+Ygb7UPsZR61EgA7JsHXQap7Rua3dzlxGm4kcSR3ylR073c2YdfjdSOnHyxTXye
         G2fzMdt+RR7FuNTevjk+metyZxVEziyQTINNbsSTqp47J6grnx9CMiTXCYMtd8GQypYP
         RWJ/b0NA77oH3Mnym7d64982prg0YPF1c7nq1wgZwbMh9xxOnHuihs7ehgza8Fod0xyS
         CB6qjAyElA+LDTpwl+BHGU0mGKsVlWg4s1D3w3KUn0KJPd2hjYcnHzMJXCeIsz/PUbOo
         yn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeye+q53rZmux/Iau8xNLxQp7lO05n5+p3pMzBVRFf8=;
        b=aQq0IqZbIn3aeUkqnx2hjJ+yCo5qgH+/InGYVzEeXtsn9Qrq9EZNWGYdV6OGTuPGM8
         AofRTxEew8PRdnkkYnFcjzPcVeJHl99UdP4thn3Ts8PNBe7MyNdiWX4UCd3nLVwut6KH
         2r5frwyz1Vf82qMfDbMDc+l1neV31efgRUgU16eaYHHXWqSAXRIn8Do/Hpq3lDcFTJcv
         csdGvZVjNdZpGP7CsDLPdOdGvb+243m8YeiSe4img6zfYR+0cFPqjasKnazImTt2JQ4T
         8EFF/wtpIOFT3cHYIKFV2D/RvrfxSWQ92nXsAxMpj3hqB7fwZLO/uVcUU8Or2mQ4p2Py
         MH6w==
X-Gm-Message-State: APjAAAXEkd9Xw2HPB03YGOWWSOd8eclkH9T0kvP5vO3W05k3SK0MeKFk
        12uzsy9na+pmEX0mkmAXkJ181mpIDcJ/RbupiBh3dA==
X-Google-Smtp-Source: APXvYqyK4sCYJ4o+bv9/rJOZOgkU9PG4Z7cuTPQR3TcJUT5pn/w74AAt1MCMgekgDxCujUR7u3lgpgoU3szvt6tBsoU=
X-Received: by 2002:a02:ca10:: with SMTP id i16mr8015353jak.10.1577086743442;
 Sun, 22 Dec 2019 23:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-3-jinpuwang@gmail.com>
 <20191221101530.GC13335@unreal> <CAHg0HuxC9b+E9CRKuw4qDeEfz7=rwUceG+fFGfNHK5=H2aQMGw@mail.gmail.com>
 <20191222073629.GE13335@unreal>
In-Reply-To: <20191222073629.GE13335@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 23 Dec 2019 08:38:54 +0100
Message-ID: <CAMGffEn9xcBO0661AXCfv0KDnZBX6meCaT07ZutHykSxM4aGaQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/25] rtrs: public interface header to establish RDMA connections
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 22, 2019 at 8:36 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sat, Dec 21, 2019 at 03:27:55PM +0100, Danil Kipnis wrote:
> > Hi Leon,
> >
> > On Sat, Dec 21, 2019 at 11:15 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > Perhaps it is normal practice to write half a company as authors,
> > > and I'm wrong in the following, but code authorship is determined by
> > > multiple tags in the commit messages.
> >
> > Different developers contributed to the driver over the last several
> > years. Currently they are not working any more on this code. What tags
> > in the commit message do you think would be appropriate to give those
> > people credit for their work?
>
> Signed-of-by/Co-developed-../e.t.c
>
> But honestly without looking in your company contract, I'm pretty sure
> that those people are not eligible for special authorship rights and
> credits beyond already payed by the employer.
>
Hi, Leon,

Thanks for the suggestion, how about only remove the authors for the
new entry, only keep the company copyright?
> +/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
> + * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
> + *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
> + *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> + *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> + */

The older entries were there, I think it's not polite to remove them.

Regards,
Jack
