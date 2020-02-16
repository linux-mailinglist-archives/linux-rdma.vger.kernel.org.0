Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C43041603DD
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2020 12:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBPLov (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Feb 2020 06:44:51 -0500
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:33792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728011AbgBPLov (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 16 Feb 2020 06:44:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLyctoE343qYAMBuVnZRLHjEC0AD+F0e253Peyc5P9HRV9lOalbxVu/LaKOiGhyiSUs8vEG/ICFKJ1YZzIgITODcLK84mlhMDcWn871+05/s7Jn5fNuuDDOs+oILH5AaXCF7MsErDBIS1GA/V6ZKfnVC9qdXpv+DoIkmZ4iWJeQ7ZIL+F2A2dQxqqbfZDzKltMze1Ds1s1CfAsa169cRN7mxKzQjVFGA1udkRS5RlTeen97R7NYtXjxynsVj0QY6YE15y30u6FRHR9YCcXAXt/OBYK4BlZ8MPlP1oYRYXX8snFaO7247LWBZCeth9Q4czinad4/tnWh8ZKceOUCuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyiFr6O06ykUhDsuGgmrfHd791/fDIiRwe4eX/exVVM=;
 b=VAsCsxmmW/RHOnz1yLn3w/YR3Yny868TmwFRUN0FQrClYsg01u3Ww7xKeHWZ9yIsntaVj3gdVrJVZ0Zhc3FSa5focOZCcPKPCpeoCeWMNjuxB+PyGEfthSSnAICwQ+8XxeUAXZ3VqFRK59KcvSgkrIO61wW8RGdv7PNFayJP2ACWfSAx5ovTouSM+uOqCfbN1KlPLrH45pfK0LeYFkg/vWppvCsaRcJ9dZHC8FUVgh3AJxd6M6TDAdwI8D4rBNYNEAG95y+FnD0MBoWJguALCKV9QNbqkXZDpJPgJX379AZ3hz/cPtLO755k4uACRMnSyQ9MEreYTu4/jHsdgv7QwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyiFr6O06ykUhDsuGgmrfHd791/fDIiRwe4eX/exVVM=;
 b=K/8EseFDLK1N3eNw5EmRXuPnIZiKGhlnWjWHpyGhW2204goK50OlnDiBK+MOhw2r0ksyP/UG1LRBKSgnlBJzYMTL3RUgDoPFIG2HhA3nAT5NxzLicCteTBHAgwNEM4JznNZwI5NMTJc2d71rfmNEOJL0x3Accem7qgnfMzN+LjY=
Received: from AM0PR05CA0095.eurprd05.prod.outlook.com (2603:10a6:208:136::35)
 by VI1PR0501MB2334.eurprd05.prod.outlook.com (2603:10a6:800:24::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Sun, 16 Feb
 2020 11:44:48 +0000
Received: from AM5EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by AM0PR05CA0095.outlook.office365.com
 (2603:10a6:208:136::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend
 Transport; Sun, 16 Feb 2020 11:44:48 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT009.mail.protection.outlook.com (10.152.16.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2665.18 via Frontend Transport; Sun, 16 Feb 2020 11:44:47 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 16 Feb 2020 13:44:46
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 16 Feb 2020 13:44:46 +0200
Received: from [172.27.0.126] (172.27.0.126) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 16 Feb 2020 13:44:46
 +0200
Subject: Re: [PATCH] RDMA/core: Get rid of ib_create_qp_user
To:     Jason Gunthorpe <jgg@mellanox.com>, <linux-rdma@vger.kernel.org>
References: <20200213191911.GA9898@ziepe.ca>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <acbaf760-a3fe-f3c6-4b0b-e3e9a48cc876@mellanox.com>
Date:   Sun, 16 Feb 2020 13:44:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200213191911.GA9898@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.0.126]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(31696002)(36756003)(478600001)(2906002)(4744005)(86362001)(70206006)(356004)(110136005)(8676002)(8936002)(16526019)(31686004)(316002)(70586007)(336012)(81166006)(186003)(81156014)(16576012)(2616005)(36906005)(53546011)(5660300002)(26005)(6666004)(26583001)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2334;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0998628-78e0-473f-db69-08d7b2d5a015
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2334:
X-Microsoft-Antispam-PRVS: <VI1PR0501MB23344EEB3CA5D3483AE0505FB6170@VI1PR0501MB2334.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 03152A99FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7INdkNRmGFIx9F7qb8rkz5NsBfkShzK23SEPy70czEMrciJbHwWq16V31L6m1b/wBmoLoc4bPw3K1oVMp1103/TYozjJyulNEMUADAOD/tBJakyXzLDb9cFMnHTt5W2CF1063DZGhUgBRSh6whX0b53Kc3pWel8hnTMtBlaTr0qGM1yEH856KD6HAsFFgQ7EjTflfvuLQsPnfieovhRDdP37MItr3Sa3dLNxXQoVUiNyuzcrb7Lj2wYbS804eeoj/IXfS/74k843ReScQ/iI9AoosmKnn80gTJDKlEobNSNph9XhQ91IHg/BCKiNqydG/v0hC61xuiQnjzI/CIQ67GgPGr0lzmZnwVZIAhXchox82DsxPuRZvdtd3DDGxD8XuczWKkCAXpg5/H1PhAOdhO5Q+1JchiTrgZAgxWfRuYPcD4OqP8QuCWzC9ZjL8KZzCAJTbDNSE22k9910ME4V0Y6P7tQ5SdhuGQTbbjN1Gw5Ui7B+hjX7siR/FvXkH5APVBIU0j5jEOnngz2pLusWg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2020 11:44:47.8126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0998628-78e0-473f-db69-08d7b2d5a015
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2334
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2/13/2020 9:19 PM, Jason Gunthorpe wrote:
> This function accepts a udata but does nothing with it, and is never
> passed a !NULL udata. Rename it to ib_create_qp which was the only
> caller and remove the udata.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>


BTW,

shouldn't ib_alloc_mr_user need also to be updated ?


