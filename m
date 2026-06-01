Return-Path: <linux-rdma+bounces-21566-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IER+DpFNHWrDYgkAu9opvQ
	(envelope-from <linux-rdma+bounces-21566-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 11:14:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A8C61C334
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 11:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A42302926B
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 09:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA28384235;
	Mon,  1 Jun 2026 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mgxtMgsp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E3625B0A8;
	Mon,  1 Jun 2026 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304915; cv=none; b=syJ57jcYCfwf1cmI4YiJ7w62JE1K1nGMjgGLAQReCs1uKJoRyc5xnUdbjieS2GkzfSmY82/DJWLLBQh8DkGtzYuXqQ/2Duo0fvVSdSs0dRwLTJBpDtx3LvCib4da2K07Uzph6ijHsygRUheUXL5aYnFYB5LzczYoXx/iFpYaVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304915; c=relaxed/simple;
	bh=YOjcHbPPuiEVS8/2pIRKPAsAMDUAyVw4ivs0jCjI3QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq6vSCynxwuuuNPP5td/717Xp/WH4+XhSkwhtqW7U+aArmW9OH0tnB5Cz12qMtuwz9+X0+gM3/E1A4z0GUdlnuTdaTTYVmVQ33e4oERdEq4eTMXf0OmR9e4iOjaOOtxNcmW31j8D4XF7ZeeKlWEhu6O+BsYZ2JPWDkXzCHejTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mgxtMgsp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 925DC20B7166; Mon,  1 Jun 2026 02:08:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 925DC20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780304894;
	bh=LyOQ9pXJyYGsO3JKnIuvfT5lYsTE9+zgjF/TM0Z0pJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgxtMgspeBHhGFgcKN+Gav4VaYtxHORMs78zzec29Fa9M+bDdIDR9vjxg6EhsZpw3
	 j7kG0J9aHGbAhnjg7D0HSww2NERXQKIj4HAzsNxUlWlFb0mBB3cAgeoQma0OI1Zjcg
	 ZKstdnPfcgzizajn/9voAW/nBdW/hPnc1WdahyAg=
Date: Mon, 1 Jun 2026 02:08:14 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kernel test robot <lkp@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH rdma-next v4] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <ah1L/geUw1KijSCA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260526194225.1338210-1-ernis@linux.microsoft.com>
 <202605290321.lRxnXfw4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605290321.lRxnXfw4-lkp@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21566-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,linux.microsoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 77A8C61C334
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 03:16:24AM +0800, kernel test robot wrote:
> Hi Erni,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on rdma/for-next]
> [also build test ERROR on linus/master v7.1-rc5 next-20260528]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Erni-Sri-Satya-Vennela/RDMA-Change-capability-fields-in-ib_device_attr-from-int-to-u32/20260527-040218
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> patch link:    https://lore.kernel.org/r/20260526194225.1338210-1-ernis%40linux.microsoft.com
> patch subject: [PATCH rdma-next v4] RDMA: Change capability fields in ib_device_attr from int to u32
> config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260529/202605290321.lRxnXfw4-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605290321.lRxnXfw4-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605290321.lRxnXfw4-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:
>    drivers/infiniband/hw/qedr/verbs.c: In function 'qedr_query_device':
> >> include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_818' declared with attribute error: min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1), attr->max_qp_init_rd_atom) signedness error
>      699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
>      680 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
>      699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
>       40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
>          |         ^~~~~~~~~~~~~~~~
>    include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
>       98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
>          |         ^~~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
>      105 | #define min(x, y)       __careful_cmp(min, x, y)
>          |                         ^~~~~~~~~~~~~
>    drivers/infiniband/hw/qedr/verbs.c:146:13: note: in expansion of macro 'min'
>      146 |             min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
>          |             ^~~
> --
>    In file included from <command-line>:
>    verbs.c: In function 'qedr_query_device':
> >> include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_818' declared with attribute error: min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1), attr->max_qp_init_rd_atom) signedness error
>      699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
>      680 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
>      699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
>       40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
>          |         ^~~~~~~~~~~~~~~~
>    include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
>       98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
>          |         ^~~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
>      105 | #define min(x, y)       __careful_cmp(min, x, y)
>          |                         ^~~~~~~~~~~~~
>    verbs.c:146:13: note: in expansion of macro 'min'
>      146 |             min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
>          |             ^~~
> 
> 
> vim +/__compiletime_assert_818 +699 include/linux/compiler_types.h
> 
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  685  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  686  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  687  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  688  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  689  /**
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  690   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  691   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  692   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  693   *
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  694   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  695   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  696   * compiler has support to do so.
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  697   */
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  698  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @699  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  700  
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
I will fix this in the next version.

Thanks,
Vennela

