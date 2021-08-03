Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039AA3DF268
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhHCQZ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 12:25:26 -0400
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:56193
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233319AbhHCQZ0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 12:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqNgql7GSNxeT5sg+WyUyuS479a/dOCAhipa6nOoXrlFUTfvxp4gGu9xXEO2YT9Ceg3F53SOyl/tMOaSysNCzR9GETCYKx/jqVzKHSMxacdAwttfGJJKHUsClviLm7bQrZSTqgdU+FHEwL2M55uSfBR4+XcSKHnxT5Y+2mFQfc42y28Cm6n8VdVVHhWwRCnnss44rNI1A8jqmaFjzxG5RwG8XM3AfNIaXDVFSd00r7ExRxxuonFO87mNxHqoXxQFxiR113H0VgLZZNGWIJ/e/lu2YxzV3bj6Ap8pNcved6y+ts1qLFsE6fVsbB93jcGBcdDULJ1JO9TpjLcjlU1Gkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bSrgEVsPee3fmFzfxVJHc/4OcLlIqaAQgGhd0NwqHI=;
 b=oDjRg7USBpADsgQ16AInhVuSkmSRhZtJOdKl1CUm9RYxo+H48+QYyWvEGZTgBxgtuBtbOi7fZZrzmZRA0TzaUZfhKIym5hRBRSK9XhxkzNTtUpEAaKlYaafTR19/9Qp1ccQXofQlCMQt1TKkGmtiCtSIXtM4WwV0ACmZBhaVokJ2ElcUS+VR2jO9A8oAQ79ThWcK7k2QL2bXSgeG4jHzh8oyCoXxpZG+TIHSmMJTi7OphGd80bYIbCczf9yv+MeKeRcrGqVJFcKfD2DXWJ2DOTOxTCOBx2Ebdv019UdwFc67ZjitWhdBKt24UMlIQr2RjYP2NWTcmbeKyiFWHERRug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bSrgEVsPee3fmFzfxVJHc/4OcLlIqaAQgGhd0NwqHI=;
 b=hV1nO8+uYTfOi3ZrhtbvhkBzX5tMbno7R1RLYC1ts447++IY/bCnpaWFOg0ruKIJZUvVtdoORg3hywEZPBx8DOzTTsQfPWN/EXDaqm9q9tYxEPq6DE7AEUy43EHpcaW9ma6+zgabSuYeKLo0kxGyScMJdCoe34yW4P0sYZNwCWCMGzZaJAqCdCwrLdCu+YZEahcgOHO77kbdvIz+YTp0x3JU6T/pDm7+EpPiy+MkUa88CrfiTi+UA1UC3peC0Tfp4GSpJg2F4xDdK6UQgFaNkNLSPEYVJuuKg42iT/ynpO4odlClA0skK2+5D/KkUwwBxWIubLzJjGsuxXNUZIyrxA==
Authentication-Results: cn.fujitsu.com; dkim=none (message not signed)
 header.d=none;cn.fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 16:25:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 16:25:08 +0000
Date:   Tue, 3 Aug 2021 13:25:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Message-ID: <20210803162507.GA2892108@nvidia.com>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
X-ClientProxiedBy: BLAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:32d::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0034.namprd03.prod.outlook.com (2603:10b6:208:32d::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend Transport; Tue, 3 Aug 2021 16:25:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAxE3-00C8Or-8c; Tue, 03 Aug 2021 13:25:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 257c6672-b171-4c87-27ae-08d9569b424b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5030EF4F71363E805002608FC2F09@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vz3Tj4l8EhfwZUY/jcxrASTngRzSlLDA9yhXekfvHOYTJnqFdCKqTMX90HqnTziTAq9+1y2+h2zWBZNpfTJ7nrCyC+0ooB27Nc6c7gWkFCgH17AG8MHHrsy2xIBTR9O/1m0q9R8sBtqiyX/tOu7wQINwqlM6zQtLdee6aNLFeYPffa0gbbV9uGn8syi1UkcxM75tB6JyJDNRLu0PzvtnDPtZUPtYj2N/M3i0VYCAJ6zQTdaFf5SEcjgDmvx/SCZHi+KmZfF0EI+RUznoh9RoVbkBpMNbu7Ks/t8vDgH3E4On60/68zPchdPWSLei/9kCunNaESuLS/dKc+nwMI0F2NhsFCuOMGnq8UtHWGEBMxq6/F4HQYZrhGQWotQaC4e0m3GGih4lLrJCFeom+KxGLtQT69RsXmhVfdS2dQn1wSUPgrkd48AnJ5c7rQWCeUBnfYHeAHmn1O3vwLI/5wWOsA5ejbU3YhrwhObkKMxaMcTeCN/1Fs1dNSLf4rpwD6lX8FthBYw8Cf6mKa9kT3cAIyYKqg7B0X9ZTHrwNHZNz+yMYnycPwayiwEvBL21hBhui7aZEwYgUcek4lezK//yy3hAGdphsJRY9bPKJ8aMicCG3tUXHNFKd/XkyR9UxPXf4OKSFrP/sh8RBdm8HlDjsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(426003)(8676002)(5660300002)(26005)(4744005)(86362001)(66946007)(6916009)(66556008)(316002)(9746002)(9786002)(66476007)(2616005)(186003)(478600001)(8936002)(83380400001)(2906002)(33656002)(38100700002)(36756003)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SDbNtgAiDp17I9B3g2EZRETT3lggPlNWswAAeuIb19gByoL0lLK1VrA7DNSy?=
 =?us-ascii?Q?l/MDoeV/GU8nqfjeE1KL2tBHRV+PA1MvZ+BnkB05KiW3E5IvzhUoYFB8l11X?=
 =?us-ascii?Q?rX1b41z20IcMo3wGN699As2JPt/WEeqMG3vKt+hv4URvcYUMl5jr3vIBxi0B?=
 =?us-ascii?Q?H2Pd3Az2z3fTYWMKr0CoYcA2OFwsZ0bk7JcSdoY52n+1NjJ3xUkmx9KwqvKK?=
 =?us-ascii?Q?sO8EaxvuDlo91VDJReREzVnJRhzkNNZ4VTBTW9Ii9I1p8i2kvsUXil89dUMn?=
 =?us-ascii?Q?07hYg1eDrTx3IQNGnBUEI1SY6l3kSErNwN63IYdFt37FxV0d4KI9LlcRhrcW?=
 =?us-ascii?Q?8usCSOw9yqlHnboV71emG3vR/Ti6EHHqIGSe74XUEPUn7wAtGOhDUz6YCbxO?=
 =?us-ascii?Q?I/OgHZGBV//swiiPNVDNmjYXTMqqzUiluQeZSOrfU7Q0RvukLTYRFMUaKSrY?=
 =?us-ascii?Q?COqIK6b0f6UOdb2zF5VvDkZesgkAHMUQRc/NuLmEtzJwgUji7rBE+Oy9LyLx?=
 =?us-ascii?Q?ffLLeGj8oDW5/aui2psfmGdMFQo2OhnpjSgpFtHG4Dvo+NPRaIxpIWcTgppF?=
 =?us-ascii?Q?W9Bfqwk6JiIPfmPkzYwMpJ+P57um2/iUU/GnlrQ4EKrae84rDaY3OxEFm4bz?=
 =?us-ascii?Q?OAbCQJt52mzylcWGNWfFTUWJ1896gYh2FSfJuG2Q3jlBBmdIF9epw3ExYJE2?=
 =?us-ascii?Q?7SOmgemNLsHqykZUoGnqPYZ7oF4QvgKVp/aC2kepv/WHRkIzgzfd3/PbMh3o?=
 =?us-ascii?Q?9414/jMxm+pGhVOTGOBH6d+O2x/unts/lU11Fkd7pWFQdTt3hhnsf65vJALo?=
 =?us-ascii?Q?A+oJ+N9TQtCg/+2g0OKtUScOifIBLQN/od2KRbxK7YHhUrKGiORwzqRtJ4NL?=
 =?us-ascii?Q?fJc9FSmA1SnZ3t1oKJOYb0Er+7mKyYQ5icOiQKK73bOT+oeHmQiyxVCaXGI/?=
 =?us-ascii?Q?3ML1RLTUBb4QROafDetNzvoU2CvXfJx0Y/kNZ7lbNP1AFRArjE8Liim37oJX?=
 =?us-ascii?Q?TpKz/+G0eig4IvEFKZ9v9Nxaefv6/1AuBwXG312UF5oUtQ90s6NYYMDy3iHp?=
 =?us-ascii?Q?gag3Q4ZPpQ33fnOXTaCEyiG8WpcvVAvns6SFreZMLr7hvirtKZ0gBnBQhM9J?=
 =?us-ascii?Q?KT5r4qqIXbepaVVWYm5OV0CuX8kmVb9hyIWX7N/I6rqUMUPfEOqw5AM6wSGV?=
 =?us-ascii?Q?LmuDuAtfN2TK8NIjKfsnU1Tdu0Yr4xk6ZggpYRjO3HNHSTxYCDUQIj/4YJWj?=
 =?us-ascii?Q?HecxoQ+Aawn7GvqKgXgPjSQoMHvN+wA30zyAYRBUAzRwi0kGht0OI4IiGj4Y?=
 =?us-ascii?Q?xQ04tQr4JBigl/alQjpjzo+f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257c6672-b171-4c87-27ae-08d9569b424b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 16:25:08.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcBISQiCUQ4bTVrJUx3U9dAu97Vmhx05+lI+gzAM+v8DlDzIWMc54iWwjikd/b/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 01, 2021 at 05:20:50PM +0800, Li Zhijian wrote:
> ibv_advise_mr(3) says:
> EFAULT In one of the following: o When the range requested is out of the  MR  bounds,
>        or  when  parts of it are not part of the process address space. o One of the
>        lkeys provided in the scatter gather list is invalid or with wrong write access
> 
> Actually get_prefetchable_mr() will return NULL if it see above conditions

No, get_prefetchable_mr() returns NULL if the mkey is invalid

The above is talking about the address, which is checked inside
pagefault_mr() and does return EFAULT for all the cases I can see?

Jason
