Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42295475A18
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 14:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbhLON5q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 08:57:46 -0500
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com ([40.107.237.73]:21056
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243074AbhLON5o (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrIwfqPAE/7e/9dBDcjhoIirPI+pH+Ibf47CSm2pEbEWDYTidxPiBlyGvlRKzRxGT8TbaNrSHF+xXjk+BNb6KtmQTUljLfJG8zj3dLEdoxIeHDQFp9H3oEt6cZZzZyUYO75zLOwXfF76buYJyVtsismL88lUgFCCgqIKx+/sK9HVb7mUKCNNM+Qm/0hmbOXJwbObQA5XVl4f823azYdI9IIHS4DGDvhZUGy4cL5QgQp5Ig35r04XtgE4V2TijeGUtxk+E6ZIizxsOsfZVu1VX0tt1HEMkRGEbMLimBqvtcqcbPJ7GqkaTaqjZwLgPO9S0P8CuCRUR2Rx90HBqlQrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uJTbIerwd+9n73Lz/5DWa0Z8BcdTocaxLPbNAYyfRk=;
 b=kgKOZ1LjzP/rZFkw7OvEQX3v0Qwy6ZkGYn+OeWDi2yCtqjSE+v8YMDNJ+WxZLcILv1gOFAAF+Ykgtil0Fx4/jvvImHeGOW367dPFlwT+TwDEqiXQLErTEE51zc+ys/hLaNupHITY/lW9NZKNcmWryM2ihAEGDcQviW1VxJw57PKYz1xrEle4XGWmX5Vvt3A4Ytqw6QceT4rj5cEnyi7NdLRgBSg/V2iCp4MBTYr5/IeHxGOa4fo7dhZVZ2Tj4CCUnUkV63+3azYy+wTmqSsKPpM4kwdC5zPDyRutuNxVJExWYx0cv8Ojl1zk7C7zj7nMVKIWgvJAl5hjqPChqx2oCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uJTbIerwd+9n73Lz/5DWa0Z8BcdTocaxLPbNAYyfRk=;
 b=rjcLjTrKoILle7LvtjjODEgEe35OSS0krLEvOydeT/+S8EHheZTkDLpE1AjzQpyKZ2sXdeUjIlQ4oHH4ZVnHWr+rFD+S756Zchw/KvSQQZOjj92fPfR6IjB3aLGzhRH3CSO8y0NjJT+P+oC9GoBAxZcFBz4JBoc487GEhYZiMzwJ+mFFXM4/VCVfdxs+NaKDCWezRHAqyPWba/lzXH1GEgnH11EmgrgCh8V3pVsIS4QBab4Fyx1YPe0JLTT+U/oejSEriJJS2HSdKvGcL6jooLZ/CGkPBHJnPhoiICPuiOiOqistr29zkV4AyvSioxVvsphvknJQuWhzLjgezvTyEw==
Received: from CO2PR04CA0104.namprd04.prod.outlook.com (2603:10b6:104:6::30)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Wed, 15 Dec
 2021 13:57:41 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::aa) by CO2PR04CA0104.outlook.office365.com
 (2603:10b6:104:6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 13:57:40 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:38 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:37 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:35 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <sagi@grimberg.me>, <jgg@nvidia.com>
CC:     <oren@nvidia.com>, <israelr@nvidia.com>, <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 6/6] IB/iser: align coding style accross driver
Date:   Wed, 15 Dec 2021 15:57:21 +0200
Message-ID: <20211215135721.3662-7-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211215135721.3662-1-mgurtovoy@nvidia.com>
References: <20211215135721.3662-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f060c48f-2214-4526-f099-08d9bfd2dc53
X-MS-TrafficTypeDiagnostic: BY5PR12MB4145:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4145AA25F3EBD2958BE917ACDE769@BY5PR12MB4145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKSNlbpZ26e7Pd41X/C3ST9bwemWBoWFRS/6wkatxcmzAsViAWUiIzdXC8yAfkhSESoRaKYPAnFXyPTwJeZcAaLal/a/T0x6dAe1RneIOQyxXIu07WLZegS9nzWdd6mC4bhojwNZtr4cNikEPIo0oRgNakHcxsTAAgAX0oEKVfjGFiIu+a6Vy7rQqFyp+L4SbLlSQYXMekjny1PpoZgUIRvRfKf1SxjwH4y7SQdC3BHCCud+l/ikhV1Iw/Gc1cWmUyhaUSaTRm/aLr4VzNy2TiUAPyyO9m1KT1l5f2g35O748lGUQzm6UINv/S20+9vuVXROeehc0wGkCqEgAnOtNmp1BQd6noidy8IGuL06XiHpnjHyI2TplIdpuWZVhaXbffuxxDiNzwWhbMcL2t73c77Zt3m2VUmC29dJz+D66RtQd5t0ZlZbHTXoKF1pnHdsTHPwxZId/+xZZ0SbG7gSGlCe5fR5gsEKmRe9cb5On7BqNIBJVhL+AEbtepy3jBeviFLDRWxy7WA0qYraSCjzIYtrxn3cApiDFQzgKN5haJKklZ0rPWgGtuB7CEEArx2kBWkuFDLIMcQOkAERl2ntetAJK+N2fmEPAw4DXq0A7j2Q6hwWleBG6B9xAKEF9dL+mYZBBTvZm215X+NRjeylxVCghEgpYohIOklMVuaHLeo/QLdl1CAE5COQ3k/F+jPEhJ/XCP7+GMmLZFK6kBgYNq8a3+csg5RBlSZ10jBCQISwivTRmbB4G/vo/KUaY7XMlRE3NKup96bL69+4EjvNT8Jz0X2Q7BF4/9dkb+LKV3w=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(82310400004)(47076005)(4326008)(6636002)(83380400001)(356005)(34020700004)(36756003)(54906003)(36860700001)(1076003)(316002)(26005)(107886003)(8676002)(5660300002)(336012)(2616005)(30864003)(186003)(40460700001)(2906002)(6666004)(8936002)(70586007)(7636003)(426003)(110136005)(70206006)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 13:57:40.6255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f060c48f-2214-4526-f099-08d9bfd2dc53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following changes were made:
1. Align function signatures to 80 characters per line.
2. Remove tabs for variable assignment and use 1 space instead.
3. Don't compare to NULL in "if" clause.
4. Remove strange indentations.

This will ease on the maintenance of the driver for the future.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c     | 74 ++++++++------------
 drivers/infiniband/ulp/iser/iser_initiator.c | 29 +++-----
 drivers/infiniband/ulp/iser/iser_memory.c    | 60 +++++++---------
 drivers/infiniband/ulp/iser/iser_verbs.c     | 52 +++++++-------
 4 files changed, 90 insertions(+), 125 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 410df19bdfb5..db0ca548bbd9 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -135,9 +135,8 @@ static int iscsi_iser_set(const char *val, const struct kernel_param *kp)
  * Notes: In case of data length errors or iscsi PDU completion failures
  *        this routine will signal iscsi layer of connection failure.
  */
-void
-iscsi_iser_recv(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
-		char *rx_data, int rx_data_len)
+void iscsi_iser_recv(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
+		     char *rx_data, int rx_data_len)
 {
 	int rc = 0;
 	int datalen;
@@ -172,8 +171,7 @@ iscsi_iser_recv(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
  * Netes: This routine can't fail, just assign iscsi task
  *        hdr and max hdr size.
  */
-static int
-iscsi_iser_pdu_alloc(struct iscsi_task *task, uint8_t opcode)
+static int iscsi_iser_pdu_alloc(struct iscsi_task *task, uint8_t opcode)
 {
 	struct iscsi_iser_task *iser_task = task->dd_data;
 
@@ -194,9 +192,8 @@ iscsi_iser_pdu_alloc(struct iscsi_task *task, uint8_t opcode)
  * state mutex to avoid dereferencing the IB device which
  * may have already been terminated.
  */
-int
-iser_initialize_task_headers(struct iscsi_task *task,
-			     struct iser_tx_desc *tx_desc)
+int iser_initialize_task_headers(struct iscsi_task *task,
+				 struct iser_tx_desc *tx_desc)
 {
 	struct iser_conn *iser_conn = task->conn->dd_data;
 	struct iser_device *device = iser_conn->ib_conn.device;
@@ -233,8 +230,7 @@ iser_initialize_task_headers(struct iscsi_task *task,
  * Return: Returns zero on success or -ENOMEM when failing
  *         to init task headers (dma mapping error).
  */
-static int
-iscsi_iser_task_init(struct iscsi_task *task)
+static int iscsi_iser_task_init(struct iscsi_task *task)
 {
 	struct iscsi_iser_task *iser_task = task->dd_data;
 	int ret;
@@ -268,8 +264,8 @@ iscsi_iser_task_init(struct iscsi_task *task)
  *	xmit.
  *
  **/
-static int
-iscsi_iser_mtask_xmit(struct iscsi_conn *conn, struct iscsi_task *task)
+static int iscsi_iser_mtask_xmit(struct iscsi_conn *conn,
+				 struct iscsi_task *task)
 {
 	int error = 0;
 
@@ -286,9 +282,8 @@ iscsi_iser_mtask_xmit(struct iscsi_conn *conn, struct iscsi_task *task)
 	return error;
 }
 
-static int
-iscsi_iser_task_xmit_unsol_data(struct iscsi_conn *conn,
-				 struct iscsi_task *task)
+static int iscsi_iser_task_xmit_unsol_data(struct iscsi_conn *conn,
+					   struct iscsi_task *task)
 {
 	struct iscsi_r2t_info *r2t = &task->unsol_r2t;
 	struct iscsi_data hdr;
@@ -322,8 +317,7 @@ iscsi_iser_task_xmit_unsol_data(struct iscsi_conn *conn,
  *
  * Return: zero on success or escalates $error on failure.
  */
-static int
-iscsi_iser_task_xmit(struct iscsi_task *task)
+static int iscsi_iser_task_xmit(struct iscsi_task *task)
 {
 	struct iscsi_conn *conn = task->conn;
 	struct iscsi_iser_task *iser_task = task->dd_data;
@@ -406,8 +400,8 @@ static void iscsi_iser_cleanup_task(struct iscsi_task *task)
  *
  *         In addition the error sector is marked.
  */
-static u8
-iscsi_iser_check_protection(struct iscsi_task *task, sector_t *sector)
+static u8 iscsi_iser_check_protection(struct iscsi_task *task,
+				      sector_t *sector)
 {
 	struct iscsi_iser_task *iser_task = task->dd_data;
 	enum iser_data_dir dir = iser_task->dir[ISER_DIR_IN] ?
@@ -456,11 +450,10 @@ iscsi_iser_conn_create(struct iscsi_cls_session *cls_session,
  *         -EINVAL in case end-point doesn't exsits anymore or iser connection
  *         state is not UP (teardown already started).
  */
-static int
-iscsi_iser_conn_bind(struct iscsi_cls_session *cls_session,
-		     struct iscsi_cls_conn *cls_conn,
-		     uint64_t transport_eph,
-		     int is_leading)
+static int iscsi_iser_conn_bind(struct iscsi_cls_session *cls_session,
+				struct iscsi_cls_conn *cls_conn,
+				uint64_t transport_eph,
+				int is_leading)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	struct iser_conn *iser_conn;
@@ -515,8 +508,7 @@ iscsi_iser_conn_bind(struct iscsi_cls_session *cls_session,
  *        from this point iscsi must call conn_stop in session/connection
  *        teardown so iser transport must wait for it.
  */
-static int
-iscsi_iser_conn_start(struct iscsi_cls_conn *cls_conn)
+static int iscsi_iser_conn_start(struct iscsi_cls_conn *cls_conn)
 {
 	struct iscsi_conn *iscsi_conn;
 	struct iser_conn *iser_conn;
@@ -538,8 +530,7 @@ iscsi_iser_conn_start(struct iscsi_cls_conn *cls_conn)
  *        handle, so we call it under iser the state lock to protect against
  *        this kind of race.
  */
-static void
-iscsi_iser_conn_stop(struct iscsi_cls_conn *cls_conn, int flag)
+static void iscsi_iser_conn_stop(struct iscsi_cls_conn *cls_conn, int flag)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	struct iser_conn *iser_conn = conn->dd_data;
@@ -574,8 +565,7 @@ iscsi_iser_conn_stop(struct iscsi_cls_conn *cls_conn, int flag)
  *
  * Removes and free iscsi host.
  */
-static void
-iscsi_iser_session_destroy(struct iscsi_cls_session *cls_session)
+static void iscsi_iser_session_destroy(struct iscsi_cls_session *cls_session)
 {
 	struct Scsi_Host *shost = iscsi_session_to_shost(cls_session);
 
@@ -584,8 +574,7 @@ iscsi_iser_session_destroy(struct iscsi_cls_session *cls_session)
 	iscsi_host_free(shost);
 }
 
-static inline unsigned int
-iser_dif_prot_caps(int prot_caps)
+static inline unsigned int iser_dif_prot_caps(int prot_caps)
 {
 	int ret = 0;
 
@@ -704,9 +693,8 @@ iscsi_iser_session_create(struct iscsi_endpoint *ep,
 	return NULL;
 }
 
-static int
-iscsi_iser_set_param(struct iscsi_cls_conn *cls_conn,
-		     enum iscsi_param param, char *buf, int buflen)
+static int iscsi_iser_set_param(struct iscsi_cls_conn *cls_conn,
+				enum iscsi_param param, char *buf, int buflen)
 {
 	int value;
 
@@ -756,8 +744,8 @@ iscsi_iser_set_param(struct iscsi_cls_conn *cls_conn,
  *
  * Output connection statistics.
  */
-static void
-iscsi_iser_conn_get_stats(struct iscsi_cls_conn *cls_conn, struct iscsi_stats *stats)
+static void iscsi_iser_conn_get_stats(struct iscsi_cls_conn *cls_conn,
+				      struct iscsi_stats *stats)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 
@@ -808,9 +796,9 @@ static int iscsi_iser_get_ep_param(struct iscsi_endpoint *ep,
  * Return: iscsi_endpoint created by iscsi layer or ERR_PTR(error)
  *         if fails.
  */
-static struct iscsi_endpoint *
-iscsi_iser_ep_connect(struct Scsi_Host *shost, struct sockaddr *dst_addr,
-		      int non_blocking)
+static struct iscsi_endpoint *iscsi_iser_ep_connect(struct Scsi_Host *shost,
+						    struct sockaddr *dst_addr,
+						    int non_blocking)
 {
 	int err;
 	struct iser_conn *iser_conn;
@@ -853,8 +841,7 @@ iscsi_iser_ep_connect(struct Scsi_Host *shost, struct sockaddr *dst_addr,
  *         or more likely iser connection state transitioned to TEMINATING or
  *         DOWN during the wait period.
  */
-static int
-iscsi_iser_ep_poll(struct iscsi_endpoint *ep, int timeout_ms)
+static int iscsi_iser_ep_poll(struct iscsi_endpoint *ep, int timeout_ms)
 {
 	struct iser_conn *iser_conn = ep->dd_data;
 	int rc;
@@ -889,8 +876,7 @@ iscsi_iser_ep_poll(struct iscsi_endpoint *ep, int timeout_ms)
  * and cleanup or actually call it immediately in case we didn't pass
  * iscsi conn bind/start stage, thus it is safe.
  */
-static void
-iscsi_iser_ep_disconnect(struct iscsi_endpoint *ep)
+static void iscsi_iser_ep_disconnect(struct iscsi_endpoint *ep)
 {
 	struct iser_conn *iser_conn = ep->dd_data;
 
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 778835003d39..2490150d3085 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -95,11 +95,8 @@ static int iser_prepare_read_cmd(struct iscsi_task *task)
  *  task->data[ISER_DIR_OUT].data_len, Protection size
  *  is stored at task->prot[ISER_DIR_OUT].data_len
  */
-static int
-iser_prepare_write_cmd(struct iscsi_task *task,
-		       unsigned int imm_sz,
-		       unsigned int unsol_sz,
-		       unsigned int edtl)
+static int iser_prepare_write_cmd(struct iscsi_task *task, unsigned int imm_sz,
+				  unsigned int unsol_sz, unsigned int edtl)
 {
 	struct iscsi_iser_task *iser_task = task->dd_data;
 	struct iser_mem_reg *mem_reg;
@@ -160,8 +157,8 @@ iser_prepare_write_cmd(struct iscsi_task *task,
 }
 
 /* creates a new tx descriptor and adds header regd buffer */
-static void iser_create_send_desc(struct iser_conn	*iser_conn,
-				  struct iser_tx_desc	*tx_desc)
+static void iser_create_send_desc(struct iser_conn *iser_conn,
+				  struct iser_tx_desc *tx_desc)
 {
 	struct iser_device *device = iser_conn->ib_conn.device;
 
@@ -355,8 +352,7 @@ static int iser_post_rx_bufs(struct iscsi_conn *conn, struct iscsi_hdr *req)
  * @conn: link to matching iscsi connection
  * @task: SCSI command task
  */
-int iser_send_command(struct iscsi_conn *conn,
-		      struct iscsi_task *task)
+int iser_send_command(struct iscsi_conn *conn, struct iscsi_task *task)
 {
 	struct iser_conn *iser_conn = conn->dd_data;
 	struct iscsi_iser_task *iser_task = task->dd_data;
@@ -427,8 +423,7 @@ int iser_send_command(struct iscsi_conn *conn,
  * @task: SCSI command task
  * @hdr: pointer to the LLD's iSCSI message header
  */
-int iser_send_data_out(struct iscsi_conn *conn,
-		       struct iscsi_task *task,
+int iser_send_data_out(struct iscsi_conn *conn, struct iscsi_task *task,
 		       struct iscsi_data *hdr)
 {
 	struct iser_conn *iser_conn = conn->dd_data;
@@ -490,8 +485,7 @@ int iser_send_data_out(struct iscsi_conn *conn,
 	return err;
 }
 
-int iser_send_control(struct iscsi_conn *conn,
-		      struct iscsi_task *task)
+int iser_send_control(struct iscsi_conn *conn, struct iscsi_task *task)
 {
 	struct iser_conn *iser_conn = conn->dd_data;
 	struct iscsi_iser_task *iser_task = task->dd_data;
@@ -590,8 +584,7 @@ void iser_login_rsp(struct ib_cq *cq, struct ib_wc *wc)
 	iser_post_recvm(iser_conn, iser_conn->rx_descs);
 }
 
-static inline int
-iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
+static inline int iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
 {
 	if (unlikely((!desc->sig_protected && rkey != desc->rsc.mr->rkey) ||
 		     (desc->sig_protected && rkey != desc->rsc.sig_mr->rkey))) {
@@ -604,10 +597,8 @@ iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
 	return 0;
 }
 
-static int
-iser_check_remote_inv(struct iser_conn *iser_conn,
-		      struct ib_wc *wc,
-		      struct iscsi_hdr *hdr)
+static int iser_check_remote_inv(struct iser_conn *iser_conn, struct ib_wc *wc,
+				 struct iscsi_hdr *hdr)
 {
 	if (wc->wc_flags & IB_WC_WITH_INVALIDATE) {
 		struct iscsi_task *task;
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 9776b755d848..8b3fe6f7ef45 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -44,8 +44,7 @@ void iser_reg_comp(struct ib_cq *cq, struct ib_wc *wc)
 	iser_err_comp(wc, "memreg");
 }
 
-static struct iser_fr_desc *
-iser_reg_desc_get_fr(struct ib_conn *ib_conn)
+static struct iser_fr_desc *iser_reg_desc_get_fr(struct ib_conn *ib_conn)
 {
 	struct iser_fr_pool *fr_pool = &ib_conn->fr_pool;
 	struct iser_fr_desc *desc;
@@ -60,9 +59,8 @@ iser_reg_desc_get_fr(struct ib_conn *ib_conn)
 	return desc;
 }
 
-static void
-iser_reg_desc_put_fr(struct ib_conn *ib_conn,
-		     struct iser_fr_desc *desc)
+static void iser_reg_desc_put_fr(struct ib_conn *ib_conn,
+				 struct iser_fr_desc *desc)
 {
 	struct iser_fr_pool *fr_pool = &ib_conn->fr_pool;
 	unsigned long flags;
@@ -73,9 +71,9 @@ iser_reg_desc_put_fr(struct ib_conn *ib_conn,
 }
 
 int iser_dma_map_task_data(struct iscsi_iser_task *iser_task,
-			    struct iser_data_buf *data,
-			    enum iser_data_dir iser_dir,
-			    enum dma_data_direction dma_dir)
+			   struct iser_data_buf *data,
+			   enum iser_data_dir iser_dir,
+			   enum dma_data_direction dma_dir)
 {
 	struct ib_device *dev;
 
@@ -100,9 +98,8 @@ void iser_dma_unmap_task_data(struct iscsi_iser_task *iser_task,
 	ib_dma_unmap_sg(dev, data->sg, data->size, dir);
 }
 
-static int
-iser_reg_dma(struct iser_device *device, struct iser_data_buf *mem,
-	     struct iser_mem_reg *reg)
+static int iser_reg_dma(struct iser_device *device, struct iser_data_buf *mem,
+			struct iser_mem_reg *reg)
 {
 	struct scatterlist *sg = mem->sg;
 
@@ -154,8 +151,8 @@ void iser_unreg_mem_fastreg(struct iscsi_iser_task *iser_task,
 	reg->mem_h = NULL;
 }
 
-static void
-iser_set_dif_domain(struct scsi_cmnd *sc, struct ib_sig_domain *domain)
+static void iser_set_dif_domain(struct scsi_cmnd *sc,
+				struct ib_sig_domain *domain)
 {
 	domain->sig_type = IB_SIG_TYPE_T10_DIF;
 	domain->sig.dif.pi_interval = scsi_prot_interval(sc);
@@ -171,8 +168,8 @@ iser_set_dif_domain(struct scsi_cmnd *sc, struct ib_sig_domain *domain)
 		domain->sig.dif.ref_remap = true;
 }
 
-static int
-iser_set_sig_attrs(struct scsi_cmnd *sc, struct ib_sig_attrs *sig_attrs)
+static int iser_set_sig_attrs(struct scsi_cmnd *sc,
+			      struct ib_sig_attrs *sig_attrs)
 {
 	switch (scsi_get_prot_op(sc)) {
 	case SCSI_PROT_WRITE_INSERT:
@@ -205,8 +202,7 @@ iser_set_sig_attrs(struct scsi_cmnd *sc, struct ib_sig_attrs *sig_attrs)
 	return 0;
 }
 
-static inline void
-iser_set_prot_checks(struct scsi_cmnd *sc, u8 *mask)
+static inline void iser_set_prot_checks(struct scsi_cmnd *sc, u8 *mask)
 {
 	*mask = 0;
 	if (sc->prot_flags & SCSI_PROT_REF_CHECK)
@@ -215,11 +211,9 @@ iser_set_prot_checks(struct scsi_cmnd *sc, u8 *mask)
 		*mask |= IB_SIG_CHECK_GUARD;
 }
 
-static inline void
-iser_inv_rkey(struct ib_send_wr *inv_wr,
-	      struct ib_mr *mr,
-	      struct ib_cqe *cqe,
-	      struct ib_send_wr *next_wr)
+static inline void iser_inv_rkey(struct ib_send_wr *inv_wr, struct ib_mr *mr,
+				 struct ib_cqe *cqe,
+				 struct ib_send_wr *next_wr)
 {
 	inv_wr->opcode = IB_WR_LOCAL_INV;
 	inv_wr->wr_cqe = cqe;
@@ -229,12 +223,11 @@ iser_inv_rkey(struct ib_send_wr *inv_wr,
 	inv_wr->next = next_wr;
 }
 
-static int
-iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
-		struct iser_data_buf *mem,
-		struct iser_data_buf *sig_mem,
-		struct iser_reg_resources *rsc,
-		struct iser_mem_reg *sig_reg)
+static int iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
+			   struct iser_data_buf *mem,
+			   struct iser_data_buf *sig_mem,
+			   struct iser_reg_resources *rsc,
+			   struct iser_mem_reg *sig_reg)
 {
 	struct iser_tx_desc *tx_desc = &iser_task->desc;
 	struct ib_cqe *cqe = &iser_task->iser_conn->ib_conn.reg_cqe;
@@ -335,12 +328,11 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 	return 0;
 }
 
-static int
-iser_reg_data_sg(struct iscsi_iser_task *task,
-		 struct iser_data_buf *mem,
-		 struct iser_fr_desc *desc,
-		 bool use_dma_key,
-		 struct iser_mem_reg *reg)
+static int iser_reg_data_sg(struct iscsi_iser_task *task,
+			    struct iser_data_buf *mem,
+			    struct iser_fr_desc *desc,
+			    bool use_dma_key,
+			    struct iser_mem_reg *reg)
 {
 	struct iser_device *device = task->iser_conn->ib_conn.device;
 
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index afef5a2a7329..6e41b0620286 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -265,14 +265,14 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 	memset(&init_attr, 0, sizeof(init_attr));
 
 	init_attr.event_handler = iser_qp_event_callback;
-	init_attr.qp_context	= (void *)ib_conn;
-	init_attr.send_cq	= ib_conn->cq;
-	init_attr.recv_cq	= ib_conn->cq;
-	init_attr.cap.max_recv_wr  = ISER_QP_MAX_RECV_DTOS;
+	init_attr.qp_context = (void *)ib_conn;
+	init_attr.send_cq = ib_conn->cq;
+	init_attr.recv_cq = ib_conn->cq;
+	init_attr.cap.max_recv_wr = ISER_QP_MAX_RECV_DTOS;
 	init_attr.cap.max_send_sge = 2;
 	init_attr.cap.max_recv_sge = 1;
-	init_attr.sq_sig_type	= IB_SIGNAL_REQ_WR;
-	init_attr.qp_type	= IB_QPT_RC;
+	init_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
+	init_attr.qp_type = IB_QPT_RC;
 	init_attr.cap.max_send_wr = max_send_wr;
 	if (ib_conn->pi_support)
 		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
@@ -284,8 +284,7 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 
 	ib_conn->qp = ib_conn->cma_id->qp;
 	iser_info("setting conn %p cma_id %p qp %p max_send_wr %d\n",
-		  ib_conn, ib_conn->cma_id,
-		  ib_conn->cma_id->qp, max_send_wr);
+		  ib_conn, ib_conn->cma_id, ib_conn->cma_id->qp, max_send_wr);
 	return ret;
 
 out_err:
@@ -313,7 +312,7 @@ struct iser_device *iser_device_find_by_ib_device(struct rdma_cm_id *cma_id)
 			goto inc_refcnt;
 
 	device = kzalloc(sizeof *device, GFP_KERNEL);
-	if (device == NULL)
+	if (!device)
 		goto out;
 
 	/* assign this device to the device */
@@ -392,8 +391,7 @@ void iser_release_work(struct work_struct *work)
  * so the cm_id removal is out of here. It is Safe to
  * be invoked multiple times.
  */
-static void iser_free_ib_conn_res(struct iser_conn *iser_conn,
-				  bool destroy)
+static void iser_free_ib_conn_res(struct iser_conn *iser_conn, bool destroy)
 {
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
 	struct iser_device *device = ib_conn->device;
@@ -401,7 +399,7 @@ static void iser_free_ib_conn_res(struct iser_conn *iser_conn,
 	iser_info("freeing conn %p cma_id %p qp %p\n",
 		  iser_conn, ib_conn->cma_id, ib_conn->qp);
 
-	if (ib_conn->qp != NULL) {
+	if (ib_conn->qp) {
 		rdma_destroy_qp(ib_conn->cma_id);
 		ib_cq_pool_put(ib_conn->cq, ib_conn->cq_size);
 		ib_conn->qp = NULL;
@@ -411,7 +409,7 @@ static void iser_free_ib_conn_res(struct iser_conn *iser_conn,
 		if (iser_conn->rx_descs)
 			iser_free_rx_descriptors(iser_conn);
 
-		if (device != NULL) {
+		if (device) {
 			iser_device_try_release(device);
 			ib_conn->device = NULL;
 		}
@@ -445,7 +443,7 @@ void iser_conn_release(struct iser_conn *iser_conn)
 	iser_free_ib_conn_res(iser_conn, true);
 	mutex_unlock(&iser_conn->state_mutex);
 
-	if (ib_conn->cma_id != NULL) {
+	if (ib_conn->cma_id) {
 		rdma_destroy_id(ib_conn->cma_id);
 		ib_conn->cma_id = NULL;
 	}
@@ -505,9 +503,8 @@ static void iser_connect_error(struct rdma_cm_id *cma_id)
 	iser_conn->state = ISER_CONN_TERMINATING;
 }
 
-static void
-iser_calc_scsi_params(struct iser_conn *iser_conn,
-		      unsigned int max_sectors)
+static void iser_calc_scsi_params(struct iser_conn *iser_conn,
+				  unsigned int max_sectors)
 {
 	struct iser_device *device = iser_conn->ib_conn.device;
 	struct ib_device_attr *attr = &device->ib_device->attrs;
@@ -545,8 +542,8 @@ iser_calc_scsi_params(struct iser_conn *iser_conn,
 static void iser_addr_handler(struct rdma_cm_id *cma_id)
 {
 	struct iser_device *device;
-	struct iser_conn   *iser_conn;
-	struct ib_conn   *ib_conn;
+	struct iser_conn *iser_conn;
+	struct ib_conn *ib_conn;
 	int    ret;
 
 	iser_conn = cma_id->context;
@@ -593,7 +590,7 @@ static void iser_addr_handler(struct rdma_cm_id *cma_id)
 static void iser_route_handler(struct rdma_cm_id *cma_id)
 {
 	struct rdma_conn_param conn_param;
-	int    ret;
+	int ret;
 	struct iser_cm_hdr req_hdr;
 	struct iser_conn *iser_conn = cma_id->context;
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
@@ -609,9 +606,9 @@ static void iser_route_handler(struct rdma_cm_id *cma_id)
 
 	memset(&conn_param, 0, sizeof conn_param);
 	conn_param.responder_resources = ib_dev->attrs.max_qp_rd_atom;
-	conn_param.initiator_depth     = 1;
-	conn_param.retry_count	       = 7;
-	conn_param.rnr_retry_count     = 6;
+	conn_param.initiator_depth = 1;
+	conn_param.retry_count = 7;
+	conn_param.rnr_retry_count = 6;
 
 	memset(&req_hdr, 0, sizeof(req_hdr));
 	req_hdr.flags = ISER_ZBVA_NOT_SUP;
@@ -687,7 +684,8 @@ static void iser_cleanup_handler(struct rdma_cm_id *cma_id,
 	complete(&iser_conn->ib_completion);
 }
 
-static int iser_cma_handler(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
+static int iser_cma_handler(struct rdma_cm_id *cma_id,
+			    struct rdma_cm_event *event)
 {
 	struct iser_conn *iser_conn;
 	int ret = 0;
@@ -764,10 +762,8 @@ void iser_conn_init(struct iser_conn *iser_conn)
  * starts the process of connecting to the target
  * sleeps until the connection is established or rejected
  */
-int iser_connect(struct iser_conn   *iser_conn,
-		 struct sockaddr    *src_addr,
-		 struct sockaddr    *dst_addr,
-		 int                 non_blocking)
+int iser_connect(struct iser_conn *iser_conn, struct sockaddr *src_addr,
+		 struct sockaddr *dst_addr, int non_blocking)
 {
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
 	int err = 0;
-- 
2.18.1

