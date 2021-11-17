Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1E454ECE
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 21:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbhKQU47 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 15:56:59 -0500
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:41759
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238891AbhKQU45 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Nov 2021 15:56:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbPptDEO0wQ1uo6uzSNknlxJObtCCTLEPFcC18lAUSXKPlPBsQPU1mKin274VlRRw0vOdttHWvemhXjCRc+lSRJYbrE0wKxhYkiioYh30g6HoHFzokHWCyoFxfbf0LnczBEeg483WbVO+s8QINvPJESFwXOY+KjybR8rO2DLnrU9evALfC9bAmqVHqu7NPlX+Vv/UdYXNS/sErrwe+70icwQcOvLIVDpP2EmQ3hgMCm9+kPBH2uxvfcxtkqz5AJECfbNBYahzOIJKwsnhY8iNAiLwuOuwbhe4gB4Ec+xrKo7F6QviuEn0FDGdFpwdUxEjhSfU/+976Uc7qby3jCQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5oJke5GkvXX5qGQKWzUSwNCsrBnV/r+s+lyru20Gy0=;
 b=W/MRMPyYcUFvm4M/oyxu5nsh0+XgjriFmT4iPHuhYUcRBLGIslrw+nsHseCmoghUErI/om9b3PsFpLOGWoEETyYjyQE9BYb8UjfZLRf+TlnWpggMt19iOiodOF/eOjj9ESk0DTD05TCoF47c/VTqUZ7YF0soKGXzJzXmybw8tsAUY7H52wpAWQTqj2DQIl1MVKb4p6cZTCP/AKtNNShYPNOP2pf3a7KsJ8Qu8u1uCLEIzNn3GJRUA+fuKbq+2fUEVTiQSAhJTKo33NjC9ZzEK0CFXyLnVWUOfB3UN/cUcQ0qal7IaMfKnI7jlP9a5miqCHZlhmol5rRLZRAzh5kBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5oJke5GkvXX5qGQKWzUSwNCsrBnV/r+s+lyru20Gy0=;
 b=sZE00asa1wusheJ+ajm9TYfPQ2TxygigcSP2i72nlGsZX1vmsbdv1bv5Uro7kZk4179qWJY/rYMSXNU1WZkXyBBrzW66iGfeqANt+4Ifpe9JeaHaRQfYaPGOqktiZEkgO4uTYRQOqR8Ea1pto2SJu5mQq7rncFpkJRR0skyuiwSqU2Ofwpa/PFVi/uimPeromzW+LLAJcTfuEJbc4+0YGZ6/JL/HLIW3Wl/0yGzZKaQjgqfEAaaNx3xV2vzq/CnjaEtQ3JnYB2YHifmyBiDHAIPoZIm+KcSKNl9Hd54KZiuZzqArmQmDHS7Gw80oRJwYIh5tw2W78qZKGl/GoXdM6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 20:53:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 20:53:56 +0000
Date:   Wed, 17 Nov 2021 16:53:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/ocrdma: Use helper function to set GUIDs
Message-ID: <20211117205355.GA2762841@nvidia.com>
References: <20211117090205.96523-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117090205.96523-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 20:53:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mnRwJ-00Bakl-Jd; Wed, 17 Nov 2021 16:53:55 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 801dcfcc-c5ce-48e5-304d-08d9aa0c5f64
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB534972C289BD91971FD40BB3C29A9@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g96nQDEkGPAf36Ok0dWwpcSW1CKtENJvWPTTR6XM7Vd4Q5NyWCs8JQKGk3OU3mJyhavhRWAG0flEq5rTvfflxlnQpH0V+yczE181uqcExZZy3beuuk690UxRHcQaCCxoxuRn027ZXsJs1XrSh3Nj64vZ2CLF/CVZ2FDpteXfaKrFayuVJnNh1bimiryk3uUz84oQW9cEK8C8d8Kpna9F5XqLEDCwT+idb5Ofcl/+72UJtutS7P3ZNlHAdFp63hqFk5xSylgaWlVARyKKxnu8h2yZU54eC81Zffwk5HrG7+iREugXeQM0mzWTkz2NELsPECX3jbC0L8Rjncft2BoPLo+oy1BzziCVKTW5UZjBxyfO0AaasVMUMFeWlHjWy7cW2Aku++ndAeX44oQmTdek9DaSBsaSOLu6GuO0X0CFlMbhtmjYCXtM8zO9Fb4QxRdVFafAd1OS7X9jJVntshobJu5KhZU/5MnNMWMObruLut+fiJEBc1nDH2itjkVTaBHJV27mOj0C8r9vA0LLVEsOL6aUOC/PFy4E503yeUIhsMUYiOK3Cj3aNq7KcciXujr7L9CKD5o+gxCdLNU25uN2KuorBA+Om3WO728G1/ZYJQcJ32rPM2DcjwHiHNo/jevum4vknISvOMn464KtkPio9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(38100700002)(6916009)(8676002)(86362001)(4326008)(316002)(66556008)(8936002)(36756003)(2616005)(9746002)(9786002)(66476007)(66946007)(2906002)(54906003)(186003)(4744005)(33656002)(426003)(26005)(508600001)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nBoJZ+hJ8Hvb92Jax6lbU/lsvjgef/0wqbqHWSymdN2oyklQORxo4rsEbt+u?=
 =?us-ascii?Q?xODRRx0cek2XYtUJS9xKA9LIjt6SBiRYNxAV42K8T3D6sU7TwKdOJbbdOeOG?=
 =?us-ascii?Q?5iqgOQnyoRZXSg8ifMTfGUM0a7aDD/ozbj17cWbkzB6RW3/S1P62oC38etj8?=
 =?us-ascii?Q?2Y62oDTusv5cZkQiEzKs26/oEHL5syO3M7dzSohZG4zZGUXwSbzBGpqIFteX?=
 =?us-ascii?Q?gfKyQbUV2araoI4OCDdNZUmfH/AyJgfaMAfftrN10dZZIlbGX5ZmRO26eMx8?=
 =?us-ascii?Q?AKhreytgKOi29vySm0UMKuSZMuN6RsOAWUdgytum1K0bQHbzMuVM0m8qJOHl?=
 =?us-ascii?Q?a/jFQ0IaOilEfU1bfW/k+I0ToFQVmsMl1ji4GVrozV7fsyQdsbWwXMh2z+gU?=
 =?us-ascii?Q?ZCqxioGX/O7zRUn9rtb+VY0mIOLxRePeRx2qWMyERMpkWd1v376GvkEgvAAl?=
 =?us-ascii?Q?hVys8w1jLtkE1Cmb3XY2yeMu128m7q5/OcPl0zZJ/OVmo/jFIn4LJA26Vj64?=
 =?us-ascii?Q?gGvCeLQONdzdhO4LH88oBtqiy+DY616fu0CkGdu42fNgasyS+xgWfQaUE7om?=
 =?us-ascii?Q?0oKu6Lmwa/bTWSPsxUFyfiNu7g8O+UbbZ8SqOe/KI/Rz6sgesWSQ18oL/VlW?=
 =?us-ascii?Q?0bGRCyR2rwiijG5Ew3gWi/znhGndVvQr4u/6Xy9Nxh6ULdRByDCtkHvzDt9G?=
 =?us-ascii?Q?fIIEwYZ4rqM4n6N8dslXC2nqYv8EeKEwK1cdL9lhiguYCS0OvVXpRtdOb6AW?=
 =?us-ascii?Q?s/wytb4Wq6hqy0H1w+Uu+8L3d+1b7X7EqEIqy/JUP8RfrVfXAHt0yadYEGB6?=
 =?us-ascii?Q?M96GxORCWRfeJDi7eeVlwaqFNmVtgczmV6Avg7xQ8sAtOvNuf4qbRk9sbI+x?=
 =?us-ascii?Q?ZNE8uNY5nlD115gq3hf50NyHJshvYu27CCsYnHRHNB+R+UxHuPRZ0Z8I06hS?=
 =?us-ascii?Q?Ijpbh+UCEnt/J4+1/91F098ICoQHQBLffK67L5Ou0kN6TQYB92RPEwcdLTCX?=
 =?us-ascii?Q?W/zPo7Efv9bAUb38W/C01RL2upjzyriMo+VPwkFk6Pi6bV4Ef0pjD+XoYZa3?=
 =?us-ascii?Q?Vdq8AK8PthFRr60uNPnS0jPLaI6opCue33GSDxjE85iyWS5qmQGWjIURl/UT?=
 =?us-ascii?Q?y8vU9eDUlC/6ttA5UMlQR1gRMO8KSNmmlm6QTJs/9XdLqE9ufYcT4E0Rrtub?=
 =?us-ascii?Q?bLmLntupBBBRHy/4hvLAi9+QsVDRtXJNeZRietOMVWIwyquCjZTmt8B8YcIO?=
 =?us-ascii?Q?3LiVoC3WxJwSBp7dH4yBqd0Y/BBp0jQgLOQNUnwyWYEaihNYspatF/f7gOZr?=
 =?us-ascii?Q?Dk+Z/GDljLGlvuDOmCpN4HbUzsmLx8u/IOdx8IbWR9L/P3HuaMZIydpC/eJO?=
 =?us-ascii?Q?LDBmGyfsfCHeDKs7LAO+5nASaGckKcV0XkbfuPyvVooirFAJUVQap4n4STvt?=
 =?us-ascii?Q?I3IqrK10NHSkBpTDep7YlpZYTcKKKGD/WterhDyfDuP4FvpAm4tYKnDZ2tkt?=
 =?us-ascii?Q?lokdzUlpaI8ytVFzJah1UlH7PsPAEjh8mz3gciWZotB2mclcJcz9AOoX6ojo?=
 =?us-ascii?Q?gz/s/m5h2BNhueMqdHU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801dcfcc-c5ce-48e5-304d-08d9aa0c5f64
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 20:53:56.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXazr5h3YnyuySB8tm9LtSL44ilpWVKCKh7y7+DwXsdhxq/38ImwpgAwxaiYj+Mv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 17, 2021 at 11:02:05AM +0200, Kamal Heib wrote:
> Use addrconf_addr_eui48() helper function to set the GUIDs and remove the
> driver specific version.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/ocrdma/ocrdma_main.c  | 17 ++---------------
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c |  4 +++-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h |  1 -
>  3 files changed, 5 insertions(+), 17 deletions(-)

Applied to for-next, thanks

Jason
