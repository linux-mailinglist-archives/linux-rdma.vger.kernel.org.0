Return-Path: <linux-rdma+bounces-17691-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F6PHL4SrWn5xwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17691-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:10:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CAF22EA85
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E05203028EDC
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 06:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117DE30E838;
	Sun,  8 Mar 2026 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rt+Sd45G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5633993;
	Sun,  8 Mar 2026 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772950200; cv=none; b=R+1Nlx7HxCeCzTVM5vdAIVDos/Tg3G8TBA75yMgBYGV6/yx4oGjn4hgqJEJ1G7lYRb6vkMp3N+HLz7ZyIMw07O/jTUafAay5Idpk6tISo/dmetOAd3fFMpyQJEwbLyeKUowf7yoTZXIwzBH6zpM/ZrqPAQsgQ2JAdMyqT/d8CHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772950200; c=relaxed/simple;
	bh=wwX+tdXmbBhV+MANPmVIQGzD60GjFbE/UZjK3DaljdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8scnLn+z/aT6ZaM6sQFj/PXFXoK/m4+cWgMueL652Dk4lVVDtWzMY8oSuWBk46Kz2Go0PqXKGZyHFq3bFSZtyzsAypums+bOgcI8QAPMRhC7xjy6Sw2jIEP5lW4jlBE2HwmMX/1xdGNQB1alCe157/IEtl+d20BFa8/z9K+XSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rt+Sd45G; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772950197; x=1804486197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wwX+tdXmbBhV+MANPmVIQGzD60GjFbE/UZjK3DaljdI=;
  b=Rt+Sd45GnsCAKX9fGVS1xa7++j61qx6CVCgzomXmgn7fg+rFXKL3PYgC
   iZ5Pq2Mn7Wq3cQDZCACFiQ7JuuylRh/TVnJofv5fglxtt0ZoEc1nQOnWm
   2HjRWaM+Va95d2hDbwbJ7OzM3QGj1VYR19dzVnweGgnoBCBUUb/07BnwY
   +OhFiOOGJiRmHzd3icpX0Qn4X/NMMkKR7PcZHf76xwBJyvPbAgffYqS2a
   ZEktDjkhiN6tEzI2adod/yGiw5NRxQuIKejvC1qrqnjhhjmWTmCjSd6Ba
   WzHKlq/2BOUE53zE5BMNKD9BgANV4WUEG6yC91z3CYEX6FW+GFsqDeKG5
   g==;
X-CSE-ConnectionGUID: B6MHC2tBRhiKiClTWC/bFQ==
X-CSE-MsgGUID: D9nUsRE6Q4yR/kFoSP7/SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="74117495"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="74117495"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 22:09:56 -0800
X-CSE-ConnectionGUID: 4OSQFm1QSeSmYnmHQWMRIw==
X-CSE-MsgGUID: EJ0xPvzdS7eq1gYGeoTV5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="217540014"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Mar 2026 22:09:54 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz7Kp-000000002wr-2AOu;
	Sun, 08 Mar 2026 06:09:51 +0000
Date: Sun, 8 Mar 2026 14:09:23 +0800
From: kernel test robot <lkp@intel.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
	zyjzyj2000@gmail.com, dsahern@kernel.org,
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/4] RDMA/rxe: Support RDMA link creation and destruction
 per net namespace
Message-ID: <202603081310.Lo0y72dG-lkp@intel.com>
References: <20260307075611.3410-4-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307075611.3410-4-yanjun.zhu@linux.dev>
X-Rspamd-Queue-Id: C6CAF22EA85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17691-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Zhu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v7.0-rc2 next-20260306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhu-Yanjun/RDMA-nldev-Add-dellink-function-pointer/20260307-155949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20260307075611.3410-4-yanjun.zhu%40linux.dev
patch subject: [PATCH 3/4] RDMA/rxe: Support RDMA link creation and destruction per net namespace
config: loongarch-randconfig-001-20260308 (https://download.01.org/0day-ci/archive/20260308/202603081310.Lo0y72dG-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603081310.Lo0y72dG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603081310.Lo0y72dG-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: drivers/infiniband/sw/rxe/rdma_rxe: section mismatch in reference: rxe_namespace_exit+0x0 (section: .text) -> rxe_net_ops (section: .init.data)
WARNING: modpost: drivers/infiniband/sw/rxe/rdma_rxe: section mismatch in reference: rxe_namespace_exit+0x4 (section: .text) -> rxe_net_ops (section: .init.data)
ERROR: modpost: "sysfb_primary_display" [drivers/video/fbdev/core/fb.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

