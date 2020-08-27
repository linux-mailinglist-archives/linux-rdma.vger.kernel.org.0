Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798092544B0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgH0MBr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgH0MBi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:01:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAFCC061264
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:01:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id oz20so7293174ejb.5
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3wVlYafljHaWL0nRnjti7Li5TZGMJDShEv2U9I1GYU=;
        b=ATb149kaLmHdvlEtqBOG6IzX9AWOTgMDWecgKxqHA9Gsz5TN244rPxoa7hw0IWWw5X
         lxxkxevhTlEX3chExpKG4Hw+EDQBhALwh6bMzlHH9YWVIy1rBeEnepNbGGjUL/rXkbBL
         HaNpvCZ6yPI6vUD77pXbYoMhjFTmP8CGehaWc79CD5v1TyuXy6s4/sHTMosbk2fEFyoI
         akxS4KJNk7v4dLl7adPKh0aL5S+34xoPcTBsQFEvssGI75edt9vNMk4DReos8e/jStTZ
         33WQkh31UakUy1eiXjmCKJpQy8QSUIxNXC/IPLaO6oaZwnKNtfJC6MGcn3XwQBE43g4r
         ijVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3wVlYafljHaWL0nRnjti7Li5TZGMJDShEv2U9I1GYU=;
        b=WJSMloc7ULB5HzggH8gc6nWDtvSqV/dvOUb4lEfyYuO0kUM0asYawT4YPntEybZjtL
         cKAGb1XCHv9TU59gbpC7+EWR3B5YZ2OTrZr9yR53gusY9lSfGPp8SvJeCqKJDU+5qYv+
         vMnBH35BYtRi5ww+F+QUtRjDHkaDdx1acXhsgGgRMwNIbhraOYUqMlwWLmhjx6w9B7sm
         ck2OTQNFRPdz86bcvdkvgIOLbyO875G6wFFt5cyMHHluUzhBzVEtDgQRSe2ohIf/JY6X
         Hf+i76XvFVewDBIr1XmAvPXpd6bxtFH4unESoFH6P5RPFZKtbcLPmPWHBZBbJtssVIo7
         PoRA==
X-Gm-Message-State: AOAM5333+9yD+rFkwaIykhq3DHwsMiVjoK0l3u/ewDe1FFpyrNIBgbrH
        UZwVv5dLUSjgfnsKiwLk8NMclJIt6M1KMvkC4CnX6w==
X-Google-Smtp-Source: ABdhPJy+MhUBBCIr1zb8fnThFlJVRtJ1vvb9yg2C9Lz/Q71VErFaXU6jRD2rGHaGKWovNxigyz1MHF0WBQDlvTifTgU=
X-Received: by 2002:a17:906:a441:: with SMTP id cb1mr10758380ejb.495.1598529679536;
 Thu, 27 Aug 2020 05:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200820034152.1660135-1-haris.iqbal@cloud.ionos.com> <20200827114526.GA3997016@nvidia.com>
In-Reply-To: <20200827114526.GA3997016@nvidia.com>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Thu, 27 Aug 2020 17:31:08 +0530
Message-ID: <CAJpMwyjg3c=TG7+BVoNHhyNZJ4-LbRM5wsWi9vHLsEJn8cuOZQ@mail.gmail.com>
Subject: Re: [PATCH v3] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 5:15 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Aug 20, 2020 at 09:11:52AM +0530, Md Haris Iqbal wrote:
>
> > +static int rtrs_srv_add_one(struct ib_device *device)
> > +{
> > +     struct rtrs_srv_ctx *ctx;
> > +     int ret;
> > +
> > +     if (ib_ctx.ib_dev_count)
> > +             goto out;
>
> Add's can run concurrently with remove and with other adds so this
> unlocked variable is racing

Hmm.. Didn't know that. Thanks, will update the patch and send.

>
> Jason



-- 

Regards
-Haris
