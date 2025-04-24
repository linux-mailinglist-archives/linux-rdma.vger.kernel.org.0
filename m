Return-Path: <linux-rdma+bounces-9781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA90CA9BA48
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 23:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767D34A8346
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 21:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64C28D850;
	Thu, 24 Apr 2025 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ce1F6Ugn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A1D28A1C9;
	Thu, 24 Apr 2025 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531885; cv=none; b=kTWk/8CS87CN3B48WNGkRRQmeukY22iHxpZD0ssRnnGujqBDGfjkGwmZPKGZx1fKXg80zbDGNwPka35x13cazOepZmc9ikNzd7ZX5/7X5dickMMEiBxajVGsoXM53T1DYxQVZy+7N8u+mMV+43wfH0ABGsc0Ij818c930rmweUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531885; c=relaxed/simple;
	bh=y3xkOyEPRECUJeCHXEj6vaIKKeVRHAxPfCAfgWVBNPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVKzGfGKY1t40U/frdgKXUUJ5+i9ysWNjFDlEMuPSjpXhACFX9CfoQUPf6ajNki+XdBP2bffSvlp1L8NrODQ/CxqWfH2fmfXKC6Eywz+UQf6wUs13tOdqdVbyBEeDLMSC3tFqAOuN5DftU4mxuwEUA0HA2ajNou9+ouLl6V7IO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ce1F6Ugn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745531882; x=1777067882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y3xkOyEPRECUJeCHXEj6vaIKKeVRHAxPfCAfgWVBNPU=;
  b=ce1F6Ugn7EH4C4URJzYIma3msy8K8fsC4c9ts0jLHkUq/ooi5Mv9pu/4
   YC8ELD2N7KEnmtfotnfuaS4BHnbixie9Yn2emfYNQpdEobcS3MDMOnDjl
   jtWN0cPCGQrwIjhVJjK1XwBK5T2ET0Wv8SGZCLocrMyvs/sIUSqrKAaJO
   3/P/o/ZEQp9qD0HHq1ymsWc9Q4xDvVk6zexl79U6cCupXaUzhw+n2PGMN
   o8oaBYLIa+zsIROcnxlGHTwY/NtcqqweVpfTrOXg9TiK1J36jBVBz+L88
   +GM3VcfAnZCbV+Atw+Ps6RdqDUffJTUmIAE32n+/9zaeUF+PYqg4etxmy
   w==;
X-CSE-ConnectionGUID: M81vnbL/Qey/wZHw7dmeFw==
X-CSE-MsgGUID: wwZkRvH0RpGRg82L0+mByQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="64603975"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="64603975"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 14:58:01 -0700
X-CSE-ConnectionGUID: WRtFMZLBTCGcHXkDl+jQhw==
X-CSE-MsgGUID: g/8gZ322TWaqhX+WXgs3xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="133659197"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Apr 2025 14:57:58 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u84Zv-0004cj-2R;
	Thu, 24 Apr 2025 21:57:55 +0000
Date: Fri, 25 Apr 2025 05:57:54 +0800
From: kernel test robot <lkp@intel.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
	leon@kernel.org, andrew+netdev@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, allen.hubbe@amd.com,
	nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: Re: [PATCH 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build
 environment
Message-ID: <202504250547.mQFcTtpn-lkp@intel.com>
References: <20250423102913.438027-15-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423102913.438027-15-abhijit.gangurde@amd.com>

Hi Abhijit,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.15-rc3 next-20250424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhijit-Gangurde/net-ionic-Rename-neqs_per_lif-to-reflect-rdma-capability/20250423-185723
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250423102913.438027-15-abhijit.gangurde%40amd.com
patch subject: [PATCH 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build environment
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20250425/202504250547.mQFcTtpn-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250425/202504250547.mQFcTtpn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504250547.mQFcTtpn-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__xchg_called_with_bad_pointer" [drivers/infiniband/hw/ionic/ionic_rdma.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

