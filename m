Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E41D1ABB
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbgEMQMG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 12:12:06 -0400
Received: from mail-db8eur05on2041.outbound.protection.outlook.com ([40.107.20.41]:6103
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732218AbgEMQMF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 12:12:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faSZm/PKvE8pq4XkSlu/wnEYyPkUG0lxRCQg7cwppeB2+HUcxYmFNKe6ObIs6IdtpJy4rLy5TVtBHDruOKFPyUXAWmKwdxFMVzCpcEdQa2R5PH9V5ABb/kynqqtI7A6Dh1Joak5W9oJmvbmIBeUR+rmIh8V/PWJeFQX+Ed6tZqUhRp40zXI4fuGYsHRNg6PYeAiC3fFI18atSVs+58P+6dmUzJvgZAYZ2L0SIfbg4a8lJVGABAroMafVDaLa/15VD8eyPnyEX+WHEWGsUVqYaCLJnUEhWQAk12c6eySN0hSSyJ2DonqfryaPkNvxgUwPae07vLaLCKq6rJ0ORC81eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjqeR4EjbpYfgSH22GTmEp1Mq1ix0esTt03AcxwPMQc=;
 b=c5luFMIeyp/A7+OGO+FUuKiR/Jr1bRtmHGo/UH8CASXvIGakGikpb5OKkWAk2IxvOw2uG3g7fZ0aH/zYoOQhhP9/a9eZauO5W9nQ8u4c4T+DwTW1leHp/ZiM9p+Zwi8kRIjod9wMDw3tHZQnPdwWMC5HvyVjTpKBWz1oEAF835BphswohNvn/uGh2Xrug9D8GC65cdmZl/VuDERSMGOHP7AwMW5h5oHDwPqO5YSeGuxvs65gpCkVm+8j8Sb00pGnV+kxOGqFyhL9CAc4naaSvZQejyaZbVVs9CK61ALKaigeVLnVDyUbzxoZm/hUNLhYVK41gy/Qd4Oq9l+OJyXyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjqeR4EjbpYfgSH22GTmEp1Mq1ix0esTt03AcxwPMQc=;
 b=SGCDPja3wNu/W9w+ehRt9ya5mlBtraJaGhD0yN+dQEJeIwNJ/dwReKrWaO0yC2b34g92vqwsVY4f0m7o+mGSnIpWxIjU9TgUU2SacayvEXY7LIa4cr3tAx12EqMV+m+4nIvIuAgWr7141S7uN38eKxVkgk21r1vQftRScwTOJiU=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4530.eurprd05.prod.outlook.com (2603:10a6:208:b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Wed, 13 May
 2020 16:12:02 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 16:12:02 +0000
Subject: Re: [PATCH 1/1] IB/srp: remove support for FMR memory registration
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     bvanassche@acm.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, leon@kernel.org, sagi@grimberg.me,
        israelr@mellanox.com
References: <20200513144930.150601-1-maxg@mellanox.com>
 <20200513145722.GH19158@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <221e0bb5-31d8-c0ba-207e-67119cc39070@mellanox.com>
Date:   Wed, 13 May 2020 19:11:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513145722.GH19158@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.12 via Frontend Transport; Wed, 13 May 2020 16:12:01 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35624f0a-d007-4c2b-74f4-08d7f7585f38
X-MS-TrafficTypeDiagnostic: AM0PR05MB4530:|AM0PR05MB4530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4530EC5A6BF6535C665FC45AB6BF0@AM0PR05MB4530.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdGIF1KeSPUJ7igRpble14t5NAcatJ1GOzlpsGhTR7Srv1v46BMl6ige8CQM/hoSwJu7RUCZFLF/9UmqeAEiPB3NhoGVnRS3TdQtRExe7hUAvHVg7e4JyCcKngKUE1WKSWYMMXmA9S7LfEMPCpbcCIHVaTAvys91hkSPgU1sxzY62adUjLHGTq20YDKQN4Hiw7bNvnii2C05aJX48kRkfj2YG3NaFnw1ABKBrxYpUgErLY3kpIioykt2WQc+b0ypwal/lPSBbji7dgbhoHpnn3WYe7BQ5BcyZY8RMDKTvWLqEAwOpvm4drc8R6F6y0peUIlISUtktg+A0KpFFO9mslxjMQVWqftbLFcEPljoN0pVEa3PPJdklfuYmtL3VEQzQhpk5HJn1W9SVjkdWCHI69/AtEK+4EdOMvyUNOAW9f8hh9emFAmnvB2vWmp+BBcs9/eBmGmGtOxeYBv8Z2vKhvyP0q/mdUTeUPuH57XXn+ErMy0QFZ2ONfMJxBFSViMZ6aeAE3IHQU3jifVBdVzaLj3cGwi9hmL6pKAsmcvZ5ZmPVJhM7wfKvrmXwZb9d12y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(33430700001)(66946007)(6486002)(31696002)(2616005)(26005)(107886003)(16526019)(6862004)(186003)(316002)(31686004)(5660300002)(53546011)(4326008)(2906002)(33440700001)(52116002)(66556008)(37006003)(956004)(36756003)(86362001)(8936002)(478600001)(8676002)(16576012)(6636002)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vicnIv+0JCP2z+2m8FR4mXxhGh/PbbCvHq980wU/k+8KQK2k3kv3O4mZI5A2Jmu2SiqAG/+OettBSbbTpJT1IdOqQEygGE5HCdnuOFn2FrEJaII+RLjZetrpA/0vPd3SB0G1jyk6+XKfcPdytYgH7+B9BJn/eOUYaP4tt5tR5IpUplJOxdHZMY/apia8KnI+6BUABwYLn0ykqxXp6qZ/qy6WSPImPJ5sLp62pgw3VF0ZABEeYF2XNuwRLeOU4qsJRTa4JAyTMwJKDCSTrFbZPExKMaxkS3z6q9DZ8i2zZHKVpZ2CQpq+6N57EYCATR82Z5h5igpfTU6PHeoPQ8NMlLE72Hk1weq82oVx5VYDHzxf9u76jOjOnvF97NaOzzTaR6h9sOP89Epa4RUQ+Db7EvnirNZouF76kBrWv1JYWKNgBWj2+v9KRIE41s+NADgkAzNKAuTPQxWzS8yq6GrXeYljShkmEPhEwiyJ1W0GG53AXshkenHDxevM8WAQFmIf
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35624f0a-d007-4c2b-74f4-08d7f7585f38
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 16:12:02.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTOhFxtKJNwLWZ14Kpw7s2QQaZtfYAYhsxGcsYzpc85TbNAhOAv6gVK0v3773hY+08/NVDLlQs92AfprbyFyPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4530
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/13/2020 5:57 PM, Jason Gunthorpe wrote:
> On Wed, May 13, 2020 at 05:49:30PM +0300, Max Gurtovoy wrote:
>> FMR is not supported on most recent RDMA devices (that use fast memory
>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
>> ULP.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> Reviewed-by: Israel Rukshin <israelr@mellanox.com>
>>   drivers/infiniband/ulp/srp/ib_srp.c | 221 +++---------------------------------
>>   drivers/infiniband/ulp/srp/ib_srp.h |  27 +----
>>   2 files changed, 24 insertions(+), 224 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
>> index cd1181c..73ffb00 100644
>> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
>> @@ -71,7 +71,7 @@
>>   static unsigned int cmd_sg_entries;
>>   static unsigned int indirect_sg_entries;
>>   static bool allow_ext_sg;
>> -static bool prefer_fr = true;
>> +static bool prefer_fr;
>>   static bool register_always = true;
>>   static bool never_register;
>>   static int topspin_workarounds = 1;
>> @@ -97,7 +97,7 @@
>>   
>>   module_param(prefer_fr, bool, 0444);
>>   MODULE_PARM_DESC(prefer_fr,
>> -"Whether to use fast registration if both FMR and fast registration are supported");
>> +"Whether to use fast registration if both FMR and fast registration are supported [deprecated]");
> Why are we not just deleting this?

Are you talking about the module param ?

Usually we deprecate it since we don't want to break existing APIs.


>
> iser and srp are the only remaining users of FMR?

In Linux kernel yes.


>
> Please send this as a series including additional patches to remove
> all things related to fmr, eg the drivers/infiniband/core/fmr_pool.c,
> headers, ops, verbs, driver support, etc.

Ok.


>
> Jason
