Return-Path: <linux-rdma+bounces-2406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B278C29F5
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 20:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4161C21A78
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 18:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5772F2D600;
	Fri, 10 May 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mymfPGRj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46811713;
	Fri, 10 May 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365954; cv=none; b=gccDsCkUBgE85ZNZgMeCrGVUVDOSGakKxxWicBLkXS1qZ1/EeCjQgjyK3AgDmHTj2weEZHIWECHzhDW+CBToIL0y70DdkZGu+PY01v98GuYSP9CdcxNvabGHd8M9dix5F7Spbhxwbr4+Omr92FjD/Shx9WhRMQuzu7Z4qp8sOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365954; c=relaxed/simple;
	bh=G9gYYTn56ZMRHxXCgVo54QvAy2pxEZPAYMOd+dNXTOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i11/I1d6jKCcy7/4zZ+JAHuiA30uRmIYQCRMrpiegodyOPp/iDrGizz3oy+JpOv7AeivbL2MEMqfZ1y4f8U2wblIqFEcLO3u0lNXD/rWf95TeWVecsKv8KutRrisnjo61/tNd2ltl39N6DTGhKsJucKgoO5tYw9HJwafoZOfBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mymfPGRj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715365952; x=1746901952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G9gYYTn56ZMRHxXCgVo54QvAy2pxEZPAYMOd+dNXTOI=;
  b=mymfPGRjH9eiE0vGGMXUay5nNyHr1ahfchjC/yKBzqFhTjSvAI8diFG8
   re6MRTo0UMNzva4A+pLZBGzWm3IJlEgPF8QLY2mmsx28dm9ytil44AvtJ
   GgO9dZ0FUJuZB3m3FjG6CzJPlYm6XoZUPi1IRSkUGfMZttK2J4RmPNqgJ
   l6HOFf3dSlsOHohl2QAqR85kRzg9QPA9BEGYryoc4ER6HHX+Tgborgqit
   VjZIGzdcxPrlKeqoRAjNLvrYrgIMJcZ0jsLLKhLNSGFQyrOnjflM2+NsV
   N84Db5BgJRIGXHKcCZqA9s3wF1pJdb782bKGyGAQEScBg9JpS+tsB/Jnq
   g==;
X-CSE-ConnectionGUID: 4LtJP3F4QX24hv0OxphQMQ==
X-CSE-MsgGUID: MCCV+7LpT1aoIUFB3nI+wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="21939974"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="21939974"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 11:32:31 -0700
X-CSE-ConnectionGUID: r4wIFvRLScGBHjGvpUXJDQ==
X-CSE-MsgGUID: y2uJc1LGTVGEQOFQXka1xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34135245"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 May 2024 11:32:27 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5V2f-0006U7-0Z;
	Fri, 10 May 2024 18:32:25 +0000
Date: Sat, 11 May 2024 02:32:23 +0800
From: kernel test robot <lkp@intel.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next 2/2] net/smc: Introduce IPPROTO_SMC
Message-ID: <202405110225.7378HJe1-lkp@intel.com>
References: <1715314333-107290-3-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715314333-107290-3-git-send-email-alibuda@linux.alibaba.com>

Hi Wythe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Wythe/net-smc-refatoring-initialization-of-smc-sock/20240510-121442
base:   net-next/main
patch link:    https://lore.kernel.org/r/1715314333-107290-3-git-send-email-alibuda%40linux.alibaba.com
patch subject: [PATCH net-next 2/2] net/smc: Introduce IPPROTO_SMC
config: x86_64-randconfig-002-20240510 (https://download.01.org/0day-ci/archive/20240511/202405110225.7378HJe1-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405110225.7378HJe1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405110225.7378HJe1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/smc/af_smc.c:3710:1: warning: unused label 'out_inet_prot' [-Wunused-label]
    3710 | out_inet_prot:
         | ^~~~~~~~~~~~~~
   1 warning generated.


vim +/out_inet_prot +3710 net/smc/af_smc.c

  3707	
  3708		static_branch_enable(&tcp_have_smc);
  3709		return 0;
> 3710	out_inet_prot:
  3711		inet_unregister_protosw(&smc_inet_protosw);
  3712		proto_unregister(&smc_inet_prot);
  3713	out_ulp:
  3714		tcp_unregister_ulp(&smc_ulp_ops);
  3715	out_lo:
  3716		smc_loopback_exit();
  3717	out_ib:
  3718		smc_ib_unregister_client();
  3719	out_sock:
  3720		sock_unregister(PF_SMC);
  3721	out_proto6:
  3722		proto_unregister(&smc_proto6);
  3723	out_proto:
  3724		proto_unregister(&smc_proto);
  3725	out_core:
  3726		smc_core_exit();
  3727	out_alloc_wqs:
  3728		destroy_workqueue(smc_close_wq);
  3729	out_alloc_hs_wq:
  3730		destroy_workqueue(smc_hs_wq);
  3731	out_alloc_tcp_ls_wq:
  3732		destroy_workqueue(smc_tcp_ls_wq);
  3733	out_pnet:
  3734		smc_pnet_exit();
  3735	out_nl:
  3736		smc_nl_exit();
  3737	out_ism:
  3738		smc_clc_exit();
  3739		smc_ism_exit();
  3740	out_pernet_subsys_stat:
  3741		unregister_pernet_subsys(&smc_net_stat_ops);
  3742	out_pernet_subsys:
  3743		unregister_pernet_subsys(&smc_net_ops);
  3744	
  3745		return rc;
  3746	}
  3747	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

