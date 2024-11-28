Return-Path: <linux-rdma+bounces-6152-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2149DB914
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 14:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A728416335C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516A01A9B59;
	Thu, 28 Nov 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXru4PHy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3A158527;
	Thu, 28 Nov 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801985; cv=none; b=em7Wh98ZWb+K/tTVlOYePU/rhi5DnR0GNZFsDPboHQQ+HR0DonMu2QLMlDWydwUBMbpa9KS9Am9IaNwIC3vvjR8LXDEfF+9iYfmQRmbYFJIhG0YSlEBbEfdKKmWl/H15OdaKU41uSlz40qdnNEt13aSB7KoGxiOMAi3HeXkbxGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801985; c=relaxed/simple;
	bh=UG+77VmKk7jPmYy+z4+sWVfveyZZmvMyCQvvHM+X7Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPoeYoiONjHBeFNc94K42vYIJ9DiH0Jtdx/ZXapmMweZIGLeTf51abUDYIuSKfcutf0JXlwR5UruIzb3C/6aITbF9XD/qFp4WfB6iFfwomFKaUY1SPHL2hWu+QvaAkJZuCccd3m7kUJZ0Im6omlI/AZP3xlCmEUTmAf1M3w2bE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXru4PHy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732801983; x=1764337983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UG+77VmKk7jPmYy+z4+sWVfveyZZmvMyCQvvHM+X7Gs=;
  b=nXru4PHy8tKuVyt638fxhfaX7gC8I2gzvHVqZqEfHl0yxOIVrosxMVn1
   MqvMNGjHa/DBleZuSV1j7mHuY+qAmh3mJaJ5Fsyi05sCoM7tLf9FHLLKw
   +koHjdmUbSJzlxM4zNGWDADLHOxVXzLjhTWGelSC+rRP+z1Fg3EgS9L7i
   RpWAdH6Om8BWFtHKwwbbbWPuxd3pczmSPkr0EP9PfgICjiWwSlnRBE6uF
   A+s3LH1MHDgeA2fLjhQXUuoVRyydWzAZwIeQAzC0O+yy1PgyBJIDzN2R2
   CoSJXM2boHcizQL6cYV7pO7bcKfUEQVcGHgel/GPZ+1PYbCyYXltKgh7F
   A==;
X-CSE-ConnectionGUID: KkCtx6B3QSCMoShgVjEZxw==
X-CSE-MsgGUID: tgfDycWOT76zvNcVaDMwdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33279016"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="33279016"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:53:02 -0800
X-CSE-ConnectionGUID: bTMg1z2ETMCuv7KPMMZ99A==
X-CSE-MsgGUID: ucUiTrj/RAaNx28VzoteOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="97203444"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Nov 2024 05:52:58 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGewx-0009dT-1q;
	Thu, 28 Nov 2024 13:52:55 +0000
Date: Thu, 28 Nov 2024 21:52:13 +0800
From: kernel test robot <lkp@intel.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
Message-ID: <202411282154.DjX7ilwF-lkp@intel.com>
References: <20241127094533.18459-3-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127094533.18459-3-guangguan.wang@linux.alibaba.com>

Hi Guangguan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangguan-Wang/net-smc-support-SMC-R-V2-for-rdma-devices-with-max_recv_sge-equals-to-1/20241128-111259
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241127094533.18459-3-guangguan.wang%40linux.alibaba.com
patch subject: [PATCH net-next 2/2] net/smc: support ipv4 mapped ipv6 addr client for smc-r v2
config: arm-randconfig-001-20241128 (https://download.01.org/0day-ci/archive/20241128/202411282154.DjX7ilwF-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411282154.DjX7ilwF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411282154.DjX7ilwF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/smc/af_smc.c:27:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2225:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> net/smc/af_smc.c:1120:46: error: no member named 'skc_v6_rcv_saddr' in 'struct sock_common'; did you mean 'skc_rcv_saddr'?
    1120 |              !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
         |                                                     ^
   include/net/sock.h:376:37: note: expanded from macro 'sk_v6_rcv_saddr'
     376 | #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
         |                                     ^
   include/net/sock.h:155:11: note: 'skc_rcv_saddr' declared here
     155 |                         __be32  skc_rcv_saddr;
         |                                 ^
   1 warning and 1 error generated.


vim +1120 net/smc/af_smc.c

  1087	
  1088	static int smc_find_proposal_devices(struct smc_sock *smc,
  1089					     struct smc_init_info *ini)
  1090	{
  1091		int rc = 0;
  1092	
  1093		/* check if there is an ism device available */
  1094		if (!(ini->smcd_version & SMC_V1) ||
  1095		    smc_find_ism_device(smc, ini) ||
  1096		    smc_connect_ism_vlan_setup(smc, ini))
  1097			ini->smcd_version &= ~SMC_V1;
  1098		/* else ISM V1 is supported for this connection */
  1099	
  1100		/* check if there is an rdma device available */
  1101		if (!(ini->smcr_version & SMC_V1) ||
  1102		    smc_find_rdma_device(smc, ini))
  1103			ini->smcr_version &= ~SMC_V1;
  1104		/* else RDMA is supported for this connection */
  1105	
  1106		ini->smc_type_v1 = smc_indicated_type(ini->smcd_version & SMC_V1,
  1107						      ini->smcr_version & SMC_V1);
  1108	
  1109		/* check if there is an ism v2 device available */
  1110		if (!(ini->smcd_version & SMC_V2) ||
  1111		    !smc_ism_is_v2_capable() ||
  1112		    smc_find_ism_v2_device_clnt(smc, ini))
  1113			ini->smcd_version &= ~SMC_V2;
  1114	
  1115		/* check if there is an rdma v2 device available */
  1116		ini->check_smcrv2 = true;
  1117		ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
  1118		if (!(ini->smcr_version & SMC_V2) ||
  1119		    (smc->clcsock->sk->sk_family != AF_INET &&
> 1120		     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
  1121		    !smc_clc_ueid_count() ||
  1122		    smc_find_rdma_device(smc, ini))
  1123			ini->smcr_version &= ~SMC_V2;
  1124		ini->check_smcrv2 = false;
  1125	
  1126		ini->smc_type_v2 = smc_indicated_type(ini->smcd_version & SMC_V2,
  1127						      ini->smcr_version & SMC_V2);
  1128	
  1129		/* if neither ISM nor RDMA are supported, fallback */
  1130		if (ini->smc_type_v1 == SMC_TYPE_N && ini->smc_type_v2 == SMC_TYPE_N)
  1131			rc = SMC_CLC_DECL_NOSMCDEV;
  1132	
  1133		return rc;
  1134	}
  1135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

