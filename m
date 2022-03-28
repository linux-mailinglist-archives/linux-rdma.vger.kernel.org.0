Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E94E955C
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbiC1Ll2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 07:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243112AbiC1LgF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 07:36:05 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A785EBD8
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 04:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiRtXRv27fxGLkH5pdPNxWSG5i905Or6NJLcrLLgsvLYjdLAjhvk55Vh9RWECDC0ahNJaQwzeUxGjLq9P+bjzTg8M2LiQsLEYyBHTf8eC/wmm6gv1a4qwI1NzgjyauEKHRNz+z6pEuy1G/MaOEf79Im153lmAss9vUwxaonuUEuXNkrM0eFjtF0MW0hdI1/8DTcS5PshTWzlQbYcRkSFSz2mzoEQUPJXcrn95gEsZjZuq1mGIqbXknZEhjDnWwxFgsce2bbPRVybakrNlW0mvn+Qx7fU2oOYxnyF3p585XJo0YD+gYLQVtrGWKWf/0YIbu8wmwpoXXjtuIKCpLRTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYttxOvX3ZmVyxjOU+3CoPd1v6ZpghJulZrIUI68g1A=;
 b=Lo6Q5oak9MtXwssCAeCCz+PvTMkgmztTaXGUvtbim5eAwoMNY4QZN5qOvi4acdzc4uG7PC/W2lPBI3lmGite0vAj9bM84kwIOLP8GnUrYQFYOTKkhBlpVBJ9LO0oxR60OOlFPKhxSTZvTKgM4Uo/F2x4x3KTI6YyCNnmBsMJ2AetyOI7/NiJ79yzm2Tm/7IzaHWjlfXc5ryzpAYYVZwQWOuePmqlcH8jOJwwLW07WbYa5nWtjmH1rhI/Yh5ps6SZ54OE2oRaUlyRRwzxtr3MhzJHGtL6pB8of/qi6O6XZUKwi7YZbODiSQEzpKZWgarqWfpBJcYRqTBLgePgfXPVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYttxOvX3ZmVyxjOU+3CoPd1v6ZpghJulZrIUI68g1A=;
 b=pKsN9u8v/0SoWl7WBvInfhCoP3Xb+nk7hhUl7PawuMb4b7dYvFXZ6VVda9c0GMwO0sZ6p+n7k2uaO15XJymUBvlvmqf1iSb+pwDtkSQ6hdCjQFmZ7xdfVWCupi96v2fA39tVZ0KYyW9V6BOwF5MX3NdrPxTVRyrQ7vbNj39WBcy50X/O0oUnEQD1HccB//FunPdioAsvrPPAwN9GvU+QC9JfN6t2K2EzZnpKStPz7wcxe8zy9KEgoJMu6iGAZ6FlhRo0Ci2mDbtWWssv0XyrqKqxt+BpUIKwpYR3CmHzxtjdUlLWFgPz747g7d0Bdh2eRr8vCSU6rKgFcLZDzRY44A==
Received: from DM6PR02CA0052.namprd02.prod.outlook.com (2603:10b6:5:177::29)
 by DM6PR12MB2665.namprd12.prod.outlook.com (2603:10b6:5:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 11:27:28 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::3c) by DM6PR02CA0052.outlook.office365.com
 (2603:10b6:5:177::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Mon, 28 Mar 2022 11:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 11:27:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 11:27:28 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 04:27:27 -0700
Date:   Mon, 28 Mar 2022 14:27:24 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>, <yanjun.zhu@linux.dev>
Subject: Re: [PATCH] RDMA/rxe: Generate a completion on error after getting a
 wqe
Message-ID: <YkGbnOEe8GBhjNqN@unreal>
References: <20220328095436.304063-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220328095436.304063-1-yangx.jy@fujitsu.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bc639eb-c743-4cfb-6dfc-08da10adf13d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2665:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26655D12ADEB3F21247D25E7BD1D9@DM6PR12MB2665.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WP1Tvto+UgbVD8ZmJerDbNGLmfVR4CE2ptywFxutO1uYPFYdhenTxNF2pYh/p5mgqxiP7fSz6Mw86rARZ/5l4aJ1QPM853Tls2baECN1oZDmT+WPBpUzWiyL+/TVAYpl/dh1HiLH4UGxnMOy0I3lh/GY3MMW9+Cw3kqYbZ8VUr1GgDPn3VLbM+NTeXzrHfLLw3XGe2SUhIY1RS+fvpAu3L3CJgkbMBufjjieDPBDlx2JXa5hkuwdow3H9tEb3tgPQY9edNQuSo6am74kBsxRo1eORy8Q4o+Dh2V3SPw8DFTHgFqfi2fPQAPqA6Tp/RuzCUAVnoVAc4oDSMnINR3UlDdh1S3yEbPs9Cp2t5KecFZya3/dxfWq3DmkxuisNNwYYw0GfMlzW8UpXCBjA04zy2cMlGjyAjI25eDRfPdJ46eA25JN0vXJLnaE+aSuKCcsd//4pnsHKajTx/mHvvooBvBLrclWeFUOlvT+p6NKbtBTp3+QNhTSgYIdPq7C3qFK9eM16eKvzhaRxOh6wY3BGGE/rT/DPtcG6+GR34OtDEIlJOLf/eHIMw5hTCtD1dlzWJnkmEUngE85jiQqmwy+RtWPw3Y8u+cnBXVaQXs6C51LFLdN+AbsHgXmmiDB3BCqWRD8EcgO3KfseN5B157k2toLvsa1emDnNnUnw/5/cSPj2Vq9c84TxnC6e9aJzO14OCfTllJakt9mZ4wR69Ft1A==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(7916004)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(40460700003)(2906002)(316002)(5660300002)(81166007)(4326008)(82310400004)(8676002)(33716001)(26005)(186003)(356005)(9686003)(70586007)(70206006)(508600001)(47076005)(86362001)(54906003)(6916009)(83380400001)(16526019)(8936002)(6666004)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 11:27:28.7818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc639eb-c743-4cfb-6dfc-08da10adf13d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2665
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 28, 2022 at 05:54:36PM +0800, Xiao Yang wrote:
> Current rxe_requester() doesn't generate a completion on error after
> getting a wqe. Fix the issue by calling "goto err;" instead.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Don't you need to set wqe->status too to have complete fix?

Thanks

> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index ae5fbc79dd5c..6f8dd2b3b817 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -648,26 +648,26 @@ int rxe_requester(void *arg)
>  		psn_compare(qp->req.psn, (qp->comp.psn +
>  				RXE_MAX_UNACKED_PSNS)) > 0)) {
>  		qp->req.wait_psn = 1;
> -		goto exit;
> +		goto err;
>  	}
>  
>  	/* Limit the number of inflight SKBs per QP */
>  	if (unlikely(atomic_read(&qp->skb_out) >
>  		     RXE_INFLIGHT_SKBS_PER_QP_HIGH)) {
>  		qp->need_req_skb = 1;
> -		goto exit;
> +		goto err;
>  	}
>  
>  	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
>  	if (unlikely(opcode < 0)) {
>  		wqe->status = IB_WC_LOC_QP_OP_ERR;
> -		goto exit;
> +		goto err;
>  	}
>  
>  	mask = rxe_opcode[opcode].mask;
>  	if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
>  		if (check_init_depth(qp, wqe))
> -			goto exit;
> +			goto err;
>  	}
>  
>  	mtu = get_mtu(qp);
> -- 
> 2.23.0
> 
> 
> 
