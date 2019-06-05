Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFFAB3672C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 00:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfFEWDL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 18:03:11 -0400
Received: from mail-eopbgr140089.outbound.protection.outlook.com ([40.107.14.89]:17885
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFEWDL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 18:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+5PqdnFtdT6MrO5nC7V7bGlYtWth+cGHf+jC9tZvfo=;
 b=V5x0vmJSaQN+OWWYWN6q0PMYoN/Ne7dWAUu31k9BIPZfACrwy1KH34LG0yLFIzzEcoODWwGfltI7wWQIAyw4tNn/ZPo3mnJN/aWZ5FFWtF+Z9eku0LLf/IYWJc36WJeYG8WIpyL+oxdDtHMA2/cTQ61fFhtTEz239btSqGIdTK8=
Received: from AM4PR05CA0033.eurprd05.prod.outlook.com (2603:10a6:205::46) by
 AM0PR05MB6419.eurprd05.prod.outlook.com (2603:10a6:208:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Wed, 5 Jun
 2019 22:03:07 +0000
Received: from AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by AM4PR05CA0033.outlook.office365.com
 (2603:10a6:205::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22 via Frontend
 Transport; Wed, 5 Jun 2019 22:03:07 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 AM5EUR03FT014.mail.protection.outlook.com (10.152.16.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 22:03:07 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 6 Jun 2019 01:03:05
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 6 Jun 2019 01:03:05 +0300
Received: from [172.16.0.12] (172.16.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 6 Jun 2019 01:02:36
 +0300
Subject: Re: [PATCH 14/20] RDMA/mlx5: Move signature_en attribute from mlx5_qp
 to ib_qp
To:     Sagi Grimberg <sagi@grimberg.me>, <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, <jgg@mellanox.com>,
        <dledford@redhat.com>, <hch@lst.de>, <bvanassche@acm.org>
CC:     <israelr@mellanox.com>, <idanb@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-15-git-send-email-maxg@mellanox.com>
 <b3f40f6e-ad56-4e6e-b36f-f8afed2e054d@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <cbee2068-75cc-6913-60d3-51e25485446a@mellanox.com>
Date:   Thu, 6 Jun 2019 01:02:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b3f40f6e-ad56-4e6e-b36f-f8afed2e054d@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(199004)(189003)(6246003)(186003)(229853002)(65806001)(65956001)(230700001)(107886003)(11346002)(336012)(36756003)(47776003)(64126003)(16576012)(558084003)(2906002)(58126008)(106002)(65826007)(316002)(54906003)(50466002)(110136005)(486006)(16526019)(31696002)(81166006)(478600001)(31686004)(126002)(476003)(2616005)(53546011)(4326008)(70586007)(446003)(81156014)(70206006)(26005)(76176011)(3846002)(6116002)(8936002)(8676002)(356004)(86362001)(7736002)(5660300002)(77096007)(305945005)(23676004)(2486003)(67846002)(2201001)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6419;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2905d846-1154-451c-160c-08d6ea019785
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR05MB6419;
X-MS-TrafficTypeDiagnostic: AM0PR05MB6419:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6419AF72823CF4156A40EE5CB6160@AM0PR05MB6419.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: nB4INq11oNiZQcQhdnPz/FMWgDHxT3Usny4N1hyKKyNjL9UYWQQUAM9fYOeyfLQxVh4pr3R/nuFmvkPzv1jDABLYF8ykAgDklVeWsjU/jei6IfWwXfs6hTWiignR0Wonvydm6BBjmiL6qF5DCiHLxKxw+Ptchj306UkZolU/5vHilPRhvl8hrFqL59Ll/xnQoJoIh6RUZltokxdkOsTVim2FDqTHcRj0l0KL8GoJgdOLO2xgHeKEgaYx+0vpvVMfixzPBOeqApZasw18XnrPDh3i/mQaDi9zaSQtqn1OcA7nUoih/+DjI6q+1JlUOcRMJyXHWBQ97TGzlv18jWnsV9lL8sbWlaUu/oGZHrnIJGcPon4OIPNW/2KY4sfLWA7jBxqknlywYpJjtC8O9s3PRJhW53K1mUTELLeQ9As24kA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 22:03:07.5370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2905d846-1154-451c-160c-08d6ea019785
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6419
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/5/2019 10:37 PM, Sagi Grimberg wrote:
>> This is a preparation for adding new signature API to the rw-API.
>
> I think it would be good to write how this is preparing for this?

We'll squash patches 14+15 as Christoph suggested and add more 
information to the commit message.

