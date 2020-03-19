Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89318AF61
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 10:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCSJQQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 05:16:16 -0400
Received: from mail-am6eur05on2045.outbound.protection.outlook.com ([40.107.22.45]:38526
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727461AbgCSJQP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 05:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF6AmU1+jd1IxOa/vE7wqXJDBiLGHiuJp2s67J9im8od1nC6GDpIhQWwdXCFozjS3Xeo+SOTDHdy97ZLUKcCP1faJghwoHoCdpKqm4yDzHvmHcA1Y9M6Bp9EatFoXcz+GX5HmJoNIntTUDbXRgD4QJSdJF/Ipr3JB1R9lJYVS3LadsA9ZNh9exz7sU6urJ5tmu2iX7+s73mIMpE3Y2pTiuG/JdINk2lf/+NogHHCbUvFStS1ggL9WCp7+H2TNUIP/cHTlGCPatBj1OXosW9y9jeJ9f4XQ7k+HrDLD66KjYwbilvxgpfszOkfPUJLWGl8ejJjqW/BPt/BppJw/a8LJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WFD5nF83fOUr4Mwsn6kyA0PKIVAxsLJoDIRsMSUNPM=;
 b=Oi2eMFgikrGtHMR/T0lEy1oWnTMevOI0oMQIwA90Pbdl7jdtxm95OHSnaKcNyuJdARLpNgd2vFESEHazyIhZ6VqIR+l2f7Cw1Z1Tz8+UUe4sDdtaA4c+WeBdp1SROZK1Z8NoJHSdkfHsTnT6Ein4DgzjuZVHw0v7otnU9UlOaKZqQN1KETgJXZLVShtlcSf/usFsT++VGdUK7IxBqE+LUQ1XhSFjUCCIeYoKn/yQG7lmH/cXWygiZj59InW2Wwl2UNfZ22ZN2IFV3eA/3DBdG+xbeD6uK+VcBU6J6oHMiROaLKkafInmcgp44pewHUnpkc6JPL9gRqUo/DI4N+2RgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WFD5nF83fOUr4Mwsn6kyA0PKIVAxsLJoDIRsMSUNPM=;
 b=b794IKbklMRxQSViqVYIbVTJstEBHHZkaztfUS+SosM2WuOyqSO8eLnjuKX5z2eKqCRQ2X3qey7LbT8uK6ii4EfaaKYWf7Oqib+NRmHHeNk4HoG4vZgjC+Z5DsKEiFm5PSDMdUCvmPbpYqX6qsduiG45O598eWnRaRv3GLC0u0o=
Received: from AM5PR0602CA0017.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::27) by DB6PR0501MB2615.eurprd05.prod.outlook.com
 (2603:10a6:4:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 19 Mar
 2020 09:16:12 +0000
Received: from AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:a3:cafe::4d) by AM5PR0602CA0017.outlook.office365.com
 (2603:10a6:203:a3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Thu, 19 Mar 2020 09:16:12 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT035.mail.protection.outlook.com (10.152.16.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Thu, 19 Mar 2020 09:16:12 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 19 Mar 2020 11:16:02
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 19 Mar 2020 11:16:02 +0200
Received: from [172.27.15.129] (172.27.15.129) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 19 Mar 2020 11:15:51
 +0200
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
To:     Bart Van Assche <bvanassche@acm.org>,
        <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <linux-rdma@vger.kernel.org>
CC:     <kbusch@kernel.org>, <leonro@mellanox.com>, <jgg@mellanox.com>,
        <dledford@redhat.com>, <idanb@mellanox.com>,
        <shlomin@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <rgirase@redhat.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
 <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <5623419a-39e6-6090-4ae2-d4725a8b9740@mellanox.com>
Date:   Thu, 19 Mar 2020 11:15:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.27.15.129]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(199004)(46966005)(36756003)(336012)(26005)(2616005)(47076004)(2906002)(4744005)(478600001)(5660300002)(186003)(16526019)(356004)(4326008)(53546011)(31686004)(316002)(70206006)(31696002)(8676002)(110136005)(70586007)(54906003)(81166006)(8936002)(86362001)(36906005)(16576012)(81156014)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2615;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 864026af-6d81-43ef-5b2d-08d7cbe62b22
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2615:
X-Microsoft-Antispam-PRVS: <DB6PR0501MB261561E290B404FCFDD36237B6F40@DB6PR0501MB2615.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0347410860
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vE4er8Wy7PtS+1CR6fFFQE3XpCUdkTobC2/d3CidxWHh2fRJdLCFLaAI4OqrKhu6qj6SS7UJI+75Ecprgeb2JzCrMK/RAzGiE/zTbmYGAAmncwvGka498x+cGP722sfy9czw/MjYyNXC71vD4JjGWcBdi3SViR/MCUcXcQw9gaz14C6IPg+BH8Cnt0mUmy7sjT3BqdhSfrC5dNW7uun5dde9daaiRd3jYkQtm8aQfoKee6SQDApGdIcKTmfV+FnOGDQ6FQiMWEFxKsoxw0LCLWqiOpaCYWQYmkS1KarycHM40W7zghOaEPmuOnuu7uwk/HrJqVH1eKrvB8e7vi7n/EhPyQ6Tt4kWLynTEOpH2Wue84ukIGmVZHkOvkJa4UwEQRZTq87BLMqIYki53L0sQYmr4Ez6ddDix5/vlcnsHg7LRqZ1VWBFG73tL361ggVolSZGexsVOD5y7ruaQUt34gbACtoY3BIZWmBxr1B7EnmShbyzaq7Xb7TD+7zVu1PZvJKEAQEDRjwJ7h/f0BWR+cED3hANiIRqVXAYvY4FhIgN/9KCd1bzVjxXBZ9wsZ+Q
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 09:16:12.0311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 864026af-6d81-43ef-5b2d-08d7cbe62b22
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2615
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/19/2020 6:09 AM, Bart Van Assche wrote:
> On 2020-03-18 08:02, Max Gurtovoy wrote:
>> In order to save resource allocation and utilize the completion
>                     ^^^^^^^^^^^^^^^^^^^
>                     resources?

thanks.


>
>> +static int nvmet_rdma_srq_size = 1024;
>> +module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
>> +MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 1024)");
> Is an SRQ overflow fatal? Isn't the SRQ size something that should be
> computed by the nvmet_rdma driver such that SRQ overflows do not happen?

I've added the following code to make sure that the size is not greater 
than device capability:

+ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
+                            nvmet_rdma_srq_size);

In case the SRQ doesn't have enough credits it will send rnr to the 
initiator and the initiator will retry later on.

We might need to change the min_rnr_timer during the connection 
establishment, but still didn't see the need for it.

-Max

>
> Thanks,
>
> Bart.
