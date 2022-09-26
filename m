Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6885EAEF0
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiIZSBF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 14:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIZSAl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 14:00:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8724B1D0D0
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 10:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5aYMrFqHyvXKfA+cSbKoGSCWVxgD06snpwQ9UwTyNHEO/IRAiXqZq+zhyXT7o8YI9Nw0JauXts4R6O72NlL6CbkK3NvMprlagodofQ5zC17Hm6N1XAdBnT+mRFaaUB3wZ+29p8GsYmFIHkGLdFdlLjmlsIQvKxclHby5Te5Jz02p1WuhZnVoo45fW3B2fuVc+1XoxTMB7ROTQCG8sG16MifPQmw2SW+21wUQMB5c7OkheBUAjLmrT6ZnlvqLIA8/XymK3udbSP/3DiVFAckUUlaQu5CDqRXrTnQ4/b6E86E1aKmn34wdM8OaITljtF46H9o49rThscWp+o4gTztkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Xqqca7ynLVlSXWa293xm/p4x614kOpKolJ318D05JU=;
 b=U44XJlVe/eR9lEc6XDfK9sST49I9wUWiGzjrQqh+E0qLVoP6A/AhVElq3ZcXgB8quVu4yETuvwgG+2AVcY+S3EG6HaBhuBfSVGrdH1kVm448qfsyDx0jG4ss1lnI0JDZzxbB13a4Cq/zcTjLrQDOnu0iX7QQHlcmVLRkzDNQPwlTjWLgzUc5Aa73S+zwDkNwlrvE+Q28AHSdXuGvfna+bFE6MRamM0r4zoKu2hYcIV3wtgs659t5CHPWmRes2g/WIksVKmwXgJF4S4G2ZjtZfzONgvLytB8ake7zgB7JpEuF+sHG4uz2gQBVktCFeHwNRdqU3bSXYjDdHeGn7ne31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xqqca7ynLVlSXWa293xm/p4x614kOpKolJ318D05JU=;
 b=O24amh5PFZ+zUpqARWckeKJ7oescb0ID7f4cSkhQAu0WFjO9A0T6pHl8gvw1W2oogaTD0tQWPCP8ezDH6HCSZwjV8d5lXZx87IAmjWPGHnmDJhQgzxhQlAo53VtLuKY2LYLWUWJ/u195qzxrSE5u4f7u9MvBG2fMI5I3XaWVJcI2/SK+JKNN3xwJ1+b/TcVW/IgIBuaErIy5xyvSmF6nTl+ZzDuP+adiTV9FtzoB//vgnDYNjSw8nvkoghLJf9tziURlY6bLGSIIE5kBHlqRyWIS+SPGhHcey/ehioTUUat4tcy8CidyEAJ4aTtMCAoRZ6aLPLYUYXdi3SR68y6Lfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 17:40:59 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 17:40:59 +0000
Date:   Mon, 26 Sep 2022 14:40:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix resize_finish() in rxe_queue.c
Message-ID: <YzHkKl3ejOcJGbD2@nvidia.com>
References: <20220825221446.6512-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825221446.6512-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:208:134::37) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c420d98-928a-4772-5f3e-08da9fe645e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kwSZOloRFPVvKMlL+nBC6rTBkZj5Y5CljEviVv4f2OlugbwobzhNSVYXOa67wpPeqQfQi/Lw0ndIXzW2HuBd3Oyio//XvfyGmRCHzwGePiCSlqrm1GcBxL4uaYNxLZ/hv4617qR9G27r6qNs0wMKPQUxCUHcrdVTrj0dkQz9pStDTElkm7+lUo34QYIzb7dAPEQHWHDr/tzd4ThAOBDBZwHBwq5pWqgPpo/ztfyUNKiZAjjyiASnygwmH1F1yglCId/j+qld82yjBREK/mBPJvXliD2EIaAYn8bVd2+s+BoqsvtnZ4bAkZpwomYGeYhKxbnj/fEFvJ6wVIhnEjI7uf9jeaWqNJD7PjfBcZUtmDLlTtND0gtD4m42ObbQMEEawBX0Epb5rjyM3HCf+n9NgSQlRMoVZOFHzr9wJ5oEO/o1TL2zxNt8EkJ/Ham9ZjDwNWkEpvSCYoI1HyNZR2S9vXpZ9QWOKdDY4JJNNA+rXUpaW3ryGh2ko64r4QSE3J/I91wwknyMZg/DybtTegkAlORHaUEMqbnjEZtD9p9A3M4r9nMMIhosMPjwpScKxC5ISxw4Q3oNMZJulZfwYSLHBwVtv5Dvs9yOvE0SGmEBarLHfPDB740TYyoKEEDuyUWxHqsjSs52Y6mwl/rOQdR0CSV//CbCKH0BlM3UJxwqiWJPAdRXeX4fOlT3L3X07icn/VVPU+E4MDQ/zbp1y0mOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199015)(41300700001)(4744005)(6506007)(5660300002)(8936002)(6512007)(26005)(36756003)(83380400001)(38100700002)(2906002)(186003)(2616005)(478600001)(316002)(6916009)(6486002)(8676002)(66946007)(4326008)(66556008)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvd89ehCgubFRitKBzVGRHB+Cl8CyC1in0cVLAkxClwB1fxiSI6UVAqbe/ZQ?=
 =?us-ascii?Q?8RPBXm4IwCFKpDbxFPQVcSxm4OKTHmvtw2rNHHu3aTf8zk/cgP+qDsLyJJ6r?=
 =?us-ascii?Q?NhE6xuUexKy6iTuu+SQ4/8WeMBL7GMmQo0kD5/TkiOWDi5cYvrX1wRH98lPo?=
 =?us-ascii?Q?lv7PVcLmmsYtrXkgCNfMZt9okEFzlzNIiMv7MJvopIhCacW2bi2YXR0IK/Bm?=
 =?us-ascii?Q?8YWJm5bsYo/cyzPHB2bnR9LsghNd8gNEGTmI7XOMOQGvPXsVuVJhnPGSAhKU?=
 =?us-ascii?Q?U6M/zkwlqmvxkRzqpXzw+FVIcnSUhjopHfoJoqyc5B4JV8VqCE2mP9xBHMoJ?=
 =?us-ascii?Q?HW7T4kEHNRSqzsjdLLPCooquvLWNIJ/FaTRhVS/+423OyP0rnV20AzHQ718c?=
 =?us-ascii?Q?t2Y67oCzyk/SNJ13io23jQumbBgr/q4QZVTF065rXwlQO+rXM01qKJfhHzXf?=
 =?us-ascii?Q?xqxHko4g8U/6TK34esnlMuomISC+xJVmJysOgWQ+OVbnmH3kh7iD2somPQhZ?=
 =?us-ascii?Q?6rbxGjwZtStkN9Z6AbfFYOknKiRHx/MMW0Abc13gxh5dNsGNjyKVKjvh5LI6?=
 =?us-ascii?Q?QzUMhoLZGxrZEOIlYaXVzWugeO9hAnUb9Jl4RGmk4OEh5j1lMYp3KbH7MP8F?=
 =?us-ascii?Q?lYzu9XvC+rmqm0FDlqhYPS+RR3yR0gzEP7RjbLs3hp/RZ98zeY962h5CMPmT?=
 =?us-ascii?Q?OVhcFN4/HoMOPtrZNPNbQOx4Eo8i+QEGtOJOjwDS2+NlLnzs0TFvIBOgiqdc?=
 =?us-ascii?Q?ZSiDj6VUI7cJMn3CxnHWCClZyq3GCoC2vbWcwxhMNVX5ePZjXwoj0NA5Mq/X?=
 =?us-ascii?Q?aCJyDXhXjwJWHTVFIGVMDO6mHp9cVwsGvZ14LMfv18May2Hyh8qmP+sOiG2P?=
 =?us-ascii?Q?7GNbHSeRQigkFXlQmTJc8BYc869cIxF5FsbsEwQwAcFgLfWNlZNHCtsgO0yU?=
 =?us-ascii?Q?oKAW1qyj2ggfRu21eyZz8wFtPjg4++DNJ1T5wo64oW7Vt/i/+02+lQCro64a?=
 =?us-ascii?Q?IZOVWi4ObAohNsnbewb3kvnFH2Rmk3KcRC4rHKtq//RtzE8b95tg7A7D4VnX?=
 =?us-ascii?Q?smEEnkzVGLDEEsv85QI0rctC9zaK85XlApPueu6Utqu+7kSJjn7U9Ad16Gme?=
 =?us-ascii?Q?8hQiPNa/KlroxCbgQwOX7Dq3wZiCAwupAdBPFJx2lfx6/BeTIiiFV7ET5Mt5?=
 =?us-ascii?Q?SUzKfVvJ3IsrEU7+e7cWCPZfgG77DzR6kCjSUDORJV85ntyqssMXmC55qvBv?=
 =?us-ascii?Q?afKMvFrON07iAXsn6YsssPwdSJAUfTjiL6Tk6ps87bh/bqbhJdOwNNAKZkfH?=
 =?us-ascii?Q?UNOppDRmlbEvDmslDJ5hZ/Q/mtjlFhvhERv2dLjm9vdl/mahf6EBKD7OXAoO?=
 =?us-ascii?Q?anEdZZF1ADNAyJS7hAxTuaIFpZpcm9GO6aBY37uOuIoXFVPfdUKcGy6vVJxT?=
 =?us-ascii?Q?eCmo1tCZb0LpHU5lwehBb3iqdthfScp8OO/8KPS3umGyp8sG4l2qR9cNdzp5?=
 =?us-ascii?Q?zH/ehwV0/kJ3zJjf8bdjfQKozA0Dly5IPmgKVkPOdfliTgNum6EQtYyF79cZ?=
 =?us-ascii?Q?nLe8BimMR/dehX5v12o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c420d98-928a-4772-5f3e-08da9fe645e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 17:40:59.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBq/3FhIqYawgDXJUspVbe6WuO3Ue0wzXk7PKVwfTRaGnca7W2YiMsNuSgQWQxL3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 25, 2022 at 05:14:47PM -0500, Bob Pearson wrote:
> Currently in resize_finish() in rxe_queue.c there is a loop which
> copies the entries in the original queue into a newly allocated queue.
> The termination logic for this loop is incorrect. The call to
> queue_next_index() updates cons but has no effect on whether the
> queue is empty. So if the queue starts out empty nothing is copied
> but if it is not then the loop will run forever. This patch changes
> the loop to compare the value of cons to the original producer index.
> 
> Fixes: ae6e843fe08d0 ("RDMA/rxe: Add memory barriers to kernel queues")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> v2
>    Fixed typo. Should have replaced all original 'prod' by 'new_prod'
> ---
>  drivers/infiniband/sw/rxe/rxe_queue.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
