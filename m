Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB84C722D
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 18:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiB1RHO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 12:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiB1RHM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 12:07:12 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD078879D
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 09:06:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUsi5/y14QaxG0dYrfrLAkkKNDy696EACqLeEZcDwKQbwhXWnkKaTWxSnM9H2EeqJKIR/ONraNWGe1dPG5wZnKvtQBBBT+B9emuDJA9FW70F2p2DAcWvNxO1YUEp7H8prXX+HFMVIJCOPLa61cq0zmGAwOqmviba4VNIAVTqWY8s23ehJJh0Q1VFy4/K3jN4DCi0DX+BMZEBG6zhf9SXCVSll3i/SQyG412tEVA4Co8eZEI/w5Qp7b21csPaQLXjvqKanNAVT2419s33Ml5O1cJksxfwLrR3oy+DGXew8YNORcLQXBJPlcfNxUtTxIDTDiHt+0H6WvQYGsefxO+O4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx2GpQPyPL5jUwu3/QP4gbwFihm4tZp1t+2bqx9YUzk=;
 b=IAiX0sTqOTJmOnSRyKfvY0z0syBLgyt0+hIjYZV+TT9vgJ3c8wIxu+fAsRy9UUt3e8CSRZAprGc20NOgsF1AnK0IdxhXFn2k00aeR8i7xdv2wJD+qmeMB5RjNmHNueo0PhbPk8CszFk9/6FqSsCjCRFawUzeN0imUSGjwyiKC3fRcAeykwFawb22ui9376gNjGvQN2JYq2ZQsb/SG5l+Bgxha8H7vnIkC8Z7N2EfqHio6jNvYSo8B17rTEAxfYtAzispozA/SLeu2rYO8yAn859k+nWxtA3Km07uEYIJjmNT4gQ2vZLrKRaoBZozFL69dix5ZsJQWo5mQ2BVUp+N0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx2GpQPyPL5jUwu3/QP4gbwFihm4tZp1t+2bqx9YUzk=;
 b=AMkLEFlNIOF0JRYzU6dLmlEYHBiGJ4XiHKU/6GsW/QljJ/oXXmNW01gu6Mgf5Op5MalvwFfntRriZjn0LMU6E/nz24zFPbeN9zTQeRVV4DKYrWTlahq0KHa1XJWPPpLIArMh6A6y14t9z+6QU3cf4oN+WUar1AspLvZETF+r/Rm07yyL10lPidVa3mA8L9lfEbH6oAXHAaJu3bQOjpYTeUku6ktVl3jN618yOseDljCAfeTsXBkObFI/dnqdZNaNudqtQ+43Cb6Atj+We2RNAkG/mvnMWh1+FVLbHuQxaf22F9JjiJQjQQJstRCCT0BIxcZtwB0NxWPoZLoe7KTcMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 17:06:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 17:06:28 +0000
Date:   Mon, 28 Feb 2022 13:06:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v10 07/11] RDMA/rxe: Fix ref error in rxe_av.c
Message-ID: <20220228170627.GL219866@nvidia.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
 <20220225195750.37802-8-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225195750.37802-8-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0038.prod.exchangelabs.com
 (2603:10b6:208:25::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff3c231-f10e-4377-e8aa-08d9fadca8fe
X-MS-TrafficTypeDiagnostic: MW3PR12MB4475:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB44759DA1A7CC406A13D5E460C2019@MW3PR12MB4475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJZqckAhDmwBBqBYTZ3VM5cQv87C2HwyJy4Ph7ZvjvHsjMFrjBnGipX7AzcqosGNq/GXuaMNUz8NY4MegCxYDPYYTgLbI6Agyj6miaIf332O2sjxBW6Rjma+jT7Klz25hp34Tat15YntRsZztYUGLsOqyVKgYQRtRac+afXCEyIIVD6ete8TEUE2wI/K9bwaDmhC/gNAJ2swjb/EzGGxq2NWLaKfhFkxlJKgnORtIND3WNiRN3P5ZcX+F/uftX+uLZd6EIgKtfR6AMg/WyiCWOWhPOhRH/hHUqZe7+Akh0ryWpVE2OtdNcanliOtiTpCUT1R21SyQJ9RQT3YHh19PBrBDeXFEsdNDRgRKaRosN1yZlkdBLw9A3lLJrlQHmqIkOMenAuirGi4cLnvykRO8FgMR3kaoHWUkew2oharqCUPt3X3sbz37qFx359i6dkWcCDFNwHi7DzKKgPoSGREiqAM2wjwUridWkndeziYzLGFdELJ/2B9Q59iih9X8NQQeRRMenMTTQp29K3jQO+DzmXXWw2eLPpIFPsyLLxdX1/CBurCvO+TUkEW3/prwnmqy93J7TnpRHNeAI6rwDUg9C0Ufm56bISEpkIF3tYrVEklPIkkUHggc4qb5wPrUcrRsgC1iqfgLMrclf1nkN21XMC0fFhoW/N77jZYErnK1b2jMn0BpFvwUswWtICbW4wupQtUOzAEVcgiA8GnHwWi9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(4326008)(6506007)(38100700002)(36756003)(6512007)(83380400001)(508600001)(6916009)(1076003)(316002)(8936002)(86362001)(2616005)(5660300002)(2906002)(33656002)(4744005)(186003)(26005)(66946007)(66556008)(66476007)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQFtW1DnvkJVwki67K//YWEtpneCAYkf0q1pkgx8XbKfjXWz8gUEZyWpHcVQ?=
 =?us-ascii?Q?0eNoMkuPY0clp8zLrzKP6QCp6e59D7F7vhG4O3MB0Vt5WQCmQRN9z8K0peX8?=
 =?us-ascii?Q?wB+mVDnDuMI5CQgNpXXAdvs8WFeQTTib/4WmDYRM/2nLU4i5u96iPOOiJlU9?=
 =?us-ascii?Q?k+MEpPzHRLhR/Q5s7+WqEYTcjabmww42ZvkAqgZeq4ESesa6ohljdbmg8fx/?=
 =?us-ascii?Q?bTF71b3xI7sdVcv8zXse3BC+l+7Lj0q2dmHQe9MTUuiycdUOcmExfZ88fu+N?=
 =?us-ascii?Q?A783l/DHSzyuwSStNvbrETKeefVtZ3eepCbXNzxEWEg/t6zedhiCUB30Yrgp?=
 =?us-ascii?Q?lS0iQav9rbMTwgRJGY9osRtyGGWYqIcFfkAqPLnqAj9EQ1VRRaySxdWmQ1oS?=
 =?us-ascii?Q?s7xBe9cdMg/Y2m2LiPZ3+KqGvTdNukx/gnrPwEVDnnU0uIpVWI45r3ywwSZH?=
 =?us-ascii?Q?iJzHU4gq4F3q+w6lXMMtrFVYxGCu4dmvzV3xmamUU/badi3jIrREMtO/d+/q?=
 =?us-ascii?Q?13WVlr6o/j4R7f8RsMxPgvHptqwKTCCKNV/ev/NvVpIDwtg0Lr1PJMl6DzFA?=
 =?us-ascii?Q?FfEXkxYZDTGObvk4uoHXgxEE6Qkv01IVTE8zax1j2Zqi9/Y57+C8DN9vULf/?=
 =?us-ascii?Q?iCiY9wVAMydL89KwgWsDc2hNVBTEpMbKkZLX0k+G3BzlJtMa5nqUfBgXek7m?=
 =?us-ascii?Q?IsE3vtZ6mq+jjtR1bz3R/CEVSBdZhc6m8FvrCmWoVf3TCCUBDGQsRb1LmDcj?=
 =?us-ascii?Q?zFZjtDtBla2wd2Ab7k2Qw3Qbfogv+xmCbfkf3B9HeQAds/o02Ho3KjLwi5mt?=
 =?us-ascii?Q?4+GP1aszmARjVgRtGG2eNFes3kFRDYK7m5rFnU/sr1p5jDWg0QgsqJYL2iQO?=
 =?us-ascii?Q?nnZ32XnO8BZFgU1fyx7v3wcOYe08GR0tBjy1z+cY3Zjn5UFbPlgiGTTJmr1d?=
 =?us-ascii?Q?ph16ioMHZPZ00HlhSytvmIzxy16lZFoXml1xYski2jWoqnmmwlQOJY8H6OtF?=
 =?us-ascii?Q?EBhHglzFbTJCpyRTd/GiXVIPBBX6hAeOfTq0D2iC3aJ25uY3amJHmx7YmU+Y?=
 =?us-ascii?Q?gDb31R/16/0vrKS9wndcvMdawIsAqRqp32CJjYT0dGYKlUdtD9WvWDpA1+BW?=
 =?us-ascii?Q?7Mk5I8CIP1rU4yuJmGX9iwx1ExdoMJo8br04uCNDhaR32lYq7SrZA4jN1lJh?=
 =?us-ascii?Q?2QlBfVRi5abWpQU9hGkht+smPs+YmXaDwd/J9B3J0i3mgtEnE1j/c9Owr1qH?=
 =?us-ascii?Q?dy/PoouJA43fBFmCNCOqA4G9deija/D6XbAQm0JqUzw/G7SMCsyCxaf7bgbk?=
 =?us-ascii?Q?usWIAuup30tkcwga2p/GTqmJ4DwOiM8hmv++aNxAFBA7KCikLii7BRWzKUU6?=
 =?us-ascii?Q?eoXb/bZQudo+eRvvE11j/C4PpKavdeRj6p8AerD0ay31nuz+UgJ5rhfmeZH6?=
 =?us-ascii?Q?YFR5v7bc0V8yV/5wUy3srQiJFs3IojYfT6PpxkgZnHstsfA58fOS42ER9dq+?=
 =?us-ascii?Q?wo5dV8PteTYBt5EOK7zmZP9IEaRdrNAqRhVAzhKxWQwF5kw1jC1s92DiUW6K?=
 =?us-ascii?Q?Ffc6d1312VUJ5FK+crw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff3c231-f10e-4377-e8aa-08d9fadca8fe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 17:06:28.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A54eHl35+wBzl1VeiyiUo7OdOubgSXz71UcmTXn0aPn6izzh4vnDuKh52VmWuY0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 01:57:47PM -0600, Bob Pearson wrote:
> The commit referenced below can take a reference to the AH which is
> never dropped. This only happens in the UD request path. This patch
> optionally passes that AH back to the caller so that it can hold the
> reference while the AV is being accessed and then drop it. Code to
> do this is added to rxe_req.c. The AV is also passed to rxe_prepare
> in rxe_net.c as an optimization.
> 
> Fixes: e2fe06c90806 ("RDMA/rxe: Lookup kernel AH from ah index in UD WQEs")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_av.c   | 19 +++++++++-
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  5 ++-
>  drivers/infiniband/sw/rxe/rxe_net.c  | 17 +++++----
>  drivers/infiniband/sw/rxe/rxe_req.c  | 55 +++++++++++++++++-----------
>  drivers/infiniband/sw/rxe/rxe_resp.c |  2 +-
>  5 files changed, 63 insertions(+), 35 deletions(-)

This should be ordered earlier as the prior patch turns this into a
bigger problem?

Jason
