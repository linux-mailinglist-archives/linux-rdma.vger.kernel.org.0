Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B02388103
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 22:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352104AbhERUKm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 16:10:42 -0400
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:2209
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352068AbhERUKX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 16:10:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+zPZLYy6OQdK5k9sjMQoS2+CQFKl0WUDgewUK+Sv6o1AQDK34MbpxYSghun9NTYHe6LFrppF/0d67g2aJTU9DDj6iIL3x4t1zLws7BWBMxGP0NMZVOC1YHzpyJiT6qMZP3ty9SMMAcMJoo+x9lLJMFrrJi0Tdh2sWLi2lHhbHuaIpYWBOb0KF3dsAGodUdRATxMKC9Pxz/GueuAQ31l5zO+Km7NWfNZPe2/DL9bUncYoi6V9X6Pz75Q61msZuSMaHG9p082AzxkDUydfufMUSoAm7vdMrsRFJo0lnydEbDYNPDNbxxwuB2IGosNHAOd8N18P910LqD5CC6LusxYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KguavUdT6D7OblcT4uwWga4kkREE9zh4kOftYlHak6M=;
 b=RWuLrdcm/Aew20aH1qgSykjDPZ9vpdUlFaJTURgnaxhr5HSfnsMosn1UdptaATobir02K3VrxSJeNKcD8mZX4VrC+3Ne0r9apFyWLDGooCSe59cwiR6wS6DFISD0MwOB7HBq/B2iPlIQiUM5gbYug7gvhN3SlUpyEkVjUcWsR0b2OttcyL+a+xkjcwP0mwZVtQtfCPDvqJ/B2hdbW2ugurVsdZz6I6FhRp+U7sSojezIjnOi5Lyq3O1I7pXutve7eqs/pDT2+jVKUv7K9xVJ2rGvY4HPuDak6PJXzUsY3Q+wlgj8FhxbtYfJzyhm0BCSQjKTUClG+ythNUArYFaEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KguavUdT6D7OblcT4uwWga4kkREE9zh4kOftYlHak6M=;
 b=YxlkxFACY0+WYfAjbuQ3lHygqIvtDpAsZmZJRiTN15CqXpOEzFvqEw8Nt8ata7pl26vVGzOAzwYsNHDaM11qtGkdKvF5Dh/nlkdzH0pEK9OD4vlREyndmq+rObFGMX2aL59CaJAs8HZ/vXCOjzb0dHOHQDa+s5uy5VXyKqUXvx0rzH+z4sE54PlLTf+pajOZePC1WECbGCnmUIoyeN4T8qXW8rgf05lVzZWmYt8BBb7gVR1DlqD7EGFhR4OEN1a8iXppdvF7smJAM+vPIijMqoMRb3sfCos4ZN+mW7NUUZPi/zJTqOox+UmxYm5ERnnDO6EpRJCq4Bv6cryVm5J1fA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 20:09:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 20:09:03 +0000
Date:   Tue, 18 May 2021 17:09:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v6 04/10] RDMA/rxe: Add ib_alloc_mw and
 ib_dealloc_mw verbs
Message-ID: <20210518200901.GA2489365@nvidia.com>
References: <20210429184855.54939-1-rpearson@hpe.com>
 <20210429184855.54939-5-rpearson@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429184855.54939-5-rpearson@hpe.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:208:23e::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR14CA0013.namprd14.prod.outlook.com (2603:10b6:208:23e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 20:09:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lj61V-00ARcv-NE; Tue, 18 May 2021 17:09:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 626dd0bb-2d87-49e6-c568-08d91a38c837
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148A0441506BEB3F9C5FF70C22C9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLR1Ls0iXU7DBpd7pdNVs+aKVH8gFMuQsqnAba9AgRdWXW1EIUX00d0Hw1Hmnq1GP6AWspugjDj03+63sWhLKR6n2uw8gf5j11CAx0kwW0eHIHqSZCm/GD5SIIXtfa+mm7o3kkw7NEibuoxstfDHHLs7sfTwNiMfmnWnefnK+JLXRw8SDZQ9Dmr906nXYhN3dYJ+5uvD8yCol+RWHEEDJhxk1oxDSYR0ygmRdJ0dwQ+4frw0yCuZ/o8f+ywTuXRJP+K94MPQ9Q5YLiRVnYj4qMge1QnO4R3noNx/Bmks6ZWNxG2RU37LcviNKPgkSUgwT1uZ47ccF4d6oF4hFDxCleUFjZeAG9wKrzHccx0mMJr+o/l+Y7HKhodmCy9tHR04udoA+jwH+2ymjZiva0udkT8aobFqiRScKAmbmfD4drBv0/3hkxMlYsiPqAEXkXqa0go773U/4Ea2vbAZ1BPjTUl8Dmue9ck01qeB+N8q8OV0o+Zkgg+AcXu/HBUD3mO/AR9Ema/RbLVaPqOgqSPvWfTQPvSYwusweTXY/egU9Kdg+69TMTrd3iGtPLNOYNFNYjWosS3rW/Qq49pPDZR1kxOs6L9F+jnwEmm+b8KzWzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(86362001)(66556008)(36756003)(2616005)(426003)(66946007)(66476007)(478600001)(4326008)(5660300002)(33656002)(8936002)(8676002)(9786002)(4744005)(26005)(1076003)(9746002)(38100700002)(2906002)(6916009)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kMtgLYxVyYDPt+WrnlNDG4uqmqjoW9tV7EoJZw2Y8oIHSS7IL5relUBLPxM9?=
 =?us-ascii?Q?mlGRwUIe/FOQZ6QoQEZQ4nkELhM7pmnBfxh0edVFhjC9QCQJi0rfwgm3OLfd?=
 =?us-ascii?Q?yrwoTBe4Sdfks0FNja+hei1ILa1kyhnOyIkl2Lkng5wyha7KjSASmfkkxnha?=
 =?us-ascii?Q?gKBFSNbCz4RsE5bfwuncOQCJYHdThc38yBWah3NHL2FeNRtdfg/cOpfoa9z3?=
 =?us-ascii?Q?CrA3VYS2foqEYC0bqJ3aQ2F0tQ7pqDC/HV1YCPXvqwjFDFBbjCPeDvAiu3V2?=
 =?us-ascii?Q?nR33GCz5302e89YW7UURrVv/FgeQ9f5pnF95GURa081t0LO4oJNkcdRkFxba?=
 =?us-ascii?Q?OJJUoihs9e3qOmsRE/rl6o7d4hF6Ya/WpcYva9gWOrI6yf7huknwtuAFo6ek?=
 =?us-ascii?Q?ykDba06pW5MylmA2xTLLt4M7/hu8fI2lbQRn788m/gEj1jD3TqVWom2UZwPA?=
 =?us-ascii?Q?4FJFHX8XRGQSCKnq2EYLZohFDuLYR95sKESh85RSy27ds5tvyKKiNTc5eIS3?=
 =?us-ascii?Q?8Qj0w4S4F+SGNcxl5IKRkhzuj+rEdgk8W9gfEFt0cU9BDpnP4M++DBh+gBtC?=
 =?us-ascii?Q?zFyP7OrDAPDkocn0oJR0DRc6qcVJaQUTfdWDAIJF/jPpDQ44DP5TncrG8KCd?=
 =?us-ascii?Q?WaiiwU8Kp/ynYUJYJR3zvQEP9nPsjHNW4slBHtZdTwXxgJtxuttn2/G9lIpv?=
 =?us-ascii?Q?G6+pfgl593HLt3m7FTRr7JYz5pDW9iCgiEAYkxVTu4qAlwtxQ0UOTdBRPi4z?=
 =?us-ascii?Q?dKDGWJANRq+xYaCPM85rfE1sXRhFOegnkGEtQmlilsxQk1ljav5Eq0CDx0VN?=
 =?us-ascii?Q?nvZqm5XgidzTGMWTwD9Coz7nbP+uEqbFWv+Y7yjhoeCErm2uQ30FUR6mQdW6?=
 =?us-ascii?Q?Ltcj0tcyoHfr+dRYvsx38U/Mw5XbDVoh+6FuT4xtlR7iVyqUX1V9FTWS2f1Z?=
 =?us-ascii?Q?WtPRpRHtJ7whZhqsUo0Dzz7m+j480qGLJu1A5RhuCQmDhOEitHiK9LB4TX+7?=
 =?us-ascii?Q?zBUqDsXhJQohof1eCaqjZoB/S6+ygvFvTD60DYjRHpmC+HElNH2Gm7MORZuZ?=
 =?us-ascii?Q?5uv9XXUOrmhypDqSVOPngi/pbUunwG1b3lt8HsEDBV185GrXV+oVRjpxuNUs?=
 =?us-ascii?Q?i9lXF0OmIv25uyojO9CKTQ3HJmYeL5x+OwKVIABU32QrxemkIX4/DXxl83pe?=
 =?us-ascii?Q?JdIsn6zDnYOvbQHpdRdzU1Xi/lU9yU+dzjCxw3LVn6b2GycbImWOhVNL6cyP?=
 =?us-ascii?Q?PAtXYfrwXEmfnHzQ5P9d0kuh29UFaePlQtXf6s0KhPvOlDdjCHRyAEnxmNwd?=
 =?us-ascii?Q?htSUIMjdYSN0Ya8NAR5fqun7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626dd0bb-2d87-49e6-c568-08d91a38c837
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 20:09:03.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSQYnec0Iuv4Hdmr9Q4diJHHB7JPU+071TAvYJ4UVHUBL4JL2S9S5e1mY2l1234M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 29, 2021 at 01:48:49PM -0500, Bob Pearson wrote:
> @@ -1106,6 +1108,7 @@ static const struct ib_device_ops rxe_dev_ops = {
>  
>  	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
> +	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, rxe_pd, ibpd),
>  	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),

ib_mw is already listed below:

 	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),

?

You added it in

 RDMA/rxe: Split MEM into MR and MW

Jason
