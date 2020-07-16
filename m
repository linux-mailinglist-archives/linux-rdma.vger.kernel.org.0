Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1252228A4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 19:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGPRBY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 13:01:24 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11796 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPRBX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jul 2020 13:01:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1087700000>; Thu, 16 Jul 2020 09:59:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 10:01:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 Jul 2020 10:01:23 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 17:01:15 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 17:01:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0T9RHtQHYEug8NCd+hOBA3CGPM6uQAesYmi5r0DXeh1hkTwW1cc0U0p2VsT46Tsj/O4l1mGqM3qLyxqmYeTCVk2O7D+tIUX74jgH4F5UemK/1SEXAevkwM4gNbaA2Ow7TwL6TpkpCMI9QukBxMg662PcBnRVEofz8SfnyHoh0YmDlDPrxDU5kjJqcQL9Y6FFqQTTo8jFSWgDLHOmmLFPLKahG795Ke4P+b7BQQdpd9UtfZlqT9L8Fh9Z1X8yUeNCFonbJEc8iN2IKvvpPVXdZb5Rybr1dsv/eI7VHyDAo4fFGZSzGXZp6gdr8nOKx7cvl4g7wD2XV9kcKc5+Sj+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcYxMuwEmn23Ub0b08evpx7NoWCVWqAR7bDE8WLzBJY=;
 b=KTv63vaxcGnDu7arMO+N9o+E+q+hJVxxPLYJML1AYb1bj+9cXQZww9Zh+6Y0nYvRpPSFvh5GmLUu9pAm18O9o7c0qq7fsQHJoYsNYTgwIlWPeMZw+O2nqHWf4iUEewpleti0xhDQLjRRMtDcjYN43CiLkQwcV2rdhMLW4VeWI+BBLdNRESPd+fqii9uctmVFBHGoz+TKnpwFwsVdoiwzMFWN5ItuyeVl585fv2qq1RDkS7WuE1vtFW1N8HwSrKdWI75TjD0M8DLkk7BZv851cbc9NzIpQ8sqfLb1PBtUXYA61wLHNxpVsSQMvA6SXxkne5MbZcTUj/iAa7V5QQ/Buw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 17:01:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 17:01:14 +0000
Date:   Thu, 16 Jul 2020 14:01:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "Zhu Yanjun" <yanjunz@mellanox.com>
Subject: Re: [PATCH for-next v1 0/4] RDMA/rxe: Cleanups and improvements
Message-ID: <20200716170111.GA2644423@nvidia.com>
References: <20200705104313.283034-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200705104313.283034-1-kamalheib1@gmail.com>
X-ClientProxiedBy: YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 17:01:13 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw7Fv-00B5we-HO; Thu, 16 Jul 2020 14:01:11 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcfd0fce-5bd9-436e-f807-08d829a9d8db
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4235DE8C9E529A40CD75DE3CC27F0@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5tjDwSy9UmWuTyCe7blk5VFBRgzcTRU4hxjKC4pUhFenO6W54FRjKSK6cFOcL+yMTwzyJY0TrckWeenKZjYsB7UST8KlCirpgXtyuGO0eiai4+0h+Vn8kwFPT2HZjAU08Kmc6iZRTxWBXa9z1wAW5HPeTCIT/08ch82nThC7YQTA9JVfOBJvudLZb1SlG7RFS+yl+jSrViM26OMpW5sFP7zeJx7G9uUYB+MQrnoIQmakxGslNwyBPQXPxNRDa0ya14Lknu9JQC9A3+8/hAd96bTUYWYO7IZl4TxdYYYKYuGRlcdW4GPKMfL7WhiP5lW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(66476007)(66556008)(1076003)(4744005)(66946007)(26005)(186003)(86362001)(4326008)(33656002)(5660300002)(2616005)(426003)(83380400001)(2906002)(8676002)(316002)(6916009)(478600001)(9786002)(36756003)(8936002)(9746002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cdVn6gKD6QdDrTwXBZhD+hrNODEBOYpHWdrzah4gby0uXxlt+x0du8tQ4px5jb6ncbNW7wmFRAk2VqdrQWMAvMm48efQD0m/zNJo7tVJJ+oUHGLfIpPHtSbuw57rKhAF+o/xjiXBKqswEOk3RQ6Gok1ts7UBmN14JdpUXz3zXK/ueEFs5yyjrAze1/B5LUxSzEztSGpGgiFBMEjEd/FGj1g4kENDVY2mmMQQ9LAJBFRh0HSYmSs2o8Dnvn4oc5iZCDxM5zC3nupENzBbAT5DVSFN4rkOUWkomQ81TgWjt3Ig3A8QfnU8wy1wqKCkzqv9gYGeQQnlkhzxU/9y7niYbAHdqAZZEJ7/i+FO1YNZkOBBv7DJ6aYQqeewvzlVtjDE9lkiApM513TmRGBJxZBeksmmbAFEpYRuf1W7nMPG4EkBVAgfywMV1Jm3CJu0D7T/R64VjP99uasaBKe0hzhjNkyavLSaib0MsRAy6RaoU4u7URY7l8whuIXoJupBgQ0d
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfd0fce-5bd9-436e-f807-08d829a9d8db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 17:01:14.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ng63ftGytSqVRJePxOnJeqWBw/4/I7l7fK2X659aL1zEDNO3DRtYOZS7javKE9o6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594918768; bh=hcYxMuwEmn23Ub0b08evpx7NoWCVWqAR7bDE8WLzBJY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=YTuIHyt4PdiVWUrSbBtQSTWntXRtHJD5zTKsmu/hw5b3YxXbSZ+fXzwX2x/RiI2TL
         MumEMM7/8tysc39zlEKus+6YYljKb2Qiwjnr/ZdbpfkdDHI97gfPpMBmemUAVkoeht
         GotcLhiWssx0gIzpb5ksOobGM+UXNNpooXzhBG6xbVFM0myFiOCm9Xd1WfvCOUEzTu
         4UL++A8QI7Ut+pxuUpAghtXt3DIfm1+4GoenSSfm8wJVXf4LDw9nVW4YWTeWLuv0z+
         i0hBmgrcGHeDp+LNtLQQdAWS1+nBVhpiXFbNXds8o2IPmNiTiCxq5et/YvbAmqd2N5
         E60WTdWYwHafg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 05, 2020 at 01:43:09PM +0300, Kamal Heib wrote:
> These series include few cleanup patches to the rxe driver.
> 
> V1:
> - patch #4: Fix commit message.
> 
> Kamal Heib (4):
>   RDMA/rxe: Drop pointless checks in rxe_init_ports
>   RDMA/rxe: Return void from rxe_init_port_param()
>   RDMA/rxe: Return void from rxe_mem_init_dma()
>   RDMA/rxe: Remove rxe_link_layer()

Applied to for-next, thanks

Jason
