Return-Path: <linux-rdma+bounces-13134-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC7CB47613
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Sep 2025 20:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E11C94E028B
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Sep 2025 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5F279903;
	Sat,  6 Sep 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeXSGy8k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24970221F12;
	Sat,  6 Sep 2025 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183178; cv=none; b=nbSK945vk1d6EVyuZ7fdlHLj9n3Lc/NsKrBf+XS6N6OT1x9e6+KMD82vxHmNozbbMPDYvCKk1Hi8cOBS84C0Um7IDXEYhy9ouHc7VbilC2JKxAgtpLhLHCND1zJXYRiHHuWohOZvRes+MyRW9GgTsDyZyIYMVl0S1u/z6QZE7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183178; c=relaxed/simple;
	bh=LSqfnwRaCxz/qt66MNF+bf0NREQDPnp6VzCH4Zt6gd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4wy6E+n4BI0iI2a89Xi/lKpS7UWJQE5+tlBAolA3avmkgIUnYT68BsInL1Jeyi9D4SnqaoRfp9/68GPXAOiNSdIycn6hLlFis+5C83gaSYg9KJKxzpGiYPV1EvYjRsGaXyE65f8u6p6pcg1AHK7WSwsXlPTAPU84mcuUI5Rw2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeXSGy8k; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757183177; x=1788719177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LSqfnwRaCxz/qt66MNF+bf0NREQDPnp6VzCH4Zt6gd8=;
  b=BeXSGy8ksJZwv9E7o1GplmFDnbPlqWKzBDQzL4iS6EyNseYykV1Hr7sT
   Qp4alw+wUmxmqFSgEE3wil+rHpcEwLP5kAlqCuVyLAOFpwwhBiiS6Q4TN
   J8kTlG2Xu7CE8Q4hRTAwd/tfLNn2JPuswksdaeb4iEuHj3nzqgpbtWw40
   CLBO8Ji3pexYUapo0pMK8ny/6/RL17HCDiNYupNqIFq67V1Bm6i09Y8oa
   EPSC8rqBz5h3Ikj52lR7AVwxnD4mfdcbvZVNV3lc84V46vCkAqgxgazLh
   KZe9iyf68B4Iot72yDIi2dhYA10vgUAVBqyqjZq/RvQDGVSJ9dh3NgZmp
   A==;
X-CSE-ConnectionGUID: bYm62msVSWav8iRtxNlMLw==
X-CSE-MsgGUID: 2GIB7Rz6SR2uKo0lgE4UDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="59199682"
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="59199682"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 11:26:17 -0700
X-CSE-ConnectionGUID: x3W0eVxLTsSI2xa8jvDr1Q==
X-CSE-MsgGUID: swWJ9GldTViBEQSAgLPwsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="172308236"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Sep 2025 11:26:13 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuxc2-0001jX-1x;
	Sat, 06 Sep 2025 18:26:10 +0000
Date: Sun, 7 Sep 2025 02:25:54 +0800
From: kernel test robot <lkp@intel.com>
To: Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next 1/2] net/smc: make wr buffer count configurable
Message-ID: <202509070225.pVKkaaCr-lkp@intel.com>
References: <20250904211254.1057445-2-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904211254.1057445-2-pasic@linux.ibm.com>

Hi Halil,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5ef04a7b068cbb828eba226aacb42f880f7924d7]

url:    https://github.com/intel-lab-lkp/linux/commits/Halil-Pasic/net-smc-make-wr-buffer-count-configurable/20250905-051510
base:   5ef04a7b068cbb828eba226aacb42f880f7924d7
patch link:    https://lore.kernel.org/r/20250904211254.1057445-2-pasic%40linux.ibm.com
patch subject: [PATCH net-next 1/2] net/smc: make wr buffer count configurable
config: loongarch-randconfig-002-20250906 (https://download.01.org/0day-ci/archive/20250907/202509070225.pVKkaaCr-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070225.pVKkaaCr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070225.pVKkaaCr-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "smc_ib_sysctl_max_send_wr" [net/smc/smc.ko] undefined!
>> ERROR: modpost: "smc_ib_sysctl_max_recv_wr" [net/smc/smc.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

