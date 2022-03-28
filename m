Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9F4E9F26
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 20:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbiC1Ss5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 14:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbiC1Ss5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 14:48:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5335FF00
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 11:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euF/QW8u7+9964/RxF0X5apYIrTVci0DOCcvSemz+cPdL0WTHjWMEGU5uC72n2I8rEBU75IpKo7knhFTAjCP3fAcCM7CvGN0AJJlSu1xxMmh+QInmac8/HJ1PquqXE+NYZNlKGDXUf5eHYmEi5tKlj0BpNarLRK62iR9QR84746xPCQc/IZ6H3TmhZ4ZG2xtbGfHCc0Hq47whn/eAR1Uu7g+qfNtsALIgS9IiKXXphUWucLDq122RdnQZKu9AETMm4hBxiGV3I3GOXlhNmhpgqLzMWCrR+95R5UA4rUJKEfZQjONLNq6f4uD8m3MwXk4wASsSDlAZl/pO5GfSGSXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8S9KHdxXy5vLn7qOQNnu/KYyYAnakQnRhUXtntkohM=;
 b=aF7TdKQPQi2YffCdbt9SLtk7462qMEwCNQbEtEd9x5mCPoKyOVz/8R+b8qyMX53avQrEisUhdUyv4kX9RUjj+5fZphRMR16UvggMnM9U+BgoooCcYGI6od1o6VKKTYMc5VTx0DtpCcMjGaqzGWeRiQbnz8iClw9comctctk2ajhtewE6FXIJ8hn7aVMF25P34mtR6+/PesjZoVsYsCbiYbWJAxa8urr81VqEhPPS4dF1dhrVniPJLUvfrjzlfrCRCCqx06gkxkpbiZwnHVjjwd5YzyA2n6Hri5MhGB19Vv+vRQf+7MnwBDFdkgbuHaDFANXfZb5eRBEwsplx/D4dxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8S9KHdxXy5vLn7qOQNnu/KYyYAnakQnRhUXtntkohM=;
 b=eJqP0YHTtbJFqW88n2JgKBUmyV9ivcfdgyq3lPyGuJ9PtGdOqjrcvrEZfv1BemTDt339qYhZzIwBe0MLlvFJFvNuFnS0eagmhDsT4czjmanHUVsQebJeRmXhqY9tvlNHaTd0SNC7vxQAQU6pXIXcsLxMunMBhO8+MXvezux/4lHYKzplHNCLpzJfL5nFhc5MFX72vmKOVyvKFjdfjDS362/zjHvk4daXRK/+68d/GA5Rf2700oYuBTVIZFetiKRtjNXILbnfPjVSbZBerO3jTU/sw1TW1fhh702ZSr5H86z3rI8/hKGluGH3b3OtHXmH5pNUPYqMfvFyrnBhA5+/xQ==
Received: from DM5PR13CA0013.namprd13.prod.outlook.com (2603:10b6:3:23::23) by
 BYAPR12MB2614.namprd12.prod.outlook.com (2603:10b6:a03:6b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.22; Mon, 28 Mar 2022 18:47:13 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::d6) by DM5PR13CA0013.outlook.office365.com
 (2603:10b6:3:23::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Mon, 28 Mar 2022 18:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 18:47:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 18:47:12 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 11:47:11 -0700
Date:   Mon, 28 Mar 2022 21:47:07 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     <linux-rdma@vger.kernel.org>, <yanjun.zhu@linux.dev>,
        <jgg@nvidia.com>, <rpearsonhpe@gmail.com>
Subject: Re: [PATCH v2] RDMA/rxe: Generate a completion on error after
 getting a wqe
Message-ID: <YkICq+3JmsTSrELB@unreal>
References: <20220328151748.304551-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220328151748.304551-1-yangx.jy@fujitsu.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7826369-eaf3-4db7-bf08-08da10eb5f58
X-MS-TrafficTypeDiagnostic: BYAPR12MB2614:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2614F188F8394B2A2610FF84BD1D9@BYAPR12MB2614.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2pp34+nd1ITYno1YZYT4v2nPNXh9S9j/3Rd71tlI1z8eBfA16J8zZE+LGf+RhqtjntUPyP+z9TAa9cBqvIWWNjtwQwrFHbFExGOEKydk9D61tHXl+331zJ06LLQ2dHBB8wU+BoSTDxbcB6pgYdLPgOcylRATC1fBaVnDuBwy+UsJ/XAg+n9jjHzTB9L92MWiEYpp+JT6bX6Ur+3VX4WmrFhJOawazSCCaqEaX1W7By0T3LXr7v55tqqLfceso2yz2IaTA60h8bpdmWGVVTvrzSqVcNMfeCPgajk28yRVLQe0Ix79FSBPlTleS7oTWyD/NbKgBwWiN1SfMMLeNX0k0l4xRlNmLInnNlsAznG6FqtWUAenWRb50xeIKFwJoQnGUhcMUzNKwk4r/BSCy2QcDmdlnctnjA48jbjHVlmWCjSds2EnfuKRvAq3EjLX5/MVZXfWrCc2IaawpQslMguDMvSLxCP4wa6aIUky73JQ2WXImf9oRoh2WzHxCF+QVIKQDrhxj+YthhWwoeZ/9Dpas1kjA/hNlWDxWcmgo+4M1CZdkZSDHfnvajMlviIFCh1FWwjhxMcTd0WaYIYgw2Urk/B9ClKzb/F/ZmQehV2+/KDOQfAcT2gRrzw794j9cGxOhjpCtZQae6zhTBeFHHM/jPjrG196cXIJtrPbyZqT/OG+aXfA1ULHJrpIywRfUkH+H/OHhTmHg81/eHUPgLo0rG9l90UEy90Dg7dgGDQ/A8=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(7916004)(4636009)(36840700001)(46966006)(40470700004)(426003)(336012)(16526019)(47076005)(508600001)(82310400004)(33716001)(26005)(9686003)(5660300002)(186003)(6666004)(83380400001)(81166007)(8936002)(356005)(6916009)(2906002)(8676002)(316002)(40460700003)(86362001)(4326008)(36860700001)(70206006)(70586007)(54906003)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 18:47:12.8107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7826369-eaf3-4db7-bf08-08da10eb5f58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2614
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 28, 2022 at 11:17:48PM +0800, Xiao Yang wrote:
> Current rxe_requester() doesn't generate a completion on error after
> getting a wqe. Fix the issue by calling "goto err;" instead.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index ae5fbc79dd5c..e69fe409fbcb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -648,26 +648,30 @@ int rxe_requester(void *arg)
>  		psn_compare(qp->req.psn, (qp->comp.psn +
>  				RXE_MAX_UNACKED_PSNS)) > 0)) {
>  		qp->req.wait_psn = 1;
> -		goto exit;
> +		wqe->status = IB_WC_LOC_QP_OP_ERR;

I see that you put same wqe->status for all error paths.
If we assume that same status needs to be for all errors, you will better
put this line under err label.

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 5eb89052dd66..003a9b109eff 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -752,6 +752,7 @@ int rxe_requester(void *arg)
        goto next_wqe;

 err:
+       wqe->status = IB_WC_LOC_QP_OP_ERR;
        wqe->state = wqe_state_error;
        __rxe_do_task(&qp->comp.task);


BTW, I didn't review if same error status is applicable for all paths.

Thanks

> +		goto err;
>  	}
>  
>  	/* Limit the number of inflight SKBs per QP */
>  	if (unlikely(atomic_read(&qp->skb_out) >
>  		     RXE_INFLIGHT_SKBS_PER_QP_HIGH)) {
>  		qp->need_req_skb = 1;
> -		goto exit;
> +		wqe->status = IB_WC_LOC_QP_OP_ERR;
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
> -		if (check_init_depth(qp, wqe))
> -			goto exit;
> +		if (check_init_depth(qp, wqe)) {
> +			wqe->status = IB_WC_LOC_QP_OP_ERR;
> +			goto err;
> +		}
>  	}
>  
>  	mtu = get_mtu(qp);
> -- 
> 2.25.4
> 
> 
> 
