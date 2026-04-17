Return-Path: <linux-rdma+bounces-19420-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNQqIUu34mnb9QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19420-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 00:42:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA88541EEFA
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 00:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93FBD30610E1
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F01348465;
	Fri, 17 Apr 2026 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJl7io4t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC02BEFED
	for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2026 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776465735; cv=none; b=Rf8Gw/72c0neMb5f2w8jSvce3xYhnTDS1IDpzFKA77zeoaJn5XwCtal1l/ADP36utIbNmrmznG5TvwBoW9KGf0rdpXAyD1zt7WQ6HHUA3hoFugN+0AUUGr8l/avRnZW54W9NayUQvULi9gYEK/EfFwPYWw/vfUz1mhjh2Z13eDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776465735; c=relaxed/simple;
	bh=gLJioYZHlOEyzNxIQ/0Yra8oQ/a1rnFkA96oshq5NFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvfBwDC0b+uOHCWl/3u2zNSgRRYVB0JTvnKfU7mvCbAFC9CLOwKW9tUOANWQRDPJr78UXTHiIfQeuM+PUT/Zto+ZheeUxrU7oD+h3P6WGZtaRwHrNZzqLs0xF5YbQg7A+lKR4JcrImaeMSmYLHCOgOkwvjrmiYDA7km+ZRVkCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJl7io4t; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776465734; x=1808001734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gLJioYZHlOEyzNxIQ/0Yra8oQ/a1rnFkA96oshq5NFM=;
  b=gJl7io4tUgrhb6RVmZc0jvGomZ9KmuzpPDZmsp5zHOpeP1AblX/8Lgk2
   nk2fh0VaKGiEPrJZME9JA2DYhy6WVM89iXUsaW5DTuK4abkTquuzXQn1i
   fw3G84Cli5aBulUqSQwTm5q42A3MpF9xZ4KEK7I0QtJYHlY4+SPEaDgIi
   /LX3t8FxWOZEw4X4jQGqwZPOE2eUgNHUdmgGdzlr2zrqrhc9VA69lgdU8
   uCe8scsQ99DiWOW67AaJnJqgokl7N4Nb9zNcIQ718NeMnKDNfiZNdMrg1
   5JKp/HX41EI4mMRvxV7pe8k4Sh1bSfds7UUg4sefP55v1u5Gw2S+T9pd0
   A==;
X-CSE-ConnectionGUID: YIOrttuaQJSsaMdgPtgrhA==
X-CSE-MsgGUID: C7wojdn7Qcal2Pj6nm+76w==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77352303"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="77352303"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 15:42:13 -0700
X-CSE-ConnectionGUID: u61miJJhS92b+YiJbtz3GA==
X-CSE-MsgGUID: pWd17O6JRO6G6n4tSDV5VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="226812127"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 17 Apr 2026 15:42:11 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDrt2-000000001R3-32VT;
	Fri, 17 Apr 2026 22:42:08 +0000
Date: Sat, 18 Apr 2026 00:41:18 +0200
From: kernel test robot <lkp@intel.com>
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sleybo@amazon.com, matua@amazon.com,
	gal.pressman@linux.dev
Subject: Re: [PATCH for-next 4/4] RDMA/efa: Add Completion Counters support
Message-ID: <202604180019.QPe3yyCy-lkp@intel.com>
References: <20260407115424.13359-5-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407115424.13359-5-mrgolin@amazon.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-19420-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: DA88541EEFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on next-20260417]
[cannot apply to linus/master v7.0]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Margolin/RDMA-core-Add-Completion-Counters-support/20260417-170427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20260407115424.13359-5-mrgolin%40amazon.com
patch subject: [PATCH for-next 4/4] RDMA/efa: Add Completion Counters support
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260418/202604180019.QPe3yyCy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260418/202604180019.QPe3yyCy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604180019.QPe3yyCy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/infiniband/core/uverbs_std_types_comp_cntr.c:8:10: fatal error: rdma/ib_umem_dmabuf.h: No such file or directory
       8 | #include <rdma/ib_umem_dmabuf.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +8 drivers/infiniband/core/uverbs_std_types_comp_cntr.c

   > 8	#include <rdma/ib_umem_dmabuf.h>
     9	#include "rdma_core.h"
    10	#include "uverbs.h"
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

