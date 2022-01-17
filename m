Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D8B490C53
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 17:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiAQQQY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 11:16:24 -0500
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:25107
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235158AbiAQQQY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jan 2022 11:16:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT07W9w3cOf3QuJgF1KZQ4TezDMfRPVbgscC1FEQiI118yPWTxlTADcobj3JzW4hARW1OJ+VIoHtaFUCeS+gVDRL98sDEdjxLIu1fcJ4J2IyyQav4dy82yxkMBq7eOq3T4aKKBSIZwkvTessUZMuEVRcNuWxXb2jFDdeDG2PnTSbf4emJUVfj220mugOwUGzn6Npzcu891qWqQsBuPtj2DboFIJS752UBtBWoIETcExAO910f6MQEAbiwWfJpmoYHYDQiwIAnM4bNZIdWU5cJeQA8wjgw1pf3Of0sjMrUzR4xFMuMTUzlMsrEbuvdCGcF35ivLo9pEBM8cqND0JwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juCzus8E/YEEMbYoePQuWH8OcUpazbRtCImnFPh03iA=;
 b=Hv/vJZTf5q7cySGu1m1Yp4yBv6ZOuBfQ+3D7OKPOPzZQg4O0MeY9fBv9X6SbStJzlIn3b1s6QfWG73k0GA38N3STORi09x/kIr6Hr+M/jIH5a72B20ooeZdlJ2IqplHqYFmDEC/TizFMongO5cxXHuT5JwFPsuBh6eP8bhF8ab+0diKp628/RDnwhH6CFNxn9pAvGt86RtR+rYjOI146xLxCdb/E3Y17eO+ZbYTPIHlm8Bfuld0kYyRTKb+perwVHU2l2Qe3ubBCSrXsWBMRxUwV+j2FZUMd9JuWlNOCEiuxtmaiDk3fAcwnW5Ph8Cu5qD1Rns+0FmZFFQ+r84/0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juCzus8E/YEEMbYoePQuWH8OcUpazbRtCImnFPh03iA=;
 b=MEzXAaqEcndoW4wqXX3Oip9o7GU7y+KwF8oKNWqZNQSx0YH52bLAT5BAiV3KdRalQUFW3AYNK31iVoO31nsKQswRqbqMcqhP2bhwT+yr2klzBoA4RSpwNQ56zJPfi6Sby3+25do+KP+LywOtIdoPEyueVT2bj8z5sMDttHLT5lOKWMwnK91SnRQaMDYyIwWhfe649sdjQ5WWUx9wvw3dAnrvUz6zaUBttzFz4Bb+g4U3lTD/E5HVhkS9niafX8t/KjSY4HKP4NuYg5zJql9Qru8cCuUVyrfWtZU94NUkhugoVE8rpkaZGk1iwnUHDQ7ff3XNa3unpGUhQFbzaRGi3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 16:16:22 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 16:16:22 +0000
Date:   Mon, 17 Jan 2022 12:16:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Clear all multicast request fields
Message-ID: <20220117161621.GC84788@nvidia.com>
References: <1876bacbbcb6f82af3948e5c37a09da6ea3fcae5.1641474841.git.leonro@nvidia.com>
 <20220106173941.GA2963550@nvidia.com>
 <YdrTbNDTg7VdR2iu@unreal>
 <20220110153619.GC2328285@nvidia.com>
 <Ydx1dDSa1JDJGFdJ@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydx1dDSa1JDJGFdJ@unreal>
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06c8ea2b-faf5-49bd-9464-08d9d9d4b3f9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5319:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5319415F7CCB88F3FEFC7591C2579@BL1PR12MB5319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDy/ZJyTj6BIUmOuekXJxu5k2lc5RqBU9xi6GgpjGlIvrr6UccvQw0ztDmoOajtMwsGoO0Vf56U1xcNDFK36WMOMm+BJK0bPtJbFrgihKVruMazuYiUH3q5ULwFGLMuWrFjYKLecOzKDQKsrZ0m496OSbD/oQ+Utb5lu8J6ZAk/6O8ZMkTWTQL42emHCrwwRjQRvI7waqCQHnQXrcCh/yq3PXPvtQ7TygNgoi78MNUAVkcBBlYGWYTJynAMFMuYMJDcgxABYQNwg1D2R7BscGd+7B2UfZvYgM+opvfsDp7lxCu1vC2xxUMkw7/eLpL6kE4BJuJ56tuktG7/tC2C0lecAcgsEVzXEO+9kNYrj5VaMZM0hWmJM8v9SKsRa8fN1WzxZsB6kPdtcvxdbYP1dK4IORmeuOkKCzEvMwfI5t0f1p/lwz88VQ2/b6VE1BMrZFB3VhQFxlOExrBl9q5COUTSJRNpq90kloKs7R/60vgLnLbvrX1vg35atnaJ5EOR5zWJFBerHTBudr6xZLoSMZf1sFBit++LjYgauFYEyMCk+96fBFv+GaoC2CDfcx6pePA/7s4ohsg9c+IW9ePlWkv0LCZXUhq4ICvrDN2DIIzPxq38RufL+R25psqvh/p53LU20B8YGQjX7/yiZfGpkrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(186003)(66476007)(6486002)(33656002)(26005)(6506007)(2616005)(8936002)(1076003)(508600001)(6512007)(4326008)(2906002)(38100700002)(6916009)(5660300002)(8676002)(36756003)(66946007)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8OKkb2NT+z0tXlTN8UkO1nwWheIs0VgAoDtp3xzRFRG+Nehl2zN1cYfv9pf+?=
 =?us-ascii?Q?pXkWkABr36S+DHo8a72Vqbbq82q7hdESKPtDR0js22FiwQGuD5SB+JzyyxSD?=
 =?us-ascii?Q?2LcBiZGh5AjqxDm0hCUTck3qG8t6x61sjxaulMc3DRlh/vnQ2+Hi71wynGzB?=
 =?us-ascii?Q?hzfJma9Sj0WdTpI1ZixrK68VYOIDiY2aMnMC3tXwd74Pn60T5jkI40xhPpGQ?=
 =?us-ascii?Q?+vKIvuJ8H8QLHMT06ISiVelt4SsVpEFlF0/ghrB+drrs4ErP1YhI9izWZkf/?=
 =?us-ascii?Q?yKUPHFVSOTRBZv2UqrHp6MF4YCk4J7VKI0VerqInohdL7P2iMX5hIjur8qyu?=
 =?us-ascii?Q?Ju7Cc9uCXXEPbR3+1s4+I2pm9FqGUh1PaeVh5DCoeIG9jg14I/hsGUBwXpag?=
 =?us-ascii?Q?9x3JlBZpYKOwlpw7q/ms3zZq9bag6rTOd1nUVx3kU5JDLtDBEq921fNTyyWH?=
 =?us-ascii?Q?wkcN6yR4AbQn8egBHPShfLtN4Xo6m9Fsa8liGfXSRJL7l7xfxNAmsENwGSBw?=
 =?us-ascii?Q?U1IXL++uy2DwGJNCwWmHZfvZq2onOx9Kb5MEN9pyAq9y5UyRsdZ00lsK06vQ?=
 =?us-ascii?Q?WKhHQoB99Rtd699IplD2NHTjl285+NS1EIzTKWPR/Q5jBIAPstYOPVVtBRUh?=
 =?us-ascii?Q?ZM104Dz3H5P3MqkXDSZ6Bcc0RAQevpiMfqC4jfmrr4IIxu/ir6vAhgE8OJCC?=
 =?us-ascii?Q?rccsb90ct/5Bj/mQ377UFKd2DADo6pDshcGrvYeNK8n+7F2NxoSnratSEhtK?=
 =?us-ascii?Q?UEvxGheOBDLaqGK7duI+gNcWTzNKf/n5Ch8O37c66tpuDW0tZOowCB4vI3Vd?=
 =?us-ascii?Q?x9x6gxnykYBrgBGPz+ozUUZR5/q1mLtp6dl7VRqBrB7iu4HVDyaczWteYz+r?=
 =?us-ascii?Q?DAyyYepzFAWby5EwoisaS2Io1jARhnuMCsnZYQguLIirgTC1IDJaw3AR+UKV?=
 =?us-ascii?Q?eMZ+/mnKyyGYRqBanHI3sAcBBIGgi6Fr3qFWjVhonUDiEOqPrl2bGi4pazFc?=
 =?us-ascii?Q?1FI7i54WVeCEePX/Kdxmt3mogAZU4+pzGtSIhr649NNExvsGDeZ0HCb8ucxR?=
 =?us-ascii?Q?YpskpwbvK3KVQVoV6q8JtBJf3fVNjB8oME5SX1rLZnSTUrJJl109eQAMgYRl?=
 =?us-ascii?Q?n8ZuUZXlgkqv9vc+OtwPihrtkOP1eXB0R19aS4AFnayzmOMxK2zSOHB3BPDz?=
 =?us-ascii?Q?hGTsncLPOZLEPCAC2Y+Zd0A0weA2ShYs82enhZ6J52JwmN8ks3QHhOFy210j?=
 =?us-ascii?Q?ydO3Dm/Z+bcZoJcoBo2XNHMtDNgePSbdhfMxVX2R69ln5sOlo4aGPVSWjBYO?=
 =?us-ascii?Q?Ewnh+t8LswxUusH6cimN/0N2IBw/hjzA3n7/rZa57PKIUaJ16plz1FbG+WL5?=
 =?us-ascii?Q?Nqiea3+WzneJmBqKdUOqW3qY0ebkNOdyRZBISU7I0Yzk7eE0ZvHkvEZn0n90?=
 =?us-ascii?Q?lKMdxHwnD1hOwFyPAeREm5cEKqnJpZLRr+1EPz+Hp6oxnMfUJNH6Ng3RS2CE?=
 =?us-ascii?Q?NCUARJpUacpjqbkSRGnHi0mvBzEjplagMU8pA9cerg1QzIsSCZWel3UuFbOr?=
 =?us-ascii?Q?69PqhiTu7wfdvim9c+E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c8ea2b-faf5-49bd-9464-08d9d9d4b3f9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 16:16:22.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsna5QGWADzBRSi9gBilZTpwNvUDQZNoKXmpPwTaEU1GxLEybh8IN87IFuOosCvE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 10, 2022 at 08:05:40PM +0200, Leon Romanovsky wrote:

> > We should probably check the PS even earlier to prevent the IB side
> > from having the same issue.
> 
> What do you think about this?

IB is a bit different, it has a bunch of PS's that are UD compatible..

Probably what we really want here is to check/restrict the CM ID to
SIDR mode, which does have the qkey and is the only mode that makes
sense to be mixed with multicast, and then forget about port space
entirely.

It may be that port space indirectly restricts the CM ID to SIDR mode,
but the language here should be 'is in sidr mode', not some confusing
open coded port space check.

I'm also not sure of the lifecycle of the qkey, qkeys only exist in
SIDR mode so obviously anything that sets/gets a qkey should be
restriced to SIDR CM IDs..

> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 835ac54d4a24..0a1f008ca929 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -4669,12 +4669,8 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
>         if (ret)
>                 return ret;
> 
> -       ret = cma_set_qkey(id_priv, 0);
> -       if (ret)
> -               return ret;
> -
>         cma_set_mgid(id_priv, (struct sockaddr *) &mc->addr, &rec.mgid);
> -       rec.qkey = cpu_to_be32(id_priv->qkey);
> +       rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);

And I'm not sure this makes sense? The UD qkey should still be
negotiated right?

Jason
