Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4487212BE3
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 20:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGBSFP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 14:05:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18675 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGBSFO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jul 2020 14:05:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efe21750000>; Thu, 02 Jul 2020 11:03:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 11:05:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 Jul 2020 11:05:14 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 18:05:04 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 2 Jul 2020 18:05:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co4s60Moz8RjhfHaQkmIPSe2MLLUXmyYUesxe7lTD52q5lsWz5fJxI7R79pYhCQYUtnPK4PIKN0lCGHWOHUbspSmMc3MjXJ9ibyuQEMh7kf4FeDnNR+XykI1cDuaBTeskW9JnGfGvim8mQPqcT7U2dwgI4izJaXNtVGy+gkdbyN5dA9yMiQFawbguVmHR3IuUp+oGyOiqyjiDclvMuYPEBDtjvE8V4OhI50ZC/0d2oZG1ohknC2PrKAqAN3Nz8YPZFYpd8oqK0Qrb/lyEG8FLzcCSKqoV6HM4Fyunddj+1an7Qyymbf66J3v7sfFT/YFEAmuOFct+EeRTgNTbICodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6UVg36/FLzpnrGUWeP6EQw2f8PX07ws2gf52EeElHQ=;
 b=TpbFEm2QdRTdmRAOeg9eFngBhbmOlfbOQzxSI9IfAvmhRQreiEw3suP4A3F9UgFLAZ4omWrB9aBZFleMD/yWeg3wPm079xOw+ZbLlt1zBK2MQJNWvRMYTw9NVvQ6WLyycPZg5Q4QZeMB1VtLz2Up3wv8yNALpSklJFgzU3CcsI+IWJ0n2hltadLeQo93d3eMXh9j/NRHM59At713w1doE3IxB+Bvbyjj60hTWoMgUlVlz2Fih4ZokOdxs1TXtYUGrgjfCKxZddYVS5hOUJMuaV1BEuYA4lIQhHZJrB5XrSahiA3im5Vg5YFiDfoGMj9j+CzY+00fVgc4AHwymYSobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 18:05:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 18:05:03 +0000
Date:   Thu, 2 Jul 2020 15:04:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Introduce ODP prefetch counter
Message-ID: <20200702180457.GA742740@nvidia.com>
References: <20200621104147.53795-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200621104147.53795-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR01CA0019.prod.exchangelabs.com (2603:10b6:208:71::32)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR01CA0019.prod.exchangelabs.com (2603:10b6:208:71::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 18:05:02 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jr3Zx-0037EK-Ir; Thu, 02 Jul 2020 15:04:57 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5f36999-5a85-43c4-d356-08d81eb27167
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4356CDEF87DE430991A90E87C26D0@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4pntjVTpCfv1YQNxeBc62wG0AzKuyCTwKxlIkXwJPlmasahDAuirmXWOcOfLrkxkwBwqa9I6jKZ72c7iJ0YqjD7JhXdoPpjD79TEiIYkvQtARcEv2+T0Q5w+R+Nt+tigI5IPAhejchQAJoIcoTT+dcNDuziC87h/xQ4DfLVtf2fZmw++VgbFvbxa+806IxjhJEtsHO34Zlx9TnWHXrjlURSd1LYQ1sViRL5jAvAe3dbLAQNWuA5VyfD83PoshudWU8JCnLnj4XwonZHc1q1sE7rU4siby0mqsths4CoJqflYJ5Qed+3LweuJax5JKCEvMrb2BM9d3VzkKdf442S2IvgVhoJ8q4fLRnBpxuImfaVeaPmI/yyJvHYxyaXZvw3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(4744005)(2616005)(54906003)(316002)(186003)(6916009)(86362001)(26005)(66946007)(8676002)(83380400001)(5660300002)(4326008)(8936002)(478600001)(33656002)(66476007)(66556008)(426003)(2906002)(9746002)(36756003)(9786002)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: E6fBMcddbempC2VKKvvNnZMXZOQmnjOyz8yZF/ixIxEQynaFe74kthoUY9mwKZLgevBdyQ6xGiFWf/JoRliqe3kLIoT7FAk1P/WICZEcAQS5iIHhaF6wJ3hrm8nWm9zFSVXbhAOTSplJyb1Ri3Eln3Zwk8/zF4QzCNwkQ3tbKAYBF3L3o2/zUIYya/YrBMg0k3zEpws2iE5xalgWGWPDenT4sMmSHMwEEpNgktJj7uc96W68jRoidkH+Lc+YaUFrddm+RKhiUaiZbigoYfc7fDr0tlvwjf/gQca87aLf/ISx3jMLhFlekNnfHjcHauiQEv8SO9eKVYHo7dn1jjlmwTpjBXxjazW2gl/Zau59rWz674iKVn6VeI3AUgkyECGgDt32iauoekm9u2SVto52MveuXfRfusVfrr27aqCXP8AbcoN5jjcm9ny9N/hO9XJypLoEVuitxWhl9nAU3ZkznXvaEDg/+bOtx4A6hWCrpO9F21xDGW+Aes0LRt5PIsm4
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f36999-5a85-43c4-d356-08d81eb27167
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 18:05:02.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDPFJjjf5XKc8Bx41UT4GOMhIzOUypnG8euk7mQOjhR2IH2zCeHNynaqm11pfgsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593713013; bh=T6UVg36/FLzpnrGUWeP6EQw2f8PX07ws2gf52EeElHQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
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
        b=iuxrsPOzpZ1hAkMCthN7dl2+pX84IqiIw2cXEgUYHYpBxUvqR8avZSYcTlme7vbyU
         cbn96D2wHEsgdw505cCeASlxL6fs5A3u32NLMDNbdD6cHyv26d8ntYNXbobexTTR8T
         qs7g338arf9xpzovqpwG6kL8kzQYkrKUHpqKj3yXTsk3zhTaH0Dv0V2S/NoPsexxqd
         8BI1oZSAD9qaXIsaFDpzMOBY7aCMCEyyje5BrDVXbTR2tuNyp8KTrWHvGWkhbmeQgq
         Qxf/ocqCCxE3Uyrs1/W5J7mmyeJuzv0XL39zZBqsR5suVvtbq8T8YpmvHVoeEYqwaJ
         KJLH6P8hkoXww==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 01:41:47PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> For debugging purpose it will be easier to understand if prefetch
> works okay if it has its own counter. Introduce ODP prefetch counter
> and count per MR the total number of prefetched pages.
> 
> In addition remove comment which is not relevant anymore and anyway
> not in the correct place.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c      | 19 ++++++++++---------
>  drivers/infiniband/hw/mlx5/restrack.c |  3 +++
>  include/rdma/ib_verbs.h               |  1 +
>  3 files changed, 14 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
