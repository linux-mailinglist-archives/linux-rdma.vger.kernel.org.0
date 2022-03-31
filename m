Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23984ED67B
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 11:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiCaJH2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiCaJH2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 05:07:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1658AC22
        for <linux-rdma@vger.kernel.org>; Thu, 31 Mar 2022 02:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAjQKoQBfJhyhz+ktmoKtF/2f4fWZuy6bxPcMoURbh8hEtJPCgNERkpU0IKjjzQg1EW2k0rDrC3fahIs9iwq79upb+2KhwiUPUYZBjzXMvCqvIbnUjjYa2DHT2+h0dLdgtUOtlALvBdjwIkQ8nM03Y6377Lqi4zVmLyTWB61EZTXW5dWeTIUDSrGYLdbnvKaVhRJnBIIZ1mta6CHVv5uda5nNS2muFMnRZoaSEroowQ320eqjpvhp7/fvO20azXw3W+VBPMYbfRLlWQaY8l2PAO5VzQdZKOnhhtxVB1k5ogVksmJm08Th86MhSMYWkQOG/bvKPtSM0+sC1jwh6NquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koWGOkcd6nKycXLmjcocOQ5IPgGyl11uvhUKv2kxoQ8=;
 b=WJCw8RmJ4O3bJ2o1jyj2JKjp45FnduXTY8TNOUyaQP7ofcLgM6dNGutggrTJJ+jXc7CmApSAn/uKHM41ay0OY6Xeufd2bjWG/0hiZ4Gtc6S1Ru1NjWEN4LGFu/733W6moSNQ1XXoH7Fnuywr1ZPAxwzioxQLLIKvprkJ5gB/Lef7BJ/9cnkvxDnQim3PVwlOZ+RFItjNY16Dt2QBOzUkIKiVD9a9lchDK+1Ejh5GOJaADO7YUYA+KbONaGPtPrZ6ZiBMGW6fdhGlfJCZ+sA8xCo3pnwolagsDZ2XtJ6NS7Hm4kBe6kXfYdtohLQHjeVkWF4o6upbrVBvvi/UQrb7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koWGOkcd6nKycXLmjcocOQ5IPgGyl11uvhUKv2kxoQ8=;
 b=n49gVDTCfj4e1vh22F3dwA6cWGoRFMQgOdFwfVZ3Tf81pa4KAZIcmcrv/M4BUXR7ShD7Kf1FewSmy/rCAS04zAT/xH755VhRmpoDbE0pVhcNokJ7fdvcHoPEP9sJ7bAmYddEniEecXDfIxa/b2mV7T24XsJWTeI4kOHF2TNOAHLDNX7CQ2ZYR69Cmn6dyjKx/4OkgsCmYoxoGRtHP6pZreyicvd/Pnjmkt13Bt3W2BwwdQRb/jn5TjD4A/WMbcWdm6tXeQrhQiGg/XrewdvFmo55G7ZMCYDWhQNDq4j/sI4IE5CDeTTgiJRNSbBn6ecaaQIXgYU7mmjdR8s/h+mG9w==
Received: from DM3PR12CA0135.namprd12.prod.outlook.com (2603:10b6:0:51::31) by
 MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 09:05:39 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::df) by DM3PR12CA0135.outlook.office365.com
 (2603:10b6:0:51::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Thu, 31 Mar 2022 09:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 09:05:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 31 Mar
 2022 09:05:38 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 31 Mar
 2022 02:05:37 -0700
Date:   Thu, 31 Mar 2022 11:51:03 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
CC:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Subject: Re: [PATCH v2] RDMA/rxe: Generate a completion on error after
 getting a wqe
Message-ID: <YkVrdzqZaDKPOEpC@unreal>
References: <20220328151748.304551-1-yangx.jy@fujitsu.com>
 <YkICq+3JmsTSrELB@unreal>
 <ce13b0dc-6e1e-28a1-75f3-dafaa044c230@fujitsu.com>
 <YkQKS0ZaB8inihGP@unreal>
 <e54bd3f3-92be-8574-894b-c5fb7aa59e58@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e54bd3f3-92be-8574-894b-c5fb7aa59e58@fujitsu.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a756df00-c8d6-41e4-40a7-08da12f5a039
X-MS-TrafficTypeDiagnostic: MN2PR12MB4093:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40933806705A5E2918237A99BDE19@MN2PR12MB4093.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WgUT+/2p+0Er+DnqrX+moHbjOZDBPh1eT7iN9oDDA961aVWHnOauZgE34Bzu+suKI3jecsv2TS9UImflJGYiyT6lN92c3Rc/fsKI//XG53UDmZr5Pda8oWlAPQCx5e1BJaY5F26RquaDF0GkQuXqFf/CsshcuoaPj4uQ+GXiZHeIjczIUM0n/bicM16HDofn4Un2DPPOyhL9WEuyIhShKBpn2ivpOVbbCKr5UdpA9INY0sr9GGnaV5Emv8f4dnX+OslfCsACxpmik9etVz560HUF0Qr74LaVrdkG8YBHhW7+59U/iGF6N1MYZ3zWoL8yrPm1B7YVK5ZPlHas/KlQb9ioDiiQb7k6zPmkUxrm9QYeTg7U60GDQzpbqeIYohWKoT26BXTvEILkVBmuimLNEkT2oHkg2VnAqP/iMzUt1zM4KcXP4bByARq1faJTZ5iKdCunlftm6Xw2MIElkRBoTgampKxkbn0USonryxUeT0wMg9SEcXuhAOfC1zLhsQeYZoyQCeUcV90HVWB1JRijCS+FaewV3nBKibaZMUGoIoyzeZ/VWHZOlbMJl0ccYShOQV80xoyWw0qMH2rKdwxY7jrwoNHkpRoXFayuHvvsNVhD+v/jyQrEwyyltUkzg0THyTxck5RAvUVCpblLVXwIlvN/tSVNvvbjmqTmIyL1oSrsbP6z3DYgSLqSRr0RxP6WR8YqO7prRf+3IE47TZixQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(7916004)(36840700001)(40470700004)(46966006)(8676002)(54906003)(6666004)(9686003)(6916009)(70586007)(316002)(82310400004)(53546011)(70206006)(36860700001)(86362001)(508600001)(40460700003)(336012)(186003)(2906002)(47076005)(26005)(83380400001)(16526019)(426003)(81166007)(356005)(33716001)(8936002)(4326008)(5660300002)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 09:05:38.9490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a756df00-c8d6-41e4-40a7-08da12f5a039
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 31, 2022 at 05:55:59AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/3/30 15:44, Leon Romanovsky wrote:
> > You will need to open IBTA spec and try to understand from it.
> > But realistically speaking, I think that it will be too hard to do it
> > and not sure if it is really important.
> >
> > Please resubmit your patch with updated diff and commit message.
> 
> Hi Leon,
> 
> It seems that your change is based on old code.
> 
> After looking into the latest code, this change seem not simpler and 
> clearer. do you think so?

No, something like that will do the trick.

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 3b05314ca739..5938cba936d9 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -104,9 +104,6 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp)
        struct rxe_ah *ah;
        u32 ah_num;

-       if (ahp)
-               *ahp = NULL;
-
        if (!pkt || !pkt->qp)
                return NULL;

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..9afc8cf50863 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -648,26 +648,30 @@ int rxe_requester(void *arg)
                psn_compare(qp->req.psn, (qp->comp.psn +
                                RXE_MAX_UNACKED_PSNS)) > 0)) {
                qp->req.wait_psn = 1;
-               goto exit;
+               wqe->status = IB_WC_LOC_QP_OP_ERR;
+               goto err;
        }

        /* Limit the number of inflight SKBs per QP */
        if (unlikely(atomic_read(&qp->skb_out) >
                     RXE_INFLIGHT_SKBS_PER_QP_HIGH)) {
                qp->need_req_skb = 1;
-               goto exit;
+               wqe->status = IB_WC_LOC_QP_OP_ERR;
+               goto err;
        }

        opcode = next_opcode(qp, wqe, wqe->wr.opcode);
        if (unlikely(opcode < 0)) {
                wqe->status = IB_WC_LOC_QP_OP_ERR;
-               goto exit;
+               goto err;
        }
 
        mask = rxe_opcode[opcode].mask;
        if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
-               if (check_init_depth(qp, wqe))
-                       goto exit;
+               if (check_init_depth(qp, wqe)) {
+                       wqe->status = IB_WC_LOC_QP_OP_ERR;
+                       goto err;
+               }
        }
 
        mtu = get_mtu(qp);
@@ -704,32 +708,27 @@ int rxe_requester(void *arg)
        pkt.wqe = wqe;
 
        av = rxe_get_av(&pkt, &ah);
-       if (unlikely(!av)) {
-               pr_err("qp#%d Failed no address vector\n", qp_num(qp));
-               wqe->status = IB_WC_LOC_QP_OP_ERR;
-               goto err_drop_ah;
-       }
+       if (unlikely(!av))
+               goto qp_err;
 
        skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
        if (unlikely(!skb)) {
-               pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
-               wqe->status = IB_WC_LOC_QP_OP_ERR;
-               goto err_drop_ah;
+               rxe_put(ah);
+               goto qp_err;
        }
 
        ret = finish_packet(qp, av, wqe, &pkt, skb, payload);
        if (unlikely(ret)) {
-               pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
                if (ret == -EFAULT)
                        wqe->status = IB_WC_LOC_PROT_ERR;
                else
                        wqe->status = IB_WC_LOC_QP_OP_ERR;
                kfree_skb(skb);
-               goto err_drop_ah;
+               rxe_put(ah);
+               goto err;
        }
 
-       if (ah)
-               rxe_put(ah);
+       rxe_put(ah);
 
        /*
         * To prevent a race on wqe access between requester and completer,
@@ -751,17 +750,15 @@ int rxe_requester(void *arg)
                        goto exit;
                }
 
-               wqe->status = IB_WC_LOC_QP_OP_ERR;
-               goto err;
+               goto qp_err;
        }
 
        update_state(qp, wqe, &pkt);
 
        goto next_wqe;
 
-err_drop_ah:
-       if (ah)
-               rxe_put(ah);
+qp_err:
+       wqe->status = IB_WC_LOC_QP_OP_ERR;
 err:
        wqe->state = wqe_state_error;
        __rxe_do_task(&qp->comp.task);


> 
> Best Regards,
> 
> Xiao Yang
> 
> >
> > Thanks
