Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F89A474EF9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 01:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbhLOARG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 19:17:06 -0500
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:12919
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238403AbhLOARF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 19:17:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1wvKqUeSycn39JcbvRSJKX+04f/+YB9FS3Ea1v+YnP2LiqFP8vBDU2z+yhv/o1z/1fEkR81rAdnlTKtU5XCdQcZ4DveoUT/uSjgQdSPDmdYzuM+77rsl/O99tRBhAJXAYKAEjy0crJ6TFJ6K4o9UHxL0En4JPRG9ZFwNsqptjwLCUdrOCvmcqi542+oL8zhVJlK1MpcyJdLY0L/aOdOD1L5Igtaup/ZDX/A1Ya61ZDZGdV+m8t8erz0AvHStGKYzU9aIYw3sKWQ7JDK6XaTW+8XtHt3xYCvOAtHqY+cv+wOMsNmmYViT+3IGR+4+y1K+wXIiotv/LrFQVGHrPV27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjARgKpGXVUS6LzLNApFToMPJ8kL4uvskTTMZM2wGhw=;
 b=bcrH2fd4IoYOrm67BIEbwFgAz1Ka+26mXxvLcU8wvDpednWaDOUk1W8D70m6zlADY+CWEZ/JM+s4Ovsj9Iu/bQYeORGe5M0CbN9vCQgcwVGxfdncrYys7WXs7iicHcBfikpyaybH2MHKhWtB49a1e1tn2mIn0RTVeIWm1Q8B9aIDHKDMr2M85DOKS/mKtRZit12KJ+xJZIuVsU/2EI32fT9ssc13wkTcUT6YLQ1hlW/7ly1jXSUYpGmWYr88YHwOMIrzh28+n/uVGbsqXRozs6WUQ4/krLl3Kr7oZygc0uft+Me63/9et5yh8fIigHsiMWg1OJK7QAxev88TiMnkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjARgKpGXVUS6LzLNApFToMPJ8kL4uvskTTMZM2wGhw=;
 b=QryXGPPn3K7hMd0FNVyXdF4MA3fCtxhjcmxJYIJMieOD/QBSBAOwG4ofkvnmMMq8vYJKQA41Bp7PR69OXVaB3WTul7UmMyD5WKrmQqWS23fkrhJsO4K87dv8EMAG8oaqpbpq6hyyaB1mNtX/DAt0bqb5U/dWsRrHpQGIU8J+muRL9Hetsv2NEy9steQZgUh9wHxngUyuEZ1thoThHzIWSjbcCz9dOtUkJxS8GSnckOD2p9EiU05O91C8w9Cw3xoOdDm/G64SwMKaasB2DPQ6Jw7HHZT7rmThkkfMq/FwPtB2K7I1BdtuhtUahiV6LC+JRyNSRIKg87Ba2rZ7yh15Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Wed, 15 Dec 2021 00:17:04 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d%4]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 00:17:04 +0000
Date:   Tue, 14 Dec 2021 20:17:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jiacheng Shi <billsjc@sjtu.edu.cn>
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Replace kfree with kvfree
Message-ID: <20211215001702.GA998963@nvidia.com>
References: <20211210094234.5829-1-billsjc@sjtu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210094234.5829-1-billsjc@sjtu.edu.cn>
X-ClientProxiedBy: SJ0PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::12) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cef21c0-8004-45dd-494e-08d9bf6038ce
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5391A339EDA07F85AA46A697C2769@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ymn1xBHBHnxi++9lomCFuMDZ0elLIDFQZngl3CiMRj7Z7iSE0ulORQYh4kJF0pTLkfDhH4KH3Tymrt3444xwuLYHtqqWRqZ4fhP8FEFSVgHQf1eN5A1YyERzQvQVe1oagEUt1oEk41gs4h7LymJIMaQiho9EuX4/NU+TOa/SydiOL/br3hxdMDIwmXj0Bt7BxFXxJJI/DLwfEIMo9Y7+sD06Ve7/pJQSsrl0MaAvHeUQwsxz2ixxGh7xD6y21Lt5nfoOwjSDumMDHrP7X1fMnoKHM0cFOfxtsCqv0LZg0eGZUBBqVWzoPeJO1aU5R0L59jUlultOW53PtoQQbg9z7hKnqezRvWTBSlUYrtd/DSsZUdfRpWesec5WPPbAv2qgoMOE1MVHW0i6MvvWiLI8MkAIFx+jlm67lqKaUUSZ3O+deFxOXwa6X5ZJWRm4X3BHZT3sJRdxO0FbkzaXaqwhCHpmdzWA/0xBD1q8N9NBRDo3CeJXqGjuvmWfPbrkDGNAQpjbPyrLgxU9DdtpBCroeAUCo4ZwZ+0U4s8YOh15XSYdrZvggLA8sVZXMMwoh42OOF06Vg3Q0Zu3DJZd9CFOk96KhjkmMSqJsgdM9B70KMlz0+oLmdEoiLHwlgJDoXNI+PL/1xK2nibmahArPBieyr6Fox9qZf3s8/PQLzu96pPWDKxxgw2Q1MW9mlIrG1EHf5Iur7KAeUR+JbPOGRpiaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(83380400001)(508600001)(26005)(36756003)(4326008)(2906002)(316002)(86362001)(4744005)(2616005)(1076003)(54906003)(6916009)(66476007)(8676002)(6512007)(5660300002)(6486002)(186003)(33656002)(66556008)(6506007)(38100700002)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J3W+NDqyrURniRcf+yu6x6RllCHWKJ8PWL9tW0AwjMqLuz7gh34jR7Zqymmm?=
 =?us-ascii?Q?Ft2ExBfvTmaigDRyzf0QpxFyux0IsfYFrHWGQxPsNPrXHssaRSEEsnJx8guu?=
 =?us-ascii?Q?9olZ+LDtwc7q1QMQIVcNnnPlSW/hEd89leqhKUxJZBpqINq17huXxXT9jfK/?=
 =?us-ascii?Q?AToiGEdjLeJ39MEWyMVBVIbYfuQECNsM+gb+qWr8D2FC2HjOuBum8Ln7TEqR?=
 =?us-ascii?Q?kacvSV8dw9/Rdkc0uvjDB2/6ZYIOQRpimU8N3EZtLsLko4LgOsM1b7T5I/I3?=
 =?us-ascii?Q?jr3DV3TMFMgsOUyIm9eFiUPXM3boiV43Tfzds/uMHAz5Yp2VRi4HtX6cBbjc?=
 =?us-ascii?Q?yhKU48c3YGTKkqt3h7Fm/UNMz+5EYt89JGMXLaOE4IOIleRVKr5V8XnVYF+3?=
 =?us-ascii?Q?+3rFRfaTIUpJNk9N7NH5UPmb5/Mu8io9Vw4oviDdugCwwW9fUa2m2Q3Vh6xF?=
 =?us-ascii?Q?jQOid6PiGrUEMCSwSQD6wcNR+Qg4+Nzd9ZNzebhDW5ZthyG1AIdEaAiDlPmo?=
 =?us-ascii?Q?/HkndOHpZ5TzB2o0GuRyI3zrcaZemVAPSNjEKz7eaVzBcouFs2Tn68LVljzm?=
 =?us-ascii?Q?PJzej6GH86gSCHxs1OJFTHTM99MQ1hdTbvImZ/N1sK3X2IvrvqHNNpQeaonv?=
 =?us-ascii?Q?Zymk/iGWF7v3+l21D1gh+VJhf7eLAfG8IKXhhg1+Azht7vobB9psPORt7K+n?=
 =?us-ascii?Q?CrHJyfw7YK28j1DLnpyYOUt3Z6ftaQJSolOmaRTPLSvgEqkwsrJV05xKhLn9?=
 =?us-ascii?Q?kp3bqsI1DPXwyJjGtSbMFdpOZriI3NKTscJ+krku9lJe1vKQXfaPuSiZ95zV?=
 =?us-ascii?Q?Pvwr28QudIXO6iLRwRvvLbSWkgJST/Zne23P6T3E/Fu14TEqUCkkh9FKmH8s?=
 =?us-ascii?Q?MIn1TR7nWi1Nw73eFA/cXnqHOPnl1YM+7rHbUB1JWD2HpuEaVz0MpG2GCMiY?=
 =?us-ascii?Q?tDz3krO/0pAnfNGw74/U5JQq0tUOGnzkN9HFs3LzMMuT/n/7TN114SXYfcWA?=
 =?us-ascii?Q?1pknTgefXAuVz1fHmBPJxZVYfiiUj/pyKC9M4mdgStmHm2ykwKW9Q+cCHSkv?=
 =?us-ascii?Q?9t6UPY5eUau7whpowHcD5mMiyH8XOg7yFvFC4d/atzGPhY67lWejry2EAsxk?=
 =?us-ascii?Q?fEE7BzhX9S8i4LIF0jgoYYwNWCOQ/ztPdierJ5Ov4S47i/OO3okajQrzyv6P?=
 =?us-ascii?Q?Ca4M+hMOu1saOmOUtHEUQmXsCPIQee94AQ8b4omGC6Jt8bO8JZ1wQ2R0AVaz?=
 =?us-ascii?Q?mn3ykNaFHwP1hHnmvuhbi7N8xth6Q/89AJrIjF92wEQ6bvDEQLJTaDCH1OND?=
 =?us-ascii?Q?+vQzztbepNhADieIEvZ8YqBb+hnglnuM4ZOA7yOuna0V7I+zDLe2q48i3Gnz?=
 =?us-ascii?Q?O+oESG53/pQSwKRQ0gANELLe0HwLiUeSFQulUrYiVLq4mBpuBYS8438RvQcZ?=
 =?us-ascii?Q?WZblO86BVKvhoyjXpyLIROwK4UyPxbX3jHzzl2AYbHA3qyBKIsnPPAZ5leXF?=
 =?us-ascii?Q?ldJUbCjeAlOVsww2s5q0LxtmMfAJ15Juhy7GZx4LlnJO7Ult4QH9pbjYNSYd?=
 =?us-ascii?Q?fSF/HiCtcoVk5CrM4Q4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cef21c0-8004-45dd-494e-08d9bf6038ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 00:17:04.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN+yWbJGPeSx3pl5I+arPhP/INLUUyr6EuO+qouBTZ0XT7xaQjEiPd4IQZn1lik7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 10, 2021 at 01:42:34AM -0800, Jiacheng Shi wrote:
> Variables allocated by kvmalloc_array should not be freed by kfree.
> Because they may be allocated by vmalloc.
> So we replace kfree with kvfree here.
> 
> Fixes: 6fd610c5733d ("RDMA/hns: Support 0 hop addressing for SRQ buffer")
> Signed-off-by: Jiacheng Shi <billsjc@sjtu.edu.cn>
> Acked-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_srq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
