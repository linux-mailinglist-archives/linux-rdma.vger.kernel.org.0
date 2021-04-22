Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC20367F8F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhDVL2l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 07:28:41 -0400
Received: from mail-mw2nam08on2044.outbound.protection.outlook.com ([40.107.101.44]:2337
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235957AbhDVL2k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 07:28:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrHyLK/SLHKQC4U9w9smDV80zT2WYEGwkczfEZNHBp32jWrn78Za+dc6ycFF4JHXuIHqCWTLN6IkDxI64x+HRHS3yH0hfjwFWuXGgg3U5PtSOFYyaV+QLAwJJxySuzOFrVq9t2vWl7a6ZuxkmuemjWcB0DcmkP11wBHNRxsGHrbWKwzlUNkUT4GaTwzzG4P3h2wwMwj25eLX4bIQvU91jiNJxCdc7B/Fmwj5rCN0FcDlNSBvAwLebG+tw3v+lgCaucJQkId1y0oTiOum/trfxmRp7gE4wqlkct7XSOo08LtNU6/p1hx0bqsp2/P08QfUg+UZB6lQsTBwDd17JVGolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGKyf5L5iP4/o+uBqPpVujZGcAt8qAHiCyZhl0Q7/pE=;
 b=g2MHw6U6TOXtXeCFlRL1DjUPW3EZRuH201sRKH6psmCT8/spJt0GPQ1buS8CeB8kvQdKL5c0OjJcAv4UhucgHsTTfj0xaS13qlfWCQtqhGlauLHAWdn6zaRoFBpee7YkLYUM6UOmh+ROA4jA5oFMhLo6FmXZ+F55Zk1zXSTTVvjTRq7S38zbxPYWfa1gLbppBSPCRzM1Rt2y8ClreOZCYBMoe11gPntCXv+D4/awpW19yMT9aJR+yb5mH/FO8HUy/cB/MiSGKn1AvFF4pk7rWTw9s4t9pT+PRlBnA1HVOM+MyJX988LMHRcYsnOHUh3e4yCWPb6yq0d1jEKgBYPoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGKyf5L5iP4/o+uBqPpVujZGcAt8qAHiCyZhl0Q7/pE=;
 b=g6guYue6cvQLKJncBIzCNxOKHM+vhAO5oe6afu4DDqiTqTGQ16SBmsqBKRhB/zo/NpKhiwdDXOFE2oSNvt27BRpNYeBqH6qzMaxRfvsd+lH68ez08XL765RE1DxXRnF8gYHUTAr2j2dijXIVTztA5m6KsyF+Wp0TFDVFzOVovLhbBftoQ7TQhhXLMT+bkSDuLeE9Zf7nX+VLZ9bXfmLSslDhHHvE3nrzzAKMH0qBi0xQchPprrnuuLHBkoVG5bdm2B0erfbklRucdZbnYpNU7PE6WZghhLvZpydJwrUn3ot/qiNJa7FG6Lt863MBzcIVQL1DI+qyJ8l6iRvRT9Up8Q==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 11:28:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 11:28:04 +0000
Date:   Thu, 22 Apr 2021 08:28:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        Krishna Kumar <krkumar2@in.ibm.com>,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/core: Fix check of device in
 rdma_listen()
Message-ID: <20210422112802.GA2320845@nvidia.com>
References: <cover.1618753862.git.leonro@nvidia.com>
 <b925e11d639726afbaaeea5aeaa58572b3aacf8e.1618753862.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b925e11d639726afbaaeea5aeaa58572b3aacf8e.1618753862.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0283.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0283.namprd13.prod.outlook.com (2603:10b6:208:2bc::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Thu, 22 Apr 2021 11:28:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZXV4-009wGt-Mv; Thu, 22 Apr 2021 08:28:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1250fac8-9c0a-476e-1044-08d90581b1c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB293796B3515667742DB3705BC2469@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7cQ2hmGuJ9KLgMV0TA8tkGSujCoGF7vbfRwgEdKbYMHsav3xZJLDQJffX2ydLBUJJC915FzwvQ6g9HKEpMx5qPD85n9aoQbQu8Hs6L9LItZGtcbpemeBr0iK/bcDvG9KisQniCwpS1SumSWzJeLwXMjHPOmPaxBR8Hhh9mZXmbVUuJfg5EZcyL4ovOCoZwq9NCWokN6lujTdbKTYSe539hpZ03K/rND83pQfglTmSyO3yI2v3ECBVD9Y+XvrdXqQu71eZohupmUKPmlSjLOuleZoRDxbA3pZgqvdaJBHwS5xccyXVxzHwRr/9X7l/pgEw/o9PBbB/REAeug79Rjz/vE2CzMo1MpidNNoS6oOI0RQ0T+dVHGT7pYiKqAlc7KPOqzobcrCWoQpX3qhPgENXAkjZ3x4lkSSvjsLA+w/1jPrr4/6EzgThdUclGU2Flb/FpVOhJnzsz1D7n4BQoWGwwntjjT6/tsIoPwzZ5pYWiE02Mi3KrGt2GTuT0lONXP23KUyTFSCkV0evp3yR6wfD7TeROVpiOBPMOEr2fPIbLUD0AA8n6bAMlEQdmkWjpoKPKDfBBcw9CNE72GnSYjK2Iy/gs4R7lMw0rFmDouI/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(54906003)(66946007)(66556008)(478600001)(8676002)(38100700002)(8936002)(2616005)(66476007)(9786002)(1076003)(33656002)(9746002)(36756003)(83380400001)(426003)(4326008)(2906002)(26005)(86362001)(186003)(6916009)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tqo2wOm/MLBg6rONtezm0ysbdyDwNzGYZaKsjHDsP0yfs5UVtXk8sdWHCFlz?=
 =?us-ascii?Q?ir+JGnPv/ufj9KbuhBUy/iC4sSB0ZdBlllkZ4DZ7nJB2BCSud3rbJZG0tDBO?=
 =?us-ascii?Q?5X5t5cJdtcFi5eMZ9G7vwjvatWCQsXJxoqcQCeFQb7EBI7C0zFQpmZcnlyeM?=
 =?us-ascii?Q?06k1uYEJu+/o0RsF22KCXZKcJtSUV8FD2RphnJ8HT5tRTB21w/xBp9JjULTy?=
 =?us-ascii?Q?IvIiaDlmfW9GPWkox3rqawpNgW8YF6ZXOZgOv0qyOWM7/91efXCsXEwg+xET?=
 =?us-ascii?Q?L9sSDhrSILc43yOlVCRiAVnjJFlo+I8jfQcbBj/nTzoVKAjClwQGBefU/VMk?=
 =?us-ascii?Q?RBcAwIxXY3LF8BAg4WqTOIG3g3jf/UsnxF9XNAuyF+xWjsHX4JsHVTVpgIer?=
 =?us-ascii?Q?BC4wQmo1f5UHus8F45y/iNJr9vMvQsai859U/1zFwcUozaGYnxs2G1LCWroH?=
 =?us-ascii?Q?MC0q3RWoYDZbYJX7H4lCiZ4V+HjYhjcSaZEGEKMnmtJkMkT1dFX14h4Zadxg?=
 =?us-ascii?Q?wU/cFCusevPDjlN5F7HuKZQu0FOrzPObtP65mVNAyUOkgrkwAYuglU1Jrzty?=
 =?us-ascii?Q?Q6GXaCdZpdUwUV27zcEM6wERf2Vs2+DjvR5AWdsqzcvPByNMkW74QnP+0LpS?=
 =?us-ascii?Q?kk31SykP8i8n5kBoIRDd2KeNLuM/r3eD1f7g5r/iCnKSF6njzHagKiTGKL4L?=
 =?us-ascii?Q?sEYkQ0U4MJ/mrHRGMFESgEzivT0HSjV/7c3C7CpMXnTSh5wAYUsmhWNeuyXm?=
 =?us-ascii?Q?dH+gvjxOSHWeEXD5tM8eMjwL4/q1V6MnIHuomMq7lAJplq1mu9iZAqXiWJ1n?=
 =?us-ascii?Q?wHV4x0KSdgVsVdKCMckX+oS22YcNxSd3ZN57Pq8D36GIPS/T8t4bm9wp40+r?=
 =?us-ascii?Q?7q1mVwMwGO1Ej8Wyiw6jQtoGHPHVjLgeV60rO6fioW1LSFqRoWOtMNzmAS1B?=
 =?us-ascii?Q?lE0POJfiqwF52L43gzWbkRoZK9WY41dpEES65wp7c52qzziTDoFn9k1IJTpx?=
 =?us-ascii?Q?EnJBR1m1z0yAlQoOncBIGAGgsOIo5mDyIHHIJn8oP7RsV99N8GIFL9cH0oJZ?=
 =?us-ascii?Q?a7MjT2esdmLs+Jr3CDLf6KKCQszDg1ymvqcpIrx1SZsIobh3RDk0c0vl+32n?=
 =?us-ascii?Q?VEEvUj9xmMUH9Xhq/ND4lBf/pPq57p2P3yRz6W2Z6d8CSfJRNAz5kQ4lzMAF?=
 =?us-ascii?Q?vz5twQc+KQ90UyTvyVBn943Xyc4b9POWFv2Qxfip/v2e7H9E+d+xyncO5d6N?=
 =?us-ascii?Q?f1dqgvVhxDKBapzkQVvNG1nsEySwXpgmTJylkWlPD22/LQGk9i7jT6gahVjz?=
 =?us-ascii?Q?0plIbcnq2iji1zzUe1zy8xtP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1250fac8-9c0a-476e-1044-08d90581b1c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 11:28:04.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7Rua+xw7dVhMonBAPOVeRqQLoudit4CkRIIcbtT5zD0l0Jhss/j2LpCrnfyWhy5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 18, 2021 at 04:55:53PM +0300, Leon Romanovsky wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> rdma_listen() checks if device already attached to rdma_id_priv,
> based on the response the its decide to what to listen, however
> this is different when the listeners are canceled.
> 
> This leads to a mismatch between rdma_listen() and cma_cancel_operation(),
> and causes to bellow wild-memory-access. Fix it by aligning rdma_listen()
> according to the cma_cancel_operation().

So this is happening because the error unwind in rdma_bind_addr() is
taking the exit path and calling cma_release_dev()?

This allows rdma_listen() to be called with a bogus device pointer
which precipitates this UAF during destroy.

However, I think rdma_bind_addr() should not allow the bogus device
pointer to leak out at all, since the ULP could see it. It really is
invalid to have it present no matter what.

This would make cma_release_dev() and _cma_attach_to_dev()
symmetrical - what do you think?

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2dc302a83014ae..91f6d968b46f65 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -474,6 +474,7 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
 	list_del(&id_priv->list);
 	cma_dev_put(id_priv->cma_dev);
 	id_priv->cma_dev = NULL;
+	id_priv->id.device = NULL;
 	if (id_priv->id.route.addr.dev_addr.sgid_attr) {
 		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
 		id_priv->id.route.addr.dev_addr.sgid_attr = NULL;
