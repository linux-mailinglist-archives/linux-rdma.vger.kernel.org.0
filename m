Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B413AA75C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 01:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhFPXWP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 19:22:15 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:27137
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234476AbhFPXWO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 19:22:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePGjlTZx3H2J0M+1Bj7tDeoQE9P/Kk46V79VCQGjjSru5r0K3lbNkKg+mNHPIS6gSWBNtSFJsiRshtIainsnXTuoCAfMRAr3RQbhaRTioSJzxJ693XupBkEOB5P24nGsW9MN6Gbke0rZoni8VTeH6CiFC/6LWpK+aTKUcuv8eamRppe6+OaPAGJqRkGYnxQ/x0fSQ0vAGp/KrtfcHz7lCb9OPp7dbVw30anULuD6fWbUyO898TcyzggvI8VD7Oep9rpeVpqibIxCvTE4k8gbf3iAIR4i/xrRdT29KmZNxIxj30cUnyZzh58lVTa/Wtd9/ab0uvWUEjouOEsFrt1bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cseAfmmmLrE+VKR5xaNdBEaYP70FSdcIJRaxVfm72SY=;
 b=Q62TGfz0EeohdKhKb8CBvt41HsOujxj7GxuoXi+UNmUsnAaGnKONmzXNGg07k/ys5OpIHbXEUjyhx5DmQpe8vQqAzze0gK5NDs5nwaKlMVzQufsPvcttEYeTaIUMi0NLVzr70Fw+Lmi+dYnCL27sJqdZSakTeQgfBBmmoO9GsogD2XL7AmCLmpLPFe3V6KS5aGeMHObKvN+vpoZadtbtIkxo2nmEpB+9sS2FKfxBtErsXSMIFFmXF+ThcNa5kTZKkIVueKmJvgVLLqTt2Bow6+HoClExqtLcB9wvs0l6s2wP/Ya3bJLxAQ8A2n4ExW1Bb1Qz7qvNrQ9fbR33PbVlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cseAfmmmLrE+VKR5xaNdBEaYP70FSdcIJRaxVfm72SY=;
 b=W5rZEO1DI9Wc8zcd6FX7zTYdeIO9kXJrdf80MaFnOe8YIvzBAz7hvHXWW5aVfU2VqI9gQjz52/VXKIXw4lP+MX+OWzu7j5GqY6V2ypAVD2Vw3M8mcSTwDEKoIniXYnjqLXa+su7KvMTsGn/Zh9ug2xQFscc1COgRiIZkpIA7TJaJrVIp1ET6Sco5YTZgj0oborwwU7cxgubGUiNxGbuATMuiLfkf9DGYvRXw5d1AwNw+JtFsY2LXkJOoqtUZMPfjz0t6+9crbRTCs7SRaYc7hjwP8u5dyEo0Gqzd7tukVtrPw6e8EPZMt3mV+yo+WpSLXOORflsvIeh9YQVH4S5MoA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 23:20:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 23:20:06 +0000
Date:   Wed, 16 Jun 2021 20:20:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Support getting max QP number from
 firmware
Message-ID: <20210616232005.GB1885358@nvidia.com>
References: <1622541427-42193-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622541427-42193-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:208:32e::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0132.namprd03.prod.outlook.com (2603:10b6:208:32e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Wed, 16 Jun 2021 23:20:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ltepJ-007uUW-Pl; Wed, 16 Jun 2021 20:20:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a57ea67-bbfa-4a20-eed2-08d9311d4719
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5062C14434F8899855CF0292C20F9@BL1PR12MB5062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D47kkcJkOGKr1bpbssBisN/c6TS++Zi11Lxui6zoGRNBm+qEYe+ynKg9hTcxL1oeGhst/O86qwTcWpfbW81Q2tpDjT/vX1IuFWKMzRklwP/tTSKhUEzPTKkV8V+tFx0l/o23wRPIeNqkAzgz8aoCTYrdt7duSjQXTDcW2yKv8zLlbIxuO/WBZym2h+TvwzkAnAeQtwmLMzldN+KWFxCNrjJfPZBtvFkRR3eeOQ71dilVV3oLGVkuDADHsEbFSZZH96sWwRxI4qT5L+XYgcNRuGlxvnCFeoTrXrkWqT5aO1F6KcbNnQsoCWcicosDURrT5V3FvYqFWRpsBqC0YUUhWcEaTmWUli8qRAModT0BwcAhd/biVPTWrc5TFyNV7bCyJ8FRhAzy7MnOK6VTc9AvCoUdtU8hz/ACtuFG9A/W5BACLxoGx350MSoDwydjM8kO/lNmE3tfU0ckqsegUdyYHn2s08cnAHBwUahAP6lfSxiNKLVT13m12JzLc/WRQzLa7RgVhLhqhpSmn9c1gZpeZpAy3MH+idnmCRCe5n7zVcqyarsMe8DBtXhN54tAlDp1jOMlH1IfvaA2gpx2dicNGc+yej6k4r9fWSOBkveZT1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(66556008)(66476007)(38100700002)(4744005)(86362001)(426003)(66946007)(186003)(8676002)(83380400001)(33656002)(4326008)(316002)(6916009)(2616005)(5660300002)(8936002)(9746002)(26005)(9786002)(36756003)(478600001)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?baiEHJVjZlZdPJqN85EKQP0FTePtje4NfPLIfAkXVJSVvlF9NNenPaW5WFCC?=
 =?us-ascii?Q?kL54MFkZgKHKwjGm0grShHxpXalTvuubKYCQmPgwTaVa+m3ZOZj/nIz/QGvs?=
 =?us-ascii?Q?K+BDQB/H+nvTMolo6cwN/u32BOKG2l37nEW3SL2YDkqWL1F8Iah+KgdSs5nn?=
 =?us-ascii?Q?I0OEqLaGSWesjZofH08cJJPRK9o1kOHfviiq1DsKD5PXl+3Iy/Tb4roEpu8H?=
 =?us-ascii?Q?yBj+1Ujk9Cct3b/b/9iTykrqQAkmNEeFr3e6IF+rP5yZG0VI+drTi9iyDIyx?=
 =?us-ascii?Q?jyuP+mJjLPTDiWNUgz4xGnBFv8cqGQWCsgMSAW8iA72FNdNUBgzp3ZmcidtV?=
 =?us-ascii?Q?DJE58p3miOvOgh/WPZNu2Y50RdfhfC7lxGfXUnvolVeAoCkCv87IZxMkeWKE?=
 =?us-ascii?Q?OcbQFZg494s5d4x3TPzcXU8G2qggehSZuyWqeGsE7LoUDpUUJi8NZTkt83nk?=
 =?us-ascii?Q?TjviXNTsq4JSAZC/3TM2eBX0CFhOSb7llJgLYIdYQQjQ/hx5ALD4FO2B5OuC?=
 =?us-ascii?Q?QIXuu9iB4T+CMFKY1FQn5FQ9aBV9iJY3ZukGBUpVinnZT2z+ePupS0OTmdab?=
 =?us-ascii?Q?ELfRf3IkPEHDEm1gpp3DfN9891ytJdoJi33i7QJowImg+thQm/q+MuR8O+t8?=
 =?us-ascii?Q?kwfrLe/wGNwg91OUTLAMRG4on0WtPuiN57tHfvt4yIJJ8BnIMFvtK2L1M+04?=
 =?us-ascii?Q?NpfQsaG6HoMkC5EQc91Hc2WaXE4bR7Mf4/d/MAz5dX9z4vESWG9OeYT66rE+?=
 =?us-ascii?Q?0k+37SuZxYrG3rahfUP5DGqOvq3ywBSqsVOj2b2uL15UKTOkzesUIe5wJPWe?=
 =?us-ascii?Q?KxHTS0MJY3k3c7blvMq6iYw5w9SzIXqx2GrrH/gni+4H7YHidVirarjrXf9a?=
 =?us-ascii?Q?qZf8r4QK6F/r5y1GRmQ+Bp1Ru47JD7u4T//0Ryje/MjgB3rHkgieuTS7HeiQ?=
 =?us-ascii?Q?Yz3E8E+mlDlM8pq4BwLRFdSQLwMugG7+Cus9rbBkmbvqBheZAfSMC5peanMY?=
 =?us-ascii?Q?bp0Yt1oOCgz7SOIZ/40boDlxzuLGnb/bSAFalAp17wnuJE/mWNlrGqHXShNm?=
 =?us-ascii?Q?oe07qXEZL7JHOcR6o1sVmcb0RIzHoAuewP6xipnswlWl+0oo0IZx9yXTtNXD?=
 =?us-ascii?Q?TJeyyK7IXx6lGvGR1Zy3IZir80TeO0WNoxaIHPKZO9CdvEURaJr8hlhSn+ej?=
 =?us-ascii?Q?p4aAHt9TPgRUeDwWzu4ft/G7wR3+wA2UV7Iys4GUCtoG4Fm/psjWlCsoHYjR?=
 =?us-ascii?Q?Ff6SKKpapZe7I+KSuFWb4gK06i+9v6FWaYc060sKh65ahKS9kjtOGcQgmxZh?=
 =?us-ascii?Q?ioOnVt0PAqK6mcd2Qa5r1Fmn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a57ea67-bbfa-4a20-eed2-08d9311d4719
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 23:20:06.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9LW5L6JucHJfltQ2iqrgPheSPxDy3mJt4sD48Ko8MSHu9zjl9JEKg9gR3EesWjU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 01, 2021 at 05:57:07PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> All functions of HIP09's ROCEE share on-chip resources for all QPs, the
> driver needs configure the resource index and number for each function
> during the init stage.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  5 +-
>  drivers/infiniband/hw/hns/hns_roce_hem.c    | 25 ++++----
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  3 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 88 +++++++++++++++++++++++++++--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 10 ++++
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 +-
>  6 files changed, 106 insertions(+), 27 deletions(-)

Applied to for-next, thanks

Jason
