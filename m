Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBBA588090
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiHBQ6M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiHBQ6L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 12:58:11 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAB815714;
        Tue,  2 Aug 2022 09:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+R/SM4DPG0bLE2PnAIilYPRURMe/PzrMpvoCDnCTGB0n1PtMvgoQJ8Q+y2FFnLZc+0H1Krx39k+msfJSyEcTnNfpj1GcLEqivAcegeJmCQlS7rKNSGbgYDyO+x4/6idDnTNhTwvWjOQZvJ3MsFlH61piuS7bx8vWWOtJPIKJj7zIaMNvImyI9Nr73oFq6DfEVYgE8ZMksXfAq3NazbzqJPHNlk8v64NXok4OkEOP8JO09pwiaJlLVLr23orWT9yvbkrG4LMXUhS2EBggokDfJLNnHCFeaLIWcJfQ1T4l5Snb0//nGqbp2wOYYwH+39ogFlmEI+HYDiQrK3ormlQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDhk/GMrJGBRjYcP91qM0yN8jppvZ01RBfNFErYDY4c=;
 b=dyy6IIfVXyiNnG++m3KB4V3wCzi5fCky78zVsjFubX9a/XSIOxM4j4FMmcM1srTwaTg9uOv8fJ/9Wgxm3MaN1AFM4GObIfY+srzIPk6Vpxaj0raQ2womnXdCfYblDlIksv9wxlGx5BdAbQPAhPn6FukLqP1rLAIIUJe4/YhO6C5oc03S/aXIgXUAXmd6zPop0W0x4FYG0KqBtIJ+Ea/UVjKCx6jmqfnWKbh7ip0kAq3R9GLTa+cmNZ2VM531mV/Y+eyhft1nDXOCCzeHC69p0s5tqNFto+GM7SDTvM1XggVVLwMq1oGrRt36GCwU9SrAQBKkToyDw5TfLtWR9JS3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDhk/GMrJGBRjYcP91qM0yN8jppvZ01RBfNFErYDY4c=;
 b=J7u21PuuqfYNNjs3WcG08cbZKBWHgWE0oe/B72akgERiwxzn5FCh+HvVnBfaa6W4gJtg+AKkT+UNNLkJagG6r0/JrSG76nmka02fMuyx07vtGBVyToWmUwnUcEoNWhBt5wBRSzn55+mzu/sYhwq0PQfqEt+S726vX93YLwra5KK7SE4zwOmue9ODSkTPdtOcPO94/7M3l1WlhVg9f3NF0szAt2vEduDkoufsUiCoZHc8tYBhp/efIV/rWySjJXVnxuPMbCpnpLR3tC896BMvjQkC56kWozeWx6w9WxmtHgAATmiEoYUUZlJusrfy/unAMXq1yjq1YHHVtBZpCx43VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 16:58:00 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 16:58:00 +0000
Date:   Tue, 2 Aug 2022 13:57:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/mlx5: unchecked return value
Message-ID: <YulXl1qhse/NM589@nvidia.com>
References: <20220730103242.48612-1-mailmesebin00@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730103242.48612-1-mailmesebin00@gmail.com>
X-ClientProxiedBy: MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f687f16b-7136-4239-e71e-08da74a8285a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ntl/phAHTTewIx8rr1gr+x5JiRZ4NFKtIxjgaQ3c/oRsU4ZjtGXo/CmT2iYjrquaW3rw7Y+yvAc9ra16pk7KSARLKlUAOJp28IPaNepGAPWVYKBM7DOhzkOPKw6qPwamzXV8h5o0m211nxxUurluVkfgzcjxNddmkzauFtjA1iPEFRAzWsFma6OqZM4XPR8vZ0EDKCmVRJk0bX70MARE9OYN6l3NUxEsrt8Wg3NnXOFt4IOqSAgmuUdjsYlUDkxt5RStvhz7aGQbSE93axus0dAQzm9BXTHaQ93FCPq7dXIUgoZb9vAi7wxmTZTqz8o5ItrcKKUOEFOR6+xnwtq6eBFYBD1vRbtcIkv8BaipIzcVjBjDXkmJ1qxDGIqsM2LdRuKF8/AvydN+F230mEUcNF7vSEPZ7DDKMfOxdIx+mW6L7z15rfJYDH7Sklbp5GHI0Ch967DRDsfCHlCI+JXZnic1GMKN7fr97/jfFKDdvgdzzuBJWluydSQNwrrFLImMTMb8fhKZJJDRmmK+2EdgGE97JMYA4IyHFmfQpFLX7FOs8kiyLD5Ubefb6ypv8noAlFpdDXw7owFQEy9CB74sE5X/Ki6LQGgVGSj7gNqvZp1KeSDL8PUJ46Holhe+HVa//UEQvY0uHHMipqvwUUeOe4g3k92erWNVHe7l3a+cZashihwUZAwmkuk/cTBHcCSH+VxRpLmhN66v4bEgVfMnHG8sPWQLVlMYm3zzfHAtGPPYvvoUtyX1ZAmA3iwkVIx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(38100700002)(66946007)(6506007)(6512007)(26005)(6486002)(4744005)(41300700001)(66556008)(478600001)(66476007)(4326008)(5660300002)(2906002)(8936002)(86362001)(8676002)(83380400001)(36756003)(6916009)(316002)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCxCozn/7pP4mBO/u74Bcbue/4w0fgwrDNBjOjG1/eGWE6zvPI/egwrfSzNQ?=
 =?us-ascii?Q?KtvTa85SDJG65SHVBOihYWcLfkUKhrwUOTCs0hCaoM6ymHri2c5NIdMaWlCa?=
 =?us-ascii?Q?GWInwQTqdW8Ifjh24SATSQ6sshL0nFKdaguYiLXMIMVC9IsDrdaGGS7izAaU?=
 =?us-ascii?Q?TYEwQrTtM9opATiemkwrEhb1AD4ots180CX7kJORadIyddK4s5c1NneCvNiK?=
 =?us-ascii?Q?B8t6QeGOBAFyUIbpQTAVfYf4cenO1En8D6Q0j+QIm0sz2UfCrPTqtlPqeOmd?=
 =?us-ascii?Q?2245LIny0D559i7PjX+0WmKXu0A1LmtJc1wgd/3ROm1+A0Kaovt7ZG5qEIdL?=
 =?us-ascii?Q?4qSGzl4PAOV8iV9/Xs7GKfH2gMlBi9kdGB7Gf5vcLL+XO/2CSkcnNuL3fidE?=
 =?us-ascii?Q?7ZlhqP1WwQWX15yEYYmEkEPrf8rG+Iis2w0jpJpsiWFpj3y8lzTsuEJd31He?=
 =?us-ascii?Q?2pTVsAZf95inV9FJGUQUJp7nczS29rgAjiP7oVbpxjDFV5vwRT3yI/k3UbTD?=
 =?us-ascii?Q?70jgdpfEUYGM72MuFm9cnsP+rBv5AQaIqo4HKNecGd+LXcO3c4PyObZlzWTd?=
 =?us-ascii?Q?0eyRhNqUkd/3eq7+7ssecrYDxEdtUi2EAnO7fwsf4JOOyPEkQObfskE/i7AO?=
 =?us-ascii?Q?aJX0soHFY80utRjjUVDkExi3suDDuxYXGyLwv707QakVuvgCXFoMhE5sIomg?=
 =?us-ascii?Q?4d0GSAeSr4muhw/5nVorPHb0oFCgOkPvHcgB+riVQSteJoiGIhRsacXKSsen?=
 =?us-ascii?Q?26HbEbO8V0vG3jPdfPoRUSkY4FMtgpkZFGmFGfdlxzWGvGXj+T5s3244srtC?=
 =?us-ascii?Q?pGkuvqOg9qve+9XqL75L7PorJ+leF1aOpLybzfK6SV2cCobU/xUmgak5N9ZV?=
 =?us-ascii?Q?tp3e6FrOivFmge8yAk2zMsldsy327uhCJKBR95c7EgxVTz0xDGMxoQpBI+d/?=
 =?us-ascii?Q?exH9WJ+/lo31i+vjlFxad5W3qQ2nV8Wizw5j8iauEfPbNY7Doo/kZFk8E9ai?=
 =?us-ascii?Q?cDOos2kwZfzvHijSpFgHOqijl/SQFpC2hUWNoXxXQZwLnqw8wQmnz7Tl/2Dz?=
 =?us-ascii?Q?nHmuZyL9sR+wHNn46/Drr4yQqCxX+iJ024VONCe6lSRGuXgMEKoNI8hfcgWW?=
 =?us-ascii?Q?0o7AzVxsk8KcqOf9WXPS0vmxMeevZ3upaNs6JO52cWfJG6X+6/v7FoQvp+FN?=
 =?us-ascii?Q?pHp4NTx1bxQ7OJCLzocFwfFHUtDWsUA2HcSvuAbigpzYOh3J7nm+q6HZY9zS?=
 =?us-ascii?Q?ZoJxSPrFTQAwwmJYz3qMTasTbn1UxzBVB4FN7RcDF0tCTfDmkoNJhFZRhLHi?=
 =?us-ascii?Q?70c5v2eEFoMUERg7o/juekfKkum5E/jUP4J5lFr9GT+0ePdNS+5uLXacLDv0?=
 =?us-ascii?Q?ucYy+TMrajcMF0VezokQzG5p1XOXolcC8vytngFOTPh9Ck8HwtlNvx+DxNT6?=
 =?us-ascii?Q?ubwIlc+s7pBUr3rtxs/zM+LC/vIUWGXLaktbtUxQie7jEDxKhqzD9qqEs8Mi?=
 =?us-ascii?Q?X4p+0P0mKHWAeoPL0JdT9UVjLVqWXs9Tv3QEb1hm9CxgtJaFXyk4cjW1xY6Q?=
 =?us-ascii?Q?Far4iM4rfOCehkPulSzICdfOX4Bzm1qMyrclbhGg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f687f16b-7136-4239-e71e-08da74a8285a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 16:58:00.8282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/gJ6Nr/agf1zcAJyLchd1BqQL+cGqT+ytb3h5E4CFfoJL4XtTxCozFUts4Od5Re
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 30, 2022 at 04:02:42PM +0530, Sebin Sebastian wrote:
> Unchecked return value warning as reported by Coverity static analyzer
> tool. check the return value of mlx5_ib_ft_type_to_namespace().
> 
> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
> ---
>  drivers/infiniband/hw/mlx5/fs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Leon's is cleaner and has a proper fixes line, so I will use his

Thanks,
Jason
