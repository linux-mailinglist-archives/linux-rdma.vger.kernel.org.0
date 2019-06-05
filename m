Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A092E36602
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 22:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFEUxV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 16:53:21 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:58039
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFEUxV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 16:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVdCocYi0gLO387WdwpsPDVduIkw0BaQShReCgylpx4=;
 b=ihEpDL4VzxSld2X2bid33ouKyZIlVpR3RwMZk8IJFjCKhIuqA+N0DEGYyr45RyAxhoIA7ikWhKQXzjR7kmfwU1zyY1QXXUFlj1Q3cprJ3ggn5XmpFtl++La9qQ6bXdTeeMJoSZMAcbDcZvYPITRiUq6m+gyoktCtSS/3VKD/Oag=
Received: from VI1PR0501CA0025.eurprd05.prod.outlook.com
 (2603:10a6:800:60::11) by DB3PR0502MB4058.eurprd05.prod.outlook.com
 (2603:10a6:8:9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22; Wed, 5 Jun
 2019 20:53:15 +0000
Received: from DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by VI1PR0501CA0025.outlook.office365.com
 (2603:10a6:800:60::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Wed, 5 Jun 2019 20:53:15 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT033.mail.protection.outlook.com (10.152.20.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 20:53:15 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 5 Jun 2019 23:53:14
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 5 Jun 2019 23:53:14 +0300
Received: from [172.16.0.12] (172.16.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Wed, 5 Jun 2019 23:52:32
 +0300
Subject: Re: [PATCH 04/20] RDMA/core: Introduce ib_map_mr_sg_pi to map
 data/protection sgl's
To:     Sagi Grimberg <sagi@grimberg.me>, <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, <jgg@mellanox.com>,
        <dledford@redhat.com>, <hch@lst.de>, <bvanassche@acm.org>
CC:     <israelr@mellanox.com>, <idanb@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-5-git-send-email-maxg@mellanox.com>
 <b9c0f67c-e690-b6db-b326-2c76cfcab7b9@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0d18b282-3950-44f9-c0cd-50c0a87df301@mellanox.com>
Date:   Wed, 5 Jun 2019 23:52:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b9c0f67c-e690-b6db-b326-2c76cfcab7b9@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39850400004)(396003)(2980300002)(199004)(189003)(64126003)(476003)(126002)(2616005)(31686004)(11346002)(486006)(5660300002)(6246003)(36756003)(65806001)(65956001)(2906002)(31696002)(2870700001)(50466002)(107886003)(356004)(6116002)(3846002)(316002)(47776003)(16576012)(229853002)(14444005)(446003)(110136005)(54906003)(58126008)(70586007)(305945005)(86362001)(26005)(77096007)(16526019)(186003)(8936002)(106002)(2201001)(81166006)(81156014)(8676002)(65826007)(336012)(4326008)(67846002)(2486003)(76176011)(478600001)(23676004)(53546011)(7736002)(70206006)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0502MB4058;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d5b959d-f688-40be-3329-08d6e9f7d49d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DB3PR0502MB4058;
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4058:
X-Microsoft-Antispam-PRVS: <DB3PR0502MB405823EF4C385C49ABFB204FB6160@DB3PR0502MB4058.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: aty6pf2TqyLW8pRaxL2VwoBSDPB4jp+R+vVCluu4bNexN2iFecEUXrdN+FibD8pDjPSYfQ2l8P49GRiD7mTBKvlzo4HrGGoUb1FQ3hFcaOmKydExZstCGdHgWUAPjNl1ndT4BLoXb9m8tm1BRjG1xk4xLkFs79y7I0o5zr12mUbRYd83lyypK6aCwRvL6sovoyIGKN6Kz6dzrkgfCuJoPtLeXS0rlp1Shc/U46GRyi0nEdyplCBwZo0l+m6J5CFd0+acao9xITt5NRAoi5+p6e8SR3sleOBR497qtGUkRr3XQPVzVb2s0XC0EimXWykQXqEeMLYHWB/fQ3xNOB6Mj0eIK7TbBk5/ukcTWS/rwhScJwF+5rrSHXkynopXrzlDQiBmsBdRSvO6jnvk8lEGhxdREd6dqDTZ1+KbEQuLlHU=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 20:53:15.0718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5b959d-f688-40be-3329-08d6e9f7d49d
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4058
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/5/2019 8:38 PM, Sagi Grimberg wrote:
>
>> +/**
>> + * ib_map_mr_sg_pi() - Map the dma mapped SG lists for PI (protection
>> + *     information) and set an appropriate memory region for 
>> registration.
>> + * @mr:             memory region
>> + * @data_sg:        dma mapped scatterlist for data
>> + * @data_sg_nents:  number of entries in data_sg
>> + * @data_sg_offset: offset in bytes into data_sg
>> + * @meta_sg:        dma mapped scatterlist for metadata
>> + * @meta_sg_nents:  number of entries in meta_sg
>> + * @meta_sg_offset: offset in bytes into meta_sg
>> + * @page_size:      page vector desired page size
>> + *
>> + * Constraints:
>> + * - The MR must be allocated with type IB_MR_TYPE_INTEGRITY.
>> + *
>> + * Returns the number of sg elements that were mapped to the memory 
>> region.
>
> Question, is it possible that all data sges were mapped but not all
> meta sges? Given that there is a non-trivial accounting on the relations
> between data and meta sges maybe the return value should be
> success/failure?

if data_sges will be mapped but not all meta_sges then the check of 
return value n == data_nents + meta_nents will fail.

I don't understand the concern here.

Can you give an example ?

>
>
> Or, if this cannot happen we need to describe why here.

failures can always happen :)

