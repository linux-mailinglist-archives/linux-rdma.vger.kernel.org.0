Return-Path: <linux-rdma+bounces-12074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2DEB02E61
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 04:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916B517B72E
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 02:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CD169D2B;
	Sun, 13 Jul 2025 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBifN8jb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF9419BBA;
	Sun, 13 Jul 2025 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752372352; cv=none; b=gneofV85vFvwaalFlizXxOo+JTREKpt7PPkdIfU+3yfcahYabalYNU5eooKGzECHRrKofgYUGIgRxpm0kBWvHH4/TEEDGamLaguCTlRQQzE7/8AnQq8ff5eg0IbDpevwQ2/H37Pxs9Kf5ML+YWxK3RG5CtcSaXvUCY+uAzkgc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752372352; c=relaxed/simple;
	bh=gN7pQcGk4dzgLG/75FHG9/admseukzraWRxYA3yX/uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8h/l2Aes1nX7RnV8K1isbUoLUfYAqjfXEV1m68R6K+ecpCp/k2pKHoPf14qORhbB1LwtA8OJ7Qf9m+IXyxs91qipJDIzeuUmtOOQo/JAAsXYHqe8IaMDDgvLaURafcbtdyBRihfF35J0KW99QNj+r4eCbEqyvmx5vgID9T7yhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBifN8jb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752372351; x=1783908351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gN7pQcGk4dzgLG/75FHG9/admseukzraWRxYA3yX/uk=;
  b=IBifN8jbjRor7d1EO9xPguNQWjRpKc1l/x3IfiBTkngU1mUmcBP/TD9j
   /OqBycTfWQZdonLLO4pGroPjkMFgtiW1WfrTo9cZjhMKYECiUZ3owz/7t
   LyCuZESOy9CeJFrBQb94AfBG9XcdbEAefXObUpIJdGRSpS8YODI50/5qb
   lfxmctNQKGbIhwyshopKsSxh+4MbKNa70aZekSTHibLznYOqYLbj1YyvW
   zWpsBaiHVpPhiv7PST8QXGGCjxl5M0WBTED2MbXfAx4/xC6+qdUCJqwWc
   BUIeNlN9ygPynLymqv1lUu7FF2yjP5pE8kyjM6hLTHBBdK57wNFXCyAtM
   w==;
X-CSE-ConnectionGUID: +u0QnsutSkSjtYXAfocHAQ==
X-CSE-MsgGUID: Al+NpKFFShaFKIy7lmxTjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58273024"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="58273024"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 19:05:51 -0700
X-CSE-ConnectionGUID: jpv6bIpERte7ki6v+dMfAA==
X-CSE-MsgGUID: pTVAAhtKQpOCPpV2V3CcBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="162328738"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Jul 2025 19:05:48 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uam64-0007pb-23;
	Sun, 13 Jul 2025 02:05:44 +0000
Date: Sun, 13 Jul 2025 10:05:07 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next v2 1/1] net/mlx5: Don't use "proxy" headers
Message-ID: <202507130919.xwitQGtJ-lkp@intel.com>
References: <20250709083757.181265-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709083757.181265-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/net-mlx5-Don-t-use-proxy-headers/20250709-163919
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250709083757.181265-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH net-next v2 1/1] net/mlx5: Don't use "proxy" headers
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250713/202507130919.xwitQGtJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250713/202507130919.xwitQGtJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507130919.xwitQGtJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlx5/core/en_main.c: In function 'mlx5e_open_channel':
>> drivers/net/ethernet/mellanox/mlx5/core/en_main.c:2766:23: error: implicit declaration of function 'irq_get_effective_affinity_mask'; did you mean 'irq_create_affinity_masks'? [-Werror=implicit-function-declaration]
    2766 |         c->aff_mask = irq_get_effective_affinity_mask(irq);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       irq_create_affinity_masks
   drivers/net/ethernet/mellanox/mlx5/core/en_main.c:2766:21: warning: assignment to 'const struct cpumask *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2766 |         c->aff_mask = irq_get_effective_affinity_mask(irq);
         |                     ^
   cc1: some warnings being treated as errors


vim +2766 drivers/net/ethernet/mellanox/mlx5/core/en_main.c

2e642afb61b244 Maxim Mikityanskiy 2022-04-15  2714  
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2715  static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2716  			      struct mlx5e_params *params,
1742b3d528690a Magnus Karlsson    2020-08-28  2717  			      struct xsk_buff_pool *xsk_pool,
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2718  			      struct mlx5e_channel **cp)
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2719  {
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2720  	struct net_device *netdev = priv->netdev;
31f114c3d158da Tariq Toukan       2024-12-03  2721  	struct mlx5e_channel_param *cparam;
67936e13858699 Tariq Toukan       2024-02-14  2722  	struct mlx5_core_dev *mdev;
db05815b36cbd4 Maxim Mikityanskiy 2019-06-26  2723  	struct mlx5e_xsk_param xsk;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2724  	struct mlx5e_channel *c;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2725  	unsigned int irq;
67936e13858699 Tariq Toukan       2024-02-14  2726  	int vec_ix;
67936e13858699 Tariq Toukan       2024-02-14  2727  	int cpu;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2728  	int err;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2729  
67936e13858699 Tariq Toukan       2024-02-14  2730  	mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, ix);
67936e13858699 Tariq Toukan       2024-02-14  2731  	vec_ix = mlx5_sd_ch_ix_get_vec_ix(mdev, ix);
67936e13858699 Tariq Toukan       2024-02-14  2732  	cpu = mlx5_comp_vector_get_cpu(mdev, vec_ix);
67936e13858699 Tariq Toukan       2024-02-14  2733  
67936e13858699 Tariq Toukan       2024-02-14  2734  	err = mlx5_comp_irqn_get(mdev, vec_ix, &irq);
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2735  	if (err)
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2736  		return err;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2737  
fa691d0c9c0812 Lama Kayal         2021-09-22  2738  	err = mlx5e_channel_stats_alloc(priv, ix, cpu);
fa691d0c9c0812 Lama Kayal         2021-09-22  2739  	if (err)
fa691d0c9c0812 Lama Kayal         2021-09-22  2740  		return err;
fa691d0c9c0812 Lama Kayal         2021-09-22  2741  
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2742  	c = kvzalloc_node(sizeof(*c), GFP_KERNEL, cpu_to_node(cpu));
31f114c3d158da Tariq Toukan       2024-12-03  2743  	cparam = kvzalloc(sizeof(*cparam), GFP_KERNEL);
31f114c3d158da Tariq Toukan       2024-12-03  2744  	if (!c || !cparam) {
31f114c3d158da Tariq Toukan       2024-12-03  2745  		err = -ENOMEM;
31f114c3d158da Tariq Toukan       2024-12-03  2746  		goto err_free;
31f114c3d158da Tariq Toukan       2024-12-03  2747  	}
31f114c3d158da Tariq Toukan       2024-12-03  2748  
31f114c3d158da Tariq Toukan       2024-12-03  2749  	err = mlx5e_build_channel_param(mdev, params, cparam);
31f114c3d158da Tariq Toukan       2024-12-03  2750  	if (err)
31f114c3d158da Tariq Toukan       2024-12-03  2751  		goto err_free;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2752  
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2753  	c->priv     = priv;
67936e13858699 Tariq Toukan       2024-02-14  2754  	c->mdev     = mdev;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2755  	c->tstamp   = &priv->tstamp;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2756  	c->ix       = ix;
67936e13858699 Tariq Toukan       2024-02-14  2757  	c->vec_ix   = vec_ix;
7f525acbccdf7e Tariq Toukan       2024-02-14  2758  	c->sd_ix    = mlx5_sd_ch_ix_get_dev_ix(mdev, ix);
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2759  	c->cpu      = cpu;
67936e13858699 Tariq Toukan       2024-02-14  2760  	c->pdev     = mlx5_core_dma_dev(mdev);
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2761  	c->netdev   = priv->netdev;
67936e13858699 Tariq Toukan       2024-02-14  2762  	c->mkey_be  = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey);
86d747a3f9697a Tariq Toukan       2021-07-06  2763  	c->num_tc   = mlx5e_get_dcb_num_tc(params);
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2764  	c->xdp      = !!params->xdp_prog;
be98737a4faa3a Tariq Toukan       2021-12-05  2765  	c->stats    = &priv->channel_stats[ix]->ch;
ec7b37b6f08fac Thomas Gleixner    2020-12-10 @2766  	c->aff_mask = irq_get_effective_affinity_mask(irq);
67936e13858699 Tariq Toukan       2024-02-14  2767  	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2768  
8f7b00307bf146 Cosmin Ratiu       2025-05-21  2769  	netif_napi_add_config_locked(netdev, &c->napi, mlx5e_napi_poll, ix);
8f7b00307bf146 Cosmin Ratiu       2025-05-21  2770  	netif_napi_set_irq_locked(&c->napi, irq);
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2771  
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2772  	err = mlx5e_open_queues(c, params, cparam);
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2773  	if (unlikely(err))
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2774  		goto err_napi_del;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2775  
1742b3d528690a Magnus Karlsson    2020-08-28  2776  	if (xsk_pool) {
1742b3d528690a Magnus Karlsson    2020-08-28  2777  		mlx5e_build_xsk_param(xsk_pool, &xsk);
1742b3d528690a Magnus Karlsson    2020-08-28  2778  		err = mlx5e_open_xsk(priv, params, &xsk, xsk_pool, c);
db05815b36cbd4 Maxim Mikityanskiy 2019-06-26  2779  		if (unlikely(err))
db05815b36cbd4 Maxim Mikityanskiy 2019-06-26  2780  			goto err_close_queues;
db05815b36cbd4 Maxim Mikityanskiy 2019-06-26  2781  	}
db05815b36cbd4 Maxim Mikityanskiy 2019-06-26  2782  
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2783  	*cp = c;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2784  
31f114c3d158da Tariq Toukan       2024-12-03  2785  	kvfree(cparam);
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2786  	return 0;
0a06382fa40601 Maxim Mikityanskiy 2019-06-26  2787  
db05815b36cbd4 Maxim Mikityanskiy 2019-06-26  2788  err_close_queues:
db05815b36cbd4 Maxim Mikityanskiy 2019-06-26  2789  	mlx5e_close_queues(c);
db05815b36cbd4 Maxim Mikityanskiy 2019-06-26  2790  
f62b8bb8f2d305 Amir Vadai         2015-05-28  2791  err_napi_del:
8f7b00307bf146 Cosmin Ratiu       2025-05-21  2792  	netif_napi_del_locked(&c->napi);
149e566fef8120 Moshe Shemesh      2018-10-25  2793  
31f114c3d158da Tariq Toukan       2024-12-03  2794  err_free:
31f114c3d158da Tariq Toukan       2024-12-03  2795  	kvfree(cparam);
ca11b798998a62 Tariq Toukan       2018-06-05  2796  	kvfree(c);
f62b8bb8f2d305 Amir Vadai         2015-05-28  2797  
f62b8bb8f2d305 Amir Vadai         2015-05-28  2798  	return err;
f62b8bb8f2d305 Amir Vadai         2015-05-28  2799  }
f62b8bb8f2d305 Amir Vadai         2015-05-28  2800  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

