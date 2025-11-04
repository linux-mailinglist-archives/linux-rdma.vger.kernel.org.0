Return-Path: <linux-rdma+bounces-14219-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93986C2ECED
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 02:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69DF1883D11
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 01:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9E2264B1;
	Tue,  4 Nov 2025 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLhtPymq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5FC224240
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220080; cv=none; b=kj3o2bcekjrDM71d3G6PGWap5cPEVCwshcwWOimfHG/hntIMp9k+2JKdXFvFX91WzYoJTRQhftd3iCSSIePoDJ4d07/Trfnd5vAbGmbA52ShkrhLdu+XyneAdHIvyqINcXzbnt8Xbkt4VOBLhW+0A/IpdCQEPkqCaYNXXvT42SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220080; c=relaxed/simple;
	bh=PD0fT2/G5PeBw1YSpO6vFTtLb30V9P9O3gXC/MNJuNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zs4v8pQtu9eX4ErL68yyyNDoQ9qvqSk5nK+zrQg5R8nLs9ipuHLAuWIbGcZFIaZlRmGHn+jzh4ZaEJwXgbVvKC3WzLmA2iTXKGAYUg/n4ehsalTD88PzrNZ7IyUblJMpZPSjDnJAznfQL79Hr0RNjax5xQznFhl+rKkuGBBkvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLhtPymq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762220077; x=1793756077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PD0fT2/G5PeBw1YSpO6vFTtLb30V9P9O3gXC/MNJuNM=;
  b=YLhtPymqaFzYG70Vlliwk2G2u6JRvKV2QvPnq30MHJrM2TbE6ZD/S+3L
   mmXLBHxLX98dEEPE6ba4skuyJnGDmvvFI6YYnPLzoUhKjjhiQkUNmAbvg
   78b+spCFJ5VgOt84c5SF0j5nuaFKx9EtSWVt3oHYtgjGFn9jIPMOxeR7G
   Ydz/64SWLxeg2xolGo+WWOGofaI8+B9jpVo2EbhnODU2PRdkeZdT/r9M9
   Zy2b5X+Ub8dt0/8MdSv47Xa15qXWbcoUmlw02C81BVfDxizsI7Bk2EGaZ
   2hc7Un15a4fddU3KNQL4d6PAKXUpwINupNXGIl3Z/g9ZUDFFw6s2UpYHG
   A==;
X-CSE-ConnectionGUID: lrwVjz0SQFqvElEGUNc8gA==
X-CSE-MsgGUID: X5j5Hjo6QwmnBNknw3yB1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74910682"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="74910682"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:34:36 -0800
X-CSE-ConnectionGUID: xnS5Q7r2RYma6owAF6BYLw==
X-CSE-MsgGUID: kXnwvqeXQWadpRY4Atq6MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186261546"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 03 Nov 2025 17:34:35 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vG5wD-000Qj8-1Y;
	Tue, 04 Nov 2025 01:34:24 +0000
Date: Tue, 4 Nov 2025 09:34:03 +0800
From: kernel test robot <lkp@intel.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	leon@kernel.org, jgg@ziepe.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH rdma-next 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR
 and UMEM verbs
Message-ID: <202511040929.WGNASMrK-lkp@intel.com>
References: <20251103105033.205586-4-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103105033.205586-4-sriharsha.basavapatna@broadcom.com>

Hi Sriharsha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.18-rc4 next-20251103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sriharsha-Basavapatna/RDMA-bnxt_re-Move-the-UAPI-methods-to-a-dedicated-file/20251103-190151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20251103105033.205586-4-sriharsha.basavapatna%40broadcom.com
patch subject: [PATCH rdma-next 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR and UMEM verbs
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251104/202511040929.WGNASMrK-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511040929.WGNASMrK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511040929.WGNASMrK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/bnxt_re/dv.c: In function 'bnxt_re_handler_BNXT_RE_METHOD_DBR_QUERY':
>> drivers/infiniband/hw/bnxt_re/dv.c:552:29: warning: variable 'rdev' set but not used [-Wunused-but-set-variable]
     552 |         struct bnxt_re_dev *rdev;
         |                             ^~~~


vim +/rdev +552 drivers/infiniband/hw/bnxt_re/dv.c

   546	
   547	static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_QUERY)(struct uverbs_attr_bundle *attrs)
   548	{
   549		struct bnxt_re_dv_db_region dpi = {};
   550		struct bnxt_re_ucontext *uctx;
   551		struct ib_ucontext *ib_uctx;
 > 552		struct bnxt_re_dev *rdev;
   553		int ret;
   554	
   555		ib_uctx = ib_uverbs_get_ucontext(attrs);
   556		if (IS_ERR(ib_uctx))
   557			return PTR_ERR(ib_uctx);
   558	
   559		uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
   560		rdev = uctx->rdev;
   561	
   562		dpi.umdbr = uctx->dpi.umdbr;
   563		dpi.dpi = uctx->dpi.dpi;
   564	
   565		ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_QUERY_DBR_ATTR,
   566						    &dpi, sizeof(dpi));
   567		if (ret)
   568			return ret;
   569	
   570		return 0;
   571	}
   572	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

