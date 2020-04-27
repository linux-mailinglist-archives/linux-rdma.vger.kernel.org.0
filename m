Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F0D1BA574
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgD0Nyd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 09:54:33 -0400
Received: from verein.lst.de ([213.95.11.211]:48280 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgD0Nyd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 09:54:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31B2268C7B; Mon, 27 Apr 2020 15:54:28 +0200 (CEST)
Date:   Mon, 27 Apr 2020 15:54:27 +0200
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
Message-ID: <20200427135427.GA2835@lst.de>
References: <20200421151747.GA10837@lst.de> <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com> <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com> <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com> <20200423055447.GB9486@lst.de> <639d6edd-ffa6-f08a-9fa2-047ca97c47ee@mellanox.com> <20200424070647.GB24059@lst.de> <7ff771eb-078e-7eb1-d363-11f96b78eb64@mellanox.com> <20200427060411.GA16186@lst.de> <2c6f172a-7923-6531-8d19-f8c496964b9d@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6f172a-7923-6531-8d19-f8c496964b9d@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 27, 2020 at 04:52:52PM +0300, Max Gurtovoy wrote:
> but the default format on NVMe pci drives is without metadata and to enable 
> it we do an NVM format command.

The defaut namespace format is entirely vendor specific for both
PCIe and Fabrics.  For OEMs that rely on PI the drives will usually
shipped with a PI-enabled format.
