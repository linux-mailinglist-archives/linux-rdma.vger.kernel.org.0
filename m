Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925CB284521
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 06:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgJFE6G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 00:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgJFE6G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 00:58:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E71420782;
        Tue,  6 Oct 2020 04:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601960285;
        bh=No65u2z/JLmabKggIX1FzjIr8Y3OJWVr8Z7RrHC8IFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCVMV8QidVPtXU/OPsTicNP4Q6mD9B4onOLF+uqkufelA+VRt6KPk+l6FfiVzSm0d
         5jZqO2v+jiO0U3wh7ZjBC2vC7BBBSL157sXRkHPgF1yhRUDmDbs9GOULCZOeRWa+Fn
         DkqtE+BNDb3cZPJgUPH1Ax0pIKs2VzcQDDGY8qbE=
Date:   Tue, 6 Oct 2020 07:58:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
Message-ID: <20201006045800.GE1874917@unreal>
References: <20200929091358.421086-1-leon@kernel.org>
 <20200929091358.421086-2-leon@kernel.org>
 <20200929102046.GA14445@lst.de>
 <20200929103549.GE3094@unreal>
 <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me>
 <20201002064505.GA9593@lst.de>
 <14fab6a7-f7b5-2f9d-e01f-923b1c36816d@grimberg.me>
 <20201005083817.GA14908@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005083817.GA14908@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 05, 2020 at 10:38:17AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 02, 2020 at 01:20:35PM -0700, Sagi Grimberg wrote:
> >> Well, why would they change it?  The whole point of the infrastructure
> >> is that there is a single sane affinity setting for a given setup. Now
> >> that setting needed some refinement from the original series (e.g. the
> >> current series about only using housekeeping cpus if cpu isolation is
> >> in use).  But allowing random users to modify affinity is just a receipe
> >> for a trainwreck.
> >
> > Well allowing people to mangle irq affinity settings seem to be a hard
> > requirement from the discussions in the past.
> >
> >> So I think we need to bring this back ASAP, as doing affinity right
> >> out of the box is an absolute requirement for sane performance without
> >> all the benchmarketing deep magic.
> >
> > Well, it's hard to say that setting custom irq affinity settings is
> > deemed non-useful to anyone and hence should be prevented. I'd expect
> > that irq settings have a sane default that works and if someone wants to
> > change it, it can but there should be no guarantees on optimal
> > performance. But IIRC this had some dependencies on drivers and some
> > more infrastructure to handle dynamic changes...
>
> The problem is that people change random settings.  We need to generalize
> it into a sane API (e.g. the housekeeping CPUs thing which totally makes
> sense).

I don't see many people jump on the bandwagon, someone should do it, but
who will? I personally have no knowledge in that area to do anything
meaningful.

Thanks
