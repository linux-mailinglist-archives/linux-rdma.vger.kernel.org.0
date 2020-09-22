Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867A8274D4D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 01:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgIVX0N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 19:26:13 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:30272 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgIVX0N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 19:26:13 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a88110000>; Wed, 23 Sep 2020 07:26:09 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 23:26:08 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 22 Sep 2020 23:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz85MkZkT3RTcmfxHc2YdWjCqxXENaOcArLzPHQUVxG8WJrUPBUj0/1AGs6wrEHDOWvrXMlK05p5CxeqxS0/onRIsTVPDaAuAe1NIHTD/NNeou76XLbRlcNQ+7+UJ0kQtwasycpDMIEShci1yEFMFewcFZgZ8EG3t8wz7cqltfDu8N+WoderCXE/g8TtREWbasbb3mHxHYPydSyMJIYAKJ0ZWM6xejPUkYVrjmEVWtBuLSbR1xemZKNCLiT1on/CNJaebdHt5MQbONl53+XFp4HCYZc7erPmdJH02RdfgZsKiBLgW9KV71p8tFGWKB6+0JOSqu0OJShTJeY20aslew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrw30Kqm5R0XOJnKjXt/HDJg+slKlVB4l9Uvz4y+IdU=;
 b=E3WSCaKrdEMjXK2uuZa8YshTET7wJ1d8dx3rO8zIS/pQyUVBSuLX4CVQj4kK228F4cXR0tUxruyDdlnkbJ4TACT1b1S16gHwCMSSqhZsjYFvAq7wesHE8dhhLN6cWk9IqGft7GWG78qkjilJlEeJoaeSwauVQA/qjwC8BlZaw/jwseqsqdH7idDUV1krtd+2TgYbLKX6unmN1iKISJnGXf7/ELAV7Ktw229p4k0fISTM6XkjndMo8I2LN04v3FO9dGDS7gw4q8MJ42xBVqpbx5JwN8cReyJWGn9cHrqIzZFZcLXLFDcg2Kbkn+SHp/hPl/8DUPBuGFJhipglKYjAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Tue, 22 Sep
 2020 23:26:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 23:26:05 +0000
Date:   Tue, 22 Sep 2020 20:26:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Sindhu, Devale" <sindhu.devale@intel.com>,
        Kamal Heib <kheib@redhat.com>
Subject: Re: [PATCH for-next] i40iw: Add support to make destroy QP
 synchronous
Message-ID: <20200922232604.GA806041@nvidia.com>
References: <20200916131811.2077-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916131811.2077-1-shiraz.saleem@intel.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:208:23e::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR14CA0030.namprd14.prod.outlook.com (2603:10b6:208:23e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.26 via Frontend Transport; Tue, 22 Sep 2020 23:26:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKrfg-003NhU-9i; Tue, 22 Sep 2020 20:26:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e7554eb-2f33-47c5-91c8-08d85f4ee09d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-Microsoft-Antispam-PRVS: <DM6PR12MB438865F00EDECEA31D71F2ACC23B0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdQpv0tlb5tMRQqHCwsiHb8GaUoX0LbX+N0PaP5imS2D5OMkU6U7tyYOR32dk/8JYIeZccYvKHlMAsLY9AcyZ+9eR7ahFIRphqUFL8n4e2+bsjXyaJdGIop9Uezmc+0Vfhbp/dCylL7rRdlWUKcHVw32oiIIPa1/lhjlswfjp52P2jFlxFEMUAXWc0//P9oHfXTbKQ3OVnalcUNQlbPtTB3OYkOefkUAvzUWYeHYJm/6ovtK27ZnrtAjT8pJ4n7ifuWDXTaPcckvbn5RuS4meuDFqUf1cleXFgPjZFAXivnJ9BVSt2Xki6pgoq85B/guI79arKsoTpyCXMH/HZaZ0TXUlH/lQmqGFdsFhn6Ifb4bD9FGdR1782YxBay+jkso
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(5660300002)(1076003)(66476007)(66556008)(86362001)(66946007)(6916009)(2616005)(426003)(478600001)(316002)(4326008)(9786002)(33656002)(9746002)(36756003)(54906003)(2906002)(83380400001)(8936002)(186003)(8676002)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +Vy3pRGIKY+kZq5qQ2atnWKNUUkA0X9VdFjY8dzfzTkXvCnVU9Pm8wiihTJP9RJpiuRl9+Mn6/1X/9fXg1s+ocfrI+UXyYBtka4q6AnMYu5UEJKBtlarI/ReXzlTqzBKYm+10ZxJwL4MGubg2QDyhh8sXertkHuoEFH4tr0rYZsJq4Xlkl7pDm5/pc022DzQqKcXAy3v2yw2LWxpEF+YmNrwJ4SGm/PZcIFOs1NnDSHgdZo2r/9XxGLPXswYKsLw/pP8n+HcUq5towTpq+QIqcpp683emeB7UQhjWsDrOIL8BHutNnv2NtUy2rXrZj1u2Jhw3+I8l77mR4OIPiwkaBN20Ppw0GSxcgkg4TMvFx8VQXOlhoXCz5ziz7eVDZj2FyrTnVOb6F1e3Tp7NBMmeFAZqxzTAH+AdqBHrcMZOcs2WkkyoKW3qngB4JUw+y+a1t2DDKiJPpyqFTT+ClpxdnENt5x5ZhMDtiIYEynp2GHuyDkIcCkQmyWYY4uD+iLxXGCz2XSm2t+svvDZSTrfuon2N5KEhAJcQ6jsOUXFOngTvBCt/Q30HeZZPjgMgeK8xtpl32fNWGm8NtvhtpYRXXT67RMCVBUIqHwIUF4EIaVsuAp6GQwDuWavSRKlyG1xYJVANKN4PoQEPhPJ0jIXSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7554eb-2f33-47c5-91c8-08d85f4ee09d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 23:26:05.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9vY5Jv8MzE6779iuw5gbI2E5sQa8emRdvFcqqmpuvJFUheIz9pZxTAkqnqLJftV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600817169; bh=qrw30Kqm5R0XOJnKjXt/HDJg+slKlVB4l9Uvz4y+IdU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=nXJ+d8bkwLvPYHpVhiu+kqpmJSdjvdpOKD5b0lH63rQr0QPTUpIN25Lmz5peP6Tx6
         RWmifWb3H7Va10S0whm0uwJB/ulNEXea8JZ8SUMMrxNGWjN//8Y2b3cxdd/CktPfwY
         peJ85Gt7mcC4Evpk0wHVK5pBeeqqClY8Imju2ijc1/rJuBrsU7EwuXqMoFhdXbRHyG
         Y9SIn5wnDh3Fh8LkNwN7Z8hs8GjC/crT1zs19Ke4Et4r4nZNpsQU63mUnyodZkpxE1
         3dQTLp62/Sg2mvnDpqLvIg7A5UuHZ9DvpUm9WuHlH0EQ4SoCJIRvOHQTJp1Gn9IIKc
         OpPluw6rYHK4A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 08:18:12AM -0500, Shiraz Saleem wrote:
> From: "Sindhu, Devale" <sindhu.devale@intel.com>
> 
> Occasionally ib_write_bw crash is seen due to
> access of a pd object in i40iw_sc_qp_destroy after it
> is freed. Destroy qp is not synchronous in i40iw and
> thus the iwqp object could be referencing a pd object
> that is freed by ib core as a result of successful
> return from i40iw_destroy_qp.
> 
> Wait in i40iw_destroy_qp till all QP references are released
> and destroy the QP and its associated resources before returning.
> Switch to use the refcount API vs atomic API for lifetime
> management of the qp.
> 
>  RIP: 0010:i40iw_sc_qp_destroy+0x4b/0x120 [i40iw]
>  [...]
>  RSP: 0018:ffffb4a7042e3ba8 EFLAGS: 00010002
>  RAX: 0000000000000000 RBX: 0000000000000001 RCX: dead000000000122
>  RDX: ffffb4a7042e3bac RSI: ffff8b7ef9b1e940 RDI: ffff8b7efbf09080
>  RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
>  R10: 8080808080808080 R11: 0000000000000010 R12: ffff8b7efbf08050
>  R13: 0000000000000001 R14: ffff8b7f15042928 R15: ffff8b7ef9b1e940
>  FS:  0000000000000000(0000) GS:ffff8b7f2fa00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000400 CR3: 000000020d60a006 CR4: 00000000001606e0
>  Call Trace:
>   i40iw_exec_cqp_cmd+0x4d3/0x5c0 [i40iw]
>   ? try_to_wake_up+0x1ea/0x5d0
>   ? __switch_to_asm+0x40/0x70
>   i40iw_process_cqp_cmd+0x95/0xa0 [i40iw]
>   i40iw_handle_cqp_op+0x42/0x1a0 [i40iw]
>   ? cm_event_handler+0x13c/0x1f0 [iw_cm]
>   i40iw_rem_ref+0xa0/0xf0 [i40iw]
>   cm_work_handler+0x99c/0xd10 [iw_cm]
>   process_one_work+0x1a1/0x360
>   worker_thread+0x30/0x380
>   ? process_one_work+0x360/0x360
>   kthread+0x10c/0x130
>   ? kthread_park+0x80/0x80
>   ret_from_fork+0x35/0x40
> 
> Fixes: d37498417947 ("i40iw: add files for iwarp interface")
> Reported-by: Kamal Heib <kheib@redhat.com>
> Signed-off-by: Sindhu, Devale <sindhu.devale@intel.com>
> Signed-off-by: Shiraz, Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw.h       |  9 +++--
>  drivers/infiniband/hw/i40iw/i40iw_cm.c    | 10 +++---
>  drivers/infiniband/hw/i40iw/i40iw_hw.c    |  4 +--
>  drivers/infiniband/hw/i40iw/i40iw_utils.c | 59 ++++++-------------------------
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c | 31 +++++++++++-----
>  drivers/infiniband/hw/i40iw/i40iw_verbs.h |  3 +-
>  6 files changed, 45 insertions(+), 71 deletions(-)

Applied to for-next, thanks

Jason
