Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0734F1B7F
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 23:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiDDVUc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 17:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380050AbiDDSqp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 14:46:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3022D1D2
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 11:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUcmyGu4Kaegbddr0d8v2O9n6JbI8dzhWPNEQA+WzUNxIuGUn1f6cGD4NJn8RmspiLjHg+7ofIsT+pNLuqS4F2WDfaERNpcke8zX60r/PCGG3qajnR4MrWj/hrfxlNp4Ud7Y3sL3+rhjGbApAWFoF/SZI41oq8aM8+mI2/nkQqvZECGXqDND+5yUapQI4kuvx90kcZyCnkb8Yi/OqBhRSHirdzGszsq8dAgzdVZmE6B9GoOAPp7hlRNvCZqRI7us1LNgKo3pFnIoP6TfHjTUld90FOZfU58GE0awp9OXSLsZzNKYiScvIx/LiAgrjk9H2gmXDr1GyYPbAadBU5UR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRvtfF7eKsIh4u65vwdwyn3cQ539ZZtzf58sa5/rXGU=;
 b=Nb8fzg14Me30gm8U7EqAyipuHeP+B/Oa48dUfSlco5DCYcQUDfornxEAwb3QDpRz+S3IogbP5GxLbb2FINVk2cxwIBIwk/8xDtutvi9QWDWYD7UWWY/ccf8b4yJ1+MITUvagD22JJHVqfKIUeN6Hpkg8d3pxBn23b86w5/JyCrljFlebWbkcvNieeQ+gkYnUwxsHe5cQHTJ3ngOKzITciirj2bVl6SgcSg6aCbolqboqP3D/0MM6exdYav8wHQxztr6cDBZzch4IQLGUnSHLV2XDDQSvkSZOroDU01iQ4o1wZh+dFZ9Teo71oe7j6CfpcGYj6uqMhb6wjz5+KjA6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRvtfF7eKsIh4u65vwdwyn3cQ539ZZtzf58sa5/rXGU=;
 b=VI2oGzx9VwD2f5FKHYsTiKZE50fzKBb18QeVdf1poLtadnGzrQSOzvkie3CBg6HqvAd2dB7SH6rokHIwSJnANhlItFs5B/pe+wgZINh5zJtAWE4g8oAhBUuQnwmKG1lshuIUA5njCnv5HcqHVcGb6ymK75jvNQBP6YSBnzLGEMH8ObgWaH09cbSi6pwqutSj6BowJqg6M4YFYSINWo6qDXi8f7uyvsshQXDfTwFUs67oXut4aRkRYIp+2ZfgGOzCWSsm0KNMJ2PbWhELRV2/xrbAIRfcMOTMiGIA8XZcjjywcgJ3JQ14SWeNof4tBvPlKkint6bZjFVBOO/vynM39w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 18:44:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 18:44:46 +0000
Date:   Mon, 4 Apr 2022 15:44:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: warnings from pyverbs tests
Message-ID: <20220404184444.GR2120790@nvidia.com>
References: <09525cae-22de-d28d-de4a-120598d0f80b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09525cae-22de-d28d-de4a-120598d0f80b@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77931a76-0a8e-428f-11b2-08da166b309c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111F52665AC42CBB8B843EFC2E59@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSUVSgWHogjXguUrIky+iz70oyFQsf4Y0tXcEjebJjj4BY8w6VMMqWh7TCgKAdE8NtfXwWZvQYCv0lXuTGN8tNryrpxGqwAQq1sw8VdO51hg8lN9DtGwbLNMCpEH4Tq1hEK1Y3WY3+1+ibG91CyTrB50nS05/RjGNn5dqFQ26FJm7Py0RLgi//PCIWDwjEXdwjZKiUfmlujxX4neHQzht19UjrkLjYMoQPr7CN815mWAKr6QQLVU5ok3IBLa4ErFXRk4l4OkGN50nIsixUH8w0jgnuUf1a0iMEKasb6CydFIyNMvJKaGDMZE8glBBCJrjoiUgKJsW1pSjmjM4oVg+hlNsYSSHPlilce7t8VsQ48I3ogBj8G+jhUJoGfs4So5cTq3kSS3pBMtweGIWLd8g/zBjbobnuwzSjE/yFlBEvcS/Sx7vVVbILIeeOYxJY7fJHmforLEfT6b2fVnM5SEAYplDxJtKWVA5uTfV0HXAz6E8cr6akTjj7m74255OBzxj+xcTuTiy2mteyHGCpfrg+/737vV5B3BMfr1XXdRrVja4XLXPDeUf4xAhardC+TWlsShgLtAhBIBMBMOEDiK3Nu1CFYkQ0ZfcrVAgVeS7zCS84pAbAktl59BA7oGbYDTzwuqzIaL7xtem1vyEHSC8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(1076003)(2616005)(83380400001)(66476007)(66556008)(38100700002)(86362001)(4326008)(8676002)(8936002)(66946007)(19627235002)(6486002)(33656002)(3480700007)(6512007)(6506007)(36756003)(508600001)(316002)(2906002)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ScTflngSNndf9lT6ApWK8tS7q5xwR9GQyoLRGaggw1sMREWpnrtFHTJajVlW?=
 =?us-ascii?Q?tFhqptuV3ad9ESmz83Hf2ydh2pI3Abm+T+s6j9ou26Kl9Tc0aAiVoaR2SWqs?=
 =?us-ascii?Q?7bMmV8+14ZQSr371AM2PkARoHohiJWHfZwNrEjxhfIe3B1n/bhCvp9DZNxCX?=
 =?us-ascii?Q?SNJmuzudoXsq+lbsv+b+2/m7kOlSppK3KfB9zOylXHOoP+71TWAJ6WGnPTtO?=
 =?us-ascii?Q?K+mA+9N5DwLrqFkDKmdbBexVVin2o6ZSNbmvBj6wIQNH7iQUpdHTF6G8eHoV?=
 =?us-ascii?Q?TZWTWn9Nbh+0ykhCNLepkyESH1Ucr0EuKnyHbJ1eM6KifC7uFmUgtFbcX61D?=
 =?us-ascii?Q?f/DOZZXEn618d11OTCn08oJrP0UTeb7lhBl06UcQTBOmr9Ie77XNH69+YrpY?=
 =?us-ascii?Q?MaCW5Vh1k376zmf22hLjCiBvCTLkzf/gc5AxtOfLzE5x3O56HLEhP4Pz5Dop?=
 =?us-ascii?Q?Hgt1BT0u4NY9Fht4YTKNZiT1BBov76JP9qWgUXBpb1L70qU6koYxdLLTgusm?=
 =?us-ascii?Q?6UVSjn2JkFe2oIu6drq7Oq3Dm0gqn/zS5gFIWKn5WmqdICfyNymq7GmCxC3w?=
 =?us-ascii?Q?wEJslwMPsZ1GM3/Vz9bB7NW5rUPutL3tY7y6/u7ZdU0A9QPNr8/TIP2BBRSj?=
 =?us-ascii?Q?TuI0JvEnFp0NYwuBZygfesI1lB0wLsEdM9rAwmT1W8Atm3inAUCZ5BuNHSjg?=
 =?us-ascii?Q?gOil2+j0gkO4lDYh3evZcDi3m2aUhEKiNSNxkzRGvLOJ6e6Vo22HXyLLwqSu?=
 =?us-ascii?Q?zVdVxMoyBXd7JzXP7yBSw+0Ce6uwpgDOB/q4kGGjp6Gmvly1DzWrU4XhXU4h?=
 =?us-ascii?Q?xv+JUn/JMfPFM2tXXG5yGIUE05OR5T1h5j1OrsmBy6JUuRvNrKKHuSqrabmC?=
 =?us-ascii?Q?to/tzP1mlADkI/8ZaYFxOeFtOGzwJACAv+O3mIhmPj/DGkw0ChtIG1HK7r4M?=
 =?us-ascii?Q?2vlKWrttl51l7/AKOwOpxfNibeUyC51p4rMvoRvIXKOeYJIwC8nKUxX9yzQg?=
 =?us-ascii?Q?Qq9M7kLUN8xBfBKVvfuo581aRUFLMoodBofcZpo8ijqqLSnqOl6WJtesxmmb?=
 =?us-ascii?Q?oa0F9eb+ScKvLQNGDggfgrG87pouRFGa+1BWb411emLdcMydqx0WO3jkHc6W?=
 =?us-ascii?Q?JOiAeCpdcMCBN9Z01TooZwnJfsud6w6eHF+CvFRQII1SPRVq4zdOiR/Slika?=
 =?us-ascii?Q?/izR7zNPnpjWgfUqRjeK+zzX+lznh72KPEyedNs9JMD925ny+095iHfrg+Go?=
 =?us-ascii?Q?SpKFbJpLJR3fDUe3n3scLszwsM+lp47YG0DTKVvM0cJS+rT/pic8dywKTdcd?=
 =?us-ascii?Q?ObaeoEPKt4WeKrATBhq4AfJYeA8Td3SGYF7WItUJF8EQA8CgINQ6MmWcaj0A?=
 =?us-ascii?Q?bfglqR5nfu6GbRI4BfrYTEyZdGug7UoZ1LS3Fc9Q8GdhdOYO7Trf6M80B6WU?=
 =?us-ascii?Q?y7baSKe5vSfd6uBt8bYkxdAcdQNuCHFFkNjZWFM7w9NJrwwokOolnmEbmnU7?=
 =?us-ascii?Q?EudCyVyG8p1QemD8tXrD6aNKr+9hh/PSxqIiVX61CLWQ6W73H1ScZLoucnSe?=
 =?us-ascii?Q?m+HMGzwiE8rkO2BzbJPl6PS4O1El3grehtMg7ogAn1FvGY948lkrk3SynINv?=
 =?us-ascii?Q?dF/e6AsPriZoOmfgEGPgm3iEzpvofFf5VJa2SO14iM795FfFddWjUSnnCgVh?=
 =?us-ascii?Q?ThlkF2CozZXKprJA26AMWZdYrMQjU2sw/dWJciZZ1Hj9i2Z5cHyoJ2rAdrLk?=
 =?us-ascii?Q?1loH9IxXjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77931a76-0a8e-428f-11b2-08da166b309c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 18:44:46.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQ6I7GSweZzHnjxFkSMUy2ZGDMTXuvRbSAx0QSMFCAUroAt9oNE5ul57BAx6h6Zy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 04, 2022 at 01:19:21PM -0500, Bob Pearson wrote:
> Back from vacation I see the following warnings when I run the pyverbs test suite.
> 
> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.device.Context size changed, may indicate binary incompatibility. Expected 160 from C header, got 176 from PyObject
> 
> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.qp.QPEx size changed, may indicate binary incompatibility. Expected 136 from C header, got 144 from PyObject
> 
> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.qp.QPInitAttrEx size changed, may indicate binary incompatibility. Expected 208 from C header, got 216 from PyObject
> 
> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.pd.PD size changed, may indicate binary incompatibility. Expected 128 from C header, got 136 from PyObject
> 
> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.pd.ParentDomain size changed, may indicate binary incompatibility. Expected 144 from C header, got 152 from PyObject
> 
> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.providers.mlx5.mlx5dv.Mlx5Context size changed, may indicate binary incompatibility. Expected 192 from C header, got 200 from PyObject
> 
> 
> It seems the headers in rdma-core and the kernel are out of sync. I just pulled fresh bits from both.


I don't think it has to do with kernel, that looks like a python
compilation problem. Rebuild a fresh rdma-core and make sure it is not
mixing and matching shared librarie somehow

Jason
