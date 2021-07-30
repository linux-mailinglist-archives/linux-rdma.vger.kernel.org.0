Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EA03DBAA3
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbhG3OdK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 10:33:10 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:35041
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239042AbhG3OdJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 10:33:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPrvWJzQyPIEcSN21Z4gexAneS1nmuGdeP/UO1+8jGwPcy4sUbp70TmBeCXL9HO6Q5jV/U++DBxrfaCpmKtbhu+Q4Ia2CsYH8I2IrzMg6OF3fUN+WxR23Weq5pZrBn6RA0LejSp/4eULmZ3Qx9DfmzdcacalLxgDkHCxoaahjQLzxRrtTyatIHlDPnZWChpujIHV0VNf31XySwNnY6Jt9H1fwhuDv7dB45ChqrK5jw+I58+1oktx9vE3QuTkoddECUcsa9lVx3Tnjb0kkTs4p6eiQT4h4GnTqoq2Nl9w16W7hRafzVtFoQdFDoOVFPl+p1Kf+2CqNOnCfXuLwSiXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU+hdOjKBruxURDSdNgm3UJXBjvCEYhgBZ+DQkZAv00=;
 b=h/0gV6R/g8Yl0ASrSA6brzOedS6TyeHpOiYJbiX/pQ993dZFiSQGmbd4aiefTs33lzphQKik5740Rn+FHJLy+TFkSOr0jh7MNTl7wgyGmJYAlxTjbX7kSyHAKgZgv68cSzvfmYbPiOeZqF+u0zzCEIP4iHGawt8fJlB5V11JlAbAX/rBAlqmUe49Vzc2Z8vi875WnXxAInxj8sp62jEEtngIEpuatYGKdHUzVt0A0zbkTWUb+CHh1KXPLzinMpFaTaVoSw89/EdwKZ10rwC85Vr77vDLY00rvXPSzo6F4RHuzBU4MU+4OqkYtPdB7RGP7z1AyNtADtAbJogTLJE4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU+hdOjKBruxURDSdNgm3UJXBjvCEYhgBZ+DQkZAv00=;
 b=KHLt/t6byml2Cb1ytn/Lqf4AfsIkNmThn7+iCLZ6+gmkyLk4GBSyOqAs8OmZwwy/0lNIFuH1OJgLKOv2A09Stadta6lBJDxYeZiUeu0UgfcQyVaionaHZYfFaQKlEC8+73vSQjQ9Fc0bZU7NjHp4GJyi7+OXpLxfHiCa3hUHS6YTcn8FOv/h9b7UqSlQKbXsxHEOX/6c6vVY9H7Tm2HaqPckXg3d3LSD8t57iv74Swksh4/mO6k2GwEqWWsIjvUE7lUrN6NN9nxYrfy1ZiyPGjyex+u5auz710vyvivyB/93+1P1qCerF7WNr5EbP22IYbMfSc7x30qX4aUrVcUEgg==
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 14:33:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 14:33:04 +0000
Date:   Fri, 30 Jul 2021 11:33:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        mkalderon@marvell.com, davem@davemloft.net, kuba@kernel.org,
        smalin@marvell.com, aelior@marvell.com, prabhakar.pkin@gmail.com,
        malin1024@gmail.com
Subject: Re: [PATCH 1/2] qed: Use accurate error num in
 qed_cxt_dynamic_ilt_alloc
Message-ID: <20210730143300.GA2568525@nvidia.com>
References: <20210729151732.30995-1-pkushwaha@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729151732.30995-1-pkushwaha@marvell.com>
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BY5PR17CA0020.namprd17.prod.outlook.com (2603:10b6:a03:1b8::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 14:33:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m9TZM-00AmCX-Mo; Fri, 30 Jul 2021 11:33:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 244d8707-a717-4f26-aaef-08d95366f0b6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5064C1A6418981D9CB26F9D5C2EC9@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hESWAfh+gQaAQz+VNWb1tcbljKKO7SfgSSgxraZ//7QEoNZbe8Ht2PE/pMbV3vOInSGXU6K90iHTRLoEDxz2aG1RRNZNVbgR/g1W32cjYTgv9JKTeyaTBM89ZqHABSYuUx5RBtM9GoQjNXSVbgKLcg3Arb7+uWp+2bS+3msGWDsNuSjAqHxe+bfvKvf+UtH3rM48IccX2J8VPd2rZ+RZPKzNGpIL8Z4AsH/vyuMqYLQdphZVtS70ZGb5eNBB3xojDq0AYxxEL9+uYgfsK1dn0Ao+taDJ3WrXbD4F2AF7O+UZJ01WrfsZUFFpF5m94f/09bIQMyKv+lMgPUb756X3AVPd/U5NrXBV1eokjseQULG+GAqQHFjnCDFiYOi7It/NkSKhxTNl141SmgyXt26hJS19UbTrB71VS/CHKuVaP8VWSmBCZW34RPj5DssqeyDZVvVvUpHbWvCGJhICWfCrR7tsYmval/ljtVq2Idp75h85iOP+HKazHZqZ9rGzUU1LpBA50+iDdI0jxSfbBDjpRCczxq3sx9Uu4nb1YWeAL10w1aYMxw7soBS7FYaQ+6Qwe4tOv1yMMQkln5VOGQfrwgUTPUCdfbktBk2gib57nUE237fcMeswEU+27k1Bfr3kcMH9WnzsCdPeqWHtw9ge0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(478600001)(83380400001)(2906002)(86362001)(186003)(5660300002)(6916009)(8936002)(38100700002)(66476007)(33656002)(4744005)(66556008)(66946007)(7416002)(26005)(316002)(4326008)(9786002)(9746002)(2616005)(426003)(8676002)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E96LiiZo/fyiEJczu0eEdqDuU7o9aXusWpPtFajCtMX1Z270zcQldb0O1Om4?=
 =?us-ascii?Q?C35+lcuX8img1IjNYqYYeVx62Wdgw2aGMo0aE2ujfA/PwRBUt7v0R9dG0ul1?=
 =?us-ascii?Q?AQHHY87jBWXnlKKEoGyVwjp/juW5hBnP7aX3NB07jCnPoPV/p0nTYUAR0wxV?=
 =?us-ascii?Q?2hTXRyWEBiFrfGn6F42yY58GaVt0jQZyWXt1gUj21/VZwVPk+NjDLrFEQfsk?=
 =?us-ascii?Q?ckqCmq0zGeJCocyhZkS/HTNHdmFsPSzdCG+N2jR9nK9rI8QokY0YMde96gd4?=
 =?us-ascii?Q?40wkfw24I/pBEhWLe5rhwJwz9yrLa41qHNZO2pst/Jb2HkIjnFvighrIcWi+?=
 =?us-ascii?Q?ftamXVt00V8YzepwNiBaievdVNclb07HteCTt3mUaLKA2yrB4U5r8zVwMZql?=
 =?us-ascii?Q?8eSKTPMZIJZVIKeT2aeUv7sQeT4LqxgxEtCo5ICGymclYtEutd0VMX74bLnM?=
 =?us-ascii?Q?F88G4htKWhMq+ZEUnI/3Zo6w3YI6SV+3zkzM94Hv2yi4mR8/6A4OLsAZwJXg?=
 =?us-ascii?Q?Ig/o8IFrjfoG7ouGh8I+UdI7i92g/vz2ec+rn3C7w3n+4jPdecFR5ma5pikr?=
 =?us-ascii?Q?2NSxYrhkTgzn/WFftUTosHOxxuYFHsxTz11caLRjChs4EJ0RcNV1GaCE1dVB?=
 =?us-ascii?Q?UiWRyyRTQRYAWckffK1erviWKVY+MZI+XZ+1uJ+5LQmkElufipBc3GhL3aFU?=
 =?us-ascii?Q?BCdZWz6/AuxqD+wvsnVItXAfMI0AS7GZ96kUs6Ja2shstmq8SoL3Eneo6M8P?=
 =?us-ascii?Q?blM3FoAwyQeBZQCLpjyG55d4E0nNeKuL7vTuKIZdYsQ6GVxdnLEh5xPBoetG?=
 =?us-ascii?Q?Ew2T6/+zizagLGqocEJbRWoE0a58fxKJvEM4IGrqsPnDfngsHEtz7JRUpjq9?=
 =?us-ascii?Q?tl7b1RrjpD+cwR7ham+2XDYf+XxmzGQlWzAeGQDuEeymIgEN3/vcoqpIEQgl?=
 =?us-ascii?Q?E4f2qBIo4SAV0RT+VsRXHYRo2u4tkwFAIKHE3bpsf9wvbZaGye9RSuqZ3gDw?=
 =?us-ascii?Q?hkRSCC94+xlJfOiNQCL3L3NwMKqAWfJ9njGiEvDQl4thN/Jp1A1NMmJORbx8?=
 =?us-ascii?Q?lLl3F9P52g3cfkLngKbAuuwwGzEgMr3PcuaJCblsDQYpF+jTEehBCZ/9dfSo?=
 =?us-ascii?Q?qisvXmDGy5C2rRnO3ymENc+hyvlDWJ+iZoIiwJRSTsxREmRuf4v6Yxvh/D0L?=
 =?us-ascii?Q?w+xFGI4nvSIgcKbsvqAEUXe1b8lu18u0uMwPr5TZj8DCA5lwHAkJIMGpgtEz?=
 =?us-ascii?Q?EHfMuSZ2/svrIN+TO7EFTrro91JbDqRLRflHjrgO4WBPijQ33JV8OVH/uVTG?=
 =?us-ascii?Q?0sZs/ANIYHNR93SOFriHtY2j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244d8707-a717-4f26-aaef-08d95366f0b6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 14:33:04.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcpqXfNH9+tugsnbl3ds1GoGQepsFsGlCi2CdWtwD64wz6SejGg5b0o/tl7RD2dB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 06:17:31PM +0300, Prabhakar Kushwaha wrote:
> To have more accurate error return type use -EOPNOTSUPP instead
> of -EINVAL.
> 
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_cxt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Both applied to for-next, thanks

Jason
