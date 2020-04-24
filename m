Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E731B6F6F
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 09:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgDXHyH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 03:54:07 -0400
Received: from verein.lst.de ([213.95.11.211]:33702 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgDXHyH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 03:54:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C99B568CEE; Fri, 24 Apr 2020 09:54:03 +0200 (CEST)
Date:   Fri, 24 Apr 2020 09:54:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, sagi@grimberg.me, martin.petersen@oracle.com,
        jsmart2021@gmail.com, linux-rdma@vger.kernel.org,
        idanb@mellanox.com, axboe@kernel.dk, vladimirk@mellanox.com,
        oren@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
        jgg@mellanox.com
Subject: Re: [PATCH 15/17] nvmet: Add metadata support for block devices
Message-ID: <20200424075403.GA24906@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-17-maxg@mellanox.com> <20200421153339.GF10837@lst.de> <3992e1fd-efad-0679-7817-f004b40cdc76@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3992e1fd-efad-0679-7817-f004b40cdc76@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 08:25:24PM +0300, Max Gurtovoy wrote:
>
> On 4/21/2020 6:33 PM, Christoph Hellwig wrote:
>> On Fri, Mar 27, 2020 at 08:15:43PM +0300, Max Gurtovoy wrote:
>>> -	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>>> +	if (!nvmet_check_transfer_len(req,
>>> +				      nvmet_rw_data_len(req) + req->md_len))
>> Shouldn't we also calculate the actual metadata length on the fly here?
>
> we calculate it during nvmet_init_req.

Indeed.  

>
>>
>>>   	blk_start_plug(&plug);
>>> +	if (req->use_md)
>> Can't we use a non-NULL req->md_sg or non-null req->md_sg_cnt as a
>> metadata supported indicator and remove the use_md flag?  Maybe wrap
>> them in a helper function that also checks for blk integrity support
>> using IS_ENABLED and we can skip the stubs as well.
>
> I'll replace it with:
>
> static inline bool nvmet_req_has_pi(struct nvmet_req *req)
> {
>         return req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns);
> }

Actually I think you can simply check for a non-0 md_len, as we always
set them at the same time.
