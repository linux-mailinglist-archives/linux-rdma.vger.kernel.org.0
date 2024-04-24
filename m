Return-Path: <linux-rdma+bounces-2043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC738B01C2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 08:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127591F2353A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 06:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D829156F34;
	Wed, 24 Apr 2024 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luZtCrI6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A3156C78;
	Wed, 24 Apr 2024 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940087; cv=none; b=BzA8vLxWyBs4EZMabAoA9ZhRyCijQRZ162G1NbsM1uyC1btam21E5d+k6FEb4fK35Hv9MmK0wkqyOXJMvKmXSxBOh/A//ZBFXTKeurbUmDC8YkkNpJjruIV0TYsJas33JiRFNVkkb2gfXZjZAsBSmO/+H4JmsUjTkAZm+q2A/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940087; c=relaxed/simple;
	bh=A/yU00UYToEMGGAoCjRKkNLmgEdhkdVsgbR/GogUobM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGxphS8IJlQDJVTj9t+jxPBa+FUNCqgM/iH6LDSCRkqq8FwXwaxqEmZjyl0TGTJdOqlRLMCPI6sh/sP11SXG41ZyADSZpVr9K+IsF2kJjUFP42OwNzF0d/Uu8Aib4kFdYMTtWU2XDuRlxoE80OslAjjkCd5UKzKzGz5osEVDKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luZtCrI6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713940085; x=1745476085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A/yU00UYToEMGGAoCjRKkNLmgEdhkdVsgbR/GogUobM=;
  b=luZtCrI6NJ4hZoTxyweFuWeoGmj9zIo89mpVjXcs7jQh2OS4iVLFjomw
   tdC/3pbxr+QHmqIck+/AyKiUBvAAZeWVSBZj09MJ3M9nwgYLz9GsEQAqf
   0oSLsNrM+6S5m3PUPK7qLBGmugw2aY9ZJZRFqrbRn9mtRbkkQmqtg9KDc
   oktukNmufnVep9+dAaHIP6KWRRP5+kRLNh3yeM+lxvthq7w4Mg2pti2r5
   VQudD8G5qA6NlqrHGeQJH3OcwpWV23B2s534ynPOqF2xRobxRxDaPz27M
   gUFZAwjVOgeRO+OInHqYsb98pfJ6hnBug6l5JZmEmcVdfgJeCM1/gsgY2
   g==;
X-CSE-ConnectionGUID: aKOYmmtSSwamtm1le7GvJQ==
X-CSE-MsgGUID: TjIabWQWQaqQiCE53MssQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27009695"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27009695"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 23:28:04 -0700
X-CSE-ConnectionGUID: AwhU1BzwRhOjwMu5FW138Q==
X-CSE-MsgGUID: cW/Rgp99T5GE1XfoYNpitQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="29265418"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Apr 2024 23:28:00 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzW6n-0000wm-2Q;
	Wed, 24 Apr 2024 06:27:57 +0000
Date: Wed, 24 Apr 2024 14:27:38 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mkarsten@uwaterloo.ca, gal@nvidia.com, nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net/mlx4: Track RX allocation failures in a
 stat
Message-ID: <202404241411.3d5OJHs6-lkp@intel.com>
References: <20240423194931.97013-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423194931.97013-2-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/net-mlx4-Track-RX-allocation-failures-in-a-stat/20240424-035224
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240423194931.97013-2-jdamato%40fastly.com
patch subject: [PATCH net-next 1/3] net/mlx4: Track RX allocation failures in a stat
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240424/202404241411.3d5OJHs6-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 5ef5eb66fb428aaf61fb51b709f065c069c11242)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240424/202404241411.3d5OJHs6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404241411.3d5OJHs6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlx4/en_port.c:35:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/mellanox/mlx4/en_port.c:35:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/mellanox/mlx4/en_port.c:35:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/net/ethernet/mellanox/mlx4/en_port.c:167:3: warning: variable 'dropped' is uninitialized when used here [-Wuninitialized]
     167 |                 dropped += READ_ONCE(ring->dropped);
         |                 ^~~~~~~
   drivers/net/ethernet/mellanox/mlx4/en_port.c:154:39: note: initialize the variable 'dropped' to silence this warning
     154 |         unsigned long packets, bytes, dropped;
         |                                              ^
         |                                               = 0
   18 warnings generated.


vim +/dropped +167 drivers/net/ethernet/mellanox/mlx4/en_port.c

   149	
   150	void mlx4_en_fold_software_stats(struct net_device *dev)
   151	{
   152		struct mlx4_en_priv *priv = netdev_priv(dev);
   153		struct mlx4_en_dev *mdev = priv->mdev;
   154		unsigned long packets, bytes, dropped;
   155		int i;
   156	
   157		if (!priv->port_up || mlx4_is_master(mdev->dev))
   158			return;
   159	
   160		packets = 0;
   161		bytes = 0;
   162		for (i = 0; i < priv->rx_ring_num; i++) {
   163			const struct mlx4_en_rx_ring *ring = priv->rx_ring[i];
   164	
   165			packets += READ_ONCE(ring->packets);
   166			bytes   += READ_ONCE(ring->bytes);
 > 167			dropped += READ_ONCE(ring->dropped);
   168		}
   169		dev->stats.rx_packets = packets;
   170		dev->stats.rx_bytes = bytes;
   171		dev->stats.rx_missed_errors = dropped;
   172	
   173		packets = 0;
   174		bytes = 0;
   175		for (i = 0; i < priv->tx_ring_num[TX]; i++) {
   176			const struct mlx4_en_tx_ring *ring = priv->tx_ring[TX][i];
   177	
   178			packets += READ_ONCE(ring->packets);
   179			bytes   += READ_ONCE(ring->bytes);
   180		}
   181		dev->stats.tx_packets = packets;
   182		dev->stats.tx_bytes = bytes;
   183	}
   184	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

