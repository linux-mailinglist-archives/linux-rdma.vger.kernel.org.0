Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A061B5B15
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgDWMJ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 08:09:58 -0400
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:40902
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbgDWMJ4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 08:09:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDc0cgASNXHvvdkucjNEwqsKqx0yVGGPcJcxs3KZaWGv48NNQYGldT1jvNSgaCAcsvEYeAsUJetkAvs0h+u2jKPNS3k4Z0JujjK8koPSTu5BiC/ETyoNpW+bULnqmKOamRYsTia4p8+CaVR1DVFckOEFm9BeQF6Dm8q1w75yH9pUwQnAnIuWdmYtU0X6vfR3m6V/i5a06iNm5GjwBHrYfAjk2kcDGXtx2oucEZS/1a+xIMWadsStKj6PYHUfyu7dgRbzkTmFTyJ5GvCz8YmSMSoPCFKKOcU8onnvKz9RxzzWfU+X8AFJXNRsMCihcGyFAMFN9J8BPl0iNGBQSB+9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UgssgCa4aPt+dQ69Frg0IVWlhTAu21/usoyopWzDQc=;
 b=WQZs8fFn+C0IovzQlZzHHx23L3oMZlUIkp0yhuT5Mevxt1wBNPjU42xgxjPpeJzL0LJLArrjbO8lVUt+99lHnMuiO2mw1Wn0Iqj4Qqd4nPFJSKa4k19JmNPQvRGicgZlk3Y46l3Ox/qSXDnBfIPN9tft32cYtNl2COefuk99cMc+FSA+HdPltMIotWOFXjH+gAZZjD6pdaJfkuYTaGNqnj4ylLnLv6ctLRCadP53Jzb9HJWePV7DJ8YRgcRCxN7EN1B8/niMrn+RAHonJV8/iKU24SDIr4C1bCwIorfT5YgOolJMIVDbHSWreKVlAJkj5CdaMBJQQOS/qvxDv4OMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UgssgCa4aPt+dQ69Frg0IVWlhTAu21/usoyopWzDQc=;
 b=VjH2QshWjdJA3+vQ0Tm2jOEvce/TVR04tmWxcamPXtToTNguLk26l4syh6l/SgxN5bSCPpVlprY6XcMJtPF80+dddt0KdYB75XmfJ9fh66GbZ8HryB6YPjlVzcFQBn2ipgKQhsqMr4QIaYMB9Y65wSNrsF3nPwADi1suCe8Z4+I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5251.eurprd05.prod.outlook.com (2603:10a6:208:f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 12:09:51 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 12:09:51 +0000
Subject: Re: [PATCH 13/17] nvme: Add Metadata Capabilities enumerations
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-15-maxg@mellanox.com> <20200421152407.GD10837@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <b4f77666-6be9-121d-4ca1-fc1887cbd92e@mellanox.com>
Date:   Thu, 23 Apr 2020 15:09:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421152407.GD10837@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0114.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::19) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by AM0PR01CA0114.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 12:09:49 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb196e1c-3a2d-4173-7c28-08d7e77f398c
X-MS-TrafficTypeDiagnostic: AM0PR05MB5251:|AM0PR05MB5251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB52514406387E8C63DA1F6099B6D30@AM0PR05MB5251.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(31696002)(8936002)(316002)(36756003)(6916009)(53546011)(8676002)(81156014)(6486002)(52116002)(16576012)(5660300002)(2906002)(4744005)(186003)(16526019)(31686004)(86362001)(478600001)(26005)(66556008)(66476007)(66946007)(956004)(2616005)(107886003)(4326008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7FN+sgztfYedYTV81rJY5MXNL2/Y+pmKHdu6agOpn6YpP56f6SnFJG+sUkFW/yguSdN/d3aZCQxnHNI4zBlPdpLlM4pxP/lUDOAAe4GvfNI8feTWmxd2FIul7NE8d6VJN/tFTerHCKWau84qi4C2h33HDnDqheQ1NKl/dY7ronP0YOKV8G75I5Bf0ayA0hxatMJWZwh3d/4RzStijCwVPGYslQH8XSyyIZqUPbh0OP1dRblsdpATQZtgmMqGTWjqscD8NMLkWZyRJu8hqT62P6ONkYC9SNEkUl7XavzPb5nsVgrjw80fxGAnTPq1uOmqBJVdkMLw2mF6JAUDTINlLnR9kI3GrlF+0tPAZ7eQ98hj58uokMvI7eugNjyIau865W54TjgxhtQMqno/dlGhMeJeC88kD/Mk8Lk0xEm+39YOxIRRmhOtVfAXZO2KpqT
X-MS-Exchange-AntiSpam-MessageData: Yctn4SFwguD5YayywbJvGrpRpiPF2SMEnpwXQAxhfSgAYP/4vBwagVXvs8bf1gqRVZP5iX3ShqRZnTp3X2JosgbYL8Ut2tO9/4RGPxxFQxWxBKCDCx7UO4m1242rGNIEemF2CbNfB8e9vb4GDlzc6RTKeH9YmoNOflamk7Kpz+SaiDMeW8+HA/3Q0BCHW/fkzxdqjTBU17Ea+AcK5cemIPtFtuy3TDiy5I1Y+lDY1lh3rCUghuRAKS1gRfUYiKwtNBQ0SMDHR13pow56C114t/3lV+nwXQYlYdLyLB23Gk9ce+6aA+3QqtqmtCUW6d/bIdcVu5+Ihd2AsLWtJXkQ8Vq4rUZi+jy8DoSI8uQRwv3LaJ4N9uUB1af5kmamuPGlqpbZ6QAcunN2i5e9QO2hBOz2gfqCXlpMGdVOJMcljD2myHE38Satb4uCAZ59AiQZ4GBMz1C0CbmiEu+6WWTsF02I3P7mpbtkHZhZUqVxtLCmNXlGqjOXEWctG8MI6Ygn2qVBsIMnHIwe4cjV2epetJIH5ZfpS4HYWYad+9GIXlBZGgHglDLe8DYkF4UbfvMJJzic4AFpX5e1jDWWFAfD5i1sbJ/ClNe31+neT2wo+Fx6XAe456aALA8zjWz3xNdomGRmLaqCL0pu9KsLL7K5oaRZYIQBaF6GWbBf/qB/+ipJv5RAQtqoJrl9rbFeP9LnAkAVHzfTiU7wcO55kUvgsk9ZQkr2s24+X5S+kEfe/xuZFm2NrmXVbNrjCPQ3zBM9N7rgx79J2iuNKlrrOz6o3PyhU1UJe5wedPjsqWDsl36JCVaQ+pcTLKsWNSFjIWFR
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb196e1c-3a2d-4173-7c28-08d7e77f398c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 12:09:51.0944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6iuut28FytTelwhYxzktu1qZqXyTT6qdmxWjt6AYCybXcxxp/ejHkJlAq0jG2wbIrr0HSGporWoyabl8870Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5251
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/21/2020 6:24 PM, Christoph Hellwig wrote:
> On Fri, Mar 27, 2020 at 08:15:41PM +0300, Max Gurtovoy wrote:
>> From: Israel Rukshin <israelr@mellanox.com>
>>
>> The enumerations will be used to expose the namespace metadata format by
>> the target.
>>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> I'd be tempted to use a separate enum and add a comment to which field
> this relates.

something like:

+/* Metadata Capabilities */
+enum {
+       /* supports metadata being transferred as part of an extended LBA */
+       NVME_NS_MC_META_EXT     = 1 << 0,
+       /* supports metadata being transferred as part of a separate 
buffer */
+       NVME_NS_MC_META_BUF     = 1 << 1,
+};

?

