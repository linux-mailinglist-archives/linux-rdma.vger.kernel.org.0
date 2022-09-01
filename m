Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008FB5A96AF
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 14:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiIAMZs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 08:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiIAMZr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 08:25:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C7E68F5
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 05:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS73rO4xvv5g6p2Nj4Jd46F+nNTcEfrHHd48Ynb+D0uZG+Kq9q0KXCsorxcBdguzpiK1BJ0dlBHIDFQWv7kM+cNp2ZO535Z6OxrK7XPObj3ePbk7SXDyId28fmDvwnhFwjf+uBrsbaCUcBm+QfYCahaDPemS/eaoeqK/5fGaZdBWGLBGs7BiV1/gh+YJmimntqFMbv8EyGN8pgZEgvJ0LE5WUArFaSYK6+nX244KFePv//WI3TF+0iH6/K18P4rIjBn3jrwETewia9ZM5uXcxWlF9ki6r4TmvvVf2wwzvpX4QG/t0oWCTKyoA0a61pk/kDnBWUZVTLoC7fwWvwUulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEW4wcNRTFQxFpTa6in2tgMxSoz7UoQqSzPlvFuHFfs=;
 b=AUJv+oKTjNDkGzszImiVHi3nyvsZd2WSPP9xUzSATAmWtmOZ9TrSbCDkQP3RLtHDvKBsYxRTiyvQCHLjpWY+iXhxMcMjozS3B85m7fszS19g1pVXefHenTzYWYuvOWxPtQptNkptK/L9NUA086G4EcWiSLr3xj2Vnon0ATawYaOJa8Xjm8iErkbWbhLly9KgkcUlWTBn2gwrljnW7xh7hZCzTdftEIeOSkNd56cs361Sge5LzqBA92AhpuAvGApT9Pdn0TR8EQq8pVf0K8iD/A7wneUFBdgzgSYS2ruQx8zGNm0qh4W6rAE1zk2S3pJlQ+kxSk4rF7RriQ4wFGn40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEW4wcNRTFQxFpTa6in2tgMxSoz7UoQqSzPlvFuHFfs=;
 b=Odbw6pKPXzhwpyaKSmxEhje9TzAEkfpO1WTwU/nPuzTst4nyTZr5lyHYDqn8WXVwI68+PpAGk5XRK6w2JXduax3JMG4QLII63ZnXrDFf8bzmItmYzBtzaTQjQYuSJ5cJ0T8dX47mcX/HT2PCWHYM0ABdjSHlUfr/KzDj361zP2M4JZAjVl5i7bs7cseiFpkC4rgWNkOZ90Z+2DZsrfcbJ0e/7xnH3Du7eO86TjJs8HviOQIfNBCG4goihHJ9J3vNdjwy+/KC1kWdLXM2VZXBwkUfR6x3JQtD2p7y6FXb+XYD7eU0+2GxY1O8qrEYo2apWOhH4jORel/baGrw4GCe5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 12:25:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 12:25:40 +0000
Date:   Thu, 1 Sep 2022 09:25:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Add missing Kconfig selections
Message-ID: <YxCkwzWMtiTkNYZO@nvidia.com>
References: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
X-ClientProxiedBy: BL1PR13CA0434.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700f651b-0c66-4189-c01c-08da8c1514d7
X-MS-TrafficTypeDiagnostic: LV2PR12MB5872:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/2iDGvKVRcXo93765zB9zLSzVagKGkuiBkHg+un6PBFmRbef4cDJermlaIBQZ+W73+d/vAwa4YT3KzzDcIV5yQAvhYsh2ehRcGuVUii5QenYJR2x0xYBnrSuJcG68h8BVdPXIV/38IsXmovGz+tKMIlVHjSIi24mH3mEt0kmWfPrNJwEl5Juw4kEwKyFAtn9VHoeM0VHxJxGUetProhJo0yLWNoK2h3a35F+Fa0Fyt5f8y1lTeFYprKkON8QqcPXKJiSfYumeNrNpt0EG9zu9TBr63rizVHLey39S3jJVCZdnIjjoyV2WaFTTLjNy7KuilEqNz5jCOzsyimMhVOh+ndD8ghY7M9R1wgum8pavMc/igmEM6pmZ9DVfIIiTa6avsumVbo82XMMoZzLhKCc7l2JUbptSSf3Rn4YTWK0jbdx+/Fw4LRdk/5yD6/FtAJs1zkF2Deda1wLzMfJsBbkZMtmpG6UNrbXSuRj+Phj76oSK9Qqq3U/fkTwe9dh5Qq4BxH1tRmmy7z7Fp/XYyPDIvdNKtMqpu7aXy8glXL4tkthO3B7ZpjXlgChaDeTvA0CsarhH634F4YvQus79S0y0CQmwUm7djkQ+D2FlQm9PWPXov7FT3S/XblxkTw/onabtKchSNob8K7FZEO3ktH/BtDRoGOW1/cF6xrevaqIHw6ldg3P4Qf4TdXRAfKUq1QrqSzCQJBRDhoxfRAwgCwxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(66556008)(66476007)(66946007)(86362001)(2906002)(6486002)(316002)(26005)(83380400001)(6916009)(54906003)(6512007)(8676002)(4326008)(5660300002)(8936002)(41300700001)(38100700002)(478600001)(6506007)(186003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQtRe7EbmcMlO2LP/3bJKNWTQK0BYf1l9bwsbBe+tkRgIfnuwf+ebKD1C/yp?=
 =?us-ascii?Q?mj+03EX+ZBJg08k8s3krWmOYRVdtGG0IH0//TUvbjbSTzw2IPj6inc9fmWjJ?=
 =?us-ascii?Q?RsN1cl8j6Lfj3x+KT0IpYjhTmth24avlvFu5cptTIe+jVSZ5SuHwkcDyJOe4?=
 =?us-ascii?Q?M9EsR4EwtbC/HmiYLYhayh+SNipO0+z5nJr7rB8EraowdIEFx5fdsoxJBUsu?=
 =?us-ascii?Q?1gwd1RGaPdSSG7S+8ip2tk7J8mhdK9Fq27bhVk4w+EJuzLcyKwPQgge+lIeI?=
 =?us-ascii?Q?uE1HafBoq7i/zuoS0F2SLNRO6G9e3rUWhK4fgPhXl6tqtELqIIANQ2LbIRc8?=
 =?us-ascii?Q?GxmlzSb3zFw3usTtJIrugcOt1F9SYxXaOK+H+9BLqX/4BtLNevkVo0gkH62q?=
 =?us-ascii?Q?8HtLOUwgEX+AJR/GQtllRNAScEbuGWK69FdTplUv2ClWoB62ALAL1RG6X8WO?=
 =?us-ascii?Q?0pubfVF2drnU4r1kh02YIk48TS+Mc+5UtPZez2oA1M+mUrv7IN6CJXyAvJFa?=
 =?us-ascii?Q?oDTZc0lNasd4QoD+t1vP131zOS9guo+ZnFqhvcOGtVdUqZrUPMbe1Mr1DT57?=
 =?us-ascii?Q?Inq1Fa4u4zb8MPEjo4ZBKZmmAimCV2CAtABH2QF2Xr1jdbaGP7i3utyNXlJn?=
 =?us-ascii?Q?JN/Uf+N+Rwjxy/xkXjfGalO+hUIT/gV0N4tbvI8vY4Bd7wYOlalQHeXjk1fI?=
 =?us-ascii?Q?o0BEGQipBmh0Io16ZbgAltkiBmzknvPUxv2P+y7+qgmY5+S5JJkmdy3Qrkyj?=
 =?us-ascii?Q?uqeljSxiLQHkio2xrupyk2jG6VvFUHIdCmUPK70mGxtLaP5KkpFEQBMvcDar?=
 =?us-ascii?Q?uURsL/De7534mwNDo5cLYlUK93lo28X0GqeO60wcHUVUPwsGCGY8DatbjSDQ?=
 =?us-ascii?Q?0EzF6BOZew34l17c17rwZZDJb2qgZlG5fj2ksJR0Kaww4pJQs3z83O3cdVpX?=
 =?us-ascii?Q?1NUArspF8sTr5u146yu8j8Tpk3/lo4TTtuNf3V4Qz+6kDQHlWZbyY2xuAwgR?=
 =?us-ascii?Q?WfL/OHSHpAwYA1INd9jBXxJGjSv+au8WuU4PVfntyNszGYJrJgYgHiBKKEE1?=
 =?us-ascii?Q?4RrWlhzdqJA+rhPK3rGYj3Hsue4Dj10k7/R0XmuB8HitZdhVUcLsR7+LWXmO?=
 =?us-ascii?Q?B8Y05x3aP//ZOCPJ/tC69eiKU/OwjrLlf6bGx+KfoQI10rQsQdsdpIu7erEb?=
 =?us-ascii?Q?P31YD3JJktXagV/sI68gkyW6JTxxVYQwqWTMcqshQQnR/iXKXHqdcODd8AjG?=
 =?us-ascii?Q?hc7Htt8Js6SoI7HmMsaIVdkNriD+F+VTvRnBqyK0+TwnmDmWT+l3VQQ5oqIM?=
 =?us-ascii?Q?V8GB/wA4FGwi55xnQL/4oIuJhqz7MVryZYzbftMcZ18ZExD0iWc5uGEScCr+?=
 =?us-ascii?Q?HNMuUEsqAIT2sIwamk20N3C0YNLzohL/dDONj2tfhTQu6HL6eSkhQTM0BUmU?=
 =?us-ascii?Q?AXZjxDk27nDTPggv/+9nGZie4LvTDAZ03wOCexngiCvgBgvToV0GFmuB6ZJ8?=
 =?us-ascii?Q?oUy1FPfH7+da/AE2HZv1d6b0eDEfkhj6VLnN+L/HRQIc7enMakcB8JlL3MAp?=
 =?us-ascii?Q?NFTU6Tr9Mw0t6vwnhOdzLh5sxIlf29TyyziKiUlz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700f651b-0c66-4189-c01c-08da8c1514d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 12:25:39.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBPB9w5WtzzqVoJtloG5nOg8J+y9KJ7kZC9F3PPyyHU3E4DqKiv0eDpFTXHMaXTM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 31, 2022 at 12:30:48PM -0400, Tom Talpey wrote:
> The SoftiWARP Kconfig is missing "select" for CRYPTO and CRYPTO_CRC32C.
> 
> In addition, it improperly "depends on" LIBCRC32C, this should be a
> "select", similar to net/sctp and others. As a dependency, SIW fails
> to appear in generic configurations.
> 
> Signed-off-by: Tom Talpey <tom@talpey.com>
> ---
>  drivers/infiniband/sw/siw/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/siw/Kconfig
> b/drivers/infiniband/sw/siw/Kconfig
> index 1b5105cbabae..81b70a3eeb87 100644
> --- a/drivers/infiniband/sw/siw/Kconfig
> +++ b/drivers/infiniband/sw/siw/Kconfig
> @@ -1,7 +1,10 @@
>  config RDMA_SIW
>         tristate "Software RDMA over TCP/IP (iWARP) driver"
> -       depends on INET && INFINIBAND && LIBCRC32C
> +       depends on INET && INFINIBAND
>         depends on INFINIBAND_VIRT_DMA
> +       select LIBCRC32C
> +       select CRYPTO
> +       select CRYPTO_CRC32C

This is against the kconfig instructions Documentation/kbuild/kconfig-language.rst:

  Note:
        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over.

None of them meet that criteria even though other places do abuse
select like this as well.

It looked fine to me the way it was, you are supposed to have to
select libcrc32c manually to make siw appear, and it already brings in
the other symbols.

Jason
