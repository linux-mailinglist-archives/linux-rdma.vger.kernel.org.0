Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2B714EB6
	for <lists+linux-rdma@lfdr.de>; Mon, 29 May 2023 19:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjE2REM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 May 2023 13:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE2REK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 May 2023 13:04:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95776B5
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 10:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnE6CNjolP+GfR2VZQcHu9z1ksX4KRnDYG8Q2E0igkuE0td0UDfNlIQlc+/dZnx0De75J/IATJI+ezndPO502Cbq3kjl1C0ZSaOXeAjRK5ZmGnuHD9v6sey2GRgOSS8nLTbvjYxZL8K+Qqvlcwanc60r6xSAzTAPqG99QpgLkH0L+X5pdW6nOndWCyQ4KeD0lBe9cyGq2Y9oBLkw4pRDgJtWGnP1KUcDFNYa+VDYEgg2W9xHPHRY7XtQWcnBRsGShRWrcVxthPMDvscOCWHIgu+E9rNq/Vy0dsi9WftnMoGpunPEYV/aB5eHtRO4oJq79wDW9wrBN9ewUvKqqWUzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqpueKiasdjIv55T56Ej1UPly6A+CPSb2wkUX53LQEA=;
 b=LnW+yzqEreE+ZBCWtIt2FXq6jZxjOXgvwGQ2AUx6Hy4LIkJE5xEHb/k/n8YCNEHtyprvxN+bs/r82iQLxvMWC8x+HuDkmFF2eEEcpy3JD34Ia5+59G4SDJCfKD4OK3t/wgyO2H7m5z0czEQ2oROJE7LxwMrvvK9d+7ELTYyGw3axkaZff5pficyG+5Be3xG0r7duuypEyDxomxQlLci3Ut1xfCKh2F/7JrlwqcnZW9h6jDwPr7wma3VtdwIF13RljknEvKm120SwYnIIP+urCAuEJRw+jl7uAKGvT0qj486of8FqJ1QkSjN35+JDpqs6pnBeQq7p0M5vfeZ+OjCBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqpueKiasdjIv55T56Ej1UPly6A+CPSb2wkUX53LQEA=;
 b=ChYSoso9XdSlv0fv1jMfjkYoW5LSignf+IFTDCB1oN0RbcWPY95PnoI1iXaxdVkTqQ4yePwdwYulPX7WnVnzOQAYXV0fej+sfQHa4srPoXJF3vzeUlBM3fQsp6z6GoZySpqn02B8Xfbbh/Ec60Sd36Q9HaU4tXoVtMrHTC5kx5jHP7W3LIoFX22XHz/bAB0BjQkkXtZXpPaX4AWOt2Z1ihRou/WEooTkwS2jvNyTjjmlIDQ/+XV1pW86wxCb7w6nzDzT32BC4rOCx3ABRgacsg6xVFFQalKy+Zwaf97iZdiPVZUATS8j9UR8945N10gCE6pshX2rBGec7wqjKypY7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 17:04:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 17:04:07 +0000
Date:   Mon, 29 May 2023 14:04:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <gal.pressman@linux.dev>
Cc:     Michael Margolin <mrgolin@amazon.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, sleybo@amazon.com, matua@amazon.com
Subject: Re: [PATCH] MAINTAINERS: Update maintainer of Amazon EFA driver
Message-ID: <ZHTbBsEdRIYyemwe@nvidia.com>
References: <20230525094444.12570-1-mrgolin@amazon.com>
 <a8a18dfe-818d-03e3-8e7d-b186b1688767@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8a18dfe-818d-03e3-8e7d-b186b1688767@linux.dev>
X-ClientProxiedBy: BL1PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 877a31ea-7432-4dab-e4d4-08db6066b68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZV+JjAyzUi1kkQ04zakyi/VIaHuZM/8QIBGKIVfJ4CUv7mp4G9pfDwamSDGv/6OLtCgBgD5+7OQ+H1l0ASBC8WNEPndPpkZQrUVQR76FplnfRKisfM3p4GMQWBqqkBzNZz1zJa/OqPwzuG8yq1XJmk42QHky4qW5vbE9xkL3HlfuAH4seXhfgtVoKiV8MT98OTv37WrRpd/ivf865jeTe2gqVmv26h8UHRvz/qPhTWYGujkSSM92FVtV2DSCdGsRPDd2W73ezaij2TVDTtPwaqDIsD96o4VsQS1uM0234mz0s6i3c9VdsmjHguSeBnh8SHO4XoDDPYrSpoibvTP063trZcz80FUunKaMhM6tfWZ+jHUpPArOnFq1YLFyg7u4ZF2Y4IQoTeO6/pQBE8JdczhjT0LKVbZk98Bj2+OenbuMpPdHrx8AVtxYti+Yk/VqgpakRbF4GAvgc6RNP4EHH0AGB04nAycmWjiC0IX2xwZI5a1q6hWPvhBDW7vMQXVOJpTP6+DdGBuVHUv/S7HUdSpekNYtiwOBQR+4c2v/HmLLuXm1OsNzBlEIxV2uNj4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(47630400002)(451199021)(41300700001)(6486002)(86362001)(6916009)(4326008)(316002)(66556008)(66476007)(36756003)(66946007)(5660300002)(186003)(6512007)(2616005)(83380400001)(6506007)(53546011)(26005)(478600001)(2906002)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7nLSPeFFpMcO70sOcfGVWRH6SP3sMVNpdvu3hd3EaVDioCyR+8RNcBank6Tn?=
 =?us-ascii?Q?+vZoqtK1fPPd/jcIvW/oQ7KN6dDgpDa3iCNfUWJq8QIuCCpTtYYPL+MYaOJ5?=
 =?us-ascii?Q?+ryHPN6PvTj0Nm6lWIv8HNhOLMkfnVQReBfKCVjIOdOj4qvB93sJ5FLKCjy0?=
 =?us-ascii?Q?z4jP1Kpgp4bpXM1FUgVP9EehSyLURMSOM4ENytVfcbq386C5BlMRClvekYqf?=
 =?us-ascii?Q?7fNIPI7+AJsr3DlOAMJQPvr2d3hJ5Bpz4kBOL45eG3zQy381QPmuTmHv82jr?=
 =?us-ascii?Q?itaeK2OHNv0+7q28YB5kBmEOUwpnQbiUIFlSSeNvhz3UyqmjYRaZ6hVFzYxH?=
 =?us-ascii?Q?p1WOtT9PBLb9+PgRWMcA6VZA1xysm4VmqD5C5tz+T6tLgbUS+SGtfNs7pgVZ?=
 =?us-ascii?Q?mu1/gIbcMhbc+yWNXw+kfxTGSQUdONZdOI+a7D6vOg2e+BZF/5eWh8KeuTml?=
 =?us-ascii?Q?sl35pKGEkEK++9gk6L881tPXLZSnBZQnjkj8Z2lPRYIJKix3TM2hQYF/DNKh?=
 =?us-ascii?Q?9gOtIL8/s+VyOQidWhxLURkvE59Y6Xc4QCeTe2BaG4aAKFN6/qeJd//1EOic?=
 =?us-ascii?Q?Ww/2iysYhMB9Qw7kGoPep37PqMfRy4+aMLsyyymAT1z8eqt5Iv4W6ou4nOvZ?=
 =?us-ascii?Q?HPCS7w9fMKXIhDONuDY80Luykrmbj4OxJAAt9NQihJtwO4q9Op6KpfdsYLfB?=
 =?us-ascii?Q?n27YIhy62s5X7U9oyBuuNyNon1YP0HPpRjNwQCTZKBOfv9UEsMkan7cQt0Ip?=
 =?us-ascii?Q?20vlPY7lik+jR0b/+Kr9TfywKDQloh0wKLY7KLY2fqwRRepEZ4whk10N0QIG?=
 =?us-ascii?Q?N9ev1pvlwITU3sC/evQCH7MZAYP1xAXuN5s6NhtywvSYM+2Mi+cU1E6v9+2o?=
 =?us-ascii?Q?4jP4hRDglb4B3YyIY7ToSGb2jgI4l6efbP0sD7SK7cdZgrbLinGdGSxFVqNz?=
 =?us-ascii?Q?lvj67/EEy0F8vgEEcuj8h2CbNFVAZAEibVMKZOYI4XR+HBWLga8it5xcLhr0?=
 =?us-ascii?Q?dkQN9H6G5mSgurQaIB9KWgJUeLmQNml+oi1HzdjTgGrXDuNIuhFKqSE0u0m9?=
 =?us-ascii?Q?ur4JxBIGAH4w3mtLY+CudM52h4MOw299IIN2OGrkvDmiftIzYj/nDI1t6ViM?=
 =?us-ascii?Q?nYoIQEnQkJj0JT/2pQbXugGaQJmddL4isBRLYyF44gesWgQ0THHt248axiPk?=
 =?us-ascii?Q?SQWlt9rwK+PmJ4coqlmkdnY4qNLzvjG0ZLHzzdDZwhPVB5DD8akeebqyTEIS?=
 =?us-ascii?Q?coAlBS7KlYd1bidOjQDbD2q/hM580FNPMMYCiIZsfVtUZJO2YRabLzoy73mt?=
 =?us-ascii?Q?PxdZzXLev5hi43nil7ikeXJEbldshwhQgCDXTpT4VvL4JVOO1XEKVBPHCGvN?=
 =?us-ascii?Q?ejZOheEL+itFx+yh43k5/ActA6xMTuw8Dhktn8gA3FDc83nbAAhuuZg82ORH?=
 =?us-ascii?Q?3HnRT9WTcb1BSpUiDcCIlxnwHcaNx2IXPr8AJhdSLFv0AnZZUmgKXOxMNxas?=
 =?us-ascii?Q?4R9AENYT8SoeAolLjd2e5RwC6OtYUrnKmr7OzPCE++1CmWrv1/WoNau5ze0/?=
 =?us-ascii?Q?oOGEhCEdk84THeROJ0M2jJGXnmgCIjFlxfC3aTU7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877a31ea-7432-4dab-e4d4-08db6066b68d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 17:04:07.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuY4cuFHSoe5A7Bp/OemlcFBiMgnET+OiMCMrOutqb9nf7qwrR9eJf0VG1vkn08h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 28, 2023 at 09:54:17AM +0300, Gal Pressman wrote:
> On 25/05/2023 12:44, Michael Margolin wrote:
> > Change EFA driver maintainer from Gal Pressman to myself.
> > 
> > Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e0ad886d3163..24a0640ded06 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -956,7 +956,7 @@ F:	Documentation/networking/device_drivers/ethernet/amazon/ena.rst
> >  F:	drivers/net/ethernet/amazon/
> >  
> >  AMAZON RDMA EFA DRIVER
> > -M:	Gal Pressman <galpress@amazon.com>
> > +M:	Michael Margolin <mrgolin@amazon.com>
> >  R:	Yossi Leybovich <sleybo@amazon.com>
> >  L:	linux-rdma@vger.kernel.org
> >  S:	Supported
> 
> Thanks, best of luck Michael!
> Please change me to a reviewer (R:), I would like to be CCed on patches.
> 
> Acked-by: Gal Pressman <gal.pressman@linux.dev>

I made this change, and applied to for-rc

Thanks,
Jason
