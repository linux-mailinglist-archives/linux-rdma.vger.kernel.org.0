Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9904EDA37
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 15:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiCaNHr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbiCaNHk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 09:07:40 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2126.outbound.protection.outlook.com [40.107.117.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681475FF1C;
        Thu, 31 Mar 2022 06:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahzIzYdiaNSZLUMtG2HQf0IbJ1Ead47oEpRn+nXfy611LsqAH90EEUoEIFVeyBQ4+eqbF9c2yLIPWC4g1ruTE9/fWtaea2GW42rrbqogxWiJ2FXFGI9aEXzEs0mBzvY6LKTnpPXT6MvZmKO7wKoxrBImXR5tauwHe2w+Yma7Qqme0M2Omn1ih7Imdy/Lvje20xoDnUdBDfqKYMTA4rcb3svP4AEpy/VKs9DgKcFFKz2nsSfAwxRXk+1aLT1clL/BRsEpR5mPjrdtWUgki6AZ21tUBOzvk3ubRjEF3mUPIIN6Ie5SeI96faz00AWyENHWP1YCXrtqbojIjv5IPK6H8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsMZf7bJmp/7li3zb253XLQSCpmWsvjJO90A2rERrFE=;
 b=k5Kgw+RlhHVudwfT0rRpf3B1RYg3AWBi+AxgQOjR/EEE5JjJefgv+drCPfeDgVUTwliaP/ROSaY3gelG10ZkSxgaQigNzw/MJpD707hOH/F7Qh48FYPL1/SjR4uOd3WPPB6yhkATKfvsz/gZ45nJxIgjSlvGCATqwpQ/YvLx4NdF4Cx2MdXs5njtxxVu3BD6DBwJ8xdQU0WUkY3fJfmV5HLgm2NveQFrAX/4Td24lk/as81JBNJQLoN3B8fIPcO3cmsEsPN1KbPZDsVr0WlIdshZmMsXhlE2XV1kNL3aSm/IXHHRKJTRYgqPIp+hvRIodWsuPjiC6QT5zNTGvQd2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsMZf7bJmp/7li3zb253XLQSCpmWsvjJO90A2rERrFE=;
 b=DmvjARzVz8YstZoLQARKHD4k12Df+y/Thota22HNZjrWFgZNHWqc+W9HiJaIEfMCkVaP3XxLn8YGPVBOQku2FG16cdAfzf8OpCmxhT3twvyGajWVf9t1gZaHLLF7FdHekTPJM/Z4r/98Uaxid85kPeGwsqCMIy/w4QmeVXeNIU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by KL1PR0601MB4161.apcprd06.prod.outlook.com (2603:1096:820:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 31 Mar
 2022 13:05:44 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 13:05:44 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        linux-rdma@vger.kernel.org (open list:INTEL ETHERNET PROTOCOL DRIVER
        FOR RDMA), linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH linux-next v2] RDMA: simplify if-if to if-else
Date:   Thu, 31 Mar 2022 21:05:25 +0800
Message-Id: <20220331130525.14750-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YkVu3vqjIPFRSGtM@unreal>
References: <YkVu3vqjIPFRSGtM@unreal>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0220.apcprd02.prod.outlook.com
 (2603:1096:201:20::32) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 914994f6-8362-4798-46a2-08da13172a5b
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4161:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB416128DE77EF83047F5711FDC7E19@KL1PR0601MB4161.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80BX7o2Fgkq1L9v06v9ID2yKnaFEzsFe/G39Ivvv76wL/KIO9Fex4K42Mpp8AgvPSlUawEYXpm9VAaMFPV6kDkxHYSIPyiM0nPDk4WHB1727d2/YoDX/EDezgAq7yqVxW620E3vF+xvtTBIMXMZlEcs0WaebuXsDZsgcn08nC5YGW+ujtLWTXaBlxO/9QQSuJGdy+RTYUbbojOpqp7Rp4w18XOKcjq78VMsduNp75YJw3M88r4YL9b45Pbe6uoZEStLy2w8THePqYmqkLQSIFF1W5J3AObJZjwxhVxNuKe22+XkmjfW+yXCu0xIz0ybfAyDgZ2EfKc2+ffF8f0V/iXcz84pgTPfSXtYmgGH1HZqSrWg03/CV5ywXJW07H4Cdwn7wtXhsDxxQun5KG3/n+/1fU6TrXsnkWY8FxqvSG9ZOPAx27v2u7ZoJIJ9BgyZf/4GqFRIrFf2E1SvJS0uA5m20ZYHydE+Sa/C/neIwIrdQEZyDEF1WQDfSyMeY/lZwp/oh0OKwY1p2NMKHHU+8iHIroUIXl6N83mLfoW9skHGQhOjZx2HC6eFBjVLyWteHjG8rPsqL3BkY3PXIHwUbpiqwowApSh8vmXtKZ/r+z/qHwAFKIUGjZeBMbwf7FCInzqgI7cdQNkaEGOpJDRCAhsd0mvn4jnXwRemvS9qCFHJWM19ECzkf2SmFngvoMFqbJOWNY+B9E7HIsIgrvChW9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(83380400001)(4326008)(6666004)(66946007)(26005)(36756003)(6506007)(5660300002)(66556008)(52116002)(107886003)(2616005)(6486002)(508600001)(316002)(110136005)(86362001)(8676002)(6512007)(38350700002)(186003)(8936002)(38100700002)(2906002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gcRa59tZ/yi5DfbAIgP4opYhuzO/8LyHui/S3o0Dcy+gmJ3NdFZWnH0fSweB?=
 =?us-ascii?Q?dWBfNv1ls94E8Yc/aFdVXDuKDpWl49Uhmy8BnwDS6rqExOLfW4MoxlV16++a?=
 =?us-ascii?Q?j5k9I9f7cCyrHZ8B7gskQCQCmoZiJf24Wg/X4eEXQvJCynu0g6NgbMMiUIoo?=
 =?us-ascii?Q?ONr44cMN34ro+pFnbkhXqFHCAMHP3AZbmoxw2vLQ7CBmBJEN6Qj4tAvySaXZ?=
 =?us-ascii?Q?ovBT4XhL8ocb9QO722OeWljvqPMstwy/s908JAgw5iwWFVdwxuVLR5K5nbDW?=
 =?us-ascii?Q?JHoyeJ6DGQiuEjGt4MEa9MBtU3pxoQouS54aJXYWG4M6kfgDu78FiZtOPxsU?=
 =?us-ascii?Q?gzGEk/shWAWcBBSop+BiTGNqx+4+qp5Db3PDIrViqPM+eWJ+vCjZiuNABlvF?=
 =?us-ascii?Q?S6rb5C46XBsK1rwKHaEO/mlwDdVS8wAmguekHzk/IO4/blUsghlpLlvi30JJ?=
 =?us-ascii?Q?NYKSUXKnNfiWf34NGIqHYb8eGytLyyxXLFqu8glrmrn65qDj/v4KxWxRkwOO?=
 =?us-ascii?Q?GXX7NYq/dO8g7t22lKQI2d9RwSz6aBQh0mQiOl8RS55F2vacqRtafbQun5OY?=
 =?us-ascii?Q?buwsXhQtIGwAlY5u+pOM4bnbiXWIbRS+YjZX4SVMIer1mXO8+2rJX0NjnhMO?=
 =?us-ascii?Q?VmS+FvJKTW9a4A6HtbIZwk3pm2+Q8yUrREZNZZcnD8u27+t8SBpm6n/dZB96?=
 =?us-ascii?Q?ea+W5Zo2++u0d1MWkuY0tyA1aEEoE/W/EXvgVqix/yWgR1UVSGG8Pe5KwszQ?=
 =?us-ascii?Q?+J9Cyjoqs9Ua/1CkPoijESVrqqByWzW5JLTHR4Y8TKh5YI1Wt6Id5+FNaP45?=
 =?us-ascii?Q?knI3gKOS5fW1lsnsz2doJ7LoagRIbGm4ziHZWCnBAWedtdYMG1+2YPrJ3mB+?=
 =?us-ascii?Q?zfmcohm9leG1s4hDD8HIjN1NslFKO0rcYejmns1Hx9lprVAZlnip5DuXkDrR?=
 =?us-ascii?Q?jOHlvn3/Vkt9rpZQgd4kTRI//MZgbCF3rPOl4QbSnqjnWIrA5Km0p+weERml?=
 =?us-ascii?Q?UGXoXdV4uuZMzFTr1P0wYwjtpZXsw3+JHNttHlXM9ZmIx8MLdDD95oVJdcxH?=
 =?us-ascii?Q?fT/5Rrb5SHef5EJamkvzKWZB9A856MF9eefEifLRHHii2ORKfxyxt2tXV4Wf?=
 =?us-ascii?Q?a8b7R1VsIOAPhLxNfk5XD2JG4yn4j/OlwtLXZnqsoWCIbrxwy+TekWDNaRP0?=
 =?us-ascii?Q?58G+yKd9YDpS/+OcJvH8hOJbybJIp+7B4y+IKeCX4hLTZor7pVsZEYkYdZxl?=
 =?us-ascii?Q?hlnciiWCIYcHaCIUOTeCmeLqTcgjhISWV/Ktc5nOqVFLLsKnFBruDe8fz6np?=
 =?us-ascii?Q?WqaVZx+9EcESQMPeSbeZqch5ZXhquBZIDdvxUux3dbSdqOBcUkLS7oNfgZH2?=
 =?us-ascii?Q?5hxypcX0pb09m7x5++q0zU0FNCrfHqPvSkOEP6kL9U0fOjfRqQcxYxHbiuYs?=
 =?us-ascii?Q?PwwSAn+1QvnheSurLYo3vNQOs+fmnpqmCyN94h8zUg6NrJ8jH31uoq8LPr/I?=
 =?us-ascii?Q?aD9xiNJ1fi/7zqXpPoIH1W2+b3kPYOB3X18IOJLWyFGx4VjzuqsbqJU1O7uR?=
 =?us-ascii?Q?nEnZRf5dzVbTZVOQURHPRb3VrrBEhkKu4ZHcZNJCR3Ob/jRai9Md9+9QtNDt?=
 =?us-ascii?Q?6SIk7wfmj9SPqpFdBm9nFVKq46cXxcf+Qsb3X/eNq2Acbau7RD9wufr5aJgp?=
 =?us-ascii?Q?E9/cEvSGQjE320XxTRc5V3aUHQDewNMnK4vpZpBJFKZMBpxqpcf6is4vNcDd?=
 =?us-ascii?Q?I20PaR/BHw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914994f6-8362-4798-46a2-08da13172a5b
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 13:05:44.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+1qD4jOGao9+RyME4rygQzMKXK6ue3iWC55ekb10Kia4dw56ZVrhpBxifuyLpFEmJH52wSjmU54eHDZkAI3hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4161
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace `if (!ret)` with `else` for simplification and
fix the unbalanced curly brackets.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/infiniband/hw/irdma/puda.c |  8 ++++----
 drivers/infiniband/hw/mlx4/mcg.c   | 29 +++++++++++++++++------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 397f3d070f90..8dd38e1f6cf0 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -838,11 +838,11 @@ static void irdma_puda_free_qp(struct irdma_puda_rsrc *rsrc)
 	}
 
 	ret = irdma_sc_qp_destroy(&rsrc->qp, 0, false, true, true);
-	if (ret)
+	if (ret) {
 		ibdev_dbg(to_ibdev(dev),
 			  "PUDA: error puda qp destroy wqe, status = %d\n",
 			  ret);
-	if (!ret) {
+	} else {
 		ret = irdma_sc_poll_for_cqp_op_done(dev->cqp, IRDMA_CQP_OP_DESTROY_QP,
 						    &compl_info);
 		if (ret)
@@ -869,9 +869,9 @@ static void irdma_puda_free_cq(struct irdma_puda_rsrc *rsrc)
 	}
 
 	ret = irdma_sc_cq_destroy(&rsrc->cq, 0, true);
-	if (ret)
+	if (ret) {
 		ibdev_dbg(to_ibdev(dev), "PUDA: error ieq cq destroy\n");
-	if (!ret) {
+	} else {
 		ret = irdma_sc_poll_for_cqp_op_done(dev->cqp, IRDMA_CQP_OP_DESTROY_CQ,
 						    &compl_info);
 		if (ret)
diff --git a/drivers/infiniband/hw/mlx4/mcg.c b/drivers/infiniband/hw/mlx4/mcg.c
index 33f525b744f2..c0beb9f4030a 100644
--- a/drivers/infiniband/hw/mlx4/mcg.c
+++ b/drivers/infiniband/hw/mlx4/mcg.c
@@ -304,13 +304,11 @@ static int send_leave_to_wire(struct mcast_group *group, u8 join_state)
 	ret = send_mad_to_wire(group->demux, (struct ib_mad *)&mad);
 	if (ret)
 		group->state = MCAST_IDLE;
-
 	/* set timeout handler */
-	if (!ret) {
+	else
 		/* calls mlx4_ib_mcg_timeout_handler */
 		queue_delayed_work(group->demux->mcg_wq, &group->timeout_work,
 				msecs_to_jiffies(MAD_TIMEOUT_MS));
-	}
 
 	return ret;
 }
@@ -561,8 +559,9 @@ static void mlx4_ib_mcg_timeout_handler(struct work_struct *work)
 				return;
 			}
 			mutex_lock(&group->lock);
-		} else
+		} else {
 			mcg_warn_group(group, "DRIVER BUG\n");
+		}
 	} else if (group->state == MCAST_LEAVE_SENT) {
 		if (group->rec.scope_join_state & 0xf)
 			group->rec.scope_join_state &= 0xf0;
@@ -571,8 +570,9 @@ static void mlx4_ib_mcg_timeout_handler(struct work_struct *work)
 		if (release_group(group, 1))
 			return;
 		mutex_lock(&group->lock);
-	} else
+	} else {
 		mcg_warn_group(group, "invalid state %s\n", get_state_string(group->state));
+	}
 	group->state = MCAST_IDLE;
 	atomic_inc(&group->refcount);
 	if (!queue_work(group->demux->mcg_wq, &group->work))
@@ -632,7 +632,7 @@ static int handle_join_req(struct mcast_group *group, u8 join_mask,
 			kfree(req);
 			ref = 1;
 			group->state = group->prev_state;
-		} else
+		} else {
 			group->state = MCAST_JOIN_SENT;
 	}
 
@@ -681,10 +681,12 @@ static void mlx4_ib_mcg_work_handler(struct work_struct *work)
 						list_del(&req->func_list);
 						kfree(req);
 						++rc;
-					} else
+					} else {
 						mcg_warn_group(group, "no request for failed join\n");
-			} else if (method == IB_SA_METHOD_DELETE_RESP && group->demux->flushing)
+					}
+			} else if (method == IB_SA_METHOD_DELETE_RESP && group->demux->flushing) {
 				++rc;
+			}
 		} else {
 			u8 resp_join_state;
 			u8 cur_join_state;
@@ -697,8 +699,9 @@ static void mlx4_ib_mcg_work_handler(struct work_struct *work)
 				/* successfull join */
 				if (!cur_join_state && resp_join_state)
 					--rc;
-			} else if (!resp_join_state)
-					++rc;
+			} else if (!resp_join_state) {
+				++rc;
+			}
 			memcpy(&group->rec, group->response_sa_mad.data, sizeof group->rec);
 		}
 		group->state = MCAST_IDLE;
@@ -730,8 +733,9 @@ static void mlx4_ib_mcg_work_handler(struct work_struct *work)
 			if (send_leave_to_wire(group, req_join_state)) {
 				group->state = group->prev_state;
 				++rc;
-			} else
+			} else {
 				group->state = MCAST_LEAVE_SENT;
+			}
 		}
 	}
 
@@ -898,8 +902,9 @@ int mlx4_ib_mcg_demux_handler(struct ib_device *ibdev, int port, int slave,
 				__be64 tid = mad->mad_hdr.tid;
 				*(u8 *)(&tid) = (u8)slave; /* in group we kept the modified TID */
 				group = search_relocate_mgid0_group(ctx, tid, &rec->mgid);
-			} else
+			} else {
 				group = NULL;
+			}
 		}
 
 		if (!group)
-- 
2.20.1

