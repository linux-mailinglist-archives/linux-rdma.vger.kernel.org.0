Return-Path: <linux-rdma+bounces-499-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC25B81EB59
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Dec 2023 02:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A00A1F21854
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Dec 2023 01:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F8D1FB2;
	Wed, 27 Dec 2023 01:44:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCFB4403
	for <linux-rdma@vger.kernel.org>; Wed, 27 Dec 2023 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VzJMpPy_1703641456;
Received: from 30.221.116.50(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VzJMpPy_1703641456)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 09:44:17 +0800
Message-ID: <90098a72-c11c-6e53-464c-40b86ac7b75f@linux.alibaba.com>
Date: Wed, 27 Dec 2023 09:44:16 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Add hardware statistics
 support
To: Zhu Yanjun <yanjun.zhu@linux.dev>, kernel test robot <lkp@intel.com>,
 jgg@ziepe.ca, leon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
 KaiShen@linux.alibaba.com
References: <20231225032117.7493-3-chengyou@linux.alibaba.com>
 <202312260550.9DPkrw52-lkp@intel.com>
 <06da7417-7706-409f-b3d7-a62caa81d57b@linux.dev>
Content-Language: en-US
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <06da7417-7706-409f-b3d7-a62caa81d57b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/26/23 10:35 AM, Zhu Yanjun wrote:
> 在 2023/12/26 6:09, kernel test robot 写道:
>> Hi Cheng,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on rdma/for-next]
>> [also build test WARNING on linus/master v6.7-rc7 next-20231222]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Cheng-Xu/RDMA-erdma-Introduce-dma-pool-for-hardware-responses-of-CMDQ-requests/20231225-154653
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
>> patch link:    https://lore.kernel.org/r/20231225032117.7493-3-chengyou%40linux.alibaba.com
>> patch subject: [PATCH for-next v2 2/2] RDMA/erdma: Add hardware statistics support
>> config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20231226/202312260550.9DPkrw52-lkp@intel.com/config)
>> compiler: s390-linux-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260550.9DPkrw52-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202312260550.9DPkrw52-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/infiniband/hw/erdma/erdma_verbs.c:1750:5: warning: no previous prototype for 'erdma_query_hw_stats' [-Wmissing-prototypes]
>>      1750 | int erdma_query_hw_stats(struct erdma_dev *dev, struct rdma_hw_stats *stats)
>>           |     ^~~~~~~~~~~~~~~~~~~~
>>
> 
> Prepending "static" can fix this problem.
> 

You are right, thanks for your suggestion.

Cheng Xu

