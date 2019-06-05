Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E23135B67
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 13:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfFELip (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 07:38:45 -0400
Received: from mail-eopbgr140089.outbound.protection.outlook.com ([40.107.14.89]:42624
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbfFELio (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 07:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dm1/9jfz4I3HkY4sEcjjGA8CjBwESuf8MTeeQ+oTS4=;
 b=eLsTlNzV2huTu+1f3jShjunjxWrDRto5+Y4r5z4YuOm0FMvalnInZKvsqEusKuKRsphu3Jod/H7JUiUuEc8YTgxj5jKofDm1jtjNy2AQbTxcCsNoFe9sFLh8iB0skWZxDDZT7Am1nVUcmtiqC4SsC/LkbGhqa0wnlUqkT/yWwLc=
Received: from VI1PR0501CA0033.eurprd05.prod.outlook.com
 (2603:10a6:800:60::19) by AM6PR0502MB4053.eurprd05.prod.outlook.com
 (2603:10a6:209:1d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Wed, 5 Jun
 2019 11:38:40 +0000
Received: from DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by VI1PR0501CA0033.outlook.office365.com
 (2603:10a6:800:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Wed, 5 Jun 2019 11:38:40 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT064.mail.protection.outlook.com (10.152.21.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 11:38:39 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 5 Jun 2019 14:38:38
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 5 Jun 2019 14:38:38 +0300
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Wed, 5 Jun 2019 14:38:36
 +0300
Subject: Re: [PATCH 03/20] RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and
 ib_alloc_mr_integrity API
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Oren Duer <oren@mellanox.com>,
        Vladimir Koushnir <vladimirk@mellanox.com>,
        "Shlomi Nimrodi" <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-4-git-send-email-maxg@mellanox.com>
 <20190604073514.GL15680@lst.de>
 <bcd4fe8a-38df-e302-b12f-4e7a99f9a77b@mellanox.com>
 <20190604124313.GC15534@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ea2d665f-926b-5b80-ff32-9e91c04955ce@mellanox.com>
Date:   Wed, 5 Jun 2019 14:38:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604124313.GC15534@mellanox.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(199004)(189003)(2906002)(336012)(81166006)(81156014)(8676002)(16526019)(70206006)(8936002)(70586007)(23676004)(2486003)(76176011)(67846002)(305945005)(5660300002)(7736002)(36756003)(486006)(6116002)(476003)(2616005)(446003)(11346002)(126002)(3846002)(6636002)(86362001)(65826007)(356004)(229853002)(6862004)(31686004)(54906003)(316002)(37006003)(16576012)(58126008)(53546011)(26005)(230700001)(186003)(77096007)(31696002)(107886003)(6246003)(4326008)(65806001)(65956001)(106002)(47776003)(64126003)(508600001)(50466002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0502MB4053;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 654f05b2-01dd-45f7-0d1e-08d6e9aa5afa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:AM6PR0502MB4053;
X-MS-TrafficTypeDiagnostic: AM6PR0502MB4053:
X-Microsoft-Antispam-PRVS: <AM6PR0502MB40531E0995F1B1D1AC39BE12B6160@AM6PR0502MB4053.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Wk5doFcvG/ud+NLQTCHtsI30E+SLaq298HFI5lEUsL7e+eNGL4fKB15ftrWPlOSBDOVwuXvsFQvfLM74BALJX7dDp7yC2xNRuRECbny229C2fgp8ViL/1qiBm5QHCoFn/VJFqg8DoLBRFe8+tyqogVxq7NOOrm8yClYANORwMPTw/pOY4GvqQ2xfuKnydHjawOR5sDFPfGXE+r48PBIxttPgqiuT/ZGhmPj07zrcLCi/glrYEeFfpT0X9RCJ3pGyMDuzxSnQx6NB7wUXLyGIwMScqnzAxv9E3wrW+8wvj9wLMC/Ea9dh8kRpbXixkBTSwSF0H/gKDldhHC3QZ36tBl+a7aJkwBFsV5kQRbZphGJ0hqFuQxwNcdprRLlHJf0Fdvz57xfIugftPVetk36DZdjINxJ95JCZZLez2kNRfsI=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 11:38:39.6213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 654f05b2-01dd-45f7-0d1e-08d6e9aa5afa
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB4053
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/4/2019 3:43 PM, Jason Gunthorpe wrote:
> On Tue, Jun 04, 2019 at 12:02:58PM +0300, Max Gurtovoy wrote:
>> On 6/4/2019 10:35 AM, Christoph Hellwig wrote:
>>> On Thu, May 30, 2019 at 04:25:14PM +0300, Max Gurtovoy wrote:
>>>> From: Israel Rukshin <israelr@mellanox.com>
>>>>
>>>> This is a preparation for signature verbs API re-design. In the new
>>>> design a single MR with IB_MR_TYPE_INTEGRITY type will be used to perform
>>>> the needed mapping for data integrity operations.
>>>>
>>>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>>> Looks good, but thinks like this that are very Linux specific really
>>> should be EXPORT_SYMBOL_GPL.
>> Well we used the convention of other exported functions in this .h file.
>>
>> If the maintainers are not against that, we can fix it.
>>
>> Jason/Leon/Doug ?
> Since it is in a .c file that is dual licensed I have a hard time
> justifying the _GPL prefix.
>
> Although I would agree with CH that it does seem to be very Linux
> specific.
>
> Honestly, I've never seen a clear description of when to use one or
> the other choice.

I'm also not familiar with licensing stuff.

I guess you prefer using the common EXPORT_SYMBOL for verbs.c functions, 
correct ?


>
> Jason
