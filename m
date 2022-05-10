Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFDD5217AF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 May 2022 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbiEJN2N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243071AbiEJNZa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 09:25:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9610E14CDC3
        for <linux-rdma@vger.kernel.org>; Tue, 10 May 2022 06:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSfQ1TSosz8H01DscrfTJmjkDY3nXPtJdWjpTExKtelBS+LiSAqk3foUAr7OWa+9LUUGTBtq24yuTKXnA2cgimAA6/9kSJSp48IJeo5bhj5Xb/VA3v2t1H4EXa8DEPE+oClmFA051fiU4WT8sxBWCEFDFP/VHqf8m4YN1+YDdhPiHEADTGBB7g7LP5SkkAOAcXJ7rSB0THJVeXiEvTYLn5yT9+PbIKPG2aWdpr6I43x/lk5tUH2fldj566zijSfYQipRgHgI9U0h7/AdaV/CZDYdK9SUCAVMj8E27tn8ANSNgFbW9KN6+Em5VjKCfx4SuOsdB6ecfr6lhT5UgVU5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaAAkFKgQTgfRV84bonpdRl12KVUEg+xqIrOTWSJ72Y=;
 b=IvI30FzCjGwmaIacjq+sacZlOfTMeZQPI/u+sJTkETHhEipYcO3o4gffMr6nG7GNYa5iAx6U8Nep+yLEDrM4fA4JQxp4CpTsNVYgxycOX0Ft2CtHrZodPKmVr6RD/ixE0K93YQOrOAO1+Qxwxcr4AvnoMQ2d3LldYaCAqvS2isuV6Y5Cie6jynAEPDhfJTG0UmUaFCaT1buzpa51Xtb/VcoIJKz06klEzLKxEyaljSdsfWoY9VpYX8+FLC72wDaRK0miu0qmpuhastaOUswNAhfAwQki7wrOPSoscQstiKU5XH6wWXNwnxIWuMAUDE0DkPRzo5FC2wCr7qYbnQZR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaAAkFKgQTgfRV84bonpdRl12KVUEg+xqIrOTWSJ72Y=;
 b=nFQ+azpUCtDxxZZfrrUCmn4El0nQTg+a/7mcpM6kvI8Ilg/Z0CEQvKPWo6baxj5JWQQG/4iMuIuVvltUQGTbblNl515Qvm/keC+CLjHgao66INSVYw3OtrgPQ491Y15yeVXXdAXW5eRuuSW7Mm+lZbTzXrMSOMeM++6PmTTgSnLdLnuO172UKZqxolxCTiNJUMW2EPpctUFUMdNyMigCfl0mjZ0qXMIxm1us8muP04FLb7dxWwrFXXuHlWwhqkOYU6m499cdWSbIrOACk2wIF7AgWGfHWGjqJzdp0OYpgJTRcn8Tie/gobaOFxfHJ2jflAKpWPKBC3n9n0XDVJVS0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 13:18:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 13:18:42 +0000
Date:   Tue, 10 May 2022 10:18:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v7 12/12] RDMA/erdma: Add driver to kernel build
 environment
Message-ID: <20220510131841.GB1093822@nvidia.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-13-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421071747.1892-13-chengyou@linux.alibaba.com>
X-ClientProxiedBy: BL0PR1501CA0004.namprd15.prod.outlook.com
 (2603:10b6:207:17::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55cb9038-3af3-4b73-333b-08da32879aa0
X-MS-TrafficTypeDiagnostic: MW3PR12MB4492:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4492BAFFFF5A60E68EADC076C2C99@MW3PR12MB4492.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uReoCqrole2i9L2dISmQm9NmjjsTOTgVCUTwkJfyRrau0ecwwoV5Q2TfFsyggpCCVRrylwD3nKtwI36JYYB6IXzbeX0f4P5q6n/NtSIp+BO7ux5GAMyemH3yePNOLSjIfwLw6tOyyLQGmQpWqDO+xEvUAfmlXmy0oiAUM4jt7uaHvHz3CEBRFjpXAL2eXHAOwwUSvGrX2azJDKjgfWWhL4yNtAdGfYmdpHxhjfGFC8osq5OQYrHsjsm6lE5rXe1t8CIOnlI4WR7ohm8OgJRlI0+oOAz+XIzBRryksDl+f6cgcLiQGlHE0zUxzPAqPitCPbJ86g66wR6sc3P4KIQIedX+qHILmVpzRWLYGmKNnoMutADhpuWiXEPyXhz5bhj9mtoxPCUFT/+mBH5TBeFiexHsf8tDcjFvqW8trRE0lS5UpsdrQ+6wVdHxKFgTXUOb/gHwfYyT5OL4VoCi6kvVTVZkaQqPC7Uj5sNl+d7o7xcTbxX1ssG431dDmINTN2XRUo6jARS7mmfirWnlDs/8T+QAmgdEon17X5mNyZCrpWIw9QxySDi4FR3CLrpIuHrYRm7YOPlOIh026RV65vJAhvoFCpuZMY6N7Jx7UrFXa/Y9L8w6dLPTWlvHaLihps59hiXBks3W8166i24nRNXPAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(1076003)(186003)(33656002)(316002)(66476007)(66946007)(4326008)(2906002)(8676002)(66556008)(36756003)(8936002)(6916009)(508600001)(26005)(6512007)(6486002)(6506007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JMaVx8RldC6Eq2E8sbSd2JphlsYM8UNiPikAyJbL53W68/QAtvQYxxCv6y2M?=
 =?us-ascii?Q?8vm2l7tUOzzsq/1O6TNC0HUtkhraB1hMHgCkvulntO2gHJq6vJqbd479OAAq?=
 =?us-ascii?Q?1i2z/E5KsZJ2oYU340LwOuxqYXKfO3JvkNBItQH6GzykAEpXfU0/87EHI7la?=
 =?us-ascii?Q?W7Dda2aWM2KEN9S1CrbjSn52Y9oCcYEaB6EBe5L+7ENA9Ywo6TTbrUdwjxXQ?=
 =?us-ascii?Q?daEkvsLt7rDkxFH7s2gmWukSofbV8DE1y88yUbiVMKBBr9SGGUZ+y3qEJCGQ?=
 =?us-ascii?Q?8XwCH2OMt5zB+h7NFV9Ywsc8mE7H3oXRJDhzDaf4Xk+5R+TzgomdAFqUD4UE?=
 =?us-ascii?Q?+AV8qYGnYRDyxkFVVLoGp054lPwRoRlY87sWGA5i2vjys3glCvY608Tfy+Wd?=
 =?us-ascii?Q?54HoZuRRF8c0YaIqgPQ7wxQO7dKKG3wdaaQniYAfYkfKZUVNlp4XlMB4kLgf?=
 =?us-ascii?Q?vpmRgsc+1m5/PFr+9qTMM4mTLJkRPjrGCg7lHikLMhdlPb+g2SZz4Hw0PQP/?=
 =?us-ascii?Q?AfpOstRuygM87xx/8qcB9i1DoR0c62EoB08ZACHr6Cb2HB6KgkJpMjrWLazV?=
 =?us-ascii?Q?UJv8BQJ7libLiYLYi9MKvz/fh09eR7uiIJH2YTor4vAKXJ6BKPHP/XpUlrJ8?=
 =?us-ascii?Q?oLIC6/PSEDXWajKHi/dCItmcgq6tzLWW17xIQIJkRPlzorh94aP4csoT0rk/?=
 =?us-ascii?Q?KrM/Jua/6kTr4QLx91odxK9J9fMHcolwHBfoPavldOyp3G4tgmQdFo14CNRq?=
 =?us-ascii?Q?bJA+qsMH0TwDQWFFQyG2t4EXqEOgyKPXbG58/GDQL3NHKT3xQ5LC5+Cexm9F?=
 =?us-ascii?Q?ZO1vwuBrFkDbJJlA0Vfj9l9vwQEblMUVzb+fCDZRIJmdrCBU6BvvA8jezqbe?=
 =?us-ascii?Q?OhPQfxQziDgTRV8dA5kZSHvrn1G+/jzSkitYfyOuAUEOPsMhtbDQH9ys69z1?=
 =?us-ascii?Q?M+/bWfXp8gAMxF+VjNFbHTqnC+NqWWhVtT6CY0akXA10p5DehwsCW2CL5hPC?=
 =?us-ascii?Q?c1jqcxqQ8J7np4f5DIIK8ZEAbZbtYRzMjbAyb2x6kHK4G6v6vv8bv4AJ5fMZ?=
 =?us-ascii?Q?olq7pjj7IbHUn42Fn4wv0PWCW59VFIVrnqlfONMeGsf+LBjC8Rg4qr2izB9K?=
 =?us-ascii?Q?jlFScA4KJ7o3Mf3THpFyJa+iMFzcpOncaFqSMwu902KR71qx82uss2Rv+Uum?=
 =?us-ascii?Q?0Ejf9rydCACSPIb//vnMcLmO6JDCJpPkgefsRVkE+Ah1E6Gf/wQGz8YvMUpO?=
 =?us-ascii?Q?PVgiNkEfEN3yVDvb/OazLhNBFMM5llLRyb3z6Ow7H0tZ5ItTjXehnne0oYH1?=
 =?us-ascii?Q?7i/+ApefV2w4Vbd2GgTnziMCi0cTVwnBM8iAf4B8hdxmal1dAe4u+U6FD8R2?=
 =?us-ascii?Q?Ff39Qz0MZn99FzqjVBrwOApyMenLrATdsF7ZeJMTJpxxPJ/rhRRHX0mF83/v?=
 =?us-ascii?Q?uZadiXN8wkNGesmD9hWc+TiSk0Wt7SUhJmrPuzC19HnDH2BF7+NBgHm59bd4?=
 =?us-ascii?Q?tBuliRkhyAEKC4agz3Et2N4c61dau0zF5XCabJWYdZT/XkIBUqcDfivw3abv?=
 =?us-ascii?Q?gwewSluzK/DZZ7RSJ8A/SYCwJQ1NHS0OTOzGsefw1raWGaj1qJikBMEx6c+8?=
 =?us-ascii?Q?qgtQRuEYQkSPpkcots8uup0OXdNLAZIDL/2b1O4zhMgZi5/gJO8rT8dXlre2?=
 =?us-ascii?Q?OxCA0oYyUVslfUYPkXqTgiizg1xjqJxdZuRd9+91HXHXkkMqynBQbOUP0+iz?=
 =?us-ascii?Q?jKfaq78CUw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cb9038-3af3-4b73-333b-08da32879aa0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 13:18:42.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQaYkQOGlcb7navWTB4HoQrRT+cdq+JUtHVi+8OE+XWN8MutHHm9VtlkoJNHHhqC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 21, 2022 at 03:17:47PM +0800, Cheng Xu wrote:
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index 33d3ce9c888e..cc6a7ff88ff3 100644
> +++ b/drivers/infiniband/Kconfig
> @@ -92,6 +92,7 @@ source "drivers/infiniband/hw/hns/Kconfig"
>  source "drivers/infiniband/hw/bnxt_re/Kconfig"
>  source "drivers/infiniband/hw/hfi1/Kconfig"
>  source "drivers/infiniband/hw/qedr/Kconfig"
> +source "drivers/infiniband/hw/erdma/Kconfig"
>  source "drivers/infiniband/sw/rdmavt/Kconfig"
>  source "drivers/infiniband/sw/rxe/Kconfig"
>  source "drivers/infiniband/sw/siw/Kconfig"

keep sorted

> diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
> index fba0b3be903e..6b3a88046125 100644
> +++ b/drivers/infiniband/hw/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
>  obj-$(CONFIG_INFINIBAND_HNS)		+= hns/
>  obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
>  obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
> +obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
> diff --git a/drivers/infiniband/hw/erdma/Kconfig b/drivers/infiniband/hw/erdma/Kconfig
> new file mode 100644
> index 000000000000..c90f2be1ea63
> +++ b/drivers/infiniband/hw/erdma/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config INFINIBAND_ERDMA
> +	tristate "Alibaba Elastic RDMA Adapter (ERDMA) support"
> +	depends on PCI_MSI && 64BIT && !CPU_BIG_ENDIAN

Why !CPU_BIG_ENDIAN? That is usually not OK.

Did you run sparse on this?

Jason
