Return-Path: <linux-rdma+bounces-11725-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A07AEC29E
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Jun 2025 00:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75C91C46378
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 22:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3409F27BF79;
	Fri, 27 Jun 2025 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTQoQVUR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0828C5D2;
	Fri, 27 Jun 2025 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751063518; cv=none; b=SJo02UoL+mLq65pXxlx+IHHhReOrzsPBuVAs4xMeGtp8CoGGG4/rR8fJmUnXRr9DevxjFId2pTcOzaDPIRkQMkztmHfkxeKC1bQxS5FNypcwlODApzOHFuCFlqdszIPi9cjCg4A4pYt8+7rBtT4IQATNrH3edY5o98EPM8pozmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751063518; c=relaxed/simple;
	bh=t148kyXLdbbYR5pY/4YRGD/alwYNyE9YPF79U/ZCXyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opWUqHus4oirG2v9A6ZmaAVbOF0/UWNrlxstGd0M0BauLMQyDIr18IjSf52bQZLZIu4evhpCCQvsRkY0UZDxgjyOF0UMbTzabT5lO1sKNmOUvqtnC3U57jzcG55ohDBjbodNOXiGnH09aIfcbY/ncHPQ7LFyINBUg2dIe8iadZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTQoQVUR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751063516; x=1782599516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t148kyXLdbbYR5pY/4YRGD/alwYNyE9YPF79U/ZCXyg=;
  b=XTQoQVURaRr9LGlR3HDYV9kpOoObGJucE6xd6kijG6nDJ1g363jo9mXr
   sYC1tpvnhZmOeN7a+2YKd+xqwcxEjLJ0AjGJAXuB591pHERZmL71ZL6iq
   +Kro0hSSV0nLAklL2mhzFrak8n8H3JPhHZPFgM7MMrSMgCoBjeoSkllr8
   MKOr1cSpohwHMpR1mp2XxUFwNXyYYFgyCTe9plWsQDXkY1HaEOu/vLUbW
   YdVKI5l4aXS9LM2EGAtLaslRjYoxWjy+F9ecc6ab2Rp4j87MAh3hZTRvu
   btphov6mVPYKbjlTYcahl76hSOWiUkkYa2uJnCiRgSckEDWFwp2iiliEi
   A==;
X-CSE-ConnectionGUID: /S4uu9HVQ8GbzCcfFS2USw==
X-CSE-MsgGUID: D3A5fVtQQMaqruFdpxiZVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53469204"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="53469204"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 15:31:55 -0700
X-CSE-ConnectionGUID: yfca7EjtR3WZ8gs4milOHQ==
X-CSE-MsgGUID: Pb1xzmifTV+W/Ou1tjgGFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="157460774"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Jun 2025 15:31:52 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVHbp-000Wag-1o;
	Fri, 27 Jun 2025 22:31:49 +0000
Date: Sat, 28 Jun 2025 06:31:37 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next v1 1/1] net/mlx5: Don't use "proxy" headers
Message-ID: <202506280652.RR3QbdqN-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/net-mlx5-Don-t-use-proxy-headers/20250627-004605
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250626164509.327410-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH net-next v1 1/1] net/mlx5: Don't use "proxy" headers
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250628/202506280652.RR3QbdqN-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506280652.RR3QbdqN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506280652.RR3QbdqN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/mellanox/mlx5/core/health.c:41:
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:9: error: call to undeclared function 'devlink_net'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                ^
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:21: error: call to undeclared function 'priv_to_devlink'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                            ^
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:9: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct net *' [-Wint-conversion]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlx5/core/health.c:45:
>> drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h:202:17: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
     202 |                                             struct devlink_fmsg *fmsg);
         |                                                    ^
   In file included from drivers/net/ethernet/mellanox/mlx5/core/health.c:46:
>> drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.h:13:15: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      13 |                                           struct devlink_fmsg *fmsg,
         |                                                  ^
>> drivers/net/ethernet/mellanox/mlx5/core/health.c:465:13: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
     465 |                           struct devlink_fmsg *fmsg,
         |                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:468:30: error: call to undeclared function 'devlink_health_reporter_priv'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     468 |         struct mlx5_core_dev *dev = devlink_health_reporter_priv(reporter);
         |                                     ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:468:24: error: incompatible integer to pointer conversion initializing 'struct mlx5_core_dev *' with an expression of type 'int' [-Wint-conversion]
     468 |         struct mlx5_core_dev *dev = devlink_health_reporter_priv(reporter);
         |                               ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/health.c:473:2: error: call to undeclared function 'devlink_fmsg_u8_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     473 |         devlink_fmsg_u8_pair_put(fmsg, "Syndrome", synd);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:477:2: error: call to undeclared function 'devlink_fmsg_string_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     477 |         devlink_fmsg_string_pair_put(fmsg, "Description", hsynd_str(synd));
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:488:39: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
     488 | mlx5_fw_reporter_ctx_pairs_put(struct devlink_fmsg *fmsg,
         |                                       ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:491:2: error: call to undeclared function 'devlink_fmsg_u8_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     491 |         devlink_fmsg_u8_pair_put(fmsg, "syndrome", fw_reporter_ctx->err_synd);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:492:2: error: call to undeclared function 'devlink_fmsg_u32_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     492 |         devlink_fmsg_u32_pair_put(fmsg, "fw_miss_counter", fw_reporter_ctx->miss_counter);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:497:19: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
     497 |                                        struct devlink_fmsg *fmsg)
         |                                               ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:507:2: error: call to undeclared function 'devlink_fmsg_pair_nest_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     507 |         devlink_fmsg_pair_nest_start(fmsg, "health buffer");
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:508:2: error: call to undeclared function 'devlink_fmsg_obj_nest_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     508 |         devlink_fmsg_obj_nest_start(fmsg);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:509:2: error: call to undeclared function 'devlink_fmsg_arr_pair_nest_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     509 |         devlink_fmsg_arr_pair_nest_start(fmsg, "assert_var");
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:511:3: error: call to undeclared function 'devlink_fmsg_u32_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     511 |                 devlink_fmsg_u32_put(fmsg, ioread32be(h->assert_var + i));
         |                 ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:512:2: error: call to undeclared function 'devlink_fmsg_arr_pair_nest_end'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     512 |         devlink_fmsg_arr_pair_nest_end(fmsg);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:513:2: error: call to undeclared function 'devlink_fmsg_u32_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     513 |         devlink_fmsg_u32_pair_put(fmsg, "assert_exit_ptr",
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:520:2: error: call to undeclared function 'devlink_fmsg_u8_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     520 |         devlink_fmsg_u8_pair_put(fmsg, "rfr", mlx5_health_get_rfr(rfr_severity));
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:526:2: error: call to undeclared function 'devlink_fmsg_obj_nest_end'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     526 |         devlink_fmsg_obj_nest_end(fmsg);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:527:2: error: call to undeclared function 'devlink_fmsg_pair_nest_end'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     527 |         devlink_fmsg_pair_nest_end(fmsg);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:532:16: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
     532 |                       struct devlink_fmsg *fmsg, void *priv_ctx,
         |                              ^
   drivers/net/ethernet/mellanox/mlx5/core/health.c:535:30: error: call to undeclared function 'devlink_health_reporter_priv'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     535 |         struct mlx5_core_dev *dev = devlink_health_reporter_priv(reporter);
         |                                     ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   6 warnings and 20 errors generated.
--
   In file included from drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:34:
>> drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h:202:17: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
     202 |                                             struct devlink_fmsg *fmsg);
         |                                                    ^
>> drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:893:37: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
     893 | mlx5_devlink_fmsg_fill_trace(struct devlink_fmsg *fmsg,
         |                                     ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:896:2: error: call to undeclared function 'devlink_fmsg_obj_nest_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     896 |         devlink_fmsg_obj_nest_start(fmsg);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:897:2: error: call to undeclared function 'devlink_fmsg_u64_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     897 |         devlink_fmsg_u64_pair_put(fmsg, "timestamp", trace_data->timestamp);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:898:2: error: call to undeclared function 'devlink_fmsg_bool_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     898 |         devlink_fmsg_bool_pair_put(fmsg, "lost", trace_data->lost);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:899:2: error: call to undeclared function 'devlink_fmsg_u8_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     899 |         devlink_fmsg_u8_pair_put(fmsg, "event_id", trace_data->event_id);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:900:2: error: call to undeclared function 'devlink_fmsg_string_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     900 |         devlink_fmsg_string_pair_put(fmsg, "msg", trace_data->msg);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:901:2: error: call to undeclared function 'devlink_fmsg_obj_nest_end'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     901 |         devlink_fmsg_obj_nest_end(fmsg);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:905:17: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
     905 |                                             struct devlink_fmsg *fmsg)
         |                                                    ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:904:5: error: conflicting types for 'mlx5_fw_tracer_get_saved_traces_objects'
     904 | int mlx5_fw_tracer_get_saved_traces_objects(struct mlx5_fw_tracer *tracer,
         |     ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h:201:5: note: previous declaration is here
     201 | int mlx5_fw_tracer_get_saved_traces_objects(struct mlx5_fw_tracer *tracer,
         |     ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:922:2: error: call to undeclared function 'devlink_fmsg_arr_pair_nest_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     922 |         devlink_fmsg_arr_pair_nest_start(fmsg, "dump fw traces");
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:925:32: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     925 |                 mlx5_devlink_fmsg_fill_trace(fmsg, &straces[index]);
         |                                              ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:893:51: note: passing argument to parameter 'fmsg' here
     893 | mlx5_devlink_fmsg_fill_trace(struct devlink_fmsg *fmsg,
         |                                                   ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c:930:2: error: call to undeclared function 'devlink_fmsg_arr_pair_nest_end'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     930 |         devlink_fmsg_arr_pair_nest_end(fmsg);
         |         ^
   3 warnings and 10 errors generated.
--
   In file included from drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c:4:
>> drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.h:13:15: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      13 |                                           struct devlink_fmsg *fmsg,
         |                                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c:60:6: error: conflicting types for 'mlx5_reporter_vnic_diagnose_counters'
      60 | void mlx5_reporter_vnic_diagnose_counters(struct mlx5_core_dev *dev,
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.h:12:6: note: previous declaration is here
      12 | void mlx5_reporter_vnic_diagnose_counters(struct mlx5_core_dev *dev,
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c:119:44: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     119 |         mlx5_reporter_vnic_diagnose_counters(dev, fmsg, 0, false);
         |                                                   ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.h:13:29: note: passing argument to parameter 'fmsg' here
      13 |                                           struct devlink_fmsg *fmsg,
         |                                                                ^
   1 warning and 2 errors generated.
--
   In file included from drivers/net/ethernet/mellanox/mlx5/core/en/health.c:4:
   In file included from drivers/net/ethernet/mellanox/mlx5/core/en/health.h:7:
   drivers/net/ethernet/mellanox/mlx5/core/en.h:955:22: error: field has incomplete type 'struct devlink_port'
     955 |         struct devlink_port dl_port;
         |                             ^
   include/linux/netdevice.h:2468:9: note: forward declaration of 'struct devlink_port'
    2468 |         struct devlink_port     *devlink_port;
         |                ^
   In file included from drivers/net/ethernet/mellanox/mlx5/core/en/health.c:4:
>> drivers/net/ethernet/mellanox/mlx5/core/en/health.h:23:60: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      23 | void mlx5e_health_cq_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
         |                                                            ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:24:67: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      24 | void mlx5e_health_cq_common_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
         |                                                                   ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:25:64: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      25 | void mlx5e_health_eq_diag_fmsg(struct mlx5_eq_comp *eq, struct devlink_fmsg *fmsg);
         |                                                                ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:26:52: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      26 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name);
         |                                                    ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:27:50: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      27 | void mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg);
         |                                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:41:46: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      41 |         int (*dump)(struct mlx5e_priv *priv, struct devlink_fmsg *fmsg, void *ctx);
         |                                                     ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:56:18: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      56 |                                struct devlink_fmsg *fmsg);
         |                                       ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:57:62: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      57 | void mlx5e_health_queue_dump(struct mlx5e_priv *priv, struct devlink_fmsg *fmsg,
         |                                                              ^
   In file included from drivers/net/ethernet/mellanox/mlx5/core/en/health.c:6:
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:9: error: call to undeclared function 'devlink_net'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                ^
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:21: error: call to undeclared function 'priv_to_devlink'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                            ^
   drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:50:9: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct net *' [-Wint-conversion]
      50 |         return devlink_net(priv_to_devlink(dev));
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/mellanox/mlx5/core/en/health.c:8:52: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
       8 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name)
         |                                                    ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:8:6: error: conflicting types for 'mlx5e_health_fmsg_named_obj_nest_start'
       8 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name)
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:26:6: note: previous declaration is here
      26 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name);
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:10:2: error: call to undeclared function 'devlink_fmsg_pair_nest_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      10 |         devlink_fmsg_pair_nest_start(fmsg, name);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:11:2: error: call to undeclared function 'devlink_fmsg_obj_nest_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      11 |         devlink_fmsg_obj_nest_start(fmsg);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:14:50: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      14 | void mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg)
         |                                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:14:6: error: conflicting types for 'mlx5e_health_fmsg_named_obj_nest_end'
      14 | void mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg)
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:27:6: note: previous declaration is here
      27 | void mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg);
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:16:2: error: call to undeclared function 'devlink_fmsg_obj_nest_end'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      16 |         devlink_fmsg_obj_nest_end(fmsg);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:17:2: error: call to undeclared function 'devlink_fmsg_pair_nest_end'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      17 |         devlink_fmsg_pair_nest_end(fmsg);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:20:60: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      20 | void mlx5e_health_cq_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg)
         |                                                            ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:20:6: error: conflicting types for 'mlx5e_health_cq_diag_fmsg'
      20 | void mlx5e_health_cq_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg)
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:23:6: note: previous declaration is here
      23 | void mlx5e_health_cq_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:30:41: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
      30 |         mlx5e_health_fmsg_named_obj_nest_start(fmsg, "CQ");
         |                                                ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:26:66: note: passing argument to parameter 'fmsg' here
      26 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name);
         |                                                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:31:2: error: call to undeclared function 'devlink_fmsg_u32_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      31 |         devlink_fmsg_u32_pair_put(fmsg, "cqn", cq->mcq.cqn);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:32:2: error: call to undeclared function 'devlink_fmsg_u8_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      32 |         devlink_fmsg_u8_pair_put(fmsg, "HW status", hw_status);
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:35:39: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
      35 |         mlx5e_health_fmsg_named_obj_nest_end(fmsg);
         |                                              ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:27:64: note: passing argument to parameter 'fmsg' here
      27 | void mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg);
         |                                                                ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:38:67: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      38 | void mlx5e_health_cq_common_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg)
         |                                                                   ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:38:6: error: conflicting types for 'mlx5e_health_cq_common_diag_fmsg'
      38 | void mlx5e_health_cq_common_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg)
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:24:6: note: previous declaration is here
      24 | void mlx5e_health_cq_common_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:46:41: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
      46 |         mlx5e_health_fmsg_named_obj_nest_start(fmsg, "CQ");
         |                                                ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:26:66: note: passing argument to parameter 'fmsg' here
      26 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name);
         |                                                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:47:2: error: call to undeclared function 'devlink_fmsg_u64_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      47 |         devlink_fmsg_u64_pair_put(fmsg, "stride size", BIT(cq_log_stride));
         |         ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.c:48:2: error: call to undeclared function 'devlink_fmsg_u32_pair_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      48 |         devlink_fmsg_u32_pair_put(fmsg, "size", cq_sz);
         |         ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   12 warnings and 20 errors generated.
--
   In file included from drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:4:
   In file included from drivers/net/ethernet/mellanox/mlx5/core/en/health.h:7:
   drivers/net/ethernet/mellanox/mlx5/core/en.h:955:22: error: field has incomplete type 'struct devlink_port'
     955 |         struct devlink_port dl_port;
         |                             ^
   include/linux/netdevice.h:2468:9: note: forward declaration of 'struct devlink_port'
    2468 |         struct devlink_port     *devlink_port;
         |                ^
   In file included from drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:4:
>> drivers/net/ethernet/mellanox/mlx5/core/en/health.h:23:60: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      23 | void mlx5e_health_cq_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
         |                                                            ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:24:67: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      24 | void mlx5e_health_cq_common_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
         |                                                                   ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:25:64: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      25 | void mlx5e_health_eq_diag_fmsg(struct mlx5_eq_comp *eq, struct devlink_fmsg *fmsg);
         |                                                                ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:26:52: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      26 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name);
         |                                                    ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:27:50: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      27 | void mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg);
         |                                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:41:46: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      41 |         int (*dump)(struct mlx5e_priv *priv, struct devlink_fmsg *fmsg, void *ctx);
         |                                                     ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:56:18: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      56 |                                struct devlink_fmsg *fmsg);
         |                                       ^
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:57:62: warning: declaration of 'struct devlink_fmsg' will not be visible outside of this function [-Wvisibility]
      57 | void mlx5e_health_queue_dump(struct mlx5e_priv *priv, struct devlink_fmsg *fmsg,
         |                                                              ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:58:41: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
      58 |         mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SW State");
         |                                                ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:26:66: note: passing argument to parameter 'fmsg' here
      26 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name);
         |                                                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:64:39: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
      64 |         mlx5e_health_fmsg_named_obj_nest_end(fmsg);
         |                                              ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:27:64: note: passing argument to parameter 'fmsg' here
      27 | void mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg);
         |                                                                ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:239:37: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     239 |         mlx5e_health_cq_diag_fmsg(&sq->cq, fmsg);
         |                                            ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:23:74: note: passing argument to parameter 'fmsg' here
      23 | void mlx5e_health_cq_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
         |                                                                          ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:240:43: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     240 |         mlx5e_health_eq_diag_fmsg(sq->cq.mcq.eq, fmsg);
         |                                                  ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:25:78: note: passing argument to parameter 'fmsg' here
      25 | void mlx5e_health_eq_diag_fmsg(struct mlx5_eq_comp *eq, struct devlink_fmsg *fmsg);
         |                                                                              ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:260:41: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     260 |         mlx5e_health_fmsg_named_obj_nest_start(fmsg, "Port TS");
         |                                                ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:26:66: note: passing argument to parameter 'fmsg' here
      26 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name);
         |                                                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:261:43: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     261 |         mlx5e_health_cq_diag_fmsg(&ptpsq->ts_cq, fmsg);
         |                                                  ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:23:74: note: passing argument to parameter 'fmsg' here
      23 | void mlx5e_health_cq_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
         |                                                                          ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:262:39: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     262 |         mlx5e_health_fmsg_named_obj_nest_end(fmsg);
         |                                              ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:27:64: note: passing argument to parameter 'fmsg' here
      27 | void mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg);
         |                                                                ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:274:41: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     274 |         mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SQ");
         |                                                ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:26:66: note: passing argument to parameter 'fmsg' here
      26 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name);
         |                                                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:278:47: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     278 |         mlx5e_health_cq_common_diag_fmsg(&txqsq->cq, fmsg);
         |                                                      ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:24:81: note: passing argument to parameter 'fmsg' here
      24 | void mlx5e_health_cq_common_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
         |                                                                                 ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:279:39: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     279 |         mlx5e_health_fmsg_named_obj_nest_end(fmsg);
         |                                              ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:27:64: note: passing argument to parameter 'fmsg' here
      27 | void mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg);
         |                                                                ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:286:41: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     286 |         mlx5e_health_fmsg_named_obj_nest_start(fmsg, "Port TS");
         |                                                ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:26:66: note: passing argument to parameter 'fmsg' here
      26 | void mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name);
         |                                                                  ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:287:50: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     287 |         mlx5e_health_cq_common_diag_fmsg(&ptpsq->ts_cq, fmsg);
         |                                                         ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:24:81: note: passing argument to parameter 'fmsg' here
      24 | void mlx5e_health_cq_common_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
         |                                                                                 ^
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:288:39: error: incompatible pointer types passing 'struct devlink_fmsg *' to parameter of type 'struct devlink_fmsg *' [-Werror,-Wincompatible-pointer-types]
     288 |         mlx5e_health_fmsg_named_obj_nest_end(fmsg);
         |                                              ^~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/health.h:27:64: note: passing argument to parameter 'fmsg' here
      27 | void mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg);
..


vim +202 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h

c71ad41ccb0c29 Feras Daoud   2018-02-07  195  
f53aaa31cce7b5 Feras Daoud   2018-07-16  196  struct mlx5_fw_tracer *mlx5_fw_tracer_create(struct mlx5_core_dev *dev);
c71ad41ccb0c29 Feras Daoud   2018-02-07  197  int mlx5_fw_tracer_init(struct mlx5_fw_tracer *tracer);
c71ad41ccb0c29 Feras Daoud   2018-02-07  198  void mlx5_fw_tracer_cleanup(struct mlx5_fw_tracer *tracer);
f53aaa31cce7b5 Feras Daoud   2018-07-16  199  void mlx5_fw_tracer_destroy(struct mlx5_fw_tracer *tracer);
fd1483fe1f9fd4 Moshe Shemesh 2018-12-11  200  int mlx5_fw_tracer_trigger_core_dump_general(struct mlx5_core_dev *dev);
fd1483fe1f9fd4 Moshe Shemesh 2018-12-11  201  int mlx5_fw_tracer_get_saved_traces_objects(struct mlx5_fw_tracer *tracer,
fd1483fe1f9fd4 Moshe Shemesh 2018-12-11 @202  					    struct devlink_fmsg *fmsg);
2d69356752ff86 Moshe Shemesh 2020-10-07  203  int mlx5_fw_tracer_reload(struct mlx5_fw_tracer *tracer);
f53aaa31cce7b5 Feras Daoud   2018-07-16  204  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

