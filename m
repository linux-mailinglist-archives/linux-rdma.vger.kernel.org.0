Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505F742D965
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Oct 2021 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhJNMjF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 08:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJNMjF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Oct 2021 08:39:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688BC061570
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 05:37:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r19so25821997lfe.10
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWAwdoBPkLQkTmqMVKCOJ6kTzAAkptw/rnO0I6zV/TY=;
        b=micKAPGzz4leSXJ+PXa07Sa7Uf9aDswutv+ykR7aqBGGa9ia1Ywe7qP3U/8aaYqJKs
         EhRGKR00379vJRFXp/o3WPpoBj7LJJGTHNLczkvDDbgYjq4e7bKAuEOUwjRcgwSpyDP7
         vVj4odkVx3lV7cA8sXe+AMxPqDtggHs/BG+CZglEqZEVEEiVjkSQTyEcsfNzxoGDG8AX
         to/Z5s0Dav1aCm481VtAdiZ3/Z/S0fkGbzdUAVWsvp7WVOqUVDZhdAIAcqm+xiprDDe5
         F7JTzYNIIentu2ULVhJrd2OZnLPYKegGF7ylrUhDz4yqGrusuErxanCDzG32J/vf9uam
         BW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWAwdoBPkLQkTmqMVKCOJ6kTzAAkptw/rnO0I6zV/TY=;
        b=usWXkFfasp9Rk52y4Mjigwqb8uFKZGsj0Zg1XdsBlNzxCDrJpwn+wSND6SFRQJYYwN
         /l3Cg/mXCJQa4Ius3N9W1ac/v1MSRsma+y0VxKqgJxJpGHiCOLQQpC3kkxo7dTpYEWjD
         sLY3QTWGalT71IEfOILYiT+Do1LVeo6KV9WGXrSY7Z7aMFVwuAJagaJol8y7lfmuR7tQ
         jO6jSaY3T2bBGMiAhgW4SpTedTN6dHxQOz9wlCaG2Bd9NtZaRY9inlvD/RkWuQN/sC4O
         JWcMcTn0zbkHd6L5GcRaHXl2S4fIGYYUT6QBnnnyRg5iUuftKdrGvc0bnzaxRUfmL3ZX
         R0PA==
X-Gm-Message-State: AOAM530X/gNiDUnUmAwTz6YYyKFUbaplelY1enUAZtDA4aNwI2iHvzz8
        EY03mr9T+6Ml0vcpOQI8fczpVZwuZ4B0U0ULXMA=
X-Google-Smtp-Source: ABdhPJxC84hlNpdRMznRwaJoJRqHTXTOtyc1IDBfJO/BnQWSiKWVlt7XulLQR5/6ywcnF6jSs6xtXMT/G3rhnkblHKM=
X-Received: by 2002:a05:6512:39d0:: with SMTP id k16mr4934049lfu.571.1634215015999;
 Thu, 14 Oct 2021 05:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <34a9a53f-1f1f-bddb-0c8e-63ec5fbcd28e@gmail.com> <20211013150045.GG2744544@nvidia.com>
In-Reply-To: <20211013150045.GG2744544@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 14 Oct 2021 20:36:44 +0800
Message-ID: <CAD=hENcvfUbbhJ_fZ58A7KeyY74mGP2v4Q7D84nCnwJnBVmzBQ@mail.gmail.com>
Subject: Re: 10 more python test cases for rxe
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 13, 2021 at 11:00 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Oct 13, 2021 at 09:43:28AM -0500, Bob Pearson wrote:
> > Zhu,
> >
> > There are about 10 test cases in the python suite that do not run for rxe because
> >
> >       ... skipped "Device rxe0 doesn't have net interface"
> >
> > Clearly this is wrong and I don't know how to address the root cause yet but the following
> > hack where enp0s3 is the actual net device that rxe0 is based on in my case enables these
> > test cases to run and it appears they all do.
> >
> > diff --git a/tests/base.py b/tests/base.py
> >
> > index 3460c546..d6fd29b8 100644
> >
> >
> > +++ b/tests/base.py
> >
> > @@ -240,10 +240,11 @@ class RDMATestCase(unittest.TestCase):
> >
> >              if self.gid_type is not None and ctx.query_gid_type(port, idx) != \
> >
> >                      self.gid_type:
> >
> >                  continue
> >
> > -            if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
> >
> > -                self.args.append([dev, port, idx, None, None])
> >
> > -                continue
> >
> > -            net_name = self.get_net_name(dev)
> >
> > +            #if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>
> The pytests code is wrong - it should be querying the netdev through
> the verbs APIs, not hacking in sysfs like this.

Got it. Thanks

Zhu Yanjun

>
> Jason
