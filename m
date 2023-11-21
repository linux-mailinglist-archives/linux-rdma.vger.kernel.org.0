Return-Path: <linux-rdma+bounces-4-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D56C7F24CD
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 05:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4A31C2168F
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 04:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D52182AE;
	Tue, 21 Nov 2023 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAf94ejG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CFD9
	for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 20:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700540433; x=1732076433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mSsmE4qN3g0cbfA3Bxr8Xu3a9KltYcO5b9GJVL+pKpA=;
  b=dAf94ejGp19kdSRg1iQY2b0PJNuE88q+arCEpbtcGEvhrAbIOBKyzWIn
   DRYgfJV4j2j3RXz7u+g2FcsoW8yc2Qstrk0GupgLu13jPwqMT3Iy7uJRF
   OZYkH+W4D3SeWUEpseIApxJW+zCFUwMqKQopbjCUt5fpGOKTPo8cogRxL
   YhT6b1UI1xjs2tR7d8xyRepSyZB8JOmtwQzzlx7ClDehdCNAp2OQTM2+4
   1PiOAJJaXCcb/3OgYNBUf1GOCZpEkcgFpx9o8GTHqsV6DVBLGIQNuE2GK
   e74MfGqmwhlTjsH/N9IeYphc4Rzx3IOaCrv5fUgKeK6rdotbun89S9LRL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="394603415"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="394603415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 20:20:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="795668319"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="795668319"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2023 20:20:31 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5IFQ-0007Hw-2S;
	Tue, 21 Nov 2023 04:20:28 +0000
Date: Tue, 21 Nov 2023 12:20:21 +0800
From: kernel test robot <lkp@intel.com>
To: Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, leon@kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH 2/2] ipoib: Add tx timeout work to recover queue stop
 situation
Message-ID: <202311211231.oyOBtdMM-lkp@intel.com>
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
[also build test ERROR on linus/master v6.7-rc2 next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jack-Wang/ipoib-Fix-error-code-return-in-ipoib_mcast_join/20231121-044240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20231120203501.321587-3-jinpu.wang%40ionos.com
patch subject: [PATCH 2/2] ipoib: Add tx timeout work to recover queue stop situation
config: x86_64-buildonly-randconfig-001-20231121 (https://download.01.org/0day-ci/archive/20231121/202311211231.oyOBtdMM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211231.oyOBtdMM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211231.oyOBtdMM-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/infiniband/ulp/ipoib/ipoib_ib.c: In function 'ipoib_napi_schedule_work':
>> drivers/infiniband/ulp/ipoib/ipoib_ib.c:542:9: error: implicit declaration of function 'napi_reschedule'; did you mean 'napi_schedule'? [-Werror=implicit-function-declaration]
     542 |   ret = napi_reschedule(&priv->send_napi);
         |         ^~~~~~~~~~~~~~~
         |         napi_schedule
   cc1: some warnings being treated as errors


vim +542 drivers/infiniband/ulp/ipoib/ipoib_ib.c

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

