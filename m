Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73F25D77E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 13:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgIDLgY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 07:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbgIDLf2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Sep 2020 07:35:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0CEC061246
        for <linux-rdma@vger.kernel.org>; Fri,  4 Sep 2020 04:35:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so5782415wme.0
        for <linux-rdma@vger.kernel.org>; Fri, 04 Sep 2020 04:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vXeg97tthpHn3OO05TYv6MMMBFwUPr9qFdp5Cy/4dA=;
        b=fgxVF/KyrZotODBO6md3qVlmfLr1Yswld4L6UNDdmY8Kz2X24HlOcy5vpRpL4rQ530
         gSMb7ay6j29f8JitxNubbM84Y0Vy2awUgC9aVsr/VWAgZAPTtFx707gjGuJedrngffk/
         2rHELETgWgk8HSS6N24wNbk7FnfcXbSluqeNpyXRjqYcdFg0+4vKoB9DJVsSlHdCZKqe
         qGh43iCNHUEh5ck+UDqey9145ghDrCdoyWzi6zglY0HshYc6vAYNqqkE2hIPYMZsex/H
         toDwou6nj8xFEiZje4JFCGJNZZXBe5HqIEG4juqJhLHBAg/FxrEvzRxp3YxxOwxCN5Xi
         DWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vXeg97tthpHn3OO05TYv6MMMBFwUPr9qFdp5Cy/4dA=;
        b=HySQxjhLDgZpCMD6OqqS4Ym9Jnnt/WYXPPc3oNQvY1TB4uJc4a1C42hPuzoKgcYxXW
         TsEDILi5Ou1fpA0/Rxoj0K3ISbM3RbYGFyF5FxgBfr5iPE/PgsYdIdJRVqZkloFPr4iK
         LLuSKJRHmoHHdvbPTw2FDStr6ZLMGYJqQv4QrbaFxKwBg9pB4xZPy6q/3ZYS0mSS5lAE
         LAp/aigcqOyodBDKt9Jv3pGhV5zv8SatZDHF6oZzxeIEa4Vf6pvfBM72af1x5REY9k/i
         qYg7KPln7iOFo3vYCrTvVnEVsUMezP5w/i5OfFua4r+XXCSFxuQJgmdc645rCmQwPfXc
         gK3A==
X-Gm-Message-State: AOAM530x3/LbsImBebQwtdKwuZV4i//MxJHxYjrjtwvz6IdOjy6mADTj
        YyugFiEHbugAc9pJwNlpCen+8L/3kfb33XmAreVH
X-Google-Smtp-Source: ABdhPJw5wZGimxTw9n7szYlZ3p5Z+QDtX17dFoRAYKAcnXU2PfEgN70bforC8WZ9Bl4pCtP+K+rlOuQza/laTYmHQ/U=
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr7196762wmk.160.1599219326253;
 Fri, 04 Sep 2020 04:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org>
In-Reply-To: <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 4 Sep 2020 13:35:15 +0200
Message-ID: <CAHg0HuyGr8BfgBvXUG7N5WYyXKEzyh3i7eA=2XZxbW3zyXLTsA@mail.gmail.com>
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 3, 2020 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-09-02 01:04, Danil Kipnis wrote:
> > RTRS allows for reliable transmission of sg lists between two hosts
> > over rdma. It is optimised for block io. One can implement a client
> > and a server module on top of RTRS which would allow for reliable
> > transmission to a group of hosts.
> >
> > In the networking world this is called reliable multicast. I think one
> > can say that reliable multicast is an equivalent to what is called
> > "mirror" in the storage world. There is something called XoR network
> > coding which seems to be an equivalent of raid5. There is also Reed
> > Solomon network coding.
> >
> > Having a reliable multicast with coding rdma-based transport layer
> > would allow for very flexible and scalable designs of distributed
> > replication solutions based on different in-kernel transport, block
> > and replication drivers.
> >
> > What do you think?
>
> How will the resulting software differ from DRBD (other than that it
> uses RDMA)?

DRBD replicates disks (a local one with a remote one). The idea here
would be to replicate on the level of hosts, i.e. to support
replication inside the transport layer. A reliable mc on top of rtrs
would be more similar to a stack where an md-raid<x> sits on a client
on top of two or more imported srp/nvmeof/rnbd devices, but with an
ability to resync between remote machines directly.

> How will it be guaranteed that the resulting software does
> not suffer from the problems that have been solved by the introduction
> of the DRBD activity log
> (https://www.linbit.com/drbd-user-guide/users-guide-drbd-8-4/#s-activity-log)?

The above would require some kind of activity log also, I'm afraid.

>
> Thanks,
>
> Bart.
