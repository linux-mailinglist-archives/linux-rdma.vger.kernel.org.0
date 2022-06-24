Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55557559850
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiFXLK0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 07:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiFXLKY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 07:10:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C6856746
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 04:10:22 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LTvVg1R4bzdZPF;
        Fri, 24 Jun 2022 19:08:11 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 19:10:21 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 19:10:21 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 5/5] RDMA/hns: Recover 1bit-ECC error of RAM on chip
Date:   Fri, 24 Jun 2022 19:08:45 +0800
Message-ID: <20220624110845.48184-6-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220624110845.48184-1-liangwenpeng@huawei.com>
References: <20220624110845.48184-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Haoyue Xu <xuhaoyue1@hisilicon.com>

Since ECC memory maintains a memory system immune to single-bit errors,
add support for correcting the 1bit-ECC error, which prevents a 1bit-ECC
error become an uncorrected type error. When a 1bit-ECC error happens in
the internal ram of the ROCE engine, such as the QPC table, as a 1bit-ECC
error caused by reading, the ROCE engine only corrects those 1bit ECC
errors by writing.

Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 195 +++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  12 ++
 2 files changed, 207 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 782f09a7f8af..f3be9817a755 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -55,6 +55,42 @@ enum {
 	CMD_RST_PRC_EBUSY,
 };
 
+enum ecc_resource_type {
+	ECC_RESOURCE_QPC = 0,
+	ECC_RESOURCE_CQC,
+	ECC_RESOURCE_MPT,
+	ECC_RESOURCE_SRQC,
+	ECC_RESOURCE_GMV,
+	ECC_RESOURCE_QPC_TIMER,
+	ECC_RESOURCE_CQC_TIMER,
+	ECC_RESOURCE_SCCC,
+	ECC_RESOURCE_COUNT,
+};
+
+static const struct {
+	char *name;
+	u8 read_bt0_op;
+	u8 write_bt0_op;
+} fmea_ram_res[] = {
+	{ "ECC_RESOURCE_QPC",
+	  HNS_ROCE_CMD_READ_QPC_BT0, HNS_ROCE_CMD_WRITE_QPC_BT0 },
+	{ "ECC_RESOURCE_CQC",
+	  HNS_ROCE_CMD_READ_CQC_BT0, HNS_ROCE_CMD_WRITE_CQC_BT0 },
+	{ "ECC_RESOURCE_MPT",
+	  HNS_ROCE_CMD_READ_MPT_BT0, HNS_ROCE_CMD_WRITE_MPT_BT0 },
+	{ "ECC_RESOURCE_SRQC",
+	  HNS_ROCE_CMD_READ_SRQC_BT0, HNS_ROCE_CMD_WRITE_SRQC_BT0 },
+	/* ECC_RESOURCE_GMV is handled by cmdq, not mailbox */
+	{ "ECC_RESOURCE_GMV",
+	  0, 0 },
+	{ "ECC_RESOURCE_QPC_TIMER",
+	  HNS_ROCE_CMD_READ_QPC_TIMER_BT0, HNS_ROCE_CMD_WRITE_QPC_TIMER_BT0 },
+	{ "ECC_RESOURCE_CQC_TIMER",
+	  HNS_ROCE_CMD_READ_CQC_TIMER_BT0, HNS_ROCE_CMD_WRITE_CQC_TIMER_BT0 },
+	{ "ECC_RESOURCE_SCCC",
+	  HNS_ROCE_CMD_READ_SCCC_BT0, HNS_ROCE_CMD_WRITE_SCCC_BT0 },
+};
+
 static inline void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
 				   struct ib_sge *sg)
 {
@@ -6017,6 +6053,163 @@ static irqreturn_t abnormal_interrupt_basic(struct hns_roce_dev *hr_dev,
 	return IRQ_RETVAL(int_work);
 }
 
+static int fmea_ram_ecc_query(struct hns_roce_dev *hr_dev,
+			       struct fmea_ram_ecc *ecc_info)
+{
+	struct hns_roce_cmq_desc desc;
+	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
+	int ret;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_QUERY_RAM_ECC, true);
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret)
+		return ret;
+
+	ecc_info->is_ecc_err = hr_reg_read(req, QUERY_RAM_ECC_1BIT_ERR);
+	ecc_info->res_type = hr_reg_read(req, QUERY_RAM_ECC_RES_TYPE);
+	ecc_info->index = hr_reg_read(req, QUERY_RAM_ECC_TAG);
+
+	return 0;
+}
+
+static int fmea_recover_gmv(struct hns_roce_dev *hr_dev, u32 idx)
+{
+	struct hns_roce_cmq_desc desc;
+	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
+	u32 addr_upper;
+	u32 addr_low;
+	int ret;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_GMV_BT, true);
+	hr_reg_write(req, CFG_GMV_BT_IDX, idx);
+
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"failed to execute cmd to read gmv, ret = %d.\n", ret);
+		return ret;
+	}
+
+	addr_low =  hr_reg_read(req, CFG_GMV_BT_BA_L);
+	addr_upper = hr_reg_read(req, CFG_GMV_BT_BA_H);
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_GMV_BT, false);
+	hr_reg_write(req, CFG_GMV_BT_BA_L, addr_low);
+	hr_reg_write(req, CFG_GMV_BT_BA_H, addr_upper);
+	hr_reg_write(req, CFG_GMV_BT_IDX, idx);
+
+	return hns_roce_cmq_send(hr_dev, &desc, 1);
+}
+
+static u64 fmea_get_ram_res_addr(u32 res_type, __le64 *data)
+{
+	if (res_type == ECC_RESOURCE_QPC_TIMER ||
+	    res_type == ECC_RESOURCE_CQC_TIMER ||
+	    res_type == ECC_RESOURCE_SCCC)
+		return le64_to_cpu(*data);
+
+	return le64_to_cpu(*data) << PAGE_SHIFT;
+}
+
+static int fmea_recover_others(struct hns_roce_dev *hr_dev, u32 res_type,
+			       u32 index)
+{
+	u8 write_bt0_op = fmea_ram_res[res_type].write_bt0_op;
+	u8 read_bt0_op = fmea_ram_res[res_type].read_bt0_op;
+	struct hns_roce_cmd_mailbox *mailbox;
+	u64 addr;
+	int ret;
+
+	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, read_bt0_op, index);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"failed to execute cmd to read fmea ram, ret = %d.\n",
+			ret);
+		goto err;
+	}
+
+	addr = fmea_get_ram_res_addr(res_type, mailbox->buf);
+
+	ret = hns_roce_cmd_mbox(hr_dev, addr, 0, write_bt0_op, index);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"failed to execute cmd to write fmea ram, ret = %d.\n",
+			ret);
+		goto err;
+	}
+
+err:
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+	return ret;
+}
+
+static void fmea_ram_ecc_recover(struct hns_roce_dev *hr_dev,
+				 struct fmea_ram_ecc *ecc_info)
+{
+	u32 res_type = ecc_info->res_type;
+	u32 index = ecc_info->index;
+	int ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(fmea_ram_res) != ECC_RESOURCE_COUNT);
+
+	if (res_type >= ECC_RESOURCE_COUNT) {
+		dev_err(hr_dev->dev, "unsupported fmea ram ecc type %u.\n",
+			res_type);
+		return;
+	}
+
+	if (res_type == ECC_RESOURCE_GMV)
+		ret = fmea_recover_gmv(hr_dev, index);
+	else
+		ret = fmea_recover_others(hr_dev, res_type, index);
+	if (ret)
+		dev_err(hr_dev->dev,
+			"failed to recover %s, index = %u, ret = %d.\n",
+			fmea_ram_res[res_type].name, index, ret);
+}
+
+static void fmea_ram_ecc_work(struct work_struct *work)
+{
+	struct hns_roce_work *ecc_work =
+		container_of(work, struct hns_roce_work, work);
+	struct hns_roce_dev *hr_dev = ecc_work->hr_dev;
+	struct fmea_ram_ecc ecc_info = {};
+
+	if (fmea_ram_ecc_query(hr_dev, &ecc_info)) {
+		dev_err(hr_dev->dev, "failed to query fmea ram ecc.\n");
+		goto err;
+	}
+
+	if (!ecc_info.is_ecc_err) {
+		dev_err(hr_dev->dev, "there is no fmea ram ecc err found.\n");
+		goto err;
+	}
+
+	fmea_ram_ecc_recover(hr_dev, &ecc_info);
+
+err:
+	kfree(ecc_work);
+}
+
+static irqreturn_t abnormal_interrupt_others(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_work *ecc_work;
+
+	ecc_work = kzalloc(sizeof(*ecc_work), GFP_ATOMIC);
+	if (!ecc_work)
+		return IRQ_NONE;
+
+	ecc_work->hr_dev = hr_dev;
+	INIT_WORK(&ecc_work->work, fmea_ram_ecc_work);
+	queue_work(hr_dev->irq_workq, &ecc_work->work);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t hns_roce_v2_msix_interrupt_abn(int irq, void *dev_id)
 {
 	struct hns_roce_dev *hr_dev = dev_id;
@@ -6027,6 +6220,8 @@ static irqreturn_t hns_roce_v2_msix_interrupt_abn(int irq, void *dev_id)
 
 	if (int_st)
 		int_work = abnormal_interrupt_basic(hr_dev, int_st);
+	else if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		int_work = abnormal_interrupt_others(hr_dev);
 	else
 		dev_err(hr_dev->dev, "there is no abnormal irq found.\n");
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index e6186149ef19..f96debac30fe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -250,6 +250,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
 	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
 	HNS_ROCE_OPC_EXT_CFG				= 0x8512,
+	HNS_ROCE_QUERY_RAM_ECC				= 0x8513,
 	HNS_SWITCH_PARAMETER_CFG			= 0x1033,
 };
 
@@ -1107,6 +1108,11 @@ enum {
 #define CFG_GMV_BT_BA_H CMQ_REQ_FIELD_LOC(51, 32)
 #define CFG_GMV_BT_IDX CMQ_REQ_FIELD_LOC(95, 64)
 
+/* Fields of HNS_ROCE_QUERY_RAM_ECC */
+#define QUERY_RAM_ECC_1BIT_ERR CMQ_REQ_FIELD_LOC(31, 0)
+#define QUERY_RAM_ECC_RES_TYPE CMQ_REQ_FIELD_LOC(63, 32)
+#define QUERY_RAM_ECC_TAG CMQ_REQ_FIELD_LOC(95, 64)
+
 struct hns_roce_cfg_sgid_tb {
 	__le32	table_idx_rsv;
 	__le32	vf_sgid_l;
@@ -1343,6 +1349,12 @@ struct hns_roce_dip {
 	struct list_head node; /* all dips are on a list */
 };
 
+struct fmea_ram_ecc {
+	u32	is_ecc_err;
+	u32	res_type;
+	u32	index;
+};
+
 /* only for RNR timeout issue of HIP08 */
 #define HNS_ROCE_CLOCK_ADJUST 1000
 #define HNS_ROCE_MAX_CQ_PERIOD 65
-- 
2.33.0

