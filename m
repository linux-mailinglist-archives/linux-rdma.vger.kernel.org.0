Return-Path: <linux-rdma+bounces-13913-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3C6BE657D
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 06:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A3994E4DE2
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 04:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B3A30C378;
	Fri, 17 Oct 2025 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RS4mDZT+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65C256C9F
	for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760676913; cv=none; b=m/Zpe22qX5X1zE2ltP8u5I+OMWcbiFXfm8gIYVp5hiLDDUuaJ3Ie8wEA0axHcKcrj9vr88bRuEqVMYURuuP9a43ziSKIbqSFX8QH4KW1IhVDZEXPYloLcg/K3A7LXShrAykOkh1E5way0VvqSlZ6BqLlnuwhbQQBbHkHp4LZIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760676913; c=relaxed/simple;
	bh=cFWHVZsc4a6CmD9dvCJ/sJwIN6GmsLf2mBle2ES8xcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKllQONyxX0pLOEKVN5/JGa+8uMhuUKzxYkeGLFX9ylhvRmCxlRjnFRtApEiRDfBqOXzapZ0CVj7u8Xb4asnRJfxG37jdtKg0D75obOauR3z8yh0KbXyJFgrGuz3zbyG32SgfTkyq83R0vJyan45T3VM+mtDKVHF+Zwrvkn2J8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RS4mDZT+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760676911; x=1792212911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cFWHVZsc4a6CmD9dvCJ/sJwIN6GmsLf2mBle2ES8xcY=;
  b=RS4mDZT+S3FFV9jODhKxNgFr10sbH3c4DAbFbefh/knZtshsYm0Xuld6
   RrL+7TawGWkjBuPh27zQCQl16vY+TK1DIU8jfRynYtoHnMGRsBjPzsNR+
   dGAVmR/2SyuBpBdhuLSrCa9ZT384YVWElyCxn5JwAQZ4msLmF/8elkPW+
   pd3gLzGAdk8HwXWQi62cCHfRaX1bzuv9fI1UomFl8J+/CKRDcdcHXCALV
   a1xO8pzfliePHy4Ry+vyGxKt6K8UXaAOwk48PjPHkZfsUJzuiuklneOvL
   LoATqSgrRg1mcBpaxxBRkGI713CD22UNcb05T7GeljSBksF4CTvRF6kWE
   Q==;
X-CSE-ConnectionGUID: TvRwnu+kSPyucXjZpBy8qA==
X-CSE-MsgGUID: v2u/+vnRS8S7vXlZtRcvAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62928204"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62928204"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 21:55:11 -0700
X-CSE-ConnectionGUID: JHzYp8xuTQmTl3baOClZ5A==
X-CSE-MsgGUID: jkPJappmQ+e+sSE4W4rwsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="181836215"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2025 21:55:08 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9cUb-0005Xj-2D;
	Fri, 17 Oct 2025 04:55:05 +0000
Date: Fri, 17 Oct 2025 12:54:48 +0800
From: kernel test robot <lkp@intel.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
	leon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, huangjunxian6@hisilicon.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH v2 for-next 5/8] RDMA/hns: Implement bonding init/uninit
 process
Message-ID: <202510171225.QiCg3w7E-lkp@intel.com>
References: <20251016132023.3043538-6-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016132023.3043538-6-huangjunxian6@hisilicon.com>

Hi Junxian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.18-rc1 next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Junxian-Huang/RDMA-hns-Add-helpers-to-obtain-netdev-and-bus_num-from-hr_dev/20251016-212255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20251016132023.3043538-6-huangjunxian6%40hisilicon.com
patch subject: [PATCH v2 for-next 5/8] RDMA/hns: Implement bonding init/uninit process
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20251017/202510171225.QiCg3w7E-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171225.QiCg3w7E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510171225.QiCg3w7E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/hns/hns_roce_main.c:645:6: warning: unused variable 'i' [-Wunused-variable]
     645 |         int i;
         |             ^
   1 warning generated.


vim +/i +645 drivers/infiniband/hw/hns/hns_roce_main.c

   637	
   638	static void hns_roce_unregister_device(struct hns_roce_dev *hr_dev,
   639					       bool bond_cleanup)
   640	{
   641		struct net_device *net_dev = get_hr_netdev(hr_dev, 0);
   642		struct hns_roce_ib_iboe *iboe = &hr_dev->iboe;
   643		struct hns_roce_bond_group *bond_grp;
   644		u8 bus_num = get_hr_bus_num(hr_dev);
 > 645		int i;
   646	
   647		if (bond_cleanup && hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND) {
   648			bond_grp = hns_roce_get_bond_grp(net_dev, bus_num);
   649			if (bond_grp)
   650				hns_roce_unregister_bond_cleanup(hr_dev, bond_grp);
   651		}
   652	
   653		hr_dev->active = false;
   654		unregister_netdevice_notifier(&iboe->nb);
   655		ib_unregister_device(&hr_dev->ib_dev);
   656	}
   657	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

