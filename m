Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2B16F8CC
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 08:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgBZHw5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 02:52:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39245 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBZHw5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 02:52:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id 18so2122678oij.6
        for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2020 23:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Qrc5xT2sz6REbOAHXLeUHMLkZGURm1RL0HusglnOBA=;
        b=Y4/ipwN8PoXarnqlqMhpTZINKvS6WbuBMD/GZN3CrJLPr/ImS20IE0ramOz2zTTA4s
         Ja1JGAd4Ba36KjZrlOc9nQRGMYi2BCrCv8GfPcI+gpid9tUOmkWPZzjlLdoEf1cXGjiH
         R8lSo/aohC2e/1ROPnLiRzfUoJrtfVRQblBy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Qrc5xT2sz6REbOAHXLeUHMLkZGURm1RL0HusglnOBA=;
        b=h57dCGAktsj3rleBy6FLe3qynAImDHfJGQ97eokqT0LSEBld3NnLR2znLMrb0IZpAw
         TuesC6yZndXdmuhfzO/SL1eNYc7x6SyEVUiRv8VI1hWzN4UYfDUPkFN+8217DcOVk+o7
         Dl7FUQktSXmY4u300jSsVttKPjUXDrPJMZwREKHDstPFuaTAl7JCMhJXDapy+3Plzv7o
         H5QLJu5n9fmZZHpyIWk5V29T3C+dAVNlAi7+sp65AG4oERmdX2wzWboTdBU5GhMBMOvi
         nDmhHLwPVg1dfkzACJHBt1MAPnxVEuCmUdGHzMPGmGQWycyjwjpzj53m3z4io6HDFLVR
         dApA==
X-Gm-Message-State: APjAAAWAAnYwt79mPRKDgU8zXaA92xaSUHraqffsz+LDMQlG5apw9Ghr
        Fy1rH8/HZRTJc3LMVdZhF0OATasXFGzT8uK0yVxm7YpD
X-Google-Smtp-Source: APXvYqxgTTKVWtEtQLfARUeKXSs5WpPnCwtB8qpBcCrf2usvCo0iiDIzrBByjFf2AULHrc9vVxGVtvV74YkJTAPFvVM=
X-Received: by 2002:aca:f0b:: with SMTP id 11mr2170646oip.34.1582703576313;
 Tue, 25 Feb 2020 23:52:56 -0800 (PST)
MIME-Version: 1.0
References: <1582693794-23373-1-git-send-email-selvin.xavier@broadcom.com>
 <1582693794-23373-2-git-send-email-selvin.xavier@broadcom.com> <AM0PR05MB4866C0C2C9CB59C386C6FD17D1EA0@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB4866C0C2C9CB59C386C6FD17D1EA0@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed, 26 Feb 2020 13:22:45 +0530
Message-ID: <CA+sbYW2O9U2Kkci-3CF-h+Gjsm+s4V7kEuKCvuuzapUqekjOhQ@mail.gmail.com>
Subject: Re: [PATCH for-next v3 1/2] RDMA/bnxt_re: Refactor device add/remove functionalities
To:     Parav Pandit <parav@mellanox.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 26, 2020 at 10:58 AM Parav Pandit <parav@mellanox.com> wrote:
>
> Hi Selvin,
>
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Selvin Xavier
> >
>  [..]
> > +int bnxt_re_ib_init(struct bnxt_re_dev *rdev) {
> > +     int rc = 0;
> > +
> > +     /* Register ib dev */
> > +     rc = bnxt_re_register_ib(rdev);
> > +     if (rc) {
> > +             pr_err("Failed to register with IB: %#x\n", rc);
> > +             return rc;
> > +     }
> > +     set_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
> > +     dev_info(rdev_to_dev(rdev), "Device registered successfully");
> > +     ib_get_eth_speed(&rdev->ibdev, 1, &rdev->active_speed,
> > +                      &rdev->active_width);
> > +     set_bit(BNXT_RE_FLAG_ISSUE_ROCE_STATS, &rdev->flags);
> > +     bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1,
> > IB_EVENT_PORT_ACTIVE);
> What if the link is down at this point?
> I see that it was done this way before, but since you are refactoring, may be you want to relook?
> Do you still want to report it as active?
No.. Will change it based on the link status. thanks
>
> > +     bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1,
> > IB_EVENT_GID_CHANGE);
> > +
> GID addition, deletion decisions for RoCE ports are taken care by the IB core.
> So hw driver shouldn't report this event. Please remove this call.
Will do.
