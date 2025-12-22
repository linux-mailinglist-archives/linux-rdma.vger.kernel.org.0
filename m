Return-Path: <linux-rdma+bounces-15164-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA718CD6AD3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA1D530139AA
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD413321A3;
	Mon, 22 Dec 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JheAFY/m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB070331A57;
	Mon, 22 Dec 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766421446; cv=none; b=Em5NZIuNRGZWPrKfTVBJaucRYksw6Ie9BEKnfomkeBfsBHbjnw23XSHTgAKRk8fsYZVwQBfg2UjM4QF4D+ZqpOI8589Z9Kj3KXXRPfTmRYCfdQA7jnj0S02s7nOjzd88kG4w+9fkvE3yWcI6KomXG+Rsvb9sX6k+c2bLDzMZW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766421446; c=relaxed/simple;
	bh=Wfss8ZAwJ5UIe7i0MAIm06rFmw1wyA7oQVPNPhENjB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwuGLU6MiSqLHjmxYIhZSfO2nAG4pWv5fEn2NMhm2WDWkhEsUNme+YIMZC1CjgTk4TJKj/kTvt3OLZ5FNzxq8XSB/Zsu60ejI9z4edLP5FJRVlD8ZAMmBJRy6GOusThZ+n9Yp+1RxQ6mOTmfe3NvYfr8QQ+2hwJs5Ps0vRaa8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JheAFY/m; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766421445; x=1797957445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wfss8ZAwJ5UIe7i0MAIm06rFmw1wyA7oQVPNPhENjB8=;
  b=JheAFY/mr0hZtq40KUQ7KYfWeoRsBBmaJo/s3zxQyb1xdTg6yWzOH5u5
   sePJYi+i469CpEnUMxGgWGV9o9VjFJ3REncsQC4J1lhLLh19mKWQG4Idt
   ot8VYzHaoItX2d428Tq7nQYWOaTPXObnq0CMsdRNcCkJnGC91x8ZRQ0t6
   RrX0K0ryYqCrye4URSGPWxVyunl074jvU7Xkm/fwG9W1gGTzl5lk7XQa5
   zLld2oA8kcKRhV7u9Q6R9RhS/yys6i2LoA7Q+HGhPm60Ep6QZBf+WiN2M
   g5c4xE0BXopHoEzfavVW/nua8d/l1g6qcYBjVClYn3oJoP1+MAHKEMJGS
   w==;
X-CSE-ConnectionGUID: PJ4HJ/lxR7+K653tsAL8vw==
X-CSE-MsgGUID: oUL/LktlTw2BkFygzSPw7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="85689880"
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="85689880"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 08:37:24 -0800
X-CSE-ConnectionGUID: HqEQfpXsRMepr58LKHUvkA==
X-CSE-MsgGUID: LzvYjuweSq2YalunxA0MLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="223051484"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 22 Dec 2025 08:37:22 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXiuO-000000005Ye-16hZ;
	Mon, 22 Dec 2025 16:37:20 +0000
Date: Mon, 22 Dec 2025 17:36:24 +0100
From: kernel test robot <lkp@intel.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Replace struct rxe_sge with struct
 ib_sge
Message-ID: <202512221736.Qj6n9uZT-lkp@intel.com>
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
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251222/202512221736.Qj6n9uZT-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251222/202512221736.Qj6n9uZT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512221736.Qj6n9uZT-lkp@intel.com/

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

