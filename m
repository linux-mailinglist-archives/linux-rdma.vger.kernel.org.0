Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5223F5FF4
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 16:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhHXONb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 10:13:31 -0400
Received: from mail-bn8nam08on2075.outbound.protection.outlook.com ([40.107.100.75]:65137
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236268AbhHXONa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Aug 2021 10:13:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koiEMJc+dbEdiGdkhV/7zuA8/Wlp/XntE00gKVWhEJ8MuUUL7Htpr1ofj4p05s58qTPUxLZ1tL2CmqzBUAqVeNZf/UuXUwxnOsn+T6DX57qFrYEgS64QcxPDEkwkVBwmCsKFcilixhIvua5iNJflqXUBhZwrB1WudpdRi8WFKgD10/3W9GX8GdB9w201hqzdflB9v/Mllj/cuUeTnxuzXFtUfoGkmonYcZ/qezWlqAJrU9J21tSol30PFwS/rfmewZqgyHO9Ejrs3HeOkZRNb6JFmfbIdFdjYR8e7338v0PNDoglhWcKsUjWW5GpBVfAcw1V0odEKO31Qu5JMsNm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2YxzkQixo73P+TikHESawYhwnhxz7Dd3EEqxAQeQJw=;
 b=NL/eelGUrHAJPPxKEel9odk1bE+0qAUvWRCDS5TuwlhI0p2is7rUvYebGUdqG6/nh1olOdACBLqNZTiSXIgq+7vRsSFK4qkohFIYpCOHevhORj66PTbTlHonGbtXu8yAA+pCq2N9WlR2r1IEZaVLQxizzzeOsw5UD6JbEMx79WMx6eERDrG1QCyBBAILENpEOlA+P3ARXW01i3B/nl0orr5gR39YH0jCy+hqvWPx7I3Qnt59jfahMWp2Xce9kuhHTUP6irR2dJ6zaZ6ovOAjnSclE7TcMpCxTEdBZih3cSnSdrk0rhslrz1JP8SWmpqo+e+s5sv+bW9YUsfuhH8LCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2YxzkQixo73P+TikHESawYhwnhxz7Dd3EEqxAQeQJw=;
 b=tWfFP76qQxXh47VjhxhxdRoVTOlzbS8pSfAHESzqW43ivyjhd5sBgcQwMKCy07SKlyORvx+HEg+qnEHTEsqvt8hCrzpjL83yfsx0Tz283FtFvDHk+rICa3e7DP5QaMe0kK/Xz3y3APwST0EyyrhSR4ZH3iA2Ts9IS/nGagBZLBU250z5I/WGPTlluIDCcOM0dz2CgW3CP1zhruCzqzKml/9Am5q0CNTQeJaye+mrpeEsonKtoWKwJeIz4N8bD/FNnNdoSbSMD8pjh8/7YerGMs9BNTlQe/9Pee/rc/I4UKRz5BM+hdnbD043x8JJjAeMIYuIF5cTixwVnx3A2Nln+A==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 14:12:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 14:12:45 +0000
Date:   Tue, 24 Aug 2021 11:12:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Use ida to manage some index of
 resources and remove unused bitmap
Message-ID: <20210824141243.GX1721383@nvidia.com>
References: <1629336980-17499-1-git-send-email-liangwenpeng@huawei.com>
 <20210820184833.GA566369@nvidia.com>
 <d40c6ee9-241e-c9b6-fd80-6936db34c1ea@huawei.com>
 <f96fa057-68cb-ec44-0c29-ef2345b3fdea@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96fa057-68cb-ec44-0c29-ef2345b3fdea@huawei.com>
X-ClientProxiedBy: BL1PR13CA0249.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0249.namprd13.prod.outlook.com (2603:10b6:208:2ba::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.10 via Frontend Transport; Tue, 24 Aug 2021 14:12:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIXAR-004UPC-M4; Tue, 24 Aug 2021 11:12:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 784c9a4d-8464-4013-216b-08d967093e77
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50478B6F433DB2293F84D537C2C59@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q++wT7xX4gTO+4HXl+99ZLhhK3QjL6N7tk8+U2SBiBi+RrjeGRS9rNiCC5moTJmceWh9PfcIKMRffn7T7fjpxnXs+mFBik3Nbsr++Oxf1r7gQ755FzkbzfhPBa0iOsjl9jzM6AzT91e4FXKju4SpRIhtbqSoRkqjSjdhuUcOuMKuBcpWm69dTF3kaekmujIdWpdy/UfxpxS6oFncmZTSBfU7LZsCLxOOQvCsVyTsiOnFB8TGh2wUguiJRYmTFCF7eEaITMuTClWh7V3lD8hZcTSZU65oy0Fck0EJYC6aplhOzD3wDbgixi3QH+/aMLnhtZJogXIpxZytBxb2WSvtHo4a/tO/Omkb7BX1bXJRkAuT35jVMf6JTs6xAjzKHQjEIHlHWnRb5wFA+omXUm7sIWwxSBWwqdmtlpclJlP5ttAzKMVWoThYLiwlJ9TJbD1fCZEiARCaevvWWM1ETZ+R7/7iTYxzoRWFvT9pgFyqAQznZNGgQxjwrqHZNvCB+0RkjSvhIABN2ZaVjfzinfU9EQr9TqvuZ5DpWKc0ELiILch8iTj28M9FhrifKH3ay0Qx8aXQBZ9Sk+X4p/UvlEasjR8uhyyTLRWn9wfcuZe80/NCZr4mErjeAFiV/MDg0jvPbbnMSXO0HW2Bettpz4oO581UpLJnyvma5yRQBQxjzNGsTrBhgirYf2MRkEOpc6y5MQaVubnk6+xujvBZ4zwSQdUl5ASj8EQ+SRK0m5e5uaBzqUvDNzcyn/Ca8fxxbCNBuCuuucZfpnvrWKrcH3Ieng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(2616005)(83380400001)(426003)(86362001)(9746002)(5660300002)(1076003)(8676002)(38100700002)(2906002)(4326008)(66946007)(66556008)(66476007)(6916009)(8936002)(33656002)(36756003)(966005)(9786002)(26005)(316002)(53546011)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3SGHrqktwPm9NanqlM9LlQMMRfIsGj3/ycJ+aOIBiJvxw/4eJuvFgh39RFH?=
 =?us-ascii?Q?/dTcfrWppzRj/lzQKfgPBzBMjoEUAXdCvJJpkM3EwkjV+vYeETxf1MfB1RqU?=
 =?us-ascii?Q?pCG8K9kQBTh/Cn4XjjbuzWgIBly4pdzzXZwTFZb+kep5GOSjIqhUMdXoBGsx?=
 =?us-ascii?Q?eq6CbZ4KTa/zxKBewiIKjQjRmKVhVrRzGg3/C+xRGZaaGhoJC26oUGW+gW3D?=
 =?us-ascii?Q?9N14KorFJ0Q0Tif23J26rLKQTVCoM1hwe8Wrify6U0YI4gs5XPh6y7UycwWC?=
 =?us-ascii?Q?NjXWy68wjfhLrHcpnQ0cuPVGbX908joO1eaI4dQS54nSEMhB1f6FNhwNmZ4c?=
 =?us-ascii?Q?dI++fz+aQoetamRnVfU5fyN1wReljq0pVybyw6mfa6w4y0B2Zyhti6/fmjX2?=
 =?us-ascii?Q?tTmIAJOgKofbWM0hZT3Ba6h/C2nUelUUNf5iTZuHBOm7twpXUUwwplYfWXzE?=
 =?us-ascii?Q?YP9TBl2XA3ohV8JgTVjwCwuXyUqcTTvk4Fv2C7CF3c/N0/5ykpp0V8BuwYjm?=
 =?us-ascii?Q?LweDfVYlgD0VxnWJ+hlIM1JsGqS0m6oOnSxHIQJzE3IjfJEy3usM9VeuHSgy?=
 =?us-ascii?Q?pqK6r96Bp2hFUh4phwD5S+ZoP8+Akp1ukW08T+OFAX0FBBjPn3gP7hfPXdsn?=
 =?us-ascii?Q?pB2ulSbI5z4lbpAHPq7UTyqqAs2Xlx4Az6sLKFJojWDt4Gdn+dU8uOuKbfW7?=
 =?us-ascii?Q?S8kab5jIuSgj56GQhBpapQAh+r7CqG4Mjyod3HCOLIm1rNoeR1C6IPwSKIXd?=
 =?us-ascii?Q?HSPuC8FOc47PkM5E5T07NrudrVO6dyJkqJ5VDMBoGlMw3GBZ2V2L0y4hdlmS?=
 =?us-ascii?Q?uwjpa9IHNAzmjJNCNWbT+gtIXRposgUZI4r0LwCh04rNy3EmcvluicQOy0go?=
 =?us-ascii?Q?uKNf6az6tQFihSBfcHl2fua+zmtUz/AjVkFWhD78yuIt/3UtnO6oFQGdzWCY?=
 =?us-ascii?Q?GbLpE+fPxfWlymf8IBufn6EP4tqG4d+RJ0Ujofp4UylBoAq3JYK5/OpcMoY3?=
 =?us-ascii?Q?p7fAasG9trz7wmEFkIYlMZRF2Pd81qxuhTAqS7ry+sKFKxhTnW/W1qTBfWmY?=
 =?us-ascii?Q?qcDBz+J/8c+IgqCebu/2kU6VNSGAkA8Bo8VP0Di5KJ1qdE3GcwXUV9Df55Br?=
 =?us-ascii?Q?DYscCcEQpczO+gTJCKv8Xw/9Q7SDGcvgX2Xw1oZOy8FmCwOvt6APm2q0+Dy8?=
 =?us-ascii?Q?8bWC3dhP5p4G5rGjhVYzTVEZjjoAvftDIzD/OKSERZkdmtdjMkE6d5leLAZK?=
 =?us-ascii?Q?AGrCjIiFix8orUkWkLSnX+iwA1vP/hc037fJH89YJDXmeKQwYWAVn6jaiLHi?=
 =?us-ascii?Q?CB7MpiDAcGLBYNU6Y6YxSLGp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784c9a4d-8464-4013-216b-08d967093e77
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 14:12:45.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqHfFQDPGxPs88EIAk4kRVfehxh6/reTWsXCe99jOTB9X64pn56ggct9KjWgANRJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 24, 2021 at 05:37:03PM +0800, Wenpeng Liang wrote:
> 
> On 2021/8/21 16:26, Wenpeng Liang wrote:
> > 
> > 
> > On 2021/8/21 2:48, Jason Gunthorpe wrote:
> >> On Thu, Aug 19, 2021 at 09:36:17AM +0800, Wenpeng Liang wrote:
> >>> Use the ida interface to replace hns' own bitmap interface. The previous
> >>> ida patchset has replaced qp, cq, mr, pd, and xrcd. This ida patchset
> >>> will replace the remaining uar and srq. Since then, all replacements
> >>> have been completed.
> >>>
> >>> Link to the previous ida patchset:
> >>> https://patchwork.kernel.org/project/linux-rdma/cover/1623325814-55737-1-git-send-email-liweihang@huawei.com/
> >>>
> >>> Yangyang Li (3):
> >>>   RDMA/hns: Use IDA interface to manage uar index
> >>>   RDMA/hns: Use IDA interface to manage srq index
> >>>   RDMA/hns: Delete unused hns bitmap interface
> >>
> >> It looks OK, but doesn't apply. Can you rebase it and resend? Looks
> >> like it was based on the earlier hns patchset
> >>
> >> Thanks,
> >> Jason
> >> .
> >>
> > 
> > I will rebase it and resend.
> > 
> > Thanks,
> > Wenpeng
> > .
> > 
> 
> Hi, Jason
> If the jgg-rc-next branch has been revert the patchset
> "RDMA/hns: Add support for Dynamic Context Attachment"
> (Link:https://patchwork.kernel.org/project/linux-rdma/cover/1627525163-1683-1-git-send -email-liangwenpeng@huawei.com/),
> then this patchset can be applied without conflicts, please try again.

Okay, looks good, thanks

Jason
