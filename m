Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491241AB6D
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2019 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfELJLf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 May 2019 05:11:35 -0400
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]:39982
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfELJLf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 May 2019 05:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9nG6gbLUlqKwXB5gkoFJMlWAr5TOu+95AWeC4hkd9U=;
 b=ET8cV66vVP92AQ7sjom/VJZFoe3pKZemJdRYOT4NAfqD5LoaBABxN4GoyBnN1ZNbpIPCHEHgmY5wwfSvH+otQPEHQDzjpDbFOfkKZZERoMTJg+tatGoYJ8zhdLpZf5S2oJaJlte5UgCrzTN2UTZzwfa+Ln2gaKOFsyp3NlioF2s=
Received: from VI1PR0501CA0015.eurprd05.prod.outlook.com
 (2603:10a6:800:92::25) by AM0PR05MB6417.eurprd05.prod.outlook.com
 (2603:10a6:208:143::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.24; Sun, 12 May
 2019 09:11:31 +0000
Received: from AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR0501CA0015.outlook.office365.com
 (2603:10a6:800:92::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Sun, 12 May 2019 09:11:31 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 AM5EUR03FT026.mail.protection.outlook.com (10.152.16.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Sun, 12 May 2019 09:11:30 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 12 May 2019 12:11:29
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 12 May 2019 12:11:29 +0300
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 12 May 2019 12:11:27
 +0300
Subject: Re: [PATCH 23/25] RDMA/mlx5: Improve PI handover performance
To:     Christoph Hellwig <hch@lst.de>
CC:     <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <sagi@grimberg.me>, <jgg@mellanox.com>, <dledford@redhat.com>,
        <bvanassche@acm.org>, <israelr@mellanox.com>, <idanb@mellanox.com>,
        <oren@mellanox.com>, <vladimirk@mellanox.com>,
        <shlomin@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
 <1557236319-9986-24-git-send-email-maxg@mellanox.com>
 <20190508131407.GE27010@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <be313ee8-7b57-9573-2782-0b920e35840d@mellanox.com>
Date:   Sun, 12 May 2019 12:11:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508131407.GE27010@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39850400004)(376002)(2980300002)(199004)(189003)(77096007)(186003)(23676004)(6116002)(3846002)(356004)(64126003)(106002)(2486003)(76176011)(107886003)(54906003)(58126008)(67846002)(229853002)(14444005)(26005)(50466002)(16526019)(478600001)(486006)(126002)(86362001)(476003)(6246003)(336012)(2616005)(53546011)(31696002)(11346002)(446003)(230700001)(5660300002)(31686004)(316002)(70206006)(4744005)(70586007)(305945005)(47776003)(7736002)(36756003)(6916009)(65806001)(65956001)(2906002)(65826007)(8676002)(81156014)(81166006)(16576012)(4326008)(8936002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6417;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb33af6-0239-4e35-4313-08d6d6b9d29d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:AM0PR05MB6417;
X-MS-TrafficTypeDiagnostic: AM0PR05MB6417:
X-Microsoft-Antispam-PRVS: <AM0PR05MB64173352E92C1C35DDCEC7FCB60E0@AM0PR05MB6417.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0035B15214
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: T/fr/qXY1XIvIHGLMWL/mVMP/viL0zWLoA9P1BMiOrv8a3jXMUga/b0buXeDXiOPExgugzcxgH0vPNZLPSMaNRGjo23X6oaLpCwcmx989HdP+Qjs9SrajgOHqNVK2XjoimGVcHr6MPhA/UPrXcPIIPkIK6wIcI4tBqATl1K9+J856EgP7CPUOKP6kfeRBkmE2A01xQqqSBP0T3cRzB7rRxebmGQayvwSU2Z0SJmJVnP+kfB1qd31F1k7wFDpAdoozsz+IDiFv0HxFc33w9VNM5UBXmseqg0Q0lkq+L4ZMHaMMtmzLmzCAz04LoCSE62U+F3/V47NB6ouJZ3OE7vEpi7czCyT0OBFB0MxvKU9fRZv2VZpalXkU8WmSVamLfSNHb4FAhsVpNEiL8C3zY1e+my6WP9PUbxEB2w7Shy+E+o=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2019 09:11:30.7697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb33af6-0239-4e35-4313-08d6d6b9d29d
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6417
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/8/2019 4:14 PM, Christoph Hellwig wrote:
> On Tue, May 07, 2019 at 04:38:37PM +0300, Max Gurtovoy wrote:
>> Performance results running fio (24 jobs, 128 iodepth) using
>> write_generate=1 and read_verify=1 (w/w.o patch):
>>
>> bs      IOPS(read)        IOPS(write)
>> ----    ----------        ----------
>> 512   1262.4K/1243.3K    1732.1K/1725.1K
>> 4k    570902/571233      773982/743293
>> 32k   72086/72388        96164/71789
>>
>> Using write_generate=0 and read_verify=0 (w/w.o patch):
>> bs      IOPS(read)        IOPS(write)
>> ----    ----------        ----------
>> 512   1600.1K/1572.1K    1830.3K/1823.5K
>> 4k    937272/921992      815304/753772
>> 32k   77369/75052        97435/73180
> This seems to roughtly get us back to the previous performance levels.
> Maybe it would be better to compare against the baseline without the
> whole series?

Yes, we'll add another column to the table (w/w.o/baseline) that will 
show the whole comparison.

Thanks.


