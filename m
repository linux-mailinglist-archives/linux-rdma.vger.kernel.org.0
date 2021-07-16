Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55EE3CBB4D
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 19:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhGPRlC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 13:41:02 -0400
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:40001
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230287AbhGPRlC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 13:41:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2XAc+qyxVS4EAiM6F3bScEVOnrWs6RODcorimZsfJlvpVbG/OY1rado6iU4N/6UuA8uactRay0B/rxBf5A8RBxLlkLqOSjdQfcXe8gwAU6r+WbGPdaRhFv0nb3voA899u6hH6x4lrySRrCuCljinBI4kRxTsTm8wXHcVYBLAccM3uwbN5leJD+zDn8vuaHFPjwTfy2TVksXaVx15E1mmPUO+Hn6fLwFz6zzd7AhrAtj6uUPQoI2LfpNbfYAghlgwM9CX2edl01C6+c7bW/LT9JmZbHH4i7Wm3gbmkOiFfqpjtLyxAzLkE1snXUuT6HfIhewN3i6aen6c1d2wjX5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09SP5pu4Q2nxGIwh5gWfqzKTPaaFslTPBfraspJZjt4=;
 b=CZ0PaQvUlSIECDkB4mW7i/NpjRis5+LgDdc3s+65msfWUUwJiqjjhN1A1PBpvmlt14pGmTXccuabstmNmoqPJUEc/HNkJxIJSYHpHONhzJNQ0DYLuFG6dr0eWtA7y5qT3LQH1pfvq1DTgt1HT3uRPVI8D5mEbXQ/SFOOjlDiu76AOT/sam5ydWf70Q+V0quuQc7xz1AKDjZaUCBwu8yNKkKvg29EaFJNPM3GbLcVN0xI3DJF1K6IsxRM0Njn3c/F+QLaXB4o63hj81frAa5vhcAWrztwrPkYzxFsq80S9pnESGTquXkBm4GGlp7Zf28VuB8KQhFV8snI1rbCXdG8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09SP5pu4Q2nxGIwh5gWfqzKTPaaFslTPBfraspJZjt4=;
 b=b9ebXq/RzrFza15hrb7n0BM0dEm88RMNtnf3gFELGkstMgVWVWFmLnCpyDTuccc6Rrglyy10wiPUWXU4xWmBEkFyP2NyW+dpjIK526ULS+5YV+wew+EJBnhU1snb812udE+n/iCPGXDHY8qGgrcGmeejAVJoCTdMujJWiMvu039J5vVsLzom1MxVcOZKVqng/7COX+LWpCvZpTQvpEmlBt6lBNW2rvOFSAjpz/Hr+cECjPyPLI4V6nXLZY/y6Rk7vD/9or11zpDP025h+vxibUzSQCMnSOEnfcCuZM1+7vFTzbh11nNPUsWPbfaxUJtAm8RS0MP/3DXLxMFu551/FA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Fri, 16 Jul
 2021 17:38:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 17:38:05 +0000
Date:   Fri, 16 Jul 2021 14:38:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 0/9] ICRC cleanup
Message-ID: <20210716173804.GA767510@nvidia.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707040040.15434-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:208:1a0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 17:38:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m4Rmm-003Dfq-Ur; Fri, 16 Jul 2021 14:38:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd489097-5bab-44a0-cd2b-08d948807810
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5047628524315D881B5ADF83C2119@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhIBLjPeyM0RaWm6BiGVifdt4fR/EM6a40Akm4LeEAXBJdd++NlxRu27X4k5XW+i0WequtQtZwhMd+yhoEpcVa4ytewmcCUPDFGAnSZs6Mp4wx5HX/4gMY1SYjhKKbecAZ7IkMuHbBvNAEjXrXgQIORPhrJAu50JH/0kyBy6rfWCNZnW2RkY2D/yym/k0qtvG24GmhGWoEwemjebq1nTFRObbpoKou9kZWRg2+2Uyh23NqlDdUkM8PSL4DJo0VMMNZ/OIC6mwnkiS/XL6bKXy2ypbFl0YOWMGHr65so3gmKB+XzPGsIaeCitI5vioDjFeMYXvfNIGbNevM/2GdqEyORODnDRu2GnMDsgDX9wGWdT1cOhn7srzeNftjTz+hAASp1UcVVCd9E3SKfqXeKCS1+f7x1diNaNealYfgAUzDbZluGRTdOXu+5nAP21JDXDo0uy/JPwPUIi/P+8PXxt6QLVhDGczw5/h9C0yTKgcipaOImP1e2nPg1phws9k080auPzfyrvcJlscBtA1dtLXct9QtQybBQAkZmiD7qdPq/3K+YcsXXXUaRFlUxfg4gOCVFL4hd4nSh5ofWQHBHI+VzGgcDMClhsIZudzVOoChIIrrIOgRcJ9Rc+MxpitTAaCx3Rz4CpwclpR1YI/AJmzhhUKbMHVK08e5RfJ4kZ18BW+zao0mBIzGlw2PPCF6AnmtgEzG5FbxKXb4bC5GeJaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(33656002)(9786002)(9746002)(36756003)(426003)(8936002)(316002)(478600001)(2906002)(186003)(2616005)(26005)(1076003)(86362001)(66476007)(66946007)(66556008)(5660300002)(6916009)(4326008)(8676002)(83380400001)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d+1pogX9GjEjX5OpE5Bs5ASYaPpqSrxyGoHL5mFne+ZK1Bv1ZuteNg6fiGy3?=
 =?us-ascii?Q?rD2DKpIODWwxDS96jby0OUJFLIR9lYKax/sP8A8Xq3V03SNdrsBo7EQD+awq?=
 =?us-ascii?Q?aPF9FWlxq4g4BJ3QeQwYLloPz5p2A8QZTTurDgGfkniad3Z+K5y3UpG/Zj49?=
 =?us-ascii?Q?dfV8KB72q+ceXUY5RgYEvvHzWsdyopmougydCWy1td0EQLcE9KnlyKtt7+n3?=
 =?us-ascii?Q?Khu7E4Gp1TQ1datt0beCOI/GIr9jDU2pIBw1PXDb4mmGv2QUIsqHR//hKftO?=
 =?us-ascii?Q?BZ/YW/z5Lh8aZmU31z0+5gVnyAfsQCbcSopHKZsAsugUQs1o88jGIx13YIKg?=
 =?us-ascii?Q?b1F/llah8f3M/wC+aTmcDyF49P77pZVJN/67GXWetYNJCxG8g0gZOHHxgwb+?=
 =?us-ascii?Q?xvMy6MEmgkisYiP3c1Ciq9agDdhXx0DoerYUzFAt04jNpWG07srYg3hqqMzM?=
 =?us-ascii?Q?BRR2iAKaNpGgus9j0fDeb60Fxa0FPQr9icAXkUdHgm86u9rvj6eqRXBQiG8i?=
 =?us-ascii?Q?RpG0h9Zdv6s6IXtuwjIri6RY1lkDYtcGemWhjxY859dEOU7Jic9YqyXF5Ij7?=
 =?us-ascii?Q?DjN9SUgotC+sCRBurDR/gAH7tPQrO+iih6R/NUs2MAUzZsLd1z63ac7HmeTq?=
 =?us-ascii?Q?C31EhD3DtoNYMVT+LsHc4bMo4q5bGG/SzhUwpWZms2bpn7KJhuLKqea1MqLY?=
 =?us-ascii?Q?qann1baxiKffPrxaUhoMG7krrpIRR9e5GN2v9pzkI9XQlPhK8OvdPqhomh+U?=
 =?us-ascii?Q?HThH2qGsGBoCD405Koj/a3061KdqXKXCClAxBEin+iofBKgVEtKpFvPsUbJc?=
 =?us-ascii?Q?JcruQxrJMvmDRDeorxrYfKk8mS5xaskmjY1S6kAKg8Xs/YgqrdjF7OAYKFEj?=
 =?us-ascii?Q?i55CeYoe8SrIAaa1nq7TTx0PjJwNTwhuRCPz06DNmqxClkPtD0UA17ATCZvn?=
 =?us-ascii?Q?TrciLiEgvsSif/JbfV9vXhsXWNeIQ0M2ziPSykt/sbpHUR1ENah74Wr1k6uQ?=
 =?us-ascii?Q?pxQee/GPXdVhH93EzjX8XKJlZWrCUmE3PvgjPxWZlc/TTcxhDnYK/jg9ZkCz?=
 =?us-ascii?Q?nYfDb0VSQyEmUt7cYJKl3izOQdLkSGmDACoKa+fzOKCpKXQSUk+H+sbgU6w8?=
 =?us-ascii?Q?Xps78Zphqg5/CdFTnpYKEXMeLnY7cgTBAZSFzhERTWrHocDuzzLq6NKUTbNu?=
 =?us-ascii?Q?04Hy1ZtFJ7g28osYFOxgj0MnFt7hSdnKnuEgzvbCWnAHMUxuexBbAaSiDrG6?=
 =?us-ascii?Q?6jTPUCJACRG8JorQRYR+Ijj3wjt56JFogPwb3rqY4ikebSvU95GuT9RDH/PN?=
 =?us-ascii?Q?uyT1iYfyOAyKmB5+LX5yeW+/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd489097-5bab-44a0-cd2b-08d948807810
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 17:38:05.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DxVyciEVnK18oKRVTze1tIIBYRGwPIOqQP1rBCpA6/TjxeU8BE3jswnUHPBLZxY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 11:00:32PM -0500, Bob Pearson wrote:
> This series of patches is a cleanup of the ICRC code in the rxe driver.
> The end result is to collect all the ICRC focused code into rxe_icrc.c
> with three APIs that are used by the rest of the driver. One to initialize
> the crypto engine used to compute crc32, and one each to generate and
> check the ICRC in a packet.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2:
>   Split up the 5 patches in the first version into 9 patches which are
>   each focused on a single change.
>   Fixed sparse warnings in the first version.
> 
> Bob Pearson (9):
>   RDMA/rxe: Move ICRC checking to a subroutine
>   RDMA/rxe: Move rxe_xmit_packet to a subroutine
>   RDMA/rxe: Fixup rxe_send and rxe_loopback
>   RDMA/rxe: Move ICRC generation to a subroutine
>   RDMA/rxe: Move rxe_crc32 to a subroutine
>   RDMA/rxe: Fixup rxe_icrc_hdr
>   RDMA/rxe: Move crc32 init code to rxe_icrc.c
>   RDMA/rxe: Add kernel-doc comments to rxe_icrc.c
>   RDMA/rxe: Fix types in rxe_icrc.c

Applied to for-next, thanks

Jason
