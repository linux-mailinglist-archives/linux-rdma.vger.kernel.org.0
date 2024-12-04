Return-Path: <linux-rdma+bounces-6241-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9809E463A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4FC169165
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 21:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690B1917E3;
	Wed,  4 Dec 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNSRR48i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742918DF81;
	Wed,  4 Dec 2024 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346089; cv=none; b=ToBsswANOLXscQ4bDSfPXHd7W/kwT8Op8Q5MBNV+eBaXyxrEYjw0rluBqe/Il4bzZTJYNwTysUce8/KtpeFcdz709tYZ+ZKCdAYY3QkIwKe2J42sTfmPj2ufuRxdZfVD1Zf0TgL022UCIc4Gb9R1f1npnTNaHvVzpr/zMZiwVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346089; c=relaxed/simple;
	bh=YYisex5fANxvp1J7FXSt2wFTYyLxl4fy8A9aDQDg1FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNvrbLHg+1IuHwK6kwlRGa4AJjhPGK2Weg1G0uCFHS0JO8ri9aQuoYKRCwKyQUkl5aMDzkYgRV/mH1JC/bStrTF7fGQsVlsomLui2poeiWOdxzTAW/iEH90SOvbG1gAmND1s4seez4+UGFchNsZ9D44r87Zbo10SHKB7oLg6zg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNSRR48i; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733346088; x=1764882088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YYisex5fANxvp1J7FXSt2wFTYyLxl4fy8A9aDQDg1FQ=;
  b=nNSRR48i5t9Qm9/t5po/KTw13GNfQkhEabEwgZE/trvtAd5kVzZAzFkB
   pNr9Provy09XZweEesbuoDeqHlPiCrM0O0NXLBwon3VXoY1xzi3Dn4FNt
   duTbwgU331MHNg/jPABW7ZbO6n2cPqYWWnGyGfGP/WFdFoKLmS0yNsTo1
   A+R+W/Khlv+oLJKkAcADYc1WSxeUDo4cFSKgXLFNwEuJ1r8rPzi1zu3SV
   d2G+7yuulEG3IYIoRQWm2BpY9OhHMA9SvFVkmYAsiAl6ov7HPUc190y2K
   yQshcoHESyxoin+aDII00rgsVDIw+di0evf+V/B4a7luXLobrjmwbx5ft
   A==;
X-CSE-ConnectionGUID: dW3lS1L2R7iWSW1w8WfVLg==
X-CSE-MsgGUID: pAWn637UTgSHidUSV8nRlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33376974"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33376974"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 13:01:25 -0800
X-CSE-ConnectionGUID: QWS2hJyNQWOxHgI42sEvdA==
X-CSE-MsgGUID: 21i45RZzRYqLQ7OlhLyg3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="97937245"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Dec 2024 13:01:21 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIwUo-0003UD-2j;
	Wed, 04 Dec 2024 21:01:18 +0000
Date: Thu, 5 Dec 2024 05:00:58 +0800
From: kernel test robot <lkp@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next V4 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <202412050416.e7egEz4f-lkp@intel.com>
References: <20241203202924.228440-8-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203202924.228440-8-tariqt@nvidia.com>

Hi Tariq,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tariq-Toukan/net-mlx5-ifc-Reorganize-mlx5_ifc_flow_table_context_bits/20241204-124235
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241203202924.228440-8-tariqt%40nvidia.com
patch subject: [PATCH net-next V4 07/11] devlink: Extend devlink rate API with traffic classes bandwidth management
config: x86_64-buildonly-randconfig-001-20241205 (https://download.01.org/0day-ci/archive/20241205/202412050416.e7egEz4f-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050416.e7egEz4f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050416.e7egEz4f-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/devlink/rate.c:7:
   In file included from net/devlink/devl_internal.h:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/devlink/rate.c:7:
   net/devlink/devl_internal.h:29:19: warning: arithmetic between different enumeration types ('enum devlink_reload_limit' and 'enum devlink_reload_action') [-Wenum-enum-conversion]
      29 |         u32 reload_stats[DEVLINK_RELOAD_STATS_ARRAY_SIZE];
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/devlink/devl_internal.h:26:30: note: expanded from macro 'DEVLINK_RELOAD_STATS_ARRAY_SIZE'
      26 |         (__DEVLINK_RELOAD_LIMIT_MAX * __DEVLINK_RELOAD_ACTION_MAX)
         |          ~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/devlink/devl_internal.h:30:26: warning: arithmetic between different enumeration types ('enum devlink_reload_limit' and 'enum devlink_reload_action') [-Wenum-enum-conversion]
      30 |         u32 remote_reload_stats[DEVLINK_RELOAD_STATS_ARRAY_SIZE];
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/devlink/devl_internal.h:26:30: note: expanded from macro 'DEVLINK_RELOAD_STATS_ARRAY_SIZE'
      26 |         (__DEVLINK_RELOAD_LIMIT_MAX * __DEVLINK_RELOAD_ACTION_MAX)
         |          ~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/devlink/rate.c:403:4: warning: 'snprintf' will always be truncated; specified size is 80, but format string expands to at least 83 [-Wformat-truncation]
     403 |                         NL_SET_ERR_MSG_FMT(info->extack,
         |                         ^
   include/linux/netlink.h:116:6: note: expanded from macro 'NL_SET_ERR_MSG_FMT'
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^
   7 warnings generated.


vim +/snprintf +403 net/devlink/rate.c

   381	
   382	static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
   383					     struct genl_info *info)
   384	{
   385		DECLARE_BITMAP(bitmap, IEEE_8021QAZ_MAX_TCS) = {};
   386		struct devlink *devlink = devlink_rate->devlink;
   387		const struct devlink_ops *ops = devlink->ops;
   388		u32 tc_bw[IEEE_8021QAZ_MAX_TCS] = {};
   389		int rem, err = -EOPNOTSUPP, i;
   390		struct nlattr *attr;
   391	
   392		nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
   393				  genlmsg_len(info->genlhdr), rem) {
   394			if (nla_type(attr) == DEVLINK_ATTR_RATE_TC_BWS) {
   395				err = devlink_nl_rate_tc_bw_parse(attr, tc_bw, bitmap, info->extack);
   396				if (err)
   397					return err;
   398			}
   399		}
   400	
   401		for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
   402			if (!test_bit(i, bitmap)) {
 > 403				NL_SET_ERR_MSG_FMT(info->extack,
   404						   "Incomplete traffic class bandwidth values, all %u traffic classes must be specified",
   405						   IEEE_8021QAZ_MAX_TCS);
   406				return -EINVAL;
   407			}
   408		}
   409	
   410		if (devlink_rate_is_leaf(devlink_rate))
   411			err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
   412						       info->extack);
   413		else if (devlink_rate_is_node(devlink_rate))
   414			err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
   415						       info->extack);
   416	
   417		if (err)
   418			return err;
   419	
   420		memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
   421	
   422		return 0;
   423	}
   424	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

