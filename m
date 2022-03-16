Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136744DB1BF
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 14:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352902AbiCPNpG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 09:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348443AbiCPNpF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 09:45:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0065A5A8
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 06:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngo3HxjGmCGwDeCsYN455fEtP1HQmJtmDbScwjK8/P5K0YuTxLTVhyiLNyx8mgVd+Ueegv2IU0CVGweo1hiZJ31G2CuDnuYhZm49GRtkE5NOlGc1CweACz4aiR+3K90dVhpTKCrgb2kalCIZEEdIzSUrncRR9mwPPJfFmYKaohYsCRymaLzRV5wCb8RqFFf4Wq5kByJf3oEWje7gjjs7n+p5X/gh3u5ucOcBc0AfqC37hTsJ0hSvDbuKYqhtc24y9TW17dsLlIRnd4cVOuhz+6mduMm/+sW/0PzFhfnEaQHL0hRjgKsZIdVMRWZeOkVO8uxawFcHMEBoQUtw/IwrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY2J5mOpyJITEYm4F4ooTpY6Q6ognRx0SZ/GE8zQa4M=;
 b=G8OHy+yOGN5T3FPqduxxToHK2G0sZdKMhn9TsnBAR50EVA3T1gse6wMVDF60UTb+t34/Kj6GTVK2r3p67aN4XQNIymlvQkWRg1OQNp7YfGMfxvCoFi2W6f4BHNMHDZxXY7/SPzRTh7soobsRz23VsMr27T3tO3tcvBNareizg8uyPXb6sYeL3HceaMss+jSa2q7yoad9T3V4G2xuOCmVsRbyQ2+66YNMvtgdMtaxVjxXMzNL4pgmxJDgXkdLQRrPWoVpBHKwdoNUX9Np84RhsL40B2sYpwAQcGnQhby5JhNWgCya49JG12C+uuoc3tW8EYBvF9C+aEk1XHXwBiO5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY2J5mOpyJITEYm4F4ooTpY6Q6ognRx0SZ/GE8zQa4M=;
 b=PCm7DH5fe/pLSLLplsKoMJgR2HAc7DL0d41jU5y3lbRvHz28mYKPZUKuf9ZHskITenSzaPgZLKLM/Ngozys5Jceur6bOmsnywsZnhWG8/zHZwoHlThwMQAKLQ5NfnYJzkU4nOgE59ptIzcYBCbI586WGlN8kpNPJ89wSrYBK0Kzh971PDRgPCyIaSGOSCIHl5wI4RtLGNPo4D356B2O7MLZ0bUjMrBwEVT2Y15MsUi+YVIgfLNslnJXUUDGeXaejvLjNLjrGp6sq7j9NPpN30XjMFVk4UY1Ce0zKIQwMaZSLBndSm96lveWtjM3o2L39B6mEPRTFu8TOM3vRjMEZLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2886.namprd12.prod.outlook.com (2603:10b6:a03:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Wed, 16 Mar
 2022 13:43:50 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 13:43:50 +0000
Date:   Wed, 16 Mar 2022 10:43:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 11/13] RDMA/rxe: Add wait_for_completion to
 pool objects
Message-ID: <20220316134348.GE11336@nvidia.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220304000808.225811-12-rpearsonhpe@gmail.com>
 <20220316001737.GW11336@nvidia.com>
 <1a6dab91-b178-6761-151c-a048511bd827@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a6dab91-b178-6761-151c-a048511bd827@gmail.com>
X-ClientProxiedBy: BL1PR13CA0313.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83ffc1eb-139d-42c7-1f84-08da0753007f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2886:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2886D1F7CC2A9F119F99BA9CC2119@BYAPR12MB2886.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76QFJCqWFiBTDgyWtu5iYzwMvE+AALFroHsnOzZjHO9ZK5O/dRBcZVcg02qtE5dWdefN1fcpsPWwzjLjG4Un7WC7rHuIGrnwqsi2K0ZUjIwsg1i/HspDNrhrE6JklHwHgTnhgGQdkzpmJWqj8GNTqDemLe5wkd+vbabhShdV4oteIcbVn++gJ/+iS3gMUdAZUuANAVUMIfpaj+ULn9SZIk3Jwc79QibNQTlx42ZUlOtInPTe/Dtjfv9WOMl4nBW6xu7DZT4sBzR2o5JBJB1pWfI+U+FtgbI8HJJBGmXnysQ1KL8oms45shkI2D10FtxUMmhR9ig+2wszpX4yKzJ6wv5Yo674j5u1rzSydGVCxOwP/H4djJY2GW47tOOqHdZK8Kj+N5uLo5lTFYZtG1Fh9H6akYbAQPuBvpSa5f+fF+IrRkCSlz275EnE7t+QWh5a/yNH6ci43cDIaxmxk8V1jFv4alQOHIBOTDcO+OdTHHnp/+VCPFAunHAEIjcKkvDxOVV0YwSf/oHBDb6vHH/S9FQ4FtdiFgG3I6LjvT0x66ZFR4eP/ctF4Hn8PO0o7ey7yIaPcxYWvszjkexsxY3SFGxf3JJqjJN1YHzAsk3gFy8sRGYYSOiNiD6aLc15knuT1LHJDbrgklk6G4jNBtd4fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(38100700002)(316002)(83380400001)(8676002)(26005)(186003)(4326008)(1076003)(6512007)(6916009)(86362001)(6486002)(33656002)(5660300002)(2906002)(66946007)(4744005)(53546011)(6506007)(66476007)(66556008)(508600001)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rgChFH7WoqCaEOxHY+ElS0azEjqQOQeV16IhKgkDNI5izFcvEwuPDTzUxzIs?=
 =?us-ascii?Q?b7WG9lVhy48ZVrlQr6VIm3VR04viIhTDNkpZGbV2qWRdNRE5qnupGQyz43jx?=
 =?us-ascii?Q?3C3SXqMOcGuuyCPX3BNvLGxGRkSPvmXGk2t0tFCn5CUx79a6ryu6O4RmDsCK?=
 =?us-ascii?Q?YmR2x4hYOn7iOYU9/9v9eO0uNQzWhgEkcRgJdOK7XIMeHFZMBw85P1my7GSe?=
 =?us-ascii?Q?7y9pkIi+PV1QubXN2pbxZm+WC1cNuVzYrMMonwettWjdmkjJ5WBQTi5iLsZ2?=
 =?us-ascii?Q?8KIfjown+HYo+kXKzsCquHL5nxfUuYZ7L91hL/LQZ5jfdEHeeLIQ/rK4svYK?=
 =?us-ascii?Q?c59kaphdIWrkWvLZqnAymQh8//yBOMIBxrRvhoTORzC0DW3AdphiPDssKum2?=
 =?us-ascii?Q?gOOZW0Fkr2yr22GJTcMzAB8BarrWlQN27l3XjFlZFnUe85eeI/tk1/tR7Gsb?=
 =?us-ascii?Q?/np+uK6dsU4lOsMpaEE4nKEiNvVqHDSQD7+rjVDPG41lCIoYN37NDsVHbfB5?=
 =?us-ascii?Q?cRGP8ctdWdqG29c7Nfw6Yc8UKspuLImt5jXst6yEtjp3EJRfJDuC9lE9cNA7?=
 =?us-ascii?Q?IZRpfdnYVdAYmJjX5yfGWA1GrEu9w2L+ODh9yhCcsIP06ICeapIrsScWWIsE?=
 =?us-ascii?Q?U7qPrvkCqbYW1IyXoHW0c+Eggplm5uGaWvMoJTwP+Jv3Yp3+1FSN1X7ebWQT?=
 =?us-ascii?Q?SNmFE+Fs5yeGWYDRh3gF9SeUueFGaelIf1kNLtgJya2f3zcqAk9nuCscEQdO?=
 =?us-ascii?Q?t3xzsYEJFbcg6ciJeEIJJ27E+aLRDe/sBDB7L5/THzcdX4l3Zwb+Vz2N+5MW?=
 =?us-ascii?Q?Rr5QBtzlYmudxFt52MxIWFxn/do0lZ5vyhrtG6Sa+32iXxX/5fv4TQ3TzVxI?=
 =?us-ascii?Q?cKmliF+F3+kv5pp4T2Hnpg6sHXa/GQ7XQYJgG5A50pNM6Vx9iyGBWgC6ydxm?=
 =?us-ascii?Q?QQ1OzzTY8QYSa8XRtolalhty7ehGv6DYYaT9Wx1YC3So6vDSzLPFV+jghY4R?=
 =?us-ascii?Q?XdNZGEAdOc+JfzTq6C1l9efg86DzpaYVK4XTR7OpsoTMluCk6NpAcqinXnaw?=
 =?us-ascii?Q?IMHCnDQjR/d3nOcZsJK/d+dwOf1WZKRR9fBbva0IiXX+KOApB8C6sSa/e5nL?=
 =?us-ascii?Q?OQOXLmk7J28jlvJpCPOOdIL3S2xIIrsOtrCEmkKoPR1jG0+mI2//wAOgicTj?=
 =?us-ascii?Q?0l3FUmfE2jDfeOybfVrT4lLGR85Vr3GXYXVRVx0dzIQnY5UHMwVNA6Gm9nk+?=
 =?us-ascii?Q?A81RhI8v3t69c+0kKsRmn9NQNvS2JMdIVn3WNlNX/7hNSf8YAH8GaKziH9qO?=
 =?us-ascii?Q?cQ9x8C/1CCiUWeIwN2sov304y2j4iQ7ExBUvuwM+Gp/xOnSITdeZWHTxzq9S?=
 =?us-ascii?Q?648j90kLeGxgeOlFoxL/tkpIjgF+AEhruXQ3Wkj9iv6Gc//jELE9c6GGpT4s?=
 =?us-ascii?Q?0nL09NizONj4LzsBLeMBq5QGTERSGKOn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ffc1eb-139d-42c7-1f84-08da0753007f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 13:43:49.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRNLV7fZkgEHDM1UHweZRIxI5UVi2GgXvHfu3X8SaNYO9kKXciNCQ0v6g3DYPkHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2886
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 15, 2022 at 10:57:20PM -0500, Bob Pearson wrote:
> On 3/15/22 19:17, Jason Gunthorpe wrote:
> > On Thu, Mar 03, 2022 at 06:08:07PM -0600, Bob Pearson wrote:
> >> Reference counting for object deletion can cause an object to
> >> wait for something else to happen before an object gets deleted.
> >> The destroy verbs can then return to rdma-core with the object still
> >> holding references. Adding wait_for_completion in this path
> >> prevents this.
> > 
> > Maybe call this rxe_pool_destroy() or something instead of wait
> > 
> > wait doesn't really convay to the reader tha the memory is free after
> > it returns
> > 
> > Jason
> 
> which is correct because except for MRs which are freed in completion code
> all the other objects are just passed back to rdma-core which will free them
> in its own good time.

If you do as I suggested to put the xa_erase in the rxe_wait then it
is much closer to destroy.

Perhaps 'unadd' or 'isolate' ?

Jason
