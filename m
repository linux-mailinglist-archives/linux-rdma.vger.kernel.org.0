Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677673F23A5
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 01:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhHSX0U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 19:26:20 -0400
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com ([40.107.93.56]:17024
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229808AbhHSX0T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 19:26:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvo30d88MUID0vgFIRSrxsfjEs5mBSHx9C8k2/DV527qv4CSG60e71eTb8h+hFn20h5C4krvLJcYAOMdDHdHh8ZnyzW8T7jzd08sTnVffm09HylPFraXKuYvav25QxE/rIaZdx8nboYLvGID+GgKFOVaF74LQKUNkIf4+zyEVtX+bNDegpHEY/CtT+rxKk1bOWI+OzajogurDKxhgV3E8XXJuBH9LZVhUbs0BqWcCvIkdaOAc/+hvm7ULwv6elXtrAa1IQ0G2dz9lReo2/UMo9ZpBUIq1dGGE8x6j3bZarmVp6L2qfBA0Fx1W47gmS8G4v5bjoCkZrvey49938LLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CCiyKv5uAZXMELezO47v5m/cnvctjaFpU7dSfgc66Q=;
 b=MWcrR3CG1kL+/wBoaO3QkXVidVnN+3PrZSVUHTbIBCL0qJnoj8ijqHgEJpDa3ZxnRyvy5BnqJHmcxzoOOMPs+X8oO7a+NmEnyhM5YDVVAXEwS3PDoZRf9BXmds4Q6pDkhRMTG4E/zmvBKOUyLE98aOkQKyc15MEtjRL96MaaS5G8qK5/mvz3gcQXfH4lPQXC9WWExLEqDa5A74SLbTwsnrxVvCk8uI8O/awsQh1TirXcy5B6JztA+q9sKNjHP+DeTww9EgrI8Yv6cJ3nRUkgcXaaAIkEFq7L3XymGCdejx66Xejwjn+sRvUyEI7gx6I5n79fkHdpHMoButCcLRJe9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CCiyKv5uAZXMELezO47v5m/cnvctjaFpU7dSfgc66Q=;
 b=qne/dfPBXu+03S1dmJ190BYhwujHViCPJYhGMjCJKdkG9NyNRLy/1XWHL99Zbr5AXKV8Zr2U3ijxCoihghIEhU8D3abZ0tYkq0/xq52ZMyvc7oNkD5PjLpLnx3U0e97ds0hCRpfgNhTDiUGalm7bbtRFiRMbQL7ukVGuy0dyHbSygx1Aib9FqRfoUea/4cXyzwIaLS+HW3wcNXvCCZ98J1DLsyqJ4QQ8p7heZu+02XlLSE+BtouC4B+d8pdIpuVVf8dCzpju4AorXYZzGWG96T9sgfOmkopzkfxa6QmIWl1201HFBR3BK29Ld8kI46WGEu/k8sO+hAboXoZFkCb1HA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 23:25:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 23:25:40 +0000
Date:   Thu, 19 Aug 2021 20:25:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, dan.carpenter@oracle.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory allocation while locked
Message-ID: <20210819232539.GA395924@nvidia.com>
References: <20210813210625.4484-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813210625.4484-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0225.namprd13.prod.outlook.com (2603:10b6:208:2bf::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 19 Aug 2021 23:25:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGrPn-001f0X-7q; Thu, 19 Aug 2021 20:25:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2162eef6-2447-4e03-f260-08d96368a88f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52220FFA009F717BCF5F3D4DC2C09@BL1PR12MB5222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7kxqEVsdybw5/Tj0TOkQ6VslmOZGrUB95YVLtEni2a13Lw3Icva9JJR5h6q7624YBW8QKuhj04S8M7z+xWTSjfamM24q36utK5mrqxGNt6VmGoz3I2+ThnLnf1wtIn+xIfe7iWzc6IWqZKwojlVQiMG235y1YtAlxV6MRS++xIZuSHf3ZW0HttwfaklqtiqrWXa77UI4PDilPbgl8GJTJ5qXwngvZ5yM7ctj8Oz3jTL6PJN0YIulfUISwT73INc+Y0/0m/zBnY1ORIBPOPUjwKLYWyLfcPy9NjzBrDs1E5R4m6dHtwR+RLIXM9wpKjRi3kNP9soB6/hpyVXnPM3IqVRqU0q8Xze04S4bDjxsr7lZ2S6DOdHruMh+VlpXB4XZrJcSB0gExvYAqbN8W3WMofbLT2k9tT60SLocgIhWdcpOBqFM/i9qUfTQj7MdYDoJo6GfHme+weoCcu/ZcToePbFueFvwJRbmxl0xzOh//zs2L1p/NMWDpMDRTANbMM6cT2DdMzeOJUNsE1+b4IZBzMbQCmcx2mzzphF96CJQmF4+BagRQ8bPTEO5Q27am/2SKMqWbhjWSnHLxtghP/nowH7Miatsc98XDj25RzqmLFUWvzRuC1ZUoQxa+VgAcVYKRcY9Kv6h9iwT/g3vgq12C6T57GDQ3zq4fjBMyupLNF7msetUzGiYZm+tOdgEN8SR7A3d4tqIASSIxelkq1YAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(2906002)(186003)(86362001)(66556008)(4326008)(2616005)(316002)(8676002)(478600001)(426003)(9786002)(9746002)(5660300002)(66946007)(38100700002)(8936002)(4744005)(1076003)(83380400001)(6916009)(36756003)(33656002)(26005)(66476007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3GGuuM8EZEEoTkGysnJbDdhHuAiUaXQcFUsjwhkQRlf3PdYJm+Ht3v8qgyz?=
 =?us-ascii?Q?DhnAYvavLmI/jegdPTNcfJt+k8DNOO6owWq4SwhzBGxid8o84y8TCygBgLO1?=
 =?us-ascii?Q?0jV9xi7n09aJbb3r885mX9UvpONwfx0VoJXo6kBj2Z69tMde4WKpovhNG4XM?=
 =?us-ascii?Q?Rpesd3/G4Ii9pXAQAmhQnElIDZsn7biOwf9fngh33mjyQmtmPbrTR9kIJNkC?=
 =?us-ascii?Q?0ubji8k1ISm0W9H6FqvjOeaeHMps2hmHl9N2NJIupz8Nwb1hm9uyqewXdsXe?=
 =?us-ascii?Q?EWLR9gjUqBZsYKUsrX/1UIXUQh1uXziNOqmUtwW8BWSMIqM5w9dTGiQbeA0o?=
 =?us-ascii?Q?xSIj/CbC/8doOXeoGah66kjf3KJUk0Oym4XW5tOHgT1Yg6ZsvQFh8lRCyB+a?=
 =?us-ascii?Q?MC4Rc0iy2/QWzER6PJIJiK1xuRXCAyMJQd2sNCHIhbKZFhcu1d2YUNd/baIO?=
 =?us-ascii?Q?JomGCvMwp2wQOmjofO4hdFUgpcU7H2swNL9kTgWTBAnC+AZ8mwLpC3F7D4mI?=
 =?us-ascii?Q?Wd/2P1s83fIweRJmdkvjAKH5NTFby16PehsVyRCWAnm5YRBGq8Vw+x7GUUOF?=
 =?us-ascii?Q?9CJSeHkF9kGG2xipd56MkZxh2zv4rAa4btFj/gbr5tJTjvULIRsa8H1twL4l?=
 =?us-ascii?Q?fMk3zH0HI/78I6llQi0LmS718Qac0bXGa6Gdg14DAK+VL1hGmQhAsQtogJer?=
 =?us-ascii?Q?LtajA402LTsUJJDWKkGp4lVPox/YEnhN/KOaD71Zq7lK2dbfDyIrO8BtEMw5?=
 =?us-ascii?Q?jKZmCIYp6rfCwDSsbqkMG7+XDqlYFi0TKZ6QnG/kW5fvj+OvSYoH/u4/kuZF?=
 =?us-ascii?Q?BlIH4mEAn+nEBp0QoVMVR2dEuca5qnrzAmu1/NMTCYJjzvA0Z+CP+OUkyPWg?=
 =?us-ascii?Q?7hzPrT4O8w/kPoGoNXvCfeY1is9KiK9QPyuFZ2IzFrju9QRJSqFjZXBDJGb5?=
 =?us-ascii?Q?Dzq7ME2/zoP+kQi9nbuap+D6qAJlrijSGpJTE4E2SxhVRawQq9g9FR0p/Jlm?=
 =?us-ascii?Q?tgJdg/ERO5NrJ5+XXn0b3f85OPKTjJs3GjPbLj5CyUDnxCGA0SYGGGU9hFwk?=
 =?us-ascii?Q?hQhqrVFWUH1R96eTudGMMEY0P3834pjzkwEuYPgt9oebjfsiuwi5+MF/xpSX?=
 =?us-ascii?Q?UhxhWgscHTeVSYZIpHUjoZ/jhBAGQKStoBWthp/iZZzk315SBR8D8AkpDD2W?=
 =?us-ascii?Q?saCwMdjdzADLctkr7mKaSfMvZP2m/P59yD+upTRI8MB0LmY32IQRh20GyStR?=
 =?us-ascii?Q?dcc4s5muGZ0wl6YM+234DUy60eYoUFzBdrv5mCHoQNCnuoiWyC66yg08CXgy?=
 =?us-ascii?Q?QuYUm3NNzKO8k9MRl1ZAga6E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2162eef6-2447-4e03-f260-08d96368a88f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 23:25:40.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdoVpeCJQW7nr++GJ59ZH5ar3lI8aIvQalHoj/ipIA7n8jws4rAmum2M7CIOZK8D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 13, 2021 at 04:06:26PM -0500, Bob Pearson wrote:
> rxe_mcast_add_grp_elem() in rxe_mcast.c calls rxe_alloc() while holding
> spinlocks which in turn calls kzalloc(size, GFP_KERNEL) which is incorrect.
> This patch replaces rxe_alloc() by rxe_alloc_locked() which uses GFP_ATOMIC.
> This bug was caused by the below mentioned commit and failing to handle the
> need for the atomic allocate.
> 
> Fixes: 4276fd0dddc9 ("Remove RXE_POOL_ATOMIC")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mcast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
