Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DFD3DDAE7
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhHBOYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbhHBOYS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 10:24:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51CFC09B13D
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 07:17:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p38so19056208lfa.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwDms3Y4aTQx7akZQL6jzCNGn1GluDtvl9bo30R0CA4=;
        b=frH/fMyNQk3WqSLcljvuj9FLp7AdgeZGSTcnaiLdDh3QZl2Ylipgk/amFztkBZLJtx
         hLnxmK2QagDOMJIhLdU0IkA2CR1F3JsH7fbanjgnlNdhVzbLNXZIR4SCd3Mqszdw3tly
         WO1uXyT2vcX+pGmR9dXrlXebLTxv+kiPIpYxmWXLgCpndFG/6LUMjwUlbVH18EiR37+7
         N45LdWHkS7BUBNO4tdSUlbckVEX6HCCbSQrFDgGrcsBBOhG1cmBFwTox1lbT2gkjWJcj
         Z9rUkxzqNnPxEFfdu1Dan9m8L2k0tglVGs/w+vk3PS9PTirkdtmiExU9bxJMCSQcA/qT
         6guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwDms3Y4aTQx7akZQL6jzCNGn1GluDtvl9bo30R0CA4=;
        b=snI9Q4RdjO5sl8slp0j8WNEYcQZ0ei53+qCJ1BTlGaZpGzCaLVeljCEvWelDew0u2w
         400mGcHlXQQX5ksLV4uALfuwAQp7diU4aWc0N4FjKj4lTI55wCsARTG2u8By/LyjE+ws
         AoRLU9UFuMZ8HA2BVW70UV+xESC/aVYL5ddohS60MVrEjmbTWYiBtnYzZYbmncKb8ScI
         +tFJaRj1ME7NfYN0hW1QL7xcDx/+Ssny92DaIJXTsqgLzBTgGAvx9gj3ewYd5VNQROTM
         00SbAURqUMgd+Uw50EXm42TbE5tssvC8uGktm81fOLBmEHNob0i430zFOxCe6V5UMorr
         A0WA==
X-Gm-Message-State: AOAM531BO9rCkb8AIU5lbXCXC1hDamxe86cikj6SHC9HEHiQaAxibw8O
        YqE/g9VzAZFjlRVeqAbIutjYYL+VeC8eIr/vCFTMWQ==
X-Google-Smtp-Source: ABdhPJylGs/MFRPFntvx4My7Gf6OhDbeXV8QEhJ3ukOgIo/SNMvoBCafk3hOn2nPMRLBlb6ZyAJHMVlY9EJ70qeDD8E=
X-Received: by 2002:a05:6512:537:: with SMTP id o23mr12454037lfc.58.1627913853041;
 Mon, 02 Aug 2021 07:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210730131832.118865-1-jinpu.wang@ionos.com> <20210730131832.118865-2-jinpu.wang@ionos.com>
 <YQeTUUMJNpyohHX/@unreal>
In-Reply-To: <YQeTUUMJNpyohHX/@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 2 Aug 2021 16:17:22 +0200
Message-ID: <CAJpMwyh0peojnNSAmyL9+GjVGi3nh+gQThTAWDUj-CB11TYO2A@mail.gmail.com>
Subject: Re: [PATCH for-next 01/10] RDMA/rtrs-clt: During add_path change
 for_new_clt according to path_num
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 2, 2021 at 8:40 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jul 30, 2021 at 03:18:23PM +0200, Jack Wang wrote:
> > From: Md Haris Iqbal <haris.iqbal@ionos.com>
> >
> > When all the paths are removed for a session, the addition of the first
> > path is like a new session for the storage server.
> >
> > Hence, for_new_clt has to be set to 1.
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index ece3205531b8..e048bfa12755 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -3083,6 +3083,15 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
> >       if (IS_ERR(sess))
> >               return PTR_ERR(sess);
> >
> > +     if (clt->paths_num == 0) {
>
> Don't you need some protection to read paths_num?
> rcu_read_lock() or mutex_lock?

Good catch. The lock should be added.

Thanks

>
> Thanks
