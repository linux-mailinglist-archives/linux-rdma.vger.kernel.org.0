Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF94C1C25
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 20:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiBWT24 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 14:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBWT24 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 14:28:56 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2085.outbound.protection.outlook.com [40.107.96.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1047AE4
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 11:28:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUDEWq5S2WvV7cCYHxhn4vQ2+UFgyY6ACUsMjmXa3jS0BH3qckCbUNHPUond7WlF7AGBLd/UkAyotzCuHMAwOBkx/yfpUcnG1tN35u8LHmGoYDNY0F+93xhMy6qBXVXxOv78KCm9IZlaU7Gpkzyi/9rlMdffQs67j3kjX42FWyegIctzIwwJjlXMPWzcMyyhEMqIAEIwNMb2eHco9EK4AN8hcgW8Ij9vDWYcp+aSGI9Ga+Dy42NGrm08Bm2NNsNHCXpRegJDyuw6TWa2hpzAyXRq2zXprcPACl1NvMGRh0OlphdlW017v3BT2VyewRcj35Jfj40ZffeT0x7o++RxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD0cJLoV0xm/3KuRvYPboy+WjbYvAGSOnQcshIqn8VA=;
 b=IlBpJEWwnzrt133Uqdb4fdvJi9F/Uan4luOqJxWpjUnVaAQUswXm5oCD3aHCpCF8y2mxxgsyq3b1Ov3+pGbGt8ottGXSF0HfC/V37W9E49fPkI+Ihz/LiybAhJge9xE6aC+c4cJmudEpPlxRQSqj834j+TVFj5ii4ugqWlOr3Ml9jfHKupUY5lLrevmvA5xOS/EP4MyFtNhUBSz+2KMwtL5MxeHa0C5KQP7rTvzCPD5oXC3U/2q8AYIGEOa+joUTJToNw8RQF7ZjETXO1mgCeVlsrkhZ3G5xNHfWYXrNvLlVGLhYGsxQoXZNra5HcBQicU02s19pPjZZuEz524KTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD0cJLoV0xm/3KuRvYPboy+WjbYvAGSOnQcshIqn8VA=;
 b=M9Z/taYOt61PQUfbivnUHV/mlMWIqa7aLTkFUYBYXqN9S81pFQiiTOYDkoiuglpeM88A9dIqqpIfmE67Yq669DG2lh1UWGmGn1uUFsv5fP+67AfOjUvPOUTnYyaeqRcfA7EAo0e5mRhHMj8j06gslMmqcW3mZBG7+8kEP+EUIjOhV9r2LqQvQFb3Z1eGf8znER5s6L2XG9EQAVJuEwC81nGHIsBj4zyTJlMMsgRltlT7f3qLZMjs/xtoFomNKYAlpnHz5JFb+2IoDCe0P3c8EfKlqjnFHVAnFvo6OZVqOOfl6q/K5GXpI4wT1O9+LUjvCnYATPKGz1Q7h7LQZn6B+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1179.namprd12.prod.outlook.com (2603:10b6:3:6f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Wed, 23 Feb 2022 19:28:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 19:28:26 +0000
Date:   Wed, 23 Feb 2022 15:28:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Remove enum irdma_status_code
Message-ID: <20220223192825.GA418559@nvidia.com>
References: <20220217151851.1518-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217151851.1518-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: MN2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:208:a8::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1cf3e07-1085-4bda-3377-08d9f702a9a9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1179:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1179FA05EBC4CEDBC1729FB8C23C9@DM5PR12MB1179.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZUrzmVJ2BUYJ/sF9kK63AVEwb3s0ijF8mQ4NFTlwfsnYVyPOzdV20OtNbcu2ZD5BS0Ptxu0EciJlzNBpZXWRqY8gGWsC3od0Y/+tTwHzFCGN4oFJAyjdUGbMhz6M5za5euZ0afQ5bZwmnBpeqY/4JBIhmwDJyXqH6BV+5ZZZclC7NhaD74pj1uXeNQa0FHHca4N0uLILWesVJn1BiYIR3714J6kErnsrt1+jeqrLLHB5IJn5i9IljwCCM7foyFrmq+58XOi1JYgCu/lyUGpBJB6RG3slVDArs99Jsau999LSazQG3i7voLCYoZjkeF0/45YP0UmWZqmOCe9LYworo/srXUX/ATPFMlsloiZLW6ttkgOwwutx/i2F1ZIJwA1Oo7TaEtybkw7YAx1VomcbGWoUdbCKdya6kzFDypk2zV6551LZaADb4NcRXRPOxPSZdzTwuvXTM4RpSD+RFnklHVomh1sYESzPtI/pTFB71DmfHWw6yE1jS3h0CN06y2skEBuu8U84gwb7b216eFtmp+3QQQLlr19ext04rmuL4OOls8SC4WHKVYbW0c27EgDXM+9xnPlLH8phbCzXjvJw6jNv8ftsgD5L+X1bV5uR/uVRoB+4zUuFA+JU544iw2dLXsQwfXxp9UNImL9/EB6vyhXFZ2eXahF3YsBYlaMYXjl6IawvjkxpWgsbQnVAYk9XoWeWBSJcZWBRQdcl4S5bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(86362001)(1076003)(186003)(6486002)(26005)(4326008)(8676002)(316002)(33656002)(6916009)(66556008)(66946007)(2616005)(83380400001)(508600001)(5660300002)(8936002)(6512007)(6506007)(4744005)(2906002)(36756003)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1uXdyL/ensMS6GxmTGA1vtuYj65oGleEpsekj7t0dPaPAe/swxOw5zf52Evm?=
 =?us-ascii?Q?Cf6KhNrl0gkbiNVXxGlXxq+nXhvP/EjwIkDDgTuwAHM0UpZdanifMN1xXtUE?=
 =?us-ascii?Q?qJeZIQsSaevfVLcMstaCeF14iSEi1rBZVNyg/AuaC9QyQ0Cv+eXNWlwT5xVO?=
 =?us-ascii?Q?BSZbTXG6GoFXZibwJ+kLm+6G9tnT2XvCQmMnfjmgzBec0V62KzCOLtd3udLV?=
 =?us-ascii?Q?qUmei9+g1wH1XqL2y3rTq5ZqGETklGP8DOlf6a33aDZ6bCW4+dh4g+0vZ9s5?=
 =?us-ascii?Q?ZLnGMb7l7Pex6w1ZuX5eLZyqA+qyXXpFsvdG3k5dURHJ5vKrItH8vvOMNnWP?=
 =?us-ascii?Q?6LGNlPXI0sSab7O4dbHzESv4DpFWcmD6iPTov7n4JSz5zWtV88wdGtVt4XNg?=
 =?us-ascii?Q?96Cbucfl9quwP+lgHU8GQZyPYolzKCFOdtuHq7tUybRexNW/FCE67UiuUuyB?=
 =?us-ascii?Q?fFXFIT6XotQx/e1J6dihSoLv5moyUhPtYc7SAKDmfzKkmBsPjFr7qxn55bnM?=
 =?us-ascii?Q?ee77GYMmoFdAUdOZOpUhXzILkkBPTO3u7TjTN3slCPscJjqIo6Fgyifn03Xn?=
 =?us-ascii?Q?QdZlvkDxafSK2zz57lYANqqkpLVZl9T/SEt8VKF0Oc+FvMSLxDrLSc+SlHJ4?=
 =?us-ascii?Q?SEStWnBTJERDF14QbYtWfqRPva3q4PthzwuJ62/elGfoRbbk2RQkqHj6XQEH?=
 =?us-ascii?Q?lpk92jg3MtH5aRhACN7/YlurpmVXBEM9PEhrE+IunXsIhWqm2w7oyQNCNP3t?=
 =?us-ascii?Q?uISQXeje93UvPFcsalY4iu/ewFjeQul/NM0ZK3Asg5IS9NRmPYvbWivrohZQ?=
 =?us-ascii?Q?9Cl+eX/Dpovh+bXXPj8ta1FQGhYySDI1E0EZaenwL+fKbeHqOS/HwrpCr5Ds?=
 =?us-ascii?Q?fYTRmI2/aSpDKBNO/agVu+nQKCikLHdI6FExXldqkJ4ga/qeC+ramajy6VZN?=
 =?us-ascii?Q?mh4HOia+nKHtVOjY+vme7/RBjjL89+lRIRvquKDD6QPNqGU9bCb4RZpCKyzY?=
 =?us-ascii?Q?JG+HQNa8xREX34m58C6U4L06A8OUqAYYzf4qXPTzEj6AV1uBh2Y4JeQ7Pqjh?=
 =?us-ascii?Q?YgfiagrPVg20ySD342hB9pojSW2Ro55TRO0sYFS+xavQxCitH6iBfvDKrYk4?=
 =?us-ascii?Q?Fc0T5itgdo2kR/nTTzHfeXx5e3Y5Dgg9phARrcnKljzMFIsVk97If3YgEWUa?=
 =?us-ascii?Q?Z3ut8CYjJIlo2hT6fNThpJN52t+/mmk52jZjnutE+5jBn0yXduBl+6BjT/vQ?=
 =?us-ascii?Q?WBaPKahBabgPYzEKa7pY1hgF9sx/8dx+1z9o8Y61TRqBXvkR6MYWJVvC25m+?=
 =?us-ascii?Q?ahfW03SfnO7d1UUvKBVncNgGihTTjkjl80mGZGy6p1afD/00twx8hcgjSVcZ?=
 =?us-ascii?Q?8rJVeytXT1i/fuCsHHI3z5c4l2reyk/ojrr2k4fhFs7Lk5MzIqcbowOsjVMc?=
 =?us-ascii?Q?geLT5Bdes1YbTBKTUGL9h6nlAv5q7O8+E5byursYKAPXIjz7YRxhtPU8hlOM?=
 =?us-ascii?Q?nXjxN9mk6/fQ0xNSZ9YJ86o2jyYSdfrlJK/5ufqoV2yQyyRYFpToaiU8S/OO?=
 =?us-ascii?Q?0ja3b6SDK++z3tCw/7Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cf3e07-1085-4bda-3377-08d9f702a9a9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 19:28:25.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bruDYRZwzmPrR2SQ5/2EIqDqTU3uVhHS8371Cu+JG4gBRtpmziCuj4GFn9AwRzFy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1179
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 17, 2022 at 09:18:48AM -0600, Shiraz Saleem wrote:
> This series replaces the use of custom irdma status codes with linux
> error codes.
> 
> Shiraz Saleem (3):
>   irdma: Remove enum irdma_status_code
>   irdma: Propagate error codes
>   irdma: Remove excess error variables

Applied to for-next, thanks

>  25 files changed, 961 insertions(+), 1263 deletions(-)

That is alot of deleted lines..

Jason
