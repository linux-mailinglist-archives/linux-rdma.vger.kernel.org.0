Return-Path: <linux-rdma+bounces-17582-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOudDBajqml6UwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17582-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 10:49:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F8921E360
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6510D30143D5
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09223161A1;
	Fri,  6 Mar 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6Ts951f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88F2405E7
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772790508; cv=none; b=Wb9x9DLTzVl9HcDIBp2yCQ5tXy62HzJoZ5JuCYcUxqx9w7Bb+dMfXL1N+x02TX7ihSP/ni6+3j8hhF3MZ6xbHzQSDm36dxGGJB3swIQw0hOFFguc8CYyAXn689Gv1nWxj76Ai60SgZRBv+QustqdjTdIXONolAQQPgKgZB+IA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772790508; c=relaxed/simple;
	bh=X8QWYQ/DuwUBOjGJrUj3uL+TILqLlyY4xhadOSv6aX8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SYxWsDov0ZANMRWvbRIorAYgoK4GnEP9KBzoSaNqtpVLjfdTIaDVy+36L44ie4OfiDdXLTH6BGxsm+/gPb0eSI8xaHO1wtThDnx68vpagNQb+S2DTDCr6Fvq1e8ljETRi5KpqtCHeKhskmu9rz+vNzQkLJ4z2rzhR0RmHUxFNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6Ts951f; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772790507; x=1804326507;
  h=date:from:to:cc:subject:message-id;
  bh=X8QWYQ/DuwUBOjGJrUj3uL+TILqLlyY4xhadOSv6aX8=;
  b=c6Ts951fWW0ELEnSl4v1cQ/LLe1yg/a+DC8SUuy0zziita4rk8lvzZ7V
   p8LD5XFgT6iwA/ewThjIRR6QooogEuJqTCHoHBeosyBOXSiscJjclpHD0
   piIMfQhhQnxWqdDOu/5VzKlP0j9WVr2iYjV/JwSMvi7sY4/6BDPsLE2SF
   bfNFKW0mXIOjvlWwBkSabXWVPUHv2F6VO165VfVLvMtFMIsfEh7QoYJ7g
   tB7mDAMm0n5v77l1Q5GSyZaeQUAlVkyAm3v8oOtLU1PS67NrBb2/mlkoP
   NXzsCJjtROMHU1SA8LbwS7SVpkCAo+PNXF4KuGbtfmhEI6n25frSZFovB
   A==;
X-CSE-ConnectionGUID: ughKKem8QkGJ3KHcx0oViQ==
X-CSE-MsgGUID: X3IMHAuBS9qxx61wOcL3EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73798264"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73798264"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 01:48:26 -0800
X-CSE-ConnectionGUID: KT43cwHiT2SGxzWM7RZ1Gw==
X-CSE-MsgGUID: x0ZG5TfkQeKp842fmrGFaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223449214"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Mar 2026 01:48:24 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyRnA-000000000fd-30Bf;
	Fri, 06 Mar 2026 09:48:20 +0000
Date: Fri, 06 Mar 2026 17:47:56 +0800
From: kernel test robot <lkp@intel.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [rdma:wip/jgg-for-next 18/19]
 drivers/infiniband/hw/bnxt_re/ib_verbs.c:3478:37: warning: variable 'cctx'
 set but not used
Message-ID: <202603061700.LqCpNTpI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A4F8921E360
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17582-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
head:   7f022cadde7e1fa6e5f7abac05e01bdcff5e19a3
commit: 387f31e96d46cd6ba0cf6b2439c367440f60255f [18/19] RDMA/bnxt_re: Separate kernel and user CQ creation paths
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260306/202603061700.LqCpNTpI-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603061700.LqCpNTpI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603061700.LqCpNTpI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_create_cq':
>> drivers/infiniband/hw/bnxt_re/ib_verbs.c:3478:37: warning: variable 'cctx' set but not used [-Wunused-but-set-variable]
    3478 |         struct bnxt_qplib_chip_ctx *cctx;
         |                                     ^~~~


vim +/cctx +3478 drivers/infiniband/hw/bnxt_re/ib_verbs.c

  3468	
  3469	int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
  3470			      struct uverbs_attr_bundle *attrs)
  3471	{
  3472		struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
  3473		struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
  3474		struct ib_udata *udata = &attrs->driver_udata;
  3475		struct bnxt_re_ucontext *uctx =
  3476			rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
  3477		struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
> 3478		struct bnxt_qplib_chip_ctx *cctx;
  3479		int cqe = attr->cqe;
  3480		int rc, entries;
  3481		u32 active_cqs;
  3482	
  3483		if (udata)
  3484			return bnxt_re_create_user_cq(ibcq, attr, attrs);
  3485	
  3486		if (attr->flags)
  3487			return -EOPNOTSUPP;
  3488	
  3489		/* Validate CQ fields */
  3490		if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
  3491			ibdev_err(&rdev->ibdev, "Failed to create CQ -max exceeded");
  3492			return -EINVAL;
  3493		}
  3494	
  3495		cq->rdev = rdev;
  3496		cctx = rdev->chip_ctx;
  3497		cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
  3498	
  3499		entries = bnxt_re_init_depth(cqe + 1, uctx);
  3500		if (entries > dev_attr->max_cq_wqes + 1)
  3501			entries = dev_attr->max_cq_wqes + 1;
  3502	
  3503		cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
  3504		cq->cql = kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
  3505				  GFP_KERNEL);
  3506		if (!cq->cql)
  3507			return -ENOMEM;
  3508	
  3509		cq->qplib_cq.sg_info.pgsize = SZ_4K;
  3510		cq->qplib_cq.sg_info.pgshft = __builtin_ctz(SZ_4K);
  3511		cq->qplib_cq.dpi = &rdev->dpi_privileged;
  3512		cq->qplib_cq.max_wqe = entries;
  3513		cq->qplib_cq.coalescing = &rdev->cq_coalescing;
  3514		cq->qplib_cq.nq = bnxt_re_get_nq(rdev);
  3515		cq->qplib_cq.cnq_hw_ring_id = cq->qplib_cq.nq->ring_id;
  3516	
  3517		rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
  3518		if (rc) {
  3519			ibdev_err(&rdev->ibdev, "Failed to create HW CQ");
  3520			goto fail;
  3521		}
  3522	
  3523		cq->ib_cq.cqe = entries;
  3524		cq->cq_period = cq->qplib_cq.period;
  3525		active_cqs = atomic_inc_return(&rdev->stats.res.cq_count);
  3526		if (active_cqs > rdev->stats.res.cq_watermark)
  3527			rdev->stats.res.cq_watermark = active_cqs;
  3528		spin_lock_init(&cq->cq_lock);
  3529	
  3530		return 0;
  3531	
  3532	fail:
  3533		kfree(cq->cql);
  3534		return rc;
  3535	}
  3536	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

