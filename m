Return-Path: <linux-rdma+bounces-13584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 644CFB942BD
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 06:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D0918A3488
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B727381F;
	Tue, 23 Sep 2025 04:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5glPcMZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AE2CCC0;
	Tue, 23 Sep 2025 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758600401; cv=none; b=WrWPgGYKpMdaVCrjPlLUwojB77juzcq9Jp9xoqD1Y/fe3b8P0cfyJKJXs8quz8UeemkRio6g7Rmkxxo5hxSnh+Sd9Gm179nE63PcENcuwZbTkkW/fca/VlIiahgG6jK7MTcJ8m3jyUpxmyzO8/TNmXkCUDqB/A2zlCKcSPdhr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758600401; c=relaxed/simple;
	bh=VZX0azsj2Y+I4tix4/GQPEAlzuuwnGYKkwOGjH+jPEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSHHS7upziXcoNHhaDVNbTdZxQF45blRWJwnzwq/WbIGMLkZDZeWpScKsRBf76CtehQHa6aTdbfTNwsMLVskAViSCg6nodWRBahM0kXHlf53RoLD9gIBK1caywAm3PItkfm2XiPjIXQ1OUzzPWHXp/FTyZqjcL0IzD9wcdbRE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5glPcMZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758600400; x=1790136400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VZX0azsj2Y+I4tix4/GQPEAlzuuwnGYKkwOGjH+jPEM=;
  b=k5glPcMZ/eeAqPtIrSFuBDMrj7AceTtSHPscwmQu0VxuE5vDL/UW3AR8
   PEq92ZFaxsW32/dr6V/VcG6mmw7+OVsUw13/xbuNJItfesKQN9ZtIcAp9
   BK64JbUBCpPDyKrTll4/hQz4ENZTJMAytp+4ROfROsZ9/WVNAdOCqNwWH
   csP+t9dl0ZTzo7+ytp7p5pffp47n/LKjpVxN0ENXPoXtv50HIy7fsQMVK
   tPA+ZCSlfeW/T+DdD+FfI8uEFOxB24XPLRcIeTerJwxYsNZQKxLQ5zENG
   y/XqF66eE0lnz1xRxLeYUbzj/LoQ3nyLyhVA1xkth0GYhai1VqwhtO+WE
   A==;
X-CSE-ConnectionGUID: oYgo5dhoQ8eEYvKt3UNUUQ==
X-CSE-MsgGUID: SuxTSzTTSuq9oXtUWhrzQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86307513"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="86307513"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 21:06:39 -0700
X-CSE-ConnectionGUID: cX+GWRf6Tu2t5gJnCXlABw==
X-CSE-MsgGUID: Es1S0oWbQ6miuIDWmPNphw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="177030369"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 22 Sep 2025 21:06:35 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0uIQ-0002jV-2y;
	Tue, 23 Sep 2025 04:06:31 +0000
Date: Tue, 23 Sep 2025 12:06:22 +0800
From: kernel test robot <lkp@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next 7/7] net/mlx5e: Use extack in set rxfh callback
Message-ID: <202509231125.Tsan9Qny-lkp@intel.com>
References: <1758531671-819655-8-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758531671-819655-8-git-send-email-tariqt@nvidia.com>

Hi Tariq,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0]

url:    https://github.com/intel-lab-lkp/linux/commits/Tariq-Toukan/net-mlx5-HWS-Generalize-complex-matchers/20250922-170716
base:   312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
patch link:    https://lore.kernel.org/r/1758531671-819655-8-git-send-email-tariqt%40nvidia.com
patch subject: [PATCH net-next 7/7] net/mlx5e: Use extack in set rxfh callback
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250923/202509231125.Tsan9Qny-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509231125.Tsan9Qny-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509231125.Tsan9Qny-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c:1508:4: warning: 'snprintf' will always be truncated; specified size is 80, but format string expands to at least 131 [-Wformat-truncation]
    1508 |                         NL_SET_ERR_MSG_FMT_MOD(
         |                         ^
   include/linux/netlink.h:131:2: note: expanded from macro 'NL_SET_ERR_MSG_FMT_MOD'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^
   include/linux/netlink.h:116:6: note: expanded from macro 'NL_SET_ERR_MSG_FMT'
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^
   1 warning generated.


vim +/snprintf +1508 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c

  1495	
  1496	static int mlx5e_rxfh_hfunc_check(struct mlx5e_priv *priv,
  1497					  const struct ethtool_rxfh_param *rxfh,
  1498					  struct netlink_ext_ack *extack)
  1499	{
  1500		unsigned int count;
  1501	
  1502		count = priv->channels.params.num_channels;
  1503	
  1504		if (rxfh->hfunc == ETH_RSS_HASH_XOR) {
  1505			unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
  1506	
  1507			if (count > xor8_max_channels) {
> 1508				NL_SET_ERR_MSG_FMT_MOD(
  1509					extack,
  1510					"Cannot set RSS hash function to XOR, current number of channels (%d) exceeds the maximum allowed for XOR8 RSS hfunc (%d)\n",
  1511					count, xor8_max_channels);
  1512				return -EINVAL;
  1513			}
  1514		}
  1515	
  1516		return 0;
  1517	}
  1518	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

