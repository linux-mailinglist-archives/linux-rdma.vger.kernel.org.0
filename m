Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E557367DA
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 01:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFEXYe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 19:24:34 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:33341
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfFEXYd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 19:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5huzPV1kLtxwsJQIvz5k0oOYf8kJ5fBYH1SQrg+giI4=;
 b=rbL7/2NBnRKES0fhT4tjGcq+JZ7PtAWWmhFq+mWosvBlOtTCkknOObch0jIbhfpNiZO25vd9edVi/K+2D+V4ZWT9EyPX0/Y1Guvey5WsYnTwXPi8RofouuX89phkCK7BeCZyzYkt8dSrsYbkJtTCorSB/Pdw5WA+JTqS1cXnlTY=
Received: from AM0PR05CA0083.eurprd05.prod.outlook.com (2603:10a6:208:136::23)
 by DB3PR0502MB4060.eurprd05.prod.outlook.com (2603:10a6:8:11::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Wed, 5 Jun
 2019 23:23:49 +0000
Received: from AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by AM0PR05CA0083.outlook.office365.com
 (2603:10a6:208:136::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12 via Frontend
 Transport; Wed, 5 Jun 2019 23:23:49 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 AM5EUR03FT013.mail.protection.outlook.com (10.152.16.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 23:23:49 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 6 Jun 2019 02:23:48
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 6 Jun 2019 02:23:48 +0300
Received: from [172.16.0.12] (172.16.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 6 Jun 2019 02:23:45
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
 <0d18b282-3950-44f9-c0cd-50c0a87df301@mellanox.com>
 <25ae4114-2ea6-6c2e-f6f9-e476dc56cf87@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2841cf54-017e-aa57-3b7b-c7aa2fa48cf1@mellanox.com>
Date:   Thu, 6 Jun 2019 02:23:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <25ae4114-2ea6-6c2e-f6f9-e476dc56cf87@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(36756003)(26005)(478600001)(2870700001)(106002)(6246003)(31696002)(107886003)(76176011)(70206006)(31686004)(86362001)(50466002)(65826007)(4326008)(2201001)(2906002)(229853002)(3846002)(6116002)(64126003)(2486003)(23676004)(67846002)(5660300002)(356004)(70586007)(486006)(336012)(8936002)(126002)(476003)(14444005)(2616005)(16526019)(446003)(81166006)(186003)(7736002)(54906003)(58126008)(316002)(77096007)(16576012)(81156014)(65806001)(53546011)(8676002)(110136005)(305945005)(47776003)(65956001)(11346002)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0502MB4060;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 868b1c8b-83ef-4e97-6d75-08d6ea0cdd63
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DB3PR0502MB4060;
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4060:
X-Microsoft-Antispam-PRVS: <DB3PR0502MB4060D3A5395D62149E246F55B6160@DB3PR0502MB4060.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: mceyMGRE/kylx56CeXCer1tVPX46esEZsPDqJ/7E8GmhiYlJS7iRTjtCVV1hZD8r0CXpzpY5xWq7IB/7sI4AgHjDvq+KwMkPvVrwGG8B6QgqMCxVvZkUgiBlqrsQHcejsOZcEgDLL2hi3z8NzXS1NYkjv3aooRBXnM99TzJkng9Pti7z5epvnXVOryd9FkJ7PtfKKWDlwUK+eeDzt9lH+110RfgxdUS9eArcae5jd3Tru/yYoTv1WOR0M9fbeD8YmXy2G+SeuqRmb6fuGVw4TOsUbZiSR6ygfUyp8CQnNr6ga9Juy/qiY2dSBzrxl75tfaqdJWeHAswCTYEZUZZz+saZ2tC5NxEMnkGATw+ygRoO2fugpAHoe8umtJehXvKcJjAl7/lJZ22HonEMTyqjmuELccoVisJqmo2AF+sStdA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 23:23:49.1619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868b1c8b-83ef-4e97-6d75-08d6ea0cdd63
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4060
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/6/2019 1:31 AM, Sagi Grimberg wrote:
>
>>>> +/**
>>>> + * ib_map_mr_sg_pi() - Map the dma mapped SG lists for PI (protection
>>>> + *     information) and set an appropriate memory region for 
>>>> registration.
>>>> + * @mr:             memory region
>>>> + * @data_sg:        dma mapped scatterlist for data
>>>> + * @data_sg_nents:  number of entries in data_sg
>>>> + * @data_sg_offset: offset in bytes into data_sg
>>>> + * @meta_sg:        dma mapped scatterlist for metadata
>>>> + * @meta_sg_nents:  number of entries in meta_sg
>>>> + * @meta_sg_offset: offset in bytes into meta_sg
>>>> + * @page_size:      page vector desired page size
>>>> + *
>>>> + * Constraints:
>>>> + * - The MR must be allocated with type IB_MR_TYPE_INTEGRITY.
>>>> + *
>>>> + * Returns the number of sg elements that were mapped to the 
>>>> memory region.
>>>
>>> Question, is it possible that all data sges were mapped but not all
>>> meta sges? Given that there is a non-trivial accounting on the 
>>> relations
>>> between data and meta sges maybe the return value should be
>>> success/failure?
>>
>> if data_sges will be mapped but not all meta_sges then the check of 
>> return value n == data_nents + meta_nents will fail.
>
> That check is in the ulp, the API preferably should not assume that the
> ulp will do that and not try to map the remaining sges with a different
> mr as it is much less trivial to do than the normal mr mapping.
>
>
> That's why I suggest to return success/fail and not the number of
> SG elems that were mapped.

It's not a problem doing it, but I wanted it to be similar return code 
and the regular data mapping function.

I guess it safer to return success/fail..

>
>> I don't understand the concern here.
>>
>> Can you give an example ?
>
> In case your max nents for data+meta is 16 but you get data_sg=15
> and meta_sg=2, its not that if you map 15+1 you can trivially continue
> from that point.

This can't happen since if max_nents is 16, I limit the max_data_nents 
to 8 and max_meta_nents to 8.

>
>>> Or, if this cannot happen we need to describe why here.
>>
>> failures can always happen :)
>
> Yes, but what I was referring to is the difference between the normal
> mr_map_sg and the mr_map_sg_pi. srp for example actually uses the
> continuation of the number of mapped sg returned, it cannot do the
> same with the pi version.

Well I guess we can still use this API in SRP and set the pointers and 
offsets correctly.

