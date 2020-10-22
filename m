Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B29295D47
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Oct 2020 13:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508763AbgJVLVG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Oct 2020 07:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507169AbgJVLVG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Oct 2020 07:21:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30EBA22267;
        Thu, 22 Oct 2020 11:21:04 +0000 (UTC)
Date:   Thu, 22 Oct 2020 14:21:00 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Avihai Horon <avihaih@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        "Leybovich, Yossi" <sleybo@amazon.com>
Subject: Re: New GID query API broke EFA
Message-ID: <20201022112100.GE2611066@unreal>
References: <3e956560-3c76-5f4b-b8fa-ad96483cd042@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e956560-3c76-5f4b-b8fa-ad96483cd042@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 22, 2020 at 01:58:29PM +0300, Gal Pressman wrote:
> Hi all,
>
> The new IOCTL query GID API 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query
> API to user space") currently breaks EFA, as ibv_query_gid() no longer works.
>
> The problem is that the IOCTL call checks for:
> 	if (!rdma_ib_or_roce(ib_dev, port_num))
> 		return -EOPNOTSUPP;
>
> EFA is neither of these, but it uses GIDs.
>
> Any objections to remove the check? Any other solutions come to mind?

We added this check to protect access to rdma_get_gid_attr() for devices
without GID table.
 1234         table = rdma_gid_table(device, port_num);
 1235         if (index < 0 || index >= table->sz)
 1236                 return ERR_PTR(-EINVAL);

So you can extend that function to return for table == NULL an error and
remove rdma_ib_or_roce()

Thanks

>
> Gal
