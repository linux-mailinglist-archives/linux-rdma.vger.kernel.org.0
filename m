Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EEF3CA4A5
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 19:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhGORoc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 13:44:32 -0400
Received: from mail-dm3nam07on2056.outbound.protection.outlook.com ([40.107.95.56]:16820
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229506AbhGORoc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 13:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvIkT6rjPJA3PkBOVvSSvHL19vs79I2UY/0aKQtFqqlUeMhvlATd+rmwC3gBTQ/JTj6DjGMoEm3SdxVrWVkc2YkldzOCZeuTLOZPZIC+r9lma1OtKrrc0ikFeoWb7cS5uC4ep1UTVjF98pNe0V5xmd3h/Bc/NiUHfn5/m2RuLaQuawfqyuKlwnIcznetTQHluZp4mJXKcVVfaqwGT+dL8nCv3hohEe1G9RaRCi65MhWPpcQG97Ya7NEGmhxLw2kQmhW+w6BT14nk91vxLQl1n0waBPzIGIkck9yJc0i6Gxa2ARzkfyj6iA00HXMJwslPZvMSFzQLHnTo10C9p/rebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5OndAJZUSVcNU3hqrlJtUdJH/MlBEVimDcm8W+7Oo0=;
 b=kXhi+j1I7Ez7gkoa4AtgyBOHZGjm4VkSo9CGYI240EzuK/P0dMwmVQFimpsA8H/+y5QlHPQTIZRMF/bnDUedSuwuWuzWKaL94v/Ht8dN6escfYuMpvWgWYfLmiHAjZjbzMuxKfITvTNkDu7QV24NaEw1St14dxVeAfNeS5nDlGHH+1lgLKMAT6xREmN2QrBUHncRVww0A1HBbKAFpJrhnsrbHAvsTUysDHN/iwGojyD12lTZn90zY1b5Yaew6EWX3lQEjOvPqyh1KPHk1z4sMYIo/SVpStJUExJ+qmo+bMd4R/h0URDnpmRTZjg7eS+eSWSsPSJgkRGEAdgaGP2pcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5OndAJZUSVcNU3hqrlJtUdJH/MlBEVimDcm8W+7Oo0=;
 b=rrUw+MpnysZaKw1mEuH7FYDgy/TjPrpzGOB1c98Qi75e7Ocb1drJG0Vf/dqkpNjplVzfkVDkHQv7t54a55d72b58ciBh7Bz5AdyyWj9zIHesCZFfp3lfA9xSVEZudHCOYY5CDDUHtUpHCwHBt6a351hnxFbAEDU9ZArXTNJlQQLf9CAfiIX8y3EszUgoVLqd+eM4t2DJqFVx8ko4zJvvKPt9okTum4A1v/gItFCekFrW6tN2GuqPpLLf0vVRI+87UNeyI12PccQFXH9J1n0q8yw8Fm6cSSNCiqDQ2H8FbML7tVIvotslEKq1GbQ74iex2Jv2Z8qKoJTYXMZZEg4aJw==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 17:41:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 17:41:37 +0000
Date:   Thu, 15 Jul 2021 14:41:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com
Subject: Re: [PATCHv2 for-rc 0/6] Bugfixes for send queue overflow by
 heartbeat
Message-ID: <20210715174135.GA658050@nvidia.com>
References: <20210712060750.16494-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712060750.16494-1-jinpu.wang@ionos.com>
X-ClientProxiedBy: CH2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:610:50::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:610:50::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 17:41:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m45Md-002lCc-CL; Thu, 15 Jul 2021 14:41:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc22477a-7b14-4000-9c54-08d947b7cb75
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5110FA500D99A1C07CD8F80AC2129@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTX/KNphZTM6UJ5snIxf9WalxnNBl+aZNV+ZRWYgSZwrenkY6EVC8L4I8ipG7kOVyakhKRyJJ46A3qCXCjvvKa0nT2F253U8bN+tONH/+u1qwv0C7h3gUIs2ZVP/ZdH46uXJvpI8UlzuZLfzkOcqSyEGYGFNce0kLKndOWPGHB5QSxhjeDvl3i6Vnh33MiTXYx7pcLvx3spIJxt4n1xS4RPbtHsbxQChxqxCrkHNfh8xLz6mpHur6T86uExtRDyQcF5QPGy02Ei92vOIiGRz65a9sIBdZx4D/Z1pK9a14JRr3oc/0wJ/kB2xgnTwsD7+Wxy2qpT5hAVy1RiYRAW7Ml+pdy9S60FdpQR51V2Jrc1f608ej+mPkvMF03j6HCqjarunajT4wmGvGnZ6OuM+StN6bIiSMrXOeEsV5ud+k/XN5d75X6hncO4WayVdNAykilphKHmqyK3Wwb3osN7h5zt6Btimp6roMQgHa2WGBPuziOIYz9vgT6aaCpiDgUZd0VwYRlKN0weEiFpZTQZ1DtU3LDQAUgcHAxPH+9P296FQnFZm2GIgRHaFXYVAhjwarbzHziDAxXaxlXdX0pnEbn67UEYmvvFHREa0uqKU/8WzCAtMxe+nFAwDVtDxJYzqtOrkQV4ccYR9K720jrBfne/Z/71S6Ip4v/fQXS1cvid4SZuj+8Xf8N3NwdUykJEcTx1qPU7Ickqf9l2p012+vps447ALGenNQ++ddCPvI6bi49hND7Nmxn13nX1KK9ltuP5vB84P00uzcnPdYXLA9T2ZykZXzMD01aZ9DyC8Dns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(33656002)(36756003)(38100700002)(2906002)(1076003)(83380400001)(8676002)(86362001)(4326008)(186003)(5660300002)(26005)(6916009)(426003)(8936002)(966005)(66946007)(478600001)(2616005)(9786002)(66556008)(66476007)(316002)(9746002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BdDDmnTj/uGBDDYRBIZEdTeDURIuNjuoGyLydAqFHf1FdUsvPVHCvihl3xZk?=
 =?us-ascii?Q?wN9kVZsYIZLowHDjl23lPhResdMw0srli0IwGrJ7n+RvMqAiFeUqPRC8jinI?=
 =?us-ascii?Q?41HrDlgc/WZDOTw2Seg4D3t3d6EM88IUk8zNZ2WFYrpfdiMsqHRX1CFPDHp/?=
 =?us-ascii?Q?jk78giNo+CgPU8KKcvtESlejg4ud6cYAw56WnT9iEt9XN9r9NFReCTaij/PG?=
 =?us-ascii?Q?TIrsCHg5bBtIKAd0VOlO/i0yKlimG1JMeLwU8yybBJml48Mt3QlHXU3jCnxf?=
 =?us-ascii?Q?2ODz+xmjL/P0YGy0Clada7pmDpGzJtHbJThct9bReJPsXfSNhZYFN2GJTFf2?=
 =?us-ascii?Q?04EJgjhf2OCT0c5eEOsrOIbbWoyCdgXeovpAjTvEpONyfzgMmbtNh7swB7pR?=
 =?us-ascii?Q?2Tc8ZlZSA3emd48k15UNZhAiUNmxxkfZmw3vTtygRB8r4fKfG56OLOoNwA2K?=
 =?us-ascii?Q?P1ugfA5CMBzsuX59x4JhujSUYspBDlg3yOeg292qZdLxqrPgtS6+jMpL1zhP?=
 =?us-ascii?Q?vkK1Oqii4YqMxD+6UedeRnDhrHeLMvcKmxhQFYLpBL6V7gJ/0DIHs5D/V0e5?=
 =?us-ascii?Q?j0UWoPVsYhuw48dRw1gXx9Un3gKGyjiC5Eh9emCBX9Aq2nZtoaOXwTCrL2S9?=
 =?us-ascii?Q?seezzFw59T2SOTOFswfBX3w9mye1tj7uydbjNHtlzCxGNuzjgw9SsH78xDoq?=
 =?us-ascii?Q?z+A22yOuxxh3OLJNdEOp8pLujbQY4bFOGqMCF4ALpvBJ3s9B4h9kTPECUnE6?=
 =?us-ascii?Q?7BigycUUtfeg8gxmHQDXJWBqk/yYFUfstwTA898xFnzZmPgJpBypJZ4zmqQQ?=
 =?us-ascii?Q?un9SXHkErqH593rJbS/jCzHnZOk8LMm/YBsQZyVxpwVTtYhtLvYEk6b1DMFo?=
 =?us-ascii?Q?Ka27K79uaSRz/uYPxvxbE3D1Sc6dkes+BcGOM0c5kp+T6MoBY3UBQECXv2JF?=
 =?us-ascii?Q?y9eLdf9wYaBawnzo2uLAdpvglcwS4jKS9JOyXg7sI61gVrpPtZoTY3+Mr5el?=
 =?us-ascii?Q?B0sKOfmkrgRnzmfDs7uvct6aI4Kv7eowH1qI6h4CuvaROatFU9uIOKRwcnoV?=
 =?us-ascii?Q?yOP/cK82L4m8hWo3MLPh5pzyQD4x2m5ada6Yu+Gh1HnyECdp5yKK9E8qmeSu?=
 =?us-ascii?Q?rjwZNiFl2u+xMnuGLGdYdtXtQc1Bg/h2K6ybK+y6Xfw8JkucrlYVhBwyO/Xc?=
 =?us-ascii?Q?eWPq35CS4UoXEsKySBMv6/hHEC8pPhDYcqzzwI5Wzhp1vbjhxxPaXtoYSHku?=
 =?us-ascii?Q?InnV8SPLP9frPIt25UIHnXs2osL2WmO/1coIwCOW9HzOlZVEewE2RbiJIH9F?=
 =?us-ascii?Q?yUeicQplN2D5u/mnmB+4/9/G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc22477a-7b14-4000-9c54-08d947b7cb75
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 17:41:37.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKbQa/95uJncqZohTi/SDTMTweAXFP5yqQOf1ZpdwDeKUf4dB060HK99LXiV40sI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 12, 2021 at 08:07:44AM +0200, Jack Wang wrote:
> Hi Jason, hi Doug,
> 
> Please consider to include following changes to upstream.
> 
> This patchset fix a regression since b38041d50add ("RDMA/rtrs: Do not signal for heatbeat").
> 
> In commit b38041d50add, the signal flag is droped to fix the send queue full
> logic, but introduced a worse bug the send queue overflow on both clt and srv
> by heartbeat, sorry.
> 
> The patchset is orgnized as:
> - patch1 debug patch.
> - patch2 preparation.
> - patch3 signal both IO and heartbeat.
> - patch4 cleanup.
> - patch5 cleanup
> - patch6 move sq_wr_avail to account send queue full correctly.
> 
> The patches are created base v5.14-rc1.
> 
> Since v1:
> * rebased to latest v5.14-rc1, target rc instread of for-next.
> 
> v1: https://lore.kernel.org/linux-rdma/20210629065321.12600-1-jinpu.wang@ionos.com/T/#t
> 
> Jack Wang (6):
>   RDMA/rtrs: Add error messages for failed operations.
>   RDMA/rtrs: move wr_cnt from rtrs_srv_con to rtrs_con
>   RDMA/rtrs: Enable the same selective signal for heartbeat and IO
>   RDMA/rtrs: Make rtrs_post_rdma_write_imm_empty static
>   RDMA/rtrs: Remove unused flags parameter
>   RDMA/rtrs: Move sq_wr_avail to rtrs_con

Applied to for-next, thanks

Jason
