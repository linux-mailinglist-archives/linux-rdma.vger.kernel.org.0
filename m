Return-Path: <linux-rdma+bounces-14223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 012D7C2F542
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 06:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A03B94E1C8B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 05:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542C429B8E6;
	Tue,  4 Nov 2025 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGDhMGbk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA31F3D56
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232413; cv=none; b=mjpQ1X6egnkbrRHf2C3XfEGkikJCCMkpQ9iu4YuZm6v+WdK2PIUb+XiGMkQIc5aodKlAdjsU5ns5cXOhaXcT87XSlOU1gcrJv6878gG7/qCXDGW5kKt9bdhsdpNXnnicLMQaqRu2JC0lOG4UO9GH6biQLB0J9r31tRO9BfgnxZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232413; c=relaxed/simple;
	bh=W1xtXW54byq/p+XNvi7L8e4LWDWnHB1mEAV8mLA87FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP2MAkCjCIwe6TVR8b25ml1hmbQILj71RbKosJE893A4qqwMNQ2vJHyu/pMzQZPzzzhfLW/KH0/yENKKU/ZJ8/Ta1Rjqjp6PoIq0xdAyAUHxkvwT8pe3pX7/mlvUdxrH0VgACIVETe5kX+6seKnCI/18EgaNkFlxaUkWUG53KAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGDhMGbk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762232411; x=1793768411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W1xtXW54byq/p+XNvi7L8e4LWDWnHB1mEAV8mLA87FU=;
  b=QGDhMGbkgBXORIxISdQndufRNZkRhXSpotZobTANvZ5IOyEZ0tfiyNlc
   P3S19i8LNWhlu8rtF9O7ne+TUz+fMmfQ6VM1LyQiA0QGk+xoSvWwu6n/o
   ZPOVIaPbt6XtKLpJsh7DtIoYOyT4iaahP6ejqmtAMjUit2OviFFmjug5s
   jcPsTM6Q9L4DcbVF1FE5CTq+RkOqnfE+ocXCRcQm/BQzS0VjwKbojOVn3
   CFbl0+gAwwT6Y5XERc3RfjKqAxRo0Q5lyvwrR2sVmFe6TB/tFnyrCIe64
   mYXOamTgWinijcdAbDIwZ8fhdIpsa+PPQDuuUamnYK6zpJR80svsWrzmi
   A==;
X-CSE-ConnectionGUID: 3KEt7cG6R0u5kHCAxw+mJA==
X-CSE-MsgGUID: rpH9BRGEScyD1hq123lJdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75429927"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="75429927"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 21:00:10 -0800
X-CSE-ConnectionGUID: 6gCF1YDUS0WwoIIIeq4ZcA==
X-CSE-MsgGUID: sNvM6ZIBTziv+OO2Si70YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="191403544"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 03 Nov 2025 21:00:09 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vG97s-000Qv2-2Y;
	Tue, 04 Nov 2025 04:59:12 +0000
Date: Tue, 4 Nov 2025 12:58:26 +0800
From: kernel test robot <lkp@intel.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	leon@kernel.org, jgg@ziepe.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH rdma-next 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ and
 QP verbs
Message-ID: <202511041217.opx35mPp-lkp@intel.com>
References: <20251103105033.205586-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103105033.205586-5-sriharsha.basavapatna@broadcom.com>

Hi Sriharsha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.18-rc4 next-20251103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sriharsha-Basavapatna/RDMA-bnxt_re-Move-the-UAPI-methods-to-a-dedicated-file/20251103-190151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20251103105033.205586-5-sriharsha.basavapatna%40broadcom.com
patch subject: [PATCH rdma-next 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251104/202511041217.opx35mPp-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511041217.opx35mPp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511041217.opx35mPp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/bnxt_re/dv.c: In function 'bnxt_re_handler_BNXT_RE_METHOD_DBR_QUERY':
   drivers/infiniband/hw/bnxt_re/dv.c:635:29: warning: variable 'rdev' set but not used [-Wunused-but-set-variable]
     635 |         struct bnxt_re_dev *rdev;
         |                             ^~~~
   drivers/infiniband/hw/bnxt_re/dv.c: In function 'bnxt_re_dv_init_user_qp':
>> drivers/infiniband/hw/bnxt_re/dv.c:1105:34: warning: variable 'cntx' set but not used [-Wunused-but-set-variable]
    1105 |         struct bnxt_re_ucontext *cntx;
         |                                  ^~~~


vim +/cntx +1105 drivers/infiniband/hw/bnxt_re/dv.c

  1093	
  1094	static int bnxt_re_dv_init_user_qp(struct bnxt_re_dev *rdev,
  1095					   struct ib_ucontext *context,
  1096					   struct bnxt_re_qp *qp,
  1097					   struct bnxt_re_srq *srq,
  1098					   struct bnxt_re_dv_create_qp_req *init_attr,
  1099					   struct bnxt_re_dv_umem *sq_umem,
  1100					   struct bnxt_re_dv_umem *rq_umem)
  1101	{
  1102		struct bnxt_qplib_sg_info *sginfo;
  1103		struct bnxt_re_dv_umem *dv_umem;
  1104		struct bnxt_qplib_qp *qplib_qp;
> 1105		struct bnxt_re_ucontext *cntx;
  1106		struct ib_umem *umem;
  1107		int rc = -EINVAL;
  1108	
  1109		if (!sq_umem || (!srq && !rq_umem))
  1110			return rc;
  1111	
  1112		qplib_qp = &qp->qplib_qp;
  1113		cntx = container_of(context, struct bnxt_re_ucontext, ib_uctx);
  1114		qplib_qp->qp_handle = init_attr->qp_handle;
  1115		sginfo = &qplib_qp->sq.sg_info;
  1116	
  1117		/* SQ */
  1118		dv_umem = bnxt_re_dv_umem_get(rdev, context, sq_umem,
  1119					      init_attr->sq_umem_offset,
  1120					      init_attr->sq_len, sginfo);
  1121		if (IS_ERR(dv_umem)) {
  1122			rc = PTR_ERR(dv_umem);
  1123			dev_err(rdev_to_dev(rdev), "%s: bnxt_re_dv_umem_get() failed! rc = %d\n",
  1124				__func__, rc);
  1125			return rc;
  1126		}
  1127		qp->sq_umem = dv_umem;
  1128		qp->sumem = dv_umem->umem;
  1129		dev_dbg(rdev_to_dev(rdev),
  1130			"%s: umem: 0x%llx npages: %d page_size: %d page_shift: %d\n",
  1131			__func__, (u64)umem, sginfo->npages, sginfo->pgsize, sginfo->pgshft);
  1132	
  1133		/* SRQ */
  1134		if (srq) {
  1135			qplib_qp->srq = &srq->qplib_srq;
  1136			goto done;
  1137		}
  1138	
  1139		/* RQ */
  1140		sginfo = &qplib_qp->rq.sg_info;
  1141		dv_umem = bnxt_re_dv_umem_get(rdev, context, rq_umem,
  1142					      init_attr->rq_umem_offset,
  1143					      init_attr->rq_len, sginfo);
  1144		if (IS_ERR(dv_umem)) {
  1145			rc = PTR_ERR(dv_umem);
  1146			dev_err(rdev_to_dev(rdev), "%s: bnxt_re_dv_umem_get() failed! rc = %d\n",
  1147				__func__, rc);
  1148			goto rqfail;
  1149		}
  1150		qp->rq_umem = dv_umem;
  1151		qp->rumem = dv_umem->umem;
  1152		dev_dbg(rdev_to_dev(rdev),
  1153			"%s: umem: 0x%llx npages: %d page_size: %d page_shift: %d\n",
  1154			__func__, (u64)umem, sginfo->npages, sginfo->pgsize, sginfo->pgshft);
  1155	
  1156	done:
  1157		qplib_qp->is_user = true;
  1158		return 0;
  1159	rqfail:
  1160		ib_umem_release(qp->sumem);
  1161		kfree(qp->sq_umem);
  1162		qplib_qp->sq.sg_info.umem = NULL;
  1163		return rc;
  1164	}
  1165	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

