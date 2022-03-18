Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331E54DE0C6
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiCRSJA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 14:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbiCRSI7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 14:08:59 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2083.outbound.protection.outlook.com [40.107.100.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6472EDC09
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 11:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKgMDEgv2g9H0KogPbKyqX/Z2lnslj1/TfN4kOiQtKFFx5rbWIJUCkpffXHGjksbtEaLc1y3xe+2XC9FY1Hx/wGV5c5e2IzTN/bV1NKzb+nNbp/Q33PbP1rtpWt5glCv97ZxEJNsi70DU95RbsTRZrbKWtj/+wGrEjIX9X6nBfIrS6QOCBoe1itEWcdcqwZaEt/hU+4ez7v8BNSfwKziDpXte+XBjUgnY3dr3c7kTN3dnLXa2ppmJDUOBAX2mkx52ERem5lZbrhQVx9XND21fQCkElkJjVajZ+1a7ssWoBWyUD0GqIv5q4DH06KT9fFVhVxL+e3jQHGeLAooEMRt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afrqp/Dn/chsKJZMDz0RGvd51wsmStRi5dTn3vz1crA=;
 b=EUzgaJH4BVoKYjHQyoenuadDEXtP4Qb+6HaLlCza+Y+8HjNIaGcGoZ/uPHZhWaP13doIMVg+IoaegcFDsOGFXvDKtYvDzzx7FGB6vMdA5a1G4wQVDkQ4skQrQhSUUMZxsbXEOMHNQNd8Zbujmu3YAXZI8MzPv0K3quDFcnUHa1f9mT+jQVZn0+EbFH/L5AJBh0XQ5+199sLC1FBhiUNAh+mO3xigoqrwaW/5z9bTxiscjRz8mtDOn7LzL0q1pYvmzxxywzB+frrRoGnwXCkSEGf817Z79vhj/LMDUoSrxMWIG17k6EsMJ7UMoeVcbSddHrGKayByiUkpFBUhRsU0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afrqp/Dn/chsKJZMDz0RGvd51wsmStRi5dTn3vz1crA=;
 b=iNGmgNtXwsK+U1zR0Q29EU772JWJ7VVpJaMp5s33GWFfdaVCO7O22yAXF7i88xX/lvHZ5PyJtX7vWfsXGD1CvBXG/FncLOOg9A1ft4+6c/5bBPVEBsn6ltLQ1vT6AVouTTbpkjTaX1crnmdiPFEGcwA07DLerLSq7rUmJHlxCQbCxQ3AG1BuQDCnmFaRrj9Gm2uGsHAcfhYv2NjFAXu6/GR+kvPf9H1G6UA5OhXB2YtHBngFRfP65adqnMNScEo7KKwBAGzoDZWKNzYyKN34UtyhmRLKsSs0HY/XoMf1Yii09KaX8TpxTHNX8I2CmJHo83zrziocOG7dBHUAqUEJ5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Fri, 18 Mar 2022 18:07:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 18:07:38 +0000
Date:   Fri, 18 Mar 2022 15:07:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v12 08/11] RDMA/rxe: Stop lookup of partially
 built objects
Message-ID: <20220318180737.GX11336@nvidia.com>
References: <20220318015514.231621-1-rpearsonhpe@gmail.com>
 <20220318015514.231621-9-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318015514.231621-9-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:208:134::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9e9d47a-bf56-4dd3-fd73-08da090a2f99
X-MS-TrafficTypeDiagnostic: DM8PR12MB5398:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB539895A78391BB36996754CBC2139@DM8PR12MB5398.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ScduHJqPkMNSNdH0ZIRz5nVPY50ElkjUwBMUyT8TrA3Fpm7PUaZG7M13k9HyfgF1DiZMBMap4hEBJUCzSiBN7sTmH6jL6wzU218nQr7Pw7wYIlELZFuWAY/3o2+LLJNvAJ12FUidzNKQfn7N907K5LdNEcBPjvolfkM55wrSp7ujPHC++cDF4oSmDcStzLzlDut/RP6TNohHbAO2spzlnyFOgGdHu8+OPOkFLhsa/dyV7kVzJjLtCKbzgcF771i2K1IURbrih77oc29D+MfvJzOLcOmhLwDDajizAYcJVRLWbd65uCQXoD3QwdbKLOmgtiJeJK2UT8txPrHAoIMBAIl2m1TkDxN/L3kCNv/OySmFkdFL7jOXnfCSG41ZcH5me+D3r+r2ZnLg+3dVqLnFSAvxS140OsksNrWOgk9P8VdPmvnO3qGDVHNpVtf68W6RKOrKAvgMQIblxYg1W0OF/OUVTB1OXW/R372P9UrUNoJeBdAcj8mCvUsjdKzotGnF3jwmSW0PICKbh5beEFsDt+guTBMnfg/juw0Y8Kp9lgifNvY70RDFIr/CB08QG9T1Es+h6DbkYkoHZQK6zTNcwX2j1HCPpJT9LpmPO+X4OqrW6g+qf249Y1s0bi1qPPqiJa+c+mdbLPY2UE1OrIRyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(8936002)(66946007)(33656002)(5660300002)(2906002)(66476007)(66556008)(38100700002)(83380400001)(86362001)(8676002)(4326008)(6486002)(2616005)(26005)(6916009)(316002)(36756003)(6512007)(6506007)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UngzM+NUGflpIMplD5ebsHNc5eEVOA/ydMlFT0vTZrN83beXHBumHw5pCLIZ?=
 =?us-ascii?Q?Eb2EGIQsoTUMO+Z+Wwti9EFKhedQSOfhZ7zd7k32NJ8/v8M4Cx3xLg0sqqmC?=
 =?us-ascii?Q?OpGK5+tngM2LfQxXPdW5FUW1H4inDgP2BzC7fMFeCEIHHvCp2a2TNB+VcTY3?=
 =?us-ascii?Q?4rXcgdyvfeb1BtTyzqPFPnQNg67+8i4RZZ8EcqRcvgj5H8lXtnWZoIhjOCFQ?=
 =?us-ascii?Q?1iWiKddB8OqNFFcmxuburRUvpDXpuqo/XZStX13LsQvr0yUzHqgO3CMbfttW?=
 =?us-ascii?Q?yi4uqRXy7XKzehO//9rslsYJXENFI2o2BtRjcnPWSr1lNxQZtO8zH6aPLQGp?=
 =?us-ascii?Q?XlTCvUZiAz8R8kwIojljlW4TormveaDrmUQBjWrvfO1xXvwE/CLVwef0Ml/5?=
 =?us-ascii?Q?oWAc9U1Z5iQYSw+FmHjyIWWVeejv+vNen3Xo87urIpV7b7cK/upr0yNbnTDA?=
 =?us-ascii?Q?0mpSKYCptGk091BUkneNHZzznErEc1tq5FM4Kw5t+MzfGdr1C3K+PrSRrnab?=
 =?us-ascii?Q?ieLUZx0vp3nJBBj1wRlA4VUat6030SIajl3PmcicpeIsKDjfgBqGAeRS0cnt?=
 =?us-ascii?Q?Kf4bqEMSkgBx8V1c+jLGYzkFTTTwlYYxQd/G5Z7AQGUTQ+pTQt90+dGu6Unk?=
 =?us-ascii?Q?i387z1ZNQ5+MT9R77V0bpX/woDZ4k49YT9g9xJovFcDs+NcrNDZ6/kxzL81K?=
 =?us-ascii?Q?1WyUrg4/JGndiOblKhfm/IrECvz+aihWNAmQG7DIroucjktx5S8YizHx8og8?=
 =?us-ascii?Q?9D5FP7sNYKqUP30QOgb5Y/L9dFxW7EhBD9NE8vQXvY6hFyVVI/IUDL/jgCnt?=
 =?us-ascii?Q?tk24f74/GDfwkH1oEXPw+3GYjLY/1MKC/1B/7SkrrUnA+84M3v+Hco+shAvq?=
 =?us-ascii?Q?Qmf4eUuGS4oiFgvB8qG9vRaAxLBgKQbnDBwxsN3dGFE3qxSz9kctbiupBYQj?=
 =?us-ascii?Q?n/BX4uSlbfa0u1ZEbaYcWajReeXKhufcJts93i5W2ytMlm3Sc80sobhPOE0Y?=
 =?us-ascii?Q?W6R56sKY3kN6rNj2Nek4fN4a/fIQvmUUe2ii+jjpnHuI14gkN2HzoDfchdib?=
 =?us-ascii?Q?X7yGFkExm/QHkdwDciV1l24qNA81B8auF2PT9KDVD+jJT7EdKMNHvWgisSjF?=
 =?us-ascii?Q?SN67/zX5VTCibhdSSUqY1VbK/4rzpRHnYUotR5cNHlRJXLWng18viUGpj2uK?=
 =?us-ascii?Q?sbxe5mWSLx2LRvUmnnnQJ/LsuQeNn+S52TMrOw8ExRPi0MjvzzuBS/YGmKQK?=
 =?us-ascii?Q?UPeKj+PtYKshsxE3tOYRFYFQDnwB14X1daHNAKFm8ef/891F2jDF1eTpojqq?=
 =?us-ascii?Q?Ff/Lab11NhkcjmTYFaBrN/FJR87Se5KIvpZb11sVeV3BCUIeTWjTJTSlqYIl?=
 =?us-ascii?Q?q/GBuS8YBKKilKzFuNSkiaGwr54j43rddSsqe23Dts92kz50UntEAUeq2ymH?=
 =?us-ascii?Q?wgtd9OOh8wuJgLRODGEAj1r30RtGG97p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e9d47a-bf56-4dd3-fd73-08da090a2f99
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 18:07:38.1947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOXYCAOHXJMtTI//UkRzFrYixN5EgTY06+urepQJgxAWGYZbHBNxbQOA+DsVPPGs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 17, 2022 at 08:55:11PM -0500, Bob Pearson wrote:
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index fc3942e04a1f..8059f31882ae 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -687,6 +687,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  	if (atomic_read(&mr->num_mw) > 0)
>  		return -EINVAL;
>  
> +	rxe_disable_lookup(mr);
>  	rxe_put(mr);
>  
>  	return 0;

  
> @@ -32,6 +34,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
>  {
>  	struct rxe_mw *mw = to_rmw(ibmw);
>  
> +	rxe_disable_lookup(mw);
>  	rxe_put(mw);
>  
>  	return 0;

> @@ -487,6 +491,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>  	struct rxe_qp *qp = to_rqp(ibqp);
>  	int ret;
>  
> +	rxe_disable_lookup(qp);
>  	ret = rxe_qp_chk_destroy(qp);
>  	if (ret)
>  		return ret;

All the places doing 'rxe_disable_lookup' immediately follow it by
rxe_put(), except this one. This one is buggy and should be ordered
after.

If all places do rxe_disable_lookp()/rxe_put() then I'm back to what I
said earlier, this should just be a function that does xa_erase and
forget about 'disable'

Putting the xa_erase in the kref release is a mistake.

Jason
