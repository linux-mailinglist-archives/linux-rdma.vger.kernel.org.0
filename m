Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6161D283231
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 10:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJEIiU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 04:38:20 -0400
Received: from verein.lst.de ([213.95.11.211]:58129 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgJEIiU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 04:38:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5276867373; Mon,  5 Oct 2020 10:38:17 +0200 (CEST)
Date:   Mon, 5 Oct 2020 10:38:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
Message-ID: <20201005083817.GA14908@lst.de>
References: <20200929091358.421086-1-leon@kernel.org> <20200929091358.421086-2-leon@kernel.org> <20200929102046.GA14445@lst.de> <20200929103549.GE3094@unreal> <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me> <20201002064505.GA9593@lst.de> <14fab6a7-f7b5-2f9d-e01f-923b1c36816d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14fab6a7-f7b5-2f9d-e01f-923b1c36816d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 02, 2020 at 01:20:35PM -0700, Sagi Grimberg wrote:
>> Well, why would they change it?  The whole point of the infrastructure
>> is that there is a single sane affinity setting for a given setup. Now
>> that setting needed some refinement from the original series (e.g. the
>> current series about only using housekeeping cpus if cpu isolation is
>> in use).  But allowing random users to modify affinity is just a receipe
>> for a trainwreck.
>
> Well allowing people to mangle irq affinity settings seem to be a hard
> requirement from the discussions in the past.
>
>> So I think we need to bring this back ASAP, as doing affinity right
>> out of the box is an absolute requirement for sane performance without
>> all the benchmarketing deep magic.
>
> Well, it's hard to say that setting custom irq affinity settings is
> deemed non-useful to anyone and hence should be prevented. I'd expect
> that irq settings have a sane default that works and if someone wants to
> change it, it can but there should be no guarantees on optimal
> performance. But IIRC this had some dependencies on drivers and some
> more infrastructure to handle dynamic changes...

The problem is that people change random settings.  We need to generalize
it into a sane API (e.g. the housekeeping CPUs thing which totally makes
sense).
