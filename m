Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16E9165B4E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 11:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBTKSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 05:18:47 -0500
Received: from mail-vi1eur05on2046.outbound.protection.outlook.com ([40.107.21.46]:19232
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbgBTKSr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 05:18:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9y7dWCUMrF4KnFKb8QOTQ+uvNrhb8UbFzb28VOeFOlPfwl4USL0MCrVkWJwXhi4jmMJ0LSDXP5QW6u9Z9RDbCOzOGUUSkdKhYui0fU1mvx9kE3qie5YNHOa7aTK0etuLAknBcyn1MAt58b0ks/Rg2PCQ7RFv9rI9JXSA74Vwav0snIPVY0c/Q5bAJnjH9YvcC4QGNkSqFzXt4fWftqHYzXOy3LnpABoYgA+1YORX+lFoczW4pcYmytytHqGuAq6WWOeWUgxbZh271unL2xdIecvne8Dn9RBJNS0mx2z5pAZU/3UO7k70RpTSn2NhdJn/8Te9q4i6fV60Q799RPZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi3/S1PcAbi0ArwStahvp1murbhis1g8WQi8Gf/nMos=;
 b=PsUlxsKXSHO4rZnhAjJX0xjeNrJ5MgpMVCd1QLCalyOJZxJC71x651bJovrNrGKC/HZWiAhddXN1g/FC3nQ/iclWJzp17K+fGDACyjX0EKIzRRJrrdnxD59ZuCuMMX1QTyny9sd+ZwcJuCZ3VLFI+EdrZQ/OdNIekZ+o7V89EQALJ2bZEILAzIgYWdj5sSVInBK4zv1ut6IStgQpoqeCNlwX4gmutY7BtwvzUhBa6J+fs7zSba5GLZ1qlz/gtV6aMXoJyZ0ZMr8dnD0x9iC0ZYYg1ft+7s8FTtkYl1NclVyuH9Erph/IHG7BNR6qtGklha2UKk2lzFheIP1XHsLLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi3/S1PcAbi0ArwStahvp1murbhis1g8WQi8Gf/nMos=;
 b=E4oRrgAOd9CSrYu+uxjM1ENArLrR4ZNroE2ccop5eypWynHDCo/CvWpbp8zhAPuXeUNFOwabyj9tdxxopBMLmEhhYl3HV9zXtRzeVvVHKUWjGwRLYaSJqHqOou90jfnMZF3eLeT6MJhdH3DCXgu1ZROvvVs4D4AAUj0pXK1tcBY=
Received: from AM5PR0502CA0015.eurprd05.prod.outlook.com
 (2603:10a6:203:91::25) by AM6PR05MB4279.eurprd05.prod.outlook.com
 (2603:10a6:209:3f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 10:18:42 +0000
Received: from AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by AM5PR0502CA0015.outlook.office365.com
 (2603:10a6:203:91::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Thu, 20 Feb 2020 10:18:42 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT013.mail.protection.outlook.com (10.152.16.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 10:18:42 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 20 Feb 2020 12:18:40
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 20 Feb 2020 12:18:40 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 20 Feb 2020 12:18:40
 +0200
Subject: Re: [PATCH 1/1] RDMA/rw: map P2P memory correctly for signature
 operations
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20200219154142.9894-1-maxg@mellanox.com>
 <20200219164735.GK23930@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <69b9de57-19cd-222c-a32c-e95278581a4e@mellanox.com>
Date:   Thu, 20 Feb 2020 12:18:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200219164735.GK23930@mellanox.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(8676002)(81166006)(81156014)(4744005)(6666004)(8936002)(6862004)(356004)(4326008)(36756003)(2906002)(2616005)(86362001)(26005)(16526019)(5660300002)(336012)(6636002)(478600001)(70206006)(316002)(186003)(16576012)(54906003)(53546011)(70586007)(31686004)(31696002)(37006003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4279;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3222f247-807a-44d0-f4a0-08d7b5ee42be
X-MS-TrafficTypeDiagnostic: AM6PR05MB4279:
X-Microsoft-Antispam-PRVS: <AM6PR05MB42798B81D0A6F35D9BAF2C83B6130@AM6PR05MB4279.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 031996B7EF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5aSQAdSAuAyafqE17dnwTgCpCHq0B4T1Fp66YaWXbVEbslw+9ER/1wshs2pSVMedW/yQrrLU8X0xwy1Il9SunH1M4efts9HnY9MEFK5liK9vs/VEZ48axSeMu0I6013AyAEO9+bW0mM5OSm+CODxMEvuycBcMRuovwNPQTpCta/xj3gv1t/Le4qx/nUjC9xUvBOp0Vpatge1kFfkye5MtJzW/vtUeQJhyCW/5hWGNm61Zp3QLufhzcE+Gk6UzzMXJ6kTV1B75ImZpNbAlH+SAC9uCsnF6WcRh/+bj/Y6JLjILCJ0U9sRqQNPgNNxsNZ50MWVkHSe+KIfkuAucY8GIS+zpLODvPaM209ZmmaHivkxnhK8RoqivI5PH7X6jhy5892gfTnxV1WzdNE0rXu5Ltg94OadqJ0RCRYfSgGSovGYspV5wcCqvq09Rdbw+4jx7LAqIWgc9gyYPrj6didOvGrbMb4YgMnAvAJ0THTvxnmDi5o2OvEaVIm9WWHm4Kt5
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 10:18:42.1277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3222f247-807a-44d0-f4a0-08d7b5ee42be
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4279
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2/19/2020 6:47 PM, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2020 at 05:41:42PM +0200, Max Gurtovoy wrote:
>> Since RDMA rw API support operations with P2P memory sg list, make sure
>> to map/unmap the scatter list for signature operation correctly. while
>> we're here, fix an error flow that doesn't unmap the sg list according
>> to the memory type.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>>   drivers/infiniband/core/rw.c | 44 +++++++++++++++++++++++++++-----------------
>>   1 file changed, 27 insertions(+), 17 deletions(-)
> Can you split the bug fix out please?

sure,

just sent a v2.


>
> Jason
