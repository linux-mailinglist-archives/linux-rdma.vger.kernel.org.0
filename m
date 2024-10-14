Return-Path: <linux-rdma+bounces-5399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A12999D103
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 17:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48DE1F23B03
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996481AAE02;
	Mon, 14 Oct 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip5dmjhz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C455896
	for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918580; cv=none; b=jYN78qd33aI9DZ28wZwGXCKEdvIJk3IkrLoJmuCXhuei6mqmEhjseanSsuzaWasJxTm42hnizUyQ6JuZgbAdP8tkS0cwDFQpscBqMji//laAw0kAKWLD0q2ikVAHArzMjIjdB1kX7vlkXQX/2OEBnCPT+cwErcUaRXp++vcTwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918580; c=relaxed/simple;
	bh=9qlOaP8cTmqlTHKiUFowff6pVCaIHLaoJR27d1mSYqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx786gLSxRurK6iyBU2Z7/jpuABcDqq/f/mEq1Sst1MTe4SCZo4l1fIJdZo15+dmjU1LGbmD9QkGynysHzDgPk0e3R470uH8hhrriXEgqFQv2miB7TtQo2hjniQF9Y76Cn7xrXzoLmrtWB95XsIIsbhgPC8LDnPmKzTernfSs6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip5dmjhz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728918578; x=1760454578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9qlOaP8cTmqlTHKiUFowff6pVCaIHLaoJR27d1mSYqs=;
  b=ip5dmjhzdSU6mmSPmYDgZWfg/m/arM6dxngaxFRqayrEC6Ik7KK3tzyh
   L1Qo7CG65b8ty4vAZAMnewMcjSr4aDHueAjlyqy7Xnv2OU3m+OJMu53+X
   QOLHft9yup7jqOET9sZslAM2xlzuaA5YAYjRnCnfBHPmvNvybMVvWP4S4
   v8mEokrGwJPXWHdv71+mPIaa0gbiecZbYnW5pgQzEKtfeBmu3s6W43FGj
   eX+I689RopYPVFNIdJkdDGk/EC73JYRH6XG1VhRLgMVrVrpduoq8cNHls
   b2tpIvKAJI/ekLhdduELFahWnlIPyWo+y+Jp+Ki/svUFbXnxzhs3N0fY8
   g==;
X-CSE-ConnectionGUID: goCJLd/VRtq1xTR9wdm9CA==
X-CSE-MsgGUID: SkBl80PqQU24u9NorYtoRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28413620"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28413620"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 08:09:38 -0700
X-CSE-ConnectionGUID: +0wgIEZvSiatrXUOCRM2/w==
X-CSE-MsgGUID: KI/aGEVfS2uvBInJaQCiGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="108343156"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Oct 2024 08:09:35 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0MhR-000GKK-0G;
	Mon, 14 Oct 2024 15:09:33 +0000
Date: Mon, 14 Oct 2024 23:09:08 +0800
From: kernel test robot <lkp@intel.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org,
	jgg@ziepe.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 1/4] RDMA/bnxt_re: Add support for optimized
 modify QP
Message-ID: <202410142256.J3j7bGkA-lkp@intel.com>
References: <1728623035-30657-2-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728623035-30657-2-git-send-email-selvin.xavier@broadcom.com>

Hi Selvin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.12-rc3 next-20241014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Selvin-Xavier/RDMA-bnxt_re-Add-support-for-optimized-modify-QP/20241011-133536
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/1728623035-30657-2-git-send-email-selvin.xavier%40broadcom.com
patch subject: [PATCH for-next 1/4] RDMA/bnxt_re: Add support for optimized modify QP
config: x86_64-randconfig-123-20241014 (https://download.01.org/0day-ci/archive/20241014/202410142256.J3j7bGkA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241014/202410142256.J3j7bGkA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410142256.J3j7bGkA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:910:23: sparse: sparse: invalid assignment: |=
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:910:23: sparse:    left side has type unsigned short
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:910:23: sparse:    right side has type restricted __le16
--
>> drivers/infiniband/hw/bnxt_re/qplib_fp.c:1291:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got unsigned long @@
   drivers/infiniband/hw/bnxt_re/qplib_fp.c:1291:36: sparse:     expected restricted __le16 [usertype] flags
   drivers/infiniband/hw/bnxt_re/qplib_fp.c:1291:36: sparse:     got unsigned long
   drivers/infiniband/hw/bnxt_re/qplib_fp.c: note: in included file (through include/linux/smp.h, include/linux/alloc_tag.h, include/linux/percpu.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +910 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c

   828	
   829	int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
   830				 struct bnxt_qplib_ctx *ctx, int is_virtfn)
   831	{
   832		struct creq_initialize_fw_resp resp = {};
   833		struct cmdq_initialize_fw req = {};
   834		struct bnxt_qplib_cmdqmsg msg = {};
   835		u16 flags = 0;
   836		u8 pgsz, lvl;
   837		int rc;
   838	
   839		bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
   840					 CMDQ_BASE_OPCODE_INITIALIZE_FW,
   841					 sizeof(req));
   842		/* Supply (log-base-2-of-host-page-size - base-page-shift)
   843		 * to bono to adjust the doorbell page sizes.
   844		 */
   845		req.log2_dbr_pg_size = cpu_to_le16(PAGE_SHIFT -
   846						   RCFW_DBR_BASE_PAGE_SHIFT);
   847		/*
   848		 * Gen P5 devices doesn't require this allocation
   849		 * as the L2 driver does the same for RoCE also.
   850		 * Also, VFs need not setup the HW context area, PF
   851		 * shall setup this area for VF. Skipping the
   852		 * HW programming
   853		 */
   854		if (is_virtfn)
   855			goto skip_ctx_setup;
   856		if (bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx))
   857			goto config_vf_res;
   858	
   859		lvl = ctx->qpc_tbl.level;
   860		pgsz = bnxt_qplib_base_pg_size(&ctx->qpc_tbl);
   861		req.qpc_pg_size_qpc_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
   862					   lvl;
   863		lvl = ctx->mrw_tbl.level;
   864		pgsz = bnxt_qplib_base_pg_size(&ctx->mrw_tbl);
   865		req.mrw_pg_size_mrw_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
   866					   lvl;
   867		lvl = ctx->srqc_tbl.level;
   868		pgsz = bnxt_qplib_base_pg_size(&ctx->srqc_tbl);
   869		req.srq_pg_size_srq_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
   870					   lvl;
   871		lvl = ctx->cq_tbl.level;
   872		pgsz = bnxt_qplib_base_pg_size(&ctx->cq_tbl);
   873		req.cq_pg_size_cq_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
   874					 lvl;
   875		lvl = ctx->tim_tbl.level;
   876		pgsz = bnxt_qplib_base_pg_size(&ctx->tim_tbl);
   877		req.tim_pg_size_tim_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
   878					   lvl;
   879		lvl = ctx->tqm_ctx.pde.level;
   880		pgsz = bnxt_qplib_base_pg_size(&ctx->tqm_ctx.pde);
   881		req.tqm_pg_size_tqm_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
   882					   lvl;
   883		req.qpc_page_dir =
   884			cpu_to_le64(ctx->qpc_tbl.pbl[PBL_LVL_0].pg_map_arr[0]);
   885		req.mrw_page_dir =
   886			cpu_to_le64(ctx->mrw_tbl.pbl[PBL_LVL_0].pg_map_arr[0]);
   887		req.srq_page_dir =
   888			cpu_to_le64(ctx->srqc_tbl.pbl[PBL_LVL_0].pg_map_arr[0]);
   889		req.cq_page_dir =
   890			cpu_to_le64(ctx->cq_tbl.pbl[PBL_LVL_0].pg_map_arr[0]);
   891		req.tim_page_dir =
   892			cpu_to_le64(ctx->tim_tbl.pbl[PBL_LVL_0].pg_map_arr[0]);
   893		req.tqm_page_dir =
   894			cpu_to_le64(ctx->tqm_ctx.pde.pbl[PBL_LVL_0].pg_map_arr[0]);
   895	
   896		req.number_of_qp = cpu_to_le32(ctx->qpc_tbl.max_elements);
   897		req.number_of_mrw = cpu_to_le32(ctx->mrw_tbl.max_elements);
   898		req.number_of_srq = cpu_to_le32(ctx->srqc_tbl.max_elements);
   899		req.number_of_cq = cpu_to_le32(ctx->cq_tbl.max_elements);
   900	
   901	config_vf_res:
   902		req.max_qp_per_vf = cpu_to_le32(ctx->vf_res.max_qp_per_vf);
   903		req.max_mrw_per_vf = cpu_to_le32(ctx->vf_res.max_mrw_per_vf);
   904		req.max_srq_per_vf = cpu_to_le32(ctx->vf_res.max_srq_per_vf);
   905		req.max_cq_per_vf = cpu_to_le32(ctx->vf_res.max_cq_per_vf);
   906		req.max_gid_per_vf = cpu_to_le32(ctx->vf_res.max_gid_per_vf);
   907	
   908	skip_ctx_setup:
   909		if (BNXT_RE_HW_RETX(rcfw->res->dattr->dev_cap_flags))
 > 910			flags |= cpu_to_le16(CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED);
   911		if (_is_optimize_modify_qp_supported(rcfw->res->dattr->dev_cap_flags2))
   912			flags |= CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED;
   913		req.flags |= cpu_to_le16(flags);
   914		req.stat_ctx_id = cpu_to_le32(ctx->stats.fw_id);
   915		bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
   916		rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
   917		if (rc)
   918			return rc;
   919		set_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->cmdq.flags);
   920		return 0;
   921	}
   922	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

