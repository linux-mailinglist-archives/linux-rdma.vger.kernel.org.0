Return-Path: <linux-rdma+bounces-493-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF0881E2FE
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Dec 2023 01:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B111C210A9
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Dec 2023 00:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732BA40;
	Tue, 26 Dec 2023 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYvrWUan"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B8382
	for <linux-rdma@vger.kernel.org>; Tue, 26 Dec 2023 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703549007; x=1735085007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R86IIiJbwjlkxTh4YsUNoDoekYHjsZn2h2Hx9zZ3lKI=;
  b=EYvrWUan52R9YAaIK/f1jmuwejtbXnItrwr02IMMk6RcIkwsFg0Dt7p3
   QXJdtB1K1PTF9aqSGKKOckidogosiTIdCOyFVvJ27OFFECgAkEpceS007
   bnROAZ7r+8av85kjQuou9izBfM5jVdwgE8zTOTGqXkJfc0a73MZAgFpS1
   I+vquQgkg1mxC3NLuolwdcMUjICXzH1/A6SI+NcF3HHkooge346x7eHqv
   hpSo9crVDt4u8xptwhdbFjQ7ln4P1oRV1r5QBpAxaHMGrtfBjrB2Omj9J
   XtqNYclucRLrPVi6cWRVBJKRo9wacNUhquMYw2wrfSDuz40WIzR9jtQ+g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="482485086"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="482485086"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 16:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="848288690"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="848288690"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 25 Dec 2023 16:03:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHuul-000Dnd-38;
	Tue, 26 Dec 2023 00:03:19 +0000
Date: Tue, 26 Dec 2023 08:03:08 +0800
From: kernel test robot <lkp@intel.com>
To: Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca, leon@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Add hardware statistics
 support
Message-ID: <202312260724.2RjYLbxV-lkp@intel.com>
References: <20231225032117.7493-3-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225032117.7493-3-chengyou@linux.alibaba.com>

Hi Cheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cheng-Xu/RDMA-erdma-Introduce-dma-pool-for-hardware-responses-of-CMDQ-requests/20231225-154653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20231225032117.7493-3-chengyou%40linux.alibaba.com
patch subject: [PATCH for-next v2 2/2] RDMA/erdma: Add hardware statistics support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231226/202312260724.2RjYLbxV-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260724.2RjYLbxV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260724.2RjYLbxV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/erdma/erdma_verbs.c:1750:5: warning: no previous prototype for function 'erdma_query_hw_stats' [-Wmissing-prototypes]
   int erdma_query_hw_stats(struct erdma_dev *dev, struct rdma_hw_stats *stats)
       ^
   drivers/infiniband/hw/erdma/erdma_verbs.c:1750:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int erdma_query_hw_stats(struct erdma_dev *dev, struct rdma_hw_stats *stats)
   ^
   static 
   1 warning generated.


vim +/erdma_query_hw_stats +1750 drivers/infiniband/hw/erdma/erdma_verbs.c

  1749	
> 1750	int erdma_query_hw_stats(struct erdma_dev *dev, struct rdma_hw_stats *stats)
  1751	{
  1752		struct erdma_cmdq_query_stats_resp *resp;
  1753		struct erdma_cmdq_query_req req;
  1754		dma_addr_t dma_addr;
  1755		int err;
  1756	
  1757		erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
  1758					CMDQ_OPCODE_GET_STATS);
  1759	
  1760		resp = dma_pool_zalloc(dev->resp_pool, GFP_KERNEL, &dma_addr);
  1761		if (!resp)
  1762			return -ENOMEM;
  1763	
  1764		req.target_addr = dma_addr;
  1765		req.target_length = ERDMA_HW_RESP_SIZE;
  1766	
  1767		err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
  1768		if (err)
  1769			goto out;
  1770	
  1771		if (resp->hdr.magic != ERDMA_HW_RESP_MAGIC) {
  1772			err = -EINVAL;
  1773			goto out;
  1774		}
  1775	
  1776		memcpy(&stats->value[0], &resp->tx_req_cnt,
  1777		       sizeof(u64) * stats->num_counters);
  1778	
  1779	out:
  1780		dma_pool_free(dev->resp_pool, resp, dma_addr);
  1781	
  1782		return err;
  1783	}
  1784	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

