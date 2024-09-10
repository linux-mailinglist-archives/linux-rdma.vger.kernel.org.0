Return-Path: <linux-rdma+bounces-4867-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFDE9741AD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 20:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4211C2450D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8E71A2643;
	Tue, 10 Sep 2024 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2RxjOkF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A22199389
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991563; cv=none; b=ccULu4c8fAJfJ5SoPZ5YRzlpdG+gYvGXl3Qz/lbTw9mWiqRN8qkZXZ6VbvoNgPKfDDs74Y4slRKnODoNn1q6zntzG3ULIjQAiprxBa3YIqyAtJt7AYkzSyxceh6uIYwDsRMPha3//qC+Jic4/uxslv0+17D4bglrdZ64DKcQW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991563; c=relaxed/simple;
	bh=cYkmWOqYPRP2o+uuGehZ8/35RLKDmvOsEw4WIAINBqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6qzxQS7xTMWcodNatNuROxpPfnG2XtWidHPCZIcAC2lODts5cn5GRVtTjEKmkV7672YTEXvGuyaUzzo1TwwqQov3WOAQ4pmBepHftZXhMxxK+Bhq1CpTgrFKpLfz7WQqzhqE9APerNzWW//4w9OYi+lFDcQoKeSqUIsmhrwdkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2RxjOkF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725991561; x=1757527561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cYkmWOqYPRP2o+uuGehZ8/35RLKDmvOsEw4WIAINBqU=;
  b=N2RxjOkFYOVoHB2UvRQE7UHa5srEMFLechYLjUpD/dTu2dzLPVdSHWaa
   SZNqiSSuw63DljG+0xVlHV8S2d1/F9O2ZHUOqgEVzP4cv7GAtPO8slgkC
   6nO1wZ8w48sHqJFnNccVVn4WgNqqZLDl8HAG8zN3G/g/s552hirWLvdd1
   423WHuS42XpnN86myo9X1gBrLHIUfy73Kni2grMdOeelkT3/SGoJpdQ1v
   s0ky/j5hpm/cxuTBtfKVHUOtOcGSmLF3oWbR9BPT23ssNBUeJBwc9iHX3
   sZsFUZRFS8geOd/bUAnpyLCRf/lKXDpb8204MWuWX67M6Hwq1jX4vpZST
   g==;
X-CSE-ConnectionGUID: yjnISNycRqaDFfZ4K2V6WA==
X-CSE-MsgGUID: PCwi8EviQSS2BXaZB5NXcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="42277968"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="42277968"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 11:06:01 -0700
X-CSE-ConnectionGUID: ZRMrzJdEQ+uibFOih6TwCQ==
X-CSE-MsgGUID: YBYFj/+LQf+CpjDsBIkS5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67123406"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Sep 2024 11:05:58 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so5FU-0002TE-1b;
	Tue, 10 Sep 2024 18:05:56 +0000
Date: Wed, 11 Sep 2024 02:05:34 +0800
From: kernel test robot <lkp@intel.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org,
	jgg@ziepe.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 1/4] RDMA/bnxt_re: Change aux driver data to
 en_info to hold more information
Message-ID: <202409110129.V1tgNuph-lkp@intel.com>
References: <1725940862-4821-2-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725940862-4821-2-git-send-email-selvin.xavier@broadcom.com>

Hi Selvin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on next-20240910]
[cannot apply to linus/master v6.11-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Selvin-Xavier/RDMA-bnxt_re-Change-aux-driver-data-to-en_info-to-hold-more-information/20240910-122414
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/1725940862-4821-2-git-send-email-selvin.xavier%40broadcom.com
patch subject: [PATCH for-next 1/4] RDMA/bnxt_re: Change aux driver data to en_info to hold more information
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240911/202409110129.V1tgNuph-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409110129.V1tgNuph-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409110129.V1tgNuph-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/bnxt_re/main.c: In function 'bnxt_re_remove':
>> drivers/infiniband/hw/bnxt_re/main.c:1939:29: warning: variable 'en_dev' set but not used [-Wunused-but-set-variable]
    1939 |         struct bnxt_en_dev *en_dev;
         |                             ^~~~~~


vim +/en_dev +1939 drivers/infiniband/hw/bnxt_re/main.c

  1935	
  1936	static void bnxt_re_remove(struct auxiliary_device *adev)
  1937	{
  1938		struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
> 1939		struct bnxt_en_dev *en_dev;
  1940		struct bnxt_re_dev *rdev;
  1941	
  1942		mutex_lock(&bnxt_re_mutex);
  1943		if (!en_info) {
  1944			mutex_unlock(&bnxt_re_mutex);
  1945			return;
  1946		}
  1947		en_dev = en_info->en_dev;
  1948		rdev = en_info->rdev;
  1949		if (!rdev)
  1950			goto skip_remove;
  1951	
  1952		if (rdev->nb.notifier_call) {
  1953			unregister_netdevice_notifier(&rdev->nb);
  1954			rdev->nb.notifier_call = NULL;
  1955		} else {
  1956			/* If notifier is null, we should have already done a
  1957			 * clean up before coming here.
  1958			 */
  1959			goto skip_remove;
  1960		}
  1961		bnxt_re_setup_cc(rdev, false);
  1962		ib_unregister_device(&rdev->ibdev);
  1963		bnxt_re_dev_uninit(rdev);
  1964		ib_dealloc_device(&rdev->ibdev);
  1965	skip_remove:
  1966		kfree(en_info);
  1967		mutex_unlock(&bnxt_re_mutex);
  1968	}
  1969	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

