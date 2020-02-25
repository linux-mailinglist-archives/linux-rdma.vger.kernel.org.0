Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED1A16B881
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 05:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgBYEW5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 23:22:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34557 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgBYEW5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 23:22:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so11282872oig.1
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 20:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFTYVS0RaZc/A054BCkr4zuBPzcGsyZJ1rmRUP60tkc=;
        b=VI/JQhDjynGyB4gDL4xgxx/3H68uxyaqljpPvqtg8NT68d/JU8xDYBsJ5dStzU7rEK
         bdlEG+dTBd3XVh+gmbRF3SuOIvIokdX/yx27pdYqqjNkbNgCJSlKpszdqjqXEM2j4X/u
         h9ZBEczIg47c6eFAyjDuHL7bwTiHDmrvC2IL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFTYVS0RaZc/A054BCkr4zuBPzcGsyZJ1rmRUP60tkc=;
        b=JkhnvK6akKc7wgh0SSDlV+06h3PX3gpFGfdHhQCMFf4kkLAmYUzAijj+MWaFOc7AAU
         Eh944glsLkbGMRvD5aWeJ9max+l3kgieysTUUmqQWX6b8QVJ/uESmJ126e6j2lV9Q9lv
         mP03KM+Z2qelliKPjkCpVQxuCx6bX78d73Lh7QZcHi+3FaHgO3Y/LC6HPKIYowQyo0Y1
         eEqCrxIZ3ETsBNZsJrpsqJ3rpeiLaILwsjOmr9QLSKC2GJu9uThw7Wl1tDJRf4xPUrcF
         HBT2W4nl6JmD9pByxkXZAxWWNC4o0aIYBZS7LQlR1GJhG13O1wDB0S25uek/38C8qfEA
         cQ6g==
X-Gm-Message-State: APjAAAUcZLYMAfsAmtEANr6KzkoseAa+9krBl69nCA6G5bngys0sjV93
        +1aZ+WZY/hmIObogvTOa11LjMybXqzJLC7zgFVdvtYnW65dyhQ==
X-Google-Smtp-Source: APXvYqwHIkIm44tbEjUibr24jOehkS5KOPHpyX7IuFO4e0eJIo75HUL/pKkwOhP0S2LLKDwtcnmx6VXTqqKMeZGjxFM=
X-Received: by 2002:aca:ba55:: with SMTP id k82mr1928713oif.94.1582604576408;
 Mon, 24 Feb 2020 20:22:56 -0800 (PST)
MIME-Version: 1.0
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
 <1582541395-19409-3-git-send-email-selvin.xavier@broadcom.com> <20200224135358.GJ26318@mellanox.com>
In-Reply-To: <20200224135358.GJ26318@mellanox.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 25 Feb 2020 09:52:45 +0530
Message-ID: <CA+sbYW3zbVQtNkqbidjdqOsLBzwiLezgdytY=s8Hbi1LhF66yQ@mail.gmail.com>
Subject: Re: [PATCH for-next v2 2/3] RDMA/bnxt_re: Refactor device add/remove functionalities
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 7:24 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> >  static void bnxt_re_stop_irq(void *handle)
> > @@ -1317,7 +1320,37 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
> >               le16_to_cpu(resp.hwrm_intf_patch);
> >  }
> >
> > -static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
> > +static void bnxt_re_ib_uninit(struct bnxt_re_dev *rdev)
> > +{
> > +     /* Cleanup ib dev */
> > +     if (test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags)) {
> > +             ib_unregister_device(&rdev->ibdev);
> > +             clear_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
> > +     }
>
> The reason ib_unregister_device_queued exists is because you can't
> call unregistration while holding RTNL.
>
> >       case NETDEV_UNREGISTER:
> > @@ -1704,9 +1727,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
> >                */
> >               if (atomic_read(&rdev->sched_count) > 0)
> >                       goto exit;
> > -             bnxt_re_ib_unreg(rdev);
> > -             bnxt_re_remove_one(rdev);
> > -             bnxt_re_dev_unreg(rdev);
> > +             bnxt_re_ib_uninit(rdev);
> > +             bnxt_re_remove_device(rdev);
> >               break;
>
> ie here.
>
> This *must* simply be a call to ib_unregister_device_queued() and all
> this other stuff has to go into the dealloc.
>
> As written this is all kinds of deadlocking and racy
>

This patch (patch 2 of this series) was to refactor the existing code and
group the reg/unreg operations as bnxt_re_add_device/bnxt_re_remove_device.  The
third patch in this series is introducing the dealloc_driver hook and
changing the code as
you suggested by calling ib_unregister_device_queued/ ib_unregister_driver.
I didn't want to squash these two patches together.

-Selvin
> Jason
