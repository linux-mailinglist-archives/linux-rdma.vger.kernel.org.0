Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7615E18CEB5
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 14:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCTNWD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 09:22:03 -0400
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:48608
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbgCTNWD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Mar 2020 09:22:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bifQwc6esdCWrE7OqDqKrJ8wMh9WytpATDR75K5lyiL6Rc5tOAhRCoJHze5d01Qil/MRFfxQB/47WfKDu/0KVngmjc9HUkqC8TY91jNScOWb6EdeT6Ea4fOUfu2ATeW02wpBYPsquY4EX5wPN2nvRelOiPD98ZUcXYe1xwnfNzuMA1H0JroNAy2wezXWm+LeG+7ZZd9QsfzewGSoYQEC0ob4oUy2D4gJPFAkbQURFP1hSzokpsSRmHFvzJ2j95qSH3wVFbsSrvPH+45JM7klrbTg+y+RTcmaxIkx0ncdlNBalbkY5Z0FSrZF6ulQ/Eh1z3ItMzJ4VUrBzvtcC80vvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0K72E0GV6h1qM3Ob6LPzD9pP+ikH1EdXwO4qTOeWoY=;
 b=ej2oojIMB52iYQn32lYAuSAts+QeyXtwx8b0AUp0AWkFKKx8UpvXHrYKgqj5yHYn+JZBIHTGTcehbqy8bTlfIki3pf2aoiZwW9XOatCemRVUv6eY9YIO2t3spVfc2vTSW6HIflMGvekbGn80Cn6VBLorAfTKBqA4Kg5GQVw0LUtz27yO2Gm1tkxMTvDES+BDSKncXwk5W2Z0lXUUM5qP2Va+63o/H53jpJcu7k9MzZdXDcpuBpvqUe2OuXgyQpnrez2h845DRMz1lN+nkud105EwPrYdHKq8pYkvmub6xhybd6R06Y34ROsVra4Ysx7ub6PFHxxqnrzprVMNNvV61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0K72E0GV6h1qM3Ob6LPzD9pP+ikH1EdXwO4qTOeWoY=;
 b=Sb/HU79KzwtU+bUWEkBDoMnJsWwslIlYUp8x8D+7D04a4VQPfTaJk55QUvQtRhPHUQq2O5PZkyz1rBxKhqPVxN+JpL1Hfjvgsh1cyrFGbeE2cWH2oldbzyzeuOzxkd186/9sVu5lmCTkvfk46YBoDup4RRIvadeXsI8otNOoy5I=
Received: from AM6PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:20b:92::37)
 by AM0PR0502MB3745.eurprd05.prod.outlook.com (2603:10a6:208:24::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 13:21:59 +0000
Received: from VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:92:cafe::1d) by AM6PR04CA0024.outlook.office365.com
 (2603:10a6:20b:92::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Fri, 20 Mar 2020 13:21:59 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT039.mail.protection.outlook.com (10.152.19.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Fri, 20 Mar 2020 13:21:58 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 20 Mar 2020 15:21:57
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 20 Mar 2020 15:21:57 +0200
Received: from [172.27.0.96] (172.27.0.96) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 20 Mar 2020 15:21:53
 +0200
Subject: Re: [PATCH v2 1/5] IB/core: add a simple SRQ pool per PD
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>, <loberman@redhat.com>, <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>
CC:     <kbusch@kernel.org>, <leonro@mellanox.com>, <jgg@mellanox.com>,
        <dledford@redhat.com>, <idanb@mellanox.com>,
        <shlomin@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <rgirase@redhat.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-2-maxg@mellanox.com>
 <b37caf65-a084-6ed2-2ee9-8a51a6e9b79d@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <bfdb2827-84c6-3053-6191-76e1fff84445@mellanox.com>
Date:   Fri, 20 Mar 2020 15:21:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b37caf65-a084-6ed2-2ee9-8a51a6e9b79d@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.27.0.96]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(199004)(46966005)(4326008)(36756003)(2616005)(47076004)(26005)(186003)(356004)(2906002)(5660300002)(498600001)(6666004)(16526019)(81156014)(31686004)(336012)(53546011)(8676002)(16576012)(110136005)(31696002)(36906005)(54906003)(86362001)(81166006)(70586007)(8936002)(70206006)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0502MB3745;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38235008-f945-45ce-e9ee-08d7ccd1ab0b
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3745:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB37457BB6C564F7C469FB1128B6F50@AM0PR0502MB3745.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03484C0ABF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isA+lKQw54aP+gQHIKTupQJNJaV1k91QBvl4iL8dG8IJYu4IEb8J6JoPpiI/4nzaWNXm0h1CK7KIi0UA2e/m/n1kMZlJSe+TggnqpbzOGB8kZeACkkIIqrzGqwljJa5lxDk2BP/h4SkltVgjskUDpkM+dI0kYg4jadY0rATmbEJo8+4UDfszmzBBj0JT3g2SkCNaHSnF2DrhVFthWNNsygARYGyVPpc/10fo+W2COObR72ysYiVdEwtV7krOZYnHfZ5xIHkya2snyudLdmsAiSLMqG0oNRQPEb5l6JQQ9sCRu480hvCgT7VSH/0zCYhiyuTE4+Iqyftfw3AToN5UooVxVJ6k0ldBeQzVUV7RZAVN3DmWu+/11NaFxZN12+4e0yqHYul6Wn0dksSoBHRxVfz3JT+UWv6G41bxIOdyTaX43aKV9YQgtYVCxYaqhIoBGlBP1sAz1t9CznKQK929xaqGT1Q7AiNeHctTgPym0PG0bWys0aKbH9HVM223nfJ7GnRK/Ir38dkHbgmoy5b3BV3b11zGHJE2WbBLeA/gVJ8=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 13:21:58.4369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38235008-f945-45ce-e9ee-08d7ccd1ab0b
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3745
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/20/2020 7:59 AM, Sagi Grimberg wrote:
>
>> ULP's can use this API to create/destroy SRQ's with the same
>> characteristics for implementing a logic that aimed to save resources
>> without significant performance penalty (e.g. create SRQ per completion
>> vector and use shared receive buffers for multiple controllers of the
>> ULP).
>
> There is almost no logic in here. Is there a real point in having
> in the way it is?
>
> What is the point of creating a pool, getting all the srqs, manage
> in the ulp (in an array), putting back, and destroy as a pool?
>
> I'd expect to have a refcount for each qp referencing a srq from the
> pool, and also that the pool would manage the srqs themselves.
>
> srqs are long lived resources, unlike mrs which are taken and restored
> to the pool on a per I/O basis...
>
> Its not that I hate it or something, just not clear to me how useful it
> is to have in this form...

Sagi,

It's surprising to me since in my V1 two years ago I sent a pure 
nvmet/RDMA implementation and no srq_pool in there.

And you have asked to add a srq_pool in the review.

Also I was asked to add another implementation with this API for another 
ULP back then and I didn't have the capacity for it.

Now I've done both NVMf and SRP target  implementation with the SRQ pool.

I'm ok with removing/upgrading the pool in a way everyone would be happy.

I'm ok with removing the SRP implementation if it's not needed.

I just want to add this feature to NVMf target 5.7 release.

So please decide on the implementation and I'll send the patches.

-Max.

