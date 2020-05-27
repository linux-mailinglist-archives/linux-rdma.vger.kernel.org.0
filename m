Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723211E38E2
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 08:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgE0GOq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 02:14:46 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:56254
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbgE0GOp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 May 2020 02:14:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyMf9MmHMKO0wT0Tmyiq8evxeiOhFb0j81ty+CeDaPNmagkLT2QxmCgkdhRadCe8I0zAxvh4PRsTEmtNDeQkzKM6rdPzNY8ADCSWxM/jQso2em3kDCV9m8osYS87L5RWxUxaEWIcrm4feM/XT/0dzPp4unNZg4Uvf8Um9dE6ZaeqJunWHD1El+46lQkctEdDxu8ufu5yR5UX5ToxB9RwE/C0p+8SHUeENy+hAM/CKvIZebANHvSp1pc3XsXOdA3IPpmpbSUUauAFo7oywi+JhjfoyR3otDWnqB79HoWwp9i1nEf+4KkVlt0LcEyJhxtWj2akEOxOV8iVkRISi8SKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flaeGJhed/8inctt5um58yPFGZXbnpwHn7RV4+kP2Wg=;
 b=G9uPCOJxUMHXhfaaNSzWi/rpLB52OZMmPZgoxd4U3OmeHDh7cruMAPfaSjSVLd9xhL0vNNEFU7pvpwtV/UuD/50gJ/uEu9oHbAead39+VjRFnObUKCitHUESkQAsTRX6Ek2uDW/Szb4KvxdILNxiQ6VmzrDBS2ACNjA/n+tdD0dsyezD5KJO3OQpLA2SQlUGMAbqbWo2EclmNu9RFM8S6wpMx7wZbdliEXeJk38xqnP3pNWokeIaWgM4xlbystYEK83z9Qypwd+HmPESqUvxK80QHMj4HULkINqSR/afW/RCjZyOnmKWrR7zbTd8OuLal2OLGMEUCHSZciZpJRa6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flaeGJhed/8inctt5um58yPFGZXbnpwHn7RV4+kP2Wg=;
 b=DOC41QtYX8yednFm5gELuaYo0WSWL8UwWqd/VEWHE4Vtbn6r7J8gf5dSLJ4QjY/dWAowL5iScfOk625DWOvB43WgtD+1rHXbRmG7c393rzGUqgvDcQKLET8nRrBflT38ChfgJHeNRpV8u57SEEz+wk0vUnN+RY2dW19RhF73zok=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB5886.eurprd05.prod.outlook.com (2603:10a6:803:e4::21)
 by VI1PR05MB7149.eurprd05.prod.outlook.com (2603:10a6:800:18a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Wed, 27 May
 2020 06:14:40 +0000
Received: from VI1PR05MB5886.eurprd05.prod.outlook.com
 ([fe80::1d64:cb82:890d:19c9]) by VI1PR05MB5886.eurprd05.prod.outlook.com
 ([fe80::1d64:cb82:890d:19c9%6]) with mapi id 15.20.3021.030; Wed, 27 May 2020
 06:14:40 +0000
Subject: Re: [PATCH rdma-next 11/14] RDMA: Add support to dump resource
 tracker in RAW format
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, Lijun Ou <oulijun@huawei.com>,
        linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-12-leon@kernel.org> <20200525144136.GA21858@ziepe.ca>
 <20200525162145.GB10591@unreal>
From:   Maor Gottlieb <maorg@mellanox.com>
Message-ID: <64abe8b8-7a07-89ff-bfc9-0bf06f5e405b@mellanox.com>
Date:   Wed, 27 May 2020 09:14:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200525162145.GB10591@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To VI1PR05MB5886.eurprd05.prod.outlook.com (2603:10a6:803:e4::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.10] (93.173.18.107) by FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 06:14:39 +0000
X-Originating-IP: [93.173.18.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1783d489-ba8e-4bad-3531-08d802053db1
X-MS-TrafficTypeDiagnostic: VI1PR05MB7149:
X-Microsoft-Antispam-PRVS: <VI1PR05MB71493E88BADB6EB78772ED52D3B10@VI1PR05MB7149.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpMUy0Ojdsp6yP7roTXy4/AupNaXPRCUYDBC7uoxeG7229KDOqgrodaRQllCsG0gx4vX+90qcNp/uhPskYw4Ccleg8z47lQETBJfcbiYcarMbneoXZfkSN5uAnn7K6+PG7jNVm4UwRNLE5l2YsQHM0b2vkEL/llamtugeweQpkr6kYcSpSaa/OVg1LIEijOz6AJoUsAd98q3IPUvRPn26waWIPtdoyWN+2wPaYAt7/OQ/TmZcyYaHP7Ia952F99C0yLN3pZXOSno4C2wFYWwwGl0nP/DwWrxczTKrvLdAWYdD1maj8FdAoxSPsYrfieOCB+IZx28EV7AQlHkUQmlK+TxY+VPap0S3m1ZdHz99uFOsdhiruP4tPoP1PPj7rau
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB5886.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(26005)(66946007)(36756003)(66476007)(66556008)(6666004)(8936002)(52116002)(16526019)(186003)(31696002)(956004)(5660300002)(83380400001)(4326008)(2616005)(8676002)(2906002)(316002)(16576012)(86362001)(53546011)(6486002)(31686004)(478600001)(110136005)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XTQBfharW9SJPymGxglsT2fndIfcuz+oM3ZWAipQIGbggQlCIM2f9tyXigur9r87ub4uN4eKg5BwbcXor+F++veKtxgb32LW7aCNOh9TBp+WjCCHfXfouChpLyo98C66g3Tv9hVhQXl4r3PWq34E3hTFLuVcIf400UsiHeBjujfJ4Y8rUa2imOo58re7jm30XqTEyLhbPAw9aWIWAnAGapvDoD42KVUsAEMMLtRtTy8FmkEf5lrNoTxLMb3btkkanm6ptA4bmfGI73TM5uog32J5O5cJJpmUpTnr2QIRIgeQnQ2I+buqrLSyxKF0pOy/Q2bYd3Av3VLztniXdYhEPQnbw/DQJ2HDTJ/NDBDk2TL/v2YRuL8Mq3DJ+mG1Ci0YGPke+yCZZO3fiLe59EQxUgs1C+sJkgjMC9nBXnAKHNFQ7Qqc2xgsjO/ExJPCpwLjLpaqE6qRokgvUfSEBkD/nKRDDqLZuRJdDqFEi4ZHTmfkzGRfwGfbq9zB1YoF72vj
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1783d489-ba8e-4bad-3531-08d802053db1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 06:14:40.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5aFIcpzQ2iZ+Kp1cGTGwYv/8jyCAMjboT7MTOTJb10CGYTEAapcZ4yEM4lVcCLseFAkkvPML2YIDSQNOvHmPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7149
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/25/2020 7:21 PM, Leon Romanovsky wrote:
> On Mon, May 25, 2020 at 11:41:36AM -0300, Jason Gunthorpe wrote:
>> On Wed, May 13, 2020 at 12:50:31PM +0300, Leon Romanovsky wrote:
>>> From: Maor Gottlieb <maorg@mellanox.com>
>>>
>>> Add support to get resource dump in raw format. It enable vendors
>>> to return the entire QP/CQ/MR context without a need from the vendor
>>> to set each field separately.
>>> When user request to get the data in RAW, we return as key value
>>> the generic fields which not require to query the vendor and in addition
>>> we return the rest of the data as binary.
>>>
>>> Example:
>>>
>>> $rdma res show mr dev mlx5_1 mrn 2 -r -j
>>> [{"ifindex":7,"ifname":"mlx5_1","mrn":2,"mrlen":4096,"pdn":5,
>>> pid":24336, "comm":"ibv_rc_pingpong",
>>> "data":[0,4,255,254,0,0,0,0,0,0,0,0,16,28,0,216,...]}]
>> That is pretty gross, why not bas64 encode it or something?
> We are talking about rdmatool output, right? It can.

Consider we are referring to the user space part, this kind of change 
requires to implement some encode and decode which looks redundant for 
me. Further more, devlink reporter do the same and I would like to use 
the same parser tool which used to parse the devlink output.
>
>>>   static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
>>> -			     struct rdma_restrack_entry *res, uint32_t port)
>>> +			     struct rdma_restrack_entry *res, uint32_t port,
>>> +			     bool raw)
>>>   {
>> Should it be a flag not a bool?
> I assume that once this RAW series will be merged, the MR res dump will
> be close to feature complete.
>
> Thank
>
>> Jason
