Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ED6424705
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbhJFTlR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 15:41:17 -0400
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:32864
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239633AbhJFTkz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 15:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cor033DsCWV8EWMhYONAwKruWv23iZ3hE3OIY6r7TGY+rECeu+XaI7jUM3F3a85LOP4U8xgLd8n6OTs73x7eBBKXSJj3rR8xryNy1Dklw/t1ohTiIoqdlSMkd50N1tcqxdy41tyIq3hi+No2uWgHanF0TxJLnR2ozs4FJOyYREQD5LC3ge6SjLq+RR6KWE0A/C7STUPDbsKt5lpmzYKYhyNTb5wlcR8G5GNf7LhzLY7VZv25vnKtsHssbP7CDrhgBsQUouGUbvvujQ9tbeHcOWPzPa2qguizzeBnpqecX49XVvbXeTzXEDiA+Esr1mudn3mlGh9PyxFzsGM7hiYcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nW+G2Zi1UZ86u3cGr0/UOy6OdSxhq6ixh/qLySd0NoI=;
 b=Fr8Ztinfmjxw9aX8ta5cfg5NVzojzKuoG2divlFdjdVBeYRjocfeq3aGNb1HJGmN3FXaLFFEVHTzQLQQEA0/JXIgkm2+Q6PVORoKSMSOQ0xaaOX5e+/ehLwl3vCYynLfxzInFRSnS9+WdCmfT7w7aAXabnWH0WYJGkrPGdKBYJN1U8MX0muVogqBzpaYg39QpVCSI2fpw95+59aE8shIe+U/jhNIRd/ZmQuILQDLABSMrOGJbKoatnAvtgCM5O/npA1RTREWdZ27soGewKxAGWUdFWGcDcX4Vtv3irXE4cHHmnB/md17oictDlUQ0QVUvCoNj3putXI+iPPcFjm8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW+G2Zi1UZ86u3cGr0/UOy6OdSxhq6ixh/qLySd0NoI=;
 b=SYlX9eU6riCe5matw2JwsfrT7wAKphrFvogoQ4TJSkfGLZMhfdtv+UVVihtCYR8dmb5LXm3YaEJee4nz3Ch60QidzFewk5ckvfgKorndFBX1wgz4OfUExRAAn8d0YCxb/2rP+vROZ4Gp8KTcs8o7DFwqV2oPaZrpWZy71y4BtA2Ss6Jp3xRGYvKFifAEXIY/FOjJ3MftVvrjww4mfw26zLqUXHuYtMl/eKQdAjG5b/7Ehu/GEJEhNgTGunzTR0QMSFEA00HoFlJtAk56Efx4L9tKG7Kzn80LM8QMA5TVs5RAfe9Z0HmghoUU7unnDzaZ0Zx8xyf92K/9GguJiqrLkA==
Authentication-Results: linux.dev; dkim=none (message not signed)
 header.d=none;linux.dev; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 19:39:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 19:39:02 +0000
Date:   Wed, 6 Oct 2021 16:39:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: compact the header file
Message-ID: <20211006193900.GA2768251@nvidia.com>
References: <20211006201531.469650-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006201531.469650-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: MN2PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:208:239::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 19:39:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mYCkm-00BcAA-JG; Wed, 06 Oct 2021 16:39:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38b0c776-d94f-446b-ad9e-08d98900f2cc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50802DA2D56BBCEF9415CFB7C2B09@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BokeyWcdT7HPiP9kfVqgzbg17NgDVPS248wfqxIi4l8I7hSj+8TK/t2i+lF5cIhJ94QuTodgHH4Cs2qqZTvmhOKKErFTFrdckYHlc5FPrsUb5vJoaqfbsZFKn7KT/77lLXYP+he085IyJ8l7ItMqjGZeDrI3yQbGfgKEZq49xtRwUH2hgohkMx9Pon2BsyYisjLTlwLpaS4+yeEFiF1hr9iGaXDs1zcmVSxF6X3Rnj/HfbImg9ZyWxVedBjY/thI2s1zZXoTV4i7nTdyvI4y83ZmsNfTMudZHyXMtI/dal7uv62Meuw1F+Y7obSHccZIMnro1yqzMzdoeNo0vl2EqPrEk3qFkMW9S1F8mWxFa/hoXGo7vsDihp5CMDSV0Yeg4xal/S8ma5B02aX/ixRi2RP7FLNeUk4dGgrglYkOYdLt9ybc6oUCbQXzBbn0J90cKzWGI2TtmLq4WdtbxKgGr7Zi1CyESFMb/IeZQZJ0v3yjjJFKLF9HcpBQ5MnP+v4j79+d7Xec7LwvgIXv/gjdax4AUJsmVfF7Hos0kbQSp4TxyS7A6EieoEE/+H51E5RiZeB8orvKHDl18zQRW8LPBTL7gZniLd2VDf6msDWapiK3yuGjUtpuSfnv9qXnS99Z6V3J1AfJfRqiIZxqBJDEZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(83380400001)(86362001)(426003)(33656002)(38100700002)(2616005)(66556008)(26005)(316002)(66946007)(36756003)(66476007)(8676002)(508600001)(186003)(6916009)(2906002)(9746002)(9786002)(4744005)(1076003)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2jnXbxX+14mRJyrstkZ+Gabsfq9pYBf9AkAsHq6dBaW2cNdshnA/oL5nnOAI?=
 =?us-ascii?Q?0TogzKg19lf5hEki3wF41o0+FpoAryGphVB6P0i7UE0PSL6AG+mkJSRdWQVb?=
 =?us-ascii?Q?4AyOXTiABptmX48ESi+vPRCo5u8hh/1fPbMDtTixSPlsTaxPq3ma2NsQi5zL?=
 =?us-ascii?Q?lVFs/n3qZAtw7GNu8fq3uCPhyJhU6xz3jvZj0TIevPTPe7UrloWFX/+DVGPU?=
 =?us-ascii?Q?iX+e0RyJA4fdqD0b/358kp238i+ZU1GITYn6r1x1G5TY4ZL5TXg6t1qDklse?=
 =?us-ascii?Q?4lPqZ1te6OhQqmOMkgvywp3yU3DRNCCr/Ja6AXEaqrNgG8LTjvBsl6gHQj1h?=
 =?us-ascii?Q?17rTKy9Pq3K4XCuK661T/Cj9B67oOCVQf2IRx/6z5U6LO1Fp01MgIWhh2YOa?=
 =?us-ascii?Q?DAy54FmwHec28ncu2yGBhBB+k4rjPH2USzoZVwqcIlRv6HCbPlVs6koRgbhm?=
 =?us-ascii?Q?u8QsqN1vPB3IC+KhOlJSoD1kBQGta+m9rz8TKvuDTkZWUBch8Knopi9mFoEl?=
 =?us-ascii?Q?k3wiaLt7caQ0b25+ZjW5VYlVPDyd3nmFbG0xK9H+YdMymwEmCReQSW/erKfu?=
 =?us-ascii?Q?Hh5B5j+msXKry6seKtUFjfnvWAxCVB7Gmc40U5mN37Qa0Hkjr3aWUzDQaijF?=
 =?us-ascii?Q?s8DDnw7m8ZGZRSC8lGoCoLVznsEAXPYUYyYuR5QnkUGxXqpdy6YwAZTy6LUj?=
 =?us-ascii?Q?mS980ZlGp09EI+YeC4SZXDKTgHo1459EpePymcPYN/4aRU04ANmUZHnwj3lQ?=
 =?us-ascii?Q?yWdY+RKooYndTeE2VLNrZ+q3GqtRXFfSHNkEvDDR3kJ86Pi9gjeC711Yolo9?=
 =?us-ascii?Q?hTGV6B7nEokB9xAHHT0M0LiHz8DKn9HuE8pEfXnKDbHbOUiJuovgN4NNYjUZ?=
 =?us-ascii?Q?mRiPgT/1OoD5Co6vw0/ZmSOQTPJws0c9qkWjE06Os9WcA714HMaH5LvyszWH?=
 =?us-ascii?Q?3ZEVKKbKoLN+l7xyea4Hk/jDOCPz77f8TEFEhpP2JYm5vNs9ltcmQjUiX+4O?=
 =?us-ascii?Q?w1BBnFEReSVHZXLxQ3db/MMZJwD9SzZJYXyQ4NC75U6YPcJbSzDIklYUh+aA?=
 =?us-ascii?Q?ZEdH7hvu8TlkrM7+pNcZa1bZfQ8RZJ6aANs41ka2+u7E4RnyXpc5FuYuyAKc?=
 =?us-ascii?Q?cqqBEFOD3Q6aCHnOTc55paTvPM7ANAJwJ1diMmzugEq7HC98BlfA/I9JNKOW?=
 =?us-ascii?Q?HNlkxN9rQGx4NSqjCln85H/QSGsfzmIcRaT11uSFEdGZie3NGgvDW1rzswfu?=
 =?us-ascii?Q?w1OY04yiVNsLJmA8qERgH8pFe2TegCX913kdquTCjDIHTaq6Ii84Q4GsdFCt?=
 =?us-ascii?Q?YlV9Am24GJue3g3ZXsL4HZGtdziy6hCB5YEahFT/zl0jEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b0c776-d94f-446b-ad9e-08d98900f2cc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 19:39:01.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGiObqgsADBX+RPjqX7sjdm4EWMmM2H6KLbZRg/CUMozchZoumRuNNkZmJ1wSUS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 06, 2021 at 04:15:31PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The struct irdma_bth is not used, so remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/cm.h | 8 --------
>  1 file changed, 8 deletions(-)

Applied to for-next, thanks

Jason
