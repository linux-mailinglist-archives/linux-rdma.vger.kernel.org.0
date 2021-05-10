Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333FE378EBA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240872AbhEJNXN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347219AbhEJMdm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 08:33:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACB5C05BD04
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 05:27:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x19so23077817lfa.2
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9JfpmIuJozAEh6JZILZuGz09TWjadk94GHyLoZsvX8=;
        b=GwzlhW0WlrHN9luhOzzon40i/ZhSAN0LKEkTpt4aHy1u9qvrZKEZTz3+YvmXh1XJ3n
         yIRmSkv6Ye1crHj6u7CczMGaqUXdCa+zc0IzYMXsbvosE0Zxkk7yWGeVM7gx4GK7Xwwb
         18lGYQ12FelZsyvQwgRQWCzC+cl3H9nlLfAloo6fzLvAHVCnaFQaJ/Zw0e0VYmwEmvmC
         ZXc0n4IUmq1duOC+8i0qW1ksi9z7iBpGCtBcyHm5l/Af9YKATNojMbn/tm8WZYYa2Ake
         wAYmpgNFC2RlonlxARgVT0DiNXwZWjDY7FjlhoQ2QJBn57OLFxMj+TpOnZ9TUcVhotir
         Ddfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9JfpmIuJozAEh6JZILZuGz09TWjadk94GHyLoZsvX8=;
        b=LcCPj3gfvcRCGBIsS8JmYNBPfsh771jwPH9PJYJE99bMMGHAbwkP5my90EfXNzqwbP
         DS+fHdztbzmXaAnRj6/bkXS4WMjwVotIAnUEArIPPW62zzt7rEBj9VFGFl9otzc/J05f
         uy13523pyTI+Q6YZ8rkP+JIvL93JmzU7tnY7rBFj3fHJtTArS7nUlK7sZ064X1efs+7E
         uTCU2Lwgojv9bugtPE7UB8koK7mWsarBTMHPC6Wpk39+Ml86WFbfx4aWzmfwNVJ1ojMw
         hL8Wv3xnlVgDH1tPMOVA/A2laOZzn5VpMtRADBlpvFXtNfp3FgYLBMDYjji/9UeBRq9H
         KLSQ==
X-Gm-Message-State: AOAM530fruPhGa0a5eQMoOIKnTRjpDRJ/orL91i52HXM0HOHEn1KIBpj
        5YmMN11yo9hd8+TVvmGUTA3a+gxfB6swfVlksBVM7A==
X-Google-Smtp-Source: ABdhPJzxQB2qvb5MzR34YKl/LoFhPnZwM3l0v28cvmqRubF9xKNINr/m0T6r+ZLrHIfd+RgAe8koP9SBMT72kTIzDCI=
X-Received: by 2002:a19:df54:: with SMTP id q20mr17326308lfj.109.1620649624274;
 Mon, 10 May 2021 05:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210503114818.288896-1-gi-oh.kim@ionos.com> <20210503114818.288896-4-gi-oh.kim@ionos.com>
 <YJfGcFlJCHrf2quT@unreal> <CAJpMwyiXbqTK-pB=nQ4sfzXeeo8=dd5KJVZ_57apGF5cbpM5dA@mail.gmail.com>
 <YJkerTfjpXOGW7X+@unreal> <CAJpMwyitTn2oFxyWwr+bnFh3cQDdPwmN8L8JKPnBGqMc4a1aiw@mail.gmail.com>
 <YJkkdKRCHC1mrR1M@unreal>
In-Reply-To: <YJkkdKRCHC1mrR1M@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 10 May 2021 14:26:53 +0200
Message-ID: <CAJpMwygafjUSKuVhBYMF0ue6BPexN8+_d88Tp+GhH_36qoLxhA@mail.gmail.com>
Subject: Re: [PATCH for-next 03/20] RDMA/rtrs-clt: No need to check
 queue_depth when receiving
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 2:18 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, May 10, 2021 at 02:06:55PM +0200, Haris Iqbal wrote:
> > On Mon, May 10, 2021 at 1:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Mon, May 10, 2021 at 01:00:33PM +0200, Haris Iqbal wrote:
> > > > On Sun, May 9, 2021 at 1:24 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Mon, May 03, 2021 at 01:48:01PM +0200, Gioh Kim wrote:
> > > > > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > > > >
> > > > > > The queue_depth size is sent from server and
> > > > > > server already checks validity of the value.
> > > > >
> > > > > Do you trust server? What will be if server is not reliable and sends
> > > > > garbage?
> > > >
> > > > Hi Leon,
> > > >
> > > > The server code checks for the queue_depth before sending. If the
> > > > server is really running malicious code, then the queue_depth is the
> > > > last thing that the client needs to worry about.
> > >
> > > Like what? for an example?
> >
> > Like accessing compromised block devices. If the queue_depth is
> > garbage, the client would fail at allocation with ENOMEM; thats it.
>
> The client will get wrong data, check it and discard. The case of ENOMEM triggered
> by remote side is different. It can cause to DDOS on the client.

True. This makes sense. Will drop this patch.

Thanks.

>
> Thanks
>
> >
> > >
> > > Thanks
