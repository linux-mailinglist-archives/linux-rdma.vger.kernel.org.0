Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72AC394933
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhE1Xnx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 19:43:53 -0400
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com ([40.107.237.73]:4737
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229559AbhE1Xnx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 19:43:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ezk99rNd6SItv11/jTVS5u1nna5SAVgTxolrLAN+Xp8iysr5HBxQtscaJ26x1ZmUL6WcHcCBuf3FvQbRIcspafVK4nIHwmaSXeu/BLicFE+1II+LZIL7HEVXoDyMkPSMAX2iJoaElKBHhmhzKZSLMCJ3q8Hqa6ufKVR7vaaDJM8VyjM2HOtzJX0gQrikZvbugd6j+ISjv7I+5vJGZ2WwGAp9MfS+FILy08Zore7zvglVc6W4jXsR+NDvhoniBw1itEHg16KNhquf6qKNHMCU6Gc6TMnz8Fh9yPJ1ibSiT05u8on8e0Qe+3FB6QiIzYqSpZq1NaO0ThsvjGPCnWEkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrAs6cku2l7OQdihXhMcKVeLdVoDNXgB7W67bnXA0vE=;
 b=CvtFid57JkK1or2ORTkjVYMnpFn8to0AyNtBUJ2oXWMyo3jFLCH7MX1tI9VP8Z8NXy2GxKrn2EACJBT3oRESJTeA287K7bz3e2Y0xu2M/2yvGeYyGZXOfRPMyYLYc5lequn8UffMwXXeuxOdo0S1BQgywkLtIUmbPzvsgG7zZXxlV10+plISqFfHwSFizX8yCvKcREHwVk6p4Cnt7Ol4XFbzXxiti8sWZcZZwqinnPGCsgYeezzHXq+gd1rx4g9tMsa9qqrOgoufbVXNlk4+s8G5iYlv/fvxZj9bQ7MNT62O8dNoJyC0b2RHZQbbFcB+ufhXFDimA+dbXd5bICJqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrAs6cku2l7OQdihXhMcKVeLdVoDNXgB7W67bnXA0vE=;
 b=nHhIbIE7AmpApI2HAEcsxOTSKG8kk70Ez6DIbvQCngCZvDb9huV61iSSJgVcroBjJNjzLf4DkVdYh0/Az5vqHC9vVKFagOaB0k5kotv4q1SnqPe9SGS14TELlTPGWMCreDqh/oCDjO8z5hTlDFrMqhzPTYyl5jsJRgez97L5KLpFmEjhbU6kh41W0lLZYFF2UeZCgn29v23MON3uPIg3Sr5bQ2GzETGqNWPudl1KV38oD+/q1bRaemX5rPrC/a5VAewAoIyd6+46H7+OWWcYckfFrh2123OICqeyw5Ak/7n3ZxxS1VbcOAUgsC5AczcHuyYMyrmMM35Fi8vuLv+3Ng==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 23:42:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 23:42:17 +0000
Date:   Fri, 28 May 2021 20:42:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/core: use DEVICE_ATTR_RO macro
Message-ID: <20210528234215.GB3874396@nvidia.com>
References: <20210526132949.20184-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526132949.20184-1-yuehaibing@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:208:1b4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend Transport; Fri, 28 May 2021 23:42:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmm7L-00GFve-LJ; Fri, 28 May 2021 20:42:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 988768be-6230-42df-afef-08d922323a00
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51598AC7DC8D3C7AC223795FC2229@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyRPDCvlG9CR8MH246aTzBS4nk5Jy8zZ3dnRLovgzCjH02soKYTs8ww+4fon15SmwvedrzEPpj3heLm6TIQYFYt5CllWDwhabpYcp+4mtlY/TzJ4xkZ0ndL0CXYYYfEgC0qMbzyndL9KQ8jc0BpPy8npTVv2e2CfrIlb5N4+wxethVO3bdgEHdQ4WCnVU0XuqhHRl2E5hxG7soZ9O9BposEmx7zBZS9LKY2NcOgzXjjVEPHUvbkSm6qcOdOJnt7t15YH6Jg7Q/3zOTYx6aiNMJ+HH0YpQn9rlnvrtGjCVs2sybN9U6m0kSfHNLW8v33kgBNS5GCIwSy1Zy9L9Xq/+oQsiWFe0blwyvYqO4GFS3kH4W5ROwOaA7lgljOJQLpM1MYt+oIMf7lFSu47PZiLLdkNz1NYcjLczf5zbrAwI1b0wlYJxYRYGu0Z9NUlvl6kxxhOjcrlD53RVySxBc7v9cVqe6J9sY7atJ7zKGl4FfcVhL/yhGeizo6AOSHRwjn4tRr1Y5CJ21uY6L3zH7/vaMb50RjlAY4s5FY93VPhuUO2gpxMaBKvDNR/iW9WK95qIWProzw9uxpQD2+xZ/7LRObJOIOh8iRdf8mwb+XKcPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(86362001)(83380400001)(8676002)(6916009)(316002)(2616005)(186003)(2906002)(426003)(1076003)(66556008)(66476007)(66946007)(26005)(5660300002)(33656002)(38100700002)(9786002)(9746002)(478600001)(4326008)(4744005)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DAZf7xK8o+B1KNyFQXnBXMNyHAQJV8dHt3Q3F/MnCbw2RhPc39HhRlZTN4tp?=
 =?us-ascii?Q?twCRFD2sPI2TY9ZCZ291DC67LNrj6LawcYGzxXt+SMz62ylYXEUFzvsmT8nJ?=
 =?us-ascii?Q?FNLt30t1ZtXvRLgLEgtoFEB8CXHpYo9uT/luJOwRz364Ut6yjrXynmF2sSxA?=
 =?us-ascii?Q?kB0TcazQXk1Wz5fchwlFktSgCJSSKROOlaSfreHBcNbZoPNif5GG84z0B4Hz?=
 =?us-ascii?Q?xsqEqQoDCI4DQAjKRxWel21Tz8CnXaDiGnPsFzxvy5KAQpS+iZ4uX9R9TpSX?=
 =?us-ascii?Q?FhYXjv3lE4EZpS1fyNvhvX8SzWMFOvP5khSiGBgVywb3uSmhvSDksLRWVYbp?=
 =?us-ascii?Q?lx6DtkPkpdBo+Hm9oqWvln3xZHEn9Ucr+N9jg7P+uGHJpO8ivq9mG+p0iyMB?=
 =?us-ascii?Q?UW8j+kZHXIaIaIW/2ZeKgldOTTyXB9kw5MEi5urq2Yj37QlaWoBcJsHfNzrY?=
 =?us-ascii?Q?zM1PMTPjMuCPHd+xyDBZ0vMtFE6lZpSVRNcqgApUZWsKOz5GHmnFdE8FFDAG?=
 =?us-ascii?Q?p6neZlUoLQ/XsOmYSklT6KhGo1Oxr//jGYhqtI1p/vH69O4HqEEVAu1gaKFI?=
 =?us-ascii?Q?u+1GoXLW6l9ineWtK+/qAeEXPMSpoaanCHdOBlu4HstGKQfdMLUNgsXMiDVZ?=
 =?us-ascii?Q?R1qJuwOoCOd3DbpB5fwDGBrVna4mIeZsE6wIGiU3E7f15JC6vzKrcL/OxkOt?=
 =?us-ascii?Q?XsPnjTXU/lLYE0yT68wV0wkv319zHNX3xn4gTeK4xBPw6UxD/tVrp8KwnJ8U?=
 =?us-ascii?Q?rAqUPDqvdIkO94qMKT9ybPioiUXvyIpldnoWVdeEbCc8Kf6RBDyofToXMU9v?=
 =?us-ascii?Q?p/V5mOYK2zNUzJDTw9nkLWs+sDxWmnb5z48b7NIFSh0bLmtqtk9GR+XQUefu?=
 =?us-ascii?Q?lz9bYdfj7M6qbFy5gI4OOIVcUhxRx3/E/cDI6Rsds4CXXR/2GlA8JY9+sFiu?=
 =?us-ascii?Q?yhgGDdQrLPsUPCNOtDDtaO79/XENAkBDA2FRwILbqZKI7eCDhQTWB59OWVol?=
 =?us-ascii?Q?EFWh8jF4XL4hqeZbOJEInlxWR158jLb9jTka3Ox+pBQLL05CM0IW4lYCHxjy?=
 =?us-ascii?Q?VmsPPYUqiB9XQFWvPB8jWg9sPLl0tnzUlnTF0wPlxZNOtoXGEkuwrocf2ULN?=
 =?us-ascii?Q?QsSiSNUjsxyX+m7bjxM7wqL+E8vVoMb/vMA4V3hplgqNwP2DZiiysNNVHgo4?=
 =?us-ascii?Q?wOdPhAAqGUL1/qQM5rUNtjl9dHz89eFKVIqZO3sndHm71VLbFUxF3sjX5hi4?=
 =?us-ascii?Q?L3MRtp68uweGgXpqbVMEjI+CPKcs7GfzpFI9EyRQTs5tyU2wWQx96ajiw68S?=
 =?us-ascii?Q?mBLIOU/FGWhNWx68JuKUIkeU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988768be-6230-42df-afef-08d922323a00
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:42:16.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ETYqZ2MuKPe/0f7G6kx49Bje8Oe6knfr6X+ZGwPmz7HOat/F8ydLSaX2YITx9c3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 09:29:49PM +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/core/ucma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, also touched with clang-format

Thanks,
Jason
