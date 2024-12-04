Return-Path: <linux-rdma+bounces-6242-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50B9E468A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372A0284883
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771B18B460;
	Wed,  4 Dec 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZGUAnuE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E0191F83;
	Wed,  4 Dec 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347420; cv=none; b=U8LDHfjM1u67GGR2qzaVluLDCO6Wt0w/bXSmeTVYxorXOvX9UMcx2hcoMn4rL5/Y9HLF8QayD+kTh0H3OtiwG0tJf4gV0h+SafQn92AATUvJs5jsk1bpl9MxNYTpprSTGFMi0717DBrFOfJniZH/U/x0TTf1SrS7Uon4xV66ikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347420; c=relaxed/simple;
	bh=mNofg1hTg0YdcTDLra4/FfjXPEnaYk1OszORZkd3Zsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idIfmZtMHMgoGnOD1wm1ugxtFlhA9YE2oyzqOykAAGsTY14AiH9Ptfwtwb+ZuvhG7zDfUJ70VvNvJZ3/i0wycF9XARDhIlg+k9ON1eAFFfmIbvpT0p2kOpTw09DQR7GM6qiSLyviK9Pm5Cvi9JVLKKC7wDxIfyuwwTIcKJJkaGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZGUAnuE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733347418; x=1764883418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mNofg1hTg0YdcTDLra4/FfjXPEnaYk1OszORZkd3Zsk=;
  b=GZGUAnuEoUq30mR4470Z+mxzNENylk8KxEVQfffWYeLmUWaYk3m/XlVA
   yTNhF246lcu03YvI+om4/FtxSl/5vkYwvhwg6YLuU9AhR6IvjS5XZ148U
   7qUNmGNuMHzF/w0rStOZ4xcQHq20r3cxu8uYgJBczbSem+NCBb17UPOBu
   zc83QTp+yny5IL385FcE/lX4EGIOSBxijUjXTHlZt0qomax9IYUuMem8Q
   1AE5kT94RuCn+xFasic0SOV1CXjH29Ok1N3A27OmfSjQ1d/tUx50PeYQS
   l1MdyRqqN7iLeX5z5wIAHHSQQvhpRklfDABXxaxGLN9eKZwQUQVyPWgCN
   Q==;
X-CSE-ConnectionGUID: 5l1uXbjGRoOiwUXCPn0kcQ==
X-CSE-MsgGUID: rePxSNlgSRi6zbR+9QCftw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="36480144"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="36480144"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 13:23:37 -0800
X-CSE-ConnectionGUID: 3mnhJN5RQlK78St+s68PTA==
X-CSE-MsgGUID: aq8CJ+ayR5qHcOD00kslmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93783596"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 04 Dec 2024 13:23:34 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIwqE-0003Vn-36;
	Wed, 04 Dec 2024 21:23:28 +0000
Date: Thu, 5 Dec 2024 05:22:16 +0800
From: kernel test robot <lkp@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next V4 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <202412050552.sNZ6Y79O-lkp@intel.com>
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
config: arm-randconfig-001 (https://download.01.org/0day-ci/archive/20241205/202412050552.sNZ6Y79O-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050552.sNZ6Y79O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050552.sNZ6Y79O-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:44,
                    from include/linux/etherdevice.h:21,
                    from net/devlink/devl_internal.h:7,
                    from net/devlink/rate.c:7:
   net/devlink/rate.c: In function 'devlink_nl_rate_tc_bw_set':
>> include/linux/netlink.h:116:13: warning: ' traffic classes must be spe...' directive output truncated writing 34 bytes into a region of size 32 [-Wformat-truncation=]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/devlink/rate.c:403:25: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     403 |                         NL_SET_ERR_MSG_FMT(info->extack,
         |                         ^~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: 'snprintf' output 83 bytes into a destination of size 80
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/devlink/rate.c:403:25: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     403 |                         NL_SET_ERR_MSG_FMT(info->extack,
         |                         ^~~~~~~~~~~~~~~~~~


vim +116 include/linux/netlink.h

2d4bc93368f5a0d Johannes Berg 2017-04-12  107  
51c352bdbcd23d7 Edward Cree   2022-10-18  108  /* We splice fmt with %s at each end even in the snprintf so that both calls
51c352bdbcd23d7 Edward Cree   2022-10-18  109   * can use the same string constant, avoiding its duplication in .ro
51c352bdbcd23d7 Edward Cree   2022-10-18  110   */
51c352bdbcd23d7 Edward Cree   2022-10-18  111  #define NL_SET_ERR_MSG_FMT(extack, fmt, args...) do {			       \
51c352bdbcd23d7 Edward Cree   2022-10-18  112  	struct netlink_ext_ack *__extack = (extack);			       \
51c352bdbcd23d7 Edward Cree   2022-10-18  113  									       \
51c352bdbcd23d7 Edward Cree   2022-10-18  114  	if (!__extack)							       \
51c352bdbcd23d7 Edward Cree   2022-10-18  115  		break;							       \
51c352bdbcd23d7 Edward Cree   2022-10-18 @116  	if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,	       \
51c352bdbcd23d7 Edward Cree   2022-10-18  117  		     "%s" fmt "%s", "", ##args, "") >=			       \
51c352bdbcd23d7 Edward Cree   2022-10-18  118  	    NETLINK_MAX_FMTMSG_LEN)					       \
51c352bdbcd23d7 Edward Cree   2022-10-18  119  		net_warn_ratelimited("%s" fmt "%s", "truncated extack: ",      \
51c352bdbcd23d7 Edward Cree   2022-10-18  120  				     ##args, "\n");			       \
51c352bdbcd23d7 Edward Cree   2022-10-18  121  									       \
51c352bdbcd23d7 Edward Cree   2022-10-18  122  	do_trace_netlink_extack(__extack->_msg_buf);			       \
51c352bdbcd23d7 Edward Cree   2022-10-18  123  									       \
51c352bdbcd23d7 Edward Cree   2022-10-18  124  	__extack->_msg = __extack->_msg_buf;				       \
51c352bdbcd23d7 Edward Cree   2022-10-18  125  } while (0)
51c352bdbcd23d7 Edward Cree   2022-10-18  126  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

