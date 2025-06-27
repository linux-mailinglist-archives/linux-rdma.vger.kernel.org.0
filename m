Return-Path: <linux-rdma+bounces-11724-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C7AEC222
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 23:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1991698E4
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCB428A1D5;
	Fri, 27 Jun 2025 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvNQNS6I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E225D906;
	Fri, 27 Jun 2025 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060152; cv=none; b=JxDfTdkB7iUTZE5oIeW+RWhPCRfVW77YW3Qil6nb1B6Y12u7rNKO/+DJf0Van6nB5YyJDj+q4BllEVYWwH8zk0MppofHJWBnXORmihw5NZNAp+XuE56l6zx7u0C3tsxnCBDhgczz6DbE3rCyEUqJEqUk8rQGOKX8hAq8Yc4TVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060152; c=relaxed/simple;
	bh=dDiJZ0vgG3S+6SnN32VF9/i/0mO2k4wbUUU+DGN3xDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV8nvffUNIy6ltj1LfzmaeEQzDB0tuKwYduw5Ry7dkeWGCaK0/CJXX9f65TIKh4Xh3goYCo3KM3cUKmwhWp+S94ecIKa5oMpB8XUIPBBhHpatiVY1uPJFy4nUXoelAbRCB7RXWFsH9YAsMdmIIQnhz5yY9kyoGG37DnZ//PuXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvNQNS6I; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751060151; x=1782596151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dDiJZ0vgG3S+6SnN32VF9/i/0mO2k4wbUUU+DGN3xDQ=;
  b=YvNQNS6IHxakANVjSZE6D9+PygXYKzEz8Ow5lJclu3kShkjn2ixUOxDM
   iUlNdW4VYLkESp4Q3lmscYhga2Bb+swYmxIms/oYdR8Cbzn+6VuE+UCsC
   CvR7pJaS1BraXCBUnSDBf0LKOAPOlYrR3elIY6KXeGnGVlTe1VTSb9elk
   ka0keMNcas8uj7w4V/YLi/kqxqQ1D6Wn3u/HUYBshFBl1ZCcVeCKWmjfW
   bcPuRInlGVaBybXnvAW1fRAsIy+8yWEzJf2bFbG2bbklYn732cQU8G5XA
   eCB6kn1tocvkYXbr8V45Yl/StoAEQ2Bd4huNfpquE3XNu9XVBhDrwzK8a
   A==;
X-CSE-ConnectionGUID: yxSJHAK3TTWTtMSpqBKUfA==
X-CSE-MsgGUID: A83W81qiR7SzdtzxYDTjCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="52610801"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="52610801"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 14:35:50 -0700
X-CSE-ConnectionGUID: yDugyF5VQfy8pIYLYHd3ng==
X-CSE-MsgGUID: LjXKLAZTTRSfjtvYI4GxsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="153451742"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Jun 2025 14:35:47 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVGjZ-000WYo-0i;
	Fri, 27 Jun 2025 21:35:45 +0000
Date: Sat, 28 Jun 2025 05:35:28 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next v1 1/1] net/mlx5: Don't use "proxy" headers
Message-ID: <202506280551.g3Yi6Vuw-lkp@intel.com>
References: <20250626164509.327410-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626164509.327410-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/net-mlx5-Don-t-use-proxy-headers/20250627-004605
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250626164509.327410-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH net-next v1 1/1] net/mlx5: Don't use "proxy" headers
config: arm64-randconfig-001-20250628 (https://download.01.org/0day-ci/archive/20250628/202506280551.g3Yi6Vuw-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506280551.g3Yi6Vuw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506280551.g3Yi6Vuw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/infiniband/hw/mlx5/dm.h:9,
                    from drivers/infiniband/hw/mlx5/dm.c:7:
>> drivers/infiniband/hw/mlx5/mlx5_ib.h:1125:9: error: unknown type name 'mempool_t'
    1125 |         mempool_t *pool;
         |         ^~~~~~~~~
--
   In file included from drivers/net/ethernet/mellanox/mlx5/core/lib/gid.c:37:
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h: In function 'mlx5_core_net':
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:16: error: implicit declaration of function 'devlink_net'; did you mean 'dev_net'? [-Wimplicit-function-declaration]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                ^~~~~~~~~~~
         |                dev_net
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:28: error: implicit declaration of function 'priv_to_devlink' [-Wimplicit-function-declaration]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                            ^~~~~~~~~~~~~~~
>> drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:16: error: returning 'int' from a function with return type 'struct net *' makes pointer from integer without a cast [-Wint-conversion]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/ethernet/mellanox/mlx5/core/health.c:41:
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h: In function 'mlx5_core_net':
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:16: error: implicit declaration of function 'devlink_net'; did you mean 'dev_net'? [-Wimplicit-function-declaration]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                ^~~~~~~~~~~
         |                dev_net
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:28: error: implicit declaration of function 'priv_to_devlink' [-Wimplicit-function-declaration]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                            ^~~~~~~~~~~~~~~
>> drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:16: error: returning 'int' from a function with return type 'struct net *' makes pointer from integer without a cast [-Wint-conversion]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlx5/core/health.c:45:
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h: At top level:
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h:202:52: warning: 'struct devlink_fmsg' declared inside parameter list will not be visible outside of this definition or declaration
     202 |                                             struct devlink_fmsg *fmsg);
         |                                                    ^~~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlx5/core/health.c:46:
   drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.h:13:50: warning: 'struct devlink_fmsg' declared inside parameter list will not be visible outside of this definition or declaration
      13 |                                           struct devlink_fmsg *fmsg,
         |                                                  ^~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:465:34: warning: 'struct devlink_fmsg' declared inside parameter list will not be visible outside of this definition or declaration
     465 |                           struct devlink_fmsg *fmsg,
         |                                  ^~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_fw_reporter_diagnose':
   drivers/net/ethernet/mellanox/mlx5/core/health.c:468:37: error: implicit declaration of function 'devlink_health_reporter_priv' [-Wimplicit-function-declaration]
     468 |         struct mlx5_core_dev *dev = devlink_health_reporter_priv(reporter);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/mellanox/mlx5/core/health.c:468:37: error: initialization of 'struct mlx5_core_dev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/net/ethernet/mellanox/mlx5/core/health.c:473:9: error: implicit declaration of function 'devlink_fmsg_u8_pair_put' [-Wimplicit-function-declaration]
     473 |         devlink_fmsg_u8_pair_put(fmsg, "Syndrome", synd);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:477:9: error: implicit declaration of function 'devlink_fmsg_string_pair_put' [-Wimplicit-function-declaration]
     477 |         devlink_fmsg_string_pair_put(fmsg, "Description", hsynd_str(synd));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: At top level:
   drivers/net/ethernet/mellanox/mlx5/core/health.c:488:39: warning: 'struct devlink_fmsg' declared inside parameter list will not be visible outside of this definition or declaration
     488 | mlx5_fw_reporter_ctx_pairs_put(struct devlink_fmsg *fmsg,
         |                                       ^~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_fw_reporter_ctx_pairs_put':
   drivers/net/ethernet/mellanox/mlx5/core/health.c:492:9: error: implicit declaration of function 'devlink_fmsg_u32_pair_put' [-Wimplicit-function-declaration]
     492 |         devlink_fmsg_u32_pair_put(fmsg, "fw_miss_counter", fw_reporter_ctx->miss_counter);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: At top level:
   drivers/net/ethernet/mellanox/mlx5/core/health.c:497:47: warning: 'struct devlink_fmsg' declared inside parameter list will not be visible outside of this definition or declaration
     497 |                                        struct devlink_fmsg *fmsg)
         |                                               ^~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_fw_reporter_heath_buffer_data_put':
   drivers/net/ethernet/mellanox/mlx5/core/health.c:507:9: error: implicit declaration of function 'devlink_fmsg_pair_nest_start' [-Wimplicit-function-declaration]
     507 |         devlink_fmsg_pair_nest_start(fmsg, "health buffer");
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:508:9: error: implicit declaration of function 'devlink_fmsg_obj_nest_start' [-Wimplicit-function-declaration]
     508 |         devlink_fmsg_obj_nest_start(fmsg);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:509:9: error: implicit declaration of function 'devlink_fmsg_arr_pair_nest_start' [-Wimplicit-function-declaration]
     509 |         devlink_fmsg_arr_pair_nest_start(fmsg, "assert_var");
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:511:17: error: implicit declaration of function 'devlink_fmsg_u32_put' [-Wimplicit-function-declaration]
     511 |                 devlink_fmsg_u32_put(fmsg, ioread32be(h->assert_var + i));
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:512:9: error: implicit declaration of function 'devlink_fmsg_arr_pair_nest_end' [-Wimplicit-function-declaration]
     512 |         devlink_fmsg_arr_pair_nest_end(fmsg);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:526:9: error: implicit declaration of function 'devlink_fmsg_obj_nest_end' [-Wimplicit-function-declaration]
     526 |         devlink_fmsg_obj_nest_end(fmsg);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:527:9: error: implicit declaration of function 'devlink_fmsg_pair_nest_end' [-Wimplicit-function-declaration]
     527 |         devlink_fmsg_pair_nest_end(fmsg);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: At top level:
   drivers/net/ethernet/mellanox/mlx5/core/health.c:532:30: warning: 'struct devlink_fmsg' declared inside parameter list will not be visible outside of this definition or declaration
     532 |                       struct devlink_fmsg *fmsg, void *priv_ctx,
         |                              ^~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_fw_reporter_dump':
   drivers/net/ethernet/mellanox/mlx5/core/health.c:535:37: error: initialization of 'struct mlx5_core_dev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     535 |         struct mlx5_core_dev *dev = devlink_health_reporter_priv(reporter);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:545:48: error: passing argument 1 of 'mlx5_fw_reporter_ctx_pairs_put' from incompatible pointer type [-Wincompatible-pointer-types]
     545 |                 mlx5_fw_reporter_ctx_pairs_put(fmsg, fw_reporter_ctx);
         |                                                ^~~~
         |                                                |
         |                                                struct devlink_fmsg *
   drivers/net/ethernet/mellanox/mlx5/core/health.c:488:53: note: expected 'struct devlink_fmsg *' but argument is of type 'struct devlink_fmsg *'
     488 | mlx5_fw_reporter_ctx_pairs_put(struct devlink_fmsg *fmsg,
         |                                ~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:548:53: error: passing argument 2 of 'mlx5_fw_reporter_heath_buffer_data_put' from incompatible pointer type [-Wincompatible-pointer-types]
     548 |         mlx5_fw_reporter_heath_buffer_data_put(dev, fmsg);
         |                                                     ^~~~
         |                                                     |
         |                                                     struct devlink_fmsg *
   drivers/net/ethernet/mellanox/mlx5/core/health.c:497:61: note: expected 'struct devlink_fmsg *' but argument is of type 'struct devlink_fmsg *'
     497 |                                        struct devlink_fmsg *fmsg)
         |                                        ~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:550:69: error: passing argument 2 of 'mlx5_fw_tracer_get_saved_traces_objects' from incompatible pointer type [-Wincompatible-pointer-types]
     550 |         return mlx5_fw_tracer_get_saved_traces_objects(dev->tracer, fmsg);
         |                                                                     ^~~~
         |                                                                     |
         |                                                                     struct devlink_fmsg *
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h:202:66: note: expected 'struct devlink_fmsg *' but argument is of type 'struct devlink_fmsg *'
     202 |                                             struct devlink_fmsg *fmsg);
         |                                             ~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_fw_reporter_err_work':
   drivers/net/ethernet/mellanox/mlx5/core/health.c:566:17: error: implicit declaration of function 'devlink_health_report' [-Wimplicit-function-declaration]
     566 |                 devlink_health_report(health->fw_reporter,
         |                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: At top level:
   drivers/net/ethernet/mellanox/mlx5/core/health.c:576:21: error: variable 'mlx5_fw_reporter_pf_ops' has initializer but incomplete type
     576 | static const struct devlink_health_reporter_ops mlx5_fw_reporter_pf_ops = {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:577:18: error: 'const struct devlink_health_reporter_ops' has no member named 'name'
     577 |                 .name = "fw",
         |                  ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:577:25: warning: excess elements in struct initializer
     577 |                 .name = "fw",
         |                         ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:577:25: note: (near initialization for 'mlx5_fw_reporter_pf_ops')
   drivers/net/ethernet/mellanox/mlx5/core/health.c:578:18: error: 'const struct devlink_health_reporter_ops' has no member named 'diagnose'
     578 |                 .diagnose = mlx5_fw_reporter_diagnose,
         |                  ^~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:578:29: warning: excess elements in struct initializer
     578 |                 .diagnose = mlx5_fw_reporter_diagnose,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:578:29: note: (near initialization for 'mlx5_fw_reporter_pf_ops')
   drivers/net/ethernet/mellanox/mlx5/core/health.c:579:18: error: 'const struct devlink_health_reporter_ops' has no member named 'dump'
     579 |                 .dump = mlx5_fw_reporter_dump,
         |                  ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:579:25: warning: excess elements in struct initializer
     579 |                 .dump = mlx5_fw_reporter_dump,
         |                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:579:25: note: (near initialization for 'mlx5_fw_reporter_pf_ops')
   drivers/net/ethernet/mellanox/mlx5/core/health.c:582:21: error: variable 'mlx5_fw_reporter_ops' has initializer but incomplete type
     582 | static const struct devlink_health_reporter_ops mlx5_fw_reporter_ops = {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:583:18: error: 'const struct devlink_health_reporter_ops' has no member named 'name'
     583 |                 .name = "fw",
         |                  ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:583:25: warning: excess elements in struct initializer
     583 |                 .name = "fw",
         |                         ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:583:25: note: (near initialization for 'mlx5_fw_reporter_ops')
   drivers/net/ethernet/mellanox/mlx5/core/health.c:584:18: error: 'const struct devlink_health_reporter_ops' has no member named 'diagnose'
     584 |                 .diagnose = mlx5_fw_reporter_diagnose,
         |                  ^~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:584:29: warning: excess elements in struct initializer
     584 |                 .diagnose = mlx5_fw_reporter_diagnose,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:584:29: note: (near initialization for 'mlx5_fw_reporter_ops')
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_fw_fatal_reporter_recover':
   drivers/net/ethernet/mellanox/mlx5/core/health.c:592:37: error: initialization of 'struct mlx5_core_dev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     592 |         struct mlx5_core_dev *dev = devlink_health_reporter_priv(reporter);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: At top level:
   drivers/net/ethernet/mellanox/mlx5/core/health.c:599:36: warning: 'struct devlink_fmsg' declared inside parameter list will not be visible outside of this definition or declaration
     599 |                             struct devlink_fmsg *fmsg, void *priv_ctx,
         |                                    ^~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_fw_fatal_reporter_dump':
   drivers/net/ethernet/mellanox/mlx5/core/health.c:602:37: error: initialization of 'struct mlx5_core_dev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     602 |         struct mlx5_core_dev *dev = devlink_health_reporter_priv(reporter);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:620:48: error: passing argument 1 of 'mlx5_fw_reporter_ctx_pairs_put' from incompatible pointer type [-Wincompatible-pointer-types]
     620 |                 mlx5_fw_reporter_ctx_pairs_put(fmsg, fw_reporter_ctx);
         |                                                ^~~~
         |                                                |
         |                                                struct devlink_fmsg *
   drivers/net/ethernet/mellanox/mlx5/core/health.c:488:53: note: expected 'struct devlink_fmsg *' but argument is of type 'struct devlink_fmsg *'
     488 | mlx5_fw_reporter_ctx_pairs_put(struct devlink_fmsg *fmsg,
         |                                ~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:623:9: error: implicit declaration of function 'devlink_fmsg_binary_pair_put' [-Wimplicit-function-declaration]
     623 |         devlink_fmsg_binary_pair_put(fmsg, "crdump_data", cr_data, crdump_size);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_fw_fatal_reporter_err_work':
>> drivers/net/ethernet/mellanox/mlx5/core/health.c:641:17: error: assignment to 'struct devlink *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     641 |         devlink = priv_to_devlink(dev);
         |                 ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:652:17: error: implicit declaration of function 'devl_lock'; did you mean 'rtnl_lock'? [-Wimplicit-function-declaration]
     652 |                 devl_lock(devlink);
         |                 ^~~~~~~~~
         |                 rtnl_lock
   drivers/net/ethernet/mellanox/mlx5/core/health.c:655:17: error: implicit declaration of function 'devl_unlock'; did you mean 'rtnl_unlock'? [-Wimplicit-function-declaration]
     655 |                 devl_unlock(devlink);
         |                 ^~~~~~~~~~~
         |                 rtnl_unlock
   drivers/net/ethernet/mellanox/mlx5/core/health.c: At top level:
   drivers/net/ethernet/mellanox/mlx5/core/health.c:672:21: error: variable 'mlx5_fw_fatal_reporter_pf_ops' has initializer but incomplete type
     672 | static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_pf_ops = {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:673:18: error: 'const struct devlink_health_reporter_ops' has no member named 'name'
     673 |                 .name = "fw_fatal",
         |                  ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:673:25: warning: excess elements in struct initializer
     673 |                 .name = "fw_fatal",
         |                         ^~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:673:25: note: (near initialization for 'mlx5_fw_fatal_reporter_pf_ops')
   drivers/net/ethernet/mellanox/mlx5/core/health.c:674:18: error: 'const struct devlink_health_reporter_ops' has no member named 'recover'
     674 |                 .recover = mlx5_fw_fatal_reporter_recover,
         |                  ^~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:674:28: warning: excess elements in struct initializer
     674 |                 .recover = mlx5_fw_fatal_reporter_recover,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:674:28: note: (near initialization for 'mlx5_fw_fatal_reporter_pf_ops')
   drivers/net/ethernet/mellanox/mlx5/core/health.c:675:18: error: 'const struct devlink_health_reporter_ops' has no member named 'dump'
     675 |                 .dump = mlx5_fw_fatal_reporter_dump,
         |                  ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:675:25: warning: excess elements in struct initializer
     675 |                 .dump = mlx5_fw_fatal_reporter_dump,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:675:25: note: (near initialization for 'mlx5_fw_fatal_reporter_pf_ops')
   drivers/net/ethernet/mellanox/mlx5/core/health.c:678:21: error: variable 'mlx5_fw_fatal_reporter_ops' has initializer but incomplete type
     678 | static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_ops = {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:679:18: error: 'const struct devlink_health_reporter_ops' has no member named 'name'
     679 |                 .name = "fw_fatal",
         |                  ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:679:25: warning: excess elements in struct initializer
     679 |                 .name = "fw_fatal",
         |                         ^~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:679:25: note: (near initialization for 'mlx5_fw_fatal_reporter_ops')
   drivers/net/ethernet/mellanox/mlx5/core/health.c:680:18: error: 'const struct devlink_health_reporter_ops' has no member named 'recover'
     680 |                 .recover = mlx5_fw_fatal_reporter_recover,
         |                  ^~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:680:28: warning: excess elements in struct initializer
     680 |                 .recover = mlx5_fw_fatal_reporter_recover,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:680:28: note: (near initialization for 'mlx5_fw_fatal_reporter_ops')
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_fw_reporters_create':
>> drivers/net/ethernet/mellanox/mlx5/core/health.c:693:35: error: initialization of 'struct devlink *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     693 |         struct devlink *devlink = priv_to_devlink(dev);
         |                                   ^~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:710:17: error: implicit declaration of function 'devl_health_reporter_create' [-Wimplicit-function-declaration]
     710 |                 devl_health_reporter_create(devlink, fw_ops, 0, dev);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/mellanox/mlx5/core/health.c:709:29: error: assignment to 'struct devlink_health_reporter *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     709 |         health->fw_reporter =
         |                             ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:715:35: error: assignment to 'struct devlink_health_reporter *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     715 |         health->fw_fatal_reporter =
         |                                   ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_fw_reporters_destroy':
   drivers/net/ethernet/mellanox/mlx5/core/health.c:730:17: error: implicit declaration of function 'devlink_health_reporter_destroy' [-Wimplicit-function-declaration]
     730 |                 devlink_health_reporter_destroy(health->fw_reporter);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: In function 'mlx5_health_init':
   drivers/net/ethernet/mellanox/mlx5/core/health.c:884:35: error: initialization of 'struct devlink *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     884 |         struct devlink *devlink = priv_to_devlink(dev);
         |                                   ^~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c: At top level:
   drivers/net/ethernet/mellanox/mlx5/core/health.c:576:49: error: storage size of 'mlx5_fw_reporter_pf_ops' isn't known
     576 | static const struct devlink_health_reporter_ops mlx5_fw_reporter_pf_ops = {
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:582:49: error: storage size of 'mlx5_fw_reporter_ops' isn't known
     582 | static const struct devlink_health_reporter_ops mlx5_fw_reporter_ops = {
         |                                                 ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:672:49: error: storage size of 'mlx5_fw_fatal_reporter_pf_ops' isn't known
     672 | static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_pf_ops = {
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:678:49: error: storage size of 'mlx5_fw_fatal_reporter_ops' isn't known
     678 | static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_ops = {
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mempool_t +1125 drivers/infiniband/hw/mlx5/mlx5_ib.h

a560f1d9af4be84 Mark Bloch     2018-09-17  1117  
d5d284b829a6eb7 Saeed Mahameed 2018-11-19  1118  struct mlx5_ib_pf_eq {
ca390799c2aa036 Yuval Avnery   2019-06-10  1119  	struct notifier_block irq_nb;
d5d284b829a6eb7 Saeed Mahameed 2018-11-19  1120  	struct mlx5_ib_dev *dev;
d5d284b829a6eb7 Saeed Mahameed 2018-11-19  1121  	struct mlx5_eq *core;
d5d284b829a6eb7 Saeed Mahameed 2018-11-19  1122  	struct work_struct work;
d5d284b829a6eb7 Saeed Mahameed 2018-11-19  1123  	spinlock_t lock; /* Pagefaults spinlock */
d5d284b829a6eb7 Saeed Mahameed 2018-11-19  1124  	struct workqueue_struct *wq;
d5d284b829a6eb7 Saeed Mahameed 2018-11-19 @1125  	mempool_t *pool;
d5d284b829a6eb7 Saeed Mahameed 2018-11-19  1126  };
d5d284b829a6eb7 Saeed Mahameed 2018-11-19  1127  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

