Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F794538FC
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 18:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhKPSA2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 13:00:28 -0500
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:44512
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239231AbhKPSA1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Nov 2021 13:00:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtzDXE8KNNriWf94qaVKFWxx8RIO6izqMkV5lRsN/gBESxK/vV4nC8FNQs3SLRGOtKk13yvr3OXhLv1jZbpl8pyz023y7LoMazjOfLkQV+v2EnD8MAdRV1wmvVKYm0V2YS7GXBRUQJFyLJ8lKJKb7mgNaQ2TZWwldHM4SiD6TSnQyvM/dgoTmA1xaHQTBTPJEMNSFDeyARDqcjdGDz9b60KLchcLa5ppuj4UeEhT7sJ+ZMMBeJlSalyGU9u5JxCNKK4gKYINXXpvQwLluef0nr1BHmkbqP3rVyPknnkEHxf0cDjE9bVPtXhv8RvzuHjdg0nmbWUNrDFgXLGUVQWDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX5HRX+m5n6zQVVmkCoT8uNJCuFpi3Wnj2FJq/OJjlY=;
 b=VTRYa7MOy4SNXabXqedejdmZ8CSnGtjD+4uVuOTHuJJP8YZk8T3SMJVwx4su7rRqfSpgwWTnO7w1LX4rbJH5fgwSfDVBX2+BFU8jSNBoiX+fkAZXU4ssyxHrZ26g/CbRCb7iD4+FtIs2o9uJsqXOKUdjLLOu0Z9bUUieGeWurK0TsxiJUEHuC3ZohVRLZDtV8ZSNNunSg7uIJt8h11A27nTJsNyAnJSffsKqUUxfPkUVf9af9SmNXxQ5r1oBiNXNTbaZGbEvl0UzRCzbBNf+Sq31jU0BOmhPL4G5qfQdCSGTCnsdWhQqyEN2ibDh3paxXAmRvcgaY+CSL+05jwgFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX5HRX+m5n6zQVVmkCoT8uNJCuFpi3Wnj2FJq/OJjlY=;
 b=DcNIv6NENK7cU93qoSzvP+iJY1CHsxP144fijJ/bg0UfukJTlYCXixeiYzelTEbHU3FizFuS7WrB5T3nB0e7QIbl71WBMR7XswaQT3Eznwx8sbcviRiywUQxdkkwKr16PF10CBH0FaxljTAlSZLztg+2doMqR+1uRw9aDVEvk9uHdvwWPXwDEvkXABlQ4/XZjsr/62bG8dixb4+Hlhg+JC9KwqCABi4aYZ7EPaCQpDHodPR04VZdfZxa7cymHrv+S1JBFxN7Lk8qvnNuDZGnrOLocoXxjVA5RoG4PpccqM83AdJ3Z/AN40HEVNSRxTNU7hCXQ+sCXiqdN/6F8tsnmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 17:57:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 17:57:26 +0000
Date:   Tue, 16 Nov 2021 13:57:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     selvin.xavier@broadcom.com, dledford@redhat.com,
        sriharsha.basavapatna@broadcom.com, eddie.wai@broadcom.com,
        somnath.kotur@broadcom.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: Scan the whole bitmap when checking if
 "disabling RCFW with pending cmd-bit"
Message-ID: <20211116175724.GC2661511@nvidia.com>
References: <47ed717c3070a1d0f53e7b4c768a4fd11caf365d.1636707421.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ed717c3070a1d0f53e7b4c768a4fd11caf365d.1636707421.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend Transport; Tue, 16 Nov 2021 17:57:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mn2hw-00BAPN-Ak; Tue, 16 Nov 2021 13:57:24 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d4f7463-e99d-4e45-1b7f-08d9a92a8c83
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5320B5EE68984EA4ED3CF9ADC2999@BL1PR12MB5320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdXqRtWDmf+lU3UkMir1GWcopu0V/0sD8Rk2lJ5E5E3hON6Ex21r2JCZHzrjtgi09+QT8n8AKh3j248Y5egkf1Nr22Cjp2euY/foNcr2R/Aff72DPeXmNxzPjOCnF0epo8phsQTtR1D8mqsgF7h3vQPAetsXID1l+Oi2F+p5z8JskGnwr4fNj3Xekgq9XMUG377V5fc7o0+wAaiaYudCLI/RiklQAsddmOTIxLRejXmQuIMgem7Z4cV95z+14gQ7lJTWWhVo25luAzlJrf7TVbTpguq9OmGeLX9yhheW+eD6Ry6MAEtLgHYuaXIMqL+ktZ49XCUgJhG9t1duQTmfb+clCOgmtaLp9ttzu86zrbJiEGx/fuCHdKZ61PWvIhAMdZHsNtT6R9N5bR8zE3XyUCTNe7GD9OjEL+7WXevbaC7i1bh5j6dHsnksuTeBR/ltkhsd4op1jL2Tr7D+yL8cHoZqfpWwmdpTlW8bLJcGqib4X7F03r7DnrSAqvyhUhO8ECvtjpR6rGbw274gKWlgmFcLzEi65Qf6BZBbyDwlm5byy7aobWxjMh+9tmQYXHeqBwMyM7yjCEQ1+OG07frYEkPJnhl0MO+0xeGRFQgQCvgYFTFOsPq7rF3nqDFmuE1wSLqwfZchemtHOgTb4Z2rXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(4744005)(8676002)(66946007)(66556008)(4326008)(86362001)(9786002)(9746002)(2616005)(186003)(38100700002)(6916009)(5660300002)(426003)(1076003)(8936002)(36756003)(26005)(508600001)(83380400001)(33656002)(7416002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzgDS2c3fJAhxfnvpLmv25lAsGGxanbFhI+mslmQA9vnzF0k+uYDhHeC5Q43?=
 =?us-ascii?Q?W8EzD/KYxwKZh9Q8XCGYPAmr/QF1DQ2INYhmaW3tyj0ZUIjlNXQONtls921F?=
 =?us-ascii?Q?kC5jNHbMaguojENSY1LiD/2pbnrnHXy0LZUYJlHsRkhu8A/VYXFC/lqOpPUe?=
 =?us-ascii?Q?ysmNd2oeOI8Ur8yNawxSufSvme2HopWT0gbiMiER5HGzMAMrU/M2haXrEc+v?=
 =?us-ascii?Q?HBA9bsDwww1fHzdbxQstM7DHgT0KOK9kZpWtQDYzZQBang/MJIwLrMj5E9+t?=
 =?us-ascii?Q?X6ToYfK6+gF3TOYrFIuzbzliW68lRdV6vZxFTLYzY9tSK2vn+huKKH0x7PnO?=
 =?us-ascii?Q?zl6Wo9PGuJEpR4Fps4dwhyprfbTtpo0a3ZKX1VOG9SjTiTAxKP8/uJ5AShu6?=
 =?us-ascii?Q?opFr/6VBA27VgFCLl75onL/f7VTr3Oir3bblAeGjErxtwS7i20AHSNsk0oPr?=
 =?us-ascii?Q?pDkPc4uwxezvFZGhQ16udo5GHuk6XsLAW+4Og6ZXjIMiEi+vEq0Hm6FXsnXV?=
 =?us-ascii?Q?oK1rLxE3hxPTJRBzVZGniba9lOj7ixdA4GbR+g3KafvqgHpdCual5ueH9JLn?=
 =?us-ascii?Q?jlUbI7jVbvMY1qm9dKaG+Q4Zcwa8n5Bp3t6iKwpIXe1DSW4pDgaeUzc15cz6?=
 =?us-ascii?Q?z5VR1PuB41z7hG9ns9nt7eMOVyj/6/I11Qnr4u0xQHGjPvIn7OGLyOfpXrkv?=
 =?us-ascii?Q?HGnFvhBoQJdXcQQ+XRIBtp9S0QCi4zpw5KJM0H7LCgmdQl39WZRdOsAWab3e?=
 =?us-ascii?Q?nDeyJsrk3CYyi/ptrnfm1x12eoUZsurwNKsm3bXKllTnuYJx2PxXL7cS6Dro?=
 =?us-ascii?Q?RA+soHSuS5bq/EWzQ1KoKnUT4oFuTM9ftloVtdDbb83AvPwOLpiLSkhCAu1s?=
 =?us-ascii?Q?4MBcKYmuV/JcgnHpi6ItL2b0g+eteyUO0vlbLqG4GCRSchx2Ak6EtnLyu1CO?=
 =?us-ascii?Q?o5egdS9G/B/Ow6sQj0lyOCllWAVg04n0n4FUI+amYmQSkZKTSJ2pK2lcnB23?=
 =?us-ascii?Q?e3sKjgOz6aaKN6RlCT1eYg2OZhdISR2OoARlkJskpTrbe1HY13iL2X2iAiZl?=
 =?us-ascii?Q?1uKMQz1z1NlsdXnRFMkem2OC65VAd747N5daqpXtKJm3Ii8eMVrcVyzKYsRL?=
 =?us-ascii?Q?aTHT5W/GSeTziqTsjj7xAbZd1Nmo1UMIYjP64sATTbLDgaXJZFFbLSLdpM2A?=
 =?us-ascii?Q?GTmcSJmmJSDWDFJsAvjWi4Lav2OJM952rzuFgtNyHy4Dxrnn399nXSJhWlwj?=
 =?us-ascii?Q?aDEDfcv3bCpQuGzwYVLMtSMiUvmK0llUvOTcqS4LWzyzJIJ/e92DuvesFtBA?=
 =?us-ascii?Q?rx4JvarFrukHWMGkQI1xwzJffac26UbbPXIwRTN066/E3DjgUCPV2teIOie2?=
 =?us-ascii?Q?I72kZdinLDdWDYLKGqBzu3MOlOyHZp1QE3eSLKhXfe63Sw9rElk/GTLaAGCi?=
 =?us-ascii?Q?ycM6pJXJyyzolq0vv0Ab1Tun9qkyu+TzfDE2a/CIp1SsoZlUNHy9v5/Q4VDw?=
 =?us-ascii?Q?x/FWV0KfVWVcbbKo47NzjB7x32Dbiw1bg/sJqyYn2Hk4aSZhoebZFPK6LSOB?=
 =?us-ascii?Q?OKoWKrmNnWdZ5NDAHx8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4f7463-e99d-4e45-1b7f-08d9a92a8c83
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 17:57:26.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7W71JvYIKzMCVk0PVNusnv4wO9hckvrEje2UvMjPincTYFVvu88ZMh6wJpiDJms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 12, 2021 at 09:59:04AM +0100, Christophe JAILLET wrote:
> The 'cmdq->cmdq_bitmap' bitmap is 'rcfw->cmdq_depth' bits long.
> The size stored in 'cmdq->bmap_size' is the size of the bitmap in bytes.
> 
> Remove this erroneous 'bmap_size' and use 'rcfw->cmdq_depth' directly in
> 'bnxt_qplib_disable_rcfw_channel()'. Otherwise some error messages may
> be missing.
> 
> Other uses of 'cmdq_bitmap' already take into account 'rcfw->cmdq_depth'
> directly.
> 
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 6 ++----
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
