Return-Path: <linux-rdma+bounces-276-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24580666B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 06:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA72B2116D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 05:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D4E3D6B;
	Wed,  6 Dec 2023 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y83Gr4C/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DA1188;
	Tue,  5 Dec 2023 21:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701839161; x=1733375161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oYy3ulZppwSO+ElFtVFX9KxBc0sNypmx8d06stBPNsI=;
  b=Y83Gr4C/19a93ZkL5TM+jHWf7W2bOPQ4yOiMvc7ICRvNMwufLDrnjauk
   x2jWhBvj2VTVWm4EVa/sJy4WJgwqyfGXtLPkUUZ6eVv9hWWbPlBQ1WqtQ
   gqHwJW/u5MlxeD3S0Bll+yJeM1k6han2UCrZsiiJxj5COk/uuv529Bf6M
   JNbYDvowyrgYHPv9Vs51Al9r4dxQEQgRrnVsTBJ8Tv7vg1Af70I/12hnU
   XHoHyZPawbeKXyJ2iAZDZIFQL0ADXUb2dhsJUsVV/xZ546sOpZe/be6CZ
   g09E+661hC0IAXgHoEavJgl8QpRMFYeO+MWGjVVH1kBvGLuNhRzG87Cq3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373468570"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="373468570"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 21:05:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="12566291"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Dec 2023 21:05:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAk6c-000AJ6-1E;
	Wed, 06 Dec 2023 05:05:54 +0000
Date: Wed, 6 Dec 2023 13:04:59 +0800
From: kernel test robot <lkp@intel.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
	leon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org,
	huangjunxian6@hisilicon.com
Subject: Re: [PATCH for-rc 6/6] RDMA/hns: Improve the readability of free mr
 uninit
Message-ID: <202312061253.0VL1jlNs-lkp@intel.com>
References: <20231129094434.134528-7-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129094434.134528-7-huangjunxian6@hisilicon.com>

Hi Junxian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc4]
[cannot apply to rdma/for-next next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Junxian-Huang/RDMA-hns-Rename-the-interrupts/20231129-183932
base:   linus/master
patch link:    https://lore.kernel.org/r/20231129094434.134528-7-huangjunxian6%40hisilicon.com
patch subject: [PATCH for-rc 6/6] RDMA/hns: Improve the readability of free mr uninit
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20231206/202312061253.0VL1jlNs-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061253.0VL1jlNs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061253.0VL1jlNs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function 'free_mr_exit':
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2684:23: warning: unused variable 'qp' [-Wunused-variable]
    2684 |         struct ib_qp *qp;
         |                       ^~


vim +/qp +2684 drivers/infiniband/hw/hns/hns_roce_hw_v2.c

  2679	
  2680	static void free_mr_exit(struct hns_roce_dev *hr_dev)
  2681	{
  2682		struct hns_roce_v2_priv *priv = hr_dev->priv;
  2683		struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
> 2684		struct ib_qp *qp;
  2685		int i;
  2686	
  2687		for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++)
  2688			free_mr_uninit_qp(hr_dev, i);
  2689	
  2690		free_mr_uninit_cq(hr_dev);
  2691	
  2692		free_mr_uninit_pd(hr_dev);
  2693	}
  2694	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

