Return-Path: <linux-rdma+bounces-5-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62D77F2758
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 09:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935D52829F8
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 08:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92C23A280;
	Tue, 21 Nov 2023 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miiEBTq5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24391CB
	for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 00:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700554919; x=1732090919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=06kDnKoPPzGlmQ1ra8/q9Os8ll0YijwScIZDkJ+PJO8=;
  b=miiEBTq5gRmMPcl2hah9ip/QE6eGGEP8p1JREmb/mpLatOzkLgGKmixE
   N8vWgkLAoPonawxCcZrVBaKzFA1PBI+bgdRaw6KehirGTZWEjfKC/dKy9
   Bja1Wy8GDREayv68Tbq4r/ITGEs+7JgvlfYQpmmGCCb2rjfcXKC5zra3q
   0/SXVTK2I3LK8K5h8/HlFSrvjVnJzUy5aowu0NIU9ybhZ7N2yT2QXgGbp
   qFUAbe4W2Afyck1yu/YbhaORo0BXnsvwH3erg1Lqs85bb+GubsWv849Iz
   YuA6Iq2OSaoUgdR02lKUkkUqiFGg82vNREsDTLG7YV7w7dK2LMsgBJRIb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="391568722"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="391568722"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="770179025"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="770179025"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2023 00:21:57 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5M0i-0007Yk-1G;
	Tue, 21 Nov 2023 08:21:48 +0000
Date: Tue, 21 Nov 2023 16:21:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, leon@kernel.org,
	jgg@ziepe.ca
Subject: Re: [PATCH 2/2] ipoib: Add tx timeout work to recover queue stop
 situation
Message-ID: <202311211607.9eJYoznW-lkp@intel.com>
References: <20231120203501.321587-3-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120203501.321587-3-jinpu.wang@ionos.com>

Hi Jack,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jack-Wang/ipoib-Fix-error-code-return-in-ipoib_mcast_join/20231121-044240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20231120203501.321587-3-jinpu.wang%40ionos.com
patch subject: [PATCH 2/2] ipoib: Add tx timeout work to recover queue stop situation
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231121/202311211607.9eJYoznW-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211607.9eJYoznW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211607.9eJYoznW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/infiniband/ulp/ipoib/ipoib_ib.c:542:9: error: call to undeclared function 'napi_reschedule'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   ret = napi_reschedule(&priv->send_napi);
                         ^
   drivers/infiniband/ulp/ipoib/ipoib_ib.c:542:9: note: did you mean 'napi_schedule'?
   include/linux/netdevice.h:520:20: note: 'napi_schedule' declared here
   static inline bool napi_schedule(struct napi_struct *n)
                      ^
   drivers/infiniband/ulp/ipoib/ipoib_ib.c:554:8: error: call to undeclared function 'napi_reschedule'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           ret = napi_reschedule(&priv->send_napi);
                 ^
   2 errors generated.


vim +/napi_reschedule +542 drivers/infiniband/ulp/ipoib/ipoib_ib.c

   533	
   534	/* The function will force napi_schedule */
   535	void ipoib_napi_schedule_work(struct work_struct *work)
   536	{
   537		struct ipoib_dev_priv *priv =
   538			container_of(work, struct ipoib_dev_priv, reschedule_napi_work);
   539		bool ret;
   540	
   541		do {
 > 542			ret = napi_reschedule(&priv->send_napi);
   543			if (!ret)
   544				msleep(3);
   545		} while (!ret && netif_queue_stopped(priv->dev) &&
   546			 test_bit(IPOIB_FLAG_INITIALIZED, &priv->flags));
   547	}
   548	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

