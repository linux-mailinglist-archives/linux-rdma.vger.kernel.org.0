Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1063D280D99
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 08:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgJBGpL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 02:45:11 -0400
Received: from verein.lst.de ([213.95.11.211]:51214 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgJBGpL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 02:45:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A2DCC68B02; Fri,  2 Oct 2020 08:45:06 +0200 (CEST)
Date:   Fri, 2 Oct 2020 08:45:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
Message-ID: <20201002064505.GA9593@lst.de>
References: <20200929091358.421086-1-leon@kernel.org> <20200929091358.421086-2-leon@kernel.org> <20200929102046.GA14445@lst.de> <20200929103549.GE3094@unreal> <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 11:24:49AM -0700, Sagi Grimberg wrote:
> Yes, basically usage of managed affinity caused people to report
> regressions not being able to change irq affinity from procfs.

Well, why would they change it?  The whole point of the infrastructure
is that there is a single sane affinity setting for a given setup. Now
that setting needed some refinement from the original series (e.g. the
current series about only using housekeeping cpus if cpu isolation is
in use).  But allowing random users to modify affinity is just a receipe
for a trainwreck.

So I think we need to bring this back ASAP, as doing affinity right
out of the box is an absolute requirement for sane performance without
all the benchmarketing deep magic.
