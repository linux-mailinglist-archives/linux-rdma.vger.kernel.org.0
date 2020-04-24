Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA51B6EAD
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 09:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDXHMl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 03:12:41 -0400
Received: from verein.lst.de ([213.95.11.211]:33538 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgDXHMl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 03:12:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2435168CEE; Fri, 24 Apr 2020 09:12:38 +0200 (CEST)
Date:   Fri, 24 Apr 2020 09:12:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, sagi@grimberg.me, martin.petersen@oracle.com,
        jsmart2021@gmail.com, linux-rdma@vger.kernel.org,
        idanb@mellanox.com, axboe@kernel.dk, vladimirk@mellanox.com,
        oren@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
        jgg@mellanox.com
Subject: Re: [PATCH 13/17] nvme: Add Metadata Capabilities enumerations
Message-ID: <20200424071237.GD24059@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-15-maxg@mellanox.com> <20200421152407.GD10837@lst.de> <b4f77666-6be9-121d-4ca1-fc1887cbd92e@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4f77666-6be9-121d-4ca1-fc1887cbd92e@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 03:09:47PM +0300, Max Gurtovoy wrote:
>
> On 4/21/2020 6:24 PM, Christoph Hellwig wrote:
>> On Fri, Mar 27, 2020 at 08:15:41PM +0300, Max Gurtovoy wrote:
>>> From: Israel Rukshin <israelr@mellanox.com>
>>>
>>> The enumerations will be used to expose the namespace metadata format by
>>> the target.
>>>
>>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>>> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
>> I'd be tempted to use a separate enum and add a comment to which field
>> this relates.
>
> something like:
>
> +/* Metadata Capabilities */
> +enum {
> +       /* supports metadata being transferred as part of an extended LBA */
> +       NVME_NS_MC_META_EXT     = 1 << 0,
> +       /* supports metadata being transferred as part of a separate 
> buffer */
> +       NVME_NS_MC_META_BUF     = 1 << 1,
> +};

What about:

/* Identify Namespace Metadata Capabilities (MC): */
enum {
	NVME_MC_METADATA_PTR	= (1 << 0),
	NVME_MC_EXTENDED_LBA	= (1 << 1),
};

