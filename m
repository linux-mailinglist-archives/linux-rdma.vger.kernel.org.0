Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726BC5A27DC
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 14:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbiHZM2p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 08:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344280AbiHZM2e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 08:28:34 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3CADAB9E
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 05:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6XzQxM7HzPw9ao/2WxdGZwrdBfVOWgeLgQjXFVd/DR8pertCe1B09amxScRJF+a7+XVm9zWsfR2NccZMU230LCZ+X3KNL8qz2mKN4xIZojQ6LhY97SRM1RnSclUol5o9oz3dPIDcF2KzOt6hsQFf6xRA5GI4tqNL7BPOu0uSfCWA74EGsA4M9tsIhIoNas/UDv3wnUHR4+v0urjaJ6QnyDu8dhvk+HIM5TIZjICaIsfDxZEOLOo/LK9dLg8XuLHFANX6Mf7eDuAKmEkIjavFhfvwdjxJmhBPGZsj7FyQtngl8wYkN0MsJCFJQyzCYAutdKVUJEtoIa3KF9N6Xf2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2mtqpwz6+Xy71xjZR6V93gGt0yKr8NQs6ASUSLvYjE=;
 b=ILm/VyzVun+tGfBbllT8HUZ6YesepBxNGIDa4LzX6X0RaRyTyJVhHXJ4lpnyQOB1raWog3XFK7GytmtluF2wscbUUk9Zej+OQzvdCCIUkvo26tN+epJst7tJJiARfJh0w6XKR4YFgtSPsoXMkI9yUSBf40E+4mdL4JESIo7FbHljZga8R5tKn9Ytb6iMKd7pzuHt6Pug7osnp6kjiLG/vXdiqBn5Pwqgfry9lcjYEvcM+HxxzJCf4JozxE8kag4HvghYr6InVwfHtrgiUq8o3VJKR84YOwV4wU7LFhDtnbFqUe1s7/onotYW1I/A+C48VhS85szUFtAB4J96DDLmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2mtqpwz6+Xy71xjZR6V93gGt0yKr8NQs6ASUSLvYjE=;
 b=W4xmv42LQsAp6UxZoVn/1F6KVwo7zA7b5J86lE89b+sNCEPAJVnoUFaT1YiiuGvUiI8PFY5Cp1w9k/kiPfPAhikZnnrhvAlD365/gxIWknx0WH+fO7ONtkk1hLt7ngdzp1BfrNVcUiUSjKht8wUnbrbTc4amMLd1WwJKXOj2II2ZMLAuah9BqDQD+Oc/40oIidp6caPq0tdHKt1c4i/mRrwVaHSUDpAzmldTaFCEPOjfTGAFcSeXcc6FZTefGIK9Zwkba6x6RNCrs4xIWpQ3MwqIKDJl4qcwCVExlwWcS9SjTzSTXwmlwPoUaSESx2dUwlfKdYltbVwzmrVDQi9Rbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2933.namprd12.prod.outlook.com (2603:10b6:a03:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 12:28:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 12:28:22 +0000
Date:   Fri, 26 Aug 2022 09:28:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     leonro@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Ratelimit error messages of read_reply()
Message-ID: <Ywi8ZebmZv+bctrC@nvidia.com>
References: <20220825110255.658706-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825110255.658706-1-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BL0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:2d::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0765ea23-e9e7-41cb-bea2-08da875e770a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32RU7pXjX4d56RK0BwNgoybELSSBcLif/CnfmL3esDrNB+3gTv/9KD/YNvuUTmfqv8GtKnXj3GeEEBZklDgmY02rchGuQGBksvG0PqrYugdl8P8tpV0H6xOQAPBEB2GelQx8xHvLI/bGOOVRsL6R4hkAcwEn/Pz2lwNTryg5+2TxoXmtS1WpOAhrhBjXgOGUTIpGh5CwCbZW/4vTnA/csbdJ8OCjtGimnWma8z70e/cbT3JTykU8uNUzG5BDDUIPlDXgpkS0H8u8EDH6KeKbWecRmiG5stAVWWvQvZT7wJacAKC30ChPu+TrjpO26b5hRTFhvKQCHPwjCUcxYGdi97J6jmdM7ybVpx11WYPccJhUdGIVPemFTrL25eekkyCdE6QMXHFA8QfTX4kmai7nTMp8+9fkUiO/zyN0okuioyZNBmnJWPZkDjkYjctKzbKlRcnSgsP8hTVjnVyyDvYJtsKduRg0c0OD9Txt5IeZie7kJZc5yiseom/dLDgV8tagLHhKH/1juaLXk8wjFUXE/tUsKsTRSjwhCw972jTwTn0qK2L1OK4mxcvUc1WwDSRpr0243KY4GZfXKr5ZaQYgdUsxSD1KiOVhSnXaU/KvGNI5wqg98zOe7/1Kc5zQQrtczTvjsF1ba2baAdyXodW38I4s2LRl5NFLbDUWHzf91wQKTTzX6nc+1hSJ2317LP9rUisQoteCB3Qung/czkTNU9+M+kn3nMR/XWYRVXcx3A2jAaduTj3LJsTiFD05FaYW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(15650500001)(41300700001)(186003)(2616005)(8676002)(83380400001)(38100700002)(86362001)(66476007)(66946007)(66556008)(6506007)(36756003)(316002)(2906002)(6916009)(8936002)(5660300002)(4744005)(478600001)(4326008)(6512007)(26005)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TR7Agz4oUDhYfhQvHGIGfMZkmSwEJzDcDTEWgKOKeWu9H6NtrsuBMsX9VM5V?=
 =?us-ascii?Q?eiMtSFGfyjeET76fR+zv3u8Pg3VM9hW6sRODDIXWtVkNyM98W63kT6n96xLK?=
 =?us-ascii?Q?VoobCE7WC6MFTec13rsBmB0oWrsYEV93Tjxq92i9FjkOCBtOkpJpT3715jbT?=
 =?us-ascii?Q?wOEmRKK6KbjzKr9LJBJoBezbibcYaWdXJ7C1bUIWFr3igcGhy1Rc4+CR4qHN?=
 =?us-ascii?Q?ccnY7EWp9vCYZLnpvsazh+aufhElTS8p6t4ALi/7c5uyD6jblfRsmfG8kF6Y?=
 =?us-ascii?Q?twuOxR6/YUzlgp2sER4hxDZGP2nzPqwKySZcwHygL+2AcwEa3fjbdVXmX9SS?=
 =?us-ascii?Q?Axln8+V2n83ycwZqQJHslC4nxdMjT7Xz5q83a4WPOHPzEHcuq7e5CkgzqMVB?=
 =?us-ascii?Q?FQvfh5/v6ph/VmtSYNJSFL9sxc6C6+Iv6Ui+0fyzyInwZG9cJd++0Qz5nipD?=
 =?us-ascii?Q?8iw3spXk9hc1d4CejxhW8fvSMhcBrhM9CnXVWDLV/o9rgjPqqh/rQt+rtAr1?=
 =?us-ascii?Q?gVmVM/nAhE/1xFiKSsXlfaCsbH6AEfXGVkugeQ1wzElMEgud9q779mUN9oHR?=
 =?us-ascii?Q?cnLhv7Dp8rmPZM16hDiTersLGvbqaFqqnluCeDQzkrVWa7chIBQEyBObRH8e?=
 =?us-ascii?Q?ZqLfwDUw8MsmKn6gIrN5QnFDXeImRyQpRkg1RdwuSY7hXR2XJGOaqH3uIXiT?=
 =?us-ascii?Q?zQf2d5ES4RFDuui2tVJsf3OtSrWctmxNha1zFwGMk7d694fU6U0Ie1Rz8KQq?=
 =?us-ascii?Q?NNb9YcmAQo/oWtwM2yb5CA7YGWwe88jrVGBcXyutQB+I0LykexVAaEhkyA7L?=
 =?us-ascii?Q?TE9rhjlG24BUcNxph5hafz1lmOYjdgnkiRkkOuMy5KHImMKiJobPcAEQARhe?=
 =?us-ascii?Q?Hvfcs2r4yy8zenz/KzCxB/FsrBakqocPQX14X7tFjalicTIwwifBqtku9kWX?=
 =?us-ascii?Q?uiuuXA/6vlQ1lIFbTjGdAvDuHhGRwbnJD8gvwFRyejxYswQti5ZlJfz8f7A1?=
 =?us-ascii?Q?NQzkABn4N+M/bKNyhKtvhNU69pxJfsmfvGbHRsyXKPDyQH9TuRlQ+0uit45R?=
 =?us-ascii?Q?XTa/t7SjKSi30S5R4v15RWe/5xIEc4krFnkcuhoThVAa9ObNA04lfyFJx78D?=
 =?us-ascii?Q?IhU2/uXqgqR/07aI++l5F3Vnc7rz/PMQdkAzv96zy3/zzLG90Aai+0WjJdlM?=
 =?us-ascii?Q?wAy8L96MzFM8wmrnq8lMwDHB+l3j6I4Qs0cjhrucYgU+rXz8GQhu+Is3vyMQ?=
 =?us-ascii?Q?Z2maNLEpqC9asNq15b/Kl8dhdgtRzbSJUeQhyd1q2UO5dVYogGy0ZExCQjv0?=
 =?us-ascii?Q?GWotDwGougMjumSPqKzS2Q47uF6gXl5nW0oc8fcfTBGmdiB4r0hrRP1sjG91?=
 =?us-ascii?Q?5FK8Xm4NFLke1r1M7UoFa8YGwyeWWfk5y7zzPuHI/qozpgj/rFHv1zba7l1P?=
 =?us-ascii?Q?n6047UKkPPvbI28H5vVIZIRPhoCXjMTlZhfAJukor/VNy3mBx8LnCytXhLtv?=
 =?us-ascii?Q?Ln2FLJ5v0YOE13CQegUSHnOltmKleFrCt+3SjNNpF/5LPCIMGKxgEAj+r5MQ?=
 =?us-ascii?Q?J34hqpY+qs3B9JxGbqhJIau3Dg2AnWCtQhBtj3LC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0765ea23-e9e7-41cb-bea2-08da875e770a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 12:28:22.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMQY/yXId1tQw90R7XYEH3tavWZBL8+qUXLD4XYtTJ9/lUTY/fgqANyhgmn/XrCi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2933
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 25, 2022 at 08:02:55PM +0900, Daisuke Matsuda wrote:
> When responder cannot copy data from a user MR, error messages overflow.
> This is because an incoming RDMA Read request can results in multiple Read
> responses. If the target MR is somehow unavailable, then the error message
> is generated for every Read response.
> 
> For the same reason, the error message for packet transmission should also
> be ratelimited.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

These lines should be deleted, network packts should never trigger
printing.

Jason
