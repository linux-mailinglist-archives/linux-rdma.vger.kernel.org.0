Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7761AB6B
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2019 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfELJJt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 May 2019 05:09:49 -0400
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:7331
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfELJJt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 May 2019 05:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tah9uesw6aATO1RdVlEnfZT2ZazKTOtKxQcugOJubDY=;
 b=aF11fz3RPU5DQ3njYak3n2516ZJb1yTjboBVWJvlDzuXTsAPqiScfccxgkIfWj8W9OlLVCvnwOJTNxHgeKZmEeZlnbaQSpo//jPZg8hL/VQ6HramQlmKzvq/2mb7k+NAyIS82XqNDmDl/6BKjYiTO4bwI7mlC0c8dxWT04ZMOug=
Received: from HE1PR05CA0279.eurprd05.prod.outlook.com (2603:10a6:3:fc::31) by
 VI1PR0502MB4061.eurprd05.prod.outlook.com (2603:10a6:803:25::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.24; Sun, 12 May
 2019 09:09:42 +0000
Received: from DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by HE1PR05CA0279.outlook.office365.com
 (2603:10a6:3:fc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Sun, 12 May 2019 09:09:42 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT019.mail.protection.outlook.com (10.152.20.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Sun, 12 May 2019 09:09:41 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 12 May 2019 12:09:40
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 12 May 2019 12:09:40 +0300
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 12 May 2019 12:09:38
 +0300
Subject: Re: [PATCH 21/25] RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
To:     Christoph Hellwig <hch@lst.de>
CC:     <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <sagi@grimberg.me>, <jgg@mellanox.com>, <dledford@redhat.com>,
        <bvanassche@acm.org>, <israelr@mellanox.com>, <idanb@mellanox.com>,
        <oren@mellanox.com>, <vladimirk@mellanox.com>,
        <shlomin@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
 <1557236319-9986-22-git-send-email-maxg@mellanox.com>
 <20190508131300.GD27010@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ed3ac4be-7d69-e920-fff7-11949e558f4b@mellanox.com>
Date:   Sun, 12 May 2019 12:09:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508131300.GD27010@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39850400004)(2980300002)(199004)(189003)(67846002)(5660300002)(70206006)(70586007)(36756003)(50466002)(53546011)(229853002)(6916009)(356004)(2906002)(3846002)(54906003)(106002)(58126008)(65826007)(6116002)(64126003)(126002)(81156014)(2486003)(4326008)(81166006)(16576012)(23676004)(6246003)(11346002)(2616005)(476003)(316002)(8676002)(8936002)(16526019)(336012)(77096007)(26005)(7736002)(186003)(107886003)(31686004)(305945005)(47776003)(65956001)(65806001)(230700001)(76176011)(446003)(486006)(31696002)(86362001)(478600001)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB4061;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4006eaf-988a-457d-96a1-08d6d6b9919c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:VI1PR0502MB4061;
X-MS-TrafficTypeDiagnostic: VI1PR0502MB4061:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB4061B57E0D5C8C6805483A1EB60E0@VI1PR0502MB4061.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0035B15214
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: AYfvYBV85EH63zRmCx51/rDopFyEn5A2K4UqfLv8M+ulKhRiPGODD74mJ3YYsMg8kXck2qRj7TK9sIenH/0yh7lxyYBdnT0QVQb4LQHLR1KWg5GvQiIbbvjLyAmmwQLeOeVUsQhbPI+YwUgoelpsYUIJMkkGbpnrgui5G6wWbFa3lNCM+mOhE3CMMPxoTaW228B6L5cCXrlbvtcox7gipgc1xRi19+BLs55YJSegSvqSwdj0jZOhELsiLYBa63fg2n9CHbTPakmoVjANaP79GPWFBz40T5hEQMxMNvAOwniZAbaK5P9EaTD/fGlWa9Kzsu8YgSwmp/XFn6KGKDnzPhvO93pwKGJkFKaJDVJ75PicUrScyVicRVYDyyuTwXqfd7CrxF6F/uWFFOj2qJJac/9GjjieMkMkrxe3jmS1zQY=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2019 09:09:41.7844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4006eaf-988a-457d-96a1-08d6d6b9919c
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4061
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/8/2019 4:13 PM, Christoph Hellwig wrote:
>> There is a performance degradation when writing big block sizes.
>> Degradation is caused by the complexity of combining multiple
>> indirections and perform RDMA READ operation from it. This will be
>> fixed in the following patches by reducing the indirections if
>> possible.
> It would be good to figure out if it is posisble, as the regressions
> are pretty significant.

Not sure if I understand. We've created an optimization and we'll 
perform MTT mapping (similar to "PRP" in NVMe) instead of KLM (similar 
to "SGL") if the buffers are not gappy.

In general, KLM is less effective than MTT since it's more complicated 
operation for the HW. And we should use it only if we really need it 
(e.g, we have a "gappy" SG list coming from the user).

I also want to perform an optimization for non-PI operations that will 
use KLM mkey only if MTT mkey is not enough to map the sg list (for 
SG_GAPS memory region). And then add SG_GAPS support to NVMf/RDMA.

