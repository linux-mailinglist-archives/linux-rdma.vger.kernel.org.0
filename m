Return-Path: <linux-rdma+bounces-13583-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F15BB93EA8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 03:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5D284E1738
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 01:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213A1DFDE;
	Tue, 23 Sep 2025 01:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhhzT8/8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840C242D83;
	Tue, 23 Sep 2025 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592704; cv=none; b=mAwkOSCM5wl0deL1ORZnE6BgI6k31UdhfrLO8Y4JiH62rUI76a8U5oBx0wHEsfO+NZj7eLniLWtXG1hKcaVgL2H3tkjPnrJC9WX1C7Ah1sGXJw3YhVK1idHDvn+SPBzpkQsPLR0w3/noCM/c26aCJl3+Ti9mgW4TbRdN+emC8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592704; c=relaxed/simple;
	bh=fRH+CAIfUuNLAhEOvvOT5dvUo6xPGpHu130myqe2ZJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCwYYH+gwbAOg8juO2Py8sGjjbplztoGQ3E3p5pxtfTLqh7u6DT+BiRin1pu+ZlF9qwEJpEM5WtfqEBDp69PYy+Ct+Fy4iiiJuRoYKjo0VljBEQ5H6IpSq0kndG4IjyC4BzwQpxmwr3m4iRUQ31AFeTr1ziJmjRyaEuLejpDJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhhzT8/8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758592703; x=1790128703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fRH+CAIfUuNLAhEOvvOT5dvUo6xPGpHu130myqe2ZJI=;
  b=YhhzT8/8A3BLFL0ROVVkogOL5YvV3mo2OhgxSMbyNnmUu6seMp1Ocjpk
   I2fwTeD1Zozf3CB4QtuypS4T4EpAYbT776kibcG8sG8SQyhxuRfl4CIAP
   kl4mKOb19MHXVF77gCQF9MUCjHqzrqz+xVFnLX5I1BPu1aHjsR0nTu6Hs
   VnZVdD3yGWIedHAtrZY2Ro74LsdFtD1u2BmXDdMattdzO8G+2pChmpU1O
   C2T45g/0YU9IY5BncJ7QKPCNtYHudxuFe+WCASlC0N1QKLFRYpiEtyzdG
   wgE7/clAxhCPd9QGyr292O0NNRssouZQYLanBM9v99OsnOmSz0UC46pKt
   w==;
X-CSE-ConnectionGUID: AlhsWC21T5yoQUFISdGnjg==
X-CSE-MsgGUID: jbI8fowlSDCVLACFWFsnNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72288950"
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="72288950"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 18:58:23 -0700
X-CSE-ConnectionGUID: 8crt4ow9QXC57FygEAnWgg==
X-CSE-MsgGUID: zloDIG89TTWLvWpaxBEf2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="176558188"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Sep 2025 18:58:18 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0sIJ-0002e3-39;
	Tue, 23 Sep 2025 01:58:15 +0000
Date: Tue, 23 Sep 2025 09:58:02 +0800
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
	Moshe Shemesh <moshe@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 3/7] net/mlx5: Improve QoS error messages with
 actual depth values
Message-ID: <202509230959.thBtcZnc-lkp@intel.com>
References: <1758531671-819655-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758531671-819655-4-git-send-email-tariqt@nvidia.com>

Hi Tariq,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0]

url:    https://github.com/intel-lab-lkp/linux/commits/Tariq-Toukan/net-mlx5-HWS-Generalize-complex-matchers/20250922-170716
base:   312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
patch link:    https://lore.kernel.org/r/1758531671-819655-4-git-send-email-tariqt%40nvidia.com
patch subject: [PATCH net-next 3/7] net/mlx5: Improve QoS error messages with actual depth values
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250923/202509230959.thBtcZnc-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509230959.thBtcZnc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509230959.thBtcZnc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c:974:4: warning: 'snprintf' will always be truncated; specified size is 80, but format string expands to at least 82 [-Wformat-truncation]
     974 |                         NL_SET_ERR_MSG_FMT_MOD(extack,
         |                         ^
   include/linux/netlink.h:131:2: note: expanded from macro 'NL_SET_ERR_MSG_FMT_MOD'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^
   include/linux/netlink.h:116:6: note: expanded from macro 'NL_SET_ERR_MSG_FMT'
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^
   drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c:1448:3: warning: 'snprintf' will always be truncated; specified size is 80, but format string expands to at least 82 [-Wformat-truncation]
    1448 |                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                 ^
   include/linux/netlink.h:131:2: note: expanded from macro 'NL_SET_ERR_MSG_FMT_MOD'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^
   include/linux/netlink.h:116:6: note: expanded from macro 'NL_SET_ERR_MSG_FMT'
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^
   2 warnings generated.


vim +/snprintf +974 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c

   955	
   956	static int
   957	esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
   958				struct netlink_ext_ack *extack)
   959	{
   960		struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
   961		struct mlx5_esw_sched_node *parent = vport_node->parent;
   962		int err;
   963	
   964		if (type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
   965			int new_level, max_level;
   966	
   967			/* Increase the parent's level by 2 to account for both the
   968			 * TC arbiter and the vports TC scheduling element.
   969			 */
   970			new_level = (parent ? parent->level : 2) + 2;
   971			max_level = 1 << MLX5_CAP_QOS(vport_node->esw->dev,
   972						      log_esw_max_sched_depth);
   973			if (new_level > max_level) {
 > 974				NL_SET_ERR_MSG_FMT_MOD(extack,
   975						       "TC arbitration on leafs is not supported beyond max scheduling depth %d",
   976						       max_level);
   977				return -EOPNOTSUPP;
   978			}
   979		}
   980	
   981		esw_assert_qos_lock_held(vport->dev->priv.eswitch);
   982	
   983		if (type == SCHED_NODE_TYPE_RATE_LIMITER)
   984			err = esw_qos_create_rate_limit_element(vport_node, extack);
   985		else
   986			err = esw_qos_tc_arbiter_scheduling_setup(vport_node, extack);
   987		if (err)
   988			return err;
   989	
   990		/* Rate limiters impact multiple nodes not directly connected to them
   991		 * and are not direct members of the QoS hierarchy.
   992		 * Unlink it from the parent to reflect that.
   993		 */
   994		if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
   995			list_del_init(&vport_node->entry);
   996			vport_node->level = 0;
   997		}
   998	
   999		err  = esw_qos_create_vport_tc_sched_elements(vport, type, extack);
  1000		if (err)
  1001			goto err_sched_nodes;
  1002	
  1003		return 0;
  1004	
  1005	err_sched_nodes:
  1006		if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
  1007			esw_qos_node_destroy_sched_element(vport_node, NULL);
  1008			esw_qos_node_attach_to_parent(vport_node);
  1009		} else {
  1010			esw_qos_tc_arbiter_scheduling_teardown(vport_node, NULL);
  1011		}
  1012		return err;
  1013	}
  1014	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

