Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF37439943
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 16:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhJYOxf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 10:53:35 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:45631
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233662AbhJYOxK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 10:53:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3l+n66h1giVg+kryu4AWk0aLQhuCxzxnBG7Kb0xGMHn+H+2S5HvLl8lxE3vgvNbiSrm4JyoL6Npn8ayaYinCcD7shCSr5E8GlSrrNe3zMezN/WP30gHo66zuzwq2Glm9hLfho5m9f440D2BgmTqyqIt5tjTh/Ycx42vJg5MpgIHr/P1gUAI32nj+14aDmgXg7ZhBnWIlAbmtuGTDl8WdAPpaY9oQqs/+xpPttIUHW4IGzGRridW66t3+EO3rGnfvOYq9TUNuxd7rLTTVJyICo+qTVmU2RlYgNcXqkSWKwO1xQA6D02XpHHZ7P640Ko7nZWOZ8u3bFyUiWZGgXPy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ur6NBjkBqN/qJ+4kPgf03VE0zm+uGkjlvu+/cvCSg4=;
 b=efZST/quIbOJNI3GbLp7D9VuO2NL4FEucfB7R6MKA0YbvLvgbp5ahofP5UVv3FDaA805JI+Cyg2TIo/ZOONTnnj3TLafnCaWm1siLqG34mmzPYIrL45QP/+fBAg3acnLoSJlw/VPjVaPurZhahSoe7hpbsHFuC5sKhupHdOvL+TRiG6opRun+vsRod79HY/xENqwTIJNkhUhnqVaFs4wV/ci6QhRUxVCBXj+Zg+hgANpEdHn52izV1cG8BHGqGre+gAKi6rimC3tLufkE2+V9QKCRSjUZiE0HzoYmvzsfyakg46EltpgVoiTaCAwu0OSrAO+QeKs5Ag4tvbrnar4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ur6NBjkBqN/qJ+4kPgf03VE0zm+uGkjlvu+/cvCSg4=;
 b=a7IdrazMQ0cFd1icrk0EBNvmd6b34HNfVr1kPIf2D2IY2ipZRYBK3MSY3tDdDKiPUa68aQz0NKdXSmo9IpuNjLm5iZ5OBflNbON050FZKbgQmF1BBAfXMBNr9ONYY4yPzdwMgLPdqw1juppz8poR8jl9qMMyzPlWgyoGzrqrphYQZA/btCUk3fQg6gXkDQy+ZCswQAaJM+emaQSA+9qIDfBefSEC9A6Qm8GZTpKj8c6G9t3qCCOPe9sJHHfHMyYlShwlBgV5HQVvmlBKeooqh6iVODAX7GJLVi4ORJMkKnpW82vwEw26nAiRIVcxcvFY6p5JuoSdxoKBT+AspRKmhw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 14:50:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 14:50:46 +0000
Date:   Mon, 25 Oct 2021 11:50:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Fleck <john.fleck@intel.com>,
        Kaike Wan <kaike.wan@intel.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <markb@mellanox.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-rc 2/2] RDMA/core: Initialize lock when allocate a
 rdma_hw_stats structure
Message-ID: <20211025145043.GA357677@nvidia.com>
References: <cover.1635055496.git.leonro@nvidia.com>
 <89baeee29503df46dd28a6a5edbad9ec1a1d86f1.1635055496.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89baeee29503df46dd28a6a5edbad9ec1a1d86f1.1635055496.git.leonro@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 14:50:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf1JD-001VBc-RR; Mon, 25 Oct 2021 11:50:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f407db9-aa21-4f0f-8bf2-08d997c6d389
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB512821F063740F26D92E2745C2839@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rl5EgHzoztJDmanLG0RN6sBJeOamdZT5OwbqlQ6SB0Lss/WLRAxcFf0AKoAWcjZjMNTjYBoz6R4If323t0A7i4Vc2wizFbgkDXlf+CChILI1JE36pytFS7STk6Gf8Y8ZydXen5mLX0X0bnRbjSSt8Ii+8DI9hLkkOwzd7OWihgEDJ313T/I4kpjQsFvGQRYHkRnDcisipTKS2afwUZV8MKrFVBNq0HWAnF2XSEPoAE06QxDzd9lhPyEFn2veJEp5ObprlWdVtHpzzSzqQiy8v9euXa2dJtXkmGr7PhsC+3iqtL5NQ5Y+aoKGfZk0TOxbHXKzOmvgDjO7taWQof3stFZyJexfcgi+IXMgje4vvPYHAZkqIAOh0shScakfwTEDL2wpk3yyqsbWZJhwSBHWGaKrHkT3n509Zv6jv/V+CVhJNLzz4OWUbEBRCUVNqI0GhifhXWUNywJ+vENFSX3oUzDhpxt21LtSBcru0ILhGzETo1RP8niiJ50NufP7y9Q6j/oOJvTbGVN5xhAUaGr8lAJtSeL1jyAtPbQMHPsVd39+dVAv9nFWYQPpdmf+0yr8WOnJttWA/wAsr6NUXnFDxGui/crYFVVJpLDV40PhzzglMDXt9L9ShPxRo59liR8LVw3XG/UlAf6uLHcoCiLgmCtYdMSP65NoJlmePQxYRsupoNX/KwVTtq9wjhvw4TU8nNtv9Ngu+Bu6aZbTU09aiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6916009)(1076003)(38100700002)(8936002)(83380400001)(66476007)(66556008)(86362001)(66946007)(54906003)(2616005)(107886003)(316002)(426003)(26005)(36756003)(4326008)(8676002)(508600001)(33656002)(2906002)(9746002)(186003)(9786002)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iMtiCwErd1ewIrALNTu1PLS71BQylsGUUCNLO1DvMDBxobzA3B30kInrvfZx?=
 =?us-ascii?Q?yISjf0DwpbRapai0ad7wPFKdiQRyzYsLzy8hi08OFk+3JEcyEYkyW9pB0JjL?=
 =?us-ascii?Q?GoMgWfusPTAvnt8irOCdQ1pK4mnyNf/NPf0gtIP/6h61gTQ7OLYsWDsnjw+J?=
 =?us-ascii?Q?9tb8O08WkF8E6w80LSVRgQ9E18qLWOa1Rluqz7NfZs1Su8r9D+lT43djwWZz?=
 =?us-ascii?Q?Z6qtDBN0rqxW3R9y9giO+BH5jQLNkM5EigYjvL3YKhK9lYvuJUfiKis+KKQo?=
 =?us-ascii?Q?f5DG3PZbFZqdVZniZ381GfVYhCKOTHr0gA2j8nWZp3cNaNam5Cp0DawUC5r+?=
 =?us-ascii?Q?vwXIX+qgJcwvT2wD0E01xNPx3JWXtmsIieJzsrBK1/Mm0P8StM3keArJqLXI?=
 =?us-ascii?Q?JXEDELShtW6iV/dBIXM/YdsQrAp9lxRSGWD8q5E41yxRMnyalMalJUmAP0PP?=
 =?us-ascii?Q?ZPNqCnBCRJHysNzvlG5gmHq+mz73svFUBiPyr5JcaFLvIsXiZc+THwOgUHay?=
 =?us-ascii?Q?h7+KuSTt5/flF3+hJrlZPNhh//PInmchE+FTiuUrS9KLB4lIKPbpLe5rbApN?=
 =?us-ascii?Q?1DU5Vcrz70rW9nFUB/sNjgZim6xuzrBWJkSABXQzUIsf1ax+oG0iWLWBy3bq?=
 =?us-ascii?Q?zRtlteBoWCsxM9TKo/w2aFET+BZullHeLiIKCqXeixFhua4lZOlv88U4TxpC?=
 =?us-ascii?Q?ZOzaJKE7buSyso51+0CLLY1+LINiB/QJ4j0iK4AfXaSdgPdJO2noDWCrkylg?=
 =?us-ascii?Q?iotKPKMcEbAunixY6N97PTNUB5IC2gl7jxqzL5BRh033dd8W0h5ghBieNvtU?=
 =?us-ascii?Q?KqyCk49mvZ12jMx7C3u6EZAS6Sc3kLGifeBFPyvxskXPBWUL6vMo5dEktJzr?=
 =?us-ascii?Q?NeKUB5O0jz1CuEstzYQRvAYL4z4iTI0QMDJ6Ws1M0W5emWox9jR3EYx6N1Im?=
 =?us-ascii?Q?gVgvzZOP1fSnPPlz0tcm65WwCSBbu7+0obJDQZRAeHGpUmbDTsH7GZ5mRw/i?=
 =?us-ascii?Q?KGC8jmRNom36sf1HYEz/+803D9TBci3vHl3Uhe8RSeHZOFZwftKwsp3DLerw?=
 =?us-ascii?Q?XDH0I/N/n+1j3NdZp7ByfA1taP/kHXOORDGecMRCzxs/ogI9WYRK1kPiwzPi?=
 =?us-ascii?Q?OXwtQ2a8rFN2lkDXGFZ0FbTBtfbfMW+52LJxmJfYD9KTYBfbk0NM+MxfKBQg?=
 =?us-ascii?Q?92tQCoYad3ZBzuEdSItIdw/nCOvqFDl5Ey4j+5Ibm4fJyVEHmLvFYAEk3jWo?=
 =?us-ascii?Q?mESQC2M+d6kN4Mre5hGsLVt9sWsZ1sckUD2B/N1OFf83osTHDr+erBaULvAF?=
 =?us-ascii?Q?XcnDoDGnp2YqmurVlREEdtIiAZ0zu/cF55YLI7lb+K0cyt+lufByGlxau/Pl?=
 =?us-ascii?Q?Y6Macqrk3ptwBDl8ciB6tLLOGVdyxNADx4A74Ikxxsy5PFy9z9aeY02a3MLo?=
 =?us-ascii?Q?pBu/m9MG8juahVK/ZJpth+QSkh2WVDi0ze37NDWW5fzLrCtNLp/xMStgPrCY?=
 =?us-ascii?Q?H6KfkpYtnw5ccY8pRfFSBOek4oIzG0gVgKOtaTUsZukaF2r14pJXL/hpSBEf?=
 =?us-ascii?Q?XyRgj809kJyFnPKGXaw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f407db9-aa21-4f0f-8bf2-08d997c6d389
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:50:45.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXMDRelbgmkvE1IOjOJDayWmJecXUMponF1CVqAZN4fqPSZNCGI/ZIOwb9WYgYyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 24, 2021 at 09:08:21AM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Initialize the rdma_hw_stats "lock" field when do allocation, to fix the
> warning below. Then we don't need to initialize it in sysfs, remove it.

This is a fine cleanup, but this does not describe the bug properly,
or have the right fixes line..

The issue is here:

static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u32 port,
					   struct ib_qp *qp,
					   enum rdma_nl_counter_mode mode)
{
	counter->stats = dev->ops.counter_alloc_stats(counter);
	if (!counter->stats)
		goto err_stats;

Which does not init counter->stat's mutex.

And trim the oops reports, don't include the usless ? fns, timestamps
or other junk.

Jason
