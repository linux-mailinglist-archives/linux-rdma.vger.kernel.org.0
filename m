Return-Path: <linux-rdma+bounces-1852-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D21E89C976
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 18:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0A91C239C6
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45A1422CD;
	Mon,  8 Apr 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfVzp+9p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C81422C5
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592891; cv=none; b=OFhcL+KZhwu+Lk50YHzAbLlz0GfYQk5HrrLUjr1N0GrnnTvlY7JEv071rFyzCupLNbDKTiUSD+AoCPhaWpQksExVYeYtCA57WH0Fk+ql6NJPYruntEbmVUbBpGeYfsyJcQGD66KPiQLQbT88l0CQswLP8rozEdtuN2TIbpkdm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592891; c=relaxed/simple;
	bh=RjI/a3KrKDXwhD04HHvyR3Ga7iSbXO1+WyN5sVNq8OI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K4rmw7AHvuOJLvTIk9No3/XqhmLVnwGTsvsAvHm/zC5jYVY8SZpHTFiUdue+zLTfKgmvGwrWqws5o5ANiD3GKiFyT4uOdlb7iKTq1NnXXF7fCeo7hihK+BvFmESiJhxA1qLThzXCAtX7lj8n93LnRQabE6F/KzSNOlSNvZAwngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfVzp+9p; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712592891; x=1744128891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RjI/a3KrKDXwhD04HHvyR3Ga7iSbXO1+WyN5sVNq8OI=;
  b=CfVzp+9p6GXsVgWQ4EuldmD63x4dxNmMGjMtxnwlnX0QMe8adc4ki9LA
   +8WvdWNqn+0qJ8rmlE0F25G1ZhxQ7d5N62ZcXqbk2pVQaRginy9Bke3em
   aYN7oRKioQ7MQgNhtT2d4EgDFFlAu2CVLokKZcVuBHtUJk5juVTWOrjR9
   vw7LEvFJr3e/F9UgosZXpsLYHjWiFQ9CfBSlO1TxWL65xq0OEtP4JUo9v
   6CbcKifFYbDFwEZbN7L1HMLCQxb+JkGQcSZFnS/n4IUInA4RFxIIwWcnN
   z9blz468o40p8P4mVb0DFmmMzlKHO3qyO58sHHHdyQJ1P6fFjgboD+vLd
   w==;
X-CSE-ConnectionGUID: CZO4nyTdRN+aMcTR0emv3w==
X-CSE-MsgGUID: 2q1IeI7ISuSoO1fshaRhmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8042328"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8042328"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:14:50 -0700
X-CSE-ConnectionGUID: ezjS66lvQRmYRgVFfh7EXg==
X-CSE-MsgGUID: 139/slmcSoOYWOulfCfTOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19882051"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Apr 2024 09:14:47 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtrdt-0005Kk-1F;
	Mon, 08 Apr 2024 16:14:45 +0000
Date: Tue, 9 Apr 2024 00:14:20 +0800
From: kernel test robot <lkp@intel.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: oe-kbuild-all@lists.linux.dev, Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>
Subject: [rdma:wip/leon-for-next 12/12]
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c:4864:13: warning: unused variable
 'sl_num'
Message-ID: <202404090005.YRqvDvXD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
head:   c3236d538646c8e333370d71cb1d1e37e8996eaf
commit: c3236d538646c8e333370d71cb1d1e37e8996eaf [12/12] RDMA/hns: Support DSCP
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240409/202404090005.YRqvDvXD-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240409/202404090005.YRqvDvXD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404090005.YRqvDvXD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function 'hns_roce_set_sl':
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:4864:13: warning: unused variable 'sl_num' [-Wunused-variable]
    4864 |         u32 sl_num;
         |             ^~~~~~
--
   drivers/infiniband/hw/hns/hns_roce_ah.c: In function 'hns_roce_create_ah':
>> drivers/infiniband/hw/hns/hns_roce_ah.c:65:13: warning: unused variable 'max_sl' [-Wunused-variable]
      65 |         u32 max_sl;
         |             ^~~~~~


vim +/sl_num +4864 drivers/infiniband/hw/hns/hns_roce_hw_v2.c

  4854	
  4855	static int hns_roce_set_sl(struct ib_qp *ibqp,
  4856				   const struct ib_qp_attr *attr,
  4857				   struct hns_roce_v2_qp_context *context,
  4858				   struct hns_roce_v2_qp_context *qpc_mask)
  4859	{
  4860		const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
  4861		struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
  4862		struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
  4863		struct ib_device *ibdev = &hr_dev->ib_dev;
> 4864		u32 sl_num;
  4865		int ret;
  4866	
  4867		ret = hns_roce_hw_v2_get_dscp(hr_dev, get_tclass(&attr->ah_attr.grh),
  4868					      &hr_qp->tc_mode, &hr_qp->priority);
  4869		if (ret && ret != -EOPNOTSUPP &&
  4870		    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
  4871			ibdev_err_ratelimited(ibdev,
  4872					      "failed to get dscp, ret = %d.\n", ret);
  4873			return ret;
  4874		}
  4875	
  4876		if (hr_qp->tc_mode == HNAE3_TC_MAP_MODE_DSCP &&
  4877		    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
  4878			hr_qp->sl = hr_qp->priority;
  4879		else
  4880			hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
  4881	
  4882		if (!check_sl_valid(hr_dev, hr_qp->sl))
  4883			return -EINVAL;
  4884	
  4885		hr_reg_write(context, QPC_SL, hr_qp->sl);
  4886		hr_reg_clear(qpc_mask, QPC_SL);
  4887	
  4888		return 0;
  4889	}
  4890	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

