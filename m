Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1B66E1C4
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 16:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjAQPLj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 10:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjAQPLY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 10:11:24 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD13234E3
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 07:11:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDeXy9NN4uTiaHzjHjP94G585GquqsMm21x1GU1jCmKXrPCU3EDZVSgkgSQ7hXueK1W+MW0SKnesSm9zeLtwwyVqPD635I4NA646o/Z2RsgQ8Buqlmz/yrQTHhccWtZNVSnV/KW0OmiPjfc5rl6S4ejmeEC/GjEcglvof6F+/UwqCLVWIsCTfdTG7GcRybWUuwsmESLeBU/+r37umbEg3dMyGFAs1V2FghfpVyQwXffsZgWoDtXbuWTcsBD266zDb3DkBmGhLZtm45yVf3GbQnyeQmJoztvgjffwxezqUPOWvCXq9o5ZFoeGGv2phU5+ELSqZEb9294BQQCtHiPUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXGMBz4DptspnS3cHVzevXC2yXlhHgZVkCAFvHcutFE=;
 b=m1tewkrp3Elppu4pMZSWjf2gThEnkh/Nxb4jNbe6wmaoKAb9FnPNrXeCMVBMn7xV0ROZBJVA0CywA6PVjkejH8qCayW5WA/PVc2dOv8nuFpSbytYJ63GugtfgvTTFPGIUP9krcG4vMPJiEfrt5svD9rI6I0wjKfS8kHR0lOOthHRGdMUTFccV0Ft6Nz9+aGEi9aiJHZH31NYc3eGmj/WqtL6oARPAkybHtfkpaKq5pODPPaWv0ldGwYpa2BQOM9xD5CgoEwUhzRiY2gT2/xxsUiwSLtKioPX3dw0rbK5Daq/hZCDORpDzRMh4y8LO19WR7I2aVRxJ45U4ZJV2dP8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXGMBz4DptspnS3cHVzevXC2yXlhHgZVkCAFvHcutFE=;
 b=nrxXUi5PEN5YS8nnXK9HmKRyUst1iiToCmPW+3HBnmTf/F40og7vSVijLnSGt1acaqCJzkURGd9ZNg1YDJg9zRE5eqL98jeqBS+ie1918gCWUsNGH3zKu9y44VxTHqBh+izTWJExeTFjeL1h0IMes8dAJ3CPs8TeHQ3TFaBmRx/GYD3sb5dyQU7eWmlN1B0q19LYPzd3KAfn3UWfsjTLXluWA3h4vvg1G/uEFa/nY8qN0/O9Ydfo4x8Ngi15phYLB5Qr4EVYEnGRHLQkR2/Lfv/q1UmDvCkNcLr4ehO4a09TveJ3goGiir3DkM2JDOGYrBGrr4ySFis4ZUeqT+y5nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 17 Jan
 2023 15:11:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 15:11:22 +0000
Date:   Tue, 17 Jan 2023 11:11:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v5 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Message-ID: <Y8a6mILrIxIwq4/m@nvidia.com>
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
 <20230116235602.22899-5-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116235602.22899-5-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR22CA0021.namprd22.prod.outlook.com
 (2603:10b6:208:238::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: e27c9a22-3cff-4108-d1b9-08daf89d17bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DA6M9szTv1Hs/DP7jbuINxpkxJWx30jdm3H5pW4aRRCtcvhoB293jrSXuXcr5umyopIiXlIfiIR/MArNPyAZjXq7UNTpxS82bSgiyfu+fp50x/mMv3OWA+op9kdnCc1aMmdsY/61m0AoDgBEFPsB/lY0srOXR+wYdqMCFciOr2dKE6toGT4BILvw36+2v7ZoJ6ov/yV+ugWJXPVGXUyssdUTuHQ5FnpC8ncW8lVxNZbp0PNXudNEM8HbXWmuybcTdFwaYYSFDBvrjL7j/xl7EIKfNyAAZpBK7iDFVy2ZFKmhE3lG+TKayRU93/iq7iNnqjVSlYV6gj1vFb9QzXDoocAeonbsGgXJs+pXRepCBLTz2jb0z+WPwGah/8bnjnZdlR/gLn8dGox+yr5bLqUbtr2gGbTviSdMCoRwlviDLXaNIw7VDFPLneydNHukWvYlh1XvHmEFmxuFLrW4s1TmOivDAOf5CHBRLJhjvDDHnpIosvLq0ipxWHVX4ENZZUuQEyIBzcQpBpCWo0wke3Rmh7AKXsm6yi172Q3+MIDw9zFDjWsFWhCLdt4LJx6LcxY7EMCQ7RsrgqtUb0eZexagsgvt14w/9C6BPlSNSpg5eXJcIH9im5lbMDV0PXu4gYf1YlkcEnmoINf5Gh5mfzN2fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199015)(36756003)(86362001)(8936002)(8676002)(6916009)(4326008)(66556008)(66476007)(66946007)(2906002)(5660300002)(38100700002)(478600001)(6486002)(316002)(41300700001)(2616005)(26005)(6512007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wWz79r5VXT3FErkHI2BZrSTrS8LjxZbyNXlNqQEqOCrFabdIO/Wt/BYdCjDx?=
 =?us-ascii?Q?+2oN0WUvcPFCNFagG8LBnU5lmqLcUdinsBLVq/AuCCP87mzoLp6EWy7cpq8w?=
 =?us-ascii?Q?xK91VeR4IBC403bFePSlLE2mce9s6yPLVghD1FPfF3b8yu4w2nDuSSeLXvHh?=
 =?us-ascii?Q?TMIthEP6AGuNJAL3SGjE4TEujgksupwYDDmKoOFYELZ/9TIDavsiZTePGHaV?=
 =?us-ascii?Q?FLOODuN2zKwdV9a1g7R8/eJs5szw/cwDPqX4Vfq6eCHZct/ljdM1SapE3LCf?=
 =?us-ascii?Q?UtVnQb+keZJ6whoI68AFgJGIExe6N3nTv4wVL9UgO1rFNRQb09ofkN2eHk+w?=
 =?us-ascii?Q?8wcz3t0nh0fO7DtQoAmXIQjX5jN/2Mw1JZz/G8cl0P7VKYnPsXghaIwIfKim?=
 =?us-ascii?Q?QjK+hFFjSy7ENtCj8KtPo8YQgePQSm97GijQP6jtyOP1OJv5NEjpO9PvO8Lv?=
 =?us-ascii?Q?yOB+BrmILlMJrA9WMrI64vJDJFODM//29KM/u0UvpF1VoXIGYFWxZ0BsvGUb?=
 =?us-ascii?Q?qRRqBSHLuwUhgdXcEn7hMgB3t2/jbyfotAzJkGSsqX3s68jhK1cdPlT02u9I?=
 =?us-ascii?Q?LSkJaadQO1hSzIvMG4a1ZfGt9hJih1Ij7d8zl9cjwtyBZafqYaoKDZfWvl7k?=
 =?us-ascii?Q?DLBQPbqOH7r0QVGeIbxTX8ntffWkmWo7QjWv5VJSJyjIDOS04m5L+583yTY7?=
 =?us-ascii?Q?cCYAUXDjnZYE7PiJTXg/xSiL+5koPq/snYcSF/F+uf8NBjL8K4g16D0Zr0j6?=
 =?us-ascii?Q?QPJGvpFB+sQneUq+2qZWYzNjhLWDmcsoZ2rX61Rz7ZdxbIL7ipzvvS8/TNZi?=
 =?us-ascii?Q?7qRcd+8F8ZY2ajY6MwEZ7818yIgCyEPsvfFPgdRxsNhxOIzWTUFtUt0M31cw?=
 =?us-ascii?Q?/gQxKfEa4ZCUofYs6NP8WrHZkyOzMNC2cUNtn9YI5PFl7CD8ZAiTaDFLDH39?=
 =?us-ascii?Q?/jrlURJ72RxENWdol/WCQ/Qfpsz/vHt+svD1kHs/42o2OBUh1y5HdQjcVnnE?=
 =?us-ascii?Q?2/k30MNsCjOykRv+9qUoS5tMcN7CRTAT3OgZVOApXoYD5Qw+cvk+bwg35tZs?=
 =?us-ascii?Q?1i53vtG4f/G5brq2r2EJ1KlrcWUyF1iSY1axAoGgw051l2jvHmFxnlGqOBTd?=
 =?us-ascii?Q?x68EJr0uzCzd58yW7ehXKPaFX7GJymhMExmKDrh5fB4jzHfIJIRo1UO9lcHT?=
 =?us-ascii?Q?fHmKDx7FBDmyTY3PZdQKFQ/t0OZkdHVgzx5vcGWMVF0BxJz9XipwibxlMWpR?=
 =?us-ascii?Q?05/3e222bVhTQESZ/anqZaHL979Idd+SiqgTUP69XKhlTahvo6VTKCCOdTTm?=
 =?us-ascii?Q?wZlGG5/pM+T1UWm7uIVHiXqgyA0sttUkxK8lQYuNsqMNMX5tp6ZohMyAgkhr?=
 =?us-ascii?Q?jBtfC4ESulkYiPXbroFR2PP0wg1XLiUzQ0IIWo0IO3mjQb71DhX7Q9ciFPBv?=
 =?us-ascii?Q?RPMFtcWjaadkNli5prM0HB1H0JakbHuycyNO5rRifHk8mL1Xu9sOtMA1Aq01?=
 =?us-ascii?Q?743p+Ws+DwA5qtco5hH0E/OTiHV2mQWGmhAzADpDEsQOHJGQKmZLAypgPNsV?=
 =?us-ascii?Q?vZjN7D/Q9mZ46pOwbUN78zwFfDTjowAq7//jinBW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27c9a22-3cff-4108-d1b9-08daf89d17bb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 15:11:21.9375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcVhlrysDWvL1x98iIR1TXoF0xY617GRinLUCBti20c588e2yHIb571D0ufJ574S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 16, 2023 at 05:56:01PM -0600, Bob Pearson wrote:

> +/* only implemented for 64 bit architectures */
> +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> +{
> +#if defined CONFIG_64BIT

#ifdef

It is a little more typical style to provide an alternate version of
the function when #ifdefing

> +	u64 *va;
> +
> +	/* See IBA oA19-28 */
> +	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
> +		rxe_dbg_mr(mr, "mr not in valid state");
> +		return -EINVAL;
> +	}
> +
> +	va = iova_to_vaddr(mr, iova, sizeof(value));
> +	if (unlikely(!va)) {
> +		rxe_dbg_mr(mr, "iova out of range");
> +		return -ERANGE;
> +	}
> +
> +	/* See IBA A19.4.2 */
> +	if (unlikely((uintptr_t)va & 0x7 || iova & 0x7)) {
> +		rxe_dbg_mr(mr, "misaligned address");
> +		return -RXE_ERR_NOT_ALIGNED;
> +	}
> +
> +	/* Do atomic write after all prior operations have completed */
> +	smp_store_release(va, value);
> +
> +	return 0;
> +#else
> +	WARN_ON(1);
> +	return -EINVAL;
> +#endif
> +}
> +
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
>  {
>  	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 1e38e5da1f4c..49298ff88d25 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -764,30 +764,40 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>  	return RESPST_ACKNOWLEDGE;
>  }
>  
> -#ifdef CONFIG_64BIT
> -static enum resp_states do_atomic_write(struct rxe_qp *qp,
> -					struct rxe_pkt_info *pkt)
> +static enum resp_states atomic_write_reply(struct rxe_qp *qp,
> +					   struct rxe_pkt_info *pkt)
>  {
> -	struct rxe_mr *mr = qp->resp.mr;
> -	int payload = payload_size(pkt);
> -	u64 src, *dst;
> -
> -	if (mr->state != RXE_MR_STATE_VALID)
> -		return RESPST_ERR_RKEY_VIOLATION;
> +	struct resp_res *res = qp->resp.res;
> +	struct rxe_mr *mr;
> +	u64 value;
> +	u64 iova;
> +	int err;
>  
> -	memcpy(&src, payload_addr(pkt), payload);
> +	if (!res) {
> +		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
> +		qp->resp.res = res;
> +	}
>  
> -	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
> -	/* check vaddr is 8 bytes aligned. */
> -	if (!dst || (uintptr_t)dst & 7)
> -		return RESPST_ERR_MISALIGNED_ATOMIC;
> +	if (res->replay)
> +		return RESPST_ACKNOWLEDGE;
>  
> -	/* Do atomic write after all prior operations have completed */
> -	smp_store_release(dst, src);
> +	mr = qp->resp.mr;
> +	value = *(u64 *)payload_addr(pkt);
> +	iova = qp->resp.va + qp->resp.offset;
>  
> -	/* decrease resp.resid to zero */
> -	qp->resp.resid -= sizeof(payload);
> +#if defined CONFIG_64BIT

Shouldn't need a #ifdef here

> +	err = rxe_mr_do_atomic_write(mr, iova, value);
> +	if (unlikely(err)) {
> +		if (err == -RXE_ERR_NOT_ALIGNED)
> +			return RESPST_ERR_MISALIGNED_ATOMIC;
> +		else
> +			return RESPST_ERR_RKEY_VIOLATION;

Again why not return the RESPST directly then the stub can return
RESPST_ERR_UNSUPPORTED_OPCODE?

Jason
