Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5511B6EA1
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 09:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgDXHGu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 03:06:50 -0400
Received: from verein.lst.de ([213.95.11.211]:33492 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgDXHGu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 03:06:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF14068CEE; Fri, 24 Apr 2020 09:06:47 +0200 (CEST)
Date:   Fri, 24 Apr 2020 09:06:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, James Smart <jsmart2021@gmail.com>,
        linux-nvme@lists.infradead.org, kbusch@kernel.org,
        sagi@grimberg.me, martin.petersen@oracle.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling
 metadata/T10-PI support
Message-ID: <20200424070647.GB24059@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de> <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com> <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com> <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com> <20200423055447.GB9486@lst.de> <639d6edd-ffa6-f08a-9fa2-047ca97c47ee@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639d6edd-ffa6-f08a-9fa2-047ca97c47ee@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 10:30:44AM +0300, Max Gurtovoy wrote:
>
> On 4/23/2020 8:54 AM, Christoph Hellwig wrote:
>> On Thu, Apr 23, 2020 at 01:39:26AM +0300, Max Gurtovoy wrote:
>>> it's a bit late for me now so I probably wrote non standard sentence above.
>>>
>>> BUT what I meant to say is I would like to give the user an option to
>>> decide whether use E2E protection or not (of course a controller can
>>> control protected and non-protected namespaces :) )
>> I don't really have a problem with an opt-out, but I'd like to apply it
>> consistently over all transports.
>>
>>> AFAIK, there is no option to format a ns in NVMf (at least for RDMA there
>>> is only 1 lbaf exposed by the target) so i'm not sure how exactly this will
>>> work.
>> The NVMe protocol Format NVM support is independent of the transport.
>
> Ok, but it's not supported in Linux.
>
> Are you saying we should implement Format NVM for fabrics ? or stay 
> consistent for NVMf (and not nvmf + pci) ?

I see no reason not to support a simple Format NVM for our fabrics target
implementation.  But that isn't the point - you don't really need Format
as you can also control it from configfs in your series.  So for the
initial version I don't think we need Format NVM, but I don't mind
adding it later.
