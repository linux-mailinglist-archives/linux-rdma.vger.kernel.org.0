Return-Path: <linux-rdma+bounces-2405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E48C291B
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 19:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A76D1F24189
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9828C17C6B;
	Fri, 10 May 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZyWs0du"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4117BA2;
	Fri, 10 May 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360970; cv=none; b=neoElRA4j/HMAfEA0JYkhpRfHndg3l6HZL0huJrUUAhPHMpQemuVHGZ5Abfj5aJRykvc54e7WkNttmuYGXsyypHJJwJV+aF0ROpLPnQau6HiHDbJtnWXQLYGQ8zb8WYUBpU8nbT6LAxV/5uKiexCskUiLctUFKTACfPdaW/Qtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360970; c=relaxed/simple;
	bh=qSTaOA+Y7IeRNxGNDOeKkRpF7oBKmwmi5GT5xSEmXdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQCLDtSh8qlFG+D9WxfFgxvFlWtIqvft2YbqCrIHUZmQMd1n0C/KNhlDqminNV5aZMPtUjmvjy5LdoeWdOT7Frrx7JMYJaknFGJuIeK2FEKRf8rxCOe+v7d+f2gtRtC3HYaV0uLvc2Vf64ZbhNIFZ5eYBNLY997YSnBHOrdkUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZyWs0du; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715360968; x=1746896968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qSTaOA+Y7IeRNxGNDOeKkRpF7oBKmwmi5GT5xSEmXdk=;
  b=AZyWs0duprVgW7GRl1RI+tVLFvprOTHTxHZILzEWSsRO28qZ9uzs2OcO
   U+xWw1hbD1OsjcT+mR90ONVkoNvch+vARu8euE4Dgm5qxORanwN2ZG3QZ
   U3opN/dbRfSaeCRqTCahVAMd5Hp1R5zatH3ZrOy6Yw4uNZXs4UYzOR4n8
   4ZEq8eOpVay516QFU2hk6BxnbAcbJzxP81hLVP+5vbJGiKwuIrukXU9Vg
   HAJOqKe0FdRidfFXYF3w9ygeuZI1RDDlhzGeZn2zmfFuu4vvJqqxZi6dh
   lqR7cL1rE6BPQ34GreMtsu4dxI98m1vr8IwlxizIWRphK18jn77IbaH2L
   w==;
X-CSE-ConnectionGUID: mG4W036FRwqlKWTPOyKJ/g==
X-CSE-MsgGUID: zxnH3M6bThad8gKctjMgHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11513339"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11513339"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 10:09:27 -0700
X-CSE-ConnectionGUID: F0qyHsW1SoOTvyONG6EWRQ==
X-CSE-MsgGUID: DH7RKwmcQzq2ZdGdLdoaqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34438249"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 May 2024 10:09:23 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5TkG-0006PL-3B;
	Fri, 10 May 2024 17:09:20 +0000
Date: Sat, 11 May 2024 01:09:05 +0800
From: kernel test robot <lkp@intel.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com,
	pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next 2/2] net/smc: Introduce IPPROTO_SMC
Message-ID: <202405110124.GxQs28cK-lkp@intel.com>
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
config: i386-buildonly-randconfig-002-20240510 (https://download.01.org/0day-ci/archive/20240511/202405110124.GxQs28cK-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405110124.GxQs28cK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405110124.GxQs28cK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/smc/af_smc.c: In function 'smc_init':
>> net/smc/af_smc.c:3710:1: warning: label 'out_inet_prot' defined but not used [-Wunused-label]
    out_inet_prot:
    ^~~~~~~~~~~~~


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

