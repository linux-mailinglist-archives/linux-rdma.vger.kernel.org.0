Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA4D366F1
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfFEVpA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 17:45:00 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:60229
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfFEVpA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 17:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ipsYxsVOegO2oecHplCgnWxHrvTuqcLHBr2MTocFBQ=;
 b=HbFH2JM7uXFFjX3C1KcWfWIOtYBNmdW8g6iFcfp1Bj9pLltZ4kmfXRhlsVUboNwW2kJRGjXMstlDpUhy6FY3phcQCHmK7X9cGeHVVrLBdkwe9NpPmAi5lfbmHc/0p8Q7sJY/kYaupacnmYDYliepiGBMzGHjZQwt+2m5+j8gMhs=
Received: from VI1PR0502CA0012.eurprd05.prod.outlook.com (2603:10a6:803:1::25)
 by DB3PR0502MB4059.eurprd05.prod.outlook.com (2603:10a6:8:4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Wed, 5 Jun
 2019 21:44:56 +0000
Received: from DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by VI1PR0502CA0012.outlook.office365.com
 (2603:10a6:803:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.18 via Frontend
 Transport; Wed, 5 Jun 2019 21:44:56 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT038.mail.protection.outlook.com (10.152.21.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 21:44:55 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 6 Jun 2019 00:44:55
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 6 Jun 2019 00:44:55 +0300
Received: from [172.16.0.12] (172.16.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 6 Jun 2019 00:44:43
 +0300
Subject: Re: [PATCH 07/20] RDMA/mlx5: Add attr for max number page list length
 for PI operation
To:     Sagi Grimberg <sagi@grimberg.me>, <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, <jgg@mellanox.com>,
        <dledford@redhat.com>, <hch@lst.de>, <bvanassche@acm.org>
CC:     <israelr@mellanox.com>, <idanb@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-8-git-send-email-maxg@mellanox.com>
 <257e556b-f248-0847-b7ed-23fb29d04a40@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <b3cd3b0f-f155-62ff-57a4-6ef07aac0932@mellanox.com>
Date:   Thu, 6 Jun 2019 00:44:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <257e556b-f248-0847-b7ed-23fb29d04a40@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(136003)(346002)(2980300002)(199004)(189003)(67846002)(356004)(478600001)(4326008)(36756003)(70206006)(31696002)(23676004)(70586007)(86362001)(50466002)(2201001)(16576012)(316002)(486006)(16526019)(186003)(2486003)(229853002)(107886003)(106002)(6246003)(76176011)(110136005)(54906003)(58126008)(53546011)(2906002)(81166006)(2870700001)(7736002)(126002)(476003)(2616005)(11346002)(65826007)(305945005)(336012)(446003)(26005)(5660300002)(81156014)(65806001)(65956001)(77096007)(8936002)(4744005)(64126003)(47776003)(6116002)(8676002)(3846002)(31686004)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0502MB4059;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c64858-72fd-4a8f-d535-08d6e9ff0cc3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DB3PR0502MB4059;
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4059:
X-Microsoft-Antispam-PRVS: <DB3PR0502MB40595956B2BB971562B9AD06B6160@DB3PR0502MB4059.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: gHine95f5TpAf8EJpVfo7e2YlM/+Lb00h7YxxOc9jD40HkmXlBgp9ly0my6FOMysZDJKH20MoH4kbfvcRe56PhaIT08ZVmUYXlMirxB9ODJLzQpmXs9EdnjI2kf8U2brp3t03xjiKu1gAac7mfs8VOm+qUXn8DOINDn8XdbSEXQ4WW+QS8AROe+YxzTQCK6Kl5V2vRpb9e4XQWYjT3Z6Pv+8ytDRUQLzJJx+r0+vatQTCHYkPuv9o8eX9UfD65K0gIoh6Dzx1g9q2HjQjPeP9kPf6tNbtDXP1GobHssoS4FDvTJqkcFqTGm5onlorr1o8E1vbp4m4r1p8ujTi4P0wWbLrL3TiQIjam5bMAjsaSbuZR1xmFWaPuQ4v+oYDhdz4kwlTUV8E7fRyd9faVOw45K9olGgnLfiDdfbzBmlicA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 21:44:55.7613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c64858-72fd-4a8f-d535-08d6e9ff0cc3
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4059
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/5/2019 10:28 PM, Sagi Grimberg wrote:
>
>> + props->max_pi_fast_reg_page_list_len =
>> +        props->max_fast_reg_page_list_len / 2;
>
> is it page_list_len or sg_list_len? Also need to document that
> both data and meta sges need to fit in this (and not respectively)


in iSER:


  if (iser_conn->ib_conn.pi_support)
                 max_num_sg = attr->max_pi_fast_reg_page_list_len;
         else
                 max_num_sg = attr->max_fast_reg_page_list_len;


so max_pi_fast_reg_page_list_len is the length of *each* list in case we 
do PI (not the sum of the 2 lists length), the same way as 
max_fast_reg_page_list_len is the length of the list in the non-PI case.


