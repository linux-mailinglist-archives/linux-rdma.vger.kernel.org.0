Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA05E6284
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiIVMeZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 08:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiIVMeP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 08:34:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85DBE720B
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 05:34:12 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYF3Z1NhPz14S36;
        Thu, 22 Sep 2022 20:30:02 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:34:10 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:34:05 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 12/12] RDMA/hns: Unified Log Printing Style
Date:   Thu, 22 Sep 2022 20:33:15 +0800
Message-ID: <20220922123315.3732205-13-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
References: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guofeng Yue <yueguofeng@hisilicon.com>

The first letter of the log information is changed to lowercase
to keep the same style.

Signed-off-by: Guofeng Yue <yueguofeng@hisilicon.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  6 +--
 drivers/infiniband/hw/hns/hns_roce_hem.c   |  6 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 50 +++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_main.c  | 30 ++++++-------
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 16 +++----
 6 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 8acd599ffac1..736dc2f993b4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -454,7 +454,7 @@ void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn)
 	hr_cq = xa_load(&hr_dev->cq_table.array,
 			cqn & (hr_dev->caps.num_cqs - 1));
 	if (!hr_cq) {
-		dev_warn(hr_dev->dev, "Completion event for bogus CQ 0x%06x\n",
+		dev_warn(hr_dev->dev, "completion event for bogus CQ 0x%06x\n",
 			 cqn);
 		return;
 	}
@@ -475,14 +475,14 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 	hr_cq = xa_load(&hr_dev->cq_table.array,
 			cqn & (hr_dev->caps.num_cqs - 1));
 	if (!hr_cq) {
-		dev_warn(dev, "Async event for bogus CQ 0x%06x\n", cqn);
+		dev_warn(dev, "async event for bogus CQ 0x%06x\n", cqn);
 		return;
 	}
 
 	if (event_type != HNS_ROCE_EVENT_TYPE_CQ_ID_INVALID &&
 	    event_type != HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR &&
 	    event_type != HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW) {
-		dev_err(dev, "Unexpected event type 0x%x on CQ 0x%06x\n",
+		dev_err(dev, "unexpected event type 0x%x on CQ 0x%06x\n",
 			event_type, cqn);
 		return;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index d0b75a2234d3..aa8a08d1c014 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -926,7 +926,7 @@ void hns_roce_cleanup_hem_table(struct hns_roce_dev *hr_dev,
 		if (table->hem[i]) {
 			if (hr_dev->hw->clear_hem(hr_dev, table,
 			    i * table->table_chunk_size / table->obj_size, 0))
-				dev_err(dev, "Clear HEM base address failed.\n");
+				dev_err(dev, "clear HEM base address failed.\n");
 
 			hns_roce_free_hem(hr_dev, table->hem[i]);
 		}
@@ -1415,7 +1415,7 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 						    &hem_list->btm_bt);
 			if (ret) {
 				dev_err(hr_dev->dev,
-					"alloc hem trunk fail ret=%d!\n", ret);
+					"alloc hem trunk fail ret = %d!\n", ret);
 				goto err_alloc;
 			}
 		}
@@ -1424,7 +1424,7 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 	ret = hem_list_alloc_root_bt(hr_dev, hem_list, unit, regions,
 				     region_cnt);
 	if (ret)
-		dev_err(hr_dev->dev, "alloc hem root fail ret=%d!\n", ret);
+		dev_err(hr_dev->dev, "alloc hem root fail ret = %d!\n", ret);
 	else
 		return 0;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fd4e767cd8de..2d0192057d1a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -380,7 +380,7 @@ static int check_send_valid(struct hns_roce_dev *hr_dev,
 	if (unlikely(ibqp->qp_type != IB_QPT_RC &&
 		     ibqp->qp_type != IB_QPT_GSI &&
 		     ibqp->qp_type != IB_QPT_UD)) {
-		ibdev_err(ibdev, "Not supported QP(0x%x)type!\n",
+		ibdev_err(ibdev, "not supported QP(0x%x)type!\n",
 			  ibqp->qp_type);
 		return -EOPNOTSUPP;
 	} else if (unlikely(hr_qp->state == IB_QPS_RESET ||
@@ -1405,20 +1405,20 @@ static void func_clr_hw_resetting_state(struct hns_roce_dev *hr_dev,
 	hr_dev->dis_db = true;
 
 	dev_warn(hr_dev->dev,
-		 "Func clear is pending, device in resetting state.\n");
+		 "func clear is pending, device in resetting state.\n");
 	end = HNS_ROCE_V2_HW_RST_TIMEOUT;
 	while (end) {
 		if (!ops->get_hw_reset_stat(handle)) {
 			hr_dev->is_reset = true;
 			dev_info(hr_dev->dev,
-				 "Func clear success after reset.\n");
+				 "func clear success after reset.\n");
 			return;
 		}
 		msleep(HNS_ROCE_V2_HW_RST_COMPLETION_WAIT);
 		end -= HNS_ROCE_V2_HW_RST_COMPLETION_WAIT;
 	}
 
-	dev_warn(hr_dev->dev, "Func clear failed.\n");
+	dev_warn(hr_dev->dev, "func clear failed.\n");
 }
 
 static void func_clr_sw_resetting_state(struct hns_roce_dev *hr_dev,
@@ -1430,21 +1430,21 @@ static void func_clr_sw_resetting_state(struct hns_roce_dev *hr_dev,
 	hr_dev->dis_db = true;
 
 	dev_warn(hr_dev->dev,
-		 "Func clear is pending, device in resetting state.\n");
+		 "func clear is pending, device in resetting state.\n");
 	end = HNS_ROCE_V2_HW_RST_TIMEOUT;
 	while (end) {
 		if (ops->ae_dev_reset_cnt(handle) !=
 		    hr_dev->reset_cnt) {
 			hr_dev->is_reset = true;
 			dev_info(hr_dev->dev,
-				 "Func clear success after sw reset\n");
+				 "func clear success after sw reset\n");
 			return;
 		}
 		msleep(HNS_ROCE_V2_HW_RST_COMPLETION_WAIT);
 		end -= HNS_ROCE_V2_HW_RST_COMPLETION_WAIT;
 	}
 
-	dev_warn(hr_dev->dev, "Func clear failed because of unfinished sw reset\n");
+	dev_warn(hr_dev->dev, "func clear failed because of unfinished sw reset\n");
 }
 
 static void hns_roce_func_clr_rst_proc(struct hns_roce_dev *hr_dev, int retval,
@@ -1457,7 +1457,7 @@ static void hns_roce_func_clr_rst_proc(struct hns_roce_dev *hr_dev, int retval,
 	if (ops->ae_dev_reset_cnt(handle) != hr_dev->reset_cnt) {
 		hr_dev->dis_db = true;
 		hr_dev->is_reset = true;
-		dev_info(hr_dev->dev, "Func clear success after reset.\n");
+		dev_info(hr_dev->dev, "func clear success after reset.\n");
 		return;
 	}
 
@@ -1474,9 +1474,9 @@ static void hns_roce_func_clr_rst_proc(struct hns_roce_dev *hr_dev, int retval,
 
 	if (retval && !flag)
 		dev_warn(hr_dev->dev,
-			 "Func clear read failed, ret = %d.\n", retval);
+			 "func clear read failed, ret = %d.\n", retval);
 
-	dev_warn(hr_dev->dev, "Func clear failed.\n");
+	dev_warn(hr_dev->dev, "func clear failed.\n");
 }
 
 static void __hns_roce_function_clear(struct hns_roce_dev *hr_dev, int vf_id)
@@ -1497,7 +1497,7 @@ static void __hns_roce_function_clear(struct hns_roce_dev *hr_dev, int vf_id)
 	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
 	if (ret) {
 		fclr_write_fail_flag = true;
-		dev_err(hr_dev->dev, "Func clear write failed, ret = %d.\n",
+		dev_err(hr_dev->dev, "func clear write failed, ret = %d.\n",
 			 ret);
 		goto out;
 	}
@@ -5033,14 +5033,14 @@ static bool check_qp_timeout_cfg_range(struct hns_roce_dev *hr_dev, u8 *timeout)
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
 		if (*timeout > QP_ACK_TIMEOUT_MAX_HIP08) {
 			ibdev_warn(&hr_dev->ib_dev,
-				   "Local ACK timeout shall be 0 to 20.\n");
+				   "local ACK timeout shall be 0 to 20.\n");
 			return false;
 		}
 		*timeout += QP_ACK_TIMEOUT_OFFSET;
 	} else if (hr_dev->pci_dev->revision > PCI_REVISION_ID_HIP08) {
 		if (*timeout > QP_ACK_TIMEOUT_MAX) {
 			ibdev_warn(&hr_dev->ib_dev,
-				   "Local ACK timeout shall be 0 to 31.\n");
+				   "local ACK timeout shall be 0 to 31.\n");
 			return false;
 		}
 	}
@@ -5543,7 +5543,7 @@ static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
 		msleep(20);
 	}
 
-	ibdev_err(ibdev, "Query SCC clr done flag overtime.\n");
+	ibdev_err(ibdev, "query SCC clr done flag overtime.\n");
 	ret = -ETIMEDOUT;
 
 out:
@@ -5832,26 +5832,26 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 
 	switch (irq_work->event_type) {
 	case HNS_ROCE_EVENT_TYPE_PATH_MIG:
-		ibdev_info(ibdev, "Path migrated succeeded.\n");
+		ibdev_info(ibdev, "path migrated succeeded.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_PATH_MIG_FAILED:
-		ibdev_warn(ibdev, "Path migration failed.\n");
+		ibdev_warn(ibdev, "path migration failed.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_COMM_EST:
 		break;
 	case HNS_ROCE_EVENT_TYPE_SQ_DRAINED:
-		ibdev_warn(ibdev, "Send queue drained.\n");
+		ibdev_warn(ibdev, "send queue drained.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR:
-		ibdev_err(ibdev, "Local work queue 0x%x catast error, sub_event type is: %d\n",
+		ibdev_err(ibdev, "local work queue 0x%x catast error, sub_event type is: %d\n",
 			  irq_work->queue_num, irq_work->sub_type);
 		break;
 	case HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR:
-		ibdev_err(ibdev, "Invalid request local work queue 0x%x error.\n",
+		ibdev_err(ibdev, "invalid request local work queue 0x%x error.\n",
 			  irq_work->queue_num);
 		break;
 	case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
-		ibdev_err(ibdev, "Local access violation work queue 0x%x error, sub_event type is: %d\n",
+		ibdev_err(ibdev, "local access violation work queue 0x%x error, sub_event type is: %d\n",
 			  irq_work->queue_num, irq_work->sub_type);
 		break;
 	case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
@@ -5873,7 +5873,7 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 		ibdev_warn(ibdev, "DB overflow.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_FLR:
-		ibdev_warn(ibdev, "Function level reset.\n");
+		ibdev_warn(ibdev, "function level reset.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_XRCD_VIOLATION:
 		ibdev_err(ibdev, "xrc domain violation error.\n");
@@ -5992,7 +5992,7 @@ static irqreturn_t hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		case HNS_ROCE_EVENT_TYPE_FLR:
 			break;
 		default:
-			dev_err(dev, "Unhandled event %d on EQ %d at idx %u.\n",
+			dev_err(dev, "unhandled event %d on EQ %d at idx %u.\n",
 				event_type, eq->eqn, eq->cons_index);
 			break;
 		}
@@ -6383,7 +6383,7 @@ static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 				  hr_dev->caps.eqe_ba_pg_sz + PAGE_SHIFT, NULL,
 				  0);
 	if (err)
-		dev_err(hr_dev->dev, "Failed to alloc EQE mtr, err %d\n", err);
+		dev_err(hr_dev->dev, "failed to alloc EQE mtr, err %d\n", err);
 
 	return err;
 }
@@ -6472,7 +6472,7 @@ static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
 					  0, hr_dev->irq_names[j - comp_num],
 					  &eq_table->eq[j - other_num]);
 		if (ret) {
-			dev_err(hr_dev->dev, "Request irq error!\n");
+			dev_err(hr_dev->dev, "request irq error!\n");
 			goto err_request_failed;
 		}
 	}
@@ -6894,7 +6894,7 @@ static int hns_roce_hw_v2_reset_notify_init(struct hnae3_handle *handle)
 		dev_err(dev, "In reset process RoCE reinit failed %d.\n", ret);
 	} else {
 		handle->rinfo.reset_state = HNS_ROCE_STATE_RST_INITED;
-		dev_info(dev, "Reset done, RoCE client reinit finished.\n");
+		dev_info(dev, "reset done, RoCE client reinit finished.\n");
 	}
 
 	return ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 498d7c28c56c..53c53c20360d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -97,7 +97,7 @@ static int handle_en_event(struct hns_roce_dev *hr_dev, u32 port,
 
 	netdev = hr_dev->iboe.netdevs[port];
 	if (!netdev) {
-		dev_err(dev, "Can't find netdev on port(%u)!\n", port);
+		dev_err(dev, "can't find netdev on port(%u)!\n", port);
 		return -ENODEV;
 	}
 
@@ -239,7 +239,7 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u32 port_num,
 	net_dev = hr_dev->iboe.netdevs[port];
 	if (!net_dev) {
 		spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
-		dev_err(dev, "Find netdev %u failed!\n", port);
+		dev_err(dev, "find netdev %u failed!\n", port);
 		return -EINVAL;
 	}
 
@@ -661,7 +661,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 				      HEM_TYPE_MTPT, hr_dev->caps.mtpt_entry_sz,
 				      hr_dev->caps.num_mtpts);
 	if (ret) {
-		dev_err(dev, "Failed to init MTPT context memory, aborting.\n");
+		dev_err(dev, "failed to init MTPT context memory, aborting.\n");
 		return ret;
 	}
 
@@ -669,7 +669,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 				      HEM_TYPE_QPC, hr_dev->caps.qpc_sz,
 				      hr_dev->caps.num_qps);
 	if (ret) {
-		dev_err(dev, "Failed to init QP context memory, aborting.\n");
+		dev_err(dev, "failed to init QP context memory, aborting.\n");
 		goto err_unmap_dmpt;
 	}
 
@@ -679,7 +679,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 				      hr_dev->caps.max_qp_init_rdma,
 				      hr_dev->caps.num_qps);
 	if (ret) {
-		dev_err(dev, "Failed to init irrl_table memory, aborting.\n");
+		dev_err(dev, "failed to init irrl_table memory, aborting.\n");
 		goto err_unmap_qp;
 	}
 
@@ -692,7 +692,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 					      hr_dev->caps.num_qps);
 		if (ret) {
 			dev_err(dev,
-				"Failed to init trrl_table memory, aborting.\n");
+				"failed to init trrl_table memory, aborting.\n");
 			goto err_unmap_irrl;
 		}
 	}
@@ -701,7 +701,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 				      HEM_TYPE_CQC, hr_dev->caps.cqc_entry_sz,
 				      hr_dev->caps.num_cqs);
 	if (ret) {
-		dev_err(dev, "Failed to init CQ context memory, aborting.\n");
+		dev_err(dev, "failed to init CQ context memory, aborting.\n");
 		goto err_unmap_trrl;
 	}
 
@@ -712,7 +712,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 					      hr_dev->caps.num_srqs);
 		if (ret) {
 			dev_err(dev,
-				"Failed to init SRQ context memory, aborting.\n");
+				"failed to init SRQ context memory, aborting.\n");
 			goto err_unmap_cq;
 		}
 	}
@@ -725,7 +725,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 					      hr_dev->caps.num_qps);
 		if (ret) {
 			dev_err(dev,
-				"Failed to init SCC context memory, aborting.\n");
+				"failed to init SCC context memory, aborting.\n");
 			goto err_unmap_srq;
 		}
 	}
@@ -737,7 +737,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 					      hr_dev->caps.num_qpc_timer);
 		if (ret) {
 			dev_err(dev,
-				"Failed to init QPC timer memory, aborting.\n");
+				"failed to init QPC timer memory, aborting.\n");
 			goto err_unmap_ctx;
 		}
 	}
@@ -749,7 +749,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 					      hr_dev->caps.cqc_timer_bt_num);
 		if (ret) {
 			dev_err(dev,
-				"Failed to init CQC timer memory, aborting.\n");
+				"failed to init CQC timer memory, aborting.\n");
 			goto err_unmap_qpc_timer;
 		}
 	}
@@ -827,13 +827,13 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 	ret = hns_roce_uar_alloc(hr_dev, &hr_dev->priv_uar);
 	if (ret) {
-		dev_err(dev, "Failed to allocate priv_uar.\n");
+		dev_err(dev, "failed to allocate priv_uar.\n");
 		goto err_uar_table_free;
 	}
 
 	ret = hns_roce_init_qp_table(hr_dev);
 	if (ret) {
-		dev_err(dev, "Failed to init qp_table.\n");
+		dev_err(dev, "failed to init qp_table.\n");
 		goto err_uar_table_free;
 	}
 
@@ -910,14 +910,14 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 	if (hr_dev->hw->cmq_init) {
 		ret = hr_dev->hw->cmq_init(hr_dev);
 		if (ret) {
-			dev_err(dev, "Init RoCE Command Queue failed!\n");
+			dev_err(dev, "init RoCE Command Queue failed!\n");
 			return ret;
 		}
 	}
 
 	ret = hr_dev->hw->hw_profile(hr_dev);
 	if (ret) {
-		dev_err(dev, "Get RoCE engine profile failed!\n");
+		dev_err(dev, "get RoCE engine profile failed!\n");
 		goto error_failed_cmd_init;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index a36afc77b3ae..dd42ff81a96e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -190,7 +190,7 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
 	int ret;
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
-	if (mr == NULL)
+	if (!mr)
 		return  ERR_PTR(-ENOMEM);
 
 	mr->type = MR_TYPE_DMA;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 52ba194d7ae3..a546e934b887 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -56,7 +56,7 @@ static void flush_work_handle(struct work_struct *work)
 	if (test_and_clear_bit(HNS_ROCE_FLUSH_FLAG, &hr_qp->flush_flag)) {
 		ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
 		if (ret)
-			dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
+			dev_err(dev, "modify QP to error state failed(%d) during CQE flush\n",
 				ret);
 	}
 
@@ -105,7 +105,7 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 	xa_unlock(&hr_dev->qp_table_xa);
 
 	if (!qp) {
-		dev_warn(dev, "Async event for bogus QP %08x\n", qpn);
+		dev_warn(dev, "async event for bogus QP %08x\n", qpn);
 		return;
 	}
 
@@ -275,7 +275,7 @@ static int hns_roce_qp_store(struct hns_roce_dev *hr_dev,
 
 	ret = xa_err(xa_store_irq(xa, hr_qp->qpn, hr_qp, GFP_KERNEL));
 	if (ret)
-		dev_err(hr_dev->dev, "Failed to xa store for QPC\n");
+		dev_err(hr_dev->dev, "failed to xa store for QPC\n");
 	else
 		/* add QP to device's QP list for softwc */
 		add_qp_to_list(hr_dev, hr_qp, init_attr->send_cq,
@@ -296,14 +296,14 @@ static int alloc_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	/* Alloc memory for QPC */
 	ret = hns_roce_table_get(hr_dev, &qp_table->qp_table, hr_qp->qpn);
 	if (ret) {
-		dev_err(dev, "Failed to get QPC table\n");
+		dev_err(dev, "failed to get QPC table\n");
 		goto err_out;
 	}
 
 	/* Alloc memory for IRRL */
 	ret = hns_roce_table_get(hr_dev, &qp_table->irrl_table, hr_qp->qpn);
 	if (ret) {
-		dev_err(dev, "Failed to get IRRL table\n");
+		dev_err(dev, "failed to get IRRL table\n");
 		goto err_put_qp;
 	}
 
@@ -312,7 +312,7 @@ static int alloc_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		ret = hns_roce_table_get(hr_dev, &qp_table->trrl_table,
 					 hr_qp->qpn);
 		if (ret) {
-			dev_err(dev, "Failed to get TRRL table\n");
+			dev_err(dev, "failed to get TRRL table\n");
 			goto err_put_irrl;
 		}
 	}
@@ -322,7 +322,7 @@ static int alloc_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		ret = hns_roce_table_get(hr_dev, &qp_table->sccc_table,
 					 hr_qp->qpn);
 		if (ret) {
-			dev_err(dev, "Failed to get SCC CTX table\n");
+			dev_err(dev, "failed to get SCC CTX table\n");
 			goto err_put_trrl;
 		}
 	}
@@ -1206,7 +1206,7 @@ int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 
 	ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata, hr_qp);
 	if (ret)
-		ibdev_err(ibdev, "Create QP type 0x%x failed(%d)\n",
+		ibdev_err(ibdev, "create QP type 0x%x failed(%d)\n",
 			  init_attr->qp_type, ret);
 
 	return ret;
-- 
2.30.0

