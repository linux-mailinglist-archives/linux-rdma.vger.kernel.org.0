Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA531858DC
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2020 03:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgCOCYO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 Mar 2020 22:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgCOCYO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C4502077F;
        Sat, 14 Mar 2020 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584209249;
        bh=RQkHCb1V2kEI9pFFfoI25oa9CYBgPcUHi5PUzveIDqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sMVdO4q5NOr9nktLHWjnBLOf1xm2las8bIjC2NKWuYNow6CIS2EqPBkuE5fUdOydz
         2l18nZmzDkhls0cHMKDwAuqEFM4VJ7zD6FkFe1/uwXDRX07dBFY/zC5NXUdYKjG3tQ
         T/sAxgWeAyG+BuGBN3b640NyKtDWQAt1VA/IIudU=
Date:   Sat, 14 Mar 2020 20:07:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Andrew Boyer <aboyer@pensando.io>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Message-ID: <20200314180724.GH67638@unreal>
References: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
 <20200312092640.GA31504@unreal>
 <20200312170237.GS31668@ziepe.ca>
 <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
 <20200312172701.GV31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A0227E188@DGGEML522-MBX.china.huawei.com>
 <20200313121835.GA31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A02287DC3@DGGEML502-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A02287DC3@DGGEML502-MBS.china.huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 14, 2020 at 03:44:49AM +0000, liweihang wrote:
> On 2020/3/13 20:18, Jason Gunthorpe wrote:
> > On Fri, Mar 13, 2020 at 06:02:20AM +0000, liweihang wrote:
> >> On 2020/3/13 1:27, Jason Gunthorpe wrote:
> >>> On Thu, Mar 12, 2020 at 01:04:05PM -0400, Andrew Boyer wrote:
> >>>>    What would you say to a per-process env variable to disable locking in
> >>>>    a userspace provider?
> >>>
> >>> That is also a no. verbs now has 'thread domain' who's purpose is to
> >>> allow data plane locks to be skipped.
> >>>
> >>> Generally new env vars in verbs are going to face opposition from
> >>> me.
> >>>
> >>> Jason
> >>
> >> Thanks for your comments. Do you have some suggestions on how to
> >> achieve lockless flows in kernel? Are there any similar interfaces
> >> in kernel like the thread domain in userspace?
> >
> > It has never come up before
> >
> > Jason
> >
>
> Thank you, Jason. Could you please explain why it's not encouraged to
> use module parameters in kernel?
>
> What about the reason why we shouldn't add new environment variables
> in userspace? Do they have the same reason?

I don't know why my previous answer didn't appear in the ML, hope that
this will arrive.

The technical reasons to avoid environmental variables and kernel module
parameters are not the same, but very similar.

Environmental variables are not thread safe (in POSIX), inherited with
fork() and behaves differently in scripts. All this together makes them
as very bad user visible configuration interface.

Kernel module parameters are not welcomed due to their global nature,
difference between various drivers which makes hard for users to change
HW/scripts, almost impossible to deprecate e.t.c.

Thanks

>
> Weihang
