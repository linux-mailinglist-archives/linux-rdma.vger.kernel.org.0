Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9288A47C
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfHLRb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 13:31:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37784 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfHLRbC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 13:31:02 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9l-0002sT-OD; Mon, 12 Aug 2019 11:31:00 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9i-0002P7-Jc; Mon, 12 Aug 2019 11:30:50 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 12 Aug 2019 11:30:34 -0600
Message-Id: <20190812173048.9186-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, bhelgaas@google.com, hch@lst.de, Christian.Koenig@amd.com, jgg@mellanox.com, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, dan.j.williams@intel.com, epilmore@gigaio.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v3 00/14] PCI/P2PDMA: Support transactions that hit the host bridge
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Bjorn, this is v3 of the patchset. Christophs suggestion's required a
bit more rework than could be expressed in incremental patches so
I've resent the whole thing. I started with your p2pdma branch though
so it should have all the changes you already made. I've included a
range-diff from your p2pdma branch below.

A git branch is available here:

https://github.com/sbates130272/linux-p2pmem/ p2pdma_rc_map_v3

--

Changes in v3:
 * Rebase on v5.3-rc3 (No changes)
 * Bjorn's edits for a bunch of the comments and commit messages
 * Rework upstream_bridge_distance() changes to split the distance,
   mapping type and ACS flag into separate pass-by-reference parameters
   (per Christoph's suggestion)
 * Jonathan Derrick (Intel) reported the domains can be 32-bits on
   some machines and thus the map_type_index() needed to be an unsigned long
   to accomadate this.

Changes in v2:
 * Rebase on v5.3-rc2 (No changes)
 * Re-introduce the private pagemap structure and move the p2p-specific
   elements out of the commond dev_pagemap (per Christoph)
 * Use flags instead of bool in the whitelist (per Jason)
 * Only store the mapping type in the xarray (instead of the distance
   with flags) such that a function can return the mapping method
   with a switch statement to decide how to map. (per Christoph)
 * Drop find_parent_pci_dev() on the fast path and rely on the fact
   that the struct device passed to the mapping functions *must* be
   a PCI device and convert it directly. (per suggestions from
   Christoph and Jason)
 * Collected Christian's Reviewed-by's

--

As discussed on the list previously, in order to fully support the
whitelist Christian added with the IOMMU, we must ensure that we
map any buffer going through the IOMMU with an aprropriate dma_map
call. This patchset accomplishes this by cleaning up the output of
upstream_bridge_distance() to better indicate the mapping requirements,
caching these requirements in an xarray, then looking them up at map
time and applying the appropriate mapping method.

After this patchset, it's possible to use the NVMe-of P2P support to
transfer between devices without a switch on the whitelisted root
complexes. A couple Intel device I have tested this on have also
been added to the white list.

Most of the changes are contained within the p2pdma.c, but there are
a few minor touches to other subsystems, mostly to add support
to call an unmap function.

--

Logan Gunthorpe (14):
  PCI/P2PDMA: Introduce private pagemap structure
  PCI/P2PDMA: Add provider's pci_dev to pci_p2pdma_pagemap struct
  PCI/P2PDMA: Add constants for map type results to
    upstream_bridge_distance()
  PCI/P2PDMA: Factor out __upstream_bridge_distance()
  PCI/P2PDMA: Apply host bridge whitelist for ACS
  PCI/P2PDMA: Factor out host_bridge_whitelist()
  PCI/P2PDMA: Whitelist some Intel host bridges
  PCI/P2PDMA: Add attrs argument to pci_p2pdma_map_sg()
  PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
  PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
  PCI/P2PDMA: Store mapping method in an xarray
  PCI/P2PDMA: dma_map() requests that traverse the host bridge
  PCI/P2PDMA: Allow IOMMU for host bridge whitelist
  PCI/P2PDMA: Update pci_p2pdma_distance_many() documentation

 drivers/infiniband/core/rw.c |   6 +-
 drivers/nvme/host/pci.c      |  10 +-
 drivers/pci/p2pdma.c         | 374 +++++++++++++++++++++++++----------
 include/linux/memremap.h     |   1 -
 include/linux/pci-p2pdma.h   |  28 ++-
 5 files changed, 300 insertions(+), 119 deletions(-)

--

$ git range-diff bjorn/master..bjorn/pci/p2pdma master..p2pdma_rc_map_v3

 1:  5173c82b3571 =  1:  78cc3a5be538 PCI/P2PDMA: Introduce private pagemap structure
 2:  f33fd6b8da93 =  2:  9fb388dff957 PCI/P2PDMA: Add provider's pci_dev to pci_p2pdma_pagemap struct
 3:  767f47b59702 <  -:  ------------ PCI/P2PDMA: Add constants for not-supported result upstream_bridge_distance()
 -:  ------------ >  3:  ed105432f644 PCI/P2PDMA: Add constants for map type results to upstream_bridge_distance()
 4:  93ed41974d69 !  4:  590aaea31997 PCI/P2PDMA: Factor out __upstream_bridge_distance()
    @@ -17,8 +17,8 @@
      --- a/drivers/pci/p2pdma.c
      +++ b/drivers/pci/p2pdma.c
     @@
    - 	P2PDMA_NOT_SUPPORTED		= 0x08000000,
    - };
    + 	return false;
    + }

     -/*
     - * Find the distance through the nearest common upstream bridge between
    @@ -44,31 +44,29 @@
     - * port of the switch, to the common upstream port, back up to the second
     - * downstream port and then to Device B.
     - *
    -- * Any two devices that cannot communicate using p2pdma will return the
    -- * distance with the flag P2PDMA_NOT_SUPPORTED.
    +- * Any two devices that cannot communicate using p2pdma will return
    +- * PCI_P2PDMA_MAP_NOT_SUPPORTED.
     - *
     - * Any two devices that have a data path that goes through the host bridge
     - * will consult a whitelist. If the host bridges are on the whitelist,
    -- * the distance will be returned with the flag P2PDMA_THRU_HOST_BRIDGE set.
    -- * If either bridge is not on the whitelist, the flag P2PDMA_NOT_SUPPORTED will
    -- * be set.
    +- * this function will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE.
    +- *
    +- * If either bridge is not on the whitelist this function returns
    +- * PCI_P2PDMA_MAP_NOT_SUPPORTED.
     - *
    -- * If a bridge which has any ACS redirection bits set is in the path
    -- * this function will flag the result with P2PDMA_ACS_FORCES_UPSTREAM.
    -- * In this case, a list of all infringing bridge addresses will be
    -- * populated in acs_list (assuming it's non-null) for printk purposes.
    +- * If a bridge which has any ACS redirection bits set is in the path,
    +- * acs_redirects will be set to true. In this case, a list of all infringing
    +- * bridge addresses will be populated in acs_list (assuming it's non-null)
    +- * for printk purposes.
     - */
    --static int upstream_bridge_distance(struct pci_dev *provider,
    --				    struct pci_dev *client,
    --				    struct seq_buf *acs_list)
    -+static int __upstream_bridge_distance(struct pci_dev *provider,
    -+				      struct pci_dev *client,
    -+				      struct seq_buf *acs_list)
    + static enum pci_p2pdma_map_type
    +-upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
    ++__upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
    + 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
      {
      	struct pci_dev *a = provider, *b = client, *bb;
    - 	int dist_a = 0;
     @@
    - 	return dist_a + dist_b;
    + 	return PCI_P2PDMA_MAP_BUS_ADDR;
      }

     +/*
    @@ -95,27 +93,29 @@
     + * port of the switch, to the common upstream port, back up to the second
     + * downstream port and then to Device B.
     + *
    -+ * Any two devices that cannot communicate using p2pdma will return the
    -+ * distance with the flag P2PDMA_NOT_SUPPORTED.
    ++ * Any two devices that cannot communicate using p2pdma will return
    ++ * PCI_P2PDMA_MAP_NOT_SUPPORTED.
     + *
     + * Any two devices that have a data path that goes through the host bridge
     + * will consult a whitelist. If the host bridges are on the whitelist,
    -+ * the distance will be returned with the flag P2PDMA_THRU_HOST_BRIDGE set.
    -+ * If either bridge is not on the whitelist, the flag P2PDMA_NOT_SUPPORTED will
    -+ * be set.
    ++ * this function will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE.
     + *
    -+ * If a bridge which has any ACS redirection bits set is in the path
    -+ * this function will flag the result with P2PDMA_ACS_FORCES_UPSTREAM.
    -+ * In this case, a list of all infringing bridge addresses will be
    -+ * populated in acs_list (assuming it's non-null) for printk purposes.
    ++ * If either bridge is not on the whitelist this function returns
    ++ * PCI_P2PDMA_MAP_NOT_SUPPORTED.
    ++ *
    ++ * If a bridge which has any ACS redirection bits set is in the path,
    ++ * acs_redirects will be set to true. In this case, a list of all infringing
    ++ * bridge addresses will be populated in acs_list (assuming it's non-null)
    ++ * for printk purposes.
     + */
    -+static int upstream_bridge_distance(struct pci_dev *provider,
    -+				    struct pci_dev *client,
    -+				    struct seq_buf *acs_list)
    ++static enum pci_p2pdma_map_type
    ++upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
    ++		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
     +{
    -+	return __upstream_bridge_distance(provider, client, acs_list);
    ++	return __upstream_bridge_distance(provider, client, dist,
    ++					  acs_redirects, acs_list);
     +}
     +
    - static int upstream_bridge_distance_warn(struct pci_dev *provider,
    - 					 struct pci_dev *client)
    - {
    + static enum pci_p2pdma_map_type
    + upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
    + 			      int *dist)
 5:  f975e51cf5df <  -:  ------------ PCI/P2PDMA: Apply host bridge whitelist for ACS
 -:  ------------ >  5:  336e968f075b PCI/P2PDMA: Apply host bridge whitelist for ACS
 6:  59b6507ac07c !  6:  3f565ce6e1d4 PCI/P2PDMA: Factor out host_bridge_whitelist()
    @@ -58,15 +58,16 @@
     +	return false;
     +}
     +
    - enum {
    - 	/*
    - 	 * These arbitrary offset are or'd onto the upstream distance
    + static enum pci_p2pdma_map_type
    + __upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
    + 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
     @@
    - 	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
    - 		return dist;
    + 					      acs_redirects, acs_list);

    --	if (root_complex_whitelist(provider) && root_complex_whitelist(client))
    -+	if (host_bridge_whitelist(provider, client))
    - 		return dist;
    + 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
    +-		if (!root_complex_whitelist(provider) ||
    +-		    !root_complex_whitelist(client))
    ++		if (!host_bridge_whitelist(provider, client))
    + 			return PCI_P2PDMA_MAP_NOT_SUPPORTED;
    + 	}

    - 	return dist | P2PDMA_NOT_SUPPORTED;
 7:  5ecec567445f =  7:  7b8701dd45e0 PCI/P2PDMA: Whitelist some Intel host bridges
 8:  68a37758d5cf =  8:  b52771ae7f95 PCI/P2PDMA: Add attrs argument to pci_p2pdma_map_sg()
 9:  4b821298d4f7 =  9:  88a554eb39c9 PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
10:  3f2dac803737 = 10:  604260bd186a PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
11:  fc402d621534 ! 11:  b55fc423a41a PCI/P2PDMA: Store mapping method in an xarray
    @@ -18,14 +18,10 @@
      #include <linux/seq_buf.h>
      #include <linux/iommu.h>
     +#include <linux/xarray.h>
    -+
    -+enum pci_p2pdma_map_type {
    -+	PCI_P2PDMA_MAP_UNKNOWN = 0,
    -+	PCI_P2PDMA_MAP_NOT_SUPPORTED,
    -+	PCI_P2PDMA_MAP_BUS_ADDR,
    -+	PCI_P2PDMA_MAP_THRU_IOMMU,
    -+};

    + enum pci_p2pdma_map_type {
    + 	PCI_P2PDMA_MAP_UNKNOWN = 0,
    +@@
      struct pci_p2pdma {
      	struct gen_pool *pool;
      	bool p2pmem_published;
    @@ -51,10 +47,10 @@
      	if (!p2p->pool)
      		goto out;
     @@
    - 	return dist_a + dist_b;
    + 	return PCI_P2PDMA_MAP_BUS_ADDR;
      }

    -+static int map_types_idx(struct pci_dev *client)
    ++static unsigned long map_types_idx(struct pci_dev *client)
     +{
     +	return (pci_domain_nr(client->bus) << 16) |
     +		(client->bus->number << 8) | client->devfn;
    @@ -64,37 +60,17 @@
       * Find the distance through the nearest common upstream bridge between
       * two PCI devices.
     @@
    - 				    struct pci_dev *client,
    - 				    struct seq_buf *acs_list)
    - {
    -+	enum pci_p2pdma_map_type map_type;
    - 	int dist;
    -
    - 	dist = __upstream_bridge_distance(provider, client, acs_list);

    --	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
    --		return dist;
    -+	if (!(dist & P2PDMA_THRU_HOST_BRIDGE)) {
    -+		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
    -+		goto store_map_type_and_return;
    -+	}
    -+
    -+	if (host_bridge_whitelist(provider, client)) {
    -+		map_type = PCI_P2PDMA_MAP_THRU_IOMMU;
    -+	} else {
    -+		dist |= P2PDMA_NOT_SUPPORTED;
    -+		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
    -+	}
    + 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
    + 		if (!host_bridge_whitelist(provider, client))
    +-			return PCI_P2PDMA_MAP_NOT_SUPPORTED;
    ++			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
    + 	}

    --	if (host_bridge_whitelist(provider, client))
    --		return dist;
    -+store_map_type_and_return:
     +	if (provider->p2pdma)
     +		xa_store(&provider->p2pdma->map_types, map_types_idx(client),
     +			 xa_mk_value(map_type), GFP_KERNEL);
    -
    --	return dist | P2PDMA_NOT_SUPPORTED;
    -+	return dist;
    ++
    + 	return map_type;
      }

    - static int upstream_bridge_distance_warn(struct pci_dev *provider,
12:  c51eb851e9da ! 12:  94e4c8633459 PCI/P2PDMA: dma_map() requests that traverse the host bridge
    @@ -44,7 +44,7 @@
     +	client = to_pci_dev(dev);
     +
     +	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
    -+	case PCI_P2PDMA_MAP_THRU_IOMMU:
    ++	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
     +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
     +	case PCI_P2PDMA_MAP_BUS_ADDR:
     +		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
    @@ -71,7 +71,7 @@
     +
     +	map_type = pci_p2pdma_map_type(p2p_pgmap->provider, client);
     +
    -+	if (map_type == PCI_P2PDMA_MAP_THRU_IOMMU)
    ++	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
     +		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
      }
      EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
13:  0a3468f51621 = 13:  f067cdb5b963 PCI/P2PDMA: Allow IOMMU for host bridge whitelist
14:  20c0cf9f4c9c = 14:  87c84b001dfa PCI/P2PDMA: Update pci_p2pdma_distance_many() documentation

--
2.20.1
