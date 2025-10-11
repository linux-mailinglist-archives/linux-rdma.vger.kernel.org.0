Return-Path: <linux-rdma+bounces-13813-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D22FBCFDDB
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Oct 2025 01:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E04A84E02B1
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Oct 2025 23:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF3242D6C;
	Sat, 11 Oct 2025 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxfCo9fg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856A22157F
	for <linux-rdma@vger.kernel.org>; Sat, 11 Oct 2025 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760225808; cv=none; b=n2Y7j+ZRMT1laPLGFnNQEGV5rEUtHEJ1pR52x4By1iU7Jh+V+59lSlBEPsc6rNkJ2oOZ2CtA1UJF/fY6SvDJ0rFxqHG/ILNaXbpPWdhefbZrzNPRpnUBT38AJj7FBd9migUDadFTp27xxWpzrD270ckXybZOdYTXHvVQmpEPcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760225808; c=relaxed/simple;
	bh=R2lYa4L4daYjxt8fCRBKjZ7g5EgOnkSjnTBjQxYbKGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krAzQvOw8Z5w/aeTeRsXFlHiUdy5U4mnEccfzJ3eXxToXRVJlGKpLYpSYwSFStTVfKCQRT9ee935djXKXZW2gGq1ctvki4Lfjcb7hOOsZKLzMcXWDj9iPpOK40xlRhDUQhIU6Ge0WflT3nJPV3Ph7zBVIcvb4hiYg+NU3fFtkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxfCo9fg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760225806; x=1791761806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R2lYa4L4daYjxt8fCRBKjZ7g5EgOnkSjnTBjQxYbKGM=;
  b=PxfCo9fg4XojZoBTazMQBrGb3r4/pys3d7zc1EDZu3lqJScKBv2p/jFf
   sytZhiDhbR7igPSDiBUK3aCD4zgegt1TV9lwkF2kSvxuuf2NgEKICxUwn
   CM1SAy/LWpGmXzy7VQiLbfdwYaRzmuzj2vMynsTbrUgegC8USkcH0ngNl
   xAPPC7qXBeMJjR+4/gyvKjLImY1rXkCYOahkyGxtimPOaDHRgkkWk7uX+
   KiG+S/bb+foQ/DyMeTEbrsEQ1sUWBQbUdLj0PHAkdNbVCRJDa3kXsT7kA
   ZGdzH166TLfiTXXhZIo41Q3yyVP6+ZVPuDY3+W0VrK7Jpb0mhcwOE05Af
   w==;
X-CSE-ConnectionGUID: 4q/cbODmRVmpsv7mr5uJ9A==
X-CSE-MsgGUID: jXK5kQEASM+v08oMQXkIUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11579"; a="62106949"
X-IronPort-AV: E=Sophos;i="6.19,222,1754982000"; 
   d="scan'208";a="62106949"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 16:36:46 -0700
X-CSE-ConnectionGUID: Hardy0Z8QzyKO67EdFq0Ww==
X-CSE-MsgGUID: nKHkdnF7SF2btuOfijcUzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,222,1754982000"; 
   d="scan'208";a="212229613"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Oct 2025 16:36:44 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7j8k-00042r-0C;
	Sat, 11 Oct 2025 23:36:42 +0000
Date: Sun, 12 Oct 2025 07:35:42 +0800
From: kernel test robot <lkp@intel.com>
To: Jian Wen <wenjianhn@gmail.com>, jgg@nvidia.com, leonro@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jian Wen <wenjian1@xiaomi.com>, linux-rdma@vger.kernel.org,
	wenjianhn@gmail.com
Subject: Re: [PATCH] RDMA/mlx5: Use mlx5_cmd_is_down to detect PCIe Surprise
 Link Down
Message-ID: <202510120715.P7oFOBOQ-lkp@intel.com>
References: <20251009142326.3794769-1-wenjian1@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009142326.3794769-1-wenjian1@xiaomi.com>

Hi Jian,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v6.17 next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jian-Wen/RDMA-mlx5-Use-mlx5_cmd_is_down-to-detect-PCIe-Surprise-Link-Down/20251009-224616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20251009142326.3794769-1-wenjian1%40xiaomi.com
patch subject: [PATCH] RDMA/mlx5: Use mlx5_cmd_is_down to detect PCIe Surprise Link Down
config: s390-defconfig (https://download.01.org/0day-ci/archive/20251012/202510120715.P7oFOBOQ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251012/202510120715.P7oFOBOQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510120715.P7oFOBOQ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mlx5_cmd_is_down" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

