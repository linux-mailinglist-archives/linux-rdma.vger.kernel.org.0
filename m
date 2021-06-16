Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4393AA75A
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 01:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhFPXVu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 19:21:50 -0400
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:62177
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234476AbhFPXVt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 19:21:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxPLLA0cyR2eLeSN3jDbR0feRmaiCJELZClspZ91lPx1cduOqO+qDRS+OXGOAEh0FaagNzp79aNVLoSKduiE1P9KKTJhAe6Pb73q7tR3YNjAeEepam2K5o5CrUU7663a08GNkzveN2qSb1k1UigNMfbpU7bmCYRw5SHLCRFR1ZkOG8agIUBPY/cy3ShciuU/eQA/BvJRqzItImoKiV5Aa2XNhSCznWvFsJh1/NnM4gr2QIhIPw/HVovxuEVggaLAuxcWxPMe87xS7yDwe0EAX+/lXFj1XkkIDL7LizxIaZP3RXcVjxIFQqgGoyxgrWwOxrtN8Os1/vaQpGx2WcQE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzNPaQp96qDe2lhzTiW9j0+qO/F6SeCiHZmJ9adXAqg=;
 b=D1mBIBl1sGUxsmy4ay7wcn+MSDu6oZohdYt0rI+Ir8++acE5IPDGKf1EyrJCeaaas8meaaweUFSuPEPbEoteJidKQm5cWCeQOoPuJHZwyI+yPrNJn29VZMMO7SgsI1/x2lmpdvOwhpwJc7nILVGDtpYwjT/kiokgu7opWRCkeDyYDa5hDXQ+tTjQ6RYLQNFF1+DI7vEOFkvI1mqxN5AE8c+2WCcRWzIiOzVYawjraPnhogNXz0di1YJJfMnCP2XKcGABhQZhQRvCOsjUwENWR4eQ0NCLhOstbEiNQlvLuJiyqxnNOZ753hCUxVycJW7pWuIYctQRVOwwJYKJxgVzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzNPaQp96qDe2lhzTiW9j0+qO/F6SeCiHZmJ9adXAqg=;
 b=fHVzkA9OgMrc/ZIQBoT9odUcneUTEUHVBhCDvACFVYzeEUJBk7SmBCT883/cK7kZY4JeUSEmH6wZj23CeykEyklicj+Yz44PbbfEKvWvjDZ1XtX375V6SR+WoOErdsRrmkisj6Yt4WYNFTuQl5KgsMajn90eRTCsU6K9YoSzvO7c4jLxqTOZExFuO96ksjaH9QIKad7hFekPQeQ6S68e2b0w4Z0Oo/aROzwmCroBG4ELSjReaxNEkuqV6Sod5RDKWxn/uccJKPJKw73gManJRBHD/KCd0kHU3R8/dQSmPD5jKex/4PUMyxK5cxGDD8UWw6KbKNYSKiwrvzsH25Epug==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Wed, 16 Jun
 2021 23:19:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 23:19:41 +0000
Date:   Wed, 16 Jun 2021 20:19:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Don't add slave port to
 unaffiliated list
Message-ID: <20210616231940.GA1885358@nvidia.com>
References: <2726e6603b1e6ecfe76aa5a12a063af72173bcf7.1622477058.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2726e6603b1e6ecfe76aa5a12a063af72173bcf7.1622477058.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:208:d4::49) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR04CA0036.namprd04.prod.outlook.com (2603:10b6:208:d4::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 16 Jun 2021 23:19:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lteou-007uTx-BZ; Wed, 16 Jun 2021 20:19:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e6e9e82-73d0-482e-b8fe-08d9311d37f6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB535053364A8591693AD57211C20F9@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBeun0T9hm5WCDMopgRMVViQFQp4DwefJCd49XmT9JEtE6IYfrZSW3HJawRLhWZQBmHroHvok4rvJ5uObO0yFzdRId/TBdIo+4eHqQU8Zw5ulcfUvG/aQlb9ADxgKs60hmZVNYniDq2cOHtEdquBzEi932vbpy4VxSahyoO0GV6s7zVI8sbafqXRdB2FWg8IG3AtkxgtuILkQT+fW0qFt9JcWGoFKeWah/Oa+cH4XQedNnq/TzqaZIZQ3XB7CZQ6x4YKw8P5YVDAlfagc7jpb45hzYVW4uMqD/Mibb9UjwbreEykm1tywBKrUAvQQOHb5DIhK7dBpvI0/fGTvAA3HckY40RoPS41CxsBnbzoAfjhMSUMdNO1RDepdSoTIJJDgE9djwWYuooHjyhiPBiXWvaoJ+xVkXbt9ViPAb9EHpWihXs5gfMBvf+wn0mfd6Dd14Itp6TTg4ItlObmEcBCLNTLnVV++BRIQsWa2pXlMFVEOa1yJIcejeicdsaBuSGbxcd2Sm9NF5EEoXJGes/3ypk5LmvVccPcz1TnyQ9/s8VsNVAwfB6pNfdbSIJH8MET65iTuot9Bx2vmZZz42iHAyrWJLm8whCas/ZZa+HqmgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(478600001)(4744005)(86362001)(66556008)(33656002)(54906003)(26005)(4326008)(8936002)(186003)(36756003)(426003)(9746002)(8676002)(1076003)(2906002)(38100700002)(66476007)(83380400001)(66946007)(5660300002)(107886003)(6916009)(9786002)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WmqXrpqnK64szwc2FW54UpqiVPWiu3OAurMHRYBp71Pp+Db0GgrFW61NAMrC?=
 =?us-ascii?Q?FY/GXcOYLOCyPybVNpVRFeHTDoxoQ3jnKKU6Hga03YUYdHfOGtCWZKApr3F4?=
 =?us-ascii?Q?xs6igJECE+54+3sNkQ7NutVhqC+uxGW5D+FAu+lH07WdA1W3s4of42uTbM4w?=
 =?us-ascii?Q?N3kXb2q/NNXdMH+bInh69NjvXhLX+iYNvk1Ad5qZj8LH88HUYEq869uxkRw6?=
 =?us-ascii?Q?XMOkkLW7drGj1K1Xbj+bcLFNATdRd1J6n+4r92iD74d0o1mxFig/645dr+Gt?=
 =?us-ascii?Q?bTheoekjlW3lidFK/lV3pLKQagdy1ziFXsqzYjwLvMapgTGZHiZavLn5IOz/?=
 =?us-ascii?Q?oCsCKaiBm3n3Er3wFEL4t5OLCmUWvrHBYbIqaGJrRtCKZTocF7uf3Pnfmv5E?=
 =?us-ascii?Q?/7oskZ/HTSt5odGJ4HUa9q0/3X9L1vZiQ7vAL2SSxVa01uoY/FfYgW9GS+x/?=
 =?us-ascii?Q?wQYYyujkiRU4nlwWhMjdBtUKnEXsYKNMDf9E4UYLgJIavbBLrGW/fnnCiPdK?=
 =?us-ascii?Q?Fn4Bs+YBuxYO6khZQXmapY3R10jFfpBkQkpCdok4sErjWwpsiBfA6AMZAYOc?=
 =?us-ascii?Q?Sxf31J6T3fPO4I9L/q3swmDNuYeUOSZFOev7jlVVtuL4VV+cgmLSaWF3ep0y?=
 =?us-ascii?Q?DwcsIW/PZsdmYd0L++FUkt7u/UpF7U6RoDMDL8V4GJip47xEywXWzOVU75Zb?=
 =?us-ascii?Q?JNqa181uQDAbWqqF9lI/opdDFMq9e8HmSl6haTh4tOeFcjeiB34tGliKJmvZ?=
 =?us-ascii?Q?62OIlq0vSwyb9yMVpHIWi/+cJfSJ27dDApZEeo9l563ew6M2TQArGm/zaPkF?=
 =?us-ascii?Q?HYEHY3xrdNLaMXVzZK8IkuNqDjjQgM318At9OKkJAAymUJxfqMBqKx6NPG6f?=
 =?us-ascii?Q?rKjZwnrbtcQmLSXb2r//R+OdgXxfLAww6MtMdJVq4R9g+1pgTaETYAE11WZo?=
 =?us-ascii?Q?wXBRwQXecdIynFBIO/Nawl+lrPgU2Q9fU9SUFQu3sNBJO1JEvxgOvCp2zUC6?=
 =?us-ascii?Q?ONGay8xzNJwUQq22eH+XvJEc1IOcc5DGWmfN4ZsuH9oqZSB1WMYSmkuOTfjM?=
 =?us-ascii?Q?c18sWt4QVC0iT68yi/yzGAzTyLTaKFiouq1HCCTcRGKWbM3zKCzZ89m6EZhm?=
 =?us-ascii?Q?eAHoigmu3Yf//xRgnqlXSgFjLwsIDfatKD6gDNK9CVRth5gY1v6m/3LtCX8b?=
 =?us-ascii?Q?xQVmUNsyHHa/be6u+USlubJFWFeI9F86m1fwbNeio7GnfFdoyl/23OK+/Lvp?=
 =?us-ascii?Q?alUF2DBO1l4gzNEVmHkOdQB1UzQSi8kgXwFdeHkzMyvy4fia+7v6/rrxUKdf?=
 =?us-ascii?Q?VhbVYZGNJcnZIv18w/0SOCrL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6e9e82-73d0-482e-b8fe-08d9311d37f6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 23:19:41.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMRpM0ajJW+JwqDKGscLm2HRn8ayVfJbygOOfyAMiFQv8fh7OFEtE0tN2R20/pIZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 31, 2021 at 07:04:44PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The mlx5_ib_bind_slave_port() doesn't remove multiport device from the
> unaffiliated list, but mlx5_ib_unbind_slave_port() did it. This unbalanced
> flow caused to the situation where mlx5_ib_unaffiliated_port_list was changed
> during iteration.
> 
> Fixes: 32f69e4be269 ("{net, IB}/mlx5: Manage port association for multiport RoCE")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
