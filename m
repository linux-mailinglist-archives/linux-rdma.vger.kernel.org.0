Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384FF3D7C40
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 19:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhG0RhM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 13:37:12 -0400
Received: from mail-bn1nam07on2074.outbound.protection.outlook.com ([40.107.212.74]:15430
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229537AbhG0RhM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 13:37:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE3IdtESKpLShOB8K6iKQaeazt/5nVndUR7u9bkvp7NRD23sb0qGwKqs2Z0yKWY0xqa/4+X33ZtYJX8iFWqnOn2MyIDBmU6sILodyKzd/d/ROSGUQbqeWKONjyUxN1pyM5se7LJHRURS0Y6cwkDuWaTYeDBZ8xuYcpZE61XZ49dC01DK9F8wMAcScTXt9yQki08fFeElHnuYHHM26/uaPtczMVyz2GEK2OGGYlwG0meLzZfOhVRBIJyOKyASVQWemt9uOU1f3aoSKLJMaU1bCKJJ8Wynmfh9/7RcS9RM1IjRai8bNg2+KrHJB0gFBDrYR0tCPa8g5Ngn8owFIFi6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdGLgAeONXlIFnIK59l0WgJVj+4qhKRNilX6v+ujpTA=;
 b=QKSYp69t5itW4LukAMBW6ajjR+dKthubVLHilSmq9MCEe7mrigCCsRE7wwUlPtdjN0P3Nb+3js4pXRteeps3ByMMZ+Sa1Hn0Z+UAA5RRwGo9BaPETpmox8rIUpOPIjWAMCCIRbfDRzNCIfDtIIXgNF8q56On6veo9AWt7DodIL4OiliDrywDWPqcmXQg7G64FJ3t2AJRPaUPpvdyhTmMD7jN34v04ukH7NtjNsm+bOeWprUF3N+VttmGCh+kGJvEV0gp17iGUEWCGbuM6RJsePeXYpAxPvXuRbHuM/uO9vKsf65C7zsYCT7pnSgJNfgsZl4okhWEMJMnkFdRgwDdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdGLgAeONXlIFnIK59l0WgJVj+4qhKRNilX6v+ujpTA=;
 b=K80YSsGodC96XNzuf3ayZfManJR1bNadxzCUzHmq6dmGfCy0pVokvihYyrAlVQmiSqGkBKkqAthVzk1WM+AoaZ2qsH4I8HWjkMjUs2aaAq14vdTxgpxmURA9PkWQkdt3r90tJuHKGCPzTLJsYuIvN4yT4LMMC5yKCd9SRb2udvFq4z0Ze4prBt9cB3vYoZkWqwsJA/iO83XnoMbDd6qbT45jqk450BUbEQayRxsAmEUT2WqS7/vFMimO02hu8UHwlg22kyRmVlYnp7Km8xVN8xVXTDg5sSgtsdM6a/DCKpW2ySuXF/rI6cQ+0szYLmxL/ouMTbOGSTpkv1QYnQz9vQ==
Authentication-Results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Tue, 27 Jul
 2021 17:37:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 17:37:11 +0000
Date:   Tue, 27 Jul 2021 14:37:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chesnokov Gleb <Chesnokov.G@raidix.com>,
        "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Message-ID: <20210727173709.GH1721383@nvidia.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
 <0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
 <20210722142346.GL1117491@nvidia.com>
 <d7cba69f-42f1-c86e-8c01-9ddba87332e8@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7cba69f-42f1-c86e-8c01-9ddba87332e8@grimberg.me>
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:23a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Tue, 27 Jul 2021 17:37:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m8R0v-00962h-VY; Tue, 27 Jul 2021 14:37:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b714a6e-d3f0-4f50-41d2-08d9512529e3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111D520E63A4C402F423310C2E99@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbZ4HJl6cYbZDIPOnLBjonDNQdXTMTXTkGV8QvelQihVEPvq0gv4rhGt8jEqTRf1ayFCqBtzcQPNVo0Xk7QOD6A2TnlibFMfzCOWbjjngbiNQBgDZLYlypJEmpLHxtkWXLFNuws/DFuG7A3JGCEw1Ut1b9oN+tkjLk4K+VyZMR0W63SkTCHFCyi8HhJQL0dfvHlSkbrbXsW+Xa2xTfDLfnEwPqwmYCNRDzF7HjfdFDbpLfO5b3D33Hac5p7S5fqfjaxA9yeWgDDbInXZPr+R9bKpcbjWQdz8SlPFDB632j8GyC4CeuDVcJE10dkhuqGEga32RYakLul0IjJwYMv5Q7lsktNOYFi7PIwHG+BdHCX+FYi4W8+dkfHTasa65iUiP1ztfdzZtn6JOrx3Tvn+Z8mQCtmCyesmmgg68v/Rg1XyAOHmPv/plOUR+jBrkDJ+Cr3A8E+K1WqXlhc2QpnR5X6Tu2ObAb1b+JEW9/yvapm0PWffkadjHsGYWrGC1sHNV8g6EP9PFiRHXimDPJdKxvx7oOnR3mpz8Q2OPZG3Qskj3M9RP3lUlH7IhZGTWFTbC+gK8kwdwXK5PqqaRzaQKnTe7DNXV86Z52m1o4KxF8T6GT9UCOKj/LqPzdliyOk72eLPStQ4TIkwdp4gD3KZyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(2616005)(38100700002)(66556008)(36756003)(1076003)(2906002)(5660300002)(426003)(9746002)(508600001)(6916009)(26005)(186003)(9786002)(8936002)(8676002)(54906003)(83380400001)(33656002)(66946007)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eA/0oiHabnbW5c+NQ1Tgz98jgeRSmDjGpgg68/PjOf72RXhgZy+NnYdkzKXI?=
 =?us-ascii?Q?IMGnotsPcgx/WLTqpBiylHW/vfw19Cf21IWvwxs/LY6C6ZQEzK68OCujmYr4?=
 =?us-ascii?Q?XHFKN5Z877ZbvfqXGjrVishmAuTDg0w2UpgUUIJ+0natpSSZyiHAxJn6asEe?=
 =?us-ascii?Q?peZ07R+t5K0dch68lwj3IyWIRr/mcyMbSNeoLn5Busu/IdYBmEjimV/U3J8o?=
 =?us-ascii?Q?VFVSQ6eQCQ/WxXGkyWEkI7jdxc9H85RZcfYLajP09z1b5hOdSE/T3xfODcId?=
 =?us-ascii?Q?WJtUmaE7Z0brsMOMRsvE4o4zmWV7WfO3kqw6XrlLyWtsVwaZfjZLuXl2x/QJ?=
 =?us-ascii?Q?ctgWTlNye2LlWw08QyAS1Usrnfb2N4ZgTFAUBwkwcVt5aseHrLgCOJkuV5eP?=
 =?us-ascii?Q?1g4L6w57T6fMZQ/bYS+lS1tDd5qepWZ23rR3hlZXvdfnLyCmLoRX4+AtwInb?=
 =?us-ascii?Q?pNUFd7LEdojR1H+d4gXtoAMS9pKXTt/NtcAFO5cLylPeVUOX7opWHwHFrsR6?=
 =?us-ascii?Q?zXoDbW+J5jMm4A+V6f4eBMTRKDdjOTmWbpR+pPhG71IcN+ekbJZNLNlfaK02?=
 =?us-ascii?Q?f1nhZSyV0etTAyNSm9rzBzrL6ChOgv0mNPkBbJ9m+yjFZxia3pjCRnHqcTa6?=
 =?us-ascii?Q?oxKH/6fTFh6dJdnoSaz9JkHCarzOFZHiiZ749BAY49xgjL0jZjLSwzo0YPpj?=
 =?us-ascii?Q?Q0WVTCwl2DTowOsXYiYiT/ztJQj3tGEcRMMHxRM+1rqg4flDw41GcASKjRxQ?=
 =?us-ascii?Q?Dm5rqx4dJrgvmNxwPN6rQUzN/C+RxSEtLA0OoJzZSDiy3pckZCv+8cf4Kx6G?=
 =?us-ascii?Q?CvfJ5XN94KyRYFxrWM/Iq5G0nl9n70h8tGf0EBGkI1caoNouESebfelHRHbr?=
 =?us-ascii?Q?J5mD5xccy+6nrqbeHYO15JUigW6yeL48IaN/gk+bpxqz9E4R5hgjnMZJSJru?=
 =?us-ascii?Q?8CJwurBs2OQl/O+VajAZnP/SCwWAVuK0kg+aYZrS7/ykK5zGdADyiNHNrUkG?=
 =?us-ascii?Q?R9OIuw/bYvwjIcFnuI9tgzMGdPyJn75WiG3adF25UtY9t7rkgwQOnAyddL0O?=
 =?us-ascii?Q?Kc03VwmGNeBJu8sOrJI5UgLbsLtcpfxseWEtLzyffOqMt8fdoDXGvnhbzjJ3?=
 =?us-ascii?Q?V/EE6lWTOkd3Ew68rUgzEAHwe/sPOgGWSLS4lpKX2wMrVPvtxmzPLLws+RMM?=
 =?us-ascii?Q?kjxmc2J7RM0EI25qFfWZLcvuHPdRBCD9fs9kFBz8KtU7bXfWJ2H78KTdpHVR?=
 =?us-ascii?Q?MtgcanvTVPk5aBulHxHNZ4BWb25PJDhpj8UCR5HhCtB9aNDyquaJzMPGVaRt?=
 =?us-ascii?Q?mcnHX56NNN8ZSthVU6ZA+0oO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b714a6e-d3f0-4f50-41d2-08d9512529e3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 17:37:10.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lwx9gAAK2yTc7/w7t5LbpOndCgnzab/ktWGhfbLY4SZP2al6/LCnfu+DHTUy7v1p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 12:54:26PM -0700, Sagi Grimberg wrote:
> 
> > > > > What is this trying to do anyhow? If the addr has truely changed why
> > > > > does the bind fail?
> > > > 
> > > > When the active physical link member of bonding interface in active-standby
> > > > mode gets faulty, the standby link will represent the assigned addresses on
> > > > behalf of the active link.
> > > > Therefore, RDMA communication manager will notify iSER target with
> > > > RDMA_CM_EVENT_ADDR_CHANGE.
> > > 
> > > Ah, here is my recollection...
> > > 
> > > However I think that if we move that into a work, we should do it
> > > periodically until we succeed or until the endpoint is torn down so
> > > we can handle address removed and restore use-cases.
> > 
> > That soudns better, but still I would say this shouldn't even happen
> > in the first place, check the address and don't initiate rebinding if
> > it hasn't changed.
> 
> But don't you need to setup a new cm_id for the this notification? It
> will remain active?

AFAIK the existing listening ID remains, the notification is
informative, it doesn't indicate any CM state has changed.
 
> Also it's a bit cumbersome to match addresses in some cases like multi
> address interfaces. Almost seems easier to setup a new one...

How so? There is only one address passed to bind. If you create
multiple CM ids to cover all addresses then you need to run a set
algorithm to figure out what cm_ids to destroy and which to
create.

Jason
