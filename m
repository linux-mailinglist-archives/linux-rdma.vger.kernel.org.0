Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56920226F27
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 21:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgGTTl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 15:41:28 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:20312 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGTTl2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jul 2020 15:41:28 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f15f3660000>; Tue, 21 Jul 2020 03:41:26 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 12:41:26 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 20 Jul 2020 12:41:26 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 19:41:22 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 20 Jul 2020 19:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpCRR255vpWnGXtwbqc9iE+rHFC0EIvGNKz6OeLyVPH5vmQifddmG8ZqBmrla6FLi+Z/uF/AttY4PzdjZwOQUZei0S5ZXqsJKXct3wbKx6bXq+H1XhB2I4lVST4c1sKR8ZInN3HvzlWnA54nOiuhOZIpBtPK+5Uj4ipiWx8B/RN84KARD2Lr7KBGBGcmpjhRqVblN6AyOuhpcglbnUXNoxaLNzVzecfleyGYMvdoV2n+5vrt16jdktxA0PrhMt1V1fSG8y2Ex4JefomzvfVy6QRoOgKWGKwVm+l2V1UI7XaKELcUv9t8U5PiKGU7SuUPMor4gIkFL+wycv9uE0UMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ld1zRv+DPxt69UyJ7Gf2qS9+DrSil/zJdIC+CZGijw=;
 b=OzGjnLfaw7p59XdKauEbPnRYGjT73rDdZie8WqYs/oBgm9MlCoYEkat3jUsakf1U4HBdv+Sj+SZjWZF0t60Lt6yAXhTm9mw8alulH8E4W/3Ay2ajwmgnba2G18pp+eGcz4VqPsnyJDOHjsMcLSQfNmRkCZ03urn/aI8DtXHidkez83hpkbjy2IT1zIQ9mg3xO6VPVJraQ9cQfnFduT5jwB8ylCG3PE3O+CrtuupDRcxybcrZiyDCOMnQOzk5V/Q8G54rMjb63yNAJe/TS5k6y74mqUJtUfznMS2fnx5RC/3EsYJyW/aFbmLIrpXLAKRbqU3wYUOIBPELS6bd4QS9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Mon, 20 Jul 2020 19:41:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 19:41:19 +0000
Date:   Mon, 20 Jul 2020 16:41:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <leon@kernel.org>
Subject: Re: [PATCH V2 for-next 0/6] Broadcom's driver update
Message-ID: <20200720194118.GA3043109@nvidia.com>
References: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
X-ClientProxiedBy: MN2PR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:208:23d::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR06CA0024.namprd06.prod.outlook.com (2603:10b6:208:23d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 19:41:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jxbf4-00ClkX-Em; Mon, 20 Jul 2020 16:41:18 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a10908b0-c0d2-486d-a9a2-08d82ce4e00f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-Microsoft-Antispam-PRVS: <DM5PR12MB154808971517FF7F8DFE8596C27B0@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0/HEEbYWO9/fV+i3jya4PuWa2/dNu4Iza4pPKa9cLsCHBLhMkyWASb5TgEfgNHREy/ypT7j3uZ1dSzh7M30uhpRXM3ZgCU+y8qZbwA8mDqG/UeHwK9NjFp9tu4vgwWvE+6dS+J3fUILKXyMYUCcrcQ/J+iVH3cW5Ap0gDh0FQZqOd0bj+EQN5tVXmtGDDxgLTULnFbCIp9B+sx90H9FrWwRh1zVj9uqeHWqyYrUaNFlA4+qgfofTvGFoS2Et/aLQ5yEexfDq+Cb2QZHd63JOL9OaokJwZfwEIqUKcJvpup1kZA5P+pBW/oTmrbvei0rUAs5s4mRXF/ZbG5npE9DioiI1lzfWlO2q4L/OtVe+iy+HAaOHBAyWDHXsRyNKHCOTAwAuUlApdIKE5mrLwRZWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(4326008)(83380400001)(36756003)(86362001)(1076003)(66556008)(66476007)(6916009)(2906002)(66946007)(33656002)(966005)(5660300002)(186003)(426003)(8676002)(8936002)(2616005)(316002)(15650500001)(9746002)(26005)(9786002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ElFpNGBfCjows7v/fOJKCxsMXMmvvCwqsSFvTJzlWpK5vqX2FaTps8xu1L5EhNhSlIWC1ZFhezikDZ2B3w34692cNfqCG0PElvTLZtrBXd9k2d+DToHA4erADeHYvSoLtDdNUqMRXiQu79ff94PmEfYriWnxapeMK0ss/hokhe+RLw43pFDB5sfxGi+JnHYHo8nt7BTn/tBWAeluKRSDI+fCHPOJvCGr8dTH5isTXDEHrHXAsAJ9rQcIR83fd67gtzo5OLigcJtkOovE8hquZ7dd3CIWryz2l9q0eV7VYfAAp1yRwHLToo3Q2neMozEKUZMSDS7Qi3kTcD5G7dMuKlqkKiPoCWjqO+qyUtSN80cw5Sjtq48Wcw31RdAAu9M/bgYCmxndb3WlPj/ljJKbo0JT/bX0T2IANasdbKQEmdEvCywgc6MAQMhZAHge8UGh/OyJ37OYmRl2eHbcG7ZY+ETMCJ9FtUtn/yB8i1qL/TY=
X-MS-Exchange-CrossTenant-Network-Message-Id: a10908b0-c0d2-486d-a9a2-08d82ce4e00f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 19:41:19.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4gl2sv8RwVkyqz0HmGEw0pIx+veAoIVobK3ShvBPV+r4aAAcHxiybquNCBUdONf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595274086; bh=9Ld1zRv+DPxt69UyJ7Gf2qS9+DrSil/zJdIC+CZGijw=;
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
        b=V2ge0s4uYOKtWthaQ3A9AukX/Qe9+9OT8gV+JxRD+S1eFUgMGZMc8sCAkGSt/hqCX
         XTRlv6VgFCYpCpnPvSp9c3184KiY8XocDBIVa3InwEJi+GuCtN0kB8lNEmeKYuy5Qk
         FO0Pxfqai+K0FPzEz4792DaQnWQfNOaarMQOz6lku8MGLGdGWiXbFoXIwSTqErN6Ky
         yRUeJLp+egjBlmBGxRxlC/ss7M0QhCA1LO7F0KNnrA+sqJS6Zhzr8gNpAXN/vzdYj8
         ArYrXqFb8lyjfdE9gG9Im6xghM506DxocfcY/N3hkMS1ap41vMIzZkp3/xct6dPqpP
         Rj/kfHMWGsTqg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 15, 2020 at 10:16:53AM -0400, Devesh Sharma wrote:
> This series is mainly focused on adding driver fast path
> changes to support variable sized wqe support. There are
> five patches in this series.
> 
> The first patch is taking care of passing wqe mode through
> driver load sequence. The second patch is moving cqe polling
> logic on shadow queue indicies. Patch 0003 0004 and 0005 deal
> with changing post-send/post-recv to accomodate changes.
> 
> The last patch 0006, adds a new co-maintainer's name.
> 
> link to v1 series:
> https://www.spinics.net/lists/linux-rdma/msg92678.html

Please use links to lore.kernel.org in future

> Changes V1 -> V2:
>     comment from Jason and Leon.
> 
> 
> Devesh Sharma (6):
>   RDMA/bnxt_re: introduce wqe mode to select execution path
>   RDMA/bnxt_re: introduce a function to allocate swq
>   RDMA/bnxt_re: Pull psn buffer dynamically based on prod
>   RDMA/bnxt_re: Add helper data structures
>   RDMA/bnxt_re: Change wr posting logic to accommodate variable wqes
>   RDMA/bnxt_re: Update maintainers for Broadcom rdma driver

Applied to for next, thanks

Jason
