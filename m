Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9364C532DEA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiEXP4r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiEXP4q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 11:56:46 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E8C980BD;
        Tue, 24 May 2022 08:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki8Fhbq8xQwtkwfV8Bpud3MP6qzZ7xRtq54irlC3MFAhPVxO92zujmphfcK3iBQRvgP2+1h86AhfT7j6sDYikFr65mZQbN36nM6ZJWOdgEg/mNd88cvyjloM8pMM/NzUbyVrVS/OFrHJj0KHYfhp/qwVEndr/e0OeWR4Zx56vY6moh3vWIetYoYzugdpbgbtEI8sdMzSEajZePrlM/ycZBHUse+ilvBVrltQnpMS6aqvBFI3d12Uvn7Y11POD5Z1EEA2E2bch7drR32ByjyT4BdNGXno8ePrTWiV1Sp/4NP9qE2wC2vYD5KqSM/5iQ6TNScNPfoxMpyeOtZOU7QvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUFdmZeVKfOwigsHmKqoFWW5fpHaKFdYmxhlVOhTytY=;
 b=buaI7b5rx517E0s6h2cUR7mWo6OzTLi5bIgQoO1A8UTgOc/PMD21HHXrg1QH4RHvhvHk50lR33UlTCTb73XUZ2FXr/yCiT115hfx3j1WBKbXEgFi4G055kCsNirwiIliuViyvvm4mDoQFSrnmeuIG4cOlN1SnS9gThBVIGcxN7qkYVTbWBiXuiC+8I7YZZSj6rR6hyxhU4BzqdK/kWQYQJ4CdqhAG7YxYaBAScod/dLdj4m7AIh0sU16/jcek074K3iUJROQMMkgCysixok/ajiWxgx2Q6eFGSStSAb7MeaGYNXbl1CNC/d6jIU7mJP8c1QnHbb9ByLwL8W9epc2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUFdmZeVKfOwigsHmKqoFWW5fpHaKFdYmxhlVOhTytY=;
 b=Wx/4g1qlnoC++FXQTUV2x1twCS34kPW0Ypf6nDZKE/BVrUx505gr7IbP1zTd4BKHASQ6aL5sEL1rc+TO/0ySZdFEduR/SN30cWJcKo0FHvI6Z8tWQ+enBlPSRwFr0TkcAlGM09KeI/PkAblQWtFGwcUaGmwsO4ees8Cz99nrqiJbU63zAux5V1xG4IejwxjWOca+OrkjC0aHpXXVy/HuvgDpp54XTfCTF4vawR1pc5Ou20tfKMs78W2ruNfBRBzG4BdY9CdpYgdL7O59xAeXKj/TRvTzZYAa3yuu8t9IizU+6dIi9QwpxSjMMNm1o1D717h+mPqW45w+8p7AzXy/6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 15:56:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 15:56:44 +0000
Date:   Tue, 24 May 2022 12:56:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix an error handling path in rxe_get_mcg()
Message-ID: <20220524155642.GA2720611@nvidia.com>
References: <fe137cd8b1f17593243aa73d59c18ea71ab9ee36.1653225896.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe137cd8b1f17593243aa73d59c18ea71ab9ee36.1653225896.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BL1PR13CA0355.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d55e61d2-0eb6-45f0-966e-08da3d9dffd4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3852:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38522D8EC8F87C6EFA842EC1C2D79@DM6PR12MB3852.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRwDTnSoIjf/wwBtdayIO+ubN9PFR739AGJjr6Otwlf100as8ix5H0gmTQoWaAOkXLqiWxqWkvUoDncGcauDOzfOG75JYZWCx9dtgYe7ERQr0aT0Ye15AhYRXsflql9T2sSIr2hx9RlNTgsU1lmPsHuqD6SS5opoZmhALLlceEOjTcQ3+oxzNwRsbqcjolp4KeHuWlJCBTCUr3pk9+8RibtX70BA1WOAe/us2Z+BaJWGnB3b2xsTEg/Tsb3RMDjiR3/YSd0tbbhDRgIqRWLtbfObsRcnZ309H/g/hsZr4/Bhdq7le8k/UjlvBVX7g4IKSw4druNqYShCfurWbgc2mosL+EP+pLqzNACfG5r5jJS48TmEdtLwVQ9Mu/WuXuJVfz1SxD4HCtndFCukkCgUGEBwgp6i81JJOFvFMbPk28T8BKKBcgBK/ASvfyDzOfJLw68RgWKKKYl46/KIoJfaUWuyeFNu3+/rWGRcluGnqICRHK14DDxzzTXHHYYVwETIDN5s5mYbaPDntIVeTmMHuR5fkACGo+3NTEHP9lA29Z4BAYPlmmv1uYGOq5wwAuTeDO4CvNn9Z+0z712FODBMBAdVE3I8Z0RBRmU9SM3lx2w0q/j+g0HwTFfJxFm2OSx21IoRwgv8Lahx04mK2ryG1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(508600001)(26005)(5660300002)(33656002)(186003)(38100700002)(6486002)(8936002)(1076003)(86362001)(6506007)(83380400001)(4744005)(4326008)(316002)(66946007)(6512007)(8676002)(66476007)(6916009)(2906002)(66556008)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMjpPCGRVyzMbw8H14Qx8hQJUt9/WVXZCLsSlZ2I0/kd7ALadgU4fLkTkA5V?=
 =?us-ascii?Q?CPrzdEAfA73oxQB0vMUgV0GEqUUGynSZG+gHcNE4C7U733h21h1897lXrQHG?=
 =?us-ascii?Q?5WjG1oBxn3jjtBEel1xvjzUek8jKP0BRSlFyf05llF5+pUT6kzPyRr0CJ0Po?=
 =?us-ascii?Q?sKc7NILrdWkzWxL2Q4m76eM47Ql3ofOefpfiS9N1XGyKPMSGOm5lZsE6YBrJ?=
 =?us-ascii?Q?t1iP5rKyHKtPHVM/4HTwcgu+C21oAqNg8uxXWVc1k31s9SVBv14VEnE1hjX7?=
 =?us-ascii?Q?eOIzN7b1g+4umbVl5sQ/AL/pnftiiWyartIxXgatPxlT7OjbR1BD7VMfm8nQ?=
 =?us-ascii?Q?6/Y3oeLrufeW6rJSoGIZ62pBGIg6L+If5ldKC9MB7k1EQjpl89+oHCAOCEn1?=
 =?us-ascii?Q?ocz8SSBX8C8y70XycioAC/W7JB1tHCGqIZNgv41sOLyupJR5HIKIMO3sZYzd?=
 =?us-ascii?Q?lC2Wn5LZErMSrwTxcWd0iYnEYMJTv6ll6J0PouJmo2PlLbYf0/z6m0++oj1h?=
 =?us-ascii?Q?9PAs0PloikrvSYMOetatRH0lRNimgPvs4WHkTDdsuNKV0A5m4ugivq3Pbz38?=
 =?us-ascii?Q?cJ46OkMlW8DxbKVIuggVbg6U1XnQOWGlRFVO0B5hnRGPX7K5PNwEmlmPBRTy?=
 =?us-ascii?Q?TkOghQ0LcEFobljLWQLHdCKn7Kqoy93XJ9BihxbpKfWw0ZmxNoguD1D2g20v?=
 =?us-ascii?Q?OGTl/YVu4E/+WMSXWmKjGBpyWwMg3BVr73zZFtfWUN/aFIP42SsW06irWdJw?=
 =?us-ascii?Q?JRfzpHy1gM38uhLFmSfhAlIdFTyECwH/B1v+d5sQGp/11qR8ogih/QEWJ2Ik?=
 =?us-ascii?Q?CSQ54wyhqN3KnVg+HW0FawC8oAbil/vxBjBG5Rq7tS64o623AFjz/F7872mF?=
 =?us-ascii?Q?Sj59YDL6Q51KcosNlGY20W7YvJRTXt7EH5w2mPeWEZdUies5cKePVhwqUqX1?=
 =?us-ascii?Q?3ITDqFqi8cSOnrDQffzI6GppmLrKjlCiVDgzIE1qTrIgiw4kMYYm0YWeSh5h?=
 =?us-ascii?Q?R00adTwRngapIBbtH9EArc8jXTM+cMIxlFNJGRy9YzP1KRkrFxDCUivPTldA?=
 =?us-ascii?Q?Ycl39Btfn5xMFZeTaZOUIKiy02/S+oX0vUnGus3NRJobU4PVtzcWIPX3Q1wu?=
 =?us-ascii?Q?tcJZlw3Jv6n0CdzbJIGuWHbzAIrYCtvChMZcA3uMZnrRgBcVW+hJVxU4IPlF?=
 =?us-ascii?Q?P7efznDOgMJuOhuZh6AhVUPVsHrt+cynA5FZITAaB0nabu7fsRknwktkMMkM?=
 =?us-ascii?Q?A1pIvRDWKd95rGBIOyxvCqx4eXUAnkAJiQ6aMwwxoNAiQizimHEBvqfzwXhR?=
 =?us-ascii?Q?0TneNAafuxilPeKeiaZfmPQK4JrMdglgUTNI8GWz/rVCHByUdaHdrXt3mhUH?=
 =?us-ascii?Q?oYWOR1xggd+DjLoCHSpTs50wes1fFxYEjCUeKFstPP94oGJHBLHt+bMDObDj?=
 =?us-ascii?Q?f9Z6PEoL9Ek9jdXdwXG2fNMst38KDEkgyhZCKj3yg/AMwmoJWNHLZC7ZITuU?=
 =?us-ascii?Q?EpglUhA/8LUVqVSeeyIB8+OsiOJ4/YowkUafJOUEOzPJny7XyQdLaC2NJUVS?=
 =?us-ascii?Q?OJOCheyHv4tzMoP3kQihcG/OIv0UlUu5rmbpqoQFI5zgOnx7YkrPpqesmNVv?=
 =?us-ascii?Q?OZdVI5KLH9SNmoRAuwMFWLUvPHwrKV8kAdeZqUDmjaiJwwadGADaszzU+/7q?=
 =?us-ascii?Q?/+XqICju4MdkMtdiBypBKmPCp3j2iGF9juu8zyciFP454k75TsPxxykHPmpU?=
 =?us-ascii?Q?ryR6g4sQhw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55e61d2-0eb6-45f0-966e-08da3d9dffd4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:56:44.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvcSzbiNg5g47OvsBDX68EpZvH6PWk3Vc2+ZZ9X3ZlRCyt9d2C/d3SZ/4+AuqSxt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 22, 2022 at 03:25:08PM +0200, Christophe JAILLET wrote:
> The commit in the Fixes tag has shuffled some code.
> Now 'mcg_num' is incremented before the kzalloc(). So if the memory
> allocation fails, this increment must be undone.
> 
> Fixes: a926a903b7dc ("RDMA/rxe: Do not call dev_mc_add/del() under a spinlock")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/sw/rxe/rxe_mcast.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
