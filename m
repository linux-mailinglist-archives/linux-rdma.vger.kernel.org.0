Return-Path: <linux-rdma+bounces-2045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E58B035B
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 09:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F7F1F224C2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3D91581E7;
	Wed, 24 Apr 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+ojOGtE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F95157E82;
	Wed, 24 Apr 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944529; cv=none; b=SGCVwwjgbJo/aFY9ADBW8e1kzNICNRoYXqcDzFmaQmt7bfZt/hmHR1z5PRXrrFensj+j9DkSZJQFDJ7fVTRudHFab6wMr2ZWI7gNzQ3Do3At6k6/oMBWiubOMF4kXcqWyM6Ki1/fmT7RlmkbWqE0NrZ4iq8Vz+4LfWJShSz/OZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944529; c=relaxed/simple;
	bh=3jSAEAP6h7kLKxNdHKe1wEKkmll4W+mLBzqwPyPus3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx4O5wMw5GrnbkhiGXwHHIlsbpyaTDtLLR/8melng5o5XHTLPw6Fvm4kuOhQfOzfwoJpMMGQSTxaEuvBeUYFHkhRzxrJp4JC6asiQlOO1de0CJt1GAaNwwELd/wZ02L0uYx6TWV82Uvx9k9SMs3Yo3Ga//19WASc5roWT7yXBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+ojOGtE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713944527; x=1745480527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3jSAEAP6h7kLKxNdHKe1wEKkmll4W+mLBzqwPyPus3s=;
  b=Y+ojOGtEXHcSmgFeELayjUZZqxDpIdzNCrol4GXXh8gVQmXJV0iqDjgt
   XaWaBtu4LWkUUO0ER1eg18EAnXRYUrq3OImyhCJnxMaaRS2IaPnguVsMA
   l6FwZ09yBOC7bbBG+hs2ZVq5xVvtgANa72moXCNGJAuF/+heJ/Fl/5qOO
   WooVVOjfM9UX9IXL82AfE1MH4lszu3w40IK1B5XTXNeKdDIoiedOE5vC2
   qIL74HfHxm+6rd+aefK9fdDErZ9hrnsyhAlMixpqPRz8E6/ZcW48ele8x
   ygZmoKDTfXfk4Lmzyq0SEDYzcdC+EdmZq+1BmElB1ATtRbd6R8BY/aSmh
   A==;
X-CSE-ConnectionGUID: K5hhc8rHQjSnkU7RAS+gcw==
X-CSE-MsgGUID: XsW3pNtyTDKh9//ABbyEAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9390847"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9390847"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:42:06 -0700
X-CSE-ConnectionGUID: FALzAmajQ0uuFCSL2eFNuw==
X-CSE-MsgGUID: ayiWfY4oQPi7bjsQn2obMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24692454"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 24 Apr 2024 00:42:02 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzXGR-000106-2j;
	Wed, 24 Apr 2024 07:41:59 +0000
Date: Wed, 24 Apr 2024 15:41:59 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mkarsten@uwaterloo.ca, gal@nvidia.com, nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net/mlx4: link NAPI instances to queues and
 IRQs
Message-ID: <202404241518.4TvjoN07-lkp@intel.com>
References: <20240423194931.97013-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423194931.97013-3-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/net-mlx4-Track-RX-allocation-failures-in-a-stat/20240424-035224
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240423194931.97013-3-jdamato%40fastly.com
patch subject: [PATCH net-next 2/3] net/mlx4: link NAPI instances to queues and IRQs
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240424/202404241518.4TvjoN07-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 5ef5eb66fb428aaf61fb51b709f065c069c11242)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240424/202404241518.4TvjoN07-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404241518.4TvjoN07-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
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
   In file included from drivers/net/ethernet/mellanox/mlx4/en_cq.c:34:
   In file included from include/linux/mlx4/cq.h:39:
   In file included from include/linux/mlx4/device.h:37:
   In file included from include/linux/if_ether.h:19:
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
   In file included from drivers/net/ethernet/mellanox/mlx4/en_cq.c:34:
   In file included from include/linux/mlx4/cq.h:39:
   In file included from include/linux/mlx4/device.h:37:
   In file included from include/linux/if_ether.h:19:
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
   In file included from drivers/net/ethernet/mellanox/mlx4/en_cq.c:34:
   In file included from include/linux/mlx4/cq.h:39:
   In file included from include/linux/mlx4/device.h:37:
   In file included from include/linux/if_ether.h:19:
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
>> drivers/net/ethernet/mellanox/mlx4/en_cq.c:202:12: warning: variable 'qtype' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     202 |                 else if (cq->type == TX)
         |                          ^~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx4/en_cq.c:205:45: note: uninitialized use occurs here
     205 |                 netif_queue_set_napi(cq->dev, cq->cq_idx, qtype, NULL);
         |                                                           ^~~~~
   drivers/net/ethernet/mellanox/mlx4/en_cq.c:202:8: note: remove the 'if' if its condition is always true
     202 |                 else if (cq->type == TX)
         |                      ^~~~~~~~~~~~~~~~~~~
     203 |                         qtype = NETDEV_QUEUE_TYPE_TX;
   drivers/net/ethernet/mellanox/mlx4/en_cq.c:197:2: note: variable 'qtype' is declared here
     197 |         enum netdev_queue_type qtype;
         |         ^
   18 warnings generated.


vim +202 drivers/net/ethernet/mellanox/mlx4/en_cq.c

   194	
   195	void mlx4_en_deactivate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq)
   196	{
   197		enum netdev_queue_type qtype;
   198	
   199		if (cq->type != TX_XDP) {
   200			if (cq->type == RX)
   201				qtype = NETDEV_QUEUE_TYPE_RX;
 > 202			else if (cq->type == TX)
   203				qtype = NETDEV_QUEUE_TYPE_TX;
   204	
   205			netif_queue_set_napi(cq->dev, cq->cq_idx, qtype, NULL);
   206			napi_disable(&cq->napi);
   207			netif_napi_del(&cq->napi);
   208		}
   209	
   210		mlx4_cq_free(priv->mdev->dev, &cq->mcq);
   211	}
   212	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

