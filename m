Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B3E5B16FC
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIHI3x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiIHI3v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 04:29:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED8140BA;
        Thu,  8 Sep 2022 01:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le8y/SjaEZQqyb+iYCH0mvrPtWqyXO+Mbudk6xFXGT1lJAuSS9FMrJSfXIX/nJve4jD9u2FSg9BDN81yhEda8PlOKaZy6gdxrxHefKKzgCgDjt/OUTgVDol8g8+VCDBvoDQPxkH6utcpfGXSAc6Hk6bxddUC811Xhl5M0VhlCwawz+9cWqs36e2leW+Bq6eMVklsypGT0hn++JkQ6G9URQwluNQFm8eGegEIJP1dJ8/7QoIFC6XNmtnUTp5/dmDLUPm/iByK50jHl8/QVe7xh5bfplesaF7hPXVbF00fbbmyWXWQX2pdVK5quBPCn1OuKreDM9GKBJspPigscW/cPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPBO283VD+iPPGxwk2M442AUVszcSusnSMGcr8Nb7QM=;
 b=VvN9Zxibh8QVgrwA3lbeKT0Y0mipWAg+JmpQETt838lxFnMDhz4oqM8v88/uaQa1IbU8LWXtKQFM+/DBLw3g3YMx3WSpOMABVD6twXK8O3Ut7BQK43S8h5cAnUsDvfAWxNXNt5kOQ4PoEurBCa8OHamlWIWo6zVyYN7eqMtx/6k1wJuexIOw5C2NM8Rg6w9xqp/LyTxVuMcUDq4T1MFHyF7cZOXsFNFkFsfgdgCkk2H0tg2Tn6rFtYGnkLNxGsct1/gxYZli9FRDKAwK3EG6hImrFoofQFtH4McXt1LaS9d+HA4ipyvPsZUVcaLxmo4hWZZ5IFt81fDzq/gbMBHQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=fujitsu.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPBO283VD+iPPGxwk2M442AUVszcSusnSMGcr8Nb7QM=;
 b=oQQ0WmG4x2xJ4cP0zDhkx4dUFpI80pi3uUg0WJg5fWGz6X7DjyrwW73APQZNV7DW7QvH1DKXvhDlekIJr5Nv1+tYcQJ0TPyIoZnZWH44V0xug6u0MZ/DvBR4RlnzGsLVPSGhqmUMDmEvpxP0a4FeAW47p8UmLLmBAFZ0V1NRstGyKd7sa4WJjmrwma96iOiwCeOHtcTViBu3A6hPtaSi1zwJ+/G3xpRpjDChItRab9nSsR0dA/ZuWhWZ8y4SO9bdl4h+l2qgqkTA5i5qzwDsGN9ivuP0YcLpQePzo9n4u7q/BaWyv29WVaDiTqUM8juVhPSDFkaPJabJP73n2mqrrg==
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 08:29:49 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f9) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Thu, 8 Sep 2022 08:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 08:29:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 08:29:47 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 01:29:46 -0700
Date:   Thu, 8 Sep 2022 11:29:43 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
CC:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <zyjzyj2000@gmail.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <rpearsonhpe@gmail.com>,
        <yangx.jy@fujitsu.com>, <lizhijian@fujitsu.com>,
        <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH 6/7] RDMA/rxe: Add support for Send/Recv/Write/Read
 operations with ODP
Message-ID: <Yxmn9xVGEXmQIuzq@unreal>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
 <f2dd21a3d0f2005e02c34c793325317f1c326ce1.1662461897.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f2dd21a3d0f2005e02c34c793325317f1c326ce1.1662461897.git.matsuda-daisuke@fujitsu.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|DM4PR12MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7dd586-fa47-4826-053a-08da91744b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CebqCxNhKmtDv+rylKLycMmrzCHLonlyZCnjOiSeYdp+n4tyqlEvwQL0vNPrZR2Q/LkpmyMKznCU+EoLuqbUl7UZQ2wVUXknNAvOFJGGqMZE5iHeb+J5KsmpJj6FF5FBCfHvQFMeFxSDmzcscJAkfh+kWWxV8VGyMu1PKoXhOcvBeq3DjbpJsvqKq4opBHxWTB0e0lL9QdaL+cB6oj9BLP5UM6rFNI9DfY8NfV9GvkXuZ3+7KQl/At2WaEtle0+9tYFQy6BKy1XDy4DJAb1Yq846OgmJJLKLQeIRd61IGymNNfjbOCuKElxWDSxSP1xwmd9DYdds+ruSWsaMEjoeuJpFLVy0rGEe/F2VYlif95MZPJVLD5N3B/PAwj0gi19DPakgcoURVNy9ggn/E6WZi914jAbe9d+iwpPA1yF5e7CugbGbDjnuy70SsIBXcTib8GEmXR2RUe2Uh9qqM9DDHt8o10jQlB30pQaeDLFaD/cNott2kmN1cMVai2Ar7KU658ANcaz5YoWd0LxJSebI3ZScfDN9SvM9lxbtzoqLEtfvtB6d2qgzm3g+fE6IseARUDVeK6W1o5DFrnBi/4Z3HjyDnSGaaSCJzBO2eu0HSGLuUSvppU/ntYykgn7o3K+I+qhnxmRokPrvY21xDjAVNfaakkUtLE9Sp7us7vZ3OsrJyG8chkrYFWwokaU+7/nD75TEdVmXd4PPYe99xB13GGGs5jdOMZ3J84pxq7R7r9DwQ2TZsP3sPPyUyloXqQ1eyOKmwiFeJrZTDK8w5PP15YYuqDxLvQDDii9PQhPpCGc=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(7916004)(136003)(396003)(39860400002)(376002)(346002)(40470700004)(46966006)(36840700001)(40480700001)(4326008)(70206006)(33716001)(8676002)(316002)(8936002)(6916009)(54906003)(5660300002)(82310400005)(2906002)(478600001)(41300700001)(6666004)(9686003)(26005)(70586007)(186003)(336012)(16526019)(47076005)(426003)(83380400001)(36860700001)(356005)(81166007)(86362001)(82740400003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 08:29:48.7352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7dd586-fa47-4826-053a-08da91744b18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 11:43:04AM +0900, Daisuke Matsuda wrote:
> rxe_mr_copy() is used widely to copy data to/from a user MR. requester uses
> it to load payloads of requesting packets; responder uses it to process
> Send, Write, and Read operaetions; completer uses it to copy data from
> response packets of Read and Atomic operations to a user MR.
> 
> Allow these operations to be used with ODP by adding a counterpart function
> rxe_odp_mr_copy(). It is comprised of the following steps:
>  1. Check the driver page table(umem_odp->dma_list) to see if pages being
>     accessed are present with appropriate permission.
>  2. If necessary, trigger page fault to map the pages.
>  3. Convert their user space addresses to kernel logical addresses using
>     PFNs in the driver page table(umem_odp->pfn_list).
>  4. Execute data copy fo/from the pages.
> 
> umem_mutex is used to ensure that dma_list (an array of addresses of an MR)
> is not changed while it is checked and that mapped pages are not
> invalidated before data copy completes.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c      |  10 ++
>  drivers/infiniband/sw/rxe/rxe_loc.h  |   2 +
>  drivers/infiniband/sw/rxe/rxe_mr.c   |   2 +-
>  drivers/infiniband/sw/rxe/rxe_odp.c  | 173 +++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c |   6 +-
>  5 files changed, 190 insertions(+), 3 deletions(-)

<...>

> +/* umem mutex is always locked when returning from this function. */
> +static int rxe_odp_map_range(struct rxe_mr *mr, u64 iova, int length, u32 flags)
> +{
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +	const int max_tries = 3;
> +	int cnt = 0;
> +
> +	int err;
> +	u64 perm;
> +	bool need_fault;
> +
> +	if (unlikely(length < 1))
> +		return -EINVAL;
> +
> +	perm = ODP_READ_ALLOWED_BIT;
> +	if (!(flags & RXE_PAGEFAULT_RDONLY))
> +		perm |= ODP_WRITE_ALLOWED_BIT;
> +
> +	mutex_lock(&umem_odp->umem_mutex);
> +
> +	/*
> +	 * A successful return from rxe_odp_do_pagefault() does not guarantee
> +	 * that all pages in the range became present. Recheck the DMA address
> +	 * array, allowing max 3 tries for pagefault.
> +	 */
> +	while ((need_fault = rxe_is_pagefault_neccesary(umem_odp,
> +							iova, length, perm))) {
> +
> +		if (cnt >= max_tries)
> +			break;
> +
> +		mutex_unlock(&umem_odp->umem_mutex);
> +
> +		/* rxe_odp_do_pagefault() locks the umem mutex. */

Maybe it is correct and safe to release lock in the middle, but it is
not clear. The whole pattern of taking lock in one function and later
releasing it in another doesn't look right to me.

Thanks
