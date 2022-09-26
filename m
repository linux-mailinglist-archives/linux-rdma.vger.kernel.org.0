Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3945EAEB5
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 19:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiIZRxx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 13:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiIZRxQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 13:53:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5537D70FB;
        Mon, 26 Sep 2022 10:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFlAlWK2geja4gMNDcEfz8XwjJkKo2RwGQgl8ZFvITWl9/imV/y21tr3xhtBfZ0cPyaNj/MRAx0P3IeB9zt+YInLx1gzbAlYBLxq5on8coBLYD5mAB3RYmq12/45M+ddq/IZDLI69E4RjDOJ50JBFvSm7Nc3VE2opk03kkMpF8jKfIWUnBkNtxwbYTCqlPuFJmxma8NrS9LTbrO1Z5/iSJHExhalQyuCFIoHqo79zRkiU+53XiZLCc7W7wydntS+WySRfgel7rvBdUmUxmdyWIrbfytCddf6K9zaBQOH1sbfYrsHo22LV3riOLdtWo3kjOQLo1bVYl90x/mfGZ0dhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27pKZWlTacxYWqmrX9GGxT1hRHdfGOf1Fg7HX+P38NI=;
 b=KNS9aSVX1lM8zNYXNo+5mLaHEkuOSSXFHHRXr+qbDuB+5aB45jm5JsMA72xdNPcnbSdNASGemDKHkvPNNkZrkeHU7IVausj3pohGhVBEymIPs7dbmiFYnfphLUpSBXiwxWxTDfgy/RDN0Mv1PEo2iHUXiyvLMMQTs8SdY6seVng0BjU1KuKhgd80ibDGyVJTu1l4xDQ8rH8wm2//Ozd0t/L8iMtfHY9b8LbNLPTMJ9SXlk2l6sXT9x4GytJee1GBAqxxLWUs+VjmzCF/NWU9pfCEuE5x1rTioMKleJP3+uk9liOl+ewAerO3bhutc21xGoA/qT7B4T8MR6uNzS1HcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27pKZWlTacxYWqmrX9GGxT1hRHdfGOf1Fg7HX+P38NI=;
 b=fsJYJsF0ouH/pZnZJ0fY9elKybmUFdc5GeuTAZ5O3I0vyO9ZjpfPSioD6KhXqMAWE9c1ul0CQtJpCmOkBm7ejEd6vajqThZVaDIYqVq6kpsZlaB1Xb4SWV4ELA8MzfDsKTOhatXTxN2IrDKAo1ZUADgPMY4RXdioUhQ5Bo5zGbigwLGKch/QmVXtOMp7OyPMMVKnjJ4IXanlV7qVxCqRCBbTTTmd/1t9H0kzyOInkEMUf1T5BJ9OhqBs8e8ok2RrI8lWefcTSn7ib9Y7+O/Ncri3H0Dcd2KsYF3Ti5vfc39aZHiF0ofViwTYvBPsGu/D02XrmEY3/mcEQQGe18yVDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 17:28:15 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 17:28:15 +0000
Date:   Mon, 26 Sep 2022 14:28:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        yangx.jy@fujitsu.com, Bob Pearson <rpearsonhpe@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/RXE: Add send_common_ack() helper
Message-ID: <YzHhLQgIK9AlYkcq@nvidia.com>
References: <1659335010-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659335010-2-1-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:208:23b::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 98005229-9b79-4953-5071-08da9fe47e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OioZj6SPn2z3UyvXJBzxf2cQ9b/XNy+DNKM6pnMXP9Smps9BZwC86GsGCH5UXW6u6+REalo1Ww4dibFtq/UD0CxI4snSdHlyRmIzDttqjbR+U5BRQ5204MZoftbDy0uhGVpC9senGR1MKTpwpRK1pkoRKwrdCKwZPzBXa3MjysYONGtDqTFMJ84erEeQfihncVYGZp0zbSEbykp4N6ZuWxvrCyn96nLtxh1tyUxIAY4h5AsVEsg2dL3cGGoxMQ+D1kk19GZg39dPKnycNihSJtK1Gwh1ANX6Wy8llZFcc2xnThZVR0JTOCNsjdUyjKgu79KHZrK+CpRY5yyUCGYhVjiRjbxTfq2boNYECEJ79vwdSzIgaUDICZRfJ/oM/CCKMq4YFkHJWUIwEoa+9iKaSZFqcWG4yk0m155hx0d8lfeH4BDRG7EzPcAQBk9agANW02vuPNYzM3BfP0PnXcETXa1eod5vWn2zgWmBeaH2ib8hRVy45UnyTB31+mQwf5uvapGSCGzbh6hkj7x6upp7DcI5PpN3EQTsxO4WfItBb//vBu2iarfC9VkNIvQsAw1xiZv86dlv5fLby/9dxmONx7vmEPUA3IbnlSCwiB/KtHr82aiVdeuiH3EQKEwFqGBMc+BV1dc0T0vnNYqw3mZWlamyeo9Rcqqhht1BB4+l0VsXnnwtItzyk3yfF3xvv0UmmDERf+8MACRv6OY1phSe7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199015)(316002)(66476007)(66556008)(6486002)(66946007)(478600001)(4326008)(8676002)(6506007)(5660300002)(4744005)(8936002)(6512007)(26005)(86362001)(41300700001)(2906002)(186003)(6916009)(54906003)(83380400001)(38100700002)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B25NJFdstihEk5Mmf24e5ESEeSAbafhvPvqgSIcIAgGsAJuVfChZuM53+TZt?=
 =?us-ascii?Q?6Ejblf3BLYBDnchJh0xDEZmpN4BNUhnz1hZkUC9wLqAUgXq830LI9HrR2esg?=
 =?us-ascii?Q?148Ywbo2IKTNkmdwBKPgbWsBuJAl0+XQx/7pcpwVOlLKdCnFI5F6a23GLTdw?=
 =?us-ascii?Q?z3oVFMGYBxT7ahYLcxc9MwqdgZs11/g0p+G0yN5vVz0aL2B6CpUlKGseDS6d?=
 =?us-ascii?Q?MZui5uTuAL19c0c53kXTm7s3WRHh+i8K16wqAKaMti34znWgpLWtgXjXb2lE?=
 =?us-ascii?Q?1SLO2PKMkrdx7tmo7EmDABiDN+7Mdd8FGk/haM1DfWS+hkZX53HiXi1/q78S?=
 =?us-ascii?Q?QT0ZH1CDtunAUUIhHnkOFBxYwSz8/N78v/E4CiCnYF/wOXIGJZskxLysUnDA?=
 =?us-ascii?Q?9XVC3ZCjQ5bkSujx/8jDyRiYIz5XlRcQQYWQ2sHWU6MB/RSJqRTTlxDVMPcQ?=
 =?us-ascii?Q?SVsma8WXysa9P2CS7zZkyHp1LIGBgCZk+c39br5abfyZt4KCz4KDerVaq7pl?=
 =?us-ascii?Q?2lQof+rMCKysFUKhmMGBj5l1UmtLUB8W2xqOI+aBAGKCEgPC6lK2AJn6e/Vi?=
 =?us-ascii?Q?+6Ti/HBozzGU2Ckje8gDKIw+ankgImay/e3qFrYL8U5jtT/h2K7tL8dlAr7h?=
 =?us-ascii?Q?p+o+WYq0tDRn9est0K6N9NvfbPl8n+vWQKGLuWxLHZ5f5iIFNatAI2l3i97X?=
 =?us-ascii?Q?CYqISwFaLim9CrbLNbrZ8PuX4YKARe91C8vvkDl8l4qfjrmTldMxUHf5yaum?=
 =?us-ascii?Q?V+elizZngL0q8J7nQcTso92SxVStgbP+0O7geTIRxbO7X4HnHkbj6YQXvn5V?=
 =?us-ascii?Q?JZKblC7M76/43grEbxULHeF+DthDa5wa9vg52uYuRELxQcy3mnzUqrDRO9PQ?=
 =?us-ascii?Q?Yywper/vUjxKd2R5q+kxlrPvYkgR56IHd8KrtFaCcGGoOdfJPIBtRUrdoAi6?=
 =?us-ascii?Q?ufO0LQNgueJKFL+ERxfTyjHLVnqsX0360JvHGKKqqVK+Ax3cnuTnrC5U6640?=
 =?us-ascii?Q?wP1VNb4Z7sERWJ250MBQN5fHEg1DMZeD6iP1Q8NW3QQwlcy9nXaSIvm1hKyB?=
 =?us-ascii?Q?Z1CmMp8KQWK5hIm3EWFMmT4S0+OdH50M5S7TJajbgVe7PPMEZRmspFvyu8mr?=
 =?us-ascii?Q?TyrITFPvc4crU2gzP+5UXmWdexS2JJ6AXEm86GtoMniJPMaFRVk8zszlJvGh?=
 =?us-ascii?Q?9xDt35u//aYRDwoTtIHpaRC2fbN8uEh6L92sTpnagIv+xSKnM5qteIrkg6JW?=
 =?us-ascii?Q?KTizp1iwFGbLA6l9OQFvM2fq+gThrkKP8bG3WDPS3So7hyU8Bi8reDRrBXiZ?=
 =?us-ascii?Q?/gNux/FFu4Df/hlo6h8/a0JHD/iQZNob3emhMqN5OyHd4fy5KncLND6LoYVv?=
 =?us-ascii?Q?tDMbk4M3t5dYr76f4HD1ndbpqk7sQbPvCVSkYvmP1+VVgCMCMFfuzs+gGOtC?=
 =?us-ascii?Q?TDyy+dJylblk4XjoqPMahuT7QVYjIJYQOYMU4k0kZ3YtcONPbL0SWPaecZJN?=
 =?us-ascii?Q?botgHIUCl1bzPcR1egxBVan/NGVx2i3Wf4jN7wWduD7JcH4olHzlKgABv/mI?=
 =?us-ascii?Q?SUpmSCWphNTbGpyVh20=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98005229-9b79-4953-5071-08da9fe47e77
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 17:28:15.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2OiMHqBKhQ++KfWiz4OL2TRcJC2qFFbIU5U24Q0lhQWdXbfy03cp6ALp5xg8Wap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 01, 2022 at 06:23:30AM +0000, Li Zhijian wrote:
> Most code in send_ack() and send_atomic_ack() are duplicate, move them
> to a new helper send_common_ack().
> 
> In newer IBA SPEC, some opcodes require acknowledge with a zero-length read
> response, with this new helper, we can easily implement it later.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 43 ++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)

Applied to for-next, thanks

If someone wants to standardize on rxe_ prefixes in the driver please
send that as a series

Jason
