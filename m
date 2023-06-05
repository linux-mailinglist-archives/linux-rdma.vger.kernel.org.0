Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6622722ED3
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFESh5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 14:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFESh4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 14:37:56 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011007.outbound.protection.outlook.com [52.101.47.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570E5CD
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 11:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ord6ziluU3OqItAccVtYflW6Wa+Ib1GTUBlEFZgRXTrRPGVkM9Zx00TLn1M+o8GTjUpAg0nsLE0D3cz73/2BndPux0NyrIVZKj1N+vSsyhZYb/HD290KC3M/lzmz8h7IZJ743N7wTeqPWsUpuc4mff77n+soYOLuGuoirro5r9QBEk66eAbC3wvxMuppWP6F9GfHl21WI6YHJw6F2Hi6TVoJ6saN3iW6X7zlxu3UTY+xe7uSJ83TL80LeP123Lxj2WMLjlxQRHbAvH8UhbOaHOYKLHRDIGdJg3B7xX9GExQVeGWVmLX2uW3zxUEPJsDa2lOtfXhwNCbsERG+Yp64KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8jc1JB2S9Unzr19wdyIlH8Fzwx9R6RvCR7MhgOlXeE=;
 b=HB/Zx9j/umxYe60ggDLnAqbeTW15qAxzJSxlZQ248IOJJXKNFi/BUMrZ0qKG45/SJ7X6D1XYGBFoq/lTfJLj/gjskkA97xqY+FW1uTFDEd4AOFfyZaK4mYOWlFSsRJaf8mac5YFeQuqDKRoD4JS/pM3RLoJLSriZihtLGoizYdsGLKzR1sg5lhHyEE51xnuBNuxwsXQo7/ospSKNAnR2qMKN/RwmGfw3zr1hxMwLXk48E4b5ycY+cv4U8rxGsB+i+mLIq8L4RqX14HmbMkS5eCow0LJkWu9vfdTRmYCjt7O+/H1ZmcyFKX+09zZC9UrmI05wXkS/uppuf5Ejljn+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8jc1JB2S9Unzr19wdyIlH8Fzwx9R6RvCR7MhgOlXeE=;
 b=Q891xCvjV+yPaOzqVXEwo+3OGIiTXWyD4ByzDB0J9l+3xqxmHggGbCDt395KxovGTbIsGQ97PWg+3DLlSmQegAbiBTVuDu1blk6t32J8uM0zxRAOKNTTSl+vxO0Y0146EdkpZ3yLZY/aSvxmriyu0CUk5oge69VaOJqAJO3iVZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB7915.namprd05.prod.outlook.com (2603:10b6:510:95::13)
 by SN7PR05MB9306.namprd05.prod.outlook.com (2603:10b6:806:272::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Mon, 5 Jun
 2023 18:37:52 +0000
Received: from PH0PR05MB7915.namprd05.prod.outlook.com
 ([fe80::8fa7:7958:5b31:f19b]) by PH0PR05MB7915.namprd05.prod.outlook.com
 ([fe80::8fa7:7958:5b31:f19b%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 18:37:52 +0000
From:   bryantan@vmware.com
To:     linux-rdma@vger.kernel.org, jgg@nvidia.com, leon@kernel.org
Cc:     Bryan Tan <bryantan@vmware.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] RDMA/vmw_pvrdma: Remove unnecessary check on wr->opcode
Date:   Mon,  5 Jun 2023 11:37:28 -0700
Message-Id: <20230605183728.47021-1-bryantan@vmware.com>
X-Mailer: git-send-email 2.35.1
Reply-To: bryantan@vmware.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::34) To PH0PR05MB7915.namprd05.prod.outlook.com
 (2603:10b6:510:95::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB7915:EE_|SN7PR05MB9306:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9e6cea-60c2-4d9a-bba7-08db65f3f896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQyPzLaDjUJHi08viwL3ycMyeBkPB/Hx8ylsx5JfUmoSc2zd/K++NgnFhgSyyneo8rE9RxAaj78gJnSYDVHYijr37KsJ85JeAWe0fosAfs3djQ2/8b3ixhSSduDWafRr6NtGDYwH5MlWGF8sOjuRmOHXtydbys6ltVz4cK3LUxRcJFlMci1Xt6BBfQlm1evg7BeZr+/MMw0mL7bYMSrGCt8FUKdErvCXxJLJQyBjBIfzYSGJHYqjGV1lQTHiPQe2/Ro5pSaATn5OKcrZo460s0Fv4h4LdbW5cR7UTnW/sxJArLFdsRsDlfoyojQ0uDRe3JQAbgVYzFCeIFRQWcwN/AwlGMMB3mXO3qetMvHq4SqSAa4ooTj4evSq/TOcM71gQ3knRdmbRsAuMs10oeFd5lqsGnLvS+HY/3fblzemx7Px41vpu5WIuM3ebvH680MUKZztxRE1n+NhW3URC21CEPmXiIZGz+8ha79EshNU+Eqsdnj3uzEZ38fnapF9IRWyM5LZ6KT4Ovj78iAf6MoOVd+hVqDiWL0mIau6zTHRpQHWm2RZEMcWVHXSP+HCovyB5u+9RsHXkanVPF3O3Bx03faw9zCobCY9eqJ9kggmnOZpwhHZyP8YgKS4TuPk5hyxL7WAD39cD5zoFOFUUllMa07EhQsx5YBU6l53qaDBFAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB7915.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(8676002)(8936002)(5660300002)(4744005)(316002)(2906002)(66476007)(66556008)(66946007)(4326008)(54906003)(41300700001)(52116002)(6666004)(6486002)(6506007)(6512007)(9686003)(26005)(1076003)(186003)(36756003)(2616005)(83380400001)(478600001)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VTqykIh6rUve8VNW9BcbM3XqFLS7fhCqD3EvhuxcL1i+tVzESpQtz+zGzpde?=
 =?us-ascii?Q?ulHOM1sXEOGc5FIcMduENIBNRE4RjAugMKstiWpq4fgiPaSi3m4gyIbJYvoG?=
 =?us-ascii?Q?Fw3Ptm5JP/CqDkuV+5Adc6p/cA+kp0gYexaUadayoaOWvqzyfsqZeRGLcU8i?=
 =?us-ascii?Q?BJIoL1i/ahTN3tB1950aKo9X1VupohO/p2ZxZm8teMOv+iN9vE1A13oNNTM3?=
 =?us-ascii?Q?Eg7Ote/H4PGGHBWdtHZSZwOT6LBwjnZMqpb8ToZuoxtww4+3eelpvTLW20/n?=
 =?us-ascii?Q?nDLev03PCZhwBsetTWzO1NQFavY3tsHuQt1dEewtluKquu15z+uSrsl00QPZ?=
 =?us-ascii?Q?YIfMIyyvEtDbcTrORpe+PoHZPCWVXJlXlgxp/3JEbf8BClTw70O5hTmvP8VU?=
 =?us-ascii?Q?0n6SrMmh6Yvtl/BYk9O1+IO4qlTFlqo6zlclicasaj8/hmQzj7THdp3CQhmS?=
 =?us-ascii?Q?u8+3X8Wrp5ddePOqxgBiajEe+y9IZqtF6NpABCCKQ7xqIQtCobUQrAM9wEE6?=
 =?us-ascii?Q?yndHBs5Ot1DX7DHbxJ4UEpwjdBhlAGrQCXfLziCXlqGU1cf2HTbiVe1W9AWp?=
 =?us-ascii?Q?jIiVboofJXKYqb5caHg+mYtmKMAoIvcQxZmBZIrP+IYgpTduIpFEbUaYgTKB?=
 =?us-ascii?Q?owWEiv6o1MpJlekwT+PZ3nLg0Uaq1DD9b4BmLAAE+hZPjG90tOsLBvfGc95x?=
 =?us-ascii?Q?aCvN6Evi/pT+PzIt7oGtpqlONyrJDp1gywidwwMsOgAMrXCaho/fELQsyfWW?=
 =?us-ascii?Q?nRkHnzn1leOrf9PCDurTvVSAchqr+++q08BURy/HDIBN9H4V0tqkQgJfMkeE?=
 =?us-ascii?Q?kGqFpaludu64VMWtNz9spO+f3EeKjn6hZRoY84zi26Bg8VKYxhKHtLyGForc?=
 =?us-ascii?Q?qXC4Eq9zSuYqG1xlFqv205IzzqkWScfx1bQHR7JBzbxtkfBKGWeoYciOMtcN?=
 =?us-ascii?Q?R3wYm5uEzGC7PccQyLcHA2RejEZK+cuuQbEIsmQ0e0hVjJmZaiKEW+t2S5Q2?=
 =?us-ascii?Q?p9nTWGuqNkGEgCw3Ta5vlNz7UMdwyTB3byWVfH/SgTtnmBzXMo5Z+hUH13X8?=
 =?us-ascii?Q?iiED13xzytLNnOcqVxMJ5QwsGpSnDpoTQMA4HKgnb92GCpRHDbnbozME1wvo?=
 =?us-ascii?Q?SFPypYZlC9TTREtKMPUQzNNwNqz2n0c818aDDp5SiJERp0/P3+nfmNCTAC+X?=
 =?us-ascii?Q?jMAzv9fTk7SkovPxQ3b7iwM3+KqpoWV5hamuoYBXCpgYVtSD0mSSd/sGRivd?=
 =?us-ascii?Q?jEntpQsI7XWicYa+UcToROLnDSLV2PAMS9sp5qQW+p69dJwfCSAUh9wVesiQ?=
 =?us-ascii?Q?rYKicFBNE9eqpwL56ifK5o/lXJIF4n7qkIPYMvj87RjxzmQGuDRKrJM4lgx3?=
 =?us-ascii?Q?qVtxC7t/7qnO6l93E63OebUvCyrbFZ7KwhOJgd7vIVb/y7cf1aCMk9KI8dWK?=
 =?us-ascii?Q?5TVcAmZhYC2u+RdNPwbRaIBYSRhDQ54q3D+6iu84VqLZNyTD0Lqa8OoFIu2R?=
 =?us-ascii?Q?fVEffhzVUWv2YJzlDdhXxlwG/PXMsOGQNI2lBcSi0VcpO1QXfyKvS2FBw5ay?=
 =?us-ascii?Q?tpYRLh1laKvPud65MmKGf8Foa7K8IIpM/6/IGRCc?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9e6cea-60c2-4d9a-bba7-08db65f3f896
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB7915.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 18:37:52.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pecEsS2UNIlwk23Tz7K+XEYC3oxodDALqmdHNg+fo3Pgq3GQg5b6vukT5eE3Zy0PvPWRM4KBWC+V9QRqz5ulVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB9306
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bryan Tan <bryantan@vmware.com>

wr->opcode is unsigned; checking if it is negative is unnecessary.
Fix this issue by removing the check.

Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Bryan Tan <bryantan@vmware.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index f83cd4a9d992..98b2a0090bf2 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -709,14 +709,6 @@ int pvrdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			goto out;
 		}
 
-		if (unlikely(wr->opcode < 0)) {
-			dev_warn_ratelimited(&dev->pdev->dev,
-					     "invalid send opcode\n");
-			*bad_wr = wr;
-			ret = -EINVAL;
-			goto out;
-		}
-
 		/*
 		 * Only support UD, RC.
 		 * Need to check opcode table for thorough checking.
-- 
2.25.1

