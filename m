Return-Path: <linux-rdma+bounces-1644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AD5890702
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 18:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7A2299A88
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3917E767;
	Thu, 28 Mar 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeDLCZYi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60984436B;
	Thu, 28 Mar 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646364; cv=none; b=iv/QRYR3H7+/tOGmtDAxYsWClNWe9FqEaDPCud4xRG1/KdujCqsPqL1zokBv2ihpunfZ/JA8vNxn+YeJ34xMRsarWS+OU9stFUUq7XgKzBc4S4WKP2QpU8rOcBUky4Ia/wiaQDodK6z3H1Gq7vKZNeWgF1E+1C9S/cHldOPo0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646364; c=relaxed/simple;
	bh=SjNBm760kIgx8JgQnDyaM+FCHFSFE+fqSaoT+RmVu3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vj/WMk+JAdkqP6xzICepayScoY3z/erGHeGpIV1miBgL+LvXDwaTnd+xGAU+OeSet1lBMs3DWJbd+JpDgL7j2OXfLsUboSPMxBDCX2gpemVxwtKiIOCuv5PsyxUm9rAqg5gkURnkMfm1pYfPT7spfIh1f8cv8810C4rh2bPWZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeDLCZYi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711646363; x=1743182363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SjNBm760kIgx8JgQnDyaM+FCHFSFE+fqSaoT+RmVu3s=;
  b=HeDLCZYiPgOOFq/O0fhdvcdSeVBGQXjR8+lDh6KGvNoxNqCZExhilQIX
   sA3EyAy9rnCe/j8xeP2vHFAAt+B3U0WGJ4imY3MRbGVbfifVLlMnO97hs
   hth/c0USk4tXV/G3OY3UUBIHknUEq+cgcY/uyvFcWirc0Izrnrw0qZ8JQ
   4LYvn64iPpUjSwm6QYD2AyKfqsJrZYUonOLTEMxRnd5qxw7QFfDwL70Nj
   +Up2dcRu0SzW9ZwCOlv/ACxtZYFXitryzV4ny+RxEui3kgKFtwTKKcTnb
   NSA5BX+KPt+OF6sB6SXN+IMzkoljGfCQJp6xXsSNF+j1kIaWDmFzIr+RQ
   g==;
X-CSE-ConnectionGUID: kzj5ylgQTnayGTO3sJQ26A==
X-CSE-MsgGUID: BA20fvUITAapxucO6lh2hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24302618"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24302618"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21446717"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Mar 2024 10:19:17 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rptPH-0002NY-0G;
	Thu, 28 Mar 2024 17:19:15 +0000
Date: Fri, 29 Mar 2024 01:18:30 +0800
From: kernel test robot <lkp@intel.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mina Almasry <almasrymina@google.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mirko Lindner <mlindner@marvell.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2 2/3] net: mirror skb frag ref/unref helpers
Message-ID: <202403290103.BHENUIYW-lkp@intel.com>
References: <20240327214523.2182174-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327214523.2182174-3-almasrymina@google.com>

Hi Mina,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mina-Almasry/net-make-napi_frag_unref-reuse-skb_page_unref/20240328-054816
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240327214523.2182174-3-almasrymina%40google.com
patch subject: [PATCH net-next v2 2/3] net: mirror skb frag ref/unref helpers
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240329/202403290103.BHENUIYW-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 23de3862dce582ce91c1aa914467d982cb1a73b4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403290103.BHENUIYW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403290103.BHENUIYW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/skbuff.c:40:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> net/core/skbuff.c:1016:21: error: use of undeclared identifier 'head_page'
    1016 |         page_pool_ref_page(head_page);
         |                            ^
   1 warning and 1 error generated.


vim +/head_page +1016 net/core/skbuff.c

  1010	
  1011		page = compound_head(page);
  1012	
  1013		if (!is_pp_page(page))
  1014			return false;
  1015	
> 1016		page_pool_ref_page(head_page);
  1017		return true;
  1018	}
  1019	EXPORT_SYMBOL(napi_pp_get_page);
  1020	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

