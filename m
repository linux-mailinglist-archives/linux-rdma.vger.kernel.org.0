Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8741B96EA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 08:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgD0GEQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 02:04:16 -0400
Received: from verein.lst.de ([213.95.11.211]:45564 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgD0GEQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 02:04:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D5D268CF0; Mon, 27 Apr 2020 08:04:12 +0200 (CEST)
Date:   Mon, 27 Apr 2020 08:04:11 +0200
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
Message-ID: <20200427060411.GA16186@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de> <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com> <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com> <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com> <20200423055447.GB9486@lst.de> <639d6edd-ffa6-f08a-9fa2-047ca97c47ee@mellanox.com> <20200424070647.GB24059@lst.de> <7ff771eb-078e-7eb1-d363-11f96b78eb64@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff771eb-078e-7eb1-d363-11f96b78eb64@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 26, 2020 at 12:48:18PM +0300, Max Gurtovoy wrote:
>> I see no reason not to support a simple Format NVM for our fabrics target
>> implementation.  But that isn't the point - you don't really need Format
>> as you can also control it from configfs in your series.  So for the
>> initial version I don't think we need Format NVM, but I don't mind
>> adding it later.
>
> so we're ok with passing -p in nvme-cli during connect command ?

PI should be enable by default.  We can think of a hook disabling it,
but please keep it at the end of the series.
