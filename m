Return-Path: <linux-rdma+bounces-15566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9332D210FA
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 20:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45EAB3018F6C
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39933C187;
	Wed, 14 Jan 2026 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRXEF3GG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893FE2D0C9A
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419622; cv=none; b=IQ2N9EKwQqcXN3H5Un8H9ITuIWTTCPJv82axFq20rpJLU5H3drzbsHBIUB8f5ovLDIhHFzGVfA5ccNaTn+OhHK4/ZiThisYnSeaJEKabpqZOFwkZhI9qLt9bdhg6Wd49Ndl6t6RA5SHdB/Y86BfSygNFUMDvftd2hwqp3hWNZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419622; c=relaxed/simple;
	bh=UQoSRSUJq1fJdRS4oTVdfqsPc/Q3oltC4Vc6RTrMgtk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UprKukc7cD/anqSE8jwJ5GSOFCsx95NczkGTza/ulsj6AmTCUGqIEtLCnbE8TUZHIRFiKPFJcW2gOjzEzLDCNr2TFUQdZXdgdV86YtVijqSjNcISMB7mLBULyKhi5lKG9jWtEIPYoCqjRiMW2l4U3KO1Mb6kqJRbD2TE89wFn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRXEF3GG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768419621; x=1799955621;
  h=date:from:to:cc:subject:message-id;
  bh=UQoSRSUJq1fJdRS4oTVdfqsPc/Q3oltC4Vc6RTrMgtk=;
  b=TRXEF3GGE+oso/Ppj5cUMnSO0mc0FQ5vcHYMUM9Ja4BXh5ttrGcXNgf3
   NdN+6VAkMY/gQTCIk36fuMwosef+C8Wy6bVqMhuuBRRx5pHAc95hTIAjF
   yBEqRVophgjjJVmR2WkRwg23xJoAJ2sJCjgmfVTioDZDMCiZBasuykKHE
   Io3ZGdxgkcYRFyiGxe3/WjNEmCxPtZ+UN61Zq9PjS/3ZIfHnniYSSN0JD
   YiswfnYrwnPUs5cv+D1vfl0A0cy1f/+vnzvzL5/HNZvbgwb46PvdlU+VQ
   yAVUVofFjm3B200RlSwfiyD64gSA2kpYeop9cgfPpkfBqF/nxsxiOqVuo
   g==;
X-CSE-ConnectionGUID: Bhv50iGARtm92k7zKMgj2Q==
X-CSE-MsgGUID: gm9ghC5OThOBXJYc/mBkPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69812146"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69812146"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 11:40:20 -0800
X-CSE-ConnectionGUID: XtuY3qDQRLqVn9Js/QufBw==
X-CSE-MsgGUID: Dxsv3r6uS4qDbiHs2XEYBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204550715"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Jan 2026 11:40:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vg6j0-00000000GvS-28nN;
	Wed, 14 Jan 2026 19:40:14 +0000
Date: Thu, 15 Jan 2026 03:39:52 +0800
From: kernel test robot <lkp@intel.com>
To: Chengchang Tang <tangchengchang@huawei.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>,
 Junxian Huang <huangjunxian6@hisilicon.com>
Subject: [rdma:wip/leon-for-next 30/32]
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c:964:6: warning: no previous
 prototype for function 'hns_roce_v2_drain_rq'
Message-ID: <202601150334.jRDP5xSy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
head:   c6b61cad07189d4556a968a305056263b73025f4
commit: cfa74ad31baad3027410b6e75c8e47092aef8d97 [30/32] RDMA/hns: Support drain SQ and RQ
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260115/202601150334.jRDP5xSy-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601150334.jRDP5xSy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601150334.jRDP5xSy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:964:6: warning: no previous prototype for function 'hns_roce_v2_drain_rq' [-Wmissing-prototypes]
   void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
        ^
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:964:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
   ^
   static 
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1001:6: warning: no previous prototype for function 'hns_roce_v2_drain_sq' [-Wmissing-prototypes]
   void hns_roce_v2_drain_sq(struct ib_qp *ibqp)
        ^
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1001:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void hns_roce_v2_drain_sq(struct ib_qp *ibqp)
   ^
   static 
   2 warnings generated.


vim +/hns_roce_v2_drain_rq +964 drivers/infiniband/hw/hns/hns_roce_hw_v2.c

   963	
 > 964	void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
   965	{
   966		struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
   967		struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
   968		struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
   969		struct hns_roce_drain_cqe rdrain = {};
   970		const struct ib_recv_wr *bad_rwr;
   971		struct ib_cq *cq = ibqp->recv_cq;
   972		struct ib_recv_wr rwr = {};
   973		int ret;
   974	
   975		ret = ib_modify_qp(ibqp, &attr, IB_QP_STATE);
   976		if (ret && hr_dev->state < HNS_ROCE_DEVICE_STATE_RST_DOWN) {
   977			ibdev_err_ratelimited(&hr_dev->ib_dev,
   978					      "failed to modify qp during drain rq, ret = %d.\n",
   979					      ret);
   980			return;
   981		}
   982	
   983		rwr.wr_cqe = &rdrain.cqe;
   984		rdrain.cqe.done = hns_roce_drain_qp_done;
   985		init_completion(&rdrain.done);
   986	
   987		if (hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN)
   988			ret = hns_roce_push_drain_wr(&hr_qp->rq, cq, rwr.wr_id);
   989		else
   990			ret = hns_roce_v2_post_recv(ibqp, &rwr, &bad_rwr);
   991		if (ret) {
   992			ibdev_err_ratelimited(&hr_dev->ib_dev,
   993					      "failed to post recv for drain rq, ret = %d.\n",
   994					      ret);
   995			return;
   996		}
   997	
   998		handle_drain_completion(cq, &rdrain, hr_dev);
   999	}
  1000	
> 1001	void hns_roce_v2_drain_sq(struct ib_qp *ibqp)
  1002	{
  1003		struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
  1004		struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
  1005		struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
  1006		struct hns_roce_drain_cqe sdrain = {};
  1007		const struct ib_send_wr *bad_swr;
  1008		struct ib_cq *cq = ibqp->send_cq;
  1009		struct ib_rdma_wr swr = {
  1010			.wr = {
  1011				.next = NULL,
  1012				{ .wr_cqe	= &sdrain.cqe, },
  1013				.opcode	= IB_WR_RDMA_WRITE,
  1014			},
  1015		};
  1016		int ret;
  1017	
  1018		ret = ib_modify_qp(ibqp, &attr, IB_QP_STATE);
  1019		if (ret && hr_dev->state < HNS_ROCE_DEVICE_STATE_RST_DOWN) {
  1020			ibdev_err_ratelimited(&hr_dev->ib_dev,
  1021					      "failed to modify qp during drain sq, ret = %d.\n",
  1022					      ret);
  1023			return;
  1024		}
  1025	
  1026		sdrain.cqe.done = hns_roce_drain_qp_done;
  1027		init_completion(&sdrain.done);
  1028	
  1029		if (hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN)
  1030			ret = hns_roce_push_drain_wr(&hr_qp->sq, cq, swr.wr.wr_id);
  1031		else
  1032			ret = hns_roce_v2_post_send(ibqp, &swr.wr, &bad_swr);
  1033		if (ret) {
  1034			ibdev_err_ratelimited(&hr_dev->ib_dev,
  1035					      "failed to post send for drain sq, ret = %d.\n",
  1036					      ret);
  1037			return;
  1038		}
  1039	
  1040		handle_drain_completion(cq, &sdrain, hr_dev);
  1041	}
  1042	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

