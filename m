Return-Path: <linux-rdma+bounces-2250-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AE08BB194
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868211F22DC7
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4203157E76;
	Fri,  3 May 2024 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAHHNHyI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5E157A49;
	Fri,  3 May 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756550; cv=none; b=d7Pq0ONtUEy52kDPXFBSao2UxP/WQjDfg8JyPJqA4GYAEURwo/hs2Mpd3flVIsVOQQBegVjpnkE5NvxEqSHVU2bauq6KJXD5l6BBJHafeDNGeUwnJuHxsbcR6kpgyOz8cTo9GqJ/0gcZUK3jtAbEeiWsW1ImsM68PpThZ3/KTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756550; c=relaxed/simple;
	bh=nmzk+rIi5lhP+mMY1lgQk4NZ9UnrTXzds4LWmy2mArY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUGAjmE+d0N8Czg4C393akXybd2ZBHO6obs3gHZPWiLxhh+nYE/RTwDqw9c5Tg15LFBzSQrZacqqzQ+N1BfwVcRKsFJZAsUkus4vABkcSbGhzqNgU6/o01ZL7QQVTdsh29kNbb/VbJQ5/Z/5Okc4o2vxjIu/XLoR0HVpVkCsO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAHHNHyI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756549; x=1746292549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nmzk+rIi5lhP+mMY1lgQk4NZ9UnrTXzds4LWmy2mArY=;
  b=SAHHNHyIUPctz3+Q4BOz3lipk9rGbqFKusJFUgQ6o+4VBC37kNSQSlX+
   nU1v8MohxetSYODNq2K2nSKnPsGT2Vx+VPoph3d8O+OMPd9w1/vm4MGpG
   6bQfTQP39uoxLITVdTFnHJJo/LPZCXI3bC9WuWNzmsgjFvE4mQAirtQwu
   dJGtMEOgi3bLojsAhfiV0MQzvspOJjb3qyraifK3LZg14mEJM+SLo2PKc
   0fx4NlCoUC+0J5tnrYLnM/lmZ5VzNb0WkMnFjHePqabWpt78rYvpZzHl8
   lMzkQFQ/wsBJS3v7tzPxLrO84DXFgmY4DuhYNXanFALzvdvuxAo6HPABy
   A==;
X-CSE-ConnectionGUID: 2HBnTOLGQ96jx51nNFt4IA==
X-CSE-MsgGUID: dce0ttkiQcCdWt8vRnXoWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10499676"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10499676"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:15:48 -0700
X-CSE-ConnectionGUID: KdVxzLLHRbG1FAlcm1gMAg==
X-CSE-MsgGUID: jzsi3S87SGqKEJo5T5+tCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="32185685"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 May 2024 10:15:44 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2wVZ-000Bw0-2e;
	Fri, 03 May 2024 17:15:41 +0000
Date: Sat, 4 May 2024 01:14:57 +0800
From: kernel test robot <lkp@intel.com>
To: Shay Drory <shayd@nvidia.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, gregkh@linuxfoundation.org,
	david.m.ertman@intel.com
Cc: oe-kbuild-all@lists.linux.dev, rafael@kernel.org, ira.weiny@intel.com,
	linux-rdma@vger.kernel.org, leon@kernel.org, tariqt@nvidia.com,
	Shay Drory <shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 1/2] driver core: auxiliary bus: show auxiliary device
 IRQs
Message-ID: <202405040108.NWUaSJgz-lkp@intel.com>
References: <20240503043104.381938-2-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503043104.381938-2-shayd@nvidia.com>

Hi Shay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus net/main net-next/main linus/master v6.9-rc6 next-20240503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shay-Drory/driver-core-auxiliary-bus-show-auxiliary-device-IRQs/20240503-123319
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20240503043104.381938-2-shayd%40nvidia.com
patch subject: [PATCH 1/2] driver core: auxiliary bus: show auxiliary device IRQs
config: s390-randconfig-r081-20240503 (https://download.01.org/0day-ci/archive/20240504/202405040108.NWUaSJgz-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240504/202405040108.NWUaSJgz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405040108.NWUaSJgz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/auxiliary.c:182: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is


vim +182 drivers/base/auxiliary.c

   180	
   181	/**
 > 182	 * Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
   183	 * shared or exclusive.
   184	 */
   185	static ssize_t auxiliary_irq_mode_show(struct device *dev,
   186					       struct device_attribute *attr, char *buf)
   187	{
   188		struct auxiliary_irq_info *info =
   189			container_of(attr, struct auxiliary_irq_info, sysfs_attr);
   190	
   191		if (refcount_read(xa_load(&irqs, info->irq)) > 1)
   192			return sysfs_emit(buf, "%s\n", "shared");
   193		else
   194			return sysfs_emit(buf, "%s\n", "exclusive");
   195	}
   196	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

