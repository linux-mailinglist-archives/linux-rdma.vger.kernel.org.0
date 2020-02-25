Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E1E16EA94
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgBYPw6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 10:52:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40479 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbgBYPw6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Feb 2020 10:52:58 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so12462111otr.7
        for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2020 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AoqgMSpTiYU9W1gfS/QLjlAJBGHD5XoNMPODbMwV0Lk=;
        b=ApYnAqLp5idGJH5WPbW3fOHUgop2QBCdcphH31bGT9Ejf01hAcSYYiClQTooiNzqbk
         Li3tL1T0zY6Qmt15x49yPwzAIUh4wrOHJjxqBJYQziUs8nQLlNBhZo6S5tDBdJSsulI0
         QrauIOqAob2LyYf4Trc5MSibADdEcKWb6xzOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoqgMSpTiYU9W1gfS/QLjlAJBGHD5XoNMPODbMwV0Lk=;
        b=cfldCpthkhFx4OAHBVHkJPC/m0Nc9iwh5uYPh/tqrUiEuhSEhpo6JQxeMRaBV5zNqJ
         P5j8LGBchRBegY+hStMtX4W7wUQ0vPKPlhlTzeEXVRAdu5y9hpMIpKr93j1nS1grIx3t
         o1nFMP1BiyntyCQQPTYm/l1g/rkKmJKTfFeCcOYLbU9JC7VboJ6Kkom8NIuvcl2a648E
         Fhx9c5PVf87LwOVUnG3kGMBdH0GPNOZbTyV3npyinWH+WaiE6ljC++H0IsBX6kuOTv7g
         n8R8of/+qmV0OTSq4yHXfNObR64zdcPRsm4TomTwwwmKxi6Owq5D7G/sPLroe/NQ2DnX
         q1pQ==
X-Gm-Message-State: APjAAAUPqmBI0O5yrGDB2xs63u0M/OZS8zgkTWq6tkDsMWqjdB9725bK
        na7NIDVBZU1YBYUoejuGdhaqouP+wR2ZcwIt+N1Sxw==
X-Google-Smtp-Source: APXvYqw3L8xVVZn2JfTZJzHo04O9frbyuKtQVobcPfcDw8DES8QkRaFlwr99ctnEvfZzMCUl6waOytWF++EE3QbvXAU=
X-Received: by 2002:a9d:7511:: with SMTP id r17mr45399788otk.154.1582645977100;
 Tue, 25 Feb 2020 07:52:57 -0800 (PST)
MIME-Version: 1.0
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
 <1582541395-19409-4-git-send-email-selvin.xavier@broadcom.com>
 <20200224134338.GH26318@mellanox.com> <CA+sbYW2-SLiDNY26h7xgbR3+T3rsr5MTCX9QxORtvREa4vJu5w@mail.gmail.com>
 <20200225131638.GZ26318@mellanox.com>
In-Reply-To: <20200225131638.GZ26318@mellanox.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 25 Feb 2020 21:22:45 +0530
Message-ID: <CA+sbYW1d0yJeFM=gn=6CgYpiS6uMN1qDkECqpGLrURdGqJxPNA@mail.gmail.com>
Subject: Re: [PATCH for-next v2 3/3] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 25, 2020 at 6:46 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Tue, Feb 25, 2020 at 09:40:42AM +0530, Selvin Xavier wrote:
> > On Mon, Feb 24, 2020 at 7:13 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Mon, Feb 24, 2020 at 02:49:55AM -0800, Selvin Xavier wrote:
> > > >
> > > > @@ -1785,32 +1777,23 @@ static int __init bnxt_re_mod_init(void)
> > > >
> > > >  static void __exit bnxt_re_mod_exit(void)
> > > >  {
> > > > -     struct bnxt_re_dev *rdev, *next;
> > > > -     LIST_HEAD(to_be_deleted);
> > > > +     struct bnxt_re_dev *rdev;
> > > >
> > > > +     flush_workqueue(bnxt_re_wq);
> > >
> > > What is this for? Usually flushing a work queue before preventing new
> > > work from queueing (ie via unregister) is racy.
> > To flush out any netdev events scheduled to be handled by
> > bnxt_re_task. Mainly to wait for
> > case where we are in the middle of NETDEV_REGISTER event handled from
> > bnxt_re_task.
>
> Then the netdev notifer should be unregistered before doing the flush.
>
Agree that the netdev notifier should be unregistered before invoking
ib_unregister_driver
so that new device additions are prevented. I will move the unregister
code to the beginning of the mod_exit.
 But still we have to flush the bnxt_re_wq work queue.  bnxt_re_task
work is scheduled from netdev notifier. We need to make sure that
there are no pending work before proceeding with unregister.
 I will modify the code to  unregister notifier and then  delete
bnxt_re_wq workqueue before calling
ib_unregister_driver.
> Jason
