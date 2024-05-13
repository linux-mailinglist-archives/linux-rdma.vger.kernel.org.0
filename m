Return-Path: <linux-rdma+bounces-2464-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44288C46AE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EC1282225
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94BE2C69D;
	Mon, 13 May 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALq3nshk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052B381B8;
	Mon, 13 May 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623493; cv=none; b=EzJiq+m73hpEFC8D5E3SgNVeTPe79xDt4DYVSDgDh5PcBiz/Y2lLqHc/eyvIOcN5ir5sMcx6Y+0NxGab/sHIUjRdWd9CZ0fR9+X+EWtOy1MHK+Swdk//sJfuNHyvMYozS0GtZrwe//7BA2THSwO4UEVeqjiJ2OZmjIPQ0klExfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623493; c=relaxed/simple;
	bh=UNnjVc+pJh5y1zaNd677ePOr+EfWhLiINtWrDbZ6JiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHuyI1u0HbREkdxYJgycyzZC+q6cK9Au0A9KO9Z76HnnpoJ18zjyToRm6BLg48dwekwaWzo8ZrLeir8OBUFh1RfGSGklsi8GIDMuGSfMbp1dOuXBEuN1oChKHHME4hXVsdsnu85AO3rO+EkAVaRtGL6gXFG0F+oLrVCH8FpiujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALq3nshk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715623492; x=1747159492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UNnjVc+pJh5y1zaNd677ePOr+EfWhLiINtWrDbZ6JiI=;
  b=ALq3nshkfJNACZs2bGRBOibPHb1J24MjACY4s8o5fwfWEkLXMRJrHPAQ
   SPW7qeEFCn3JfLOk+7eCAcAYPnSGqbLTsxXguiN5VsWrHsPqkxdiN1LMe
   K0wpDYbM6xdh8WbDtWXjPGydOoE3Qr/weq0KcK51qiYnKCZOE/EoEEOVv
   CBiS6T6rFEHvct5VvpgAeuglkS1KtsIJbOsO0AOQ8RAo5GOnLma0YmDEG
   ynJ1BWGeI6GmmbY5g8OjfBMf4GVVgj8Ve6tvbJPqxgkiZNHQeB/d8l0rA
   YhtAtW+kc2UBbm/kcAzOKHoEun4VkCjT0nEHXMH+qAQIMl3/VlVDWQ56Y
   A==;
X-CSE-ConnectionGUID: illagKBOR/CTZF5qivd0iA==
X-CSE-MsgGUID: KVLR66K5TlK0yDkUEKwOXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11707184"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11707184"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 11:04:51 -0700
X-CSE-ConnectionGUID: nd+xT5/HRpWebuVOWnS8bQ==
X-CSE-MsgGUID: SDUo857CR4WS3qN7ZUTp3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30360987"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 May 2024 11:04:45 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6a2V-000AVf-1L;
	Mon, 13 May 2024 18:04:43 +0000
Date: Tue, 14 May 2024 02:04:35 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Mark Zhang <markzhang@nvidia.com>,
	=?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH 2/6] rds: Brute force GFP_NOIO
Message-ID: <202405140136.LE0Nk9by-lkp@intel.com>
References: <20240513125346.764076-3-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513125346.764076-3-haakon.bugge@oracle.com>

Hi Håkon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-wq/for-next]
[also build test WARNING on rdma/for-next net/main net-next/main linus/master v6.9 next-20240513]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/H-kon-Bugge/workqueue-Inherit-NOIO-and-NOFS-alloc-flags/20240513-205927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
patch link:    https://lore.kernel.org/r/20240513125346.764076-3-haakon.bugge%40oracle.com
patch subject: [PATCH 2/6] rds: Brute force GFP_NOIO
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240514/202405140136.LE0Nk9by-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240514/202405140136.LE0Nk9by-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405140136.LE0Nk9by-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/rds/af_rds.c:33:
   In file included from include/linux/module.h:19:
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
   In file included from net/rds/af_rds.c:38:
   In file included from include/linux/ipv6.h:101:
   In file included from include/linux/tcp.h:17:
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
   In file included from net/rds/af_rds.c:38:
   In file included from include/linux/ipv6.h:101:
   In file included from include/linux/tcp.h:17:
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
   In file included from net/rds/af_rds.c:38:
   In file included from include/linux/ipv6.h:101:
   In file included from include/linux/tcp.h:17:
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
>> net/rds/af_rds.c:315:15: warning: variable 'noio_flags' set but not used [-Wunused-but-set-variable]
     315 |         unsigned int noio_flags;
         |                      ^
   18 warnings generated.


vim +/noio_flags +315 net/rds/af_rds.c

   310	
   311	static int rds_cancel_sent_to(struct rds_sock *rs, sockptr_t optval, int len)
   312	{
   313		struct sockaddr_in6 sin6;
   314		struct sockaddr_in sin;
 > 315		unsigned int noio_flags;
   316		int ret = 0;
   317	
   318		if (rds_force_noio)
   319			noio_flags = memalloc_noio_save();
   320	
   321		/* racing with another thread binding seems ok here */
   322		if (ipv6_addr_any(&rs->rs_bound_addr)) {
   323			ret = -ENOTCONN; /* XXX not a great errno */
   324			goto out;
   325		}
   326	
   327		if (len < sizeof(struct sockaddr_in)) {
   328			ret = -EINVAL;
   329			goto out;
   330		} else if (len < sizeof(struct sockaddr_in6)) {
   331			/* Assume IPv4 */
   332			if (copy_from_sockptr(&sin, optval,
   333					sizeof(struct sockaddr_in))) {
   334				ret = -EFAULT;
   335				goto out;
   336			}
   337			ipv6_addr_set_v4mapped(sin.sin_addr.s_addr, &sin6.sin6_addr);
   338			sin6.sin6_port = sin.sin_port;
   339		} else {
   340			if (copy_from_sockptr(&sin6, optval,
   341					   sizeof(struct sockaddr_in6))) {
   342				ret = -EFAULT;
   343				goto out;
   344			}
   345		}
   346	
   347		rds_send_drop_to(rs, &sin6);
   348	out:
   349		if (rds_force_noio)
   350			noio_flags = memalloc_noio_save();
   351		return ret;
   352	}
   353	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

