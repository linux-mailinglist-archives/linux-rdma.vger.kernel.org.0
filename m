Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95D8367F4
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 01:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFEX1c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 19:27:32 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:30277
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbfFEX1c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 19:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+/m595QPVU1qx6QkIcmi7qsdxs/fU7iEuLmTyMmd3g=;
 b=EKkWGHd5K7nPClUtldbcb61p3qDQ7XmNy2CQAADJX2GGIgj2wln+tnxNjVkk+eVvadf9HxRUMbneDDIIkxxZAmD5hH1A2Ks0gkqfRxeLUq7glG+HDJHf7MTvBCRiL4hrDHQMVswdvM5VWqj8F+z/yS6UinzOJxpw2qBL8+ZzpxA=
Received: from AM3PR05CA0154.eurprd05.prod.outlook.com (2603:10a6:207:3::32)
 by AM5PR0502MB3009.eurprd05.prod.outlook.com (2603:10a6:203:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Wed, 5 Jun
 2019 23:27:29 +0000
Received: from DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by AM3PR05CA0154.outlook.office365.com
 (2603:10a6:207:3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12 via Frontend
 Transport; Wed, 5 Jun 2019 23:27:29 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT045.mail.protection.outlook.com (10.152.21.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 23:27:28 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 6 Jun 2019 02:27:27
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 6 Jun 2019 02:27:27 +0300
Received: from [172.16.0.12] (172.16.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 6 Jun 2019 02:26:33
 +0300
Subject: Re: [PATCH 16/20] RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC:     <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <jgg@mellanox.com>, <dledford@redhat.com>, <bvanassche@acm.org>,
        <israelr@mellanox.com>, <idanb@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-17-git-send-email-maxg@mellanox.com>
 <20190604075336.GS15680@lst.de>
 <e67e80cd-a2ed-b76d-21c5-1189b682b7fa@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <bae07b08-6712-3e97-7d7d-8e8c8187ef08@mellanox.com>
Date:   Thu, 6 Jun 2019 02:26:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e67e80cd-a2ed-b76d-21c5-1189b682b7fa@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(396003)(376002)(136003)(2980300002)(189003)(199004)(230700001)(2616005)(126002)(2906002)(478600001)(476003)(81156014)(81166006)(8676002)(3846002)(6116002)(486006)(31686004)(70586007)(70206006)(58126008)(50466002)(336012)(110136005)(186003)(54906003)(16526019)(65806001)(65956001)(31696002)(86362001)(64126003)(8936002)(76176011)(356004)(23676004)(2486003)(77096007)(26005)(7736002)(229853002)(107886003)(47776003)(5660300002)(4744005)(305945005)(67846002)(36756003)(446003)(11346002)(53546011)(65826007)(106002)(16576012)(6246003)(4326008)(316002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0502MB3009;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79941752-7c79-42dc-c57c-08d6ea0d6035
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:AM5PR0502MB3009;
X-MS-TrafficTypeDiagnostic: AM5PR0502MB3009:
X-Microsoft-Antispam-PRVS: <AM5PR0502MB3009CA041755ABBE21717B69B6160@AM5PR0502MB3009.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:403;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 9kjhrQ+WIJ5di3fOYjP5FuQX0VlqU006QcmSrzXiGcOaaxOLvNUj+4g7EqnE0ypmTplHUWPS+gFKPYI4iVg9DxAQzjjuGuRcBVOy6/uXosf9I4QM38Qs7Geko8AI/1FxXIXjPHdOLI5e+bCThaDhGJsqwY6SgJcTrvxl9g+0uMNSRiqcqt/CyRfUZ62t2X7iPQ6i0W9pnp+nNyJx0raAAABt/JMw9RJu98NIjF/zoD0C87BkKWyi196a4Bq9C92LaOf4hwl24AtdrheEOhGHL6DiCyy39qiPMA/ajOuZxK33QOg+1vMZLvS5+EoeQZrrL9rrbmeVjBGrlx9TjT0lI+Eux6WhNNcLgQHF7315pLCT3HshCCRTKvWvV0h5MFsUQVVVKRPqBOyyeA2vIPQBmVaTwnneswhSz5JLnG0MIQo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 23:27:28.7074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79941752-7c79-42dc-c57c-08d6ea0d6035
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB3009
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/6/2019 1:55 AM, Sagi Grimberg wrote:
>
>>> + memcpy(ctx->reg->mr->sig_attrs, sig_attrs, sizeof(struct 
>>> ib_sig_attrs));
>>
>> Why do we need to do a struct copy here instead of setting up a pointer?
>
> Yea, can't we use the mr->sig_attrs directly?

No, the MR is internal to RW API and the sig_attrs comes from isert. I 
don't want to loose the pointer I've allocated. it will cause a leak.

