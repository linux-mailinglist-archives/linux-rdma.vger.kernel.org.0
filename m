Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0674186BB8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 14:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgCPNE3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 09:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730974AbgCPNE3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 09:04:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61388205ED;
        Mon, 16 Mar 2020 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584363869;
        bh=r/vjGY3srDcP5skU18egm65+dRfZOqRXKjw/qVyPMfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsaZjRkIgnPxXAnzPCiBL+G3r9BVhgucnbF7TUZDgWmW0gjFb0O30tWl0L/6S/9Fv
         +o1gUSY9HtxIhcu6HAesTXMuo9yH1q/g8HLMzawTEVs+5q530ROtfbuP46VnZ5GCOp
         qpnlhs873H7OoJguAtXEVAcitJ9f/TPjmpOYz6A4=
Date:   Mon, 16 Mar 2020 15:04:25 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     liweihang <liweihang@huawei.com>,
        Andrew Boyer <aboyer@pensando.io>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Message-ID: <20200316130425.GA42537@unreal>
References: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
 <20200312092640.GA31504@unreal>
 <20200312170237.GS31668@ziepe.ca>
 <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
 <20200312172701.GV31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A0227E188@DGGEML522-MBX.china.huawei.com>
 <20200313121835.GA31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A02287DC3@DGGEML502-MBS.china.huawei.com>
 <20200316121231.GB20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316121231.GB20941@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 16, 2020 at 09:12:31AM -0300, Jason Gunthorpe wrote:
> On Sat, Mar 14, 2020 at 03:44:49AM +0000, liweihang wrote:
> > On 2020/3/13 20:18, Jason Gunthorpe wrote:
> > > On Fri, Mar 13, 2020 at 06:02:20AM +0000, liweihang wrote:
> > >> On 2020/3/13 1:27, Jason Gunthorpe wrote:
> > >>> On Thu, Mar 12, 2020 at 01:04:05PM -0400, Andrew Boyer wrote:
> > >>>>    What would you say to a per-process env variable to disable locking in
> > >>>>    a userspace provider?
> > >>>
> > >>> That is also a no. verbs now has 'thread domain' who's purpose is to
> > >>> allow data plane locks to be skipped.
> > >>>
> > >>> Generally new env vars in verbs are going to face opposition from
> > >>> me.
> > >>>
> > >>> Jason
> > >>
> > >> Thanks for your comments. Do you have some suggestions on how to
> > >> achieve lockless flows in kernel? Are there any similar interfaces
> > >> in kernel like the thread domain in userspace?
> > >
> > > It has never come up before
> > >
> > > Jason
> > >
> >
> > Thank you, Jason. Could you please explain why it's not encouraged to
> > use module parameters in kernel?
>
> Behavior that effects the operation of a ULP should never be
> configured globally. The ULP must self-select this behavior
> pragmatically, only when it is safe.

Indeed, very good point.

I just want to add that for ULP it is very rare that module
parameters are the right choice either, because usually those parameters
change ULP behavior be suitable for specific workload.

Thanks

>
> Jason
