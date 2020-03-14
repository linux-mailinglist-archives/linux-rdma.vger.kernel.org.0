Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6F1858E6
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2020 03:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgCOCYs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 Mar 2020 22:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgCOCYO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BEC42074C;
        Sat, 14 Mar 2020 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584179371;
        bh=/TMoRcdmYvay8DeJDZubH32zeCJ/a4uKhLxLHQpm2Pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzMFxOQokiegEdMD3//V3XyLILA+pP1rAf331gq1rEDjuSVeArdv7uN7mD3UDSe+q
         loJtpCV9n3veAsEmoDEXRATdhYzpYDAO7s6eWU39VjVeRmeJYQbvb1JFAD/+MZN+Cl
         7fELzclfbocuuWiR9QeSd/KVaye6DQrQaSxTbmjY=
Date:   Sat, 14 Mar 2020 11:49:25 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Andrew Boyer <aboyer@pensando.io>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Message-ID: <20200314094925.GE67638@unreal>
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

No, the are discouraged for different technical reasons. There are many
reasons for not allowing them, but immediately comes into mind that
environmental variables are not thread safe, silently inherited by fork()
and have very interesting behavior in the scripts.

This makes environmental variables are the worst configuration "tool"
for the libraries.

Module parameters are bad due to inability to deprecate them, difference
between drivers that requires rewrite scripts/configs after driver/HW
change, global nature of the change and really painful experience for
the users if workload requires to change those defaults.

Thanks

>
> Weihang
