Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A200D694EFE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Feb 2023 19:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjBMSOS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Feb 2023 13:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBMSOR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Feb 2023 13:14:17 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B13A196
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 10:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmG4rcarM4KQgSyfL3t8KtCusRFtA305n2i6zXpT6E8K1QjbggeSJgrtQhZkPaX7upJ3PS/oVBsXzGSQUn6KsmB7jbdxKBmtvUgk1VPN/9GimnN4cye7FBvyJBI34eFlXIYjWdoGKAhFxC5V6NZBHFYLd8KuscK4YAfW7cNDw2wi8BSQKG0nBpC0P9k3bsPncvtsL6rhuAqFPEvx/yG/f/VwpQ1fveWZOh8yNPO9aT+IZWp4NYDvk1CDX4L3bJ3hpDhTJ+wYKng5FrJ6MHvv6HgDMy7hh/FqP24dgx7YfWZiop1LbCVcBqbUGkbh0yiq/aW1XWbGr4bVKF79s/DviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWqXsx+6ZUFJ2nRC7QEWXbSn252x1jzQWKsBxumzzxA=;
 b=Ll+l2IrbN9wjuhxBY4OJO41ri/N+FyvoAULRM6rYu6IIlENEELlTPkwaouEjwaJTAVkpNdNlbyca8n+clQy2Vg533woWmQvMbArPejFbIOaFVizlFa3TD+Gjf2BzIPsquW1Smw9+GTCKUKuJz7Z8nHpAg6BX8H6CaM+XBADfGP16x5e1qqdK4KGflYCMIt2o5MDeEVEPhJVn1oXBG9S1NVJxLA42nLCdTjGx7JHGdj/CE1jwR6OsePTr2Mq9KI/82Onwcv/CRzSX/uttNIcrWKzkRRTLlpxgnE24rzH9M80L044x1+hB5rYO0fuEzzZPIlkXzhVGLRBdebkqget8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWqXsx+6ZUFJ2nRC7QEWXbSn252x1jzQWKsBxumzzxA=;
 b=T9XGAk5x78vZH6gJYbSAbm+jrAnoxSqiHp2oJqKNWrr6cp0mrEPmbfH79Y9vnoACnpXo+7gLJ6wZj5IdwZ4UcF7rICC6qFztXOFYEv7mWolTDrfiiVXh0rQkqOEqgOG6B2LYRFKjq7GlA6yaoH/TO9kcshbdSVLyv600fgDYBocFV7duYVKKBGj4v4WTb8GBZF/qg2I9CFQvljieJt5qNVmmJZzhLuoZHpT0NDTFnyDBKy7MCtdI2bjqDdQgrNmQCdqnVm5e6zSIuTni8/cG6E+c9RTxjjaq1iemCeeNfWJF4QRvx/OD1vXSj9b2jciopVXYAKdy3/TKleuPyf/TOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 18:14:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 18:14:13 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     Aharon Landau <aharonl@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH] RDMA/mlx5: Use rdma_umem_for_each_dma_block()
Date:   Mon, 13 Feb 2023 14:14:11 -0400
Message-Id: <0-v1-c13a5b88359b+556d0-mlx5_umem_block_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:32d::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: e06703c9-11f8-4d3f-e43c-08db0dee1c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BOBEVntah4LfRuEWO2k1nMcC2mNQs9OV1c7DL0Snf1s+q0lHMf9M5OVqACBEKXVo2Pk5jcyDf03fJKXoIqBVYasjJIOieZMiqK1zF6y1u59diD4a4MeyToZhXkrOsm4mhqf1/eVJQ35h5GT1F1lXDM+to7qcDIvL9+RKcLZMjxeQKeXgH6b+zwjDMVZpWyQZGkwefmMPOsy0Zsth1wQUaLu8I3BCdsbqh6GpddBNIzGiXDIk/xWxGt8hBP+0lI7ysalSor4jJJ9AUSv1HxU36O8oSP+Nv1e1mkF2czsnKfcPSqScewqUvLkFAr2IE1ejGSgdz/mnlTKWnI94i5rUxalGcwP/IxoSx9KkvUOKeC30q3ATXuE9dDLqSDpwz0reWNiEnVdXJCjCYNRxrutm/o+Ohs+HBfb2UpTregluNLv/9Wm5iciVBakio7DVJZQAtSjJo6kqFrvxneRonmsww9o8ZbU/xUBFG1MX1ooei3EqD/pv4liUNCcqHJijxqFHLH9Zz6wSvKyKYJT2F3f3muPg3GtrPCTYMtLMxoV/j9/T75Vt6Nvr8M/qHKz7kkxPF02xuXXG3QbvYWNGaJIaJPYsugqwxbhwtjH7JlReXLXsT/jD498Z933Wn63A3Pw32SCtX73OyZGhVrjOjhIGWJCKvuvpa0RbhpPQCn251fiUUiguBB4CFsf07K3S4rq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199018)(36756003)(4326008)(41300700001)(54906003)(316002)(66476007)(8676002)(66556008)(66946007)(38100700002)(86362001)(107886003)(26005)(6512007)(6506007)(186003)(5660300002)(2906002)(8936002)(2616005)(478600001)(6486002)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/7iYFbbg2kSw/TnGewaoF940eMYxyQdW+6XJMtDqJUSBnUFMHbU0pvqjO2va?=
 =?us-ascii?Q?ZTzEX/sslZ1QXtPgCHuulBKRo9bKqGfgiA8o+brzRKaLV1kKPIHONm5HiwOx?=
 =?us-ascii?Q?6mvwscGR3Gwi2VYjAp39qM/FF/ujc8fh4WM7B5oe8/BFxKpwe6n/GZiIJjAH?=
 =?us-ascii?Q?65L9Fk7mdwtP3yqr8mhs77J6p6V6PJ7eLFbyJz283mO54qWEcBjN2gM4JEx6?=
 =?us-ascii?Q?U7tAogdVgJ9LrNi3SOtA0vO0qZO90YQKXwSxWDp6ZOadTn2b/rcI/6qfp9Mj?=
 =?us-ascii?Q?YhR7zeNhcMY+4Ft0UOcElM8+64jVyjb1mCeWFoIDzAOvR/Db1UNkegIVhwab?=
 =?us-ascii?Q?JfSPpy8V/3JqZCs0HUspMy7gb1TqLWk6BPiRncVRv6RNbn9h2sO1x6i9xDOO?=
 =?us-ascii?Q?jnESo3EOF56/lV3gSJH4cwpxJ/KcTLsd56FgxGrc4BScUbON/bb+inaYaMEK?=
 =?us-ascii?Q?z2uMhOKiiZvsQuOguLhOcwTnkJKhO+EzUJC9oo4qKuWmQj/KJuiLvuX78uCM?=
 =?us-ascii?Q?4LudoBHtJbCVYdgAvp+lED3WmkuLz0sMrtlq9K00nqJ51Xsq1tEYTkqjLcOT?=
 =?us-ascii?Q?jT97BxEmEKLFQlTPfcYG3ich7N67KWUvwrGJNVSQNaLsx+6sItoJf/QbA0Rv?=
 =?us-ascii?Q?Nqf9ja/A9nKAvrlUUE3SRQSUHiWZk1gXhZgiHCwbeWLcCvzFcEP+wxLw3Reg?=
 =?us-ascii?Q?2Dz4GJ/5YwMtmKtBzjrsjCFlv0d9JP923H+XUXY8upj/P2/P22YM53YpG6U3?=
 =?us-ascii?Q?vIxZsNWfG4TLOocGwAleqy8nGhXHOgVyz5D+OwHNgNYRY4IKOZooFxrtyZtH?=
 =?us-ascii?Q?iIN6Jq+UePno3OHCWXuPjWZ71zZAYBljdPEqfa4mMpP8MqFvXp2D4hVtAkOV?=
 =?us-ascii?Q?LVwd1JkIqsFqs4H0Sgd3AaBABsBb/qU/pXXl68XKk7UIE/HgFVI2E1E29os+?=
 =?us-ascii?Q?juUn+Km+k3+714lxs2rowh2N65RVReZH4fsxV71vf/U04jFQEbXAYYAyPT15?=
 =?us-ascii?Q?Nqph47VLcv1Tp9ahbpaLjx3QXUKkCy2gZ6BnaDciW1WztZAEMExK++4980Tl?=
 =?us-ascii?Q?cs9dlJip6gPPOuIiPtYhiODN5+60MVv7A7DG3iNlmzXQ9uaKE4w/L3fqJ5k6?=
 =?us-ascii?Q?0ySDEesWuoLPlygUaQETNTZ+cW8KUxD/ZZmCUESSDuRJJvwSW6slVmkLBaNl?=
 =?us-ascii?Q?i9I1/lxnZJlGS/VvXotchlf0C7SYnpTmbEhhDaaJWY2PeM759LWJ0xNYQsT1?=
 =?us-ascii?Q?5xiYCkbSjbvKDcXrdsewiqKHm994evKLzb+q/pVKO7vWxD84KDzw535+Pyr4?=
 =?us-ascii?Q?zVl9QRfoQ9Ymn6DWaK+i/OopR6OKGOgBl1VD0VMM7Mbed6Fe2CB7j3rDZF/F?=
 =?us-ascii?Q?xxmwxz9ibphAWGQz+f+QpeJD3iAjLpC+EGIUp0jTzZ+7ngwn3Rhfvl841iAj?=
 =?us-ascii?Q?wRn5qc3ZZE9AtJuIkXabv6ZhSbJsmmDBYjTTbP1q2i1Y2h61Wdeur34MuhXD?=
 =?us-ascii?Q?r8B2Np+uDE3dsi68AKZiRe9Ro3U2w5h/o8G1yZPo0U4zvUtVv2m/HgjFHFSQ?=
 =?us-ascii?Q?fxMuw76u/eh3knkVG9twH6ZDGajieXpKE0i0IGam?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06703c9-11f8-4d3f-e43c-08db0dee1c6d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 18:14:13.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9bYJLsonNTvm5ME35Gwa4IqdZh2vu/xVK16GI33aeia8oqKaPR3vkXGVzji7o7i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace an open coding of rdma_umem_for_each_dma_block() with the proper
function.

Fixes: b3d47ebd4908 ("RDMA/mlx5: Use mlx5_umr_post_send_wait() to update MR pas")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 029e9536ec28f2..55f4e048d94743 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -636,9 +636,7 @@ int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
 	mlx5r_umr_set_update_xlt_data_seg(&wqe.data_seg, &sg);
 
 	cur_mtt = mtt;
-	rdma_for_each_block(mr->umem->sgt_append.sgt.sgl, &biter,
-			    mr->umem->sgt_append.sgt.nents,
-			    BIT(mr->page_shift)) {
+	rdma_umem_for_each_dma_block(mr->umem, &biter, BIT(mr->page_shift)) {
 		if (cur_mtt == (void *)mtt + sg.length) {
 			dma_sync_single_for_device(ddev, sg.addr, sg.length,
 						   DMA_TO_DEVICE);

base-commit: 627122280c878cf5d3cda2d2c5a0a8f6a7e35cb7
-- 
2.39.1

