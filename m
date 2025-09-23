Return-Path: <linux-rdma+bounces-13589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44343B94BB7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 09:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E583A48BF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED33112AB;
	Tue, 23 Sep 2025 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V27zlUZt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8730F944;
	Tue, 23 Sep 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612011; cv=none; b=XjkeA+G3DSfV/ifog8JzaE6B/D4dv5TmoO0jvxT7ZEIBqT1NSmIpFWOUctEks4Mi2etkH6ii5Rptbl7aKdw7j5K0ekg8uKbXqj7MZ+QqtKxBsPnSvQFzUQd/Y/JWYRd8z1MbrS2CIy/ACnYjTDphlgeRkoT7yhp/B2uYAGYTn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612011; c=relaxed/simple;
	bh=lwJ9UOqD//PDM/RdW1ujxGd44CcPYvzNz6RKR54u+xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj1FISjaxTUCAGfusr+7oHk1yesMVustihRryI+bUbf0omv9otsul2J5KyAGycPAvnXEyg72001XTcz/8wU4YqXoU8z97XYdqtRi184DkTvwm8lddq0ZftU5QjkmZrMNyzWiRJU4F2H9L3OBbJGqTDCSII8xRftXZHS2vjpfKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V27zlUZt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758612009; x=1790148009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lwJ9UOqD//PDM/RdW1ujxGd44CcPYvzNz6RKR54u+xI=;
  b=V27zlUZtetY/r9/AQeifUAGuFD7QaUmRDnDq7FBycNHBxIswHpwSHAIq
   vZbBPCCCukaoMk26CpDrGlm6l6Dld3zxJyLPVOwmdM/SyGNTGFOXdEPNd
   ZNIQfDKr8mncxv+NCxz5wiFbnA1OAE+1X3hJ4ltTAM4+z2/eJk/xt/zxl
   E62Mr9JqWxGTo4U/EdyFMiUJiU26qk0Fs5ebPE7Cg1R71KHOCwKT4kmPK
   MMLpDBS0W8U2PwR+s6Dk1PsV7OL73bM84IJnnxGzoLNI/Y/oV6bzH7+/c
   OZmGPE8rOhsiQtGoIlAokvrgz+U3OC9tp1K1RlveVCbj5iJJ+73SXkOiq
   A==;
X-CSE-ConnectionGUID: ldYJDQNkRtylDdNddlP6bA==
X-CSE-MsgGUID: nJqbN5ogQC68l4NrdimYhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72310800"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="72310800"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 00:20:08 -0700
X-CSE-ConnectionGUID: Yfyb9R4/Q+iN3TxSgmOafA==
X-CSE-MsgGUID: tJaYf2dMRTq2G+2tFbHnZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="181079366"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 Sep 2025 00:20:02 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0xJf-0002rB-2I;
	Tue, 23 Sep 2025 07:19:59 +0000
Date: Tue, 23 Sep 2025 15:19:38 +0800
From: kernel test robot <lkp@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next V4] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <202509231437.exOuF9vQ-lkp@intel.com>
References: <1758528951-817323-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758528951-817323-1-git-send-email-tariqt@nvidia.com>

Hi Tariq,

kernel test robot noticed the following build errors:

[auto build test ERROR on 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0]

url:    https://github.com/intel-lab-lkp/linux/commits/Tariq-Toukan/net-mlx5-Improve-write-combining-test-reliability-for-ARM64-Grace-CPUs/20250922-161859
base:   312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
patch link:    https://lore.kernel.org/r/1758528951-817323-1-git-send-email-tariqt%40nvidia.com
patch subject: [PATCH net-next V4] net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20250923/202509231437.exOuF9vQ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509231437.exOuF9vQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509231437.exOuF9vQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In function 'mlx5_iowrite64_copy',
       inlined from 'mlx5_wc_post_nop' at drivers/net/ethernet/mellanox/mlx5/core/wc.c:317:2:
>> drivers/net/ethernet/mellanox/mlx5/core/wc.c:268:17: error: unknown register name 'v0' in 'asm'
     268 |                 asm volatile
         |                 ^~~


vim +268 drivers/net/ethernet/mellanox/mlx5/core/wc.c

   261	
   262	static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
   263					size_t mmio_wqe_size, unsigned int offset)
   264	{
   265	#ifdef CONFIG_KERNEL_MODE_NEON
   266		if (cpu_has_neon()) {
   267			kernel_neon_begin();
 > 268			asm volatile
   269			(".arch_extension simd;\n\t"
   270			"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
   271			"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
   272			:
   273			: "r"(mmio_wqe), "r"(sq->bfreg.map + offset)
   274			: "memory", "v0", "v1", "v2", "v3");
   275			kernel_neon_end();
   276			return;
   277		}
   278	#endif
   279		__iowrite64_copy(sq->bfreg.map + offset, mmio_wqe,
   280				 mmio_wqe_size / 8);
   281	}
   282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

