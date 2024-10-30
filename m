Return-Path: <linux-rdma+bounces-5609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CFC9B5FBC
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 11:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C577C1C21450
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1B01E2312;
	Wed, 30 Oct 2024 10:10:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4CF194151
	for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283028; cv=none; b=eAgHiLLKEJZJe/odttt/j1et21Frnof6yd9H7zhv/nXQ4HrumP7vDNJDeAurd1P91FalX4QKIXlJ6sq+sxtmH3GNIRge4LKNFaUGulTlQv7jDDAMtirMJccelttN9RQDwHCPmKrJa9dXFK1aL3amhwSsJ5mRKv0SQkUWjhrFo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283028; c=relaxed/simple;
	bh=5eQ4aPI/dKTq01ai+EQP1W7ho9fZB6pzQA+y6i7HRiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XrhTCpGur1w8Jro1//ZuG54cUm6JqvGnVJ9auFYXisi4HeBPyIIYFrTwAH/6E+I+XZKEhLGIlV1F8Vw/FJeuIT5Rmuiup0pUWHFxbWyHNW7Q6lrrnwjLYiRow483iRgPHmwl4TER8CH9Si2kAxjiRQjaDzNWB9FvhcCn7giwC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XdjXJ66Vzz20ql0;
	Wed, 30 Oct 2024 18:09:20 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AA4E1402CE;
	Wed, 30 Oct 2024 18:10:20 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Oct 2024 18:10:19 +0800
Message-ID: <4766a9e3-205a-4979-33c8-703e1148675c@hisilicon.com>
Date: Wed, 30 Oct 2024 18:10:18 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next 4/4] RDMA/bnxt_re: Add debugfs hook in the driver
To: Selvin Xavier <selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<jgg@ziepe.ca>
CC: <linux-rdma@vger.kernel.org>, <andrew.gospodarek@broadcom.com>,
	<kalesh-anakkur.purayil@broadcom.com>, <kashyap.desai@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
References: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
 <1729591916-29134-5-git-send-email-selvin.xavier@broadcom.com>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <1729591916-29134-5-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/10/22 18:11, Selvin Xavier wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> Adding support for a per device debugfs folder for exporting
> some of the device specific debug information.
> Added support to get QP info for now. The same folder can be
> used to export other debug features in future.
> 
> Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/Makefile   |   3 +-
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   2 +
>  drivers/infiniband/hw/bnxt_re/debugfs.c  | 141 +++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/debugfs.h  |  21 +++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c |   4 +
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   1 +
>  drivers/infiniband/hw/bnxt_re/main.c     |  13 ++-
>  7 files changed, 183 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.c
>  create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.h
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/Makefile b/drivers/infiniband/hw/bnxt_re/Makefile
> index ee9bb1b..f63417d 100644
> --- a/drivers/infiniband/hw/bnxt_re/Makefile
> +++ b/drivers/infiniband/hw/bnxt_re/Makefile
> @@ -4,4 +4,5 @@ ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnxt
>  obj-$(CONFIG_INFINIBAND_BNXT_RE) += bnxt_re.o
>  bnxt_re-y := main.o ib_verbs.o \
>  	     qplib_res.o qplib_rcfw.o	\
> -	     qplib_sp.o qplib_fp.o  hw_counters.o
> +	     qplib_sp.o qplib_fp.o  hw_counters.o	\
> +	     debugfs.o
> diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> index 311bb7c..7f931c7 100644
> --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> @@ -213,6 +213,8 @@ struct bnxt_re_dev {
>  	struct delayed_work dbq_pacing_work;
>  	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
>  	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
> +	struct dentry			*dbg_root;
> +	struct dentry			*qp_debugfs;
>  };
>  
>  #define to_bnxt_re_dev(ptr, member)	\
> diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
> new file mode 100644
> index 0000000..dd38dd6c
> --- /dev/null
> +++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * Copyright (c) 2024, Broadcom. All rights reserved.  The term
> + * Broadcom refers to Broadcom Limited and/or its subsidiaries.
> + *
> + * Description: Debugfs component of the bnxt_re driver
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/pci.h>
> +#include <rdma/ib_addr.h>
> +
> +#include "bnxt_ulp.h"
> +#include "roce_hsi.h"
> +#include "qplib_res.h"
> +#include "qplib_sp.h"
> +#include "qplib_fp.h"
> +#include "qplib_rcfw.h"
> +#include "bnxt_re.h"
> +#include "ib_verbs.h"
> +#include "debugfs.h"
> +
> +static struct dentry *bnxt_re_debugfs_root;
> +
> +static inline const char *bnxt_re_qp_state_str(u8 state)
> +{
> +	switch (state) {
> +	case CMDQ_MODIFY_QP_NEW_STATE_RESET:
> +		return "RST";
> +	case CMDQ_MODIFY_QP_NEW_STATE_INIT:
> +		return "INIT";
> +	case CMDQ_MODIFY_QP_NEW_STATE_RTR:
> +		return "RTR";
> +	case CMDQ_MODIFY_QP_NEW_STATE_RTS:
> +		return "RTS";
> +	case CMDQ_MODIFY_QP_NEW_STATE_SQE:
> +		return "SQER";
> +	case CMDQ_MODIFY_QP_NEW_STATE_SQD:
> +		return "SQD";
> +	case CMDQ_MODIFY_QP_NEW_STATE_ERR:
> +		return "ERR";
> +	default:
> +		return "Invalid QP state";
> +	}
> +}
> +
> +static inline const char *bnxt_re_qp_type_str(u8 type)
> +{
> +	switch (type) {
> +	case CMDQ_CREATE_QP1_TYPE_GSI: return "QP1";
> +	case CMDQ_CREATE_QP_TYPE_GSI: return "QP1";
> +	case CMDQ_CREATE_QP_TYPE_RC: return "RC";
> +	case CMDQ_CREATE_QP_TYPE_UD: return "UD";
> +	case CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE: return "RAW_ETHERTYPE";
> +	default: return "Invalid transport type";
> +	}
> +}
> +

Would it be better to use table-driven approach for these two functions?

> +static ssize_t qp_info_read(struct file *filep,
> +			    char __user *buffer,
> +			    size_t count, loff_t *ppos)
> +{
> +	struct bnxt_re_qp *qp = filep->private_data;
> +	char *buf;
> +	int len;
> +
> +	if (*ppos)
> +		return 0;
> +
> +	buf = kasprintf(GFP_KERNEL,
> +			"QPN\t\t: %d\n"
> +			"transport\t: %s\n"
> +			"state\t\t: %s\n"
> +			"mtu\t\t: %d\n"
> +			"timeout\t\t: %d\n"
> +			"remote QPN\t: %d\n",
> +			qp->qplib_qp.id,
> +			bnxt_re_qp_type_str(qp->qplib_qp.type),
> +			bnxt_re_qp_state_str(qp->qplib_qp.state),
> +			qp->qplib_qp.mtu,
> +			qp->qplib_qp.timeout,
> +			qp->qplib_qp.dest_qpn);
> +	if (!buf)
> +		return -ENOMEM;
> +	if (count < strlen(buf)) {
> +		kfree(buf);
> +		return -ENOSPC;
> +	}
> +	len = simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
> +	kfree(buf);
> +	return len;
> +}
> +
> +static const struct file_operations debugfs_qp_fops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = qp_info_read,
> +};
> +
> +void bnxt_re_debug_add_qpinfo(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp)
> +{
> +	char resn[32];
> +
> +	sprintf(resn, "0x%x", qp->qplib_qp.id);
> +	qp->dentry = debugfs_create_file(resn, 0400, rdev->qp_debugfs, qp, &debugfs_qp_fops);
> +}
> +
> +void bnxt_re_debug_rem_qpinfo(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp)
> +{
> +	if (!bnxt_re_debugfs_root || !rdev->qp_debugfs)
> +		return;

debugfs functions can handle cases where the input dentry is an error,
so this checking is unnecessary.

Junxian

> +
> +	debugfs_remove(qp->dentry);> +}
> +
> +void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
> +{
> +	struct pci_dev *pdev = rdev->en_dev->pdev;
> +
> +	rdev->dbg_root = debugfs_create_dir(dev_name(&pdev->dev), bnxt_re_debugfs_root);
> +
> +	rdev->qp_debugfs = debugfs_create_dir("QPs", rdev->dbg_root);
> +}
> +
> +void bnxt_re_debugfs_rem_pdev(struct bnxt_re_dev *rdev)
> +{
> +	debugfs_remove_recursive(rdev->qp_debugfs);
> +
> +	debugfs_remove_recursive(rdev->dbg_root);
> +	rdev->dbg_root = NULL;
> +}
> +
> +void bnxt_re_register_debugfs(void)
> +{
> +	bnxt_re_debugfs_root = debugfs_create_dir("bnxt_re", NULL);
> +}
> +
> +void bnxt_re_unregister_debugfs(void)
> +{
> +	debugfs_remove(bnxt_re_debugfs_root);
> +}
> diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.h b/drivers/infiniband/hw/bnxt_re/debugfs.h
> new file mode 100644
> index 0000000..cd3be0a9
> --- /dev/null
> +++ b/drivers/infiniband/hw/bnxt_re/debugfs.h
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * Copyright (c) 2024, Broadcom. All rights reserved.  The term
> + * Broadcom refers to Broadcom Limited and/or its subsidiaries.
> + *
> + * Description: Debugfs header
> + */
> +
> +#ifndef __BNXT_RE_DEBUGFS__
> +#define __BNXT_RE_DEBUGFS__
> +
> +void bnxt_re_debug_add_qpinfo(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp);
> +void bnxt_re_debug_rem_qpinfo(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp);
> +
> +void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev);
> +void bnxt_re_debugfs_rem_pdev(struct bnxt_re_dev *rdev);
> +
> +void bnxt_re_register_debugfs(void);
> +void bnxt_re_unregister_debugfs(void);
> +
> +#endif
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index e66ae9f..10e96f1 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -62,6 +62,7 @@
>  
>  #include "bnxt_re.h"
>  #include "ib_verbs.h"
> +#include "debugfs.h"
>  
>  #include <rdma/uverbs_types.h>
>  #include <rdma/uverbs_std_types.h>
> @@ -939,6 +940,8 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
>  	else if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_UD)
>  		atomic_dec(&rdev->stats.res.ud_qp_count);
>  
> +	bnxt_re_debug_rem_qpinfo(rdev, qp);
> +
>  	ib_umem_release(qp->rumem);
>  	ib_umem_release(qp->sumem);
>  
> @@ -1622,6 +1625,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
>  		if (active_qps > rdev->stats.res.ud_qp_watermark)
>  			rdev->stats.res.ud_qp_watermark = active_qps;
>  	}
> +	bnxt_re_debug_add_qpinfo(rdev, qp);
>  
>  	return 0;
>  qp_destroy:
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> index b789e47..e02a5e7 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -95,6 +95,7 @@ struct bnxt_re_qp {
>  	struct ib_ud_header	qp1_hdr;
>  	struct bnxt_re_cq	*scq;
>  	struct bnxt_re_cq	*rcq;
> +	struct dentry		*dentry;
>  };
>  
>  struct bnxt_re_cq {
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 0a18d24..04fa81e 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -67,6 +67,7 @@
>  #include <rdma/bnxt_re-abi.h>
>  #include "bnxt.h"
>  #include "hw_counters.h"
> +#include "debugfs.h"
>  
>  static char version[] =
>  		BNXT_RE_DESC "\n";
> @@ -1870,6 +1871,8 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
>  	u8 type;
>  	int rc;
>  
> +	bnxt_re_debugfs_rem_pdev(rdev);
> +
>  	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
>  		cancel_delayed_work_sync(&rdev->worker);
>  
> @@ -2070,6 +2073,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
>  	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
>  		hash_init(rdev->srq_hash);
>  
> +	bnxt_re_debugfs_add_pdev(rdev);
> +
>  	return 0;
>  free_sctx:
>  	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
> @@ -2389,18 +2394,24 @@ static int __init bnxt_re_mod_init(void)
>  	int rc;
>  
>  	pr_info("%s: %s", ROCE_DRV_MODULE_NAME, version);
> +	bnxt_re_register_debugfs();
> +
>  	rc = auxiliary_driver_register(&bnxt_re_driver);
>  	if (rc) {
>  		pr_err("%s: Failed to register auxiliary driver\n",
>  			ROCE_DRV_MODULE_NAME);
> -		return rc;
> +		goto err_debug;
>  	}
>  	return 0;
> +err_debug:
> +	bnxt_re_unregister_debugfs();
> +	return rc;
>  }
>  
>  static void __exit bnxt_re_mod_exit(void)
>  {
>  	auxiliary_driver_unregister(&bnxt_re_driver);
> +	bnxt_re_unregister_debugfs();
>  }
>  
>  module_init(bnxt_re_mod_init);

