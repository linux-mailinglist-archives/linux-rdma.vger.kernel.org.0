Return-Path: <linux-rdma+bounces-15166-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4A2CD7605
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 23:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F93301D58B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B26630E0C8;
	Mon, 22 Dec 2025 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BstKPJ+U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53C30171E;
	Mon, 22 Dec 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766443816; cv=none; b=B1ljv7ZGhWplpWDfDsUvyzVXyPYRwHQLPpF9lh7Lh4xOlWmlL6WMiEiSWelSEEqUPnvXVPcPHKybP+NnZ8CU20LQtUu5FbE31Q4grv+pHgA/yKyu42Y2PpzvdLDMDj6y0IzplgW+yX0PSUn4yNL43gnBbBvQ5Lg6xJZY+6m3PGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766443816; c=relaxed/simple;
	bh=SqvJC7oq25Hm85BMabv/De3LzEOjPbn+kuJQnwOUTv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTxyINMCOBcjSaRjEe24BiGiWpu9OTlBaRLKOKJ40gSbS7nUeI55wjEgjt7cc50vACmBIrQdvsU9y6oW+yH57yXNDRmD10O7NjXhedR+4F3CCKxmZIHkTu8UbIRHyjnZEQtppxsJf+vg1ry2Sb9xsbcoiGAcCd1asYItPW3zlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BstKPJ+U; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766443815; x=1797979815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SqvJC7oq25Hm85BMabv/De3LzEOjPbn+kuJQnwOUTv8=;
  b=BstKPJ+UCJo0kH5PnGlAtP5/WoLJ1IhYoHYI/OAuytM3i0qDauaVjSix
   wig4PzuvR/9LKyzv45R2tbUf91AzHngNsxKb4jQZbIRl9OV3g8gCAuX3+
   EtXeNiE8RKwV7rDkDAVotfMgQGBQRodw0EoNRAo+TKTjYnKSXUOLOTnof
   sCq/8egKTaExGiAS3VwNopP3+wi1UgXPt0vMT0OZsAOBhScJZBOKrdEII
   2YKyGOM4r58fcNfm6VjKpYCiJK0C7I1sWIEKtXnqY0oJ5goI8K3QCt7fk
   k0W9pTHfLAOkuyIGcFD4j1fnt5yyWdzilCoSv2Zc6rdieIaBJZQ7YjU2c
   g==;
X-CSE-ConnectionGUID: 30Sk+mPpTLaFu75nEEaQFg==
X-CSE-MsgGUID: CoTbSuSnTf6Izrx40QfMKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="67494077"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="67494077"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 14:50:15 -0800
X-CSE-ConnectionGUID: Xokk78WITX6N0RwyjeMRbA==
X-CSE-MsgGUID: b/taRFiURNaVaWOcJbFQ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="199283556"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 Dec 2025 14:50:12 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXojC-000000001Bl-3fYJ;
	Mon, 22 Dec 2025 22:50:10 +0000
Date: Tue, 23 Dec 2025 06:49:47 +0800
From: kernel test robot <lkp@intel.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Replace struct rxe_sge with struct
 ib_sge
Message-ID: <202512230626.yVlfxS7X-lkp@intel.com>
References: <20251221233404.332108-2-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221233404.332108-2-yanjun.zhu@linux.dev>

Hi Zhu,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhu-Yanjun/RDMA-rxe-Replace-struct-rxe_sge-with-struct-ib_sge/20251222-074206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20251221233404.332108-2-yanjun.zhu%40linux.dev
patch subject: [PATCH v2 2/2] RDMA/rxe: Replace struct rxe_sge with struct ib_sge
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251223/202512230626.yVlfxS7X-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512230626.yVlfxS7X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230626.yVlfxS7X-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from usr/include/linux/posix_types.h:5,
                    from usr/include/linux/types.h:9,
                    from ./usr/include/rdma/rdma_user_rxe.h:37,
                    from <command-line>:
>> ./usr/include/rdma/rdma_user_rxe.h:141:53: error: array type has incomplete element type 'struct ib_sge'
     141 |                 __DECLARE_FLEX_ARRAY(struct ib_sge, sge);
         |                                                     ^~~
   usr/include/linux/stddef.h:56:22: note: in definition of macro '__DECLARE_FLEX_ARRAY'
      56 |                 TYPE NAME[]; \
         |                      ^~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

