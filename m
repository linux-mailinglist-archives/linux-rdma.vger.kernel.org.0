Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811391B546E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 07:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDWFxT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 01:53:19 -0400
Received: from verein.lst.de ([213.95.11.211]:56003 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgDWFxT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 01:53:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B760B227A81; Thu, 23 Apr 2020 07:53:15 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:53:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, sagi@grimberg.me, martin.petersen@oracle.com,
        jsmart2021@gmail.com, linux-rdma@vger.kernel.org,
        idanb@mellanox.com, axboe@kernel.dk, vladimirk@mellanox.com,
        oren@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
        jgg@mellanox.com
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling
 metadata/T10-PI support
Message-ID: <20200423055315.GA9486@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de> <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 01:07:47AM +0300, Max Gurtovoy wrote:
>
> On 4/21/2020 6:17 PM, Christoph Hellwig wrote:
>> On Fri, Mar 27, 2020 at 08:15:33PM +0300, Max Gurtovoy wrote:
>>> From: Israel Rukshin <israelr@mellanox.com>
>>>
>>> Preparation for adding metadata (T10-PI) over fabric support. This will
>>> allow end-to-end protection information passthrough and validation for
>>> NVMe over Fabric.
>> So actually - for PCIe we enable PI by default.  Not sure why RDMA would
>> be any different?  If we have a switch to turn it off we probably want
>> it work similar (can't be the same due to the lack of connect) for PCIe
>> as well.
>
> For PCI we use a format command to configure metadata. In fabrics we can 
> choose doing it in the connect command and we can also choose to have 
> "protected" controllers and "non-protected" controllers.
>
> I don't think it's all or nothing case, and configuration using nvme-cli 
> (or other tool) seems reasonable and flexible.

Format applies to a namespace and is not limited to PCIe.
