Return-Path: <linux-rdma+bounces-4577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 791E895FE39
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 03:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202591F22A85
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 01:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C44C80;
	Tue, 27 Aug 2024 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bNwBefJs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654F4A2D
	for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724721965; cv=none; b=lBXmwcLMXLYLuLfpXq//33LT9rwUPi1qEI/B/DK+zX+Oqk5r8V/A7iUncZ7fYkBWfgKVdenLdtollxs6kf6uZZ4d0KIhb8eiUsqi4+Qn2ZAgGxcVF3uN+uYAplgw8V227DuvLmxi3K5VutzF4T3qFqCpngyZQAiz5wbJEnz6cz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724721965; c=relaxed/simple;
	bh=Uez05m10zQOVyiWsSAhFkbzI0MjMSuKG7JPik6wLM8I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dU/dKkeT+TUKyqWN4xCIerKoQ2sirde7JrSA+iHF96n0CodaaiIzDwh30rFzrTKaaIjV7+q/P0OxqaYvmThtTaz0QhSjlvFdNdqudTtTmyBZAYyc/sgJE9y18bwje6DPcmn8PQQChBop9WS5P2LEkBHb3FlmAzbBw3t7x9nG3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bNwBefJs; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724721954; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=JAraI/IXB9VouGKKvNPeywNuUsMkSCMVNVSTPiNohms=;
	b=bNwBefJsuupg+zE2xPRHA8/nOt02Lw1Dcf7X7orftysJ2U6WnO8HNKXxTceuUEvxEadJz8JwiV5Jw9KOw6M/2svsmxbZWie09SVs/LCKew2KKd72YKRgrwsQnMyjbn7cRSRQhztoaOjgWGGG19YcyuQmC6RR7oaiYG6yMghH43Y=
Received: from 30.221.116.190(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WDkZnno_1724721952)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 09:25:53 +0800
Message-ID: <58196845-0ed8-d992-831a-b3a2718ca760@linux.alibaba.com>
Date: Tue, 27 Aug 2024 09:25:52 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From: Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-next 2/4] RDMA/erdma: Refactor the initialization and
 destruction of EQ
To: kernel test robot <lkp@intel.com>, jgg@ziepe.ca, leon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
 KaiShen@linux.alibaba.com
References: <20240823075058.89488-3-chengyou@linux.alibaba.com>
 <202408262144.SpsbTKs7-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202408262144.SpsbTKs7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/26/24 9:51 PM, kernel test robot wrote:
> Hi Cheng,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on rdma/for-next]
> [also build test WARNING on linus/master v6.11-rc5 next-20240826]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Cheng-Xu/RDMA-erdma-Make-the-device-probe-process-more-robust/20240826-123256
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> patch link:    https://lore.kernel.org/r/20240823075058.89488-3-chengyou%40linux.alibaba.com
> patch subject: [PATCH for-next 2/4] RDMA/erdma: Refactor the initialization and destruction of EQ
> config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240826/202408262144.SpsbTKs7-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408262144.SpsbTKs7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408262144.SpsbTKs7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/infiniband/hw/erdma/erdma_eq.c:141:6: warning: no previous prototype for 'erdma_aeq_destroy' [-Wmissing-prototypes]
>      141 | void erdma_aeq_destroy(struct erdma_dev *dev)
>          |      ^~~~~~~~~~~~~~~~~

Forgot to remove this unused function, will fix.


> 
> vim +/erdma_aeq_destroy +141 drivers/infiniband/hw/erdma/erdma_eq.c
> 
> f2a0a630b95345 Cheng Xu 2022-07-27  140  
> f2a0a630b95345 Cheng Xu 2022-07-27 @141  void erdma_aeq_destroy(struct erdma_dev *dev)
> f2a0a630b95345 Cheng Xu 2022-07-27  142  {
> f2a0a630b95345 Cheng Xu 2022-07-27  143  	struct erdma_eq *eq = &dev->aeq;
> f2a0a630b95345 Cheng Xu 2022-07-27  144  
> f0697bf078368d Boshi Yu 2024-03-11  145  	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
> f2a0a630b95345 Cheng Xu 2022-07-27  146  			  eq->qbuf_dma_addr);
> f0697bf078368d Boshi Yu 2024-03-11  147  
> fdb09ed15f272a Boshi Yu 2024-03-11  148  	dma_pool_free(dev->db_pool, eq->dbrec, eq->dbrec_dma);
> f2a0a630b95345 Cheng Xu 2022-07-27  149  }
> f2a0a630b95345 Cheng Xu 2022-07-27  150  
> 

