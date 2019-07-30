Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5431C7AC21
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfG3PTq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 11:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbfG3PTq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 11:19:46 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 173D020693;
        Tue, 30 Jul 2019 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564499985;
        bh=sjpJj9N+XWCLQQ8ovnXRoeAxzTYexRwIxEDc4XutAYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbRofjSVgNRUx5SRMOS5BprtXjGXQrTW8Fv8e0NG4hIkG+ZoBMEhy9A74gsM0Gi4p
         +e9DH49EEZsgGxg03Akv7O+WQoWVDwxYup2CvLoKpKKHBFK7GjuAqPkJMrZlwr6BVc
         RQbdqN7GAlUZlGDrNDAKV+hsdRrUTJFPf2rTthZU=
Date:   Tue, 30 Jul 2019 18:19:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/restrack: Track driver QP types in resource
 tracker
Message-ID: <20190730151936.GE4878@mtr-leonro.mtl.com>
References: <20190730110137.37826-1-galpress@amazon.com>
 <20190730133817.GC4878@mtr-leonro.mtl.com>
 <24f4f7e3-dada-5185-3988-2e821b321bc1@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24f4f7e3-dada-5185-3988-2e821b321bc1@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 30, 2019 at 04:49:52PM +0300, Gal Pressman wrote:
> On 30/07/2019 16:38, Leon Romanovsky wrote:
> > On Tue, Jul 30, 2019 at 02:01:37PM +0300, Gal Pressman wrote:
> >> The check for QP type different than XRC has wrongly excluded driver QP
> >> types from the resource tracker.
> >>
> >> Fixes: 78a0cd648a80 ("RDMA/core: Add resource tracking for create and destroy QPs")
> >
> > It is a little bit over to say "wrongly". At that time, we did it on purpose
> > because it was unclear how to represent such QP types to users and we didn't
> > have vendor specific hooks introduced by Steve later on.
>
> It's very confusing to see a test running and zero QPs in "rdma res".
> I'm fine with removing the "wrongly" :), but I still think this should be
> targeted to for-rc as a bug fix.

Yes, please remove "wrongly" and change Fixes line to be
"Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")",
because before addition of EFA driver all other drivers had QPs.

>
> >
> > I would like to see the output or "rdma res" and "rdma res show qp" with
> > running driver QP after your change.
>
> gal@server [~] $ rdma res
> 0: efa_0: pd 2 cq 4 qp 2 cm_id 0 mr 2 ctx 2
> gal@server [~] $ rdma res show qp
> link efa_0/1 lqpn 0 type UNKNOWN state RTS sq-psn 13400680 pdn 0 pid 17847 comm ib_send_bw
> link efa_0/1 lqpn 1 type UNKNOWN state RTR sq-psn 0 pdn 1 pid 17820 comm ib_send_bw
>
> We can change the UNKNOWN to DRIVER/something else in userspace code.

We need to change it too.

Thanks
