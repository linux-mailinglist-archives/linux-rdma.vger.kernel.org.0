Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB712153E44
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 06:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgBFFaL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 00:30:11 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46491 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFFaK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 00:30:10 -0500
Received: by mail-io1-f65.google.com with SMTP id t26so4901159ioi.13
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 21:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSfuOloWYjvnfxXLD0Vw9hSIUL+t25CsRPCYenvSaBg=;
        b=ME3pDgvHDjtI+qbE0zmjepPncwdgVO/pEoFeEKtl0XDbXMsobpkxgIsrJqV63oXFe3
         qD9sCAereDdTbItenWUr5wlVfkueNqdYipRHGjIKn/oiTdKMEMvaYnKEoKl1qbpcgUpe
         dScwp2gTS6cy9ZNCHwGF4J6WJyN0sqJ08ti5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSfuOloWYjvnfxXLD0Vw9hSIUL+t25CsRPCYenvSaBg=;
        b=enIFbIFYNvRFbGQe69qu3rta0P0yRNAQqczSwxFypLXTwqtxnLtW33Q5iD0VSx/sy5
         EOq8tVgPhnXSPpdGRzkq4333mqYhNTHYetiTP2DJFq9Tt3+X2VFN4kCWDhZAXg8LLIdf
         18ghyeJFdX6QW+123buzUOF0IF00rUTnxULVuk7Rlsnx4vXj1nNuE/Qrel4UPVMxm1KD
         Bgtznt7qstBppiu6BWcHaSVKKPDxoIdRcE9IMQAW9EbiKDu1nJ4ULN8Ninw4uLvIzgD5
         BxE8xv7zvHb9ljGLQgoVKNUnIqlU4pSWoRvJkx6MFEJGc/FjZVqLlfems7Qx20zoSm6y
         y1fw==
X-Gm-Message-State: APjAAAXjb947kMzzIqR3s9GxhndWsM2HU5Gy0SDyXASv1hP/zRx0yoK4
        jOAXlFCrqaLus09rqtIiiMp3HGAtanjXqJ14sSxbMQ==
X-Google-Smtp-Source: APXvYqxqQW16Deu68JmtnQ1sWH2Y1YkF0dkPZm/BJ/z2mCN9SxCDj0TEiU4HjqgInPc0g3h9N/UloG/Sjw50tkGhG6o=
X-Received: by 2002:a5e:9246:: with SMTP id z6mr32878018iop.232.1580967008805;
 Wed, 05 Feb 2020 21:30:08 -0800 (PST)
MIME-Version: 1.0
References: <1580809644-5979-1-git-send-email-devesh.sharma@broadcom.com>
 <AM0PR05MB4866F91551DAE20160D39235D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CANjDDBhY5EkJpk-_yv1gM76ZidLk92WHokq2nZFAUqOUH_Q-CA@mail.gmail.com> <20200205190701.GD28298@ziepe.ca>
In-Reply-To: <20200205190701.GD28298@ziepe.ca>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 6 Feb 2020 10:59:32 +0530
Message-ID: <CANjDDBgoA5vh3tc=gNoOAdhD0HOT9Uu-bOiv8euBDPMRYd+vDw@mail.gmail.com>
Subject: Re: [PATCH v6] libibverbs: display gid type in ibv_devinfo
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Parav Pandit <parav@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 6, 2020 at 12:37 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Feb 04, 2020 at 08:56:54PM +0530, Devesh Sharma wrote:
> > On Tue, Feb 4, 2020 at 8:01 PM Parav Pandit <parav@mellanox.com> wrote:
> > >
> > > Hi Devesh,
> > >
> > > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > > owner@vger.kernel.org> On Behalf Of Devesh Sharma
> > > >       phys_state:     LINK_UP (5)
> > > >       GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
> > > >       GID[  1]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
> > > >       GID[  1]:       fe80::b226:28ff:fed3:b0f0
> > > Showing two entries as individual raw like this is surely confusing to user.
> > > Either all content should be in single raw or as Leon said just single different format for RoCEv2 is fine.
> > Yes, I liked the single display in new format, I would wait for Jason
> > to agree/disagree and then send a rev.
>
> Well, I wasn't thinking to display the GID[xx] prefix for the 2nd
> entry
>
> It seems like other people want to just show one, that seems OK too
Thanks for confirming, sending down V7 shortly please review.
>
> Jason
