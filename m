Return-Path: <linux-rdma+bounces-494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9C81E494
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Dec 2023 03:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CEE1C21BB2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Dec 2023 02:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D988641;
	Tue, 26 Dec 2023 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rM48GSGL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26F4400
	for <linux-rdma@vger.kernel.org>; Tue, 26 Dec 2023 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06da7417-7706-409f-b3d7-a62caa81d57b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703558134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqisLRf4GV+oh5SCv6QWn6SnAyx7Xx1gcM07OoVgR9o=;
	b=rM48GSGLmD2q2vSHjpLyM8uxEUD0vEmUefIiUTKXqYOWfNJIfE8MbJZhDvgOWTnxVIdqE2
	9Cicgibn+enr1sTDjkUI3QJMp6updxJzL++MDT3R2Y/sLq2pbxjdOLDaq2MmUlZCPvNb/3
	8BtdmD/TEhzjJJeJDLMST4fl5VC1V8o=
Date: Tue, 26 Dec 2023 10:35:28 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Add hardware statistics
 support
To: kernel test robot <lkp@intel.com>, Cheng Xu <chengyou@linux.alibaba.com>,
 jgg@ziepe.ca, leon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
 KaiShen@linux.alibaba.com
References: <20231225032117.7493-3-chengyou@linux.alibaba.com>
 <202312260550.9DPkrw52-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <202312260550.9DPkrw52-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2023/12/26 6:09, kernel test robot 写道:
> Hi Cheng,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on rdma/for-next]
> [also build test WARNING on linus/master v6.7-rc7 next-20231222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Cheng-Xu/RDMA-erdma-Introduce-dma-pool-for-hardware-responses-of-CMDQ-requests/20231225-154653
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> patch link:    https://lore.kernel.org/r/20231225032117.7493-3-chengyou%40linux.alibaba.com
> patch subject: [PATCH for-next v2 2/2] RDMA/erdma: Add hardware statistics support
> config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20231226/202312260550.9DPkrw52-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260550.9DPkrw52-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312260550.9DPkrw52-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/infiniband/hw/erdma/erdma_verbs.c:1750:5: warning: no previous prototype for 'erdma_query_hw_stats' [-Wmissing-prototypes]
>      1750 | int erdma_query_hw_stats(struct erdma_dev *dev, struct rdma_hw_stats *stats)
>           |     ^~~~~~~~~~~~~~~~~~~~
> 

Prepending "static" can fix this problem.

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c 
b/drivers/infiniband/hw/erdma/erdma_verbs.c
index e47e158bedd5..de534651658d 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1747,7 +1747,7 @@ struct rdma_hw_stats 
*erdma_alloc_hw_port_stats(struct ib_device *device,
                                           RDMA_HW_STATS_DEFAULT_LIFESPAN);
  }

-int erdma_query_hw_stats(struct erdma_dev *dev, struct rdma_hw_stats 
*stats)
+static int erdma_query_hw_stats(struct erdma_dev *dev, struct 
rdma_hw_stats *stats)
  {
         struct erdma_cmdq_query_stats_resp *resp;
         struct erdma_cmdq_query_req req;


> 
> vim +/erdma_query_hw_stats +1750 drivers/infiniband/hw/erdma/erdma_verbs.c
> 
>    1749	
>> 1750	int erdma_query_hw_stats(struct erdma_dev *dev, struct rdma_hw_stats *stats)
>    1751	{
>    1752		struct erdma_cmdq_query_stats_resp *resp;
>    1753		struct erdma_cmdq_query_req req;
>    1754		dma_addr_t dma_addr;
>    1755		int err;
>    1756	
>    1757		erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
>    1758					CMDQ_OPCODE_GET_STATS);
>    1759	
>    1760		resp = dma_pool_zalloc(dev->resp_pool, GFP_KERNEL, &dma_addr);
>    1761		if (!resp)
>    1762			return -ENOMEM;
>    1763	
>    1764		req.target_addr = dma_addr;
>    1765		req.target_length = ERDMA_HW_RESP_SIZE;
>    1766	
>    1767		err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
>    1768		if (err)
>    1769			goto out;
>    1770	
>    1771		if (resp->hdr.magic != ERDMA_HW_RESP_MAGIC) {
>    1772			err = -EINVAL;
>    1773			goto out;
>    1774		}
>    1775	
>    1776		memcpy(&stats->value[0], &resp->tx_req_cnt,
>    1777		       sizeof(u64) * stats->num_counters);
>    1778	
>    1779	out:
>    1780		dma_pool_free(dev->resp_pool, resp, dma_addr);
>    1781	
>    1782		return err;
>    1783	}
>    1784	
> 


