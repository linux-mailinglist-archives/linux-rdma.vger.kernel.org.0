Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0E4EBC00
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Mar 2022 09:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiC3HqK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Mar 2022 03:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiC3HqJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Mar 2022 03:46:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1208E62
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 00:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgPgPfNG4GUCqWKDHXxdj8ozncPQMyHON/IylJBuv+tN3STC2f/ppukUKu4JYLcdiUR0D8qq29lpEemtxx8KykHrvFi3WfuwP8ibjpwmEj6yEph5C6Zn0fECB7LVgCcz0EsH9jnqG+lqCwrvKFvYCghtS6v+a8iSbz/cTdyBsYiDdNpBTIsjRN51zPlre0ZfFGnuRFvwk4iVKTd3i2OzYr2uZ3yjwFDtCoZ6aFnuu9Fa59jdYL7/IXsGZDFlI8yUtJ6hzLACCrrNT4NdViFG9RZ0I/33naocKXYDpzyJROO+loWpdftL5IZKgwx/AH5m40WOsBx7a7UWXPItSM3qLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBuAhFX7ZEm4DfCHkuNWAJ9OMy6aW0R730kiUzPoDBM=;
 b=mqOLzLPLv86zi6qggCeF17RL1QYLrmpC2tSSdPV4eoRVbGw//FwwgCPgVS2MD2Fk+99sFv4Ybbswr72NTg6lHEumpAHCd/bguWDese40etFGrTMVaMcYHxFYnMLZj/ibjzCod5SeemXbZcUOpIxsqpdJo1GPaaXH5O5k0R4Rj954FCJeTsFhmH54LqTQUxkBc3ib6hPeKcMI1ijvmTCrQPh3kHnjF/Ud0lK8O4gBHbeezIyg1ZVQ7M5dxI6zcp3t+aCQJNzQFuQz0bksm6alzlZx9Ecd7YUOcLxrf7eYblJddhc5H+F0Tp9ViUDUlykPBkVjsr4FUf8VtMrM8v61qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBuAhFX7ZEm4DfCHkuNWAJ9OMy6aW0R730kiUzPoDBM=;
 b=ZvxkiHRaGtAnSZt0NoniPOGbK1/SliUZZcmRA7ypMPQbiqhUL02+IXBo07cBfttGUPeQakDTKt0gXg4wj/01G1OGorkiH+DdgYI+Ka0JCYjyctzaJPeEweGw534DSsyfrvsqyV/ymczAWWMz7EBFcCJUXEnVRN/uql3jiz/hmio8qKi4m9kRS+zzcXRnV8hhh8/w2a58P5GUGtl4y27OXRyYVSOXRj83qVuGB+L/VjSecEvOLIPZsq0q7nPpap7TiCKLkj6NW5yCdDi1f/vkILk3BqUE0yC8pehXIcLXTlb5/m+pPpL9//DAAHctkgwlmrBkroEGQdcj8SzqwYNApg==
Received: from DM5PR22CA0020.namprd22.prod.outlook.com (2603:10b6:3:101::30)
 by CO6PR12MB5409.namprd12.prod.outlook.com (2603:10b6:5:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Wed, 30 Mar
 2022 07:44:22 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::46) by DM5PR22CA0020.outlook.office365.com
 (2603:10b6:3:101::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 07:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 07:44:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 30 Mar
 2022 07:44:15 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 00:44:14 -0700
Date:   Wed, 30 Mar 2022 10:44:11 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
CC:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Subject: Re: [PATCH v2] RDMA/rxe: Generate a completion on error after
 getting a wqe
Message-ID: <YkQKS0ZaB8inihGP@unreal>
References: <20220328151748.304551-1-yangx.jy@fujitsu.com>
 <YkICq+3JmsTSrELB@unreal>
 <ce13b0dc-6e1e-28a1-75f3-dafaa044c230@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce13b0dc-6e1e-28a1-75f3-dafaa044c230@fujitsu.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28cc4090-f8d2-44ef-eeeb-08da12211ac7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5409:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54092603D6750E363DFA3EE9BD1F9@CO6PR12MB5409.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mAKJm+Lhg+uld5KcxDj1xAsd73plth8+quWR7ljtcK/hnVCWfJyknExgSvTT0bwK6j6/5iKXHL1sMTxmJKMluwqUjIhcJcPZ24/Iw1UI90h6mdKX/SFblv/dsJES01D1Y+56XdvsM2nC7+vPQTkfoCpqkxJEO6+P9drfqytmSf1JEVuEdtSUWVHUAySgx5i0ji3CzKRJ/5xGmKiz6dbs1ULDJ1Q0Y2TH0CqRty2wv970jjSpH6AM3/XB3hyrMrmjJfu95JSsxhzGisI/MTb5U6iJOjKjbBmAjOOfA3PEy5K6L4Sf2Be2C+CZVCU475J9RlPTEUI3dC9tu7yl8YEdLgsb+ZWGIc6b0O1F708KAsy3vE87nOhim2BsiI+tPfuTJgBORKPNDR1vZ9rdKgm5jJIYTyvDohD9BvTc9wqS6nKSfAschs6Zk7Da+AQYD3TCoVUiBz4DCBrvfpbv3tcPpeR8TYgzo4ZKkhjF3NZmfnGbOGlO236RGKCA+2+JtVzGaXuUgMmVH+RR1TdyzMICvzoiLErXMXt56OKEttlI2euKBKCZJlFvTyUrn8N6VXNUTtappGUC/tXZ6iQc1ehyT19AIwjtzescifmGsLUC/NBl1ZC2T7MVx4T1W4plRzW/JxNk/qJ+Zy7cmAfEfcgIDpTAeJ+7XupMeIJu8wa+vQN0k1cR0Fxj872QscxI7hFpv7tYA6wZZA8WDUTv3g0yQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(7916004)(40470700004)(36840700001)(46966006)(6666004)(53546011)(82310400004)(8676002)(4326008)(83380400001)(40460700003)(70586007)(36860700001)(316002)(70206006)(86362001)(6916009)(508600001)(426003)(47076005)(336012)(356005)(8936002)(81166007)(107886003)(186003)(9686003)(16526019)(33716001)(5660300002)(26005)(54906003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 07:44:21.7471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cc4090-f8d2-44ef-eeeb-08da12211ac7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5409
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 29, 2022 at 03:55:07AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/3/29 2:47, Leon Romanovsky wrote:
> > I see that you put same wqe->status for all error paths.
> > If we assume that same status needs to be for all errors, you will better
> > put this line under err label.
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> > index 5eb89052dd66..003a9b109eff 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_req.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> > @@ -752,6 +752,7 @@ int rxe_requester(void *arg)
> >          goto next_wqe;
> >
> >   err:
> > +       wqe->status = IB_WC_LOC_QP_OP_ERR;
> >          wqe->state = wqe_state_error;
> >          __rxe_do_task(&qp->comp.task);
> >
> >
> > BTW, I didn't review if same error status is applicable for all paths.
> 
> Hi Leon,
> 
> It's not suitable to set the same IB_WC_LOC_QP_OP_ERR for all paths 
> because other error status also will be set in some places.
> 
> For example:
> 
> IB_WC_LOC_QP_OP_ERR or IB_WC_MW_BIND_ERR will be set in rxe_do_local_ops()
> 
> IB_WC_LOC_PROT_ERR or IB_WC_LOC_QP_OP_ERR will be set by checking the 
> return value of finish_packet()

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 5eb89052dd66..5515a095cbba 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -657,26 +657,24 @@ int rxe_requester(void *arg)
                psn_compare(qp->req.psn, (qp->comp.psn +
                                RXE_MAX_UNACKED_PSNS)) > 0)) {
                qp->req.wait_psn = 1;
-               goto exit;
+               goto qp_err;
        }
 
        /* Limit the number of inflight SKBs per QP */
        if (unlikely(atomic_read(&qp->skb_out) >
                     RXE_INFLIGHT_SKBS_PER_QP_HIGH)) {
                qp->need_req_skb = 1;
-               goto exit;
+               goto qp_err;
        }
 
        opcode = next_opcode(qp, wqe, wqe->wr.opcode);
-       if (unlikely(opcode < 0)) {
-               wqe->status = IB_WC_LOC_QP_OP_ERR;
-               goto exit;
-       }
+       if (unlikely(opcode < 0))
+               goto qp_err;
 
        mask = rxe_opcode[opcode].mask;
        if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
                if (check_init_depth(qp, wqe))
-                       goto exit;
+                       goto qp_err;
        }
 
        mtu = get_mtu(qp);
@@ -706,11 +704,8 @@ int rxe_requester(void *arg)
        }
 
        skb = init_req_packet(qp, wqe, opcode, payload, &pkt);
-       if (unlikely(!skb)) {
-               pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
-               wqe->status = IB_WC_LOC_QP_OP_ERR;
-               goto err;
-       }
+       if (unlikely(!skb))
+               goto qp_err;
 
        ret = finish_packet(qp, wqe, &pkt, skb, payload);
        if (unlikely(ret)) {
@@ -742,15 +737,15 @@ int rxe_requester(void *arg)
                        rxe_run_task(&qp->req.task, 1);
                        goto exit;
                }
-
-               wqe->status = IB_WC_LOC_QP_OP_ERR;
-               goto err;
+               goto qp_err;
        }
 
        update_state(qp, wqe, &pkt, payload);
 
        goto next_wqe;
 
+qp_err:
+       wqe->status = IB_WC_LOC_QP_OP_ERR;
 err:
        wqe->state = wqe_state_error;
        __rxe_do_task(&qp->comp.task);

> 
> 
> Hi Leon, Bob, Yanjun
> 
> How can I know if IB_WC_LOC_QP_OP_ERR is suitable for all changes on my 
> patch?
> 
> In other words,  how can I know which error status should be used in 
> which case?

You will need to open IBTA spec and try to understand from it.
But realistically speaking, I think that it will be too hard to do it
and not sure if it is really important.

Please resubmit your patch with updated diff and commit message.

Thanks

> 
> 
> Best Regards,
> 
> Xiao Yang
> 
> >
> > Thanks
