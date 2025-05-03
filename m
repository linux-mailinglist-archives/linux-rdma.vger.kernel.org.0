Return-Path: <linux-rdma+bounces-9953-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A38AA7E00
	for <lists+linux-rdma@lfdr.de>; Sat,  3 May 2025 04:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDBA466BBF
	for <lists+linux-rdma@lfdr.de>; Sat,  3 May 2025 02:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E11136349;
	Sat,  3 May 2025 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mG5D0msi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C0EAC7;
	Sat,  3 May 2025 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746238254; cv=none; b=S6j3Q/7emyOg2fnBKMUfxhmGVR0rpV7rN24qRLJzBIFdofhdt3BQCz9kdoWkSXPHQ/opv5/8YkzqnKu8X28GFqNcyZKTSh7hxI264V+cU4e7K1CdG7055g3sVlTcdYOGjmocVed7OV8V5ZyQFLf4C3z7T49RCEdDLMuZ6R7rdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746238254; c=relaxed/simple;
	bh=rb8M6icJ1O0t+JJpDjVxWKwSngtPcPtHu/v2cgq4WV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9dqvEilEGx6/Ec4ZCwtIIyUdn1GkItJw8kDisu8bV9SUdirbYafGhKDFOQ9y1R2lA3N6e7qksRWhmdzRzYbv8uEUmGfJDj8TyvNNwcWsYxgbr2Z9wIk0J2ZxhYk8xNJbX9Qk9QUUbX4Q2cCmsLzU43ctbvC4b+fTydNB1gzF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mG5D0msi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746238252; x=1777774252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rb8M6icJ1O0t+JJpDjVxWKwSngtPcPtHu/v2cgq4WV4=;
  b=mG5D0msicbmxoA1mdqlD22+cA1IcC6HQ57uf/OAZfX3dKlNs0vkys52T
   qmqYzPDMygd0/iupJUVh02qn4W/HyWclo7c+ACUomDx+yNMt0roNy+rHy
   SQxdG/0QBGj2oJPzdBHPg7YAnPaonGSSjDzds/IlaJUijaB052wKPGBpE
   3GJZuwzJcNodRqxkaHXGOuE4cvGMhd5l8ow9YLfsGFo3ahnpS/0qNn0Kb
   0GM1D356+vsXyx1ZysdzeyuUFe6+bCAYGqfLb/JbzGCOHbSBkQ+VtsKRK
   00z2ZkwjMaRrlEkBA4hC9pAEw/1moEPr2gYozydhL2G9UVKkUB/2kHN3M
   Q==;
X-CSE-ConnectionGUID: L2l1KzsUSUubAp4qGqfyRg==
X-CSE-MsgGUID: YYQL3PDmSnOCkrtkzbpGsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="73317257"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="73317257"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 19:10:52 -0700
X-CSE-ConnectionGUID: Aca4/farR+6vpc13FIFjtQ==
X-CSE-MsgGUID: UCTrg10+Ss+W/OaadgRI5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="139581500"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 02 May 2025 19:10:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uB2L1-0005A3-24;
	Sat, 03 May 2025 02:10:47 +0000
Date: Sat, 3 May 2025 10:09:50 +0800
From: kernel test robot <lkp@intel.com>
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Daisuke Matsuda <dskmtsd@gmail.com>
Subject: Re: [PATCH for-next v1 1/2] RDMA/rxe: Implement synchronous prefetch
 for ODP MRs
Message-ID: <202505030925.esKbABQW-lkp@intel.com>
References: <20250502032216.2312-2-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502032216.2312-2-dskmtsd@gmail.com>

Hi Daisuke,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on next-20250502]
[cannot apply to linus/master v6.15-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daisuke-Matsuda/RDMA-rxe-Implement-synchronous-prefetch-for-ODP-MRs/20250502-112436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20250502032216.2312-2-dskmtsd%40gmail.com
patch subject: [PATCH for-next v1 1/2] RDMA/rxe: Implement synchronous prefetch for ODP MRs
config: x86_64-buildonly-randconfig-005-20250503 (https://download.01.org/0day-ci/archive/20250503/202505030925.esKbABQW-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250503/202505030925.esKbABQW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505030925.esKbABQW-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/infiniband/sw/rxe/rxe_srq.c:8:
   In file included from drivers/infiniband/sw/rxe/rxe.h:30:
>> drivers/infiniband/sw/rxe/rxe_loc.h:231:5: warning: no previous prototype for function 'rxe_ib_advise_mr' [-Wmissing-prototypes]
     231 | int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
         |     ^
   drivers/infiniband/sw/rxe/rxe_loc.h:231:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     231 | int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
         | ^
         | static 
   1 warning generated.
--
>> ld.lld: error: duplicate symbol: rxe_ib_advise_mr
   >>> defined in drivers/infiniband/sw/rxe/rxe.o
   >>> defined in drivers/infiniband/sw/rxe/rxe_hw_counters.o
--
>> ld.lld: error: duplicate symbol: rxe_ib_advise_mr
   >>> defined in drivers/infiniband/sw/rxe/rxe.o
   >>> defined in drivers/infiniband/sw/rxe/rxe_net.o
--
>> ld.lld: error: duplicate symbol: rxe_ib_advise_mr
   >>> defined in drivers/infiniband/sw/rxe/rxe.o
   >>> defined in drivers/infiniband/sw/rxe/rxe_verbs.o
--
>> ld.lld: error: duplicate symbol: rxe_ib_advise_mr
   >>> defined in drivers/infiniband/sw/rxe/rxe.o
   >>> defined in drivers/infiniband/sw/rxe/rxe_queue.o
--
>> ld.lld: error: duplicate symbol: rxe_ib_advise_mr
   >>> defined in drivers/infiniband/sw/rxe/rxe.o
   >>> defined in drivers/infiniband/sw/rxe/rxe_srq.o
--
>> ld.lld: error: duplicate symbol: rxe_ib_advise_mr
   >>> defined in drivers/infiniband/sw/rxe/rxe.o
   >>> defined in drivers/infiniband/sw/rxe/rxe_pool.o
--
>> ld.lld: error: duplicate symbol: rxe_ib_advise_mr
   >>> defined in drivers/infiniband/sw/rxe/rxe.o
   >>> defined in drivers/infiniband/sw/rxe/rxe_resp.o
--
>> ld.lld: error: duplicate symbol: rxe_ib_advise_mr
   >>> defined in drivers/infiniband/sw/rxe/rxe.o
   >>> defined in drivers/infiniband/sw/rxe/rxe_qp.o
--
>> ld.lld: error: duplicate symbol: rxe_ib_advise_mr
   >>> defined in drivers/infiniband/sw/rxe/rxe.o
   >>> defined in drivers/infiniband/sw/rxe/rxe_recv.o
--
>> ld.lld: error: duplicate symbol: rxe_ib_advise_mr
   >>> defined in drivers/infiniband/sw/rxe/rxe.o
   >>> defined in drivers/infiniband/sw/rxe/rxe_req.o
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

