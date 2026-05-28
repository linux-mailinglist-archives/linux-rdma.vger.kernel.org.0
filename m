Return-Path: <linux-rdma+bounces-21458-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FiULhCWGGoMlQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21458-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:22:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 018CE5F7039
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9D28302E40E
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 19:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBA933120C;
	Thu, 28 May 2026 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7piyDc8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC923F8EAF;
	Thu, 28 May 2026 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995822; cv=none; b=gR5oDCG/x4yBU27Y8SkJH6FY8bDkyobbTonk/k32Mscl0I8VyRKB838dtmgCFX5aA9lc03NKtZA2fjcUeAbY9uH6HNtf3/m+N1Ud0yJKXGih2P2npd6Ti/m97sP5DyPCUt4z6REcnN1JYk18KJIzNcEtxmhOrRdXHW1+7vV6mwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995822; c=relaxed/simple;
	bh=RBIQDllAdTkrpUimCKcZpFTnvXCRtGl8e7WGWHgFIP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knszAOhbSpsUY1l0utUG0+LsdIf1woWTXnxA+fvFcFeBpTvyfgx6pfA0lZ1zseHW8JTJSk3NX//YCCWCio5BCrQmmlgoncXxC3jD+kr1SsUUhx21yURFSZKkUyUEROklf138aOgZ7gmjLkHm1IMBg1/5oe2dyKzHhINQ93P+Vq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7piyDc8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779995821; x=1811531821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RBIQDllAdTkrpUimCKcZpFTnvXCRtGl8e7WGWHgFIP8=;
  b=Y7piyDc8AIiHv5lCObJzNSmho/78f+C2AnKfvksKMBZLbNAuBH7oPpma
   noRyUCsgh0zrrDrn9IQZYBETZg9l1eJVRNlXQ4Vx9LbOe39JVaKGJgmm3
   45cZpuWqIht6SPE6oQpQRtAjtKRILTncODMXWy50AO5ECish0FYgAA2Qk
   AL9a29PmtjiNTroWGE3yRDxo88ACDK6Kx/DkElQprhzq+LkV0f0xC/WCJ
   WLZkx2ZDDMw8g3ybPlggH/BMDtjYlnyTG1NUKpt5wjK7oAT+k8G5XHvvv
   g7NkiSOPN4Hq8JfCkFS73ZbFZc1FSe/Y742pGP4TTTyCgbyM5y1Aia6Sa
   Q==;
X-CSE-ConnectionGUID: Q3ZfTa4hRa6NUfgv/0hKBw==
X-CSE-MsgGUID: xk/Uo3TSQ4WHd/lafqonSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="84705736"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="84705736"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 12:17:01 -0700
X-CSE-ConnectionGUID: uHgSdsX9Qke+VPnnLKpdxg==
X-CSE-MsgGUID: qI68ScWCSL+3XYVn5Dy3/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="238443679"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 May 2026 12:16:59 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSgDw-000000006Ly-447t;
	Thu, 28 May 2026 19:16:56 +0000
Date: Fri, 29 May 2026 03:16:24 +0800
From: kernel test robot <lkp@intel.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v4] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <202605290321.lRxnXfw4-lkp@intel.com>
References: <20260526194225.1338210-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526194225.1338210-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21458-lists,linux-rdma=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 018CE5F7039
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Erni,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v7.1-rc5 next-20260528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Erni-Sri-Satya-Vennela/RDMA-Change-capability-fields-in-ib_device_attr-from-int-to-u32/20260527-040218
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20260526194225.1338210-1-ernis%40linux.microsoft.com
patch subject: [PATCH rdma-next v4] RDMA: Change capability fields in ib_device_attr from int to u32
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260529/202605290321.lRxnXfw4-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605290321.lRxnXfw4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605290321.lRxnXfw4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/infiniband/hw/qedr/verbs.c: In function 'qedr_query_device':
>> include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_818' declared with attribute error: min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1), attr->max_qp_init_rd_atom) signedness error
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
     680 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
      98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
     105 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/infiniband/hw/qedr/verbs.c:146:13: note: in expansion of macro 'min'
     146 |             min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
         |             ^~~
--
   In file included from <command-line>:
   verbs.c: In function 'qedr_query_device':
>> include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_818' declared with attribute error: min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1), attr->max_qp_init_rd_atom) signedness error
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
     680 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
      98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
     105 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   verbs.c:146:13: note: in expansion of macro 'min'
     146 |             min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
         |             ^~~


vim +/__compiletime_assert_818 +699 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  685  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  686  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  687  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  688  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  689  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  690   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  691   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  692   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  693   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  694   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  695   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  696   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  697   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  698  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @699  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  700  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

