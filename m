Return-Path: <linux-rdma+bounces-13391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F9DB58E07
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 07:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1523716F49E
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 05:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE92DD5F3;
	Tue, 16 Sep 2025 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hV75BlTh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9591C6A3;
	Tue, 16 Sep 2025 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001556; cv=none; b=jTruajq/WGaJI9egBzYCFt7e8lSGZVxeoCh5szzGbnKxGGKcVLhUMJvmG4MzESf1dm5kUv1OcR9DN0dmBZ4fFdh300DDS5C9c8zCFQ1DCq4/KVPyTI0XL12D0ixXdGzpwc8yH6KupPVNaaj3GPy90GFGmZpzPwrBYAWWb8uL12U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001556; c=relaxed/simple;
	bh=St0T9L/irb0uOHmCv7ND5bZ4N+RxY3A5HgQju34FRd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRTpynE9+6cFpq0RYw1MVQ1RGqiFc/sdwe6aibB4CbzT7dv1nfLE53yvsjZlgGbfAIHKdaeI5CD6XcspHyEu9paf6pjFdUBmE4I72oTRcW+hGgLyYHBQybR4jikWuK/QfRdAe9bC/uSd+3YGDmalMv8ge7eYJxcW1EXYiB78HK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hV75BlTh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758001555; x=1789537555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=St0T9L/irb0uOHmCv7ND5bZ4N+RxY3A5HgQju34FRd4=;
  b=hV75BlThWq8KodXbt2apsGzge37/5sliuUpvVBBvQE1x/gf1DBEFlbq/
   yXJ6gNEZBPvCnBYjr6z8jSLTeHRCEJBWaZFPWREjom73KuoADV75n0lDC
   YBr9E/Lq41caQE+FbTOfHfLCRVJI0sW0kQ0ej6k6UvdShxsVmvGcYgzOu
   k9H15cBDipxFhG2N0FBDJBe5vrC6G8TknqI7eJIBxp7lQZ6uPyzYA65fS
   G/nHEA+FU3LwSEaoGobpRYCtc36fn3DFGXRkBd7PGs3mS0oabQ3YwCbKC
   5PpTpsvxkK6TxKnlQ+0CnBnMhkdTacL6pnvQki9JBLhxXBvYGe+p3YSQF
   g==;
X-CSE-ConnectionGUID: Z/W4vhbtT1KTx7Xm115Qng==
X-CSE-MsgGUID: yyozBt0DSIaeLlz4AI3aHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="63902761"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="63902761"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 22:45:54 -0700
X-CSE-ConnectionGUID: MlV3610HQl6I+ZtfDRhHmw==
X-CSE-MsgGUID: AV8iiBnCROSuPNFdCkIvjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="178848707"
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Sep 2025 22:45:47 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyOVc-00011z-20;
	Tue, 16 Sep 2025 05:45:44 +0000
Date: Tue, 16 Sep 2025 13:45:20 +0800
From: kernel test robot <lkp@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>, linux-rdma@vger.kernel.org,
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
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH net-next V2] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <202509161338.Kq88HUjH-lkp@intel.com>
References: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>

Hi Tariq,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1f24a240974589ce42f70502ccb3ff3f5189d69a]

url:    https://github.com/intel-lab-lkp/linux/commits/Tariq-Toukan/net-mlx5-Improve-write-combining-test-reliability-for-ARM64-Grace-CPUs/20250915-163901
base:   1f24a240974589ce42f70502ccb3ff3f5189d69a
patch link:    https://lore.kernel.org/r/1757925308-614943-1-git-send-email-tariqt%40nvidia.com
patch subject: [PATCH net-next V2] net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250916/202509161338.Kq88HUjH-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509161338.Kq88HUjH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509161338.Kq88HUjH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c:9:3: error: instruction requires: neon
       9 |         ("ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
         |          ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x19]
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c:9:48: error: instruction requires: neon
       9 |         ("ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
         |                                                       ^
   <inline asm>:2:2: note: instantiated into assembly here
       2 |         st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x20]
         |         ^
   2 errors generated.


vim +9 drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c

     5	
     6	void mlx5_wc_neon_iowrite64_copy(void __iomem *to, const void *from)
     7	{
     8		asm volatile
   > 9		("ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

