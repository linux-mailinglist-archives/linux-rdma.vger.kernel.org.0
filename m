Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C86C7FB4
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCXOSN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 10:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCXOSM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 10:18:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A8DBDEA
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 07:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awIHuNvV3XeJrO1WjvezppmzzKN2XL9EBVBF1dk+qIKJ7Vscr/d6DCGa1yRx/cINlPPPsGyoKB5tn2N38o8H1vBkjGY+uIr+rQFw6f528s/g7dkcqq5CIOLUeIF5GUQ/RAuNBNhJIohvQAwS25CMy3/5DYsXbJpT6fmZejXPgjssKwPGWEv2FtvrQ27bypMh5uSqQlY9NbFWf2ZiPVDZaXaJpxySnKLMT/cVDLJbmcmI2cwcH8zpYf33H50x1g/c3GEocGVj7l0zBkjOqoyaXgV9AxhxXVSx+z/ZHwAntvwfyzVG6zVGCS77QQyoVAV0nmKCQ+TUOwG6C1rBX36Jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjyxOasc72D8YGKtr1VMm7ae45fHpRR+y6IyEunBQpo=;
 b=kAgJxLQpnuk3nsbrXQAx7bUyOhej51ObhWRRyPryScBsCSx0eo5ox9ibprBEsFy7CeN1FTZPi79fc7staj+WFjHEkbaWEr3HXtUNETkX0IhCW3jzvFKKY4No3FlUPOxiBErF9JsgATjV3uzkEVKJ91JNKnfKFW7MSlRmg5TnRwBCl/RKKMe3mKOPJzMVQvyhsQGswAJmPZLWYVkDf752+UFmmy1q8DhrPpowFse5qRMqtNcn62Fmka7rhB7vKRacVakG+T1rt3rW8loYyh/cTZJZVDb54xP57tBDF1YYnbyqmqilfWEcwhSLEjd5G7KeKuGVzVJtQeW/EChelXJFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjyxOasc72D8YGKtr1VMm7ae45fHpRR+y6IyEunBQpo=;
 b=ofB9npMeSY037L23DZ90tWLaiS38CLoaA9vn9TXDV/zU3Lwc4lc2QM77gAFUyExHlzC3R1HJVmBVJq9STNdnTHw/9F+fnec8gFGKeZzNozu2OxGO3qf1Yk1uWYy+2FEypONScDTYLAZfvcCZ7F4YJQIXesUTh3k1hoxp8Y7gnuHhi9D27RjUeNB8mCb2Kn1dXq49cWOGoN5NGvIWfZFm+dajdqMo/9/KdK3KDbpYpqQXGqa4YTFK0nSDtS/w+B14/SWNYwFplLVP5QeorF6Hz9A+eBijHUYgFMBvpaAd7mF3u7tgB/qW5DdMfAdgsnpzbCosAyReiGgRftK00q5N6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 14:18:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 14:18:06 +0000
Date:   Fri, 24 Mar 2023 11:18:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, jhack@hpe.com, matsuda-daisuke@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3 2/8] RDMA/rxe: Warn if refcnt zero in rxe_put
Message-ID: <ZB2xHf00620e7vtf@nvidia.com>
References: <20230304174533.11296-1-rpearsonhpe@gmail.com>
 <20230304174533.11296-3-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304174533.11296-3-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:208:23d::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b35a5f-76e3-4eab-fc30-08db2c729652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTc/n5hmrYNcS3UQTyQt7E3KCpsKxI8BTDaZFOntOI541ihaZVq0unmX5Nsn/OKMVall7C2MTctQYXEwwGpEfVnG3rtnW3PGFpLPSFEQM3aJXwrzGFC2OJlwWZMRY1ZqR0VEHJof51higx9kQyc8hiN9pFuJruUAy701QxTc1Q8KVqaOh+4c0Gj3V4szjhA21TI+3h787c8xHRQCdHx2xhAWU8FdUK9xRoJIzF0FdPycbLIo6cVOGTth6/PF48irbFwzE5y/BHz30AkzV5JkqbiBu+iyiaW1Bov/wW+dg/p9w1nDRQ7Xhd+HNMHKdfDr/A0rEaW+n9e2oKTjPhZr8Gx6I9z8OHtO1BqtoNoEURQ8NJLoAjGBw2qdRv7YIJfMmdJEuAhxCgMpQ9GdYwUhr2irviFdZajjA9Anjfj8JNCzX2JW3YfPcEoGQUzK9SmgKFZahP/q8MstfvTW5PCge6j9yfFJ984OVQetPPY58DHyeSadfBHcTwSh0YvVy/MBU2jtAE+3it9TAp1gBE3wWHo9SY1+nwomiL2noCSHc1Rw8D5RLRmGPcPOS7BCuBNV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199018)(66946007)(66476007)(4326008)(8676002)(66556008)(41300700001)(6916009)(8936002)(36756003)(6512007)(6506007)(38100700002)(86362001)(186003)(2616005)(26005)(6486002)(478600001)(316002)(5660300002)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AsTylJOHVuG2TNga+3taD38X3925ZKBluG+i+xb1IoL1eI2ovcvGabcExbeZ?=
 =?us-ascii?Q?xnmSkpDA6BeXHgyFFxNDPPYJ2I4qmrPw05K+JV2BVU4Qp/rzG+5QV6eHkEwC?=
 =?us-ascii?Q?NrNj2r87OGnKT9nadFb8MLsONhb8cbmDCWQvQLV7xQENdpNtlo//uhGE+98u?=
 =?us-ascii?Q?Qyx1xQpn/n7crdhZYJbVeQu7YIwBdylwfaHnTqgMtDLqevAX9DDx9m26xXkE?=
 =?us-ascii?Q?uhwV6iQMshVMc7lhzmJb6Gva/qcaogH2hO61RwVdD9iMmzNSrFidmA+NX6bI?=
 =?us-ascii?Q?KAgwokqfUkCVacChoOyW9xKu/oai57qgJoM5DwYO74OekOdgmjGas4bKYrZ0?=
 =?us-ascii?Q?W+9mUYvnDKQOvJy474TATK4RoLQkxFL3fR951Sz9FORnMpMwpJ4TO88LvryI?=
 =?us-ascii?Q?Fd+drE3l7BWa4m9uPqqtVYcZAxgEGo3qxQpOQoHS5DTN8HEsTJHUnnUeTV5P?=
 =?us-ascii?Q?rK6UoZxzM45jPEP6BGX2EUvjtfRCqK3C7zz1bKS8sOF62keUx1UQ5NeZL5FP?=
 =?us-ascii?Q?LgUp2sCztTjCoiRecC4Bh5Wuezl5yNya63ZL731VQyx62pj/CCqJ8miO47Qm?=
 =?us-ascii?Q?I+6A4w7qAp9AgmD0DTIXNGJbvd3TbttyKBM1HAjZweophu2ETwhZy26vrKlm?=
 =?us-ascii?Q?r0PUZ9NJNL9BV7AUdAWuAtgG8688WBUJ53vMHa3Kg334iAlAB/EJPlG9C40c?=
 =?us-ascii?Q?2QtQGEERDSkz1NvBe/fhvrxE4Rn5ufJ87Bymsv5QOZS8xmL2SeVjNlzkFdqu?=
 =?us-ascii?Q?P3DaBjBcYhSF+zJzuJG5jdNxBRj/hH1IHZaUsd1KGiqioBXCZZNA1ev9TGR+?=
 =?us-ascii?Q?u2zazN6K8Mwz4I2Wjg2XNc2r+IJbk6eUxesyQTjxGMmuKcczLGahSlpD0feL?=
 =?us-ascii?Q?+oRTJbDIcgb2IkjORaZsHEdyxJYbRtGBQSZMIBlUh+G5ojkkYAcFgckz0hGU?=
 =?us-ascii?Q?IrLZvrgAUrMTpBGIdOUZVHrPQK/Zcms0aPrr2pbVCyP9YscYlbWZXx1REHo6?=
 =?us-ascii?Q?BiFj88MTncfwp2uSGjEA/0o97R+nwnQDRSVZOp7qBwld6Fgm5ORtHkg7zNTO?=
 =?us-ascii?Q?cpshQbpf5PkJ2USuBYmJsFChByb1CJgceu7eXOBlDSNbSPnPyPx1+0G/Nw5r?=
 =?us-ascii?Q?/Y2lagFi0ElM4XJDN3lmvp6aaN+Q/v20cWy1IkKzLwy/FQwGt/Rpu7EYD1Q5?=
 =?us-ascii?Q?AJQPlAsHfDYoDsskN1JgxS4l2IoSJyGJM2dOyGyPefudoalFJm9fmDjfmmYR?=
 =?us-ascii?Q?FC5diHPfsq+5cu7Ot59Q3e3VV+zCYC5YoDYcT/+TL2gJDHU94N+IGO5XWGS8?=
 =?us-ascii?Q?deHLdDMxDlvjQFS/UR7ePj2LUH+fHd0wZeey45Riyw73zye2hTpAZYFYb9FL?=
 =?us-ascii?Q?PbZJNxghMY1DMR+2j6Ii0hbjmLIIkYRaTF4wF4R0ksw/zHiXFUT2rg7RDatD?=
 =?us-ascii?Q?l46PH7S9c3rNeBXzl93GsnB8xWrf/ROBFRVRADddggmc7zKL6I4ETAqyK1Rj?=
 =?us-ascii?Q?RBdjvLkjyjDt0qHreQPR9wuDG9vAfpZ+ATpq9jFQXVHytBEEOFG3tJcHYInJ?=
 =?us-ascii?Q?Ec0yI5T850syELEUh5jHsI6a6l5OBOcvMyrFSLik?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b35a5f-76e3-4eab-fc30-08db2c729652
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:18:06.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gwkoNnSC7DxXfrhHVvdnKzQrmUj0apkXWb4Wqe2xZ5sFu31h9P3+N+pJkT++jdz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 04, 2023 at 11:45:28AM -0600, Bob Pearson wrote:
> This patch adds a WARN_ON if the reference count of the object
> passed to __rxe_put() is <= 0. This can only happen if there is a
> bug in the rxe driver but has bad consequences if there is.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 3f6bd672cc2d..1b160e36b751 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -244,6 +244,8 @@ int __rxe_get(struct rxe_pool_elem *elem)
>  
>  int __rxe_put(struct rxe_pool_elem *elem)
>  {
> +	if (WARN_ON(kref_read(&elem->ref_cnt) <= 0))
> +		return 0;
>  	return kref_put(&elem->ref_cnt, rxe_elem_release);

refcount debugging in kref_put already does this kind of stuff, don't
need to open code it.

Jason
