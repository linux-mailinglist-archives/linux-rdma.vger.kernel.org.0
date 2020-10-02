Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1E280B7C
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 02:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgJBAEA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 20:04:00 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19879 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgJBAD7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 20:03:59 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f766e070001>; Thu, 01 Oct 2020 17:02:15 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 00:03:58 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 00:03:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3G6fKlctVpFQ1E8gT1pdOW6762ZSnSqf9tbK23ye/35RjZVBqN50zGu5b8xOp0Yc8+k+dQ7qVQYTZ1tXaWdtTNs0nY94U+S2TBl0Le+qqki+r0mU+qZOMJZe3A2Am1E8E5ApXpR01V93o1tAE51XQKoDn/1LDh2wtSqd9xOVnbdC0/Jf6CNdwoBuZWP5WDWx0GbiblkFV53u8TF6r+SUri0xvcBbCwbLC3wS/QajY+GYx9qi4u1Mi/+mZkryWe8LU4KyD+ULZ89ziyM9cNC5CwSsjD29vCayUEbNC00GHRAER9bPeOm4Bt8Y+l0PJek+C8xQhWt8bgPn35a5PfugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHyjJM1JbZRSbA+RJfjGmuGhBvHNzaeismrbxVuyA4E=;
 b=bCw31D4VY7ryChpo12eB0cX1vqGIRKR63rBLUZcZvd0LY1tazPFTZ/2hBq7QzlQyMz64el7WEwJUZnLQLZXHZA7nlYd5MOY1H7qACeC/hpORNQBANs/nl3QMB+87Hc+r3mcV5Tz52gkIoupCBR4yKpF97ml+lIyJ2u1CsHaVu3VmhQjTN4xkhBE7li5oAi/oWdci9gMZ519wHUFyTde+S17Dd5TWSH7AasVDBrhNWe6t8Pc7lpqHxF5gl96fu/AyrW1kQqwwG6t64PbN8HvaQODK3uowY+bmgCm5CJllmrMM2BmrFrzMWfD4RVtM+iIHvjfMo0sl+/8q+Fh7cL+S5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4618.namprd12.prod.outlook.com (2603:10b6:5:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Fri, 2 Oct
 2020 00:03:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Fri, 2 Oct 2020
 00:03:57 +0000
Date:   Thu, 1 Oct 2020 21:03:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v3 3/4] RDMA/core: Introduce new GID table
 query API
Message-ID: <20201002000356.GA1213435@nvidia.com>
References: <20200923165015.2491894-1-leon@kernel.org>
 <20200923165015.2491894-4-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200923165015.2491894-4-leon@kernel.org>
X-ClientProxiedBy: MN2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:23a::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:23a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Fri, 2 Oct 2020 00:03:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kO8YG-0055md-1u; Thu, 01 Oct 2020 21:03:56 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601596935; bh=ZHyjJM1JbZRSbA+RJfjGmuGhBvHNzaeismrbxVuyA4E=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=F9bT+l0s0Ge157PyfPnFWgQB8twNYntKTVNw/gt1bLOW3160cm9rQBmeYfEM/y249
         x+hoRdAnHxgSAM8ydg22rBpLwuhH1uD/NSo4LdCOoCqNpgNtZEamQ0A2HJGJcE2XFL
         anVJfw0zN4McpnU39BHJCplQDnKieqd5hcgTSntYBboWQPnklxUDq3d0VZyccsniaY
         1ZSvc0iFSpkTFdu09cBkpRfzfdOAzI0ijt1IfoGtnz976bU5JqP8o1Hun2RTZ0s3iv
         o0CzrxMwo+s0HReOikViroxzuQaeE2u3jY4MFeT2opeiy+fXGWO/PKuscEtgYD3Tn+
         vncZXfa0HcVkg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 23, 2020 at 07:50:14PM +0300, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Introduce rdma_query_gid_table which enables querying all the GID tables
> of a given device and copying the attributes of all valid GID entries to
> a provided buffer.
> 
> This API provides a faster way to query a GID table using single call and
> will be used in libibverbs to improve current approach that requires
> multiple calls to open, close and read multiple sysfs files for a single
> GID table entry.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/cache.c         | 73 ++++++++++++++++++++++++-
>  include/rdma/ib_cache.h                 |  3 +
>  include/uapi/rdma/ib_user_ioctl_verbs.h |  8 +++
>  3 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index cf49ac0b0aa6..211b88d17bc7 100644
> +++ b/drivers/infiniband/core/cache.c
> @@ -1247,6 +1247,74 @@ rdma_get_gid_attr(struct ib_device *device, u8 port_num, int index)
>  }
>  EXPORT_SYMBOL(rdma_get_gid_attr);
>  
> +/**
> + * rdma_query_gid_table - Reads GID table entries of all the ports of a device up to max_entries.
> + * @device: The device to query.
> + * @entries: Entries where GID entries are returned.
> + * @max_entries: Maximum number of entries that can be returned.
> + * Entries array must be allocated to hold max_entries number of entries.
> + * @num_entries: Updated to the number of entries that were successfully read.
> + *
> + * Returns number of entries on success or appropriate error code.
> + */
> +ssize_t rdma_query_gid_table(struct ib_device *device,
> +			     struct ib_uverbs_gid_entry *entries,
> +			     size_t max_entries)
> +{
> +	const struct ib_gid_attr *gid_attr;
> +	ssize_t num_entries = 0, ret;
> +	struct ib_gid_table *table;
> +	unsigned int port_num, i;
> +	struct net_device *ndev;
> +	unsigned long flags;
> +
> +	rdma_for_each_port(device, port_num) {
> +		if (!rdma_ib_or_roce(device, port_num))
> +			continue;
> +
> +		table = rdma_gid_table(device, port_num);
> +		read_lock_irqsave(&table->rwlock, flags);
> +		for (i = 0; i < table->sz; i++) {
> +			if (!is_gid_entry_valid(table->data_vec[i]))
> +				continue;
> +			if (num_entries >= max_entries) {
> +				ret = -EINVAL;
> +				goto err;
> +			}
> +
> +			gid_attr = &table->data_vec[i]->attr;
> +
> +			memcpy(&entries->gid, &gid_attr->gid,
> +			       sizeof(gid_attr->gid));
> +			entries->gid_index = gid_attr->index;
> +			entries->port_num = gid_attr->port_num;
> +			entries->gid_type = gid_attr->gid_type;

> +			rcu_read_lock();
> +			ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);

This can't call rdma_read_gid_attr_ndev_rcu(), that also obtains the
rwlock. rwlock can't be nested.

Why didn't lockdep explode on this?

This whole thing can just be:

    ndev = rcu_dereference_protected(gid_attr->ndev, lockdep_is_held(&table->rwlock))
    if (ndev)
         entries->netdev_ifindex = ndev->ifindex;

Jason
