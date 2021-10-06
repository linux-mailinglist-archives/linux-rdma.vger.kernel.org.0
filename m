Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF68424A0D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 00:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbhJFWsg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 18:48:36 -0400
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74]:63788
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231559AbhJFWsf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 18:48:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocA10+D/BQQ0wg7L6U+9QDdqu0+a8oIjhQAghE/09rZkLLqgYQI5skHC1aGFUh6EfJDXzh3rWXMUBLkyqPv4d39QH6PjC/9xLN/966cqwcLJHHr0IVfWTaU7gmMrCmvYXmBZAfT7KY76Nq3nrL4bhZfYqynTnyA7MZI1YJcMLBLZ4o8flZt2px57m+X57xCkaWdYL85Olb6YOTauhCDlLx8SEz7GHq4I+X080SsNVUgnp/VRS5ngxybX8tU8et4c8eWWRZOYAjkQykHnRuHnVis8nFaioZdjznMrSzjMZCFYPUxYefvo7uh+i/2SlAM9SQEmcWIxMx4IAnLicPMjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJaeIM4uqlU/vCrjRb7UNqemAZmlAhbOvlONRbEuj0I=;
 b=JWk+8fH8/hYMnjXtKe/kmkLQ0rUL9Q87sJ/sXkXqlma724QxD4SFwl+io4ft5DW8ecDg3CZHjpTiVQCbt60Anxi37H9mIH2cZmI92fSy65UkGegsal381bd1y4N6gURXdZbivPsisXZDKNgrbsES+1RI5syq80jFQ5qjwq3Y4ZxlvAQ29UbD8yRnKNZ/FzK2EO+rOCcawsnH0uNsEmI0veSUInVwwAHjsPdtCOIsAkjYWaSCMpA3fo/8qPb0AoY7xp1NknmfMs1H+1javnQtzVat0+SCJ6sXzBWz0ciR+vFF7c6qzddcg6wt5/yt1cCL8haFFi+eVM1qjfDnDioVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJaeIM4uqlU/vCrjRb7UNqemAZmlAhbOvlONRbEuj0I=;
 b=nzBd0cmzgAQnVnywQ5XmK2XhYjpwyZi0pYG5cTkO8b5bzirRwLpD7DmhIm2GHCEm35Qy0qzcVR1LGAqYJAwbJ2g9J+p79F7lYKipUGpEaJOlNWl7n7oVeTsM3Z1apIaAKq9i267eU+DEKtPJlApA9OgckZ9PDimbgGP+wGLeDY8u/HbwYe3xFaQfq2n+MrjIrNVFZ2ucCjk84CJ5ckl0Ga7VpWFkhjAZT/T8neTW7KzFTs2BztVWB61yPVZ6/+R+iHZRN5KKEt1krgpq8GhIlBZsBzzkYdK2yXKnBQJ+On9PMAZyFLT3x/kjRylVW0O9rCzuoqXWluYSJl99Dgde+A==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 22:46:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 22:46:41 +0000
Date:   Wed, 6 Oct 2021 19:46:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com, leon@kernel.org
Subject: Re: [PATCH v4 0/4] RDMA/rxe: Do some cleanup
Message-ID: <20211006224640.GA2783838@nvidia.com>
References: <20210930094813.226888-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930094813.226888-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:208:a8::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR12CA0015.namprd12.prod.outlook.com (2603:10b6:208:a8::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 22:46:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mYFgO-00BgDO-Lw; Wed, 06 Oct 2021 19:46:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46baf1a0-72a3-4947-a4c0-08d9891b2a35
X-MS-TrafficTypeDiagnostic: BL1PR12MB5256:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5256F949B0A7BB9479FCE666C2B09@BL1PR12MB5256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eifB56oqERVhk5dZdYv6+hKcKNEj0dt70yVFHRPKVyiOMllJO6kpafONj9KVbYE5A8hVwFCP+k+CgLO7ONNjEAcGEo4N7zh4KuPaJh2TEFAlOPd3KhynqVdAoWpHDU0t7g39Mzo0mKQGytIEUhi+dP1CmJGKdtyTtKC195yYvXH67eyiLocfBkD2IS5TqhuP1JcrdVd40H1aaVGL8qz6M+tVJWXG+SVUxPaAHRBLlPDWdfBcTH7tsLVb8QWrezn9dfvGvUBRke0gWmAy9bGi4Gwk2Cpe+lg8xK6kI8wuPsbImwerYogaZxOMZLIh0N2s/dNpBTTYvpCD1PFwP9pSKKAjZ7V0O9zaVvCHI3VBdHjJ+id6D0pP+mkzVV42XeEUAZU/pNz7U/dEdCbqLM/YPGEdb0Cej9kgNwkRhVv0nBw/8KNreNXM0KTc0wTOZh2HaR6GmCBrPset0GzHweFrv9CBPJsbpNTVFW2F7/TnWpUwga/q/gSB37sxDlMO1lB6tEi5I6uuf8y82Ru1+2EGORBK5yXiT4c6osAPvyY97hoTdSbqwN6j63zoBxoctEs+1Nvh08JF/gkOKI85PB0BpcWbTUQgTZJiK6hdIEjICGz+SHukXUBBfU46C2Zwe/plCFhIJIUsWdx+OoqjUoR2jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(426003)(86362001)(1076003)(83380400001)(2616005)(33656002)(9786002)(4744005)(9746002)(36756003)(26005)(316002)(508600001)(4326008)(8936002)(6916009)(186003)(66556008)(66476007)(8676002)(66946007)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dtv9Y+JaaksPkdkH1jyXzJa9TWfY9FE4bYhyW4r87qJitumrYQ9D9hf6jEyN?=
 =?us-ascii?Q?1jjOw0ZP7e/U0s2SzG0vmRzszqtscx75YDjJP0M5TL5IiZ4+X/3rFSKYK+qy?=
 =?us-ascii?Q?CLaSzzgLnzmvI4RoImJj80VphEPld1QVRDDrD17meku06+lmnK4SM493CNKX?=
 =?us-ascii?Q?2DymyTctKkkKw1rNQKjpE204DvgQYPW3kIEEJLfjEakfgL0NqiyNq5yz4tPk?=
 =?us-ascii?Q?+a77f0sjNWVZtgluYIJmz/FNA31SnawRCS9TcpM7lEvysety8beh3nqVvmZx?=
 =?us-ascii?Q?a2x5+hBo+jFubto4mL3GU9aHUBNBq2GRDqD7yxGAfxwKhH3RZuVagOxnO3iF?=
 =?us-ascii?Q?2y/qjHRBHG758NPhCRFVtYldQBTiatId4crcNLr7mjxClSPDN10P4JVQF2bb?=
 =?us-ascii?Q?nQjTV3PkCNDnCGr5FQy7+9EhVQAx0f4+418PUzlkq1wmDDPWG+lo9J/uDlx9?=
 =?us-ascii?Q?HzIk3KIbUfIITjCDiigEC0JJOEoKrP5O64URDqpVE7vNvmr+1E/DP/xKtLft?=
 =?us-ascii?Q?PLj0K0+5+1oqYVvmeQw11suvk2rBPb0Tada9BfD1gGlvsU+CxjJG5aT1pxZn?=
 =?us-ascii?Q?Qa8w11wCmohxg0npuM5Wx/5T8tosoF19dPrtqJ1oR0IeE8l/zE4MxdTosFu0?=
 =?us-ascii?Q?tBlTl+WD9N9J/3fLzHaOKj8Wi4vDS8tZTB3BaToxk4zXQt1+sWO5J9Nkji9A?=
 =?us-ascii?Q?WictJOOI+79rYupuQAo6r5fkhbdGCmSRgNqn85fjD2CB8JJ7HRtrsRqZWs6E?=
 =?us-ascii?Q?vNWYnKQGsZ+RW0ICNsgzi8KeH6q7BPbR4ydv3CpIvPLtUzJeFQBd7TvT1wWQ?=
 =?us-ascii?Q?WtKYDk2TmoOlsZ0B5lgR19JKGy7UIMwMdsLH0fwSZ0rJDWbfmYV6eL2x2g4h?=
 =?us-ascii?Q?R9/YS4EGOfV7Jjwgb/5hVC5X/e8pOX8vpwS9uXBo0enZfkivmLQqfp7Awpk8?=
 =?us-ascii?Q?JyonxPY3/X+n+12GiA4ZGjW9Bpw9SXe2DcYehdtf0TEH1G7rRCaRyFsJuZf/?=
 =?us-ascii?Q?ZMUIyHxXV8Q+y1nyrKssoitVFo53KMKMlOBTUzpDuaZkk43P8+DScnOCnOMx?=
 =?us-ascii?Q?88pAckSM9D6/UD+D8eWk2cnqZQfUo4Hsbewh6q/YlAYhg+jj5Zn4KMkWVJur?=
 =?us-ascii?Q?9uvpD3Vp4ISVmtB7zwJRIhJXR1N8Z7nHeFUz4pLF3zjHzl7LpMPlgjUu5G/5?=
 =?us-ascii?Q?Ry2pTHQ5UYrNqETtprWRoWx1rMFGabX+ae2ZEAuiUGmRoVjuxOZ/vo21s9IY?=
 =?us-ascii?Q?lTVj000j3MdR22TRSMgZuZ+Bdeu47jX0aU0sBfEfAfi1khoqZQly0lDg+UxQ?=
 =?us-ascii?Q?jLNhbC9TpFPzeZbP22KOwozQJrA6X1B04SIKNJ747JhYyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46baf1a0-72a3-4947-a4c0-08d9891b2a35
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 22:46:41.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtsIeXLhrE3GoKj9heH8oR0HYvtasRE/3LY0uSzaV3LIN0jRTgYrQS2Apx8Qi2oB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 30, 2021 at 05:48:09PM +0800, Xiao Yang wrote:
> V3->V4:
> 1) Rebase on the latest for-next branch.
> 2) Remove [PATCH v3 1/5].
> 3) Update [PATCH v3 2/5] to remove the is_user members of
>    struct rxe_sq/rxe_rq/rxe_srq.
> 
> Xiao Yang (4):
>   RDMA/rxe: Remove the is_user members of struct rxe_sq/rxe_rq/rxe_srq
>   RDMA/rxe: Change the is_user member of struct rxe_cq to bool
>   RDMA/rxe: Set partial attributes when completion status !=
>     IBV_WC_SUCCESS
>   RDMA/rxe: Remove duplicate settings

Applied to for-next, thanks

Jason
