Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB593742046
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 08:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjF2GXW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 02:23:22 -0400
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:47328
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230222AbjF2GXU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jun 2023 02:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy/HJk9hrF8azrV6QYYjefJd8H+t50M/DnphFADaBTAlX5EMpxRE8csb2f9xNTFIXPxhSQL7kJh3oDwO+XZB8wGhaF3QYDCJ51z/C9cRtZdtDogUyoxGdgaggILfild0UWcYdkmEncaYijBJmxZ7oXfnoO1X5p8Ip3OCgPH141Z+wYGsEPr1xm+ztTkL2++vygOjYPSV+1zasOeWsEHgTzBmQ4m9UDf6cx9+85cORpERS5lOJG3qOFf/VhiuyhZQCbT80hJGffEGdUmln05ZGJEkHi9fdecW0R0MDjQNkojcW+x3TfXzIT6yWKzREbZ/yF2kaMsujqDivP5aajGb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+cR5xwiy6BRpsN3dSqtv/jxUl0SE2Rp+5BFz2MUzKI=;
 b=GplMnRn/K0E1emJRht8zdskNsA8Rng2cyoCAD1Ti+TnZEg0gwe07Ti4DZodZOf2i2xtD3mrOJuEGNNrdaG94//y00t57wuFRE33+YPRF7NHPiNPpexh7IBQz/DvjH++BESvKtReMajerXnmtPTpJSBqRYuml76KB/DOOxx421Rntjd1oDvAOMETLAAHE2qBvuWg20Weq5atJL9QJQHQnm0KP4u3bNPyXdRNjPdSPB4Ub/CeOdWkSG4kpzcas5UDA19Fb8kIG4xfe6ckuRrc0c5n0iZ/XavCSHyLBGf+qLJmJo3RETRAc5vOc8LWzUFMWituZHlwEoTsr3kzoMF6hPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+cR5xwiy6BRpsN3dSqtv/jxUl0SE2Rp+5BFz2MUzKI=;
 b=duwFATYIdttL2EfMP4L4OquD4XXAeyMxON7X++JCyRqOls/sYCAnrh3eWrH4HKUJSzZt4iIzU0bWjul67v9jGF2GkDQsYttun3NFE91Jqo8C9RPVDjtrZUbR8hfLyZyP4Cpt9EFasMlC+gIfszEbI4ZKXFoXF8N0OqjTPa4iq5PC+zukjuKJ6qs9DizpwGIJLDtaBX3oK6OwMAlxrzbwltebzkDeeiRzPjLwR+6IWiJ/sMhJee9iI9zEFH9edre823P8YGFky5aUcMMvaGl5E0e+30h0J21qX0Zf+du//Zm8tvNAsKISZsFvZlU5zVqXir5ViftqhyPkatomyyh8Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 06:23:18 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 06:23:18 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>,
        <saeedm@nvidia.com>, <leon@kernel.org>, <lkayal@nvidia.com>,
        <tariqt@nvidia.com>, <gal@nvidia.com>, <vadfed@meta.com>,
        <ayal@nvidia.com>, <eranbe@nvidia.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>
Subject: Re: [PATCH net 2/2] net/mlx5e: fix memory leak in mlx5e_ptp_open
References: <20230629024642.2228767-1-shaozhengchao@huawei.com>
        <20230629024642.2228767-3-shaozhengchao@huawei.com>
Date:   Wed, 28 Jun 2023 23:23:10 -0700
In-Reply-To: <20230629024642.2228767-3-shaozhengchao@huawei.com> (Zhengchao
        Shao's message of "Thu, 29 Jun 2023 10:46:42 +0800")
Message-ID: <87ttuqn5wx.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: f8cf96f0-ceed-48aa-f8d1-08db786953e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGLekugtrYVElTHbISGFSKiUrCTaythio56d/7jObh0/R36U2CZl1RSdLHYAYP5jGYG7b+w4y55vt7qAkOyaIZWo5i5g4FuOAYF0Gdg6VB2W6RBPUoFI5XD7R2iGnAd0wDeSg8lD4lrgDBu2EmmNg1c+C/11SD7QRZ1XBb6/Qb4qGrb1A61fAVytX/cEYwjU88sc2Vz3btxiY4QCV3axB6NQyRk/r/KOTkz9lR3XAgsBve7Xr6tqHFkYFPZyAM+ZC9trXiIAmL09CUCzmkITEOB6K0KuptNYtKhEQ68NGD/rPD5/5lS/zAXWFGWrMw0ViDPUss+dhIUyoO1Dh0S/Tb5uSfAOryYWXWTsOFeg+abJppzxz23JTq55DVvrBARop/JjAQns95bS1BUJpUSQqtIDrBhGGLCPHgL8obad5KhWa6cE2C0+pEnvFvaaDogaBqgewWl4zC6wincg3hvrmJN3pblOJMiwMSno/kfaHgu/anj/SaKc7Wq9bRzHxQmLAkxQZYLoFGVenkr9JCUv6Ogiu1IN2bEf1yF3oMyfnQ/TEHzu9J+SLEECf8gIldUw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(186003)(26005)(6916009)(4744005)(2906002)(2616005)(38100700002)(6506007)(6512007)(5660300002)(66476007)(8936002)(66946007)(66556008)(41300700001)(7416002)(36756003)(6666004)(8676002)(54906003)(316002)(86362001)(4326008)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DUewYybvfA7V4ZjXJiPAPIRmtI9vPxFMHgU+j5NMHSaYACtSL7/3/oZlcp7r?=
 =?us-ascii?Q?VWXuuKfByBhzRGu9qawZwIdIUhV8kXYq8PPkSHTJdOgs03MG8Q5IaKkw/77R?=
 =?us-ascii?Q?6qBOA51t4TRW316OVzeA1+nYb7tLBwAf3M6VCsX7Sw9bqKyajMJvZbqhAYlm?=
 =?us-ascii?Q?9fntBnm1rRGRiEZ1XznSd7G4vFhpXZCyXuK3d6HSkaiCux7LvmvI7+m7Z3Yb?=
 =?us-ascii?Q?bxz/h1D3H8MN5kmv4PVNJtNBZcaNn80TY6cxmEyZl7qbZe7MZcqJwiP/wAUz?=
 =?us-ascii?Q?EElL45fHtbXjMS3D+SLhuTb8Hbq75e+IMyLSun94xnBeboBy+/LhLeYzoyEL?=
 =?us-ascii?Q?36MDRDrUyvSX8M6WV7E7zdToe1P6DrRpQXITWXyDDMLff1OMfWT0gL55uMro?=
 =?us-ascii?Q?r05jYkk8FGdyLpCyq8PUfTQ6lD+R0PemON5sfozfxNu4siXV3HE5KagSLdMm?=
 =?us-ascii?Q?7oklr8x5Va4ugOSQe+ki0r0GGIyw6Hl7SCL+sNe2Epozc8RL36Tbi6zb6TNg?=
 =?us-ascii?Q?NyUs2SQ3sWzYtuWiTO8cYd86vM90ATmySSi1sRpvEUks1yEf9PBNhSTmb+8k?=
 =?us-ascii?Q?o/SgRBDWDAtyvXcu4EM0zrbdHoyUAR6SU7zvRGo87e0AvewP1Tl9JesIjQ0f?=
 =?us-ascii?Q?ubnUpNbXzuXc54EClViP54cNv/Y6SXha4T3UpAWiDg4PUMRxAQolaqS8ulG8?=
 =?us-ascii?Q?rJ6OuyD/JWyf6GxrNhqz91kiFbbYdYkLJaLOSnuyMjm+Nf0B0+shwsDAzLHw?=
 =?us-ascii?Q?uTt/qNXo3JCIHzA+utRl6efWDRaFElCwaE8wab2s04C0cGofAOLO00nsc0Tx?=
 =?us-ascii?Q?fxr7ee13F6Ba3KU2MgmkI3rRvCLZir+wqVaTvBCPLVwQi05KnkcTbO8agzve?=
 =?us-ascii?Q?zdkkVSiDJhuzMv5nUS8ZGDFOI3hFjkQg8j0DqFx9VGu7s5/h/VgSal87Yl+i?=
 =?us-ascii?Q?DeEaJkHwCJYgMRRj5oXbhdtZu8kAfrqSotvNz5m6L8P3X23NP6IWow5MFfCz?=
 =?us-ascii?Q?ihavFe4RJwUpcDDn3Yg5r9i3Da4KiOxAjFoLb/DgEv0dNAde3hNvI9zIzn5r?=
 =?us-ascii?Q?ZKd4AL6kV6KYKYXCqX8G8q1a2XNAtoEMSGfdeMcH9lK2TSZq3ZnH3gab1hl3?=
 =?us-ascii?Q?MKzywbhVw3eBJ74B6YLH1ryu8vGYpzeCY4zRKGflJv8lExahsJXCPhgKhnXF?=
 =?us-ascii?Q?rXdHrQ+pNBdfxzl8pxHy4h494zBZ47/Rw7oXHf2P5PYjBsgw0DyA0vRV5Hs2?=
 =?us-ascii?Q?x1SA5rKshyJXOqbszAavOvCB3Rjuw9BQfL6ErtdAwrXuFWDDLG4ro80Dk7Ha?=
 =?us-ascii?Q?uOirgO9pHOrECQrisF4wGo+FspZ0s4d0CMOyV5UHFngmyaw6U1i5HKS7ey8j?=
 =?us-ascii?Q?LAqotTxm7R+DcOz/FFkuj31BszQjxybTXd8kG6xP2xlt6Tol3RritNPw/6x1?=
 =?us-ascii?Q?kpNWWIroziIugF/rLdF8fzrIs8xa0CAWU2clwABLdblbMCk9eLnwDofsj3tk?=
 =?us-ascii?Q?479OM7j1no53PPIZbZUd1vHkD/ALacLCI6AfzUixfn0c90UFphW/TZa72PNE?=
 =?us-ascii?Q?m+Mq5pDAnghwyjF/6zLjIdUOuy9Hy7dB+MC+73PNLvE8iXy9gQU1h9/loFrp?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cf96f0-ceed-48aa-f8d1-08db786953e5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 06:23:17.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOs5mXhOnZvwc6sqh8ashMxT9CQLLlcRPxdUFnnXucfQ7+5t3NCtI6y+hYL2gy0qInqIzev/Wflm58oZiPyUZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 29 Jun, 2023 10:46:42 +0800 Zhengchao Shao <shaozhengchao@huawei.com> wrote:
> When kvzalloc_node or kvzalloc failed in mlx5e_ptp_open, the memory
> pointed by "c" or "cparams" is not freed, which can lead to a memory
> leak. Fix by freeing the array in the error path.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
