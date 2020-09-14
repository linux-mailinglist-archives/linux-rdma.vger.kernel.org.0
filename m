Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01A268B21
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgINMiX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 08:38:23 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:51073
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbgINMf4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 08:35:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSBszNWQlCBF4uFb9veziGuwxBarW4dGU2nLdBMV4YvJ0xVhu0cM2Tokza6aWw4OpmRQPLG1umhgttnEFJRQy/BZJxcvQv6ZE3od0KvsVFD8CLO5TRpqJ64uhhCQSfIWI5HjDL/8hRdHr8zPvkBNBZLK6r5G++0mzr5a/kpgeTpXoRolQ2jGSdZzhnp7hTO+Sm6qOSoe4/gwNJWWGJFUd4XJ4soWXCniRLuj15OXvfu87w0lJHlN0jUjUoeNfwiohqZR0RNFDt+rgNlLf1/NFhR7HS1UtG8PXK0TMB0xNY5ZLFiysdddELfMQQilub7lukkeBAd9DdqS7GndZ1omJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfou24vZ6gVq+Obnf6Wc7AmhFVetLmCd1rmDAHdhi1E=;
 b=SuaxW0SJj0ydhoNX93Dm/W2mVYjXja7NM48uGRcEVjIghasSdnRiR7+Gprz1A8rZPIqCtXYVHUr6i1sDZA7mUBkrXMtGi8G0skRT+PqpKO4b/RaPpuI8ZVAXIdovwIalnpMKhjZxDMNOrHH7kvuEhnAT03hln7lILRX96/Y2G4vtZHD1LUCMFw/8vdT740IJMVAQuZdOkNBqiLCgfNlIcEqtT3N7pdWU7u43hbaQvu/w5OFDH6HnFw7uj0IeMnFXvkLxu8ZkVhBe5s6Irbq5lIQPg6Muggzf4NcsVUWLecPLo5Pzo4XIZGp9D6i9RLiIKI7SXYgTL/wj8K0HZMXvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfou24vZ6gVq+Obnf6Wc7AmhFVetLmCd1rmDAHdhi1E=;
 b=C3weNuMHdLoB1BOzpOMkxf8Mb8I3AccTrYjIi/N/zBOvbhBX6Z+beKiv1+nJAmtPqryv+bQqpAskEkujM0zkcM92lVOAw1Ck9yIylr+6HdPD3tKIGvuE8rBEDUH91q/Z/R5BHuG8Yk10N2ZZaSKw08UAWMH8nIrOBlYV2g+fblQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (2603:10a6:208:c0::32)
 by AM8PR05MB7201.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 12:35:53 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::349f:cbf4:ddcf:ce18]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::349f:cbf4:ddcf:ce18%3]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 12:35:53 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Cc:     Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next] IB/i40iw: Avoid typecast from void to pci_dev
Date:   Mon, 14 Sep 2020 15:35:28 +0300
Message-Id: <20200914123528.270382-1-parav@mellanox.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM3PR14CA0141.namprd14.prod.outlook.com
 (2603:10b6:0:53::25) To AM0PR05MB4866.eurprd05.prod.outlook.com
 (2603:10a6:208:c0::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sw-mtx-036.mtx.labs.mlnx (208.176.44.194) by DM3PR14CA0141.namprd14.prod.outlook.com (2603:10b6:0:53::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 12:35:51 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [208.176.44.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2580c563-d9ba-4b44-f635-08d858aab800
X-MS-TrafficTypeDiagnostic: AM8PR05MB7201:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-Microsoft-Antispam-PRVS: <AM8PR05MB72019AC2B1E3235A72414987D1230@AM8PR05MB7201.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbE58Yy6XKa9R46gXyZWQW9OmeXqriUxGsKMuPX24XEPyrnUhAqdH8P/RJ8kYVBfvc/c3Vm7w2hq/b+j10jiV2ofsPvJeV8TzG9Y0VEQHJ9kZhsJBIHbKPAJhVvTZq3DyylBJqFZZjkQxJya2+hAHzkLirO3awtoaQFLDR3Aom5we14ptvYQeew/X8B4oYO9I4ius48kDBTSBqyu3S4W4QMGDbbkObcBywaj4QxGAW5arQNYV6zfkzgOAHY2ka3F0JlL/Ip8eC3aL+RvCDjKbD13iISrsnUa8cVSqeEj7RMR2Bhzm+EiGRE4P9alkmnk9cnavT+uei+fdlCwNdBESQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4866.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(316002)(2616005)(66946007)(8676002)(86362001)(66476007)(66556008)(1076003)(8936002)(956004)(2906002)(16526019)(186003)(26005)(4326008)(6666004)(6506007)(52116002)(5660300002)(83380400001)(36756003)(478600001)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IqJgFk3rSMnh2T2Su6sr6q2cbP8RMd1DTATAlxkUqawNTqoTTwMENnjWEscgWkxlZYBI+dw2qRqvd4e7PmL3Lc8m+ub4Ft1rObi0L7BgTv8TJ+0c/vx4uCIYZb6cFZFVAcmAkDYiKEZh1YgMXsDLGlsB0yaHW12/IFfASZZSyqiP3d4XTW3o/FW9XnuFyD5PcVjN9bT2S4QGUYkegd5Q7JeA2z0j0aLrR49eKHdrGs0Mp1qcYpVsXw+vgayc0bbI+HL4l0c/4uUuUlkgcOseaS2v1o0MCCNPWQIXgA2GFUhKDGwLxE9HJ3BGoqFQPmoC1yx6jh20C0KT6kb1FBRN6Ac4VdK5GohjtVjuKaoITjvtv9R6EEw3CquTpE0LKGp+rjSt5HevvbhT3oS+ji0UUX2sWBqyxu2j6Y/B+ArvllhVnxJ5p2TIcH4Uh73jauAqrIsNDekzKGYLxJ+P6P2J1Bniksh6XOIMC9rjWPV78iHOKRYJFGcPQXa6JRITxg6/DyhbeOUmEZsGAVau9iVeCEvpoFUKAlpmtueqU6gRcxBs3YUYXkC6gOKaIZOULrRJw02mAPWtdOqpnsztIlA0XSOZcda2758+9DMY89wDmW/Y8UrbGwLx3wjCTh2eyxyutnFGwMvRgoh8Lbbc+O99cg==
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2580c563-d9ba-4b44-f635-08d858aab800
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4866.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 12:35:53.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unAnaYATunHikY/LdEKe4/z50lo1RPMjHPnw+fx5fTKkUKQGTTw5TtdpdcXoAvtID1fVdN19qQA/IUbEeaLyrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7201
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

hw_context stores pci device pointer. Use the pci_dev pointer instead of
void * and avoid typecasts.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/infiniband/hw/i40iw/i40iw_main.c  | 2 +-
 drivers/infiniband/hw/i40iw/i40iw_pble.c  | 4 ++--
 drivers/infiniband/hw/i40iw/i40iw_type.h  | 3 ++-
 drivers/infiniband/hw/i40iw/i40iw_utils.c | 4 ++--
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index c0cdb25440bf..2408b279e4c2 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1573,7 +1573,7 @@ static enum i40iw_status_code i40iw_setup_init_state(struct i40iw_handler *hdl,
 	status = i40iw_save_msix_info(iwdev, ldev);
 	if (status)
 		return status;
-	iwdev->hw.dev_context = (void *)ldev->pcidev;
+	iwdev->hw.pcidev = ldev->pcidev;
 	iwdev->hw.hw_addr = ldev->hw_addr;
 	status = i40iw_allocate_dma_mem(&iwdev->hw,
 					&iwdev->obj_mem, 8192, 4096);
diff --git a/drivers/infiniband/hw/i40iw/i40iw_pble.c b/drivers/infiniband/hw/i40iw/i40iw_pble.c
index 540aab5e502d..5f97643e22e5 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_pble.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_pble.c
@@ -167,7 +167,7 @@ static enum i40iw_status_code add_sd_direct(struct i40iw_sc_dev *dev,
  */
 static void i40iw_free_vmalloc_mem(struct i40iw_hw *hw, struct i40iw_chunk *chunk)
 {
-	struct pci_dev *pcidev = (struct pci_dev *)hw->dev_context;
+	struct pci_dev *pcidev = hw->pcidev;
 	int i;
 
 	if (!chunk->pg_cnt)
@@ -193,7 +193,7 @@ static enum i40iw_status_code i40iw_get_vmalloc_mem(struct i40iw_hw *hw,
 						    struct i40iw_chunk *chunk,
 						    int pg_cnt)
 {
-	struct pci_dev *pcidev = (struct pci_dev *)hw->dev_context;
+	struct pci_dev *pcidev = hw->pcidev;
 	struct page *page;
 	u8 *addr;
 	u32 size;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_type.h b/drivers/infiniband/hw/i40iw/i40iw_type.h
index 54c323c40d96..c3babf3cbb8e 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_type.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_type.h
@@ -73,6 +73,7 @@ struct i40iw_pd_ops;
 struct i40iw_priv_qp_ops;
 struct i40iw_priv_cq_ops;
 struct i40iw_hmc_ops;
+struct pci_dev;
 
 enum i40iw_page_size {
 	I40IW_PAGE_SIZE_4K,
@@ -261,7 +262,7 @@ struct i40iw_vsi_pestat {
 
 struct i40iw_hw {
 	u8 __iomem *hw_addr;
-	void *dev_context;
+	struct pci_dev *pcidev;
 	struct i40iw_hmc_info hmc;
 };
 
diff --git a/drivers/infiniband/hw/i40iw/i40iw_utils.c b/drivers/infiniband/hw/i40iw/i40iw_utils.c
index e07fb37af086..4ab8e0dcfd4c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_utils.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_utils.c
@@ -751,7 +751,7 @@ enum i40iw_status_code i40iw_allocate_dma_mem(struct i40iw_hw *hw,
 					      u64 size,
 					      u32 alignment)
 {
-	struct pci_dev *pcidev = (struct pci_dev *)hw->dev_context;
+	struct pci_dev *pcidev = hw->pcidev;
 
 	if (!mem)
 		return I40IW_ERR_PARAM;
@@ -770,7 +770,7 @@ enum i40iw_status_code i40iw_allocate_dma_mem(struct i40iw_hw *hw,
  */
 void i40iw_free_dma_mem(struct i40iw_hw *hw, struct i40iw_dma_mem *mem)
 {
-	struct pci_dev *pcidev = (struct pci_dev *)hw->dev_context;
+	struct pci_dev *pcidev = hw->pcidev;
 
 	if (!mem || !mem->va)
 		return;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index b51339328a51..90baa4c7f208 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2668,7 +2668,7 @@ static struct i40iw_ib_device *i40iw_init_rdma_device(struct i40iw_device *iwdev
 {
 	struct i40iw_ib_device *iwibdev;
 	struct net_device *netdev = iwdev->netdev;
-	struct pci_dev *pcidev = (struct pci_dev *)iwdev->hw.dev_context;
+	struct pci_dev *pcidev = iwdev->hw.pcidev;
 
 	iwibdev = ib_alloc_device(i40iw_ib_device, ibdev);
 	if (!iwibdev) {
-- 
2.26.2

