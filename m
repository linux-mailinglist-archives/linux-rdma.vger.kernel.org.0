Return-Path: <linux-rdma+bounces-17571-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPvZD7tdqmkVQQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17571-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 05:53:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E325521B8AE
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 05:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72BF930338AA
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 04:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B792337BBC;
	Fri,  6 Mar 2026 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDrmTChI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB202BE048
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772772782; cv=none; b=Mkn8xnwt6Ffvtaj1xVWpSlHQTXZObX05reehX5CTwDPfQkG2VcA5bvx52o/x02CUZVgbQdZZRmr2cB5qDeGApFw5Tmvp9lPOsHYzSNOwwmsjigMTgN6go4vO7ZDecX6ZApoZnRjcfXNEAwk5/qJNBy/65AXgRavRrJ1R7y/vrvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772772782; c=relaxed/simple;
	bh=YmayjqeoeBzN6EAo79bnD+2H2/jvhVtSXZqsTRn7F/8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B4ozFLFlv2wLOsBNpwutIbrFdL1o5nl8okQZsMfBF6NaN+4LoQn3yA98QT34FR/EaB+IEYftwTqORjNu3TQ3nocyR8U1DFKnLZEeL6s0GAZnv7U5puGOvlXV0rQiNeO9fZeJZL5HCV3qLP7BgfwGEOZqnM6moE244qaSh4iY1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDrmTChI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772772780; x=1804308780;
  h=date:from:to:cc:subject:message-id;
  bh=YmayjqeoeBzN6EAo79bnD+2H2/jvhVtSXZqsTRn7F/8=;
  b=TDrmTChI0So3C58J56TDUMQkdkmdYgYCo+CqD2DRPdArxOua3S54bCaL
   VxMz6/gQWx56vwUuGmvwgn2DbPwbN9ro7rAo7eMgi6rciUps1Wk3oyoVL
   oIkvhDHcR5URgOf6dOe/ve8qOJvTU4InxgLz/stHsLed/srG0MHDBH385
   C51uH5iLE4eaFdojEZSusVId2bMCidX0EKtEu4uY9D628TRx+1lGLbP94
   h7RI3VF76uvHPVRAZMLgRQ8DJYf1yiYTx9iOdhxD3lcxr9cf+nNasa04k
   ejm50Z4QkvHc0kWq2p3SyFNYYW0VgvKABHbqL0GugykRy0/ecKhhk4TQT
   g==;
X-CSE-ConnectionGUID: kj4yj2MXR8e8wUZPFgJqxQ==
X-CSE-MsgGUID: iS9u1HMyQK+vwPbvz950ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73952112"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73952112"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 20:52:59 -0800
X-CSE-ConnectionGUID: zeXZLJGwSFWQBJP1Wo4cNw==
X-CSE-MsgGUID: Bx9N5QUcQPiz/pRhODe7VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="218854225"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 05 Mar 2026 20:52:57 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyNBD-000000002C5-0qsM;
	Fri, 06 Mar 2026 04:52:51 +0000
Date: Fri, 06 Mar 2026 05:52:07 +0100
From: kernel test robot <lkp@intel.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [rdma:wip/jgg-for-next 18/19]
 drivers/infiniband/hw/bnxt_re/ib_verbs.c:3478:37: warning: variable 'cctx'
 set but not used
Message-ID: <202603060549.g4df8HXz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: E325521B8AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17571-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
head:   7f022cadde7e1fa6e5f7abac05e01bdcff5e19a3
commit: 387f31e96d46cd6ba0cf6b2439c367440f60255f [18/19] RDMA/bnxt_re: Separate kernel and user CQ creation paths
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260306/202603060549.g4df8HXz-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603060549.g4df8HXz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603060549.g4df8HXz-lkp@intel.com/

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

