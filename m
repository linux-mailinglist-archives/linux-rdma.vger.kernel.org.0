Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A61AB77
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2019 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfELJTH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 May 2019 05:19:07 -0400
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:52100
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbfELJTH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 May 2019 05:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AYzJ9K2LYbGdC2P9+x9XqZ9ouAQTnWEeLOi0al0Cgc=;
 b=TW/oJy834u11yIkFbJrClhJ0tOLqWv/pLVxCa0vOsi6zEn1OGNqix7tcoYP426ucpcfl09G8Nci3mOtdHml2qLpXgXE3l4nwv6xUqJGr82Rxn13i9Hikx9gloUL0jexkGlBYiWnG4OOnXFPTo1S2gax+BhvsGsFB2sG11xZ9lFc=
Received: from AM6PR0502CA0006.eurprd05.prod.outlook.com (2603:10a6:209:1::19)
 by VI1PR0502MB4064.eurprd05.prod.outlook.com (2603:10a6:803:25::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.25; Sun, 12 May
 2019 09:19:02 +0000
Received: from VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by AM6PR0502CA0006.outlook.office365.com
 (2603:10a6:209:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.20 via Frontend
 Transport; Sun, 12 May 2019 09:19:02 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT039.mail.protection.outlook.com (10.152.19.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Sun, 12 May 2019 09:19:02 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 12 May 2019 12:19:01
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 12 May 2019 12:19:01 +0300
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 12 May 2019 12:18:14
 +0300
Subject: Re: [PATCH 25/25] RDMA/mlx5: Use PA mapping for PI handover
To:     Christoph Hellwig <hch@lst.de>
CC:     <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <sagi@grimberg.me>, <jgg@mellanox.com>, <dledford@redhat.com>,
        <bvanassche@acm.org>, <israelr@mellanox.com>, <idanb@mellanox.com>,
        <oren@mellanox.com>, <vladimirk@mellanox.com>,
        <shlomin@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
 <1557236319-9986-26-git-send-email-maxg@mellanox.com>
 <20190508131707.GG27010@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f1c2af3f-765f-edea-43c2-134367e9e1f7@mellanox.com>
Date:   Sun, 12 May 2019 12:18:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508131707.GG27010@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39850400004)(376002)(396003)(136003)(2980300002)(189003)(199004)(14444005)(26005)(77096007)(446003)(2486003)(107886003)(65956001)(6246003)(16526019)(5660300002)(186003)(23676004)(336012)(65826007)(4326008)(6916009)(86362001)(47776003)(31696002)(76176011)(126002)(11346002)(50466002)(2616005)(65806001)(476003)(31686004)(53546011)(36756003)(478600001)(486006)(230700001)(316002)(64126003)(2906002)(70206006)(70586007)(7736002)(229853002)(305945005)(54906003)(16576012)(81166006)(6116002)(3846002)(67846002)(8936002)(356004)(106002)(58126008)(81156014)(8676002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB4064;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1de1fd6-d125-4891-7a81-08d6d6badf94
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:VI1PR0502MB4064;
X-MS-TrafficTypeDiagnostic: VI1PR0502MB4064:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB4064E0DC68EF28A0015D56D8B60E0@VI1PR0502MB4064.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0035B15214
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ScQ3lOn+iZwsOw41Xewhm0C2lm8f5Tl/02DVKcSapxwZvJW+RF1yMCRFSinpAmGzPMBsXJnUzHARS8O3loTAs61YzDsInGAW3AIeWV7Nc1aUEO78B+CDF96GyXWg05ZgreyojQ/i19xKj/KlenrfQVGiLvcpRtX1kpA3TlxnPPB9ABH3pEjZRfyArphULgqWVMfACtmN5Vpj2TreBdPCm17I9EuOL79SiEqgYvnl9CHEuS6Ue1Gvr6W9FALne/dGMGeXAHPG9ICU3Rn4TSuzfPvPyxRg/FRtjPnGbC/2rHX5r2GYFkzk0DkS/vgce8aOXmsRkz5ss9ZUFdtJTW3AgIy92soVC4Lpqi1jgoCXOmee79l0bSOqcsHh8YL6r3SUoe5+KqJSz6TDqEDFRffRO3Asx+JtlP2saRdvuhQ9teo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2019 09:19:02.1033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1de1fd6-d125-4891-7a81-08d6d6badf94
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4064
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/8/2019 4:17 PM, Christoph Hellwig wrote:
> On Tue, May 07, 2019 at 04:38:39PM +0300, Max Gurtovoy wrote:
>> Performance results running fio (24 jobs, 128 iodepth) using
>> write_generate=1 and read_verify=1 (w/w.o patch):
>>
>> bs      IOPS(read)        IOPS(write)
>> ----    ----------        ----------
>> 512   1266.4K/1262.4K    1720.1K/1732.1K
>> 4k    793139/570902      1129.6K/773982
>> 32k   72660/72086        97229/96164
>>
>> Using write_generate=0 and read_verify=0 (w/w.o patch):
>> bs      IOPS(read)        IOPS(write)
>> ----    ----------        ----------
>> 512   1590.2K/1600.1K    1828.2K/1830.3K
>> 4k    1078.1K/937272     1142.1K/815304
>> 32k   77012/77369        98125/97435
> So this makes almost no difference for 512byte or 32k block sizes,
> but a huge difference for 4k, which seems a little odd.  Do you have
> a good explanation for that?

Yes. The servers that were used for the measurements weren't so strong 
to show the improvements for 512B.

We'll try to find stronger servers for that.

For the case of 32K it's obvious, it doesn't fall to the case of PA 
mappings (sg_nents == 1).


>>   			case IB_WR_REG_MR_INTEGRITY:
>> -				memset(&reg_pi_wr, 0, sizeof(struct ib_reg_wr));
> Btw, I think the driver would really benefit from eventually splitting
> out each case in this huge switch statement into a helper.  Everytime
> I had to stare at it it took me forever to understand it.

Sure, this was exactly what I thought during the development. It's on 
our plate after merging this series that's already big enough.


