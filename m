Return-Path: <linux-rdma+bounces-10511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ED7AC02B9
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 05:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9E21B6222A
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 03:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700DA1494D9;
	Thu, 22 May 2025 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMG928al"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C23A1B6;
	Thu, 22 May 2025 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747883575; cv=none; b=uYpCIR3A412svsyCeIEJiHJMHovwIDcxIC+k+7Fu0p1D7USsuToM6t1EJClcnk8H6xCjkeBhsedHUfmOZod+YLcxbioHj5hUZU5vcy3ULDlOgstQv7hqoC3IPtvubHXM5V9hoyEtgYdg2wI2c5z23H5uq3+njYJijzdbIrjN8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747883575; c=relaxed/simple;
	bh=5/LiaP+uX/OsJwwbgqyM+MuEPY85wwD6eLPaxD/gW/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+8QmTHLwEuB+UjxDhvav6lOzao1MWZut9ym6JFTEoyKu2P8tbY9m4UGfAiDq0BDxrg3sw5sbMBoSgRV5vp/Eofsl1n41+Xs0fzeN1wMRaq5QUGO76RQaFDVFw7xPs5/SE6tQ8rFzYlKbj51q9Qn3MgC1/kg0OLemMPb2J9Dn5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMG928al; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747883572; x=1779419572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5/LiaP+uX/OsJwwbgqyM+MuEPY85wwD6eLPaxD/gW/o=;
  b=NMG928alRp4OyDLV7ObVfvCfjJMRRrqcZMP5e9vRWYbWZy87pXUKvwFK
   f1HmCVLvofD2EgywWvtG8ScZI7KcMfYEGmmT6otQt2sb15b9QOdp9i9Yb
   i07W7043bnS+NXtJliEfirXK8IZvJ2CBDFQp6GNVSfexwJU3gsZE2765U
   4o1T6uWh3XPiVzuEmhWV762vpe7k8TMDectZCs9BZIHAIZzTsZwZoB7Dv
   AHUu2CO3CdViiJxnKpyhXZ9ORrts5WBTM8DAr20NnE1YZNe9lYy+MJcDE
   gMGc7gSWliDzo8wR4qfkyPRSmxtRqTUN3LxiecmBz/exqmMdB2c4VrGHX
   A==;
X-CSE-ConnectionGUID: 4qdnsOX1TIOCME1jXslAng==
X-CSE-MsgGUID: h82ngtgGRYaFfh1Gopvc8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="72414850"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="72414850"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 20:12:52 -0700
X-CSE-ConnectionGUID: FuZxdP3RQWym+in8/eOzWA==
X-CSE-MsgGUID: /6oOLcPMQtWU4RDqyGpVAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="177541262"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 21 May 2025 20:12:48 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHwMP-000OsC-0J;
	Thu, 22 May 2025 03:12:45 +0000
Date: Thu, 22 May 2025 11:12:35 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v3] net/mlx5: Add error handling in
 mlx5_query_nic_vport_node_guid()
Message-ID: <202505221016.r93lwUfJ-lkp@intel.com>
References: <20250521132343.844-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521132343.844-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.15-rc7 next-20250521]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/net-mlx5-Add-error-handling-in-mlx5_query_nic_vport_node_guid/20250521-212557
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250521132343.844-1-vulab%40iscas.ac.cn
patch subject: [PATCH v3] net/mlx5: Add error handling in mlx5_query_nic_vport_node_guid()
config: loongarch-randconfig-002-20250522 (https://download.01.org/0day-ci/archive/20250522/202505221016.r93lwUfJ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250522/202505221016.r93lwUfJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505221016.r93lwUfJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlx5/core/vport.c: In function 'mlx5_query_nic_vport_node_guid':
>> drivers/net/ethernet/mellanox/mlx5/core/vport.c:474:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
     474 |         ret = mlx5_query_nic_vport_context(mdev, 0, out);
         |         ^~~
         |         net
   drivers/net/ethernet/mellanox/mlx5/core/vport.c:474:9: note: each undeclared identifier is reported only once for each function it appears in


vim +474 drivers/net/ethernet/mellanox/mlx5/core/vport.c

   463	
   464	int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid)
   465	{
   466		u32 *out;
   467		int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
   468		int err;
   469	
   470		out = kvzalloc(outlen, GFP_KERNEL);
   471		if (!out)
   472			return -ENOMEM;
   473	
 > 474		ret = mlx5_query_nic_vport_context(mdev, 0, out);
   475		if (err)
   476			goto out;
   477	
   478		*node_guid = MLX5_GET64(query_nic_vport_context_out, out,
   479					nic_vport_context.node_guid);
   480	out:
   481		kvfree(out);
   482	
   483		return err;
   484	}
   485	EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_node_guid);
   486	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

