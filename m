Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE81B6EA5
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 09:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgDXHJd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 03:09:33 -0400
Received: from verein.lst.de ([213.95.11.211]:33506 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgDXHJd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 03:09:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 73FD368CEE; Fri, 24 Apr 2020 09:09:30 +0200 (CEST)
Date:   Fri, 24 Apr 2020 09:09:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, sagi@grimberg.me, martin.petersen@oracle.com,
        jsmart2021@gmail.com, linux-rdma@vger.kernel.org,
        idanb@mellanox.com, axboe@kernel.dk, vladimirk@mellanox.com,
        oren@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
        jgg@mellanox.com
Subject: Re: [PATCH 08/17] nvme-rdma: add metadata/T10-PI support
Message-ID: <20200424070930.GC24059@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-10-maxg@mellanox.com> <20200421122030.GI26432@lst.de> <688ec4ba-78e8-0ba3-9ee9-3c19b3e7b0c6@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <688ec4ba-78e8-0ba3-9ee9-3c19b3e7b0c6@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 12:22:27PM +0300, Max Gurtovoy wrote:
>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>> index e38f8f7..23cc77e 100644
>>> --- a/drivers/nvme/host/rdma.c
>>> +++ b/drivers/nvme/host/rdma.c
>>> @@ -67,6 +67,9 @@ struct nvme_rdma_request {
>>>   	struct ib_cqe		reg_cqe;
>>>   	struct nvme_rdma_queue  *queue;
>>>   	struct nvme_rdma_sgl	data_sgl;
>>> +	/* Metadata (T10-PI) support */
>>> +	struct nvme_rdma_sgl	*md_sgl;
>>> +	bool			use_md;
>> Do we need a use_md flag vs just using md_sgl as a boolean and/or
>> using blk_integrity_rq?
>
> md_sgl will be used if we'll get a blk request with blk_integrity (memory 
> domain).
>
> use_md will be responsible for wire domain.
>
> so instead of this bool we can check in any place (after prev commit 
> changes):
>
> "
>
> if (queue->pi_support && nvme_ns_has_pi(ns))
>                 req->use_md = c.common.opcode == nvme_cmd_write ||
>                               c.common.opcode == nvme_cmd_read;
>
> "
>
> And this is less readable IMO.

It would obviously have to go into a little helper, but I really hate
adding lots of little fields caching easily derived information.  There
are a few exception, for example if we really need to not touch too
many cache lines.  Do you have a git tree with your current code?  That
might be a little easier to follow than the various patches, maybe
I can think of something better.

>>> +	if (blk_integrity_rq(rq)) {
>>> +		memset(req->md_sgl, 0, sizeof(struct nvme_rdma_sgl));
>> Why do we need this memset?
>
> just good practice we took from drivers/scsi/scsi_lib.c.
>
> It's not a must and I can remove it if needed and test it.

I think (and please double check) that we initialize all three fields
anyway, so the memset should not be needed.
