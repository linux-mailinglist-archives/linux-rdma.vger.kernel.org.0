Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB64C713F
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 17:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiB1QFn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 11:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiB1QFm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 11:05:42 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2DF41993
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 08:05:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZxmfjmXnGDYoNhmZubdN7V0FpYqjULAtyimGjJ2lhGocjvf0rnLo8td7TczgFjlDI+L74k8bEFsUt1bLmB5kbZ/IGU4VCINMq6D9/g3T8AxTpBQslbbnH62pNN04ctw2+0XQN1h5uEkW9IKWzR24WLyy6qRgfY/tPkc1E02ugMbBMXDOU/ryLwrn6srZil6oUK+2DHy/zL0T1qkTeskVQwgFuLYTuLPdIM4xLIBudZdCbud+FPMTBUz7lXdsEIcfnkmowMxqYib1OHBbNJE+YsgqKM0smoLVywxXB99CLoi9teLCDdcIcgoCPD2PvFLDboUDGQlPenN2/x+NVp2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9J4CjBEPBd81fqxWbBbhAZwGcCvJQhTdR3xTgDu980=;
 b=VIgT1BzTliylH4BjwK+MHQetJ1I2orC5RrQQTDXQry0RtW7V8BBDJddbvEHs05qWYx16GLYCpfqio2lKKNGtLxwIBcqwIHG+mYSnCVVKWmJPgFCYbwXPnL3fl2q0hW1WokZyLatDoeLxKiHFqvS+h6ntQXcXya9z2Qv7nfrEeu87vbIA0I9JKQVqdGaA55EaL0GMNrY7MuXB12Agv0k6zlJw8WK8Mulcls7oyTEH9EUzMe9UjECJy+Ng4FfGhCXcGcYnMSHS6lc0WHlYp6XtgPg2F/t1Oi8MBj9hSFVE8cUVqcIDSXnS1t4iR5SvUYRbz5H86f24uyVHxMbUNCDpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9J4CjBEPBd81fqxWbBbhAZwGcCvJQhTdR3xTgDu980=;
 b=BIM9XkKI1k80H6sotWJU43KHN28TpWZ9l5eBhLkXxB+PC/SKyksZqCjgis0EEthy4WBqwEvDfWfmwTj5uwsjgLEsg9Q66RihBBsGiaJNHYxNLzaGYBOcdhv1ON52FoSxHy+cSysklc6wsq7mHPcXM8RDz9OAxrWrLowRCTGIWdp6c7lGDSmMTUKQLjlhvyqhLlHR/i9Xyf/rXxe3KYxHmcP/fLLVQAVKGA8FiIDSKdRLjxvYd+lNRy+WsbNJ0BAe/7SqGb0eTi4MA57B9yrY5bnqd+mjoP5yBNbx5pzspufEd6yNbqJ3UvCItHBaHrIwoMUqjxf7K+Og+sLlvWpSQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB3841.namprd12.prod.outlook.com (2603:10b6:a03:194::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 16:05:00 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 16:05:00 +0000
Date:   Mon, 28 Feb 2022 12:04:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 7/9] RDMA/hns: Clean up the return value
 check of hns_roce_alloc_cmd_mailbox()
Message-ID: <20220228160458.GA595987@nvidia.com>
References: <20220225112559.43300-1-liangwenpeng@huawei.com>
 <20220225112559.43300-8-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225112559.43300-8-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL1PR13CA0412.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0197d5-6b58-4fbf-df8e-08d9fad4125e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3841:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38415C2DD8F9C1FB3EE0A7A5C2019@BY5PR12MB3841.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCJ4hqMCV5XrXCEXvdozP5dMyw9b7qYbkbjdMR9otHcKKsiQeEHjyW1gVEStg2XNSIyCXEA3fEWEyC9eCPGCxU5c6YS/DxoOsR22PKJuo5Y7YS0Pwj2DDAKDXzzWLPTT+4sWdmu5+hRzEELok3gvDQYeO6Kfq8/gSfGIzOQCvjE1knVBWvezpycLDcX3S3rSbm8vN0prufKJ1eQOD/xD1jv2tOO6D5zDWg7RDhcLIwwRVWJOaVHPT5DadhEE6Xwu23o/al022sMcslEL7GhpfCCkMfM0dqpzYHGKOOWFsLG1s/iBm5TWIxOApy82N7EYfxp+yESF+5V7oNADR5Shc4ptrZTWmIXKqAf/yAoRo3KnVRomZDPucnRthdEySFdz9y4Vg/kgMow8k814DxC6PPwhW0suTUGp5Se7VFlUeh82ZOmhVw5lu6otuwtl3M/jp+g2oT+6Nj/1OH1aFtCBfH4oR58Sid6uombrLTT397eGuJd3dc2Rn1uYuD4fU2yQXuHEYzAmckS5waLltgzmMfXBDKgrQ3q2NztIIOu+YGYmoxPjdB8DJDI2X6GCFaO4JM4N5GGJSA0We8wN+wi7nqsavsH1FFFSq2osygFmg5fbdYIRVSIAtjFGhPUQ4B+lS6ZnoBXnetvAxp/RJaPeoSkURcf5ZFi2EqhV9IQVMhje/vYwBZY1pkqtIiiBIcnS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(6512007)(316002)(6916009)(6506007)(38100700002)(66476007)(66556008)(66946007)(86362001)(83380400001)(2906002)(8676002)(26005)(186003)(4326008)(2616005)(1076003)(8936002)(4744005)(33656002)(5660300002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pJqyt6tR2NE3LyAfWexmvOB5gy3qCGjuA9Nz7LIT1lP2qU3+SVUx8+d3rupt?=
 =?us-ascii?Q?/fdcb/KiHStK0t71Z712ldY2bZD+2T4Cwn60sZtS+3YOIKoqdEAeMqlL1NmY?=
 =?us-ascii?Q?vqCKPjNJqZHqgy+itb9h7PthCtS6ZzT5uS4Dsdg5x2eU0Vym+C1NSJ8q00dz?=
 =?us-ascii?Q?GbYnnnbPUowNtChFQmWhw0GlaZ+JLqxTRFDpEkNvJD1khLSRtOBjbS1Pqh0l?=
 =?us-ascii?Q?uXC2NG/1OXzR+GjK6PBVgWpHwU7y3WVL85eefa23Xa1/yMBwlPIghGMAnjvT?=
 =?us-ascii?Q?O7pUR6DjudCGzQmzml9+25Iz5TzRc+/EQuH78x0KLPVivjqFV/1Al9xZ7aYw?=
 =?us-ascii?Q?i3E+wqvhcOQdFaEjLLDldqDOvdk0RNWgf0UDQHCKSd3rE7eGfBPHZsusd5LV?=
 =?us-ascii?Q?fLYZYUZyUaNl1yiDJRmesxtPi8+iGH4UiobDw4gHPo38FPqV46laOwJdunHM?=
 =?us-ascii?Q?L1N123osBIuz44JtGeaccGcgDii75OxIEj53ihMrYxoT+HmTPp/uIzhcd80u?=
 =?us-ascii?Q?DhwsZa/cvyQl5nPUPGXpqfAWmtfk04If8rLyh+lSyAJTjsoPA0nwb69W7y9/?=
 =?us-ascii?Q?xADTv+dKDRtY3VnpetdWdgv7DF1UVpqaBStVyDhauAnj7ttQMI5qZ8CR5644?=
 =?us-ascii?Q?Gzgx3kt4uVsWff8ZBZiq0uxxQWEOLuNbz6WF729h6qVx+Z/h1MgxUqBTbcmr?=
 =?us-ascii?Q?vY9gZl47cgg0xbjz3tqcnjyUo7+CQvUnbVnJLSPLK3rtMfCjjlifw2Vvh3mi?=
 =?us-ascii?Q?87CuJ7HX2GDrNX6SBJbTh4vgAe7B4OhWcGPRuaYB5e0cgaORsGQ/HXqKlDv+?=
 =?us-ascii?Q?P1kVwUjNUmARqf7SAwbPxj564rko6gopIIKV4tBAT9TVuyp5f8VJEiou4Q3c?=
 =?us-ascii?Q?Oun6Lx6wS/5MtQs7REkS5ZgxykaEpCT4N24th5VpR7gNgYFlI0lNXWCG8+OK?=
 =?us-ascii?Q?eCTQ5iiUhvwtJ+PgHsUaKXH1SLPyU3q59pR2FeCr2iJigw+bSKuyndn6UFSL?=
 =?us-ascii?Q?MFXUQnleJfszte+5750ySwF88FLJpM801mOParyQGCbFmdEDvPXV/uOkMGfw?=
 =?us-ascii?Q?cTYg4IU6fvCLLE6KXmHbg6ayAnxLG0vg8nQvbhr1yCOCWxQiVgh1bybEUP8G?=
 =?us-ascii?Q?3HCwyHI259O8bYyU4TfRMw6vKx4duBvOJLnxlvF25FBBcfGuGPqiPjORTtXG?=
 =?us-ascii?Q?Esj1cUKYwfNTN76lBAP3TuaVn58+ajpZHwe7qPCjPcZkZjhDy4a8s7ckStQS?=
 =?us-ascii?Q?FiM+u+++rKQlEppXOL95S7VCmQ7n+HYGM0s+FMLlvWN0zsEd4afvUhbqZiHW?=
 =?us-ascii?Q?dLHQHMYWU/abs0aen/z7+L5QxnUZhp0tJRbRZsqKGUiLo50l+YQ6PcpKEIHQ?=
 =?us-ascii?Q?Ge1uXDc4VC1QKKSagddWsK3cC4yu9iETLHyTKe0mZWpXJAxJ812AutHOF97F?=
 =?us-ascii?Q?rosP5igYoM7bCp4opNodZOvB+0fWDn/nhvnmmuOIXn5A9+wASnlLSjd+tLZi?=
 =?us-ascii?Q?3nRtbqdqkj4Gk10zKEyzWdQrMTHEycxGYf3FINDO6JkHpMlg0d/1kxOrqkPa?=
 =?us-ascii?Q?qq1H1bCJ2hEW5MOt6lE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0197d5-6b58-4fbf-df8e-08d9fad4125e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:04:59.9416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ki6u4k5pruxfUEE07y0k7ktdvvDvoV4ZE19vlFOqQ1vZeFdIjlnXafD6YyaAH/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3841
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 07:25:57PM +0800, Wenpeng Liang wrote:
> @@ -282,7 +280,7 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
>  
>  	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
>  	if (IS_ERR(mailbox))
> -		return ERR_CAST(mailbox);
> +		return ERR_PTR(mailbox);

This doesn't compile, it should stay as ERR_CAST, right?

Jason
