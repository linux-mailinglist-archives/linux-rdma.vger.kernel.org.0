Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EA5637F4F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 19:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKXSua (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 13:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXSu3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 13:50:29 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EB6334
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 10:50:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcNMs6rm331iJv+czQHl7RewmSB3AAIHrbQ6AcIJU0BT4IuedMkxb8KWjhxEpXJtwJrzziGkvNEN7b00Sq+UGGv9X2QEP7AAXBjVd+oNX5oObDWBkPVT0JCJi0tBDx1pJ4VBHYrTJvpAAr2oP904eZq9A5UTCJU1IBxXMw8kNrR5PAbt2TNblNEMQW3hbJGFy3l2lByssFLrC8LzL4HNbcGghXvp19xU9fCi7/TCCPZm7b8AjJMa3biy9D5xWRmIgoPnQfAppAtOHdmGnEVcE4hyJrL985cSHOwN2Tr2jIE8hU18GIvcWstVOHAkmbYjxczrVwA1gBHweTd32J5hxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8PzW3mjt0Muav9d/Ub7IlL+A/jcRxMFi3Rw30YCoLo=;
 b=G0aVTAtn6VhjeKtnh+JTJDN2dD6xj44zjFMeqBUwRVT9nJL7mB1iWA1n0QciXa0O1dRGDJosyM9Fnc8MLbwz9pKijmlia7AMkQ5G2XzG3R2WkKLCF/0jrPrdSDEjFsRjc1/pHmm5tcENZGXRwIQvb7iG1Gisyiaypf2axoSJ8pQJH9Ydn8afByIzTdX15vpT7kJdHksqUViv+/X7XSislAtfO0ohaULJfZUKxnFIl6A9YsFqi8vH1l6Q38YcmJY/FgM+G1lMkJpCZgf3+keurXplSnVQC20es/oj7N02KKCtMC1Ojw98stQTweYext/YX+71XmkvjCax+T0adxeYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8PzW3mjt0Muav9d/Ub7IlL+A/jcRxMFi3Rw30YCoLo=;
 b=o/AAkNg4RSYRtemZghNX+vt1wMpn8y6JJq5zTZswYIB513H9ppyEdvx+dGWYzuhWO/EfJAoHArd3tmtDwR/i6K2tgmOK+zu0ZLxhAwpeZuY/FrF9z09Dk4wqXVkXXx9wF3NunLZwhextX/oZ7TPe8D/voQoNwjlT+QKkDHE/mz4q9TeorvYBWBdfuFARdniVZmTHW6ESQrVHPIpEp6lE4/ef5Or3ou/yJmVqULePXBxjGFgYTFSUk6ijXv5zIrVLpQdNgoKr46ymJWxR6JDpukSwQIDjoLv3mq1AK0BF9yw1eRRxfuxOn41TfLlwMnTmxCJHlhqvk03NTVtv6iAecw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 24 Nov
 2022 18:50:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 18:50:26 +0000
Date:   Thu, 24 Nov 2022 14:50:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
Subject: Re: [PATCH v2 for-rc] RDMA/erdma: Fix a typo in annotation
Message-ID: <Y3+88bFYxR98geX4@nvidia.com>
References: <20221124114933.77250-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124114933.77250-1-chengyou@linux.alibaba.com>
X-ClientProxiedBy: MN2PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:208:23b::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: bd03f068-f74d-4378-d156-08dace4cc052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T91+LG7cqzgEyGx1dGeDWBaOaHt+OmmBKZ19glnT+eKdmJETNShq5QZBEbnCqFR16impAO2sqx0ogJ+4A4EeZPaBpaRyPIDwlouGGUxkSOBQoouarK+0jvDTLle/9wvu9IMBGVtwBtrbKqrpDKgjXHterrQPSkkhDkPWtU3QewXgHa0xHRuxMnt6RTqsSZn3Lkf3kpWKKS204bMPHNmMyE8wEhwx0NNDk7OR3z1AMto2TuriEw/spsuQAV6hSJo/64J4kZxASgl+O4gl/pVhChcLcThrG+cHSNj7uI0Fq7/Kffe504oWLvgjN6V87SFn97RkuJwo83x0xMhAdxV2m8l8d69FgVz74mZLVp6QD1iW9fbHFTkWeMV8pnCeuTDWU4x20xMI23rP6uiF7lK5YBt6OZCa20qdBE8JXASUSUjxZsg6EOgIqPvugd8XLvd9tupJV4tRb2X0yDLQUm/nFfUKIlKAFcopT1arO9U4vg3tTZdRMedYvYRTJYN8PVoHnmTzKx5/4G4kV4A5TuftJ/P9pKWjpAMfN1e+y5c8+PL4iku2uiDtMjBFYUIi9AZHEDg9hGweHZZMbUSc8KnvMPePVAF/S2QlmyQ/NnFNZNd5FZxqrlVZVlf74Sab46a3zE8mlv79mV+8ZnCqiwvFeW8UT5+o9ayCHlriNDONd01P63dp5xOSCZ9XgIdzW1JQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(2616005)(186003)(316002)(6916009)(26005)(6506007)(6512007)(66476007)(66556008)(83380400001)(5660300002)(4326008)(8676002)(66946007)(38100700002)(8936002)(4744005)(86362001)(36756003)(2906002)(478600001)(6486002)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c5txsEe3/ATLSTQNapH9TnUaM8cmHo7h+dDTOAmBBkWhXFuTIoOSfwgwosRd?=
 =?us-ascii?Q?W5xZFd/3gufYLvGpAdpqMxHBpk3HQ4/iv39pb6VH45elhCEiGc/Dw1jdMI65?=
 =?us-ascii?Q?vzMHSyOGNlTxNioBiAflEkl96/yZ4rCnDAvUsSTN9sWIeLeVTpMVfUn0z5Cv?=
 =?us-ascii?Q?xvaRNU8aSZwHSyZmaPBRWwe3pzF6nZeO2NvTrQ1l+imTNbPQLxyMMUvpFvk4?=
 =?us-ascii?Q?safE3NDQrbxNb1Uv92kvRw7+9JZMk2Pbg6QcSZ1tAi5a+eTvRXZPNk2w+ssv?=
 =?us-ascii?Q?6eXVAQBu/Ve5sK5fv8zTCFhOLFlHwTkRx7cZafMIo3dsWoAk4TQSEglm/VLG?=
 =?us-ascii?Q?2AkFFHmISipMVUGpYHEhXTnX+x2V8p+qFWj1kGKxgUmUwmPsl9WmllkaKiTg?=
 =?us-ascii?Q?1MWvDF/Ma5NmSO9krdRaokz0mSHCaDu1BqHuaf75ZVQHTe8KYhewBhH1JPpg?=
 =?us-ascii?Q?81Dyr/JTyGNIZhi4e2RjtTQrth8AoSdZZuSSkJO50uYSibCRLSBps91ZTbUO?=
 =?us-ascii?Q?o2kPLVu+AYWSoNLKpXrx1PyGQt0Rg5sfHkdc8AtR3yzerpsf5u8qE3tmSaGk?=
 =?us-ascii?Q?Okrm+HbKV1AEtwWuVdsBemJiw03TAmUe/pIqsJcIAYEDAHa/y4BQnnHXniZu?=
 =?us-ascii?Q?yIDj20zj9xvSFudiX/5CQHs5t1+5Dehr50kYi4Wnvlwft+t3c32k0fo+epHg?=
 =?us-ascii?Q?V9Q8fbDX0d1DWpwAog5Dsa/W0d4aC418FHRx9n1l8Fz+VFxGFydSU6OsC4Y8?=
 =?us-ascii?Q?ojBFW6AdAI9sMHgTFLr2Rk1qFV5OWVywnyynRb82Xwhp7T05semKQSvNqBbj?=
 =?us-ascii?Q?EuaCBmoU54zKqfY/1GD8qkN3eDhWaEJQC5Quot3UQgHWMbBpqt3K1A98spjx?=
 =?us-ascii?Q?7apbP/6+dGFDqGVzp/d9IU8/x9tTAveuU2DJQz3oFglDxJ72vwUlm+Kbq+I3?=
 =?us-ascii?Q?+dfaqxuxYKfZkUn7+Gb72ngOT65TsvVLMXCTZoaRlqkEPDeyIEDBhN8HJz/U?=
 =?us-ascii?Q?dbUA4J8lqwzkESS/8w4XaXVgZjP44pOZ1tZ852QY5dt40DlU191+BgTlWhIi?=
 =?us-ascii?Q?MtWH19RV1kou7iKpBdJ3SlcUg6zwCjkIsyT95cVAOiArCOJtUlBb33SDhM4+?=
 =?us-ascii?Q?L223oIKtpv63shJvdeRACcWZSykwxTMXZEXa/M/vZf9wUPG585opsErYWfbx?=
 =?us-ascii?Q?TPitEMWpbxqTCLFjrOZz3a0thErmScPJtE0PWPPpdq6ZgYh4iTlkRl0BU6Yt?=
 =?us-ascii?Q?Bzk//oDZjpBTr8pQYyVw2N1+DLsdlqU25w/Z2TnBLyYk+jxLaRPH+d8F6AfJ?=
 =?us-ascii?Q?qex/We7RLIYHlNDDYbgL7F3c/RJKy61Ms6UEHfQBNjkLH1fbU8/CxLkY/P+K?=
 =?us-ascii?Q?dDCvwnvpLg8nwC0mNaSjq++pmQDmHiqmZO6M+rcHNIDIwN4CUWvYvMjuL7JO?=
 =?us-ascii?Q?MBBjIExxMNBHor3tAcjfyY5HFdKFfHiOD4MnWZzECEfq8I3ISutNGF7DqZmL?=
 =?us-ascii?Q?G2jplUc3GiW5kKg4kUcCJiRoSA4v0jRobxgOxUQPhAkAOJPGo+vlGpfsj7v5?=
 =?us-ascii?Q?1VurS7mHUQFlAg3T81w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd03f068-f74d-4378-d156-08dace4cc052
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 18:50:26.8491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6E62toFdpUBm+eW6yDROuh62ip0+/7nMowIiOVEcgZxy1SFJ+2dLHQ2sSL9yUIDK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 24, 2022 at 07:49:33PM +0800, Cheng Xu wrote:
> A non-ASCII character was wrongly put in annotation, which should be
> removed.
> 
> Fixes: bee85e0e31ec ("RDMA/erdma: Add main include file")
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
