Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2D5657C7
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiGDNtl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiGDNtk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 09:49:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835376452
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 06:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0vp/q0Z5oZmQlEyaNA2pTIQ+OneusmKS7SCUh5AvQh87FoBjCXzlONBiSyvIDHG+wFi/PYCtWV2W1D7En62REXS0Vuwbx/tV7jTgMGBxEARvSAoPbLXcwqOML7Q6ClmzBzObNydZHmYROiU8QLkDCzH1nNVWWpZXmxEuAAgou20Ini/d6ZTBHTYPa+uh7g88SJzXV+KEB9/x+YEZ7KW/TFqsndxbccGtQh9OrNrUi3UUW65UMXldqogf7R03hXKzlSp8nk8jjps/vwTXhNRdddSxMHLzxr9nIYuR0B3Gz5XZNcrQvxLO7sPIItMu94kNch98CB6+/Vr29Jn3Vbofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGmsGUxvG4TPj/Xh511J3hD4hE7yVIQtENaa8M5/oKU=;
 b=Nd/eDByu8pqKdFRAvgDDrKF4JYA8xqZzw7n9R+AwnCvBxkj7Ut2dtZfcQVIB9nMz7farfxC5p+C78UgJvQBqY2texyHzyGmtcX55JoRYxv/1j8egS9z1pOJ4G/OioGYUFX4xHvAlbEcMuwTycUf1Iv3LClPNF2YbpRQXul/GNSF5PGNgXjGfaWS3LStF4axYAYIlRFf4vgRnQch4MevgJIpAhpoHzMzHQcZPrV7Ij/M5dMX8wuPcdpcove60495ol+ol8CmlF0mcFyC8BzIMKylHiagGT5/1HRruMtL2ByAkLAnvyNdSXZUu36uRfH6Ufx9PQ0MJ3rsg0NquPKPrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGmsGUxvG4TPj/Xh511J3hD4hE7yVIQtENaa8M5/oKU=;
 b=XucUJwi/pulYfaY2eF+K4pi4717UHBLIF47E73PNkPR8k2aiKUugBK0ioIo9p5Hi7YG58FK+gdYooLRwx3x5v7ahIiTGtBF/mwtezdS787lMF6xqUn7qVe2+SYaZvM88978sSJOZF/UmTDEnqvMmKzHw9csgHsCjZG5Hc2eKci/ABcY6WfStFbPDHZQCZbF+8VIPVA3SlXO8Mr+Jy8RZRWXqxboVtHkHJH2fi2RK/juEz1lWWb1v/BQE7sUC7Gdex4QsQDar9HJsWhv/JGbb4CLZnZZC7d3LIEMzUIS3j9hphNhP+lYhj+A3dipDO6b5Fvd57movoA6hB9hZRFOQAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB4742.namprd12.prod.outlook.com (2603:10b6:a03:9f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Mon, 4 Jul
 2022 13:49:36 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:49:36 +0000
Date:   Mon, 4 Jul 2022 10:49:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 5/5] RDMA/hns: Recover 1bit-ECC error of RAM on
 chip
Message-ID: <20220704134935.GA1422797@nvidia.com>
References: <20220624110845.48184-1-liangwenpeng@huawei.com>
 <20220624110845.48184-6-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624110845.48184-6-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL1PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40a56765-5633-4506-ea21-08da5dc4087f
X-MS-TrafficTypeDiagnostic: BYAPR12MB4742:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nb9+JP2mnppSVZe4ViZ4Eo143RixtZa9+L53p2X+bUKsdYb/fVLH1C1iDYPpzFCzC4AldWw37rXgQpHjuC92JuTpRhDQux8csYvcTVpPziEOfR9132zflbqpQcUdmChidJ22wK4OH5Ecdqww9tQUZ2mIUIe7rKGqAcPL3f3qOn+glIsvMmzPWC6C1q5rmGEk6bEfyRn2p+qnKGTUym535NRnLCWKSi/rMmPTH6vS22hmjMUrufj7zDEgLt9bdcvo4Ewj7B+QPoQKg53u8S222tm8e0ArPIevkdC4tGHQPHOTKADbSaIyUBw1o/RciB94WN7s3AOBNkHK+wdqKJ18+AtboqAK+4aSPgGxVQ3VTL5p9LB8MfwrckFlgb/uBej63yQT+ZCe5qtUCKfBxnl+jdEtntc/S1zQT8jGg9EpPKq/cVLd5jBojXg1VhsxBdJoUWt6SySGpchnTO8pSwOqWAMK8Ahqecszc9SBKG/iIzAfINwmLIK44n1iwXi4RWGzqEXrsMI07JCZVWXXrpsH4azEeYU3zQSaOFzvBFZ/vg4AreXgTXQBJZdDj+ryqmtczEKIRIdIo4lyHNHGn953AVrJNeTkag4TcbNRESSrUgC7lSqiwL6VanQxQunXHqFeIXN9ERbc/9a4iid9PdFwDBCi6GEKh8i89HVJ9cbRHKlTpi968clFJ8C9yBDVqGR0Le5AmUgN+R7H6D/MH3PGelxo1pif/Viy5PVttkTyBK4e3DKHAjgAg4o5k+DuzwrU8OrkuB7d7H5a+VwJkBnfhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(36756003)(41300700001)(186003)(8936002)(6506007)(1076003)(86362001)(5660300002)(2906002)(6916009)(8676002)(66556008)(6486002)(478600001)(38100700002)(2616005)(33656002)(66476007)(66946007)(4326008)(26005)(6512007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YvIzoYNkXbU6UPDqOYV05ZrQKBiKfxtieu7lNekwqmhhwPqMVBXoa8pFnOyV?=
 =?us-ascii?Q?C9TlCJq+6Pg/Cp0zR6/dCxRgOcfmJuq6Fe2EH2FDGuZxWAZKp6W9t/cNy7PF?=
 =?us-ascii?Q?OKNqTkXeXYpRdBR6iQOG8iL1PxGznVWS0kw/vG0+QM4dn2gD9o7fSW+KVtuC?=
 =?us-ascii?Q?WSk6Uath8/qWpGmSSSaWe0NKMtABR8rRK/PSRiTBQV6UTMK7uGGXEy+xlXLV?=
 =?us-ascii?Q?gq+3abjFXmE+QEZqBnmuTdt3qwZ+bnW+/IjSVsxUsXhZ0tv6xHy6I8DOUv8R?=
 =?us-ascii?Q?UVOoWhSWTXYKY4qKui8rFZDukpJQw1zBf5jDDfyOlvJb46O5cn6t4ZYTIQ+d?=
 =?us-ascii?Q?UhmF7jPlYLUwdjbOpp201Lk1psombTG2ZWJM9eiVL3vgWGSVYZTNuTePtGBE?=
 =?us-ascii?Q?Oa5t116EMPuvVmCqy+lMQUlp4nMl+xFQGVuPxKZWksAMgvviQzc5XGW4e/j1?=
 =?us-ascii?Q?v6+4LOPuEWjhseqRmToP0tIwBjRMm9G37IIr5FEIJhqrqM2WydwfskQGfbHw?=
 =?us-ascii?Q?Ee2FhFcWsiI4VpZW48nfdOLNaiAMwtP0OfcUs6EbyQvrWohHP+8FcbwPhGx/?=
 =?us-ascii?Q?Ba9RqR4yNg7k2BtrsneTpVXPFb4WOtTzhVXDAUwJTyL441FGlHRFiSyUvTKq?=
 =?us-ascii?Q?d/A2mWEwQUkZzyXiwOs6DgI3wk98RPSJBCmEBDMo+QVFipXERRvqilPlVuLF?=
 =?us-ascii?Q?G1GQOE21AKWPGmMup7a6/P0dZ/5h+zrHqOX28X1tdYKzgjEBD+HN2o9eVwf8?=
 =?us-ascii?Q?5oTHYGxVWG7hO6k9OWxLbzB65eYRyCpySa58p+HR8SBnzZgIoPjSToKQz0gq?=
 =?us-ascii?Q?G8ud9p8kxIDHpeNPRx7dE5KXXN1VT31cJa3NOoa+7U6QTqW76KjRqEdAN7Ct?=
 =?us-ascii?Q?J7AplfvEibo2Ty1VG9B2UEZSzjQqZqK7Eur3zb978zQ6qeBrFHpNeOunz094?=
 =?us-ascii?Q?ApQDPCY57PDZHlR3B8a2g1KkOW5yxErUGT1NubmkRzor/suBPtZV1Rn04GgW?=
 =?us-ascii?Q?IqMJgSHFTTwIlJnqelCplvOUt47QWYJkhsYkDSJYqQwB9+SVGQspJ36TE/tY?=
 =?us-ascii?Q?a3PkH8mfmXz8lV1DDq4t0q8EluuxL2U2uJktd2jIMTy1cAMgCkcnU26jAOO5?=
 =?us-ascii?Q?EdeRbwt9U1b6ONcNS0Rc8XA9y2DD7dSEOOatw2S4yWIoz5cEPujdTf2U2ADP?=
 =?us-ascii?Q?XHbC7Td+GGg5wzGsqbJId2rjS5fYuo5KPNhzKuWU5JM4/h8nggr+Q9GOCp44?=
 =?us-ascii?Q?7e905hxcJ+S6Xna14Nd+5wuY7q+7JGNELSCwORUOwkSEjAjRb+WvoQhcKGS0?=
 =?us-ascii?Q?tIiludn4c9BmFIltpUiTsLk2VVWNX8d4/TqQq3lsmg/P7OSZQKnKt+RekemI?=
 =?us-ascii?Q?EWn6tz8aMvs+S/RfmqF6o74y82e35OZqFud6kFiEPdaTcxZK8Ljh0NHn6kpm?=
 =?us-ascii?Q?7hbIe1gmNH7p0vafq00PbG9ljt3HWLD2T4Yz9UZjOh73cPRMgLRl9PR2GCIO?=
 =?us-ascii?Q?58mW2C2L5hby8XGp+IavXK5EcZLjpDEeCl2YI0lg/VPtN98xOjbOAkbHq5VF?=
 =?us-ascii?Q?JTPdDmuCmhSJeIDZo6PdPK5vIa+OeDVu7pod5eHT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a56765-5633-4506-ea21-08da5dc4087f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:49:36.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQDRBOicqcul3SsO14oxTvPJ7frKQefypSa57fMT5nehSmDucXOSI8i+SF7lHdpk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4742
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 24, 2022 at 07:08:45PM +0800, Wenpeng Liang wrote:
> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> 
> Since ECC memory maintains a memory system immune to single-bit errors,
> add support for correcting the 1bit-ECC error, which prevents a 1bit-ECC
> error become an uncorrected type error. When a 1bit-ECC error happens in
> the internal ram of the ROCE engine, such as the QPC table, as a 1bit-ECC
> error caused by reading, the ROCE engine only corrects those 1bit ECC
> errors by writing.
> 
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 195 +++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  12 ++
>  2 files changed, 207 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 782f09a7f8af..f3be9817a755 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -55,6 +55,42 @@ enum {
>  	CMD_RST_PRC_EBUSY,
>  };
>  
> +enum ecc_resource_type {
> +	ECC_RESOURCE_QPC = 0,
> +	ECC_RESOURCE_CQC,
> +	ECC_RESOURCE_MPT,
> +	ECC_RESOURCE_SRQC,
> +	ECC_RESOURCE_GMV,
> +	ECC_RESOURCE_QPC_TIMER,
> +	ECC_RESOURCE_CQC_TIMER,
> +	ECC_RESOURCE_SCCC,
> +	ECC_RESOURCE_COUNT,
> +};
> +
> +static const struct {
> +	char *name;

const char *

> +	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
> +	if (ret) {
> +		dev_err(hr_dev->dev,
> +			"failed to execute cmd to read gmv, ret = %d.\n", ret);
> +		return ret;

Shouldn't all these prints use the IB version of the loggers?

> +static irqreturn_t abnormal_interrupt_others(struct hns_roce_dev *hr_dev)
> +{
> +	struct hns_roce_work *ecc_work;
> +
> +	ecc_work = kzalloc(sizeof(*ecc_work), GFP_ATOMIC);
> +	if (!ecc_work)
> +		return IRQ_NONE;
> +
> +	ecc_work->hr_dev = hr_dev;

Since there is nothing in this work you should just embed it in the
struct hns_roce_dev and use container_of to get the hr_dev. Then there
is no allocation here.

Jason
