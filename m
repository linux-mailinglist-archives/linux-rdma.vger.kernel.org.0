Return-Path: <linux-rdma+bounces-1818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB3289B3B1
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Apr 2024 20:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D62281224
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Apr 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C603F9CD;
	Sun,  7 Apr 2024 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q5liLnbm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9B3D0C2;
	Sun,  7 Apr 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712516206; cv=none; b=taLjHjOZcu3nubGxDZZGe16jvBZ+ENV2ky1Z9JFL3cNABt+Zzq32Xku5bRr6o4VNGYoJ88bwRgAmuE9BwoXF4myEEyBPUMX7+DpK75qKnzliWS8fCFfNlWC+g2WM5gf5UuwUlCx33i6LqEg1hrvIhVlpBNNJwQoz8ppEm+pjMmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712516206; c=relaxed/simple;
	bh=XUCEUi3tlAK5SiGgAyJi822HRi/+WAizduBAWmVOpPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJvKmOFjeOy3Ym/iWUNo5aNZxHaSYYb0cuiXhLqmUt62WbfAFlUFkCS9EevE9cz21a+56lA/ck/TQcDliy/qyapueqyAgWqpkyHzJIGeVyaPQIUONFJ3bkkNckV6qaeF0jNtSbOHiIm7ouw2HtiCBmi90Cw6CsKdvkKbfm6z+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q5liLnbm; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <20158645-6637-4f36-a247-d3a15ff56d63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712516198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPWMmDLO77UTrV5Jci0z2krEZP1mwBlTU+VWJnRngNk=;
	b=Q5liLnbmSKwUcufa6Y/hCudLg415TvisZKo+32dn2P1GN0Cz/UdESwnaEu+89Vnp2zLK4I
	/qgPFYLf1pT/TpYGYYWBkP/+c/BbYo7gOSvhzDlobjaZUyLlmwjwnadI5XNGD1V4SQqNQ8
	TNsraRLAtKkEMRR6LzCj9vEfrS5OgLo=
Date: Sun, 7 Apr 2024 20:56:29 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/9] IB: Convert from tasklet to BH workqueue
To: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org
Cc: tj@kernel.org, keescook@chromium.org, vkoul@kernel.org, marcan@marcan.st,
 sven@svenpeter.dev, florian.fainelli@broadcom.com, rjui@broadcom.com,
 sbranden@broadcom.com, paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
 manivannan.sadhasivam@linaro.org, vireshk@kernel.org, Frank.Li@nxp.com,
 leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com,
 haijie1@huawei.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, afaerber@suse.de,
 logang@deltatee.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, andersson@kernel.org, konrad.dybcio@linaro.org,
 orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
 patrice.chotard@foss.st.com, linus.walleij@linaro.org, wens@csie.org,
 jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 jassisinghbrar@gmail.com, mchehab@kernel.org, maintainers@bluecherrydvr.com,
 aubin.constans@microchip.com, ulf.hansson@linaro.org,
 manuel.lauss@gmail.com, mirq-linux@rere.qmqm.pl, jh80.chung@samsung.com,
 oakad@yahoo.com, hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
 brucechang@via.com.tw, HaraldWelte@viatech.com, pierre@ossman.eu,
 duncan.sands@free.fr, stern@rowland.harvard.edu, oneukum@suse.com,
 openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-mediatek@lists.infradead.org, linux-actions@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-4-apais@linux.microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240327160314.9982-4-apais@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/3/27 17:03, Allen Pais 写道:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/infiniband/* from tasklet to BH workqueue.
> 
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10

I made simple tests. And I can not find the difference on latency and 
throughput on RoCEv2 devices.

Anyone also made tests with these patches on IB? Any difference on 
Latency and throughput?

Thanks,
Zhu Yanjun

> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>   drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  3 +-
>   drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 21 ++++++------
>   drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  2 +-
>   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 25 ++++++++-------
>   drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 +-
>   drivers/infiniband/hw/erdma/erdma.h        |  3 +-
>   drivers/infiniband/hw/erdma/erdma_eq.c     | 11 ++++---
>   drivers/infiniband/hw/hfi1/rc.c            |  2 +-
>   drivers/infiniband/hw/hfi1/sdma.c          | 37 +++++++++++-----------
>   drivers/infiniband/hw/hfi1/sdma.h          |  9 +++---
>   drivers/infiniband/hw/hfi1/tid_rdma.c      |  6 ++--
>   drivers/infiniband/hw/irdma/ctrl.c         |  2 +-
>   drivers/infiniband/hw/irdma/hw.c           | 24 +++++++-------
>   drivers/infiniband/hw/irdma/main.h         |  5 +--
>   drivers/infiniband/hw/qib/qib.h            |  7 ++--
>   drivers/infiniband/hw/qib/qib_iba7322.c    |  9 +++---
>   drivers/infiniband/hw/qib/qib_rc.c         | 16 +++++-----
>   drivers/infiniband/hw/qib/qib_ruc.c        |  4 +--
>   drivers/infiniband/hw/qib/qib_sdma.c       | 11 ++++---
>   drivers/infiniband/sw/rdmavt/qp.c          |  2 +-
>   20 files changed, 106 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> index 9dca451ed522..f511c8415806 100644
> --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> @@ -42,6 +42,7 @@
>   #include <rdma/uverbs_ioctl.h>
>   #include "hw_counters.h"
>   #include <linux/hashtable.h>
> +#include <linux/workqueue.h>
>   #define ROCE_DRV_MODULE_NAME		"bnxt_re"
>   
>   #define BNXT_RE_DESC	"Broadcom NetXtreme-C/E RoCE Driver"
> @@ -162,7 +163,7 @@ struct bnxt_re_dev {
>   	u8				cur_prio_map;
>   
>   	/* FP Notification Queue (CQ & SRQ) */
> -	struct tasklet_struct		nq_task;
> +	struct work_struct 		nq_work;
>   
>   	/* RCFW Channel */
>   	struct bnxt_qplib_rcfw		rcfw;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index 439d0c7c5d0c..052906982cdf 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -46,6 +46,7 @@
>   #include <linux/delay.h>
>   #include <linux/prefetch.h>
>   #include <linux/if_ether.h>
> +#include <linux/workqueue.h>
>   #include <rdma/ib_mad.h>
>   
>   #include "roce_hsi.h"
> @@ -294,9 +295,9 @@ static void __wait_for_all_nqes(struct bnxt_qplib_cq *cq, u16 cnq_events)
>   	}
>   }
>   
> -static void bnxt_qplib_service_nq(struct tasklet_struct *t)
> +static void bnxt_qplib_service_nq(struct work_struct *t)
>   {
> -	struct bnxt_qplib_nq *nq = from_tasklet(nq, t, nq_tasklet);
> +	struct bnxt_qplib_nq *nq = from_work(nq, t, nq_work);
>   	struct bnxt_qplib_hwq *hwq = &nq->hwq;
>   	struct bnxt_qplib_cq *cq;
>   	int budget = nq->budget;
> @@ -394,7 +395,7 @@ void bnxt_re_synchronize_nq(struct bnxt_qplib_nq *nq)
>   	int budget = nq->budget;
>   
>   	nq->budget = nq->hwq.max_elements;
> -	bnxt_qplib_service_nq(&nq->nq_tasklet);
> +	bnxt_qplib_service_nq(&nq->nq_work);
>   	nq->budget = budget;
>   }
>   
> @@ -409,7 +410,7 @@ static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
>   	prefetch(bnxt_qplib_get_qe(hwq, sw_cons, NULL));
>   
>   	/* Fan out to CPU affinitized kthreads? */
> -	tasklet_schedule(&nq->nq_tasklet);
> +	queue_work(system_bh_wq, &nq->nq_work);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -430,8 +431,8 @@ void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
>   	nq->name = NULL;
>   
>   	if (kill)
> -		tasklet_kill(&nq->nq_tasklet);
> -	tasklet_disable(&nq->nq_tasklet);
> +		cancel_work_sync(&nq->nq_work);
> +	disable_work_sync(&nq->nq_work);
>   }
>   
>   void bnxt_qplib_disable_nq(struct bnxt_qplib_nq *nq)
> @@ -465,9 +466,9 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
>   
>   	nq->msix_vec = msix_vector;
>   	if (need_init)
> -		tasklet_setup(&nq->nq_tasklet, bnxt_qplib_service_nq);
> +		INIT_WORK(&nq->nq_work, bnxt_qplib_service_nq);
>   	else
> -		tasklet_enable(&nq->nq_tasklet);
> +		enable_and_queue_work(system_bh_wq, &nq->nq_work);
>   
>   	nq->name = kasprintf(GFP_KERNEL, "bnxt_re-nq-%d@pci:%s",
>   			     nq_indx, pci_name(res->pdev));
> @@ -477,7 +478,7 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
>   	if (rc) {
>   		kfree(nq->name);
>   		nq->name = NULL;
> -		tasklet_disable(&nq->nq_tasklet);
> +		disable_work_sync(&nq->nq_work);
>   		return rc;
>   	}
>   
> @@ -541,7 +542,7 @@ int bnxt_qplib_enable_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq,
>   	nq->cqn_handler = cqn_handler;
>   	nq->srqn_handler = srqn_handler;
>   
> -	/* Have a task to schedule CQ notifiers in post send case */
> +	/* Have a work to schedule CQ notifiers in post send case */
>   	nq->cqn_wq  = create_singlethread_workqueue("bnxt_qplib_nq");
>   	if (!nq->cqn_wq)
>   		return -ENOMEM;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> index 7fd4506b3584..6ee3e501d136 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> @@ -494,7 +494,7 @@ struct bnxt_qplib_nq {
>   	u16				ring_id;
>   	int				msix_vec;
>   	cpumask_t			mask;
> -	struct tasklet_struct		nq_tasklet;
> +	struct work_struct 		nq_work;
>   	bool				requested;
>   	int				budget;
>   
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> index 3ffaef0c2651..2fba712d88db 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> @@ -43,6 +43,7 @@
>   #include <linux/pci.h>
>   #include <linux/prefetch.h>
>   #include <linux/delay.h>
> +#include <linux/workqueue.h>
>   
>   #include "roce_hsi.h"
>   #include "qplib_res.h"
> @@ -51,7 +52,7 @@
>   #include "qplib_fp.h"
>   #include "qplib_tlv.h"
>   
> -static void bnxt_qplib_service_creq(struct tasklet_struct *t);
> +static void bnxt_qplib_service_creq(struct work_struct *t);
>   
>   /**
>    * bnxt_qplib_map_rc  -  map return type based on opcode
> @@ -165,7 +166,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
>   		if (!crsqe->is_in_used)
>   			return 0;
>   
> -		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
> +		bnxt_qplib_service_creq(&rcfw->creq.creq_work);
>   
>   		if (!crsqe->is_in_used)
>   			return 0;
> @@ -206,7 +207,7 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
>   
>   		udelay(1);
>   
> -		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
> +		bnxt_qplib_service_creq(&rcfw->creq.creq_work);
>   		if (!crsqe->is_in_used)
>   			return 0;
>   
> @@ -403,7 +404,7 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
>   
>   		usleep_range(1000, 1001);
>   
> -		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
> +		bnxt_qplib_service_creq(&rcfw->creq.creq_work);
>   		if (!crsqe->is_in_used)
>   			return 0;
>   		if (jiffies_to_msecs(jiffies - issue_time) >
> @@ -727,9 +728,9 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
>   }
>   
>   /* SP - CREQ Completion handlers */
> -static void bnxt_qplib_service_creq(struct tasklet_struct *t)
> +static void bnxt_qplib_service_creq(struct work_struct *t)
>   {
> -	struct bnxt_qplib_rcfw *rcfw = from_tasklet(rcfw, t, creq.creq_tasklet);
> +	struct bnxt_qplib_rcfw *rcfw = from_work(rcfw, t, creq.creq_work);
>   	struct bnxt_qplib_creq_ctx *creq = &rcfw->creq;
>   	u32 type, budget = CREQ_ENTRY_POLL_BUDGET;
>   	struct bnxt_qplib_hwq *hwq = &creq->hwq;
> @@ -800,7 +801,7 @@ static irqreturn_t bnxt_qplib_creq_irq(int irq, void *dev_instance)
>   	sw_cons = HWQ_CMP(hwq->cons, hwq);
>   	prefetch(bnxt_qplib_get_qe(hwq, sw_cons, NULL));
>   
> -	tasklet_schedule(&creq->creq_tasklet);
> +	queue_work(system_bh_wq, &creq->creq_work);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -1007,8 +1008,8 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
>   	creq->irq_name = NULL;
>   	atomic_set(&rcfw->rcfw_intr_enabled, 0);
>   	if (kill)
> -		tasklet_kill(&creq->creq_tasklet);
> -	tasklet_disable(&creq->creq_tasklet);
> +		cancel_work_sync(&creq->creq_work);
> +	disable_work_sync(&creq->creq_work);
>   }
>   
>   void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
> @@ -1045,9 +1046,9 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
>   
>   	creq->msix_vec = msix_vector;
>   	if (need_init)
> -		tasklet_setup(&creq->creq_tasklet, bnxt_qplib_service_creq);
> +		INIT_WORK(&creq->creq_work, bnxt_qplib_service_creq);
>   	else
> -		tasklet_enable(&creq->creq_tasklet);
> +		enable_and_queue_work(system_bh_wq, &creq->creq_work);
>   
>   	creq->irq_name = kasprintf(GFP_KERNEL, "bnxt_re-creq@pci:%s",
>   				   pci_name(res->pdev));
> @@ -1058,7 +1059,7 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
>   	if (rc) {
>   		kfree(creq->irq_name);
>   		creq->irq_name = NULL;
> -		tasklet_disable(&creq->creq_tasklet);
> +		disable_work_sync(&creq->creq_work);
>   		return rc;
>   	}
>   	creq->requested = true;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> index 45996e60a0d0..8efa474fcf3f 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> @@ -207,7 +207,7 @@ struct bnxt_qplib_creq_ctx {
>   	struct bnxt_qplib_hwq		hwq;
>   	struct bnxt_qplib_creq_db	creq_db;
>   	struct bnxt_qplib_creq_stat	stats;
> -	struct tasklet_struct		creq_tasklet;
> +	struct work_struct 		creq_work;
>   	aeq_handler_t			aeq_handler;
>   	u16				ring_id;
>   	int				msix_vec;
> diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
> index 5df401a30cb9..9a47c1432c27 100644
> --- a/drivers/infiniband/hw/erdma/erdma.h
> +++ b/drivers/infiniband/hw/erdma/erdma.h
> @@ -11,6 +11,7 @@
>   #include <linux/netdevice.h>
>   #include <linux/pci.h>
>   #include <linux/xarray.h>
> +#include <linux/workqueue.h>
>   #include <rdma/ib_verbs.h>
>   
>   #include "erdma_hw.h"
> @@ -161,7 +162,7 @@ struct erdma_eq_cb {
>   	void *dev; /* All EQs use this fields to get erdma_dev struct */
>   	struct erdma_irq irq;
>   	struct erdma_eq eq;
> -	struct tasklet_struct tasklet;
> +	struct work_struct work;
>   };
>   
>   struct erdma_resource_cb {
> diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
> index ea47cb21fdb8..252906fd73b0 100644
> --- a/drivers/infiniband/hw/erdma/erdma_eq.c
> +++ b/drivers/infiniband/hw/erdma/erdma_eq.c
> @@ -160,14 +160,16 @@ static irqreturn_t erdma_intr_ceq_handler(int irq, void *data)
>   {
>   	struct erdma_eq_cb *ceq_cb = data;
>   
> -	tasklet_schedule(&ceq_cb->tasklet);
> +	queue_work(system_bh_wq, &ceq_cb->work);
>   
>   	return IRQ_HANDLED;
>   }
>   
> -static void erdma_intr_ceq_task(unsigned long data)
> +static void erdma_intr_ceq_task(struct work_struct *t)
>   {
> -	erdma_ceq_completion_handler((struct erdma_eq_cb *)data);
> +	struct erdma_eq_cb *ceq_cb = from_work(ceq_cb, t, work);
> +
> +	erdma_ceq_completion_handler(ceq_cb);
>   }
>   
>   static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 ceqn)
> @@ -179,8 +181,7 @@ static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 ceqn)
>   		 pci_name(dev->pdev));
>   	eqc->irq.msix_vector = pci_irq_vector(dev->pdev, ceqn + 1);
>   
> -	tasklet_init(&dev->ceqs[ceqn].tasklet, erdma_intr_ceq_task,
> -		     (unsigned long)&dev->ceqs[ceqn]);
> +	INIT_WORK(&dev->ceqs[ceqn].work, erdma_intr_ceq_task);
>   
>   	cpumask_set_cpu(cpumask_local_spread(ceqn + 1, dev->attrs.numa_node),
>   			&eqc->irq.affinity_hint_mask);
> diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
> index b36242c9d42c..ec19ddbfdacb 100644
> --- a/drivers/infiniband/hw/hfi1/rc.c
> +++ b/drivers/infiniband/hw/hfi1/rc.c
> @@ -1210,7 +1210,7 @@ static inline void hfi1_queue_rc_ack(struct hfi1_packet *packet, bool is_fecn)
>   	if (is_fecn)
>   		qp->s_flags |= RVT_S_ECN;
>   
> -	/* Schedule the send tasklet. */
> +	/* Schedule the send work. */
>   	hfi1_schedule_send(qp);
>   unlock:
>   	spin_unlock_irqrestore(&qp->s_lock, flags);
> diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
> index b67d23b1f286..5e1a1dd45511 100644
> --- a/drivers/infiniband/hw/hfi1/sdma.c
> +++ b/drivers/infiniband/hw/hfi1/sdma.c
> @@ -11,6 +11,7 @@
>   #include <linux/timer.h>
>   #include <linux/vmalloc.h>
>   #include <linux/highmem.h>
> +#include <linux/workqueue.h>
>   
>   #include "hfi.h"
>   #include "common.h"
> @@ -190,11 +191,11 @@ static const struct sdma_set_state_action sdma_action_table[] = {
>   static void sdma_complete(struct kref *);
>   static void sdma_finalput(struct sdma_state *);
>   static void sdma_get(struct sdma_state *);
> -static void sdma_hw_clean_up_task(struct tasklet_struct *);
> +static void sdma_hw_clean_up_task(struct work_struct *);
>   static void sdma_put(struct sdma_state *);
>   static void sdma_set_state(struct sdma_engine *, enum sdma_states);
>   static void sdma_start_hw_clean_up(struct sdma_engine *);
> -static void sdma_sw_clean_up_task(struct tasklet_struct *);
> +static void sdma_sw_clean_up_task(struct work_struct *);
>   static void sdma_sendctrl(struct sdma_engine *, unsigned);
>   static void init_sdma_regs(struct sdma_engine *, u32, uint);
>   static void sdma_process_event(
> @@ -503,9 +504,9 @@ static void sdma_err_progress_check(struct timer_list *t)
>   	schedule_work(&sde->err_halt_worker);
>   }
>   
> -static void sdma_hw_clean_up_task(struct tasklet_struct *t)
> +static void sdma_hw_clean_up_task(struct work_struct *t)
>   {
> -	struct sdma_engine *sde = from_tasklet(sde, t,
> +	struct sdma_engine *sde = from_work(sde, t,
>   					       sdma_hw_clean_up_task);
>   	u64 statuscsr;
>   
> @@ -563,9 +564,9 @@ static void sdma_flush_descq(struct sdma_engine *sde)
>   		sdma_desc_avail(sde, sdma_descq_freecnt(sde));
>   }
>   
> -static void sdma_sw_clean_up_task(struct tasklet_struct *t)
> +static void sdma_sw_clean_up_task(struct work_struct *t)
>   {
> -	struct sdma_engine *sde = from_tasklet(sde, t, sdma_sw_clean_up_task);
> +	struct sdma_engine *sde = from_work(sde, t, sdma_sw_clean_up_task);
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&sde->tail_lock, flags);
> @@ -624,7 +625,7 @@ static void sdma_sw_tear_down(struct sdma_engine *sde)
>   
>   static void sdma_start_hw_clean_up(struct sdma_engine *sde)
>   {
> -	tasklet_hi_schedule(&sde->sdma_hw_clean_up_task);
> +	queue_work(system_bh_highpri_wq, &sde->sdma_hw_clean_up_task);
>   }
>   
>   static void sdma_set_state(struct sdma_engine *sde,
> @@ -1415,9 +1416,9 @@ int sdma_init(struct hfi1_devdata *dd, u8 port)
>   		sde->tail_csr =
>   			get_kctxt_csr_addr(dd, this_idx, SD(TAIL));
>   
> -		tasklet_setup(&sde->sdma_hw_clean_up_task,
> +		INIT_WORK(&sde->sdma_hw_clean_up_task,
>   			      sdma_hw_clean_up_task);
> -		tasklet_setup(&sde->sdma_sw_clean_up_task,
> +		INIT_WORK(&sde->sdma_sw_clean_up_task,
>   			      sdma_sw_clean_up_task);
>   		INIT_WORK(&sde->err_halt_worker, sdma_err_halt_wait);
>   		INIT_WORK(&sde->flush_worker, sdma_field_flush);
> @@ -2741,7 +2742,7 @@ static void __sdma_process_event(struct sdma_engine *sde,
>   		switch (event) {
>   		case sdma_event_e00_go_hw_down:
>   			sdma_set_state(sde, sdma_state_s00_hw_down);
> -			tasklet_hi_schedule(&sde->sdma_sw_clean_up_task);
> +			queue_work(system_bh_highpri_wq, &sde->sdma_sw_clean_up_task);
>   			break;
>   		case sdma_event_e10_go_hw_start:
>   			break;
> @@ -2783,13 +2784,13 @@ static void __sdma_process_event(struct sdma_engine *sde,
>   		switch (event) {
>   		case sdma_event_e00_go_hw_down:
>   			sdma_set_state(sde, sdma_state_s00_hw_down);
> -			tasklet_hi_schedule(&sde->sdma_sw_clean_up_task);
> +			queue_work(system_bh_highpri_wq, &sde->sdma_sw_clean_up_task);
>   			break;
>   		case sdma_event_e10_go_hw_start:
>   			break;
>   		case sdma_event_e15_hw_halt_done:
>   			sdma_set_state(sde, sdma_state_s30_sw_clean_up_wait);
> -			tasklet_hi_schedule(&sde->sdma_sw_clean_up_task);
> +			queue_work(system_bh_highpri_wq, &sde->sdma_sw_clean_up_task);
>   			break;
>   		case sdma_event_e25_hw_clean_up_done:
>   			break;
> @@ -2824,13 +2825,13 @@ static void __sdma_process_event(struct sdma_engine *sde,
>   		switch (event) {
>   		case sdma_event_e00_go_hw_down:
>   			sdma_set_state(sde, sdma_state_s00_hw_down);
> -			tasklet_hi_schedule(&sde->sdma_sw_clean_up_task);
> +			queue_work(system_bh_highpri_wq, &sde->sdma_sw_clean_up_task);
>   			break;
>   		case sdma_event_e10_go_hw_start:
>   			break;
>   		case sdma_event_e15_hw_halt_done:
>   			sdma_set_state(sde, sdma_state_s30_sw_clean_up_wait);
> -			tasklet_hi_schedule(&sde->sdma_sw_clean_up_task);
> +			queue_work(system_bh_highpri_wq, &sde->sdma_sw_clean_up_task);
>   			break;
>   		case sdma_event_e25_hw_clean_up_done:
>   			break;
> @@ -2864,7 +2865,7 @@ static void __sdma_process_event(struct sdma_engine *sde,
>   		switch (event) {
>   		case sdma_event_e00_go_hw_down:
>   			sdma_set_state(sde, sdma_state_s00_hw_down);
> -			tasklet_hi_schedule(&sde->sdma_sw_clean_up_task);
> +			queue_work(system_bh_highpri_wq, &sde->sdma_sw_clean_up_task);
>   			break;
>   		case sdma_event_e10_go_hw_start:
>   			break;
> @@ -2888,7 +2889,7 @@ static void __sdma_process_event(struct sdma_engine *sde,
>   			break;
>   		case sdma_event_e81_hw_frozen:
>   			sdma_set_state(sde, sdma_state_s82_freeze_sw_clean);
> -			tasklet_hi_schedule(&sde->sdma_sw_clean_up_task);
> +			queue_work(system_bh_highpri_wq, &sde->sdma_sw_clean_up_task);
>   			break;
>   		case sdma_event_e82_hw_unfreeze:
>   			break;
> @@ -2903,7 +2904,7 @@ static void __sdma_process_event(struct sdma_engine *sde,
>   		switch (event) {
>   		case sdma_event_e00_go_hw_down:
>   			sdma_set_state(sde, sdma_state_s00_hw_down);
> -			tasklet_hi_schedule(&sde->sdma_sw_clean_up_task);
> +			queue_work(system_bh_highpri_wq, &sde->sdma_sw_clean_up_task);
>   			break;
>   		case sdma_event_e10_go_hw_start:
>   			break;
> @@ -2947,7 +2948,7 @@ static void __sdma_process_event(struct sdma_engine *sde,
>   		switch (event) {
>   		case sdma_event_e00_go_hw_down:
>   			sdma_set_state(sde, sdma_state_s00_hw_down);
> -			tasklet_hi_schedule(&sde->sdma_sw_clean_up_task);
> +			queue_work(system_bh_highpri_wq, &sde->sdma_sw_clean_up_task);
>   			break;
>   		case sdma_event_e10_go_hw_start:
>   			break;
> diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
> index d77246b48434..3f047260cebe 100644
> --- a/drivers/infiniband/hw/hfi1/sdma.h
> +++ b/drivers/infiniband/hw/hfi1/sdma.h
> @@ -11,6 +11,7 @@
>   #include <asm/byteorder.h>
>   #include <linux/workqueue.h>
>   #include <linux/rculist.h>
> +#include <linux/workqueue.h>
>   
>   #include "hfi.h"
>   #include "verbs.h"
> @@ -346,11 +347,11 @@ struct sdma_engine {
>   
>   	/* CONFIG SDMA for now, just blindly duplicate */
>   	/* private: */
> -	struct tasklet_struct sdma_hw_clean_up_task
> +	struct work_struct sdma_hw_clean_up_task
>   		____cacheline_aligned_in_smp;
>   
>   	/* private: */
> -	struct tasklet_struct sdma_sw_clean_up_task
> +	struct work_struct sdma_sw_clean_up_task
>   		____cacheline_aligned_in_smp;
>   	/* private: */
>   	struct work_struct err_halt_worker;
> @@ -471,7 +472,7 @@ void _sdma_txreq_ahgadd(
>    * Completions of submitted requests can be gotten on selected
>    * txreqs by giving a completion routine callback to sdma_txinit() or
>    * sdma_txinit_ahg().  The environment in which the callback runs
> - * can be from an ISR, a tasklet, or a thread, so no sleeping
> + * can be from an ISR, a work, or a thread, so no sleeping
>    * kernel routines can be used.   Aspects of the sdma ring may
>    * be locked so care should be taken with locking.
>    *
> @@ -551,7 +552,7 @@ static inline int sdma_txinit_ahg(
>    * Completions of submitted requests can be gotten on selected
>    * txreqs by giving a completion routine callback to sdma_txinit() or
>    * sdma_txinit_ahg().  The environment in which the callback runs
> - * can be from an ISR, a tasklet, or a thread, so no sleeping
> + * can be from an ISR, a work, or a thread, so no sleeping
>    * kernel routines can be used.   The head size of the sdma ring may
>    * be locked so care should be taken with locking.
>    *
> diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
> index c465966a1d9c..31cb5a092f42 100644
> --- a/drivers/infiniband/hw/hfi1/tid_rdma.c
> +++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
> @@ -2316,7 +2316,7 @@ void hfi1_rc_rcv_tid_rdma_read_req(struct hfi1_packet *packet)
>   	 */
>   	qpriv->r_tid_alloc = qp->r_head_ack_queue;
>   
> -	/* Schedule the send tasklet. */
> +	/* Schedule the send work. */
>   	qp->s_flags |= RVT_S_RESP_PENDING;
>   	if (fecn)
>   		qp->s_flags |= RVT_S_ECN;
> @@ -3807,7 +3807,7 @@ void hfi1_rc_rcv_tid_rdma_write_req(struct hfi1_packet *packet)
>   	hfi1_tid_write_alloc_resources(qp, true);
>   	trace_hfi1_tid_write_rsp_rcv_req(qp);
>   
> -	/* Schedule the send tasklet. */
> +	/* Schedule the send work. */
>   	qp->s_flags |= RVT_S_RESP_PENDING;
>   	if (fecn)
>   		qp->s_flags |= RVT_S_ECN;
> @@ -5389,7 +5389,7 @@ static void hfi1_do_tid_send(struct rvt_qp *qp)
>   
>   			/*
>   			 * If the packet cannot be sent now, return and
> -			 * the send tasklet will be woken up later.
> +			 * the send work will be woken up later.
>   			 */
>   			if (hfi1_verbs_send(qp, &ps))
>   				return;
> diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
> index 6aed6169c07d..e9644f2b774d 100644
> --- a/drivers/infiniband/hw/irdma/ctrl.c
> +++ b/drivers/infiniband/hw/irdma/ctrl.c
> @@ -5271,7 +5271,7 @@ int irdma_process_cqp_cmd(struct irdma_sc_dev *dev,
>   }
>   
>   /**
> - * irdma_process_bh - called from tasklet for cqp list
> + * irdma_process_bh - called from work for cqp list
>    * @dev: sc device struct
>    */
>   int irdma_process_bh(struct irdma_sc_dev *dev)
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> index ad50b77282f8..18d552919c28 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -440,12 +440,12 @@ static void irdma_ena_intr(struct irdma_sc_dev *dev, u32 msix_id)
>   }
>   
>   /**
> - * irdma_dpc - tasklet for aeq and ceq 0
> - * @t: tasklet_struct ptr
> + * irdma_dpc - work for aeq and ceq 0
> + * @t: work_struct ptr
>    */
> -static void irdma_dpc(struct tasklet_struct *t)
> +static void irdma_dpc(struct work_struct *t)
>   {
> -	struct irdma_pci_f *rf = from_tasklet(rf, t, dpc_tasklet);
> +	struct irdma_pci_f *rf = from_work(rf, t, dpc_work);
>   
>   	if (rf->msix_shared)
>   		irdma_process_ceq(rf, rf->ceqlist);
> @@ -455,11 +455,11 @@ static void irdma_dpc(struct tasklet_struct *t)
>   
>   /**
>    * irdma_ceq_dpc - dpc handler for CEQ
> - * @t: tasklet_struct ptr
> + * @t: work_struct ptr
>    */
> -static void irdma_ceq_dpc(struct tasklet_struct *t)
> +static void irdma_ceq_dpc(struct work_struct *t)
>   {
> -	struct irdma_ceq *iwceq = from_tasklet(iwceq, t, dpc_tasklet);
> +	struct irdma_ceq *iwceq = from_work(iwceq, t, dpc_work);
>   	struct irdma_pci_f *rf = iwceq->rf;
>   
>   	irdma_process_ceq(rf, iwceq);
> @@ -533,7 +533,7 @@ static irqreturn_t irdma_irq_handler(int irq, void *data)
>   {
>   	struct irdma_pci_f *rf = data;
>   
> -	tasklet_schedule(&rf->dpc_tasklet);
> +	queue_work(system_bh_wq, &rf->dpc_work);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -550,7 +550,7 @@ static irqreturn_t irdma_ceq_handler(int irq, void *data)
>   	if (iwceq->irq != irq)
>   		ibdev_err(to_ibdev(&iwceq->rf->sc_dev), "expected irq = %d received irq = %d\n",
>   			  iwceq->irq, irq);
> -	tasklet_schedule(&iwceq->dpc_tasklet);
> +	queue_work(system_bh_wq, &iwceq->dpc_work);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -1121,14 +1121,14 @@ static int irdma_cfg_ceq_vector(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
>   	if (rf->msix_shared && !ceq_id) {
>   		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
>   			 "irdma-%s-AEQCEQ-0", dev_name(&rf->pcidev->dev));
> -		tasklet_setup(&rf->dpc_tasklet, irdma_dpc);
> +		INIT_WORK(&rf->dpc_work, irdma_dpc);
>   		status = request_irq(msix_vec->irq, irdma_irq_handler, 0,
>   				     msix_vec->name, rf);
>   	} else {
>   		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
>   			 "irdma-%s-CEQ-%d",
>   			 dev_name(&rf->pcidev->dev), ceq_id);
> -		tasklet_setup(&iwceq->dpc_tasklet, irdma_ceq_dpc);
> +		INIT_WORK(&iwceq->dpc_work, irdma_ceq_dpc);
>   
>   		status = request_irq(msix_vec->irq, irdma_ceq_handler, 0,
>   				     msix_vec->name, iwceq);
> @@ -1162,7 +1162,7 @@ static int irdma_cfg_aeq_vector(struct irdma_pci_f *rf)
>   	if (!rf->msix_shared) {
>   		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
>   			 "irdma-%s-AEQ", dev_name(&rf->pcidev->dev));
> -		tasklet_setup(&rf->dpc_tasklet, irdma_dpc);
> +		INIT_WORK(&rf->dpc_work, irdma_dpc);
>   		ret = request_irq(msix_vec->irq, irdma_irq_handler, 0,
>   				  msix_vec->name, rf);
>   	}
> diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
> index b65bc2ea542f..54301093b746 100644
> --- a/drivers/infiniband/hw/irdma/main.h
> +++ b/drivers/infiniband/hw/irdma/main.h
> @@ -30,6 +30,7 @@
>   #endif
>   #include <linux/auxiliary_bus.h>
>   #include <linux/net/intel/iidc.h>
> +#include <linux/workqueue.h>
>   #include <crypto/hash.h>
>   #include <rdma/ib_smi.h>
>   #include <rdma/ib_verbs.h>
> @@ -192,7 +193,7 @@ struct irdma_ceq {
>   	u32 irq;
>   	u32 msix_idx;
>   	struct irdma_pci_f *rf;
> -	struct tasklet_struct dpc_tasklet;
> +	struct work_struct dpc_work;
>   	spinlock_t ce_lock; /* sync cq destroy with cq completion event notification */
>   };
>   
> @@ -316,7 +317,7 @@ struct irdma_pci_f {
>   	struct mc_table_list mc_qht_list;
>   	struct irdma_msix_vector *iw_msixtbl;
>   	struct irdma_qvlist_info *iw_qvlist;
> -	struct tasklet_struct dpc_tasklet;
> +	struct work_struct dpc_work;
>   	struct msix_entry *msix_entries;
>   	struct irdma_dma_mem obj_mem;
>   	struct irdma_dma_mem obj_next;
> diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
> index 26c615772be3..d2ebaf31ce5a 100644
> --- a/drivers/infiniband/hw/qib/qib.h
> +++ b/drivers/infiniband/hw/qib/qib.h
> @@ -53,6 +53,7 @@
>   #include <linux/sched.h>
>   #include <linux/kthread.h>
>   #include <linux/xarray.h>
> +#include <linux/workqueue.h>
>   #include <rdma/ib_hdrs.h>
>   #include <rdma/rdma_vt.h>
>   
> @@ -562,7 +563,7 @@ struct qib_pportdata {
>   	u8                    sdma_generation;
>   	u8                    sdma_intrequest;
>   
> -	struct tasklet_struct sdma_sw_clean_up_task
> +	struct work_struct sdma_sw_clean_up_task
>   		____cacheline_aligned_in_smp;
>   
>   	wait_queue_head_t state_wait; /* for state_wanted */
> @@ -1068,8 +1069,8 @@ struct qib_devdata {
>   	u8 psxmitwait_supported;
>   	/* cycle length of PS* counters in HW (in picoseconds) */
>   	u16 psxmitwait_check_rate;
> -	/* high volume overflow errors defered to tasklet */
> -	struct tasklet_struct error_tasklet;
> +	/* high volume overflow errors defered to work */
> +	struct work_struct error_work;
>   
>   	int assigned_node_id; /* NUMA node closest to HCA */
>   };
> diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
> index f93906d8fc09..c3325071f2b3 100644
> --- a/drivers/infiniband/hw/qib/qib_iba7322.c
> +++ b/drivers/infiniband/hw/qib/qib_iba7322.c
> @@ -46,6 +46,7 @@
>   #include <rdma/ib_smi.h>
>   #ifdef CONFIG_INFINIBAND_QIB_DCA
>   #include <linux/dca.h>
> +#include <linux/workqueue.h>
>   #endif
>   
>   #include "qib.h"
> @@ -1711,9 +1712,9 @@ static noinline void handle_7322_errors(struct qib_devdata *dd)
>   	return;
>   }
>   
> -static void qib_error_tasklet(struct tasklet_struct *t)
> +static void qib_error_work(struct work_struct *t)
>   {
> -	struct qib_devdata *dd = from_tasklet(dd, t, error_tasklet);
> +	struct qib_devdata *dd = from_work(dd, t, error_work);
>   
>   	handle_7322_errors(dd);
>   	qib_write_kreg(dd, kr_errmask, dd->cspec->errormask);
> @@ -3001,7 +3002,7 @@ static noinline void unlikely_7322_intr(struct qib_devdata *dd, u64 istat)
>   		unknown_7322_gpio_intr(dd);
>   	if (istat & QIB_I_C_ERROR) {
>   		qib_write_kreg(dd, kr_errmask, 0ULL);
> -		tasklet_schedule(&dd->error_tasklet);
> +		queue_work(system_bh_wq, &dd->error_work);
>   	}
>   	if (istat & INT_MASK_P(Err, 0) && dd->rcd[0])
>   		handle_7322_p_errors(dd->rcd[0]->ppd);
> @@ -3515,7 +3516,7 @@ static void qib_setup_7322_interrupt(struct qib_devdata *dd, int clearpend)
>   	for (i = 0; i < ARRAY_SIZE(redirect); i++)
>   		qib_write_kreg(dd, kr_intredirect + i, redirect[i]);
>   	dd->cspec->main_int_mask = mask;
> -	tasklet_setup(&dd->error_tasklet, qib_error_tasklet);
> +	INIT_WORK(&dd->error_work, qib_error_work);
>   }
>   
>   /**
> diff --git a/drivers/infiniband/hw/qib/qib_rc.c b/drivers/infiniband/hw/qib/qib_rc.c
> index a1c20ffb4490..79e31921e384 100644
> --- a/drivers/infiniband/hw/qib/qib_rc.c
> +++ b/drivers/infiniband/hw/qib/qib_rc.c
> @@ -593,7 +593,7 @@ int qib_make_rc_req(struct rvt_qp *qp, unsigned long *flags)
>    *
>    * This is called from qib_rc_rcv() and qib_kreceive().
>    * Note that RDMA reads and atomics are handled in the
> - * send side QP state and tasklet.
> + * send side QP state and work.
>    */
>   void qib_send_rc_ack(struct rvt_qp *qp)
>   {
> @@ -670,7 +670,7 @@ void qib_send_rc_ack(struct rvt_qp *qp)
>   		/*
>   		 * We are out of PIO buffers at the moment.
>   		 * Pass responsibility for sending the ACK to the
> -		 * send tasklet so that when a PIO buffer becomes
> +		 * send work so that when a PIO buffer becomes
>   		 * available, the ACK is sent ahead of other outgoing
>   		 * packets.
>   		 */
> @@ -715,7 +715,7 @@ void qib_send_rc_ack(struct rvt_qp *qp)
>   		qp->s_nak_state = qp->r_nak_state;
>   		qp->s_ack_psn = qp->r_ack_psn;
>   
> -		/* Schedule the send tasklet. */
> +		/* Schedule the send work. */
>   		qib_schedule_send(qp);
>   	}
>   unlock:
> @@ -806,7 +806,7 @@ static void reset_psn(struct rvt_qp *qp, u32 psn)
>   	qp->s_psn = psn;
>   	/*
>   	 * Set RVT_S_WAIT_PSN as qib_rc_complete() may start the timer
> -	 * asynchronously before the send tasklet can get scheduled.
> +	 * asynchronously before the send work can get scheduled.
>   	 * Doing it in qib_make_rc_req() is too late.
>   	 */
>   	if ((qib_cmp24(qp->s_psn, qp->s_sending_hpsn) <= 0) &&
> @@ -1292,7 +1292,7 @@ static void qib_rc_rcv_resp(struct qib_ibport *ibp,
>   		    (qib_cmp24(qp->s_sending_psn, qp->s_sending_hpsn) <= 0)) {
>   
>   			/*
> -			 * If send tasklet not running attempt to progress
> +			 * If send work not running attempt to progress
>   			 * SDMA queue.
>   			 */
>   			if (!(qp->s_flags & RVT_S_BUSY)) {
> @@ -1629,7 +1629,7 @@ static int qib_rc_rcv_error(struct ib_other_headers *ohdr,
>   	case OP(FETCH_ADD): {
>   		/*
>   		 * If we didn't find the atomic request in the ack queue
> -		 * or the send tasklet is already backed up to send an
> +		 * or the send work is already backed up to send an
>   		 * earlier entry, we can ignore this request.
>   		 */
>   		if (!e || e->opcode != (u8) opcode || old_req)
> @@ -1996,7 +1996,7 @@ void qib_rc_rcv(struct qib_ctxtdata *rcd, struct ib_header *hdr,
>   		qp->r_nak_state = 0;
>   		qp->r_head_ack_queue = next;
>   
> -		/* Schedule the send tasklet. */
> +		/* Schedule the send work. */
>   		qp->s_flags |= RVT_S_RESP_PENDING;
>   		qib_schedule_send(qp);
>   
> @@ -2059,7 +2059,7 @@ void qib_rc_rcv(struct qib_ctxtdata *rcd, struct ib_header *hdr,
>   		qp->r_nak_state = 0;
>   		qp->r_head_ack_queue = next;
>   
> -		/* Schedule the send tasklet. */
> +		/* Schedule the send work. */
>   		qp->s_flags |= RVT_S_RESP_PENDING;
>   		qib_schedule_send(qp);
>   
> diff --git a/drivers/infiniband/hw/qib/qib_ruc.c b/drivers/infiniband/hw/qib/qib_ruc.c
> index 1fa21938f310..f44a2a8b4b1e 100644
> --- a/drivers/infiniband/hw/qib/qib_ruc.c
> +++ b/drivers/infiniband/hw/qib/qib_ruc.c
> @@ -257,7 +257,7 @@ void _qib_do_send(struct work_struct *work)
>    * @qp: pointer to the QP
>    *
>    * Process entries in the send work queue until credit or queue is
> - * exhausted.  Only allow one CPU to send a packet per QP (tasklet).
> + * exhausted.  Only allow one CPU to send a packet per QP (work).
>    * Otherwise, two threads could send packets out of order.
>    */
>   void qib_do_send(struct rvt_qp *qp)
> @@ -299,7 +299,7 @@ void qib_do_send(struct rvt_qp *qp)
>   			spin_unlock_irqrestore(&qp->s_lock, flags);
>   			/*
>   			 * If the packet cannot be sent now, return and
> -			 * the send tasklet will be woken up later.
> +			 * the send work will be woken up later.
>   			 */
>   			if (qib_verbs_send(qp, priv->s_hdr, qp->s_hdrwords,
>   					   qp->s_cur_sge, qp->s_cur_size))
> diff --git a/drivers/infiniband/hw/qib/qib_sdma.c b/drivers/infiniband/hw/qib/qib_sdma.c
> index 5e86cbf7d70e..facb3964d2ec 100644
> --- a/drivers/infiniband/hw/qib/qib_sdma.c
> +++ b/drivers/infiniband/hw/qib/qib_sdma.c
> @@ -34,6 +34,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/netdevice.h>
>   #include <linux/moduleparam.h>
> +#include <linux/workqueue.h>
>   
>   #include "qib.h"
>   #include "qib_common.h"
> @@ -62,7 +63,7 @@ static void sdma_get(struct qib_sdma_state *);
>   static void sdma_put(struct qib_sdma_state *);
>   static void sdma_set_state(struct qib_pportdata *, enum qib_sdma_states);
>   static void sdma_start_sw_clean_up(struct qib_pportdata *);
> -static void sdma_sw_clean_up_task(struct tasklet_struct *);
> +static void sdma_sw_clean_up_task(struct work_struct *);
>   static void unmap_desc(struct qib_pportdata *, unsigned);
>   
>   static void sdma_get(struct qib_sdma_state *ss)
> @@ -119,9 +120,9 @@ static void clear_sdma_activelist(struct qib_pportdata *ppd)
>   	}
>   }
>   
> -static void sdma_sw_clean_up_task(struct tasklet_struct *t)
> +static void sdma_sw_clean_up_task(struct work_struct *t)
>   {
> -	struct qib_pportdata *ppd = from_tasklet(ppd, t,
> +	struct qib_pportdata *ppd = from_work(ppd, t,
>   						 sdma_sw_clean_up_task);
>   	unsigned long flags;
>   
> @@ -188,7 +189,7 @@ static void sdma_sw_tear_down(struct qib_pportdata *ppd)
>   
>   static void sdma_start_sw_clean_up(struct qib_pportdata *ppd)
>   {
> -	tasklet_hi_schedule(&ppd->sdma_sw_clean_up_task);
> +	queue_work(system_bh_highpri_wq, &ppd->sdma_sw_clean_up_task);
>   }
>   
>   static void sdma_set_state(struct qib_pportdata *ppd,
> @@ -437,7 +438,7 @@ int qib_setup_sdma(struct qib_pportdata *ppd)
>   
>   	INIT_LIST_HEAD(&ppd->sdma_activelist);
>   
> -	tasklet_setup(&ppd->sdma_sw_clean_up_task, sdma_sw_clean_up_task);
> +	INIT_WORK(&ppd->sdma_sw_clean_up_task, sdma_sw_clean_up_task);
>   
>   	ret = dd->f_init_sdma_regs(ppd);
>   	if (ret)
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> index e6203e26cc06..efe4689151c2 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -1306,7 +1306,7 @@ int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err)
>   
>   	rdi->driver_f.notify_error_qp(qp);
>   
> -	/* Schedule the sending tasklet to drain the send work queue. */
> +	/* Schedule the sending work to drain the send work queue. */
>   	if (READ_ONCE(qp->s_last) != qp->s_head)
>   		rdi->driver_f.schedule_send(qp);
>   


