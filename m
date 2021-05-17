Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279D4383A6D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbhEQQtj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:39 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:65527
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242415AbhEQQta (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCAXPBCLpu0bHPlJ4YhgnXcR2t+24GwEn40iiAIRLuAcAiH9u80sPHMcH6EVOhRCEbqpj4RTd85I3uFS8sdBVfUKKVKeHr2HhARQ8MIdIPMy9xL3Gt7NEZIt+SdjybSo8ro4eoUqtVuflAbqCg1nkYFxeJGBEcdBhvn0HikrwEP5WwFju+11IaIAcaFrRqt7LB+4zawhYBQPlAbJa+PLVbtm1gZYspQzM4FnMRvgy8izdMXSDa1df2bvTOJiIgq7C74Br0DklKn6AQWVXn+AeYgFdFdYE0Q5HX1VZPBYijjXY2oDTGCLV0mkCYpfawOzLVhf96w7RjdrWb16a4wT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdvSy9d1raH9lgNQt8O5rTK95wQq2pYsMmdcHpAvFdQ=;
 b=RPmRKPkyAONyFYljIDlHyuVl1pe14+4dfI3MdnawfYpsBPtVi7d+bLen355WiFM3xP/cLSzefapG9sGMmqBuDbeYzpokrk7td2/JobDgrslnwYJ1S/k+MARMCNKoR9Ajl0grMfekWvYr4q5h0xuNCJY6MLsd1lNGnkLPYBCf+SXTnWmQXVb/L9DNZ/3D3foFN32TIw+1SCaaBCJe53tXuoGqixDc92HOjVJRO5HmfIV5b6HGaXd8Ly2rt2kQjuwhHpfxZ4M2eVZsb8e6g9i8ySNHOMzC7cC0CIJErIkeWIDxcrPaFz5V6oIFp52end5SDVoslI+0ro0j7+JjyxDN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdvSy9d1raH9lgNQt8O5rTK95wQq2pYsMmdcHpAvFdQ=;
 b=Z8z0R7mSVhVLdcZt5PSL6q6uMvvicy0zEPOwOHIdMkfu2exkD2F9dhz9nwFt7sOiQWjDuqU9WEsSJgYTLRURvW9+ccoL4EcnOxYDQpemaTVp9Hei8zTRfD9skf2D9ZJMg+fpOnvVH3Hf0mNKhlxBmiIQqflgKe51dj64QsKk6WY56DKzBR70omylUAQEBmQC49AsuyKr+gQnUFusNubFztbqObIYJHG1WD8XqN5slXbuWyC+O4btb4QJV9PmgUlv/weC0EVUg218EmYDcgO/Sognt4QpL+plKsLSK/qERDeEmnkxbcn2sPmY3DonINzTWOkbAiAN1n08bvf86VAsVw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:49 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 10/13] RDMA/cm: Use an attribute_group on the ib_port_attribute intead of kobj's
Date:   Mon, 17 May 2021 13:47:38 -0300
Message-Id: <10-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:23a::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:23a::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 16:47:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP8-009LYw-4u; Mon, 17 May 2021 13:47:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32959656-a5cc-4809-f960-08d919537f29
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28587F5AC0611952FB393F7EC22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rA4MPHtABUywT3jTJbxw0lIH3Q75GClSSHW29unHK0p2qsAkoCMYNnHk7jfaXaOhnRjayij+71IdzpyJSIwJFQ8Z7hA8r1VSzZODFOIFwDRrrr53ZJYHa22sf3HfqEIGhq3ZTU30hpAO3dxnUIvqGPm6frGFx8n+1DQALzhTpl86qtfvLrL2bprya51nKXquewN2rkf/NCrwGnYS1moUpOqyV0y7DH0NxiU5CGGZuY4OSdPZ8106IMuKyuakeinQu6cKqG/kF22UzeXNoyjuFEC0+2uZ4mX7hR0PENYtPJd6fGk3NSXovDiRrckfN2ikDpD8OrCtcrM9s5m+1EDPhtpvsySFZ342LauNIG+4dSnWpeusGCtuMYsPS/lYvuRbdJ4cJKz3ioFFmDdSeLqCAB3JHPPOpUmZO2fBN7+8ARzMftzKfvgAxaRWmVt7qfHZWw5uyecry3ZSNlwWQ+OLTbPosF7iJ6zXl53DzZTfr4wh99CbTYJtcx+hL5C01KqU89/+MyexNtU0ZVPJIM6ACnEud02iimSdOlxfTuh93sfU45uRqRv3y7Z3gnQauJkSK4WCPmrz9Af3hJsIUsW5PZbj98uf0cz2nod7cDdwwPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(6666004)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(30864003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vwmY5GzfU9y/hvS7PsZLeYdRBi14bkjfuGKb1ghLtl9MLyFw2680JS/UZqoI?=
 =?us-ascii?Q?GGmw36vY2G2XnNx0aFotysgGLk+P/28tsmCMjj+NjLgx130R3X3O/YaK4nCu?=
 =?us-ascii?Q?lI3bvhAd3iEh41k8n0dKYiLPMPV0BH/PcKYB1SpoasZjhAMsc0C/O3aFSvOS?=
 =?us-ascii?Q?oLPvZbnwQKp9Hil/pxb/fiong8YDMRG++5FiZD0lOBqD3HYHtTaINO8/8oLe?=
 =?us-ascii?Q?dvPcCd3HzfJmf+jgNXb1TyIECFZWfUjJ6VVtICZ0Nwr3v30XEs1ow0Zb5GuT?=
 =?us-ascii?Q?2hvn6gKEHwKYR1LAax0HQgFEd72qoYcsgAPISUwE+eYcz0LlMmk+PcVFUeyN?=
 =?us-ascii?Q?6dCv6bV8XuxpHsCnppeiPPdY8C6g/PUVymv4xk30xrl/lS9v4lQNqppfo/gg?=
 =?us-ascii?Q?GhZJxiKZr/Ql/88+u1i7nXUbLrc9HzICj7CWcpVHyCZfH5K+HHijOMnN/21O?=
 =?us-ascii?Q?In2H1Z3O35qfq4YpWT1zWNXcKsPT/Cy6kQBx6klvk0LGMfw2/W0UU2bVcLZV?=
 =?us-ascii?Q?wJ812X3FC/NnL/WlH5SdSMNnqrhwbTcgnPUz72r+/dRrmffbzzDWjr8TLx4k?=
 =?us-ascii?Q?G8k5J+lh6qrrttXRmDeQhBxM9IKbEoyJcXnyJJ5IjRaQoK3tgNGvMeDyZwFt?=
 =?us-ascii?Q?S6JFO6yiMqQkUxOHCZr/VmzckY3iYCxiIGtA7bpsfI64FLedF2rKH50vghy1?=
 =?us-ascii?Q?73CB6U9ko3BBOW3Sg2h5OjhnUTok64yLfmbPSuOHzQ+5PgUuQVwIHmxguOOL?=
 =?us-ascii?Q?COSfTDJ/iKd7erqsrNr+rOdP3xrPtXl7hJlXSardB0kESOwFiD7ZzxqwRFAd?=
 =?us-ascii?Q?Eqr1AGib6FSubgTnkZ64GLKdLCy8a3fR/xui49NWgGGJni9eNsGykWfbgBMU?=
 =?us-ascii?Q?FbSskJ9axUbQIm9Rp8ila68aescRAzCk3Ksd6TTpYHOCWivSQlF9E7AyS2gN?=
 =?us-ascii?Q?4MAIsOuQO0Olsv0H+KQk3fDwjBNRYswRGO++lz6mGXxn/2cjCb1borItUQ7P?=
 =?us-ascii?Q?z44+XkYPZgAyQKxf/X6D/NqrJoH0qszHon6+3hc7D03xygR8Lspmx/dbxkfg?=
 =?us-ascii?Q?I8ODrqvw+QKf55F2ov6yGOk+69ANETYzONZHc/AmUBZSq/wfgCWi1BEh1fZa?=
 =?us-ascii?Q?8vn/CTcl2amRE7Nb8IVLR1xwhRBQF2KYo7yzjUoUQd9jjyPqV1EII14QUTxy?=
 =?us-ascii?Q?l7MsrTAvvdfN+bt7tchbafAy9x/BlL2Fd9JZLM4HAdErOTDUGxqKXn13L/L6?=
 =?us-ascii?Q?ZATRrMpxOVf0ONJp9h/lvu9dNF5P1b8z86Ua7AjLxKVXmIcJ+UGn52Q4V5Ni?=
 =?us-ascii?Q?QGm91qNbyjjZcJpRhTcmI+7e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32959656-a5cc-4809-f960-08d919537f29
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:45.8661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P37uA2HZQdtMO4BhC5XUTaBvVMeObQgEpsfUMCoFP2b9pCxwa+rSPITjN2TBEG6+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This code is trying to attach a list of counters grouped into 4 groups to
the ib_port sysfs. Instead of creating a bunch of kobjects simply express
everything naturally as an ib_port_attribute and add a single
attribute_groups list.

Remove all the naked kobject manipulations.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cm.c        | 227 ++++++++++++----------------
 drivers/infiniband/core/core_priv.h |   8 +-
 drivers/infiniband/core/sysfs.c     |  50 ++----
 3 files changed, 119 insertions(+), 166 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 0ead0d22315401..fc8fcb502eb479 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -25,6 +25,7 @@
 
 #include <rdma/ib_cache.h>
 #include <rdma/ib_cm.h>
+#include <rdma/ib_sysfs.h>
 #include "cm_msgs.h"
 #include "core_priv.h"
 #include "cm_trace.h"
@@ -150,53 +151,10 @@ enum {
 	CM_COUNTER_GROUPS
 };
 
-static char const counter_group_names[CM_COUNTER_GROUPS]
-				     [sizeof("cm_rx_duplicates")] = {
-	"cm_tx_msgs", "cm_tx_retries",
-	"cm_rx_msgs", "cm_rx_duplicates"
-};
-
-struct cm_counter_group {
-	struct kobject obj;
-	atomic_long_t counter[CM_ATTR_COUNT];
-};
-
 struct cm_counter_attribute {
-	struct attribute attr;
-	int index;
-};
-
-#define CM_COUNTER_ATTR(_name, _index) \
-struct cm_counter_attribute cm_##_name##_counter_attr = { \
-	.attr = { .name = __stringify(_name), .mode = 0444 }, \
-	.index = _index \
-}
-
-static CM_COUNTER_ATTR(req, CM_REQ_COUNTER);
-static CM_COUNTER_ATTR(mra, CM_MRA_COUNTER);
-static CM_COUNTER_ATTR(rej, CM_REJ_COUNTER);
-static CM_COUNTER_ATTR(rep, CM_REP_COUNTER);
-static CM_COUNTER_ATTR(rtu, CM_RTU_COUNTER);
-static CM_COUNTER_ATTR(dreq, CM_DREQ_COUNTER);
-static CM_COUNTER_ATTR(drep, CM_DREP_COUNTER);
-static CM_COUNTER_ATTR(sidr_req, CM_SIDR_REQ_COUNTER);
-static CM_COUNTER_ATTR(sidr_rep, CM_SIDR_REP_COUNTER);
-static CM_COUNTER_ATTR(lap, CM_LAP_COUNTER);
-static CM_COUNTER_ATTR(apr, CM_APR_COUNTER);
-
-static struct attribute *cm_counter_default_attrs[] = {
-	&cm_req_counter_attr.attr,
-	&cm_mra_counter_attr.attr,
-	&cm_rej_counter_attr.attr,
-	&cm_rep_counter_attr.attr,
-	&cm_rtu_counter_attr.attr,
-	&cm_dreq_counter_attr.attr,
-	&cm_drep_counter_attr.attr,
-	&cm_sidr_req_counter_attr.attr,
-	&cm_sidr_rep_counter_attr.attr,
-	&cm_lap_counter_attr.attr,
-	&cm_apr_counter_attr.attr,
-	NULL
+	struct ib_port_attribute attr;
+	unsigned short group;
+	unsigned short index;
 };
 
 struct cm_port {
@@ -205,7 +163,7 @@ struct cm_port {
 	u32 port_num;
 	struct list_head cm_priv_prim_list;
 	struct list_head cm_priv_altr_list;
-	struct cm_counter_group counter_group[CM_COUNTER_GROUPS];
+	atomic_long_t counters[CM_COUNTER_GROUPS][CM_ATTR_COUNT];
 };
 
 struct cm_device {
@@ -1934,8 +1892,8 @@ static void cm_dup_req_handler(struct cm_work *work,
 	struct ib_mad_send_buf *msg = NULL;
 	int ret;
 
-	atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-			counter[CM_REQ_COUNTER]);
+	atomic_long_inc(
+		&work->port->counters[CM_RECV_DUPLICATES][CM_REQ_COUNTER]);
 
 	/* Quick state check to discard duplicate REQs. */
 	spin_lock_irq(&cm_id_priv->lock);
@@ -2426,8 +2384,8 @@ static void cm_dup_rep_handler(struct cm_work *work)
 	if (!cm_id_priv)
 		return;
 
-	atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-			counter[CM_REP_COUNTER]);
+	atomic_long_inc(
+		&work->port->counters[CM_RECV_DUPLICATES][CM_REP_COUNTER]);
 	ret = cm_alloc_response_msg(work->port, work->mad_recv_wc, &msg);
 	if (ret)
 		goto deref;
@@ -2604,8 +2562,8 @@ static int cm_rtu_handler(struct cm_work *work)
 	if (cm_id_priv->id.state != IB_CM_REP_SENT &&
 	    cm_id_priv->id.state != IB_CM_MRA_REP_RCVD) {
 		spin_unlock_irq(&cm_id_priv->lock);
-		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-				counter[CM_RTU_COUNTER]);
+		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+						     [CM_RTU_COUNTER]);
 		goto out;
 	}
 	cm_id_priv->id.state = IB_CM_ESTABLISHED;
@@ -2810,8 +2768,8 @@ static int cm_dreq_handler(struct cm_work *work)
 		cpu_to_be32(IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg)),
 		cpu_to_be32(IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg)));
 	if (!cm_id_priv) {
-		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-				counter[CM_DREQ_COUNTER]);
+		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+						     [CM_DREQ_COUNTER]);
 		cm_issue_drep(work->port, work->mad_recv_wc);
 		trace_icm_no_priv_err(
 			IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg),
@@ -2840,8 +2798,8 @@ static int cm_dreq_handler(struct cm_work *work)
 	case IB_CM_MRA_REP_RCVD:
 		break;
 	case IB_CM_TIMEWAIT:
-		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-				counter[CM_DREQ_COUNTER]);
+		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+						     [CM_DREQ_COUNTER]);
 		msg = cm_alloc_response_msg_no_ah(work->port, work->mad_recv_wc);
 		if (IS_ERR(msg))
 			goto unlock;
@@ -2856,8 +2814,8 @@ static int cm_dreq_handler(struct cm_work *work)
 			cm_free_msg(msg);
 		goto deref;
 	case IB_CM_DREQ_RCVD:
-		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-				counter[CM_DREQ_COUNTER]);
+		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+						     [CM_DREQ_COUNTER]);
 		goto unlock;
 	default:
 		trace_icm_dreq_unknown_err(&cm_id_priv->id);
@@ -3212,17 +3170,17 @@ static int cm_mra_handler(struct cm_work *work)
 		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
 				  cm_id_priv->msg, timeout)) {
 			if (cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
-				atomic_long_inc(&work->port->
-						counter_group[CM_RECV_DUPLICATES].
-						counter[CM_MRA_COUNTER]);
+				atomic_long_inc(
+					&work->port->counters[CM_RECV_DUPLICATES]
+							     [CM_MRA_COUNTER]);
 			goto out;
 		}
 		cm_id_priv->id.lap_state = IB_CM_MRA_LAP_RCVD;
 		break;
 	case IB_CM_MRA_REQ_RCVD:
 	case IB_CM_MRA_REP_RCVD:
-		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-				counter[CM_MRA_COUNTER]);
+		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+						     [CM_MRA_COUNTER]);
 		fallthrough;
 	default:
 		trace_icm_mra_unknown_err(&cm_id_priv->id);
@@ -3328,8 +3286,8 @@ static int cm_lap_handler(struct cm_work *work)
 	case IB_CM_LAP_IDLE:
 		break;
 	case IB_CM_MRA_LAP_SENT:
-		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-				counter[CM_LAP_COUNTER]);
+		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+						     [CM_LAP_COUNTER]);
 		msg = cm_alloc_response_msg_no_ah(work->port, work->mad_recv_wc);
 		if (IS_ERR(msg))
 			goto unlock;
@@ -3346,8 +3304,8 @@ static int cm_lap_handler(struct cm_work *work)
 			cm_free_msg(msg);
 		goto deref;
 	case IB_CM_LAP_RCVD:
-		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-				counter[CM_LAP_COUNTER]);
+		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+						     [CM_LAP_COUNTER]);
 		goto unlock;
 	default:
 		goto unlock;
@@ -3576,8 +3534,8 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	listen_cm_id_priv = cm_insert_remote_sidr(cm_id_priv);
 	if (listen_cm_id_priv) {
 		spin_unlock_irq(&cm.lock);
-		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-				counter[CM_SIDR_REQ_COUNTER]);
+		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+						     [CM_SIDR_REQ_COUNTER]);
 		goto out; /* Duplicate message. */
 	}
 	cm_id_priv->id.state = IB_CM_SIDR_REQ_RCVD;
@@ -3821,12 +3779,10 @@ static void cm_send_handler(struct ib_mad_agent *mad_agent,
 	if (!msg->context[0] && (attr_index != CM_REJ_COUNTER))
 		msg->retries = 1;
 
-	atomic_long_add(1 + msg->retries,
-			&port->counter_group[CM_XMIT].counter[attr_index]);
+	atomic_long_add(1 + msg->retries, &port->counters[CM_XMIT][attr_index]);
 	if (msg->retries)
 		atomic_long_add(msg->retries,
-				&port->counter_group[CM_XMIT_RETRIES].
-				counter[attr_index]);
+				&port->counters[CM_XMIT_RETRIES][attr_index]);
 
 	switch (mad_send_wc->status) {
 	case IB_WC_SUCCESS:
@@ -4063,8 +4019,7 @@ static void cm_recv_handler(struct ib_mad_agent *mad_agent,
 	}
 
 	attr_id = be16_to_cpu(mad_recv_wc->recv_buf.mad->mad_hdr.attr_id);
-	atomic_long_inc(&port->counter_group[CM_RECV].
-			counter[attr_id - CM_ATTR_ID_OFFSET]);
+	atomic_long_inc(&port->counters[CM_RECV][attr_id - CM_ATTR_ID_OFFSET]);
 
 	work = kmalloc(struct_size(work, path, paths), GFP_KERNEL);
 	if (!work) {
@@ -4262,59 +4217,74 @@ int ib_cm_init_qp_attr(struct ib_cm_id *cm_id,
 }
 EXPORT_SYMBOL(ib_cm_init_qp_attr);
 
-static ssize_t cm_show_counter(struct kobject *obj, struct attribute *attr,
-			       char *buf)
+static ssize_t cm_show_counter(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *attr, char *buf)
 {
-	struct cm_counter_group *group;
-	struct cm_counter_attribute *cm_attr;
+	struct cm_counter_attribute *cm_attr =
+		container_of(attr, struct cm_counter_attribute, attr);
+	struct cm_device *cm_dev = ib_get_client_data(ibdev, &cm_client);
 
-	group = container_of(obj, struct cm_counter_group, obj);
-	cm_attr = container_of(attr, struct cm_counter_attribute, attr);
+	if (WARN_ON(!cm_dev))
+		return -EINVAL;
 
-	return sysfs_emit(buf, "%ld\n",
-			  atomic_long_read(&group->counter[cm_attr->index]));
+	return sysfs_emit(
+		buf, "%ld\n",
+		atomic_long_read(
+			&cm_dev->port[port_num - 1]
+				 ->counters[cm_attr->group][cm_attr->index]));
 }
 
-static const struct sysfs_ops cm_counter_ops = {
-	.show = cm_show_counter
-};
-
-static struct kobj_type cm_counter_obj_type = {
-	.sysfs_ops = &cm_counter_ops,
-	.default_attrs = cm_counter_default_attrs
-};
-
-static int cm_create_port_fs(struct cm_port *port)
-{
-	int i, ret;
-
-	for (i = 0; i < CM_COUNTER_GROUPS; i++) {
-		ret = ib_port_register_module_stat(port->cm_dev->ib_device,
-						   port->port_num,
-						   &port->counter_group[i].obj,
-						   &cm_counter_obj_type,
-						   counter_group_names[i]);
-		if (ret)
-			goto error;
+#define CM_COUNTER_ATTR(_name, _group, _index)                                 \
+	{                                                                      \
+		.attr = __ATTR(_name, 0444, cm_show_counter, NULL),            \
+		.group = _group, .index = _index                               \
 	}
 
-	return 0;
-
-error:
-	while (i--)
-		ib_port_unregister_module_stat(&port->counter_group[i].obj);
-	return ret;
-
-}
-
-static void cm_remove_port_fs(struct cm_port *port)
-{
-	int i;
-
-	for (i = 0; i < CM_COUNTER_GROUPS; i++)
-		ib_port_unregister_module_stat(&port->counter_group[i].obj);
+#define CM_COUNTER_GROUP(_group, _name)                                        \
+	static struct cm_counter_attribute cm_counter_attr_##_group[] = {      \
+		CM_COUNTER_ATTR(req, _group, CM_REQ_COUNTER),                  \
+		CM_COUNTER_ATTR(mra, _group, CM_MRA_COUNTER),                  \
+		CM_COUNTER_ATTR(rej, _group, CM_REJ_COUNTER),                  \
+		CM_COUNTER_ATTR(rep, _group, CM_REP_COUNTER),                  \
+		CM_COUNTER_ATTR(rtu, _group, CM_RTU_COUNTER),                  \
+		CM_COUNTER_ATTR(dreq, _group, CM_DREQ_COUNTER),                \
+		CM_COUNTER_ATTR(drep, _group, CM_DREP_COUNTER),                \
+		CM_COUNTER_ATTR(sidr_req, _group, CM_SIDR_REQ_COUNTER),        \
+		CM_COUNTER_ATTR(sidr_rep, _group, CM_SIDR_REP_COUNTER),        \
+		CM_COUNTER_ATTR(lap, _group, CM_LAP_COUNTER),                  \
+		CM_COUNTER_ATTR(apr, _group, CM_APR_COUNTER),                  \
+	};                                                                     \
+	static struct attribute *cm_counter_attrs_##_group[] = {               \
+		&cm_counter_attr_##_group[0].attr.attr,                        \
+		&cm_counter_attr_##_group[1].attr.attr,                        \
+		&cm_counter_attr_##_group[2].attr.attr,                        \
+		&cm_counter_attr_##_group[3].attr.attr,                        \
+		&cm_counter_attr_##_group[4].attr.attr,                        \
+		&cm_counter_attr_##_group[5].attr.attr,                        \
+		&cm_counter_attr_##_group[6].attr.attr,                        \
+		&cm_counter_attr_##_group[7].attr.attr,                        \
+		&cm_counter_attr_##_group[8].attr.attr,                        \
+		&cm_counter_attr_##_group[9].attr.attr,                        \
+		&cm_counter_attr_##_group[10].attr.attr,                       \
+		NULL,                                                          \
+	};                                                                     \
+	static const struct attribute_group cm_counter_group_##_group = {      \
+		.name = _name,                                                 \
+		.attrs = cm_counter_attrs_##_group,                            \
+	};
 
-}
+CM_COUNTER_GROUP(CM_XMIT, "cm_tx_msgs")
+CM_COUNTER_GROUP(CM_XMIT_RETRIES, "cm_tx_retries")
+CM_COUNTER_GROUP(CM_RECV, "cm_rx_msgs")
+CM_COUNTER_GROUP(CM_RECV_DUPLICATES, "cm_rx_duplicates")
+
+static const struct attribute_group *cm_counter_groups[] = {
+	&cm_counter_group_CM_XMIT,
+	&cm_counter_group_CM_XMIT_RETRIES,
+	&cm_counter_group_CM_RECV,
+	&cm_counter_group_CM_RECV_DUPLICATES,
+	NULL,
+};
 
 static int cm_add_one(struct ib_device *ib_device)
 {
@@ -4341,6 +4311,8 @@ static int cm_add_one(struct ib_device *ib_device)
 	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
 	cm_dev->going_down = 0;
 
+	ib_set_client_data(ib_device, &cm_client, cm_dev);
+
 	set_bit(IB_MGMT_METHOD_SEND, reg_req.method_mask);
 	rdma_for_each_port (ib_device, i) {
 		if (!rdma_cap_ib_cm(ib_device, i))
@@ -4359,7 +4331,8 @@ static int cm_add_one(struct ib_device *ib_device)
 		INIT_LIST_HEAD(&port->cm_priv_prim_list);
 		INIT_LIST_HEAD(&port->cm_priv_altr_list);
 
-		ret = cm_create_port_fs(port);
+		ret = ib_port_register_client_groups(ib_device, i,
+						     cm_counter_groups);
 		if (ret)
 			goto error1;
 
@@ -4388,8 +4361,6 @@ static int cm_add_one(struct ib_device *ib_device)
 		goto free;
 	}
 
-	ib_set_client_data(ib_device, &cm_client, cm_dev);
-
 	write_lock_irqsave(&cm.device_lock, flags);
 	list_add_tail(&cm_dev->list, &cm.device_list);
 	write_unlock_irqrestore(&cm.device_lock, flags);
@@ -4398,7 +4369,7 @@ static int cm_add_one(struct ib_device *ib_device)
 error3:
 	ib_unregister_mad_agent(port->mad_agent);
 error2:
-	cm_remove_port_fs(port);
+	ib_port_unregister_client_groups(ib_device, i, cm_counter_groups);
 error1:
 	port_modify.set_port_cap_mask = 0;
 	port_modify.clr_port_cap_mask = IB_PORT_CM_SUP;
@@ -4410,7 +4381,8 @@ static int cm_add_one(struct ib_device *ib_device)
 		port = cm_dev->port[i-1];
 		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
 		ib_unregister_mad_agent(port->mad_agent);
-		cm_remove_port_fs(port);
+		ib_port_unregister_client_groups(ib_device, i,
+						 cm_counter_groups);
 		kfree(port);
 	}
 free:
@@ -4462,7 +4434,8 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 		port->mad_agent = NULL;
 		spin_unlock_irq(&cm.state_lock);
 		ib_unregister_mad_agent(cur_mad_agent);
-		cm_remove_port_fs(port);
+		ib_port_unregister_client_groups(ib_device, i,
+						 cm_counter_groups);
 		kfree(port);
 	}
 
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 6066c4b39876d6..78782cce47a19f 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -382,10 +382,10 @@ int ib_setup_device_attrs(struct ib_device *ibdev);
 
 int rdma_compatdev_set(u8 enable);
 
-int ib_port_register_module_stat(struct ib_device *device, u32 port_num,
-				 struct kobject *kobj, struct kobj_type *ktype,
-				 const char *name);
-void ib_port_unregister_module_stat(struct kobject *kobj);
+int ib_port_register_client_groups(struct ib_device *ibdev, u32 port_num,
+				   const struct attribute_group **groups);
+void ib_port_unregister_client_groups(struct ib_device *ibdev, u32 port_num,
+				     const struct attribute_group **groups);
 
 int ib_device_set_netns_put(struct sk_buff *skb,
 			    struct ib_device *dev, u32 ns_fd);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 58a45548bf1568..5d9c8bfc280d8f 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1449,46 +1449,26 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
 }
 
 /**
- * ib_port_register_module_stat - add module counters under relevant port
- *  of IB device.
+ * ib_port_register_client_group - Add an ib_client's attributes to the port
  *
- * @device: IB device to add counters
+ * @ibdev: IB device to add counters
  * @port_num: valid port number
- * @kobj: pointer to the kobject to initialize
- * @ktype: pointer to the ktype for this kobject.
- * @name: the name of the kobject
+ * @groups: Group list of attributes
+ *
+ * Do not use. Only for legacy sysfs compatibility.
  */
-int ib_port_register_module_stat(struct ib_device *device, u32 port_num,
-				 struct kobject *kobj, struct kobj_type *ktype,
-				 const char *name)
+int ib_port_register_client_groups(struct ib_device *ibdev, u32 port_num,
+				   const struct attribute_group **groups)
 {
-	struct kobject *p, *t;
-	int ret;
-
-	list_for_each_entry_safe(p, t, &device->coredev.port_list, entry) {
-		struct ib_port *port = container_of(p, struct ib_port, kobj);
-
-		if (port->port_num != port_num)
-			continue;
-
-		ret = kobject_init_and_add(kobj, ktype, &port->kobj, "%s",
-					   name);
-		if (ret) {
-			kobject_put(kobj);
-			return ret;
-		}
-	}
-
-	return 0;
+	return sysfs_create_groups(&ibdev->port_data[port_num].sysfs->kobj,
+				   groups);
 }
-EXPORT_SYMBOL(ib_port_register_module_stat);
+EXPORT_SYMBOL(ib_port_register_client_groups);
 
-/**
- * ib_port_unregister_module_stat - release module counters
- * @kobj: pointer to the kobject to release
- */
-void ib_port_unregister_module_stat(struct kobject *kobj)
+void ib_port_unregister_client_groups(struct ib_device *ibdev, u32 port_num,
+				      const struct attribute_group **groups)
 {
-	kobject_put(kobj);
+	return sysfs_remove_groups(&ibdev->port_data[port_num].sysfs->kobj,
+				   groups);
 }
-EXPORT_SYMBOL(ib_port_unregister_module_stat);
+EXPORT_SYMBOL(ib_port_unregister_client_groups);
-- 
2.31.1

