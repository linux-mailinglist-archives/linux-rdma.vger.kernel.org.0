Return-Path: <linux-rdma+bounces-4406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DE7955C43
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2024 13:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026A61C209CE
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2024 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCC117C60;
	Sun, 18 Aug 2024 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4CFGP/l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1859443
	for <linux-rdma@vger.kernel.org>; Sun, 18 Aug 2024 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723979111; cv=none; b=YleOVbH4gMzkJsEVy3ki2tNuhGP/F1hGdfrU/TLGMVYvwP0A9EMTn85btWsFMLnw8GebAGi40qTFRwvcjddJpS7fB85J6yThiBAB7mi5I4tWPwQG+cPalmmyzzlbCBKqMncY/dLkl4IdlXztPwbfrkOvZ3kDCTDZ3qzniztF/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723979111; c=relaxed/simple;
	bh=MHjdPHpr7cXcUSHEna3tL7Dl0u3iD4j9Pne1UYTNsGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/dkOiPIzoZ5FtTdltK9RqlAsywp9oxUcpBk2OrTh9630P5fDaWkwVKsCXVMcmtMErr3XSM7VLHX2U5fJ7T8vx9vEOiKC7WBF23xj6CW7w8kGhkoxUGtOgsRqPhetmsYa9YqjcT25bdLwJq3ELOpJ/MHgoYKn89HQcEASOoZ2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4CFGP/l; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723979109; x=1755515109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MHjdPHpr7cXcUSHEna3tL7Dl0u3iD4j9Pne1UYTNsGU=;
  b=G4CFGP/lDlOkVzjLXJrucQYzUL1U0+NGx20l6iwukk4J0tnJDljhPxgv
   4b2yUULW62hbER4t8ZXjgz5HG/+Grt1KMM3hiOBf5tXGoMOtoPtqGPrk+
   OTSnbYwrE/1F2J13F8VXM8fuWpNuibWBGkgpbMVVFtDQMUjAhv3Pi0BnW
   cDDrUjUrzRsQXL087jYSZzuTkjBGm1ZGmQey8BqRq49ckERndgK/J2Sr4
   QUJFJBaPpnJTlZNQh4HybST3eMVaX1T2Rist2pXgvCI/0AToVxSDX2bTf
   vD+q2w7NrCX1mQiO94QuG8z0B0odnr/FS9Dmj2h6t/2sGJxEobYHkLjHM
   g==;
X-CSE-ConnectionGUID: eNSoKoJCQXm91WcV9v/P8A==
X-CSE-MsgGUID: fou/f/IjTdq+o0sDTlPUow==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="22372748"
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="22372748"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 04:05:09 -0700
X-CSE-ConnectionGUID: 0YsMYXRWS3SjvUdmFIaTmA==
X-CSE-MsgGUID: c2EoetvURQS9o8ra4a6MkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="59813644"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Aug 2024 04:05:06 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfdia-0008CI-1s;
	Sun, 18 Aug 2024 11:05:04 +0000
Date: Sun, 18 Aug 2024 19:04:58 +0800
From: kernel test robot <lkp@intel.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org,
	jgg@ziepe.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: Re: [PATCH for-next v2 2/4] RDMA/bnxt_re: Get the WQE index from
 slot index while completing the WQEs
Message-ID: <202408181809.Sed4EJbs-lkp@intel.com>
References: <1723621322-6920-3-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723621322-6920-3-git-send-email-selvin.xavier@broadcom.com>

Hi Selvin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Selvin-Xavier/RDMA-bnxt_re-Add-support-for-Variable-WQE-in-Genp7-adapters/20240814-223609
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/1723621322-6920-3-git-send-email-selvin.xavier%40broadcom.com
patch subject: [PATCH for-next v2 2/4] RDMA/bnxt_re: Get the WQE index from slot index while completing the WQEs
config: sparc64-randconfig-r112-20240818 (https://download.01.org/0day-ci/archive/20240818/202408181809.Sed4EJbs-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240818/202408181809.Sed4EJbs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408181809.Sed4EJbs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/infiniband/hw/bnxt_re/qplib_fp.c:2530:64: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] cqe_slot @@     got restricted __le16 [usertype] sq_cons_idx @@
   drivers/infiniband/hw/bnxt_re/qplib_fp.c:2530:64: sparse:     expected unsigned int [usertype] cqe_slot
   drivers/infiniband/hw/bnxt_re/qplib_fp.c:2530:64: sparse:     got restricted __le16 [usertype] sq_cons_idx
   drivers/infiniband/hw/bnxt_re/qplib_fp.c: note: in included file (through include/linux/smp.h, include/linux/alloc_tag.h, include/linux/percpu.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +2530 drivers/infiniband/hw/bnxt_re/qplib_fp.c

  2499	
  2500	static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
  2501					     struct cq_req *hwcqe,
  2502					     struct bnxt_qplib_cqe **pcqe, int *budget,
  2503					     u32 cq_cons, struct bnxt_qplib_qp **lib_qp)
  2504	{
  2505		struct bnxt_qplib_swq *swq;
  2506		struct bnxt_qplib_cqe *cqe;
  2507		struct bnxt_qplib_qp *qp;
  2508		struct bnxt_qplib_q *sq;
  2509		u32 cqe_sq_cons;
  2510		int cqe_cons;
  2511		int rc = 0;
  2512	
  2513		qp = (struct bnxt_qplib_qp *)((unsigned long)
  2514					      le64_to_cpu(hwcqe->qp_handle));
  2515		if (!qp) {
  2516			dev_err(&cq->hwq.pdev->dev,
  2517				"FP: Process Req qp is NULL\n");
  2518			return -EINVAL;
  2519		}
  2520		sq = &qp->sq;
  2521	
  2522		cqe_sq_cons = le16_to_cpu(hwcqe->sq_cons_idx) % sq->max_sw_wqe;
  2523		if (qp->sq.flushed) {
  2524			dev_dbg(&cq->hwq.pdev->dev,
  2525				"%s: QP in Flush QP = %p\n", __func__, qp);
  2526			goto done;
  2527		}
  2528	
  2529		if (__is_err_cqe_for_var_wqe(qp, hwcqe->status)) {
> 2530			cqe_cons = bnxt_qplib_get_cqe_sq_cons(sq, hwcqe->sq_cons_idx);
  2531			if (cqe_cons < 0) {
  2532				dev_err(&cq->hwq.pdev->dev, "%s: Wrong SQ cons cqe_slot_indx = %d\n",
  2533					__func__, hwcqe->sq_cons_idx);
  2534				goto done;
  2535			}
  2536			cqe_sq_cons = cqe_cons;
  2537			dev_err(&cq->hwq.pdev->dev, "%s: cqe_sq_cons = %d swq_last = %d swq_start = %d\n",
  2538				__func__, cqe_sq_cons, sq->swq_last, sq->swq_start);
  2539		}
  2540	
  2541		/* Require to walk the sq's swq to fabricate CQEs for all previously
  2542		 * signaled SWQEs due to CQE aggregation from the current sq cons
  2543		 * to the cqe_sq_cons
  2544		 */
  2545		cqe = *pcqe;
  2546		while (*budget) {
  2547			if (sq->swq_last == cqe_sq_cons)
  2548				/* Done */
  2549				break;
  2550	
  2551			swq = &sq->swq[sq->swq_last];
  2552			memset(cqe, 0, sizeof(*cqe));
  2553			cqe->opcode = CQ_BASE_CQE_TYPE_REQ;
  2554			cqe->qp_handle = (u64)(unsigned long)qp;
  2555			cqe->src_qp = qp->id;
  2556			cqe->wr_id = swq->wr_id;
  2557			if (cqe->wr_id == BNXT_QPLIB_FENCE_WRID)
  2558				goto skip;
  2559			cqe->type = swq->type;
  2560	
  2561			/* For the last CQE, check for status.  For errors, regardless
  2562			 * of the request being signaled or not, it must complete with
  2563			 * the hwcqe error status
  2564			 */
  2565			if (swq->next_idx == cqe_sq_cons &&
  2566			    hwcqe->status != CQ_REQ_STATUS_OK) {
  2567				cqe->status = hwcqe->status;
  2568				dev_err(&cq->hwq.pdev->dev,
  2569					"FP: CQ Processed Req wr_id[%d] = 0x%llx with status 0x%x\n",
  2570					sq->swq_last, cqe->wr_id, cqe->status);
  2571				cqe++;
  2572				(*budget)--;
  2573				bnxt_qplib_mark_qp_error(qp);
  2574				/* Add qp to flush list of the CQ */
  2575				bnxt_qplib_add_flush_qp(qp);
  2576			} else {
  2577				/* Before we complete, do WA 9060 */
  2578				if (do_wa9060(qp, cq, cq_cons, sq->swq_last,
  2579					      cqe_sq_cons)) {
  2580					*lib_qp = qp;
  2581					goto out;
  2582				}
  2583				if (swq->flags & SQ_SEND_FLAGS_SIGNAL_COMP) {
  2584					cqe->status = CQ_REQ_STATUS_OK;
  2585					cqe++;
  2586					(*budget)--;
  2587				}
  2588			}
  2589	skip:
  2590			bnxt_qplib_hwq_incr_cons(sq->hwq.max_elements, &sq->hwq.cons,
  2591						 swq->slots, &sq->dbinfo.flags);
  2592			sq->swq_last = swq->next_idx;
  2593			if (sq->single)
  2594				break;
  2595		}
  2596	out:
  2597		*pcqe = cqe;
  2598		if (sq->swq_last != cqe_sq_cons) {
  2599			/* Out of budget */
  2600			rc = -EAGAIN;
  2601			goto done;
  2602		}
  2603		/*
  2604		 * Back to normal completion mode only after it has completed all of
  2605		 * the WC for this CQE
  2606		 */
  2607		sq->single = false;
  2608	done:
  2609		return rc;
  2610	}
  2611	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

