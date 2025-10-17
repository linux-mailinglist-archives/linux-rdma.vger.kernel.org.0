Return-Path: <linux-rdma+bounces-13924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E2BE7E8F
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 11:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067F2189922A
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040DE2D6E71;
	Fri, 17 Oct 2025 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhwgTpEO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE02DAFD8
	for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694983; cv=none; b=UZpkceLczkpyQ0ILvepTCccn/zcj0hOtOir7L19qEG726bBjKQHxIKCsQqDZMdIFuQetl2Lj3n/qHNupGDx1wnWqIUXzMp9NHlHXH2IK27a3INtMxvynQokyhAd1MVHDZu2lvnt4qrHve9HasQZktZ3DtYxCiSNFiBK57Cczg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694983; c=relaxed/simple;
	bh=A+6cSCGTm4AtT77Wz6M4Un3I0zYhQbZ6X93SH7HHeSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALwocouHupWfu/UpqsNTmXnCJ6lY9gA9sXhtul5L6gaJ+WYVHhIPAc9YxkbsAsrCMWXbT+S7c/gS0wSkpzKDFDavn4dUJV16prlDdRCnBdYGec4kHSWm8Kue/2cHBE8kJ5mI9fGblQYSBopKlaDYYczCoog84G6yf3G0wZfWf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhwgTpEO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760694982; x=1792230982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A+6cSCGTm4AtT77Wz6M4Un3I0zYhQbZ6X93SH7HHeSs=;
  b=dhwgTpEOVh89wpcEO29iNehKVPGqVEbQT6rXmOtyZRwx+OmC4xCjQyO/
   /iCqtQVu2/4Vb2If5fxsCwzNMieLXo/aeIVRlzWLbkyaZeu+PyZzCkT4N
   YBCkH6J42I1jsVn/XYf6bLpg3AZsOex2WDfAL95AKBa54bmDKi8+/2WZS
   UMwdtEhOvjiBlJnfpNlB3JgQQjeZurj42DZdNH1q3CVw8z+8AfGPj+q5z
   CkGbyJA0Z9PuDo//doFdUk8J2VZCLJbg3fuLEs7spcYJhz2LZ+url0du2
   3A3MwyLQOXW3mi7eNh3G88xUJYl9/17wcDkBxvPj7/l2+oBuIsGLg6Hn/
   A==;
X-CSE-ConnectionGUID: VU5MTT9KSqqjew5W2rsLfw==
X-CSE-MsgGUID: Fi6Emln6SKuM8Rjxtuy+Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66550110"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="66550110"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 02:56:21 -0700
X-CSE-ConnectionGUID: VU97YMCpSF2nn6TWPj9/YA==
X-CSE-MsgGUID: 5UJ2toIaRpKPy2cXvH21Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182252742"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 17 Oct 2025 02:56:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9hC5-0005p1-0w;
	Fri, 17 Oct 2025 09:56:17 +0000
Date: Fri, 17 Oct 2025 17:55:28 +0800
From: kernel test robot <lkp@intel.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
	leon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, huangjunxian6@hisilicon.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH v2 for-next 7/8] RDMA/hns: Support link state reporting
 for bond
Message-ID: <202510171755.ZCMuesa4-lkp@intel.com>
References: <20251016132023.3043538-8-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016132023.3043538-8-huangjunxian6@hisilicon.com>

Hi Junxian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.18-rc1 next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Junxian-Huang/RDMA-hns-Add-helpers-to-obtain-netdev-and-bus_num-from-hr_dev/20251016-212255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20251016132023.3043538-8-huangjunxian6%40hisilicon.com
patch subject: [PATCH v2 for-next 7/8] RDMA/hns: Support link state reporting for bond
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20251017/202510171755.ZCMuesa4-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171755.ZCMuesa4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510171755.ZCMuesa4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:7357:30: warning: unused variable 'bond_grp' [-Wunused-variable]
    7357 |         struct hns_roce_bond_group *bond_grp;
         |                                     ^~~~~~~~
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:7358:5: warning: unused variable 'bus_num' [-Wunused-variable]
    7358 |         u8 bus_num;
         |            ^~~~~~~
   2 warnings generated.


vim +/bond_grp +7357 drivers/infiniband/hw/hns/hns_roce_hw_v2.c

  7351	
  7352	static void hns_roce_hw_v2_link_status_change(struct hnae3_handle *handle,
  7353						      bool linkup)
  7354	{
  7355		struct hns_roce_dev *hr_dev = (struct hns_roce_dev *)handle->priv;
  7356		struct net_device *netdev = handle->rinfo.netdev;
> 7357		struct hns_roce_bond_group *bond_grp;
> 7358		u8 bus_num;
  7359	
  7360		if (linkup || !hr_dev)
  7361			return;
  7362	
  7363		/* For bond device, the link status depends on the upper netdev,
  7364		 * and the upper device's link status depends on all the slaves'
  7365		 * netdev but not only one. So bond device cannot get a correct
  7366		 * link status from this path.
  7367		 */
  7368		if (hns_roce_get_bond_grp(netdev, get_hr_bus_num(hr_dev)))
  7369			return;
  7370	
  7371		ib_dispatch_port_state_event(&hr_dev->ib_dev, netdev);
  7372	}
  7373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

