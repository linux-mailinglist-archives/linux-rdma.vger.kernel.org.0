Return-Path: <linux-rdma+bounces-22496-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vUl8CYEpP2o8PgkAu9opvQ
	(envelope-from <linux-rdma+bounces-22496-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 03:38:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7986D0B6D
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 03:38:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=hisilicon.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22496-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22496-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BBDA303A13C
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 01:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDA523394C;
	Sat, 27 Jun 2026 01:37:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466E1E1DE5;
	Sat, 27 Jun 2026 01:37:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782524228; cv=none; b=nY8/dGluGIwCx1dmKQha5vz7rFYTlIzsE3a5snHNsQUDhZ4R9oVwJARl7cQ6ANLWgcVC88GlHEhmSTuQYvOeBi8J+vOra3WElZFeXaG9cRGJzBkwZCUp+ipjyrZtIyIsczcCWxDs94xxLzILi62nKhA5teE11xlXcovvZy1w5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782524228; c=relaxed/simple;
	bh=WL2JSMr11/ZqNcL5aPhsLjfMBW8vrp7qe5FEvWVd2Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OuSb2DI6an6ulslRY7WqEcOtSRd/cGk6fFsony9KbvagFeul3/eFBs42PHoYNhZEld2EUyD10lHUzOFT9QTPLj2HMC4dB2saiUFMb4EAl5fapv7fHUXQh3D9JvM2mVjaY1rJeU59zZ+b8jqc2KbtXmeYTdoAu/MaqYNUDTsLz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gnFKQ66D4zLlT9;
	Sat, 27 Jun 2026 09:27:54 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id CBC5D40571;
	Sat, 27 Jun 2026 09:37:01 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 27 Jun 2026 09:37:01 +0800
Message-ID: <c8adf050-2962-5eda-a984-d42e4efbfde5@hisilicon.com>
Date: Sat, 27 Jun 2026 09:37:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH rdma v1 1/2] RDMA/zrdma: Add basic framework for ZTE
 Dinghai Ethernet Protocol Driver for RDMA
Content-Language: en-US
To: <zhang.yanze@zte.com.cn>, <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<wei.quan@zte.com.cn>, <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
	<han.chengfei@zte.com.cn>
References: <20260624164852120pLCX6txujHU8n4GMakGbe@zte.com.cn>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20260624164852120pLCX6txujHU8n4GMakGbe@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhang.yanze@zte.com.cn,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:wei.quan@zte.com.cn,m:han.junyang@zte.com.cn,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22496-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux-foundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D7986D0B6D



On 2026/6/24 16:48, zhang.yanze@zte.com.cn wrote:
> From: Yanze Zhang <zhang.yanze@zte.com.cn>
> 
> Add basic framework for ZTE DingHai Ethernet Protocol Driver for RDMA,
> including Kconfig/Makefile build support and auxiliary device probe/remove
> skeleton.
> 
> Signed-off-by: Yanze Zhang <zhang.yanze@zte.com.cn>
> ---
> MAINTAINERS                              |   6 +
> drivers/infiniband/Kconfig               |   1 +
> drivers/infiniband/hw/Makefile           |   1 +
> drivers/infiniband/hw/zrdma/Kconfig      |  10 +
> drivers/infiniband/hw/zrdma/Makefile     |   4 +
> drivers/infiniband/hw/zrdma/zrdma_ctrl.h | 248 +++++++++++++++++++++++
> drivers/infiniband/hw/zrdma/zrdma_main.c | 142 +++++++++++++
> drivers/infiniband/hw/zrdma/zrdma_main.h | 139 +++++++++++++
> drivers/infiniband/hw/zrdma/zrdma_mem.h  | 103 ++++++++++
> drivers/infiniband/hw/zrdma/zrdma_type.h | 110 ++++++++++
> 10 files changed, 764 insertions(+)
> create mode 100644 drivers/infiniband/hw/zrdma/Kconfig
> create mode 100644 drivers/infiniband/hw/zrdma/Makefile
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_ctrl.h
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_main.c
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_main.h
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_mem.h
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_type.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aed5a1103de7..a784ce5b99fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29483,6 +29483,12 @@ S: Maintained
> T: git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> F: sound/hda/codecs/senarytech.c
> 
> +ZTE DINGHAI ZRDMA DRIVER
> +M: Yanze Zhang <zhang.yanze@zte.com.cn>
> +L: linux-rdma@vger.kernel.org
> +S: Supported
> +F: drivers/infiniband/hw/zrdma/
> +
> THE REST
> M: Linus Torvalds <torvalds@linux-foundation.org>
> L: linux-kernel@vger.kernel.org
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index 086195758a8a..419dbf742f38 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -100,6 +100,7 @@ source "drivers/infiniband/hw/ocrdma/Kconfig"
> source "drivers/infiniband/hw/qedr/Kconfig"
> source "drivers/infiniband/hw/usnic/Kconfig"
> source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
> +source "drivers/infiniband/hw/zrdma/Kconfig"
> source "drivers/infiniband/sw/rdmavt/Kconfig"
> endif # !UML
> source "drivers/infiniband/sw/rxe/Kconfig"
> diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
> index c42b22ac3303..a86b867c56d4 100644
> --- a/drivers/infiniband/hw/Makefile
> +++ b/drivers/infiniband/hw/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_INFINIBAND_BNXT_RE)  += bnxt_re/
> obj-$(CONFIG_INFINIBAND_BNG_RE)        += bng_re/
> obj-$(CONFIG_INFINIBAND_ERDMA)     += erdma/
> obj-$(CONFIG_INFINIBAND_IONIC)     += ionic/
> +obj-$(CONFIG_INFINIBAND_ZRDMA)     += zrdma/
> diff --git a/drivers/infiniband/hw/zrdma/Kconfig b/drivers/infiniband/hw/zrdma/Kconfig
> new file mode 100644
> index 000000000000..316be707331f
> --- /dev/null
> +++ b/drivers/infiniband/hw/zrdma/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config INFINIBAND_ZRDMA
> +   tristate "ZTE Ethernet Protocol Driver for RDMA"
> +   depends on INFINIBAND
> +   help
> +       Say Y or M here to enable support for the ZTE DingHai (ZXDH) Ethernet
> +       Protocol Driver for RDMA. This driver provides RDMA over Converged
> +       Ethernet (RoCE) functionality for ZTE DingHai network adapters.
> +       If you choose to build this driver as a module, it will be built as
> +       a module named zrdma.
> diff --git a/drivers/infiniband/hw/zrdma/Makefile b/drivers/infiniband/hw/zrdma/Makefile
> new file mode 100644
> index 000000000000..b5297543e393
> --- /dev/null
> +++ b/drivers/infiniband/hw/zrdma/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +
> +obj-$(CONFIG_INFINIBAND_ZRDMA) += zrdma.o
> +zrdma-y := zrdma_main.o
> diff --git a/drivers/infiniband/hw/zrdma/zrdma_ctrl.h b/drivers/infiniband/hw/zrdma/zrdma_ctrl.h
> new file mode 100644
> index 000000000000..1078884de36a
> --- /dev/null
> +++ b/drivers/infiniband/hw/zrdma/zrdma_ctrl.h
> @@ -0,0 +1,248 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * ZTE DingHai Rdma driver
> + * Copyright (c) 2022-2026, ZTE Corporation
> + */
> +
> +#ifndef ZRDMA_CTRL_H
> +#define ZRDMA_CTRL_H
> +
> +#include "zrdma_mem.h"
> +
> +#define ZXDH_HW_SCHEDULE_OFF 0
> +#define ZXDH_HW_SCHEDULE_ON 1
> +
> +enum zxdh_cqp_op_type {
> +   ZXDH_OP_CEQ_DESTROY = 1,
> +   ZXDH_OP_AEQ_DESTROY = 2,
> +   ZXDH_OP_CEQ_CREATE = 5,
> +   ZXDH_OP_QP_MODIFY = 8,
> +   ZXDH_OP_CQ_CREATE = 10,
> +   ZXDH_OP_CQ_DESTROY = 11,
> +   ZXDH_OP_QP_CREATE = 12,
> +   ZXDH_OP_QP_DESTROY = 13,
> +   ZXDH_OP_ALLOC_STAG = 14,
> +   ZXDH_OP_MR_REG_NON_SHARED = 15,
> +   ZXDH_OP_DEALLOC_STAG = 16,
> +   ZXDH_OP_MW_ALLOC = 17,
> +   ZXDH_OP_QP_FLUSH_WQES = 18,
> +   ZXDH_OP_REQ_CMDS = 28,
> +   ZXDH_OP_CMPL_CMDS = 29,
> +   ZXDH_OP_AH_CREATE = 30,
> +   ZXDH_OP_AH_DESTROY = 32,
> +   ZXDH_OP_CONFIG_PTE_TAB = 51,
> +   ZXDH_OP_CONFIG_PBLE_TAB = 53,
> +   ZXDH_OP_CONFIG_MAILBOX = 54,
> +   ZXDH_OP_DMA_WRITE = 55,
> +   ZXDH_OP_DMA_WRITE32 = 56,
> +   ZXDH_OP_DMA_READ = 58,
> +   ZXDH_OP_DMA_READ_USE_CQE = 59,
> +   ZXDH_OP_QUERY_QPC = 60,
> +   ZXDH_OP_QUERY_CQC = 61,
> +   ZXDH_OP_QUERY_SRQC = 62,
> +   ZXDH_OP_QUERY_CEQC = 63,
> +   ZXDH_OP_QUERY_AEQC = 64,
> +   ZXDH_OP_SRQ_CREATE = 65,
> +   ZXDH_OP_SRQ_DESTROY = 66,
> +   ZXDH_OP_SRQ_MODIFY = 67,
> +   ZXDH_OP_QUERY_MKEY = 68,
> +   ZXDH_OP_CQ_MODIFY_MODERATION = 69,
> +   ZXDH_OP_QUERY_HW_OBJECT_INFO = 71,
> +   ZXDH_OP_CQ_MODIFY_OVERFLOW_CHECK_EN = 72,
> +   /* Must be last entry */
> +   ZXDH_MAX_CQP_OPS = 73,
> +};
> +
> +struct zxdh_hw {
> +   u32 __iomem *hw_addr;
> +   u32 __iomem *pci_hw_addr;
> +   struct device *device;
> +   struct zxdh_hmc_info hmc;
> +};
> +
> +struct zxdh_uk_attrs {
> +   u64 feature_flags;
> +   u32 max_hw_wq_frags;
> +   u32 max_hw_read_sges;
> +   u32 max_hw_inline;
> +   u32 max_hw_srq_quanta;
> +   u32 max_hw_rq_quanta;
> +   u32 max_hw_wq_quanta;
> +   u32 min_hw_cq_size;
> +   u32 max_hw_cq_size;
> +   u16 max_hw_sq_chunk;
> +   u32 max_hw_srq_wr;
> +   u8 hw_rev;
> +};
> +
> +struct zxdh_hw_attrs {
> +   struct zxdh_uk_attrs uk_attrs;
> +   u64 max_hw_outbound_msg_size;
> +   u64 max_hw_inbound_msg_size;
> +   u64 max_mr_size;
> +   u32 min_hw_qp_id;
> +   u32 min_hw_aeq_size;
> +   u32 max_hw_aeq_size;
> +   u32 min_hw_ceq_size;
> +   u32 max_hw_ceq_size;
> +   u32 max_hw_device_pages;
> +   u32 max_hw_vf_fpm_id;
> +   u32 first_hw_vf_fpm_id;
> +   u32 max_hw_ird;
> +   u32 max_hw_ord;
> +   u32 max_hw_wqes;
> +   u32 max_hw_pds;
> +   u32 max_qp_wr;
> +   u32 max_srq_wr;
> +   u32 max_pe_ready_count;
> +   u32 max_done_count;
> +   u32 max_sleep_count;
> +   u32 max_cqp_compl_wait_time_ms;
> +   u16 max_stat_inst;
> +   u16 max_stat_idx;
> +   u32 cqp_timeout_threshold;
> +   u8 skip_hw;
> +};
> +
> +struct zxdh_sc_dev {
> +   struct list_head cqp_cmd_head;
> +   spinlock_t cqp_lock; /* Protects CQP command queue submission */
> +   struct zxdh_dma_mem clear_dpu_mem;
> +   struct zxdh_dma_mem nof_clear_dpu_mem;
> +   u64 pte_l2d_startpa;
> +   u32 pte_l2d_len;
> +   struct zxdh_hw *hw;
> +   u8 __iomem *db_addr;
> +   u32 __iomem *wqe_alloc_db;
> +   u32 __iomem *cq_arm_db;
> +   u32 __iomem *cqp_db;
> +   u32 __iomem *cq_ack_db;
> +   u64 cqp_cmd_stats[ZXDH_MAX_CQP_OPS];
> +   struct zxdh_hw_attrs hw_attrs;
> +   struct zxdh_hmc_info *hmc_info;
> +   struct zxdh_sc_cqp *cqp;
> +   struct zxdh_sc_cq *ccq;
> +   u32 max_ceqs;
> +   u32 base_qpn;
> +   u32 base_cqn;
> +   u32 base_srqn;
> +   u32 base_ceqn;
> +   u32 max_qp;
> +   u32 max_cq;
> +   u32 max_srq;
> +   u16 num_vfs;
> +   u16 active_vfs_num;
> +   u32 hmc_fn_id;
> +   u16 vf_id;
> +   u16 vhca_id;
> +   u16 vhca_id_pf;
> +   u16 cache_id;
> +   u8 ep_id;
> +   u8 hmc_epid;
> +   u16 ird_size;
> +   u32 total_vhca;
> +   u16 vhca_gqp_start;
> +   u16 vhca_gqp_cnt;
> +   u16 vhca_8k_index_start;
> +   u16 vhca_8k_index_cnt;
> +   u16 vhca_ud_gqp;
> +   u16 vhca_ud_8k_index;
> +   u64 nof_ioq_ddr_addr;
> +   u8 chip_version;
> +   u64 l2d_pt_addr;
> +   u32 l2d_pt_l2_offset;
> +   u32 l2_pt_num;
> +   u32 l3_pt_num;
> +   u8 ceq_valid : 1;
> +   u8 privileged : 1;
> +   u8 hmc_use_dpu_ddr : 1;
> +   u8 np_mode_low_lat : 1;
> +   struct mutex vchnl_mutex; /* protects virtual channel operations */
> +   u8 driver_load;
> +};
> +
> +struct cqp_info {
> +   union {
> +       struct {
> +           struct zxdh_sc_cq *cq;
> +           u64 scratch;
> +       } cq_create;
> +
> +       struct {
> +           struct zxdh_sc_cq *cq;
> +           u64 scratch;
> +       } cq_destroy;
> +   } u;
> +};
> +
> +struct cqp_cmds_info {
> +   struct list_head cqp_cmd_entry;
> +   u8 cqp_cmd;
> +   u8 post_sq;
> +   struct cqp_info in;
> +};
> +
> +struct zxdh_cqp_err_info {
> +   u16 maj;
> +   u16 min;
> +   const char *desc;
> +};
> +
> +struct zxdh_cqp_compl_info {
> +   u64 op_ret_val;
> +   u16 maj_err_code;
> +   u16 min_err_code;
> +   bool error;
> +   u8 op_code;
> +   __le64 addrbuf[5];
> +};
> +
> +struct zxdh_cqp_request {
> +   struct cqp_cmds_info info;
> +   wait_queue_head_t waitq;
> +   struct list_head list;
> +   refcount_t refcnt;
> +   void (*callback_fcn)(struct zxdh_cqp_request *cqp_request);
> +   void *param;
> +   struct zxdh_cqp_compl_info compl_info;
> +   u8 waiting : 1;
> +   u8 request_done : 1;
> +   u8 dynamic : 1;
> +};
> +
> +struct zxdh_sc_cqp {
> +   u64 sq_pa;
> +   u64 host_ctx_pa;
> +   void *back_cqp;
> +   struct zxdh_sc_dev *dev;
> +   struct zxdh_ring sq_ring;
> +   struct zxdh_cqp_quanta *sq_base;
> +   __le64 *host_ctx;
> +   u64 *scratch_array;
> +   u32 sq_size;
> +   u32 hw_sq_size;
> +   u8 polarity;
> +   u8 state_cfg : 1;
> +};
> +
> +struct zxdh_cqp {
> +   struct zxdh_sc_cqp sc_cqp;
> +   spinlock_t req_lock; /* protect CQP request list */
> +   spinlock_t compl_lock; /* protect CQP completion processing */
> +   wait_queue_head_t waitq;
> +   wait_queue_head_t remove_wq;
> +   struct zxdh_dma_mem sq;
> +   struct zxdh_dma_mem host_ctx;
> +   u64 *scratch_array;
> +   struct zxdh_cqp_request *cqp_requests;
> +   struct list_head cqp_avail_reqs;
> +   struct list_head cqp_pending_reqs;
> +};
> +
> +struct zxdh_ccq {
> +   struct zxdh_sc_cq sc_cq;
> +   struct zxdh_dma_mem mem_cq;
> +   struct zxdh_dma_mem shadow_area;
> +};
> +
> +#endif
> diff --git a/drivers/infiniband/hw/zrdma/zrdma_main.c b/drivers/infiniband/hw/zrdma/zrdma_main.c
> new file mode 100644
> index 000000000000..e06ad176e6d8
> --- /dev/null
> +++ b/drivers/infiniband/hw/zrdma/zrdma_main.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ZTE DingHai Rdma driver
> + * Copyright (c) 2022-2026, ZTE Corporation
> + */
> +
> +#include <linux/module.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/types.h>
> +#include <linux/netdevice.h>
> +#include <linux/workqueue.h>
> +#include <rdma/ib_verbs.h>
> +
> +#include "zrdma_main.h"
> +
> +MODULE_ALIAS("zrdma");
> +MODULE_AUTHOR("Yanze Zhang <zhang.yanze@zte.com.cn>");
> +MODULE_DESCRIPTION("ZTE Ethernet Protocol Driver for RDMA");
> +MODULE_LICENSE("Dual BSD/GPL");
> +
> +LIST_HEAD(zxdh_handlers);
> +DEFINE_SPINLOCK(zxdh_handler_lock);
> +
> +static void zxdh_add_handler(struct zxdh_handler *hdl)
> +{
> +   unsigned long flags;
> +
> +   spin_lock_irqsave(&zxdh_handler_lock, flags);
> +   list_add(&hdl->list, &zxdh_handlers);
> +   spin_unlock_irqrestore(&zxdh_handler_lock, flags);
> +}
> +
> +static void zxdh_del_handler(struct zxdh_handler *hdl)
> +{
> +   unsigned long flags;
> +
> +   spin_lock_irqsave(&zxdh_handler_lock, flags);
> +   list_del(&hdl->list);
> +   spin_unlock_irqrestore(&zxdh_handler_lock, flags);
> +}
> +
> +static void zxdh_fill_device_info(struct zxdh_device *zdev,
> +                 struct zxdh_core_dev_info *zdev_info)
> +{
> +   struct zxdh_pci_f *rf = zdev->rf;
> +
> +   rf->ftype = ZXDH_FUNC_TYPE(zdev_info->vport_id);
> +   rf->pf_id = ZXDH_PF_ID(zdev_info->vport_id);
> +   rf->sc_dev.ep_id = ZXDH_EP_ID(zdev_info->vport_id);
> +   rf->ep_id = rf->sc_dev.ep_id;
> +   rf->sc_dev.driver_load = true;
> +   rf->zdev_info = zdev_info;
> +   rf->pcidev = zdev_info->pdev;
> +   rf->hw.pci_hw_addr = zdev_info->hw_addr;
> +   rf->zdev = zdev;
> +
> +   INIT_LIST_HEAD(&zdev->ah_list);
> +   mutex_init(&zdev->ah_list_lock);
> +   zdev->netdev = zdev_info->netdev;
> +   zdev->source_netdev = zdev_info->netdev;
> +   zdev->init_state = INITIAL_STATE;
> +}
> +
> +static int zxdh_probe(struct auxiliary_device *aux_dev,
> +             const struct auxiliary_device_id *id)
> +{
> +   struct zxdh_auxiliary_dev *zxdh_adev =
> +       container_of(aux_dev, struct zxdh_auxiliary_dev, adev);
> +   struct zxdh_handler *hdl;
> +   struct zxdh_device *zdev;
> +   struct zxdh_pci_f *rf;
> +
> +   zdev = ib_alloc_device(zxdh_device, ibdev);
> +   if (!zdev)
> +       return -ENOMEM;
> +
> +   zdev->zxdh_adev = zxdh_adev;
> +   zdev->rf = kzalloc_obj(*zdev->rf);
> +   if (!zdev->rf) {
> +       ib_dealloc_device(&zdev->ibdev);
> +       return -ENOMEM;
> +   }
> +
> +   zxdh_fill_device_info(zdev, zxdh_adev->zxdh_info);
> +
> +   hdl = kzalloc_obj(*hdl);
> +   if (!hdl) {
> +       kfree(zdev->rf);
> +       ib_dealloc_device(&zdev->ibdev);
> +       return -ENOMEM;
> +   }
> +
> +   hdl->zdev = zdev;
> +   zdev->hdl = hdl;
> +   zdev->netdev_speed = SPEED_UNKNOWN;
> +
> +   zxdh_add_handler(hdl);
> +
> +   dev_set_drvdata(&aux_dev->dev, zdev);
> +
> +   return 0;
> +}
> +
> +static void zxdh_remove(struct auxiliary_device *aux_dev)
> +{
> +   struct zxdh_device *zdev = dev_get_drvdata(&aux_dev->dev);
> +
> +   if (!zdev) {
> +       dev_err(&aux_dev->dev, "%s: zdev is NULL\n", __func__);
> +       return;
> +   }
> +
> +   zxdh_del_handler(zdev->hdl);


You don't free this hdl in the remove process

Junxian

> +   kfree(zdev->rf);
> +   ib_dealloc_device(&zdev->ibdev);
> +}
> +
> +static void zxdh_shutdown(struct auxiliary_device *aux_dev)
> +{
> +   zxdh_remove(aux_dev);
> +}
> +
> +static const struct auxiliary_device_id zxdh_auxiliary_id_table[] = {
> +   {
> +       .name = ZXDH_PF_NAME "." ZXDH_RDMA_DEV_NAME,
> +   },
> +   {},
> +};
> +
> +MODULE_DEVICE_TABLE(auxiliary, zxdh_auxiliary_id_table);
> +
> +static struct auxiliary_driver zxdh_auxiliary_drv = {
> +   .driver = {
> +       .name = ZXDH_RDMA_DEV_NAME,
> +   },
> +   .id_table = zxdh_auxiliary_id_table,
> +   .probe = zxdh_probe,
> +   .remove = zxdh_remove,
> +   .shutdown = zxdh_shutdown,
> +};
> +
> +module_auxiliary_driver(zxdh_auxiliary_drv);
> diff --git a/drivers/infiniband/hw/zrdma/zrdma_main.h b/drivers/infiniband/hw/zrdma/zrdma_main.h
> new file mode 100644
> index 000000000000..2eb2fc802f5c
> --- /dev/null
> +++ b/drivers/infiniband/hw/zrdma/zrdma_main.h
> @@ -0,0 +1,139 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * ZTE DingHai Rdma driver
> + * Copyright (c) 2022-2026, ZTE Corporation
> + */
> +
> +#ifndef ZRDMA_MAIN_H
> +#define ZRDMA_MAIN_H
> +
> +#include <linux/auxiliary_bus.h>
> +#include "zrdma_type.h"
> +#include "zrdma_ctrl.h"
> +
> +#define ZXDH_PF_NAME "dinghai10e"
> +#define ZXDH_RDMA_DEV_NAME "rdma_aux"
> +
> +#define ZXDH_FUNC_TYPE(vport_id) (((vport_id) >> 11) & 0x1)
> +#define ZXDH_PF_ID(vport_id) (((vport_id) >> 8) & 0x7)
> +#define ZXDH_EP_ID(vport_id) (((vport_id) >> 12) & 0x7)
> +
> +enum init_completion_state {
> +   INVALID_STATE = 0,
> +   INITIAL_STATE,
> +   CQP_CREATED,
> +   SMMU_PAGETABLE_INITIALIZED,
> +   DATA_CAP_CREATED,
> +   HMC_OBJS_CREATED,
> +   HW_RSRC_INITIALIZED,
> +   CQP_QP_CREATED,
> +   AEQ_CREATED,
> +   CCQ_CREATED,
> +   CEQ0_CREATED,
> +   CEQS_CREATED,
> +   PBLE_CHUNK_MEM,
> +};
> +
> +struct zxdh_fw_compat {
> +   u8 module_id;
> +   u8 major;
> +   u8 fw_minor;
> +   u8 drv_minor;
> +   u16 patch;
> +   u16 rsv;
> +} __packed;
> +
> +struct zxdh_handler {
> +   struct list_head list;
> +   struct zxdh_device *zdev;
> +};
> +
> +struct zxdh_pci_f {
> +   u8 reset : 1;
> +   u8 rsrc_created : 1;
> +   u8 ftype : 1;
> +   u8 max_rdma_vfs;
> +   u8 *hmc_info_mem;
> +   u8 *mem_rsrc;
> +   u8 pf_id;
> +   u8 vf_id;
> +   u8 ep_id;
> +   u32 msix_count;
> +   u32 max_mr;
> +   u32 max_qp;
> +   u32 max_cq;
> +   u32 max_ah;
> +   u32 next_ah;
> +   u32 max_pd;
> +   u32 next_qp;
> +   u32 next_cq;
> +   u32 next_pd;
> +   u32 next_mr;
> +   u32 max_mr_size;
> +   u32 max_cqe;
> +   u32 used_pds;
> +   u32 used_cqs;
> +   u32 used_mrs;
> +   u32 used_qps;
> +   u32 max_srq;
> +   u32 next_srq;
> +   u32 used_srqs;
> +   u32 max_pri;
> +   u16 max_8k_idx;
> +   u32 *qp_cnt_8k_idxs;
> +   u32 ceqs_count;
> +   u64 base_bar_offset;
> +
> +   unsigned long *allocated_qps;
> +   unsigned long *allocated_cqs;
> +   unsigned long *allocated_mrs;
> +   unsigned long *allocated_pds;
> +   unsigned long *allocated_mcgs;
> +   unsigned long *allocated_ahs;
> +   unsigned long *allocated_srqs;
> +   unsigned long *allocated_pris;
> +   unsigned long *allocated_8k_idx;
> +
> +   enum init_completion_state init_state;
> +   struct zxdh_sc_dev sc_dev;
> +   struct zxdh_handler *hdl;
> +   struct pci_dev *pcidev;
> +   struct zxdh_core_dev_info *zdev_info;
> +   struct zxdh_hw hw;
> +   struct zxdh_cqp cqp;
> +   struct zxdh_ccq ccq;
> +   struct zxdh_dma_mem cqp_host_ctx;
> +   spinlock_t rsrc_lock; /* protect HardWare resource array access */
> +   struct workqueue_struct *cqp_cmpl_wq;
> +   struct work_struct cqp_cmpl_work;
> +   struct zxdh_device *zdev;
> +   u8 mcode_type;
> +   u16 pcie_id;
> +   void *dh_dev;
> +};
> +
> +struct zxdh_device {
> +   struct ib_device ibdev;
> +   const struct uverbs_object_tree_def *driver_trees[6];
> +   struct zxdh_pci_f *rf;
> +   struct net_device *netdev;
> +   struct net_device *source_netdev;
> +   struct zxdh_handler *hdl;
> +   struct workqueue_struct *cleanup_wq;
> +   struct list_head ah_list;
> +   struct mutex ah_list_lock; /* protects ah_list operations */
> +   u32 ah_list_cnt;
> +   u32 ah_list_hwm;
> +   u32 vendor_id;
> +   u32 vendor_part_id;
> +   u32 device_cap_flags;
> +   enum init_completion_state init_state;
> +   wait_queue_head_t suspend_wq;
> +   u32 netdev_speed;
> +   struct zxdh_fw_compat fw_ver;
> +   struct zxdh_auxiliary_dev *zxdh_adev;
> +};
> +
> +int zxdh_ctrl_init_hw(struct zxdh_pci_f *rf);
> +
> +#endif /* ZRDMA_MAIN_H */
> diff --git a/drivers/infiniband/hw/zrdma/zrdma_mem.h b/drivers/infiniband/hw/zrdma/zrdma_mem.h
> new file mode 100644
> index 000000000000..b49df6d51d19
> --- /dev/null
> +++ b/drivers/infiniband/hw/zrdma/zrdma_mem.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * ZTE DingHai Rdma driver
> + * Copyright (c) 2022-2026, ZTE Corporation
> + */
> +
> +#ifndef ZRDMA_MEM_H
> +#define ZRDMA_MEM_H
> +
> +#define ZXDH_TABLE5_VF_EN 0x04
> +
> +#define ZXDH_HMC_MAX_SD_COUNT 8192
> +
> +enum zxdh_indicate_id {
> +   ZXDH_INDICATE_L2D = 0,
> +   ZXDH_INDICATE_DPU_DDR = ZXDH_INDICATE_L2D,
> +   ZXDH_INDICATE_REGISTER = ZXDH_INDICATE_L2D,
> +   ZXDH_INDICATE_RESERVED = 1,
> +   ZXDH_INDICATE_HOST_NOSMMU = 2,
> +   ZXDH_INDICATE_HOST_SMMU = 3,
> +};
> +
> +enum zxdh_axid_type {
> +   ZXDH_AXID_L2D,
> +   ZXDH_AXID_DPUDDR,
> +   ZXDH_AXID_HOST_EP0,
> +   ZXDH_AXID_HOST_EP1,
> +   ZXDH_AXID_HOST_EP2,
> +   ZXDH_AXID_HOST_EP3,
> +   ZXDH_AXID_HOST_EP4,
> +};
> +
> +enum zxdh_object_id {
> +   ZXDH_PBLE_MR_OBJ_ID = 0,
> +   ZXDH_PBLE_QUEUE_OBJ_ID = 1,
> +   ZXDH_MR_OBJ_ID = 2,
> +   ZXDH_AH_OBJ_ID = 3,
> +   ZXDH_IRD_OBJ_ID = 4,
> +   ZXDH_TX_WINDOW_OBJ_ID = 5,
> +   ZXDH_SRQC_OBJ_ID = 6,
> +   ZXDH_CQC_OBJ_ID = 7,
> +   ZXDH_MG_PAYLOAD_OBJ_ID = 8,
> +   ZXDH_MG_OBJ_ID = 9,
> +   ZXDH_RW_PAYLOAD = 10,
> +   ZXDH_SQ = 11,
> +   ZXDH_SQ_SHADOW_AREA = 12,
> +   ZXDH_RQ = 13,
> +   ZXDH_RQ_SHADOW_AREA = 14,
> +   ZXDH_SRQP = 15,
> +   ZXDH_SRQ = 16,
> +   ZXDH_SRQ_SHADOW_AREA = 17,
> +   ZXDH_CQ = 18,
> +   ZXDH_CQ_SHADOW_AREA = 19,
> +   ZXDH_CEQ = 20,
> +   ZXDH_AEQ = 21,
> +   ZXDH_MG_QPN = 22,
> +   ZXDH_CPU_DDR = 24,
> +   ZXDH_QPC_OBJ_ID = 29,
> +   ZXDH_DMA_OBJ_ID = 30,
> +   ZXDH_L2D_OBJ_ID = 31,
> +   ZXDH_REG_OBJ_ID = ZXDH_L2D_OBJ_ID,
> +};
> +
> +struct zxdh_dma_mem {
> +   void *va;
> +   dma_addr_t pa;
> +   u32 size;
> +} __packed;
> +
> +struct zxdh_virt_mem {
> +   void *va;
> +   u32 size;
> +} __packed;
> +
> +struct zxdh_hmc_sd_entry {
> +   bool valid;
> +   struct zxdh_dma_mem addr;
> +   struct zxdh_dma_mem addr_hardware;
> +};
> +
> +struct zxdh_hmc_sd_table {
> +   struct zxdh_virt_mem addr;
> +   u32 sd_cnt;
> +   struct zxdh_hmc_sd_entry *sd_entry;
> +};
> +
> +struct zxdh_hmc_info {
> +   u32 signature;
> +   u8 hmc_fn_id;
> +   u32 pble_hmc_index;
> +   u32 pble_mr_hmc_index;
> +   u32 hmc_entry_total;
> +   u32 hmc_first_entry_pble;
> +   u32 hmc_first_entry_pble_mr;
> +   struct zxdh_hmc_obj_info *hmc_obj;
> +   struct zxdh_virt_mem hmc_obj_virt_mem;
> +   struct zxdh_hmc_sd_table sd_table;
> +   u16 sd_indexes[ZXDH_HMC_MAX_SD_COUNT];
> +   u8 pble_mr_cachid;
> +   u8 pble_ird_cachid;
> +};
> +
> +#endif
> diff --git a/drivers/infiniband/hw/zrdma/zrdma_type.h b/drivers/infiniband/hw/zrdma/zrdma_type.h
> new file mode 100644
> index 000000000000..b5def5803d1f
> --- /dev/null
> +++ b/drivers/infiniband/hw/zrdma/zrdma_type.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * ZTE DingHai Rdma driver
> + * Copyright (c) 2022-2026, ZTE Corporation
> + */
> +
> +#ifndef ZRDMA_TYPE_H
> +#define ZRDMA_TYPE_H
> +
> +#include "zrdma_mem.h"
> +
> +#define ZXDH_CQP_WQE_SIZE 8
> +#define ZXDH_CQE_SIZE 8
> +
> +struct zxdh_ring {
> +   u32 head;
> +   u32 tail;
> +   u32 size;
> +};
> +
> +struct zxdh_cqp_quanta {
> +   __le64 elem[ZXDH_CQP_WQE_SIZE];
> +};
> +
> +struct zxdh_cqe {
> +   __le64 buf[ZXDH_CQE_SIZE];
> +};
> +
> +struct zxdh_cq_uk {
> +   struct zxdh_cqe *cq_base;
> +   u32 __iomem *cqe_alloc_db;
> +   u32 __iomem *cq_ack_db;
> +   __le64 *shadow_area;
> +   u32 cq_id;
> +   u32 cq_size;
> +   u32 cq_log_size;
> +   u32 cqe_rd_cnt;
> +   bool valid_cq;
> +   struct zxdh_ring cq_ring;
> +   u8 polarity;
> +   u8 armed : 1;
> +   u8 cqe_size;
> +};
> +
> +struct zxdh_sc_cq {
> +   struct zxdh_cq_uk cq_uk;
> +   u64 cq_pa;
> +   u64 shadow_area_pa;
> +   struct zxdh_sc_dev *dev;
> +   void *pbl_list;
> +   void *back_cq;
> +   u32 ceq_id;
> +   u32 ceq_index;
> +   u32 shadow_read_threshold;
> +   u8 pbl_chunk_size;
> +   u8 cq_type;
> +   u8 tph_val;
> +   u32 first_pm_pbl_idx;
> +   u8 ceqe_mask : 1;
> +   u8 virtual_map : 1;
> +   u8 ceq_id_valid : 1;
> +   u8 tph_en;
> +   u8 cq_st;
> +   u16 is_in_list_cnt;
> +   u16 cq_max;
> +   u16 cq_period;
> +   u8 scqe_break_moderation_en : 1;
> +   u8 cq_overflow_locked_flag : 1;
> +};
> +
> +struct zxdh_ver_info {
> +   u16 major;
> +   u16 minor;
> +   u64 support;
> +};
> +
> +enum zxdh_function_type {
> +   ZXDH_FUNCTION_TYPE_PF,
> +   ZXDH_FUNCTION_TYPE_VF,
> +};
> +
> +struct zxdh_core_dev_info {
> +   struct pci_dev *pdev;
> +   struct auxiliary_device *adev;
> +   u32 __iomem *hw_addr;
> +   struct zxdh_ver_info ver;
> +   void *auxiliary_priv;
> +   enum zxdh_function_type ftype;
> +   u16 vport_id;
> +   u16 slot_id;
> +   struct net_device *netdev;
> +   struct msix_entry msix_entries;
> +   u16 msix_count;
> +   void *dh_dev;
> +};
> +
> +struct zxdh_rdma_if {
> +   void *(*get_rdma_netdev)(void *dh_dev);
> +};
> +
> +struct zxdh_auxiliary_dev {
> +   struct auxiliary_device adev;
> +   struct zxdh_core_dev_info *zxdh_info;
> +   struct zxdh_rdma_if *rdma_ops;
> +   void *ops;
> +   void *parent;
> +   void *auxiliary_ops[18];
> +};
> +
> +#endif /* ZRDMA_TYPE_H */
> --
> 2.27.0
> 
> 

