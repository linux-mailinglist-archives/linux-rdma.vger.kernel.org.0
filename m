Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABDE1663A2
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 17:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBTQ7M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 11:59:12 -0500
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:8349
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728072AbgBTQ7M (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 11:59:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Keryq3Dxt0769UWIFMlicnxs7235TiAc5caVxuX+5lDqXVAsDoI6fJAK6BjNRBV0jTVw5t+h8aBuZKRU3lqIhhWR5PiH3jZ3AtAEIv7eC+FBnDYDQvh6ddOnRxxxyrRH7FxlY+YJbClxlRuRgmXyk5pWAACHadGij37MS8MBLdBkf4as764RQj44eEdXY3/J/U+SVZ04KBRokQ2ERJOa0IJaK7ROBQuPPlls3tqwNqpcoIz56OyVj51wXOIhIrnUCh3244RK0jaGeUx+5zuStdjcUEC5jieDirop8VwI0BixYeN99O/YKVUl8ZkZ24kYtV2RQtmfpXN07EP+8+7DYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmo2EzUxr2oxXd5KJcTarINv+9Rwq2XVUNnVR/JMjuc=;
 b=DAb7lEdYMSZgfOFWH1wUjNHbaTprY4KXKzXb/oo1fD8vjrgoyAFednJA+ZgIMCnjdzFd2bXryGMHI7Baoa3wNQmhn5GKMKBeWgTsrAJZcioXaoG95QnDGmRWK+LEbCZ4luIieSAK88SVB1GOhlTcnTmvNo92vcLpLFLYjVvyJKVbhYvTrlNb8SKbWSrSSRzs/txnYQLpocotMSVbn3zE8u0wAUngIaZX2J39tvoFeig7W6VYhV/fSpHHd9Kit+AQlaWh5ZbQPZZtMMf6faIYK0vmoZFqrGPRh+zq9IBkNjxHQ8yR2j1d42iNymDS/6JgEYoG5ddKffkFd8fuc3Izcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmo2EzUxr2oxXd5KJcTarINv+9Rwq2XVUNnVR/JMjuc=;
 b=olOiafJ0+EGdD7yRcgntZ0AOyhch7q7xBKjeCS2MPGqlNcd9w3xv1a+5GFwE3jdW8lcnDKlabk+aXNWJXOe7hQ4AH6oy8iqY7momrK+pdpwEQ7O7PgD47iIRsXFTKc66xBnSC6xDube3VPv4ffajknPqg7EOR0coFyTYchqL9IQ=
Received: from DB7PR05CA0018.eurprd05.prod.outlook.com (2603:10a6:10:36::31)
 by AM6PR05MB5538.eurprd05.prod.outlook.com (2603:10a6:20b:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Thu, 20 Feb
 2020 16:58:22 +0000
Received: from DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by DB7PR05CA0018.outlook.office365.com
 (2603:10a6:10:36::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Thu, 20 Feb 2020 16:58:22 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT038.mail.protection.outlook.com (10.152.21.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 16:58:22 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 20 Feb 2020 18:58:21
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 20 Feb 2020 18:58:21 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 20 Feb 2020 18:57:36
 +0200
Subject: Re: [PATCH v2 2/2] RDMA/rw: map P2P memory correctly for signature
 operations
To:     Logan Gunthorpe <logang@deltatee.com>, <jgg@mellanox.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <israelr@mellanox.com>
References: <20200220100819.41860-1-maxg@mellanox.com>
 <20200220100819.41860-2-maxg@mellanox.com>
 <9e68c521-f083-c713-c19a-c08a0227c95e@deltatee.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <c2e891f7-ded3-4c19-baf1-a441048f2542@mellanox.com>
Date:   Thu, 20 Feb 2020 18:57:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <9e68c521-f083-c713-c19a-c08a0227c95e@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(199004)(189003)(107886003)(70206006)(5660300002)(316002)(70586007)(53546011)(86362001)(16576012)(4326008)(336012)(2906002)(110136005)(36756003)(2616005)(31696002)(478600001)(8936002)(8676002)(186003)(81166006)(26005)(31686004)(81156014)(356004)(16526019)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5538;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f9c0ec5-3fa5-48f4-1c3b-08d7b6261810
X-MS-TrafficTypeDiagnostic: AM6PR05MB5538:
X-Microsoft-Antispam-PRVS: <AM6PR05MB55389EC74F573431AE8E0D0BB6130@AM6PR05MB5538.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 031996B7EF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GtCAjtj8CnO201JIYkYEWMOtaidgQbSwNIlUxpY3VfYR0MwN5F4l4ZNvfrpudydMLggOMGhD9v7/3iw7Ecq4GmAU1LhAq1o63XA1Gpax3e+6wm5CmKQ9IXEJfZQZUWGYYbuyGT3JmSZnVJaSh7uh+6/gRapqyCbwlG/IOce1O2gE3BiAYCcgjuVctd0L3E8mdaBJMgYBObzncmbkOBrvUfzEWJJYDMB2nLMw20gxf6Y8YRRX0LmsR3DkeSwPHcA6F0mu/GHp+vaXQlPi4euHKpurDtf3fSId/d/yNPCPdO21TMfPTaUbJZp9oCVcyX8HfmfA5lHCTwVZF88vT8EfPCfNaQ/IK4/c+xtHc/9apHUhQlTt6lR+BM8MOp3PniKsbfgOR5SfNe3fYZk0hH1aIHflI4hO2zwNyLKVGAWiYTcRW6J03cng/PCW+7OVtCSatAX2gGtNGEoMoZMDaxxaIuurZM8OWZJGFpEzZiaVR3Q3MaWFQ6+upu+uZ5nbFtFyOXjoTq6wpEsyovVEPMJTw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 16:58:22.2273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9c0ec5-3fa5-48f4-1c3b-08d7b6261810
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5538
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2/20/2020 6:51 PM, Logan Gunthorpe wrote:
>
> On 2020-02-20 3:08 a.m., Max Gurtovoy wrote:
>> Since RDMA rw API support operations with P2P memory sg list, make sure
>> to map/unmap the scatter list for signature operation correctly.
> Does anyone actually use P2P pages with rdma_rw_ctx_signature_init()?

We're adding support for NVMf/target in these days.

Nevertheless, the RW API defined as an API that might use P2P pages.

>
> Logan
>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>   drivers/infiniband/core/rw.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
>> index 69513b484507..6eba8453f206 100644
>> --- a/drivers/infiniband/core/rw.c
>> +++ b/drivers/infiniband/core/rw.c
>> @@ -392,13 +392,13 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
>>   		return -EINVAL;
>>   	}
>>   
>> -	ret = ib_dma_map_sg(dev, sg, sg_cnt, dir);
>> +	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
>>   	if (!ret)
>>   		return -ENOMEM;
>>   	sg_cnt = ret;
>>   
>>   	if (prot_sg_cnt) {
>> -		ret = ib_dma_map_sg(dev, prot_sg, prot_sg_cnt, dir);
>> +		ret = rdma_rw_map_sg(dev, prot_sg, prot_sg_cnt, dir);
>>   		if (!ret) {
>>   			ret = -ENOMEM;
>>   			goto out_unmap_sg;
>> @@ -467,9 +467,9 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
>>   	kfree(ctx->reg);
>>   out_unmap_prot_sg:
>>   	if (prot_sg_cnt)
>> -		ib_dma_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
>> +		rdma_rw_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
>>   out_unmap_sg:
>> -	ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
>> +	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL(rdma_rw_ctx_signature_init);
>> @@ -629,9 +629,9 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
>>   	ib_mr_pool_put(qp, &qp->sig_mrs, ctx->reg->mr);
>>   	kfree(ctx->reg);
>>   
>> -	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
>>   	if (prot_sg_cnt)
>> -		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
>> +		rdma_rw_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
>> +	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
>>   }
>>   EXPORT_SYMBOL(rdma_rw_ctx_destroy_signature);
>>   
>>
