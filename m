Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99AC48597A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 20:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbiAETuC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 14:50:02 -0500
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:37984
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243724AbiAETt2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 14:49:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz8s1OTkMpO4AiZ3mWjTd61gGQrwyVaY1yDJRG6RTc22x4qHKjQKw1R2j8HSCaj/MY4fRRf/CSTK6iQ4L8tYncHKOUj/I7ft/rUrDlWfcr/uEDBRuZk1MGLVMB0bUaRAku97IXg5zdc1MdfRsp4CjoHCJP8dBsdNSwZGBY64cL1cVdJ9Zp8eqPx0KmCsDrveiUGVwV2mYBFdXNSbK1Y3aYf2+FqcxoVLZQgNHE5O5B7C9qBYOk3DENUzwhOdrLPy36tCf0VXNZLRMeSIgOaFkMgmZmOk1Fdybm0UhmBkd7r9tACLVxttnQCKrhnYxmmgutuKZ1J/3qRqh71TIi4Zlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vNzlox9a4yVrCDa3hZ4s4qpFzDzTP8vgP2m8g1piHk=;
 b=NCui/TApHje8gPfJbc9FGnCtvryV9JkJkQ9eugbLVvPzpCv+rULiJWGBzHwiwvR3QJ97Cz5Frdi30YmALso70lqDRoUlj6psLgAs91SFE9lvYV0yb43xW7EIJZRYBRdKr/DqzxottZMc8lQqnZ2M5mmBZZ/O/kFRy2/VK68TwcgWDxznXeS4DpAKXY68vTT8EDObPy9OFImFa86iBVl3xKG86mywsxL95DbWIoVVEo3+U4FkY6yoGKF74oFX0m0i1IWG0jPALUzQA5KaXeTdC+T0oF3ZfkonJqAsGrxjhP89A8L4gVixHTbMf4rkVDThk/2QoZvBRHOqRGwehfaS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vNzlox9a4yVrCDa3hZ4s4qpFzDzTP8vgP2m8g1piHk=;
 b=op7Oa92NshLCdxgKD4xLtAGehjA/crqsE7MtOtZU+f1T5AJu8gx+c37ZEJe6Bp4lmSv9/YyHdV+oUDJIOYbQy3ltNULJe53XJSeOI46Gh1k5f6EtVuxmaIkIJTBPBsjqZABvp8V2rmaPBzMf/lLsJKIbAfCRc5rvlrC2cBxQEKPQGmrN27s2xGJRzQ07MLAd2K0jOe0V/PagqmKb54a7Vq8qu3SmLMfvLIshUECKzqPeOF6DR6Ld/M0nCh1wbzg5fPMK79XGISZIQT9ULRJz2+7YTCMHpwZsftoCDJv7kJeadu87GKCk1I+D5ZxXuYw8GSBjxsqxkc5a4ts/W16RCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 19:49:27 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 19:49:27 +0000
Date:   Wed, 5 Jan 2022 15:49:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Delete deprecated module parameters
 interface
Message-ID: <20220105194925.GD2872048@nvidia.com>
References: <c8376d7517aebe7cc851f0baaeef7b13707cf767.1641372460.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8376d7517aebe7cc851f0baaeef7b13707cf767.1641372460.git.leonro@nvidia.com>
X-ClientProxiedBy: BY3PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:217::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 552c7c5c-15b6-4360-7c01-08d9d0847b54
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB503192E8FAB2AA820DF43557C24B9@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Id+ataePwyfohOq18u6Uf4o/33C2a4UwOJYOGBAp17QkybcXYFi8G3DDwQeg8NTIposst0G7vmN8YoTnNioSfVY4RNCRz87ur13biLuBc0DwujyNPs8mVsy9w1MNCzJmlcpsHS7jW/jYOAmW4Wtjv9TrCb9V3513JQnyUEfLOwBDREEHRf9JnXHG/AyMd8ER24GPhyi+RshzpJnR+OFjdfIP3XAMfNe2D8rXvb5Qcy+T/Xp5yOX5A419R9n+rDnjpJplUEioyct2uVPgTfHqIShWpR1DCCd7sFmgUfblolgK1F6LCWeWmvl2cLZ2QLG0T6EiCiCXo1jdWmezENirSNCdHqqewknUWylQfHtB9FXA9siiV54MVbHynDza96sYJra6e2PNEDVruQj6wERTR9O01yLxMRrIPno7+14IwzNp4fBoDFaeVrorpg/XehHWAGMaXvlsOxI6RH3MuWPxgTiVww9bSAanWUqlQP2hdDaNXyMV4fz3/ZpgTnuu7xFGq6oAoYm0lBlYqV6PlF/i6lOhck/hqj3bvBxUQMCow8mbY9DcHKVRaUFRHypeQ/5dtK+m1QhGjSn9oT0khuOqgeq9Nl/R8OACkiUfnDC/70znOZiZ66oLQo8dPbdv/dxI1X2W/6Za8InPCRE3GACboA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(36756003)(8676002)(66946007)(508600001)(66556008)(6916009)(4326008)(2906002)(186003)(1076003)(26005)(2616005)(86362001)(33656002)(6486002)(6506007)(6512007)(38100700002)(316002)(54906003)(4744005)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?naGpaE3FjxbFnxkgS0bPQjHG5ihsgGH5T+M8rCArSZmWrNpdMzOT7hbNQDwu?=
 =?us-ascii?Q?fm9Y5BfZT7j4crX4FdqcP3uYL1xTuRCbITCy3GJmtKKVe11PynBSOVu9jWxS?=
 =?us-ascii?Q?1GyMOJ0WN8EASeJsBpKy7wkcmYm413FYbZkb26/vwnshpMZeP+krg2Mj/oBJ?=
 =?us-ascii?Q?mVy55uP4rjvm1of/ZIh7cpSiUzAFibvUkvVqJvZD74yJPTYPbAgznBEuK7Bv?=
 =?us-ascii?Q?db4n/ejFX65fNF59iMZExV5SvXvw8uS4mmTYe/Yd1myt+IDaPkibdsPyB/10?=
 =?us-ascii?Q?5PyYEbe7t3axNZnpIs73zpa1GHeUGsNyI5ykAgxOkkEiHrFJUpHmMxMrUfSt?=
 =?us-ascii?Q?aMFeauw48l8cA4FnmJs39P8l7aG4KpwU+Rz+oJp5x3QVJxGE6EKG9oxTz48q?=
 =?us-ascii?Q?7vpXmz/YA7bKN3uVQSm6mUDPseU8P+GMF+JtqsCcziZobJennJ3ki5iPs7KZ?=
 =?us-ascii?Q?+oX2Z6b0Magh4y7k6C6+3pZYKoFK+aze5gvwHdZB/7AeXIcra9Jf+YIEbMLd?=
 =?us-ascii?Q?mrMoB5eavKhWufr/PFdF0PsXh9k8dRZjxukB2+njXzLJGeJ9VGbDCSrR0KUu?=
 =?us-ascii?Q?6Q+kIARNkeHWeTrUSTTniR1iqlq8Vp9954wgCG57zqPii0otHW6mKJC9vPhe?=
 =?us-ascii?Q?S+Ze1svRczYMqUu4bkW7tk3BTp3KmbXoAwqeAyYkB6D/S1C2IQXIWDCOfZ5T?=
 =?us-ascii?Q?k3pdIkuVRfZjROxxiUdlf7kMJZUjd2ELKUnjylRe3fth9BIUDouvwXW0i5Ch?=
 =?us-ascii?Q?ynlj0NuOldpvhxPPwJ47OT7L/ycScrDPQz1pIxPwZdYldnNQaLgJdDHBplL2?=
 =?us-ascii?Q?55IZc37hyRqyf6O08FElUr4rj2dsjWitHXMfaVvteaYgghCGgUhwK0PCR41/?=
 =?us-ascii?Q?VoTqrfIBHe4zTSvZDWo9p7x310y7/TWLErNmFgZj9Z0nzp0P3zcCATo0LPcV?=
 =?us-ascii?Q?OKulabcHz4uDYMxLJa54PDCNX9RE8GKFKG9OWQ4LVWSAeiAD89y3e38QmBbm?=
 =?us-ascii?Q?v3HuyN4N6Is7kQhnUp4deq1b42j6MtRNfo1BkwoMa93P6yNzM4yiDwvq4clB?=
 =?us-ascii?Q?M19dvkY2czepMRcmdK22TK0ZH/uQBQSc0XRW0RmAcB/3lH0sr2jhUzr8l6ch?=
 =?us-ascii?Q?HevHC3LSGrijf0w1b3YNDxp1gxTEpr6dxGOXs56SnwAHziIU3FhmnGknzhbg?=
 =?us-ascii?Q?dwMIioRWcsI6K3vyG1r+qlxt0RZ07NzdBdNte8KC71/iaitEapGtTbpCJVAB?=
 =?us-ascii?Q?KkQfiK4jaEuCgBA8AZWqfkmNjTSU9hJReb6Kcg4cxAkTMSPSUuAmPp66klFe?=
 =?us-ascii?Q?JWQiWPNrjwq7hQ9+JkSXyyEZbWeoESUUzd9DvEU+9Pyp0FWyOpf2cNIPr38W?=
 =?us-ascii?Q?8jIHt67gkzhnx50T3BOKUMI07knI0vX8VFwHO08wq9y6WLs6GKoUu1ppfbfc?=
 =?us-ascii?Q?XlnBv9pfhW1cnpUIOD+Zx/05ECwGrrql9nJFIikOPR7y5o5FGHZSS08ngiEC?=
 =?us-ascii?Q?/4qff1+a+O0EZYbyc79wTAQS4/7LDEFTNZm7j5Ed9AFaFMqJ4sMZEd3SyP3r?=
 =?us-ascii?Q?Ot35MI7ngtmRqBp3t44=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552c7c5c-15b6-4360-7c01-08d9d0847b54
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:49:27.5217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pNovBvRwlXcTajm2Qr2Pwtb2nfXvkoirVVTmefs71xom8EG9858sTZK5NTnjdmN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 10:50:35AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Starting from the commit 66920e1b2586 ("rdma_rxe: Use netlink messages
> to add/delete links") from the 2019, the RXE modules parameters are marked
> as deprecated in favour of rdmatool. So remove the kernel code too.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/Makefile    |   1 -
>  drivers/infiniband/sw/rxe/rxe.c       |   4 -
>  drivers/infiniband/sw/rxe/rxe.h       |   2 -
>  drivers/infiniband/sw/rxe/rxe_sysfs.c | 119 --------------------------
>  4 files changed, 126 deletions(-)
>  delete mode 100644 drivers/infiniband/sw/rxe/rxe_sysfs.c

Applied to for-next, thanks

Jason
