Return-Path: <linux-rdma+bounces-4569-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47D95F602
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 18:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA701F22BB4
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B6D194131;
	Mon, 26 Aug 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLUj69HU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD0249631
	for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688326; cv=none; b=J6Uw9s8HQcFHgwoSbBccUn7nVCifoaKhnnUZZKf9pdbKjVE650Vr6spbuFmH0qHY+D2d5G3DAYjn1cfPprJijaBVHELuNOIE36/g6vt1bveH86kQj3euKS6l5M0EKR/+ZqWVA2vpLiTWmAEcdHsHuK/wELY94VLzenTo2WqBblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688326; c=relaxed/simple;
	bh=/2Do9k3Sze9rh2v7/7p30zOKQMTiSFu60fpAD/a0QrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj2DVqE/ynNw2KxV7ETG3+upMvIcVf23AxwlzZtcozgRIIOsOLwobt2ajbDBlOiAMEW8i9Xvh0gGg5mvPng4gGFRf9KFJm7ze78mJXyq4Ijmc7AjyUCNC7JUltpvZakqFUKdDnVdt/1+FwTlH/Q0FMXYi/x4EHgv9v3WSThH5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLUj69HU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724688324; x=1756224324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/2Do9k3Sze9rh2v7/7p30zOKQMTiSFu60fpAD/a0QrM=;
  b=BLUj69HUAe8HuVTOCSnn26e1vOrXo+xkvDBTYRfSW1T7GPv0WRi4Vd/+
   bu9nC5oRQFQCJ/6Rwhfsine6WQfzkS2fJFUNfOGS9kaEGpO7H+KDJ9XUY
   hReWVXN8dsfkbHw+nAm27qwvxkk4tiQjJzf+r44e5w1fGPbLnxZYS9bA4
   nAbxVr3aoywRuRyPDzd06ujGgYwsrElUQ8Bdh/7YDZ6AGlA2YgM70Ypwk
   vVSr+SBVuK22T+UTDGXE4slLeUHJLgsJZxONHoRJULI09zOIo1IooCk2y
   QE/UyGhmgPqbQK//91yYG2yw9OemJUSoitgc7NtTD9ZLQjflJDj2QJLu5
   Q==;
X-CSE-ConnectionGUID: ZbeMnGg6Twu2zw4uvbwOSQ==
X-CSE-MsgGUID: JQvoBFi/Q4ecB9T+zJmVpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23277572"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23277572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 09:05:20 -0700
X-CSE-ConnectionGUID: s0kwVPpTS0W4sAU9v6JqLQ==
X-CSE-MsgGUID: FQMP2285QLCrGMnJg8flmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="67248289"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Aug 2024 09:05:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sicDP-000HGQ-1G;
	Mon, 26 Aug 2024 16:05:11 +0000
Date: Tue, 27 Aug 2024 00:05:07 +0800
From: kernel test robot <lkp@intel.com>
To: Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca, leon@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 2/4] RDMA/erdma: Refactor the initialization and
 destruction of EQ
Message-ID: <202408262310.5jeNjXWm-lkp@intel.com>
References: <20240823075058.89488-3-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823075058.89488-3-chengyou@linux.alibaba.com>

Hi Cheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cheng-Xu/RDMA-erdma-Make-the-device-probe-process-more-robust/20240826-123256
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20240823075058.89488-3-chengyou%40linux.alibaba.com
patch subject: [PATCH for-next 2/4] RDMA/erdma: Refactor the initialization and destruction of EQ
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240826/202408262310.5jeNjXWm-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408262310.5jeNjXWm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408262310.5jeNjXWm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/infiniband/hw/erdma/erdma_eq.c:7:
   In file included from drivers/infiniband/hw/erdma/erdma_verbs.h:10:
   In file included from drivers/infiniband/hw/erdma/erdma.h:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/infiniband/hw/erdma/erdma_eq.c:7:
   In file included from drivers/infiniband/hw/erdma/erdma_verbs.h:10:
   In file included from drivers/infiniband/hw/erdma/erdma.h:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/infiniband/hw/erdma/erdma_eq.c:7:
   In file included from drivers/infiniband/hw/erdma/erdma_verbs.h:10:
   In file included from drivers/infiniband/hw/erdma/erdma.h:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/infiniband/hw/erdma/erdma_eq.c:141:6: warning: no previous prototype for function 'erdma_aeq_destroy' [-Wmissing-prototypes]
     141 | void erdma_aeq_destroy(struct erdma_dev *dev)
         |      ^
   drivers/infiniband/hw/erdma/erdma_eq.c:141:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     141 | void erdma_aeq_destroy(struct erdma_dev *dev)
         | ^
         | static 
   18 warnings generated.


vim +/erdma_aeq_destroy +141 drivers/infiniband/hw/erdma/erdma_eq.c

f2a0a630b953451 Cheng Xu 2022-07-27  140  
f2a0a630b953451 Cheng Xu 2022-07-27 @141  void erdma_aeq_destroy(struct erdma_dev *dev)
f2a0a630b953451 Cheng Xu 2022-07-27  142  {
f2a0a630b953451 Cheng Xu 2022-07-27  143  	struct erdma_eq *eq = &dev->aeq;
f2a0a630b953451 Cheng Xu 2022-07-27  144  
f0697bf078368d7 Boshi Yu 2024-03-11  145  	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
f2a0a630b953451 Cheng Xu 2022-07-27  146  			  eq->qbuf_dma_addr);
f0697bf078368d7 Boshi Yu 2024-03-11  147  
fdb09ed15f272ad Boshi Yu 2024-03-11  148  	dma_pool_free(dev->db_pool, eq->dbrec, eq->dbrec_dma);
f2a0a630b953451 Cheng Xu 2022-07-27  149  }
f2a0a630b953451 Cheng Xu 2022-07-27  150  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

