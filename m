Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6797F634A9
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 13:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfGILAj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 07:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfGILAj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 07:00:39 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDC120861;
        Tue,  9 Jul 2019 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562670039;
        bh=2XsTmWCfqT5Fa4cZZJO+REL76wsoOz4bHJL9fpj5At8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fv2pKjptyF2Liggy5U6pHGehR/sr+XnJc9c0WEuyy7ySwLU2b56IiehBJQGmE+L01
         xlHlExpoAGE+2HGAKp/6NhOXpQyxce/g9sPAM8ICnrVmGjM40ULx4oMsZfCLK3OUcZ
         fVFoY4HqmMr3Tya6T9R7gAF1C/rxnGQH9hc1kXfY=
Date:   Tue, 9 Jul 2019 14:00:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>, gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Message-ID: <20190709110036.GQ7034@mtr-leonro.mtl.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 09, 2019 at 11:55:03AM +0200, Danil Kipnis wrote:
> Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
>
> Could you please provide some feedback to the IBNBD driver and the
> IBTRS library?
> So far we addressed all the requests provided by the community and
> continue to maintain our code up-to-date with the upstream kernel
> while having an extra compatibility layer for older kernels in our
> out-of-tree repository.
> I understand that SRP and NVMEoF which are in the kernel already do
> provide equivalent functionality for the majority of the use cases.
> IBNBD on the other hand is showing higher performance and more
> importantly includes the IBTRS - a general purpose library to
> establish connections and transport BIO-like read/write sg-lists over
> RDMA, while SRP is targeting SCSI and NVMEoF is addressing NVME. While
> I believe IBNBD does meet the kernel coding standards, it doesn't have
> a lot of users, while SRP and NVMEoF are widely accepted. Do you think
> it would make sense for us to rework our patchset and try pushing it
> for staging tree first, so that we can proof IBNBD is well maintained,
> beneficial for the eco-system, find a proper location for it within
> block/rdma subsystems? This would make it easier for people to try it
> out and would also be a huge step for us in terms of maintenance
> effort.
> The names IBNBD and IBTRS are in fact misleading. IBTRS sits on top of
> RDMA and is not bound to IB (We will evaluate IBTRS with ROCE in the
> near future). Do you think it would make sense to rename the driver to
> RNBD/RTRS?

It is better to avoid "staging" tree, because it will lack attention of
relevant people and your efforts will be lost once you will try to move
out of staging. We are all remembering Lustre and don't want to see it
again.

Back then, you was asked to provide support for performance superiority.
Can you please share any numbers with us?

Thanks
