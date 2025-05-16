Return-Path: <linux-rdma+bounces-10376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588BCAB9C05
	for <lists+linux-rdma@lfdr.de>; Fri, 16 May 2025 14:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A775010D3
	for <lists+linux-rdma@lfdr.de>; Fri, 16 May 2025 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05923C8A0;
	Fri, 16 May 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6txO3wk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF1235063;
	Fri, 16 May 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398525; cv=none; b=Cqyj38wf/MgI2jfD5S4SMPPHyZBr4cNV9ZWO2Lq3JKPKkP2sLwvwJRPNEIM9hZC010CDXRIEKEOCgDdLPk+fGrOGi7MeWMGsv7XHlLkLMATmfZUKocwRYY+LpNKOPF63uErmY4zxnq84iM/WYE7HzodVora/QOjX99XlWuiuD5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398525; c=relaxed/simple;
	bh=W3K28pAKxl8sf9FQ1cFzRh/S7+lXMOVHJ01qrcT3Epg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRWf8kAevJXsDR3WRpoqfQM26aOTSrFLU0tTI61YeOtrtfZXRN6uW+CSqTug9Dd4jRdv3SfJisy2mQUYJysB/8DNRJJjKV7tNzuEvSkVOGhkcUr1Y6e7kgAipugdNUUzKIW2DG7lTuOUHfrOJBunBq/fCijAUtEApwq24jQPhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6txO3wk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747398524; x=1778934524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W3K28pAKxl8sf9FQ1cFzRh/S7+lXMOVHJ01qrcT3Epg=;
  b=l6txO3wkykKEs7nAE5PF1wVltevVJzdYYGsTNDWuo6YzTy+EZibQ9GKB
   u/JvqXeMjdI7seNlH1nkDwg6QXXsg2fj8vLjTWgCQm8fvc/iUobQmzp3N
   q7/mGnC8r3+Ry624Yta8cYAtkZdMklSExDHYUHqZTON4xnLYcrmoIebF+
   rXah43tRKl6zkHUtf2kjZl72f/3u87UW2NJQfKJ3Hz3SY8D3d0IzeVneY
   bAwwvUiRvI0dDwDQnkavjtzW7w+8zMem8m5hY+Thdy20YZ804XX1xqwWM
   3+uyvh6ZD6GBT4NC0YcnA4DU2cMfiYzt2hP5iGndWglpZ/ZXIMFhYWT+f
   g==;
X-CSE-ConnectionGUID: F8k4Vju2QOysC05C7+L+GA==
X-CSE-MsgGUID: WRb/hH7/Rcuv/61CRwDFkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="74767451"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="74767451"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 05:28:43 -0700
X-CSE-ConnectionGUID: FIv2m/x9Q1GLwkhas4irZg==
X-CSE-MsgGUID: 3juNk3wcTFaGDejhu/y9CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143571042"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 May 2025 05:28:40 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFuB4-000JKV-12;
	Fri, 16 May 2025 12:28:38 +0000
Date: Fri, 16 May 2025 20:28:23 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, mustafa.ismail@intel.com,
	tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: puda: Clear entries after allocation to
 ensure clean state
Message-ID: <202505162002.CUpcFouJ-lkp@intel.com>
References: <20250515133929.1222-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515133929.1222-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v6.15-rc6 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/RDMA-irdma-puda-Clear-entries-after-allocation-to-ensure-clean-state/20250515-214046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20250515133929.1222-1-vulab%40iscas.ac.cn
patch subject: [PATCH] RDMA/irdma: puda: Clear entries after allocation to ensure clean state
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20250516/202505162002.CUpcFouJ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250516/202505162002.CUpcFouJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505162002.CUpcFouJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/infiniband/hw/irdma/puda.c: In function 'irdma_puda_send':
>> drivers/infiniband/hw/irdma/puda.c:448:24: error: passing argument 1 of 'irdma_clr_wqes' from incompatible pointer type [-Wincompatible-pointer-types]
     448 |         irdma_clr_wqes(qp, wqe_idx);
         |                        ^~
         |                        |
         |                        struct irdma_sc_qp *
   In file included from drivers/infiniband/hw/irdma/type.h:7,
                    from drivers/infiniband/hw/irdma/puda.c:6:
   drivers/infiniband/hw/irdma/user.h:412:41: note: expected 'struct irdma_qp_uk *' but argument is of type 'struct irdma_sc_qp *'
     412 | void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx);
         |                     ~~~~~~~~~~~~~~~~~~~~^~


vim +/irdma_clr_wqes +448 drivers/infiniband/hw/irdma/puda.c

   420	
   421	/**
   422	 * irdma_puda_send - complete send wqe for transmit
   423	 * @qp: puda qp for send
   424	 * @info: buffer information for transmit
   425	 */
   426	int irdma_puda_send(struct irdma_sc_qp *qp, struct irdma_puda_send_info *info)
   427	{
   428		__le64 *wqe;
   429		u32 iplen, l4len;
   430		u64 hdr[2];
   431		u32 wqe_idx;
   432		u8 iipt;
   433	
   434		/* number of 32 bits DWORDS in header */
   435		l4len = info->tcplen >> 2;
   436		if (info->ipv4) {
   437			iipt = 3;
   438			iplen = 5;
   439		} else {
   440			iipt = 1;
   441			iplen = 10;
   442		}
   443	
   444		wqe = irdma_puda_get_next_send_wqe(&qp->qp_uk, &wqe_idx);
   445		if (!wqe)
   446			return -ENOMEM;
   447	
 > 448		irdma_clr_wqes(qp, wqe_idx);
   449	
   450		qp->qp_uk.sq_wrtrk_array[wqe_idx].wrid = (uintptr_t)info->scratch;
   451		/* Third line of WQE descriptor */
   452		/* maclen is in words */
   453	
   454		if (qp->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2) {
   455			hdr[0] = 0; /* Dest_QPN and Dest_QKey only for UD */
   456			hdr[1] = FIELD_PREP(IRDMA_UDA_QPSQ_OPCODE, IRDMA_OP_TYPE_SEND) |
   457				 FIELD_PREP(IRDMA_UDA_QPSQ_L4LEN, l4len) |
   458				 FIELD_PREP(IRDMAQPSQ_AHID, info->ah_id) |
   459				 FIELD_PREP(IRDMA_UDA_QPSQ_SIGCOMPL, 1) |
   460				 FIELD_PREP(IRDMA_UDA_QPSQ_VALID,
   461					    qp->qp_uk.swqe_polarity);
   462	
   463			/* Forth line of WQE descriptor */
   464	
   465			set_64bit_val(wqe, 0, info->paddr);
   466			set_64bit_val(wqe, 8,
   467				      FIELD_PREP(IRDMAQPSQ_FRAG_LEN, info->len) |
   468				      FIELD_PREP(IRDMA_UDA_QPSQ_VALID, qp->qp_uk.swqe_polarity));
   469		} else {
   470			hdr[0] = FIELD_PREP(IRDMA_UDA_QPSQ_MACLEN, info->maclen >> 1) |
   471				 FIELD_PREP(IRDMA_UDA_QPSQ_IPLEN, iplen) |
   472				 FIELD_PREP(IRDMA_UDA_QPSQ_L4T, 1) |
   473				 FIELD_PREP(IRDMA_UDA_QPSQ_IIPT, iipt) |
   474				 FIELD_PREP(IRDMA_GEN1_UDA_QPSQ_L4LEN, l4len);
   475	
   476			hdr[1] = FIELD_PREP(IRDMA_UDA_QPSQ_OPCODE, IRDMA_OP_TYPE_SEND) |
   477				 FIELD_PREP(IRDMA_UDA_QPSQ_SIGCOMPL, 1) |
   478				 FIELD_PREP(IRDMA_UDA_QPSQ_DOLOOPBACK, info->do_lpb) |
   479				 FIELD_PREP(IRDMA_UDA_QPSQ_VALID, qp->qp_uk.swqe_polarity);
   480	
   481			/* Forth line of WQE descriptor */
   482	
   483			set_64bit_val(wqe, 0, info->paddr);
   484			set_64bit_val(wqe, 8,
   485				      FIELD_PREP(IRDMAQPSQ_GEN1_FRAG_LEN, info->len));
   486		}
   487	
   488		set_64bit_val(wqe, 16, hdr[0]);
   489		dma_wmb(); /* make sure WQE is written before valid bit is set */
   490	
   491		set_64bit_val(wqe, 24, hdr[1]);
   492	
   493		print_hex_dump_debug("PUDA: PUDA SEND WQE", DUMP_PREFIX_OFFSET, 16, 8,
   494				     wqe, 32, false);
   495		irdma_uk_qp_post_wr(&qp->qp_uk);
   496		return 0;
   497	}
   498	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

