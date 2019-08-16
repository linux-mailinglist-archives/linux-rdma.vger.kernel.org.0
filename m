Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852119035C
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 15:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfHPNpp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 09:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfHPNpp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Aug 2019 09:45:45 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CD212064A;
        Fri, 16 Aug 2019 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565963142;
        bh=UCWndjtZXjAbWtgmcceNf4pUqug4mbXZnZIaQLgkPLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxJ2iR5h+xIe1jt5BtgwZ8Ff1tP+QU38Hu3K/Euw3zApGul7Kv0tW5saBIKIH8mzi
         qXR5kJpTTxmr6LjDDVJ3QXoI0fHKdN9gB92l0YzMQqcYRn21JkdSkmXHXx4q2zi5Ss
         v5pEEqwDYipZXGezQA+gScAT0ZyMb3mGQVw0Ojy0=
Date:   Fri, 16 Aug 2019 08:45:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v3 00/14] PCI/P2PDMA: Support transactions that hit the
 host bridge
Message-ID: <20190816134540.GO253360@google.com>
References: <20190812173048.9186-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812173048.9186-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 11:30:34AM -0600, Logan Gunthorpe wrote:
> Bjorn, this is v3 of the patchset. Christophs suggestion's required a
> bit more rework than could be expressed in incremental patches so
> I've resent the whole thing. I started with your p2pdma branch though
> so it should have all the changes you already made. I've included a
> range-diff from your p2pdma branch below.

I added Christoph's reviewed-by and replaced my pci/p2pdma branch with
this series, thanks!  This is all headed for v5.4.

> A git branch is available here:
> 
> https://github.com/sbates130272/linux-p2pmem/ p2pdma_rc_map_v3
> 
> --
> 
> Changes in v3:
>  * Rebase on v5.3-rc3 (No changes)
>  * Bjorn's edits for a bunch of the comments and commit messages
>  * Rework upstream_bridge_distance() changes to split the distance,
>    mapping type and ACS flag into separate pass-by-reference parameters
>    (per Christoph's suggestion)
>  * Jonathan Derrick (Intel) reported the domains can be 32-bits on
>    some machines and thus the map_type_index() needed to be an unsigned long
>    to accomadate this.
> 
> Changes in v2:
>  * Rebase on v5.3-rc2 (No changes)
>  * Re-introduce the private pagemap structure and move the p2p-specific
>    elements out of the commond dev_pagemap (per Christoph)
>  * Use flags instead of bool in the whitelist (per Jason)
>  * Only store the mapping type in the xarray (instead of the distance
>    with flags) such that a function can return the mapping method
>    with a switch statement to decide how to map. (per Christoph)
>  * Drop find_parent_pci_dev() on the fast path and rely on the fact
>    that the struct device passed to the mapping functions *must* be
>    a PCI device and convert it directly. (per suggestions from
>    Christoph and Jason)
>  * Collected Christian's Reviewed-by's
> 
> --
> 
> As discussed on the list previously, in order to fully support the
> whitelist Christian added with the IOMMU, we must ensure that we
> map any buffer going through the IOMMU with an aprropriate dma_map
> call. This patchset accomplishes this by cleaning up the output of
> upstream_bridge_distance() to better indicate the mapping requirements,
> caching these requirements in an xarray, then looking them up at map
> time and applying the appropriate mapping method.
> 
> After this patchset, it's possible to use the NVMe-of P2P support to
> transfer between devices without a switch on the whitelisted root
> complexes. A couple Intel device I have tested this on have also
> been added to the white list.
> 
> Most of the changes are contained within the p2pdma.c, but there are
> a few minor touches to other subsystems, mostly to add support
> to call an unmap function.
> 
> --
> 
> Logan Gunthorpe (14):
>   PCI/P2PDMA: Introduce private pagemap structure
>   PCI/P2PDMA: Add provider's pci_dev to pci_p2pdma_pagemap struct
>   PCI/P2PDMA: Add constants for map type results to
>     upstream_bridge_distance()
>   PCI/P2PDMA: Factor out __upstream_bridge_distance()
>   PCI/P2PDMA: Apply host bridge whitelist for ACS
>   PCI/P2PDMA: Factor out host_bridge_whitelist()
>   PCI/P2PDMA: Whitelist some Intel host bridges
>   PCI/P2PDMA: Add attrs argument to pci_p2pdma_map_sg()
>   PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
>   PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
>   PCI/P2PDMA: Store mapping method in an xarray
>   PCI/P2PDMA: dma_map() requests that traverse the host bridge
>   PCI/P2PDMA: Allow IOMMU for host bridge whitelist
>   PCI/P2PDMA: Update pci_p2pdma_distance_many() documentation
> 
>  drivers/infiniband/core/rw.c |   6 +-
>  drivers/nvme/host/pci.c      |  10 +-
>  drivers/pci/p2pdma.c         | 374 +++++++++++++++++++++++++----------
>  include/linux/memremap.h     |   1 -
>  include/linux/pci-p2pdma.h   |  28 ++-
>  5 files changed, 300 insertions(+), 119 deletions(-)
> 
> --
> 
> $ git range-diff bjorn/master..bjorn/pci/p2pdma master..p2pdma_rc_map_v3
> 
>  1:  5173c82b3571 =  1:  78cc3a5be538 PCI/P2PDMA: Introduce private pagemap structure
>  2:  f33fd6b8da93 =  2:  9fb388dff957 PCI/P2PDMA: Add provider's pci_dev to pci_p2pdma_pagemap struct
>  3:  767f47b59702 <  -:  ------------ PCI/P2PDMA: Add constants for not-supported result upstream_bridge_distance()
>  -:  ------------ >  3:  ed105432f644 PCI/P2PDMA: Add constants for map type results to upstream_bridge_distance()
>  4:  93ed41974d69 !  4:  590aaea31997 PCI/P2PDMA: Factor out __upstream_bridge_distance()
>     @@ -17,8 +17,8 @@
>       --- a/drivers/pci/p2pdma.c
>       +++ b/drivers/pci/p2pdma.c
>      @@
>     - 	P2PDMA_NOT_SUPPORTED		= 0x08000000,
>     - };
>     + 	return false;
>     + }
> 
>      -/*
>      - * Find the distance through the nearest common upstream bridge between
>     @@ -44,31 +44,29 @@
>      - * port of the switch, to the common upstream port, back up to the second
>      - * downstream port and then to Device B.
>      - *
>     -- * Any two devices that cannot communicate using p2pdma will return the
>     -- * distance with the flag P2PDMA_NOT_SUPPORTED.
>     +- * Any two devices that cannot communicate using p2pdma will return
>     +- * PCI_P2PDMA_MAP_NOT_SUPPORTED.
>      - *
>      - * Any two devices that have a data path that goes through the host bridge
>      - * will consult a whitelist. If the host bridges are on the whitelist,
>     -- * the distance will be returned with the flag P2PDMA_THRU_HOST_BRIDGE set.
>     -- * If either bridge is not on the whitelist, the flag P2PDMA_NOT_SUPPORTED will
>     -- * be set.
>     +- * this function will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE.
>     +- *
>     +- * If either bridge is not on the whitelist this function returns
>     +- * PCI_P2PDMA_MAP_NOT_SUPPORTED.
>      - *
>     -- * If a bridge which has any ACS redirection bits set is in the path
>     -- * this function will flag the result with P2PDMA_ACS_FORCES_UPSTREAM.
>     -- * In this case, a list of all infringing bridge addresses will be
>     -- * populated in acs_list (assuming it's non-null) for printk purposes.
>     +- * If a bridge which has any ACS redirection bits set is in the path,
>     +- * acs_redirects will be set to true. In this case, a list of all infringing
>     +- * bridge addresses will be populated in acs_list (assuming it's non-null)
>     +- * for printk purposes.
>      - */
>     --static int upstream_bridge_distance(struct pci_dev *provider,
>     --				    struct pci_dev *client,
>     --				    struct seq_buf *acs_list)
>     -+static int __upstream_bridge_distance(struct pci_dev *provider,
>     -+				      struct pci_dev *client,
>     -+				      struct seq_buf *acs_list)
>     + static enum pci_p2pdma_map_type
>     +-upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
>     ++__upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
>     + 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
>       {
>       	struct pci_dev *a = provider, *b = client, *bb;
>     - 	int dist_a = 0;
>      @@
>     - 	return dist_a + dist_b;
>     + 	return PCI_P2PDMA_MAP_BUS_ADDR;
>       }
> 
>      +/*
>     @@ -95,27 +93,29 @@
>      + * port of the switch, to the common upstream port, back up to the second
>      + * downstream port and then to Device B.
>      + *
>     -+ * Any two devices that cannot communicate using p2pdma will return the
>     -+ * distance with the flag P2PDMA_NOT_SUPPORTED.
>     ++ * Any two devices that cannot communicate using p2pdma will return
>     ++ * PCI_P2PDMA_MAP_NOT_SUPPORTED.
>      + *
>      + * Any two devices that have a data path that goes through the host bridge
>      + * will consult a whitelist. If the host bridges are on the whitelist,
>     -+ * the distance will be returned with the flag P2PDMA_THRU_HOST_BRIDGE set.
>     -+ * If either bridge is not on the whitelist, the flag P2PDMA_NOT_SUPPORTED will
>     -+ * be set.
>     ++ * this function will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE.
>      + *
>     -+ * If a bridge which has any ACS redirection bits set is in the path
>     -+ * this function will flag the result with P2PDMA_ACS_FORCES_UPSTREAM.
>     -+ * In this case, a list of all infringing bridge addresses will be
>     -+ * populated in acs_list (assuming it's non-null) for printk purposes.
>     ++ * If either bridge is not on the whitelist this function returns
>     ++ * PCI_P2PDMA_MAP_NOT_SUPPORTED.
>     ++ *
>     ++ * If a bridge which has any ACS redirection bits set is in the path,
>     ++ * acs_redirects will be set to true. In this case, a list of all infringing
>     ++ * bridge addresses will be populated in acs_list (assuming it's non-null)
>     ++ * for printk purposes.
>      + */
>     -+static int upstream_bridge_distance(struct pci_dev *provider,
>     -+				    struct pci_dev *client,
>     -+				    struct seq_buf *acs_list)
>     ++static enum pci_p2pdma_map_type
>     ++upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
>     ++		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
>      +{
>     -+	return __upstream_bridge_distance(provider, client, acs_list);
>     ++	return __upstream_bridge_distance(provider, client, dist,
>     ++					  acs_redirects, acs_list);
>      +}
>      +
>     - static int upstream_bridge_distance_warn(struct pci_dev *provider,
>     - 					 struct pci_dev *client)
>     - {
>     + static enum pci_p2pdma_map_type
>     + upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
>     + 			      int *dist)
>  5:  f975e51cf5df <  -:  ------------ PCI/P2PDMA: Apply host bridge whitelist for ACS
>  -:  ------------ >  5:  336e968f075b PCI/P2PDMA: Apply host bridge whitelist for ACS
>  6:  59b6507ac07c !  6:  3f565ce6e1d4 PCI/P2PDMA: Factor out host_bridge_whitelist()
>     @@ -58,15 +58,16 @@
>      +	return false;
>      +}
>      +
>     - enum {
>     - 	/*
>     - 	 * These arbitrary offset are or'd onto the upstream distance
>     + static enum pci_p2pdma_map_type
>     + __upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
>     + 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
>      @@
>     - 	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
>     - 		return dist;
>     + 					      acs_redirects, acs_list);
> 
>     --	if (root_complex_whitelist(provider) && root_complex_whitelist(client))
>     -+	if (host_bridge_whitelist(provider, client))
>     - 		return dist;
>     + 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
>     +-		if (!root_complex_whitelist(provider) ||
>     +-		    !root_complex_whitelist(client))
>     ++		if (!host_bridge_whitelist(provider, client))
>     + 			return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>     + 	}
> 
>     - 	return dist | P2PDMA_NOT_SUPPORTED;
>  7:  5ecec567445f =  7:  7b8701dd45e0 PCI/P2PDMA: Whitelist some Intel host bridges
>  8:  68a37758d5cf =  8:  b52771ae7f95 PCI/P2PDMA: Add attrs argument to pci_p2pdma_map_sg()
>  9:  4b821298d4f7 =  9:  88a554eb39c9 PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
> 10:  3f2dac803737 = 10:  604260bd186a PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
> 11:  fc402d621534 ! 11:  b55fc423a41a PCI/P2PDMA: Store mapping method in an xarray
>     @@ -18,14 +18,10 @@
>       #include <linux/seq_buf.h>
>       #include <linux/iommu.h>
>      +#include <linux/xarray.h>
>     -+
>     -+enum pci_p2pdma_map_type {
>     -+	PCI_P2PDMA_MAP_UNKNOWN = 0,
>     -+	PCI_P2PDMA_MAP_NOT_SUPPORTED,
>     -+	PCI_P2PDMA_MAP_BUS_ADDR,
>     -+	PCI_P2PDMA_MAP_THRU_IOMMU,
>     -+};
> 
>     + enum pci_p2pdma_map_type {
>     + 	PCI_P2PDMA_MAP_UNKNOWN = 0,
>     +@@
>       struct pci_p2pdma {
>       	struct gen_pool *pool;
>       	bool p2pmem_published;
>     @@ -51,10 +47,10 @@
>       	if (!p2p->pool)
>       		goto out;
>      @@
>     - 	return dist_a + dist_b;
>     + 	return PCI_P2PDMA_MAP_BUS_ADDR;
>       }
> 
>     -+static int map_types_idx(struct pci_dev *client)
>     ++static unsigned long map_types_idx(struct pci_dev *client)
>      +{
>      +	return (pci_domain_nr(client->bus) << 16) |
>      +		(client->bus->number << 8) | client->devfn;
>     @@ -64,37 +60,17 @@
>        * Find the distance through the nearest common upstream bridge between
>        * two PCI devices.
>      @@
>     - 				    struct pci_dev *client,
>     - 				    struct seq_buf *acs_list)
>     - {
>     -+	enum pci_p2pdma_map_type map_type;
>     - 	int dist;
>     -
>     - 	dist = __upstream_bridge_distance(provider, client, acs_list);
> 
>     --	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
>     --		return dist;
>     -+	if (!(dist & P2PDMA_THRU_HOST_BRIDGE)) {
>     -+		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
>     -+		goto store_map_type_and_return;
>     -+	}
>     -+
>     -+	if (host_bridge_whitelist(provider, client)) {
>     -+		map_type = PCI_P2PDMA_MAP_THRU_IOMMU;
>     -+	} else {
>     -+		dist |= P2PDMA_NOT_SUPPORTED;
>     -+		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
>     -+	}
>     + 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
>     + 		if (!host_bridge_whitelist(provider, client))
>     +-			return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>     ++			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
>     + 	}
> 
>     --	if (host_bridge_whitelist(provider, client))
>     --		return dist;
>     -+store_map_type_and_return:
>      +	if (provider->p2pdma)
>      +		xa_store(&provider->p2pdma->map_types, map_types_idx(client),
>      +			 xa_mk_value(map_type), GFP_KERNEL);
>     -
>     --	return dist | P2PDMA_NOT_SUPPORTED;
>     -+	return dist;
>     ++
>     + 	return map_type;
>       }
> 
>     - static int upstream_bridge_distance_warn(struct pci_dev *provider,
> 12:  c51eb851e9da ! 12:  94e4c8633459 PCI/P2PDMA: dma_map() requests that traverse the host bridge
>     @@ -44,7 +44,7 @@
>      +	client = to_pci_dev(dev);
>      +
>      +	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
>     -+	case PCI_P2PDMA_MAP_THRU_IOMMU:
>     ++	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>      +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>      +	case PCI_P2PDMA_MAP_BUS_ADDR:
>      +		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
>     @@ -71,7 +71,7 @@
>      +
>      +	map_type = pci_p2pdma_map_type(p2p_pgmap->provider, client);
>      +
>     -+	if (map_type == PCI_P2PDMA_MAP_THRU_IOMMU)
>     ++	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
>      +		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
>       }
>       EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
> 13:  0a3468f51621 = 13:  f067cdb5b963 PCI/P2PDMA: Allow IOMMU for host bridge whitelist
> 14:  20c0cf9f4c9c = 14:  87c84b001dfa PCI/P2PDMA: Update pci_p2pdma_distance_many() documentation
> 
> --
> 2.20.1
