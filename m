Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C00A1D1A7B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgEMQDb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 12:03:31 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:46724
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728354AbgEMQDa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 12:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqJvRJkI1zWNXuW3vh/RvD3dwdpBL5uPxKzJZASQb9P/Sex4B+BQypmsdE2x3Ehxp9j8GEb+GpJw4D5V8Sv1oGctoO3WkvV2kwHEUSMg7DpYXw/EOQQUSq2RWt9oZiKVpFN9/VIivDORMBxnAT9erCnefvYdhCjbXJf/AhUFuj6BT+2R0egYMo7U7WWsyAvjiwrq6YZVSLiONAKx6pG7NqbHUDwIb6Bas0/JJT/BgXZ9k/disarc8DepkUug6cGu3iqZKDSl3D8Dcnkes23g37yJEaobfioQkXZhSZVpluaunBSiDnD1eKV0vv1bs07XLIo1mpJxxg+cLCXYgdoFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ca2C9rT+YS4ILooNBsdwR3j2tPRrJK+WQEPCQd4H0k=;
 b=LqFiRLBuefNNZ70Q8pJwPwpsUTGOEN6NB3BdHAph3GG2mFTWRT3lgYVtX2/Jw4sHx14/3MxUdzL5gqIPPxPkwHz8fYdjlsUn+4/T5hD9amN39EhcVlSciLgR2Bi4iTZLFbS+ajvXhtV9UEdYXVPMXv5TbelZiaPqFVJUqO5cRJ3rJ46pvGOk5+Rwk7Rm9iPnHXw5BPA/GKNqjr4wPBZ/hQcJWo1Q+Y2nH99wchGXrVES9OiG1hSB00SLsVa7orX3NT1gnYG+uLSBGmIQAIO5YtZ/CjNQtIZp7olag3MMj9A0q0AOH09etrx9AuUW0+5iX4NLz1vAHrgls09LynPygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ca2C9rT+YS4ILooNBsdwR3j2tPRrJK+WQEPCQd4H0k=;
 b=W7UgDg25gTBVMPXbxKHki6UhitIdwWaMW0qxvxOg2ZFGYCqhMLTtnUI2cKnt07szaGmOyzFR2GBRtzr7Us8bZBWKiQI6JKJFlNjF+xKV/GlpoYMg/hOTf/a5RjTh2bB4bZlcTin/erdkFiqoYaXj4VUfrq1y8p1Djeq+ImWmoF8=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5875.eurprd05.prod.outlook.com (2603:10a6:208:12d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 13 May
 2020 16:03:27 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 16:03:27 +0000
Subject: Re: [PATCH 1/1] IB/srp: remove support for FMR memory registration
To:     Bart Van Assche <bvanassche@acm.org>, jgg@mellanox.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org
Cc:     sagi@grimberg.me, israelr@mellanox.com
References: <20200513144930.150601-1-maxg@mellanox.com>
 <b356d083-7c53-145c-bd30-38fe3b5a6510@acm.org>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <bc179a1a-863f-9ae4-954b-ca18db9c388f@mellanox.com>
Date:   Wed, 13 May 2020 19:03:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <b356d083-7c53-145c-bd30-38fe3b5a6510@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Wed, 13 May 2020 16:03:25 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd93456b-d444-471e-c7d8-08d7f7572be7
X-MS-TrafficTypeDiagnostic: AM0PR05MB5875:|AM0PR05MB5875:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB58751EFA13E1534E4E3A3600B6BF0@AM0PR05MB5875.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7gjr0FwBUmgWoKCjluH2/kYgXq/WrIuv/i71l9j9862B7FJypJabIZ7qNEv9KrszXZwCGBzbKvEhm8gKdSFcPZPMLdda1lLvV/qNLVbEniZFGysdOxM3VjJVIt5cmNdrHjCMXRG4Yu8uibzMxu3OmAYjyxJ7NKdahhDEQTyYuFGoUSetFnl+rUYh2NFCEJOlF8VCM4jaurdi69Dv6j9VCf70btIunJXi2pKVmebGkNpQtvl6bWUU0Xq7yzFNFk7JpvW+YTSuvOz/iIHTzcN7oy8sIEPByKV24BeFbp0iPSerfxOe2FyhYjWdj7Xpkz9npEARx9G2+FFsv+aCtmN36+c+obv3gswMyfTFhhRQDzV0Y9ZekneoEXGH22rakDFl2aiBWSIhmpeHWNRmnuYi4z5n4OFZs9BJpYa2uDXV5oOEImhdCF6deUd222rJindkHazuvEjUe92SkJuk0eIM0XAF62FyEeov2y1xVEqBQssB5HvkiUWUQdlYWxhyzVSPn/0KuYbDsJvPXjGNu/1ofOq2weuDMyuJRXtVOhLjN9QBRvIvUZmGndNumNjiVtN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(33430700001)(8676002)(31686004)(16576012)(2616005)(107886003)(316002)(2906002)(52116002)(478600001)(53546011)(6486002)(8936002)(33440700001)(956004)(36756003)(66476007)(66556008)(5660300002)(31696002)(66946007)(186003)(16526019)(86362001)(26005)(4744005)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: trX2XcRuaOMLTE8uw1JaNnB+Vk8LNi7h66oH84mL4eYpM3/6055+c980IGvRShVHO9yUUJbucqINAUsk569VTEP4oeyRmBUBv+fdmSvygXRfLn7oSUIf0RzO3fPrXJW/S/Sa/NSWnAgjo2kjfrjm74R2dShosTbFrpcA478PjygbrRARBK22NWM9fPa3chJRMhXQvLObUQG2cbAW9hR6C0n/INxCQ8ktYaDPaQeZwzJItp1X/mUpsRpqpHRgTABMZK1JExneRp61JpTtjuBfZE3VCzASUSK6YcdZyuUebVYIGYfGtpYdS/u0brjUkwvjfoCT6sdmFMUnnq3/M8Wb6eHgom5h562s9E/AYVXpRHLvZZ2ves25uRUvP6twmCvmki7Yo/uHj934DeuOtdDYb9wVP+rwH2loeUIBwZQ9h277jlFiD8DgoYYh0Ye9t+wQ4+DjEbNdjD0yxCQ2rh9YAmAsJHfpPOOxaR6Ckocx+xy9qetQgdBzaRUZFQ4RPvuv
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd93456b-d444-471e-c7d8-08d7f7572be7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 16:03:26.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gleAAiZRGEfoQ9uxRnOa4sDVkdBr2T3Feb0DTVWeQoxr+rk7Flyq4BLgRfPFk61sj/R4BfMJfbxMkGk3D+mVOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5875
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/13/2020 6:11 PM, Bart Van Assche wrote:
> On 2020-05-13 07:49, Max Gurtovoy wrote:
>> FMR is not supported on most recent RDMA devices (that use fast memory
>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
>> ULP.
> Please mention how this patch has been tested.

It was tested using loopback SRP connection on ConnectX-4 HCA and 
ib_srpt target (rdma_cm connection establishment).


>
>> @@ -71,7 +71,7 @@
>>   static unsigned int cmd_sg_entries;
>>   static unsigned int indirect_sg_entries;
>>   static bool allow_ext_sg;
>> -static bool prefer_fr = true;
>> +static bool prefer_fr;
>>   static bool register_always = true;
>>   static bool never_register;
>>   static int topspin_workarounds = 1;
> Is this change necessary?

No. But why this should be set ?


>
> Thanks,
>
> Bart.
