Return-Path: <linux-rdma+bounces-4931-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6D497781B
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 06:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE651C24802
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 04:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBD71D31BD;
	Fri, 13 Sep 2024 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpqWJfpR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C71BF336;
	Fri, 13 Sep 2024 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726202919; cv=none; b=iqAXCyC4ste/K/7I1vZ5/aEA6WkasiijGYLaMzSKZaRQllFWS00oKiPTZItJ38qB+Oba5aTJVRs5JU8kBUA9nXOmkPSR/loeQaLbXQGIMTuXmaVBdOh54iedBkeVPZzJmVYaC99eZnvL22HnipcW4loHGqd/fFFins452AzPzHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726202919; c=relaxed/simple;
	bh=IdOwkHjoUAi8m8kt5OW69d8R+b3A2mVuvSErhnEz5Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp58BUqE+VMFAdyKZE2L+4kFenwO7htUYWFKGAC989Wszv7BJHMRHoJr56C5ZUdhNX6yRF+QguKxdKnVf3tImMHT/ZjmpvW/XhbxONOMcpNsAYE0T/la0ua/5Tn+zM8WHZmfBFbvKMacwFV1f7HjOtg/kaNCmIyEZsN5MLI9OGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpqWJfpR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726202918; x=1757738918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IdOwkHjoUAi8m8kt5OW69d8R+b3A2mVuvSErhnEz5Kc=;
  b=UpqWJfpR6I2K9MwicevCVeCKk6qBEd9oecaNCwF6aQmOPlhS8NwQdU3P
   t7E33AFFHyZMsviYpBQbQWGZ+BDaIslTjp2v2WO8mSeLZVpyV16uaugUf
   /NmP/D9vQ3K3rygZHF5V8vi/4qKKTlFh3a8ai5/qrr7OrdV5Zk4vW9kZU
   +T0IMXlDg6EqVsADDwEZjnr3jEqy1+gYgzHVQawgEQufSLPYDrKRY3cxk
   K8b8pzgz+ZXFB6jKqGt44d3nSeFXC/P3CDHg12G8uvFQOv59WhJPO2IuS
   Z46aLywIgcO6M4ug73rA3dqHwhap6uipUFHLQtiyqIKQFEQ1JT6C5/uaP
   Q==;
X-CSE-ConnectionGUID: a3cj89jqRsKkfXr+kd/EAg==
X-CSE-MsgGUID: +4qru6oBTRurpw9Rr3uBIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25214666"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25214666"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 21:48:37 -0700
X-CSE-ConnectionGUID: wxSQ7Mk9Qga4+VcKo3PYlA==
X-CSE-MsgGUID: teQ5LMKESkKoZubZ1pwdbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="91191688"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Sep 2024 21:48:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soyES-00061e-0r;
	Fri, 13 Sep 2024 04:48:32 +0000
Date: Fri, 13 Sep 2024 12:48:02 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
	Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] mlx4: Use MLX4_ATTR_CABLE_INFO instead of
 0xFF60 magic value
Message-ID: <202409131245.mVHqb5R3-lkp@intel.com>
References: <12a1d143-35d6-43f3-b8b3-ab0198f5540a@ans.pl>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a1d143-35d6-43f3-b8b3-ab0198f5540a@ans.pl>

Hi Krzysztof,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Krzysztof-Ol-dzki/mlx4-Use-MLX4_ATTR_CABLE_INFO-instead-of-0xFF60-magic-value/20240912-144426
base:   net-next/main
patch link:    https://lore.kernel.org/r/12a1d143-35d6-43f3-b8b3-ab0198f5540a%40ans.pl
patch subject: [PATCH net-next 2/4] mlx4: Use MLX4_ATTR_CABLE_INFO instead of 0xFF60 magic value
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240913/202409131245.mVHqb5R3-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131245.mVHqb5R3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131245.mVHqb5R3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/infiniband/hw/mlx4/main.c:34:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/infiniband/hw/mlx4/main.c:38:
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
   In file included from drivers/infiniband/hw/mlx4/main.c:38:
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
   In file included from drivers/infiniband/hw/mlx4/main.c:38:
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
>> drivers/infiniband/hw/mlx4/main.c:722:21: error: use of undeclared identifier 'MLX4_ATTR_EXTENDED_PORT_INFO'
     722 |                 in_mad->attr_id = MLX4_ATTR_EXTENDED_PORT_INFO;
         |                                   ^
   16 warnings and 1 error generated.


vim +/MLX4_ATTR_EXTENDED_PORT_INFO +722 drivers/infiniband/hw/mlx4/main.c

225c7b1feef1b4 Roland Dreier    2007-05-08  654  
1fb7f8973f51ca Mark Bloch       2021-03-01  655  static int ib_link_query_port(struct ib_device *ibdev, u32 port,
0a9a01884d447c Jack Morgenstein 2012-08-03  656  			      struct ib_port_attr *props, int netw_view)
fa417f7b520ee6 Eli Cohen        2010-10-24  657  {
a45e5f1859579f Ruan Jinjie      2023-07-28  658  	struct ib_smp *in_mad;
a45e5f1859579f Ruan Jinjie      2023-07-28  659  	struct ib_smp *out_mad;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  660  	int ext_active_speed;
0a9a01884d447c Jack Morgenstein 2012-08-03  661  	int mad_ifc_flags = MLX4_MAD_IFC_IGNORE_KEYS;
a9c766bb75ee2c Or Gerlitz       2012-01-11  662  	int err = -ENOMEM;
a9c766bb75ee2c Or Gerlitz       2012-01-11  663  
a9c766bb75ee2c Or Gerlitz       2012-01-11  664  	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
a9c766bb75ee2c Or Gerlitz       2012-01-11  665  	out_mad = kmalloc(sizeof *out_mad, GFP_KERNEL);
a9c766bb75ee2c Or Gerlitz       2012-01-11  666  	if (!in_mad || !out_mad)
a9c766bb75ee2c Or Gerlitz       2012-01-11  667  		goto out;
a9c766bb75ee2c Or Gerlitz       2012-01-11  668  
d82e2b27ad3a4f Leon Romanovsky  2022-01-05  669  	ib_init_query_mad(in_mad);
a9c766bb75ee2c Or Gerlitz       2012-01-11  670  	in_mad->attr_id  = IB_SMP_ATTR_PORT_INFO;
a9c766bb75ee2c Or Gerlitz       2012-01-11  671  	in_mad->attr_mod = cpu_to_be32(port);
a9c766bb75ee2c Or Gerlitz       2012-01-11  672  
0a9a01884d447c Jack Morgenstein 2012-08-03  673  	if (mlx4_is_mfunc(to_mdev(ibdev)->dev) && netw_view)
0a9a01884d447c Jack Morgenstein 2012-08-03  674  		mad_ifc_flags |= MLX4_MAD_IFC_NET_VIEW;
0a9a01884d447c Jack Morgenstein 2012-08-03  675  
0a9a01884d447c Jack Morgenstein 2012-08-03  676  	err = mlx4_MAD_IFC(to_mdev(ibdev), mad_ifc_flags, port, NULL, NULL,
a9c766bb75ee2c Or Gerlitz       2012-01-11  677  				in_mad, out_mad);
a9c766bb75ee2c Or Gerlitz       2012-01-11  678  	if (err)
a9c766bb75ee2c Or Gerlitz       2012-01-11  679  		goto out;
a9c766bb75ee2c Or Gerlitz       2012-01-11  680  
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  681  
225c7b1feef1b4 Roland Dreier    2007-05-08  682  	props->lid		= be16_to_cpup((__be16 *) (out_mad->data + 16));
225c7b1feef1b4 Roland Dreier    2007-05-08  683  	props->lmc		= out_mad->data[34] & 0x7;
225c7b1feef1b4 Roland Dreier    2007-05-08  684  	props->sm_lid		= be16_to_cpup((__be16 *) (out_mad->data + 18));
225c7b1feef1b4 Roland Dreier    2007-05-08  685  	props->sm_sl		= out_mad->data[36] & 0xf;
225c7b1feef1b4 Roland Dreier    2007-05-08  686  	props->state		= out_mad->data[32] & 0xf;
225c7b1feef1b4 Roland Dreier    2007-05-08  687  	props->phys_state	= out_mad->data[33] >> 4;
225c7b1feef1b4 Roland Dreier    2007-05-08  688  	props->port_cap_flags	= be32_to_cpup((__be32 *) (out_mad->data + 20));
0a9a01884d447c Jack Morgenstein 2012-08-03  689  	if (netw_view)
0a9a01884d447c Jack Morgenstein 2012-08-03  690  		props->gid_tbl_len = out_mad->data[50];
0a9a01884d447c Jack Morgenstein 2012-08-03  691  	else
5ae2a7a836be66 Roland Dreier    2007-06-18  692  		props->gid_tbl_len = to_mdev(ibdev)->dev->caps.gid_table_len[port];
149983af609e8f Dotan Barak      2007-06-26  693  	props->max_msg_sz	= to_mdev(ibdev)->dev->caps.max_msg_sz;
5ae2a7a836be66 Roland Dreier    2007-06-18  694  	props->pkey_tbl_len	= to_mdev(ibdev)->dev->caps.pkey_table_len[port];
225c7b1feef1b4 Roland Dreier    2007-05-08  695  	props->bad_pkey_cntr	= be16_to_cpup((__be16 *) (out_mad->data + 46));
225c7b1feef1b4 Roland Dreier    2007-05-08  696  	props->qkey_viol_cntr	= be16_to_cpup((__be16 *) (out_mad->data + 48));
225c7b1feef1b4 Roland Dreier    2007-05-08  697  	props->active_width	= out_mad->data[31] & 0xf;
225c7b1feef1b4 Roland Dreier    2007-05-08  698  	props->active_speed	= out_mad->data[35] >> 4;
225c7b1feef1b4 Roland Dreier    2007-05-08  699  	props->max_mtu		= out_mad->data[41] & 0xf;
225c7b1feef1b4 Roland Dreier    2007-05-08  700  	props->active_mtu	= out_mad->data[36] >> 4;
225c7b1feef1b4 Roland Dreier    2007-05-08  701  	props->subnet_timeout	= out_mad->data[51] & 0x1f;
225c7b1feef1b4 Roland Dreier    2007-05-08  702  	props->max_vl_num	= out_mad->data[37] >> 4;
225c7b1feef1b4 Roland Dreier    2007-05-08  703  	props->init_type_reply	= out_mad->data[41] >> 4;
225c7b1feef1b4 Roland Dreier    2007-05-08  704  
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  705  	/* Check if extended speeds (EDR/FDR/...) are supported */
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  706  	if (props->port_cap_flags & IB_PORT_EXTENDED_SPEEDS_SUP) {
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  707  		ext_active_speed = out_mad->data[62] >> 4;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  708  
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  709  		switch (ext_active_speed) {
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  710  		case 1:
2e96691c31ecf7 Or Gerlitz       2012-02-28  711  			props->active_speed = IB_SPEED_FDR;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  712  			break;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  713  		case 2:
2e96691c31ecf7 Or Gerlitz       2012-02-28  714  			props->active_speed = IB_SPEED_EDR;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  715  			break;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  716  		}
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  717  	}
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  718  
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  719  	/* If reported active speed is QDR, check if is FDR-10 */
2e96691c31ecf7 Or Gerlitz       2012-02-28  720  	if (props->active_speed == IB_SPEED_QDR) {
d82e2b27ad3a4f Leon Romanovsky  2022-01-05  721  		ib_init_query_mad(in_mad);
a5e12dff757b56 Marcel Apfelbaum 2011-10-03 @722  		in_mad->attr_id = MLX4_ATTR_EXTENDED_PORT_INFO;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  723  		in_mad->attr_mod = cpu_to_be32(port);
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  724  
0a9a01884d447c Jack Morgenstein 2012-08-03  725  		err = mlx4_MAD_IFC(to_mdev(ibdev), mad_ifc_flags, port,
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  726  				   NULL, NULL, in_mad, out_mad);
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  727  		if (err)
bf6b47deb40f9f Jesper Juhl      2012-04-11  728  			goto out;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  729  
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  730  		/* Checking LinkSpeedActive for FDR-10 */
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  731  		if (out_mad->data[15] & 0x1)
2e96691c31ecf7 Or Gerlitz       2012-02-28  732  			props->active_speed = IB_SPEED_FDR10;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  733  	}
d2ef406866620f Or Gerlitz       2012-04-02  734  
d2ef406866620f Or Gerlitz       2012-04-02  735  	/* Avoid wrong speed value returned by FW if the IB link is down. */
d2ef406866620f Or Gerlitz       2012-04-02  736  	if (props->state == IB_PORT_DOWN)
d2ef406866620f Or Gerlitz       2012-04-02  737  		 props->active_speed = IB_SPEED_SDR;
d2ef406866620f Or Gerlitz       2012-04-02  738  
a9c766bb75ee2c Or Gerlitz       2012-01-11  739  out:
a9c766bb75ee2c Or Gerlitz       2012-01-11  740  	kfree(in_mad);
a9c766bb75ee2c Or Gerlitz       2012-01-11  741  	kfree(out_mad);
a9c766bb75ee2c Or Gerlitz       2012-01-11  742  	return err;
fa417f7b520ee6 Eli Cohen        2010-10-24  743  }
fa417f7b520ee6 Eli Cohen        2010-10-24  744  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

