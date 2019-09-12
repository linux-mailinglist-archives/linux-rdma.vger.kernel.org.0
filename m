Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2869B15C6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfILVOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 17:14:21 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:26752
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbfILVOV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 17:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUnVO2p93N8K7pPCl55hh5IWX0C61WbdKUpB7wKuu3ea4ricaenX4cpg6xN3olzEQiK0AhZMGo5TXZvp/nALMhbSBuoxbjHEH/If/SB3Ut1HWBiGbCfKnykh9GCfRLoDV0a24AGTxIT5eBhy67Oy7f6IbQp2sVFcOuacJqCs7eeFwYN4gBgLUII+BFVPyWiQNsyVzQREkBZgoaKHLy7KzzPK+XYiXGDDoKagVrqvZIN3dJBT8CvdNWZMN/buH5xblodUPEMlChf5G91kYf9OY/zJC6v82dvuTp6TWhgk9yD+EHYvP0tbpsSMCYIToIUsPY/lfWliTkFCdMNfw3jGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4kq8VJg+wBO0Jk5rTYeibcdY5mH1SSOv6sQsD3dBeg=;
 b=Ty1fItb5PjIWfEvvDk6GOPgaPkpraAqgXvtxKHMG+wXOMegisFprrfGaqvJVbWKhCigqUr90FXEXdvo0FNw48F5z+uZwkGKjVP2HGN8xnWIwjUIpUuTdRbXv81MfxB41hp0QC7DkEbRHbczt1Z5+bTvDGn8JkeH7ZZAUyjOASlLSea3bI+Fw9kfiQ0y2cRkWD3f/Wc01PIKdXiJ4Lwcmt1vhzIFv4nRjx6uZmEdhlHqDLA0Evn8omgBHiiQwWhzs/eX4ab1jJz8CC+3Cs0dfmtah8rHilpYMNYA0W8jtqnGnhEndfIaaeCmUg1QMjcyojjse9rKumKxR5HxZ0JI//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=grimberg.me smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4kq8VJg+wBO0Jk5rTYeibcdY5mH1SSOv6sQsD3dBeg=;
 b=fYapCMI3CnpoJQXpXSTJdgcUHg1bEQmcG1YmpcDDBBfutAsoL3KRRl5o8i2ZiSNh8Wtsurbsat8CUnd71Efc91YVlsezQH3P10Z05whIddqrj++57jOYJBTPIr2Ugd37/OHDqSadp9IKxV6HpJA8pmOLBVf3kuLCNvbTwaSY3Ec=
Received: from AM5PR0502CA0017.eurprd05.prod.outlook.com
 (2603:10a6:203:91::27) by AM6PR05MB5302.eurprd05.prod.outlook.com
 (2603:10a6:20b:69::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.13; Thu, 12 Sep
 2019 21:14:17 +0000
Received: from VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by AM5PR0502CA0017.outlook.office365.com
 (2603:10a6:203:91::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.13 via Frontend
 Transport; Thu, 12 Sep 2019 21:14:17 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT031.mail.protection.outlook.com (10.152.18.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2263.14 via Frontend Transport; Thu, 12 Sep 2019 21:14:16 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 13 Sep 2019 00:14:15
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 13 Sep 2019 00:14:15 +0300
Received: from [172.16.0.57] (172.16.0.57) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 13 Sep 2019 00:14:14
 +0300
Subject: Re: [PATCH v1] IB/iser: Support up to 16MB data transfer in a single
 command
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sergey Gorenko <sergeygo@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
References: <20190912103534.18210-1-sergeygo@mellanox.com>
 <20190912151931.GA15637@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <b49453d9-d419-f804-35a9-757a9b8206b9@mellanox.com>
Date:   Fri, 13 Sep 2019 00:14:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912151931.GA15637@mellanox.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.57]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(4326008)(58126008)(5660300002)(316002)(50466002)(36756003)(478600001)(16576012)(3846002)(7736002)(36906005)(86362001)(6116002)(6246003)(2906002)(6636002)(76176011)(305945005)(53936002)(31696002)(31686004)(14444005)(81156014)(70586007)(336012)(53546011)(2616005)(70206006)(81166006)(54906003)(446003)(230700001)(23676004)(2486003)(229853002)(110136005)(26005)(47776003)(65956001)(476003)(4744005)(8936002)(106002)(65806001)(356004)(8676002)(126002)(486006)(16526019)(186003)(11346002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5302;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6224e0f4-5e95-49c5-f237-08d737c62b62
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB5302;
X-MS-TrafficTypeDiagnostic: AM6PR05MB5302:
X-Microsoft-Antispam-PRVS: <AM6PR05MB5302FB24CE3D9ED0026BD15DB6B00@AM6PR05MB5302.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-Forefront-PRVS: 01583E185C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qAjB4KT9TlwsydZXANVARwA2qzoO8kb7OtKfEdWN6FjMhVYbXbAXDLkLNaaOYzLBYDrVPQtLo8Kkfe/3v8AGQYTQrMcEFR6bQlamK5abz8tW1N55Yy3/5KrciPsveH57PYv5ys4UGR40pxljLQ1f6hJe07qFgw4CjmxAT0EiO1DXP2IHiVPgvseckTlqr9hU6TFKlb33KHkhrptcWxgC76z4NCdM5maWnoB73MGoUGZpdwVRQa3TXLAzhTwQ6v+gBjBDHkNNq+XkTTxwPUwDUElrzYElzMv3mjMA8LvbsE7NBwXuV9SQ1vpEVJm6UtLytlQs/ESQ8YER4u3YKfnGyG4m0c//TZ8Q62nW9nkP96IkABnrky4SP/yrI/ocNaAxIdve86918wCCXgSX3McneygaT8a/4hWvqYx3uYpcYbw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2019 21:14:16.5370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6224e0f4-5e95-49c5-f237-08d737c62b62
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5302
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/12/2019 6:19 PM, Jason Gunthorpe wrote:
> On Thu, Sep 12, 2019 at 10:35:34AM +0000, Sergey Gorenko wrote:
>> Maximum supported IO size is 8MB for the iSER driver. The
>> current value is limited by the ISCSI_ISER_MAX_SG_TABLESIZE
>> macro. But the driver is able to handle 16MB IOs without any
>> significant changes. Increasing this limit can be useful for
>> the storage arrays which are fine tuned for IOs larger than
>> 8 MB.
>>
>> This commit allows to configure maximum IO size up to 16MB
>> using the max_sectors module parameter.
>>
>> Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
>> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
>> Acked-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Changes from v0:
>> - Change 512 to SECTOR_SIZE (suggested by Sagi)

is this always true ? 512 == SECTOR_SIZE ?


>>
>>   drivers/infiniband/ulp/iser/iscsi_iser.h | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
> Applied to for-next with Sagi's ack
>
> Thanks,
> Jason
