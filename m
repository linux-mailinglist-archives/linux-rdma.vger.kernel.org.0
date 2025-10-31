Return-Path: <linux-rdma+bounces-14161-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45DC25CC2
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 16:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E75974F8776
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018B23AE66;
	Fri, 31 Oct 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vqwbh277"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AA23D7C4
	for <linux-rdma@vger.kernel.org>; Fri, 31 Oct 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923370; cv=none; b=HFCeKBf7G69ULnjGnnroh9/0CtFvK76tYRv/KR6AqhkOcix+z6LVqLCMoYsP/qTw+8i4MGpXlT+qfh//iMJKJ+qwb+Ac1G6ib0wIoVBXNGlb0Jzr116KjBdlo3W4+z52uGcrqHCeiNxxG3hUZTa/zknMm954UVROyOlDE/NKQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923370; c=relaxed/simple;
	bh=h38XWH5oNliTqnSzDy6hKbk/3zxZrXB4UKzWrtXAiMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IidHQNTs6HC0B6nhlJkqjf+I24ZY+finmyNujxClOy8aGktlXnOANug5nVix1MluB93ZzGnonjKewSQ3XFuCQxnP/WrAKeYirY0HvoJQSOQxrFHrwoRWSgQHD97VCtpmEFWH1+1AL47sLT/OMfgRiTliZfo4cZWeaao20A29TqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vqwbh277; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761923369; x=1793459369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h38XWH5oNliTqnSzDy6hKbk/3zxZrXB4UKzWrtXAiMc=;
  b=Vqwbh277MYL4IAitTWyOmS5qjig992El9pZrgJ1B7fKpKzLdMPQFO8B+
   ca3ek2QmPxvmgO7UyP4UHZYEBb/qDOJqrAY/wjHsbsuI7jBD1ts79L7CN
   9vGE9bVvTA2HVq7/qH+9n/7xYntrr/ULGdxm1zJr3vQndW9/PSDJr/rD/
   bAe9sr2FgPgSkaP3hRA12Q/YleZYcbrbMyASp1sZ0lx5Vo/FdjeN8UkW4
   4ATTFyPjg3EbEsJKGwq+vwcm4aUNHik2MHiWnrQv2wqLniqQZgoO4v1TL
   gpFjdZt1XSZBh9c7SCqoh3BxC42mMiqFTzJVdMaKYQ/hgA3fzN80WTPDm
   Q==;
X-CSE-ConnectionGUID: 3MNDUEalRRC/Zwq0Bkv6Aw==
X-CSE-MsgGUID: 4+cc1kdkQ8eitZLjMjfpEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="81714959"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="81714959"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:09:29 -0700
X-CSE-ConnectionGUID: 8KI+8oI1R9eoEZGYHij9DQ==
X-CSE-MsgGUID: SETeYqBIQDS5+YXdY7aXLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185943240"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 31 Oct 2025 08:09:26 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEqkm-000NKe-1O;
	Fri, 31 Oct 2025 15:09:24 +0000
Date: Fri, 31 Oct 2025 23:08:30 +0800
From: kernel test robot <lkp@intel.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, leon@kernel.org,
	jgg@ziepe.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Add a debugfs entry for CQE
 coalescing tuning
Message-ID: <202510312213.Pogyd6u5-lkp@intel.com>
References: <20251030171540.12656-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030171540.12656-1-kalesh-anakkur.purayil@broadcom.com>

Hi Kalesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kalesh-AP/RDMA-bnxt_re-Add-a-debugfs-entry-for-CQE-coalescing-tuning/20251031-011453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20251030171540.12656-1-kalesh-anakkur.purayil%40broadcom.com
patch subject: [PATCH rdma-next] RDMA/bnxt_re: Add a debugfs entry for CQE coalescing tuning
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251031/202510312213.Pogyd6u5-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510312213.Pogyd6u5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510312213.Pogyd6u5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/infiniband/hw/bnxt_re/main.c:70:
>> drivers/infiniband/hw/bnxt_re/debugfs.h:37:27: warning: 'bnxt_re_cq_coal_str' defined but not used [-Wunused-const-variable=]
      37 | static const char * const bnxt_re_cq_coal_str[] = {
         |                           ^~~~~~~~~~~~~~~~~~~


vim +/bnxt_re_cq_coal_str +37 drivers/infiniband/hw/bnxt_re/debugfs.h

    36	
  > 37	static const char * const bnxt_re_cq_coal_str[] = {
    38		"buf_maxtime",
    39		"normal_maxbuf",
    40		"during_maxbuf",
    41		"en_ring_idle_mode",
    42		"enable",
    43	};
    44	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

