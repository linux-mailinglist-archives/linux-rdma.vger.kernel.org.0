Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2421D7910
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgERM66 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 08:58:58 -0400
Received: from mail-vi1eur05on2085.outbound.protection.outlook.com ([40.107.21.85]:26593
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbgERM65 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 May 2020 08:58:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJeOy6v+ky7ZW3PcpRka1Dw6zeb0ygfSRtGuFGfh0VFlU75eK+6VTkb6o81/G3vNHOV5ahE1vNmuWc2TugnhmFTqLutoRlNQDqlAVXKXNtQ8+AtTJX4hrRtNWPqjtfcdk95Dm3dN0r/dZCu2FQScEvYywV9LSzWqtUb86xW1PNLBjGF17BIobmw1dG05eqBqb+nTITkQOEH3zfvZUa9LukjZnsojDwc8K/T9qNAaaMUEnfDbK5a9kYjXqF8Nw5GLLdUilPkfDj8i564PLpxG40Mq4RuUqlS0s43cHrNet/SwlDL8fKBP0iCw6Xi0A+5pCx6o2t6YSTVg9IrwiE2Pzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+XFu52bZ4oyP/yjDkPSJKk60L7a0pe6sujo0RC6TGA=;
 b=idWqZ4784pZdR07+TwFo0tsW1UG8dDvJ9SsWO3lyFteZ0Nc8/zKM82st1xuzDT6RubI80fzm0CkdLy+ITAbFqIIGT0mgMMl3HoeTkEceQUcw5RUOskfYG9+r3QmMMy9woavjeWf2OOY7bQdjF1naXItN9RnuJgJcuF948rMSJcipydG9OpBN4eRDf/2ZPKPHJa+te68mHymYncl1PXMkLOeyxDxFiKeoFDy9gFTTjA2tPxyiWU2++nB7HuPfBhl4Xv6p3evZaqVJ+JY3bKH2cPe6x89hdmucS66lJnqO4tbyBEn2IX0atyoWQxbn7pa0itXlFcuYwY7768ItY60QrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+XFu52bZ4oyP/yjDkPSJKk60L7a0pe6sujo0RC6TGA=;
 b=IY62r+ZPuMrEn0z8glp8zx546mtEUVqI3fOlDlUFiNKED5Yv8UiMGUxBW3B/u0/vNyBFQ/k12HVYcKObIeN6p7zCfuwtoJJElxZVtRwmP3iKak+kPd2D99dWMXdis5bMvVWyI9hXNYAimx2BQLcYIA7epoRzThNw3G0apcxtREc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB3964.eurprd05.prod.outlook.com (2603:10a6:8:3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 12:58:25 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 12:58:25 +0000
Subject: Re: [PATCH V2 1/4] RDMA/core: Add protection for shared CQs used by
 ULPs
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Or Gerlitz <ogerlitz@mellanox.com>, linux-rdma@vger.kernel.org
References: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
 <1589370763-81205-2-git-send-email-yaminf@mellanox.com>
 <20200518075416.GA185893@unreal>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <d8e19d4c-897c-25af-5d67-399238cda781@mellanox.com>
Date:   Mon, 18 May 2020 15:58:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200518075416.GA185893@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0163.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::32) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM0PR01CA0163.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Mon, 18 May 2020 12:58:22 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66021f8d-5b23-4f99-904f-08d7fb2b26df
X-MS-TrafficTypeDiagnostic: DB3PR0502MB3964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB3964C9440D087D1D76CE77ADB1B80@DB3PR0502MB3964.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6tPPhXJ9nhy15K/Wx+s0EIlSz2lkg2TXas1PtWxAcWhjjMvOlxFFTy10LqhqwMNRzCx+Y1yS65W5Xw0WJ0ufWHe4Uzf4hnlCcDfpT+hz3ge+mbEqIatreeS7+JDNu33Qnk0mD5r1jfpN9BWQ7U+4EPLMBLbncUPJoCnIuHz+vt5dcSK14YCQD/o0d1RXCbjD7j1u5QcImc46fJ38LQtkQJiMdIacrn6HdgNZbjpf+vHQ3Jhiu1goELer0CGuZsJwtobczh3xfdqqXJdev8/7Qwz/GRQB3N1Yk2wFP8FiMGOeBdhgUcGVXCCty5Uo6B9aX/qiQUjfnT8uol+8/x/JyfOFMnlMdNSwYjoDSQC3IvrAF7tvU/OZIVZndMzHOdwXOorS0kgVzeJsyOnBwXig7yQ75S5puPmY2ou02BlNjjIPMq6nl08SsXnM/9k0uchMO+L/d0UfZ8UZB4NnSjr8vgi069ij6RgwqGsQt5F0xy3+mwrNN/ZQoFYKnuiOjvJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(66946007)(36756003)(66476007)(16526019)(66556008)(53546011)(6666004)(52116002)(186003)(26005)(956004)(2616005)(31686004)(8676002)(5660300002)(31696002)(86362001)(8936002)(37006003)(6486002)(54906003)(316002)(16576012)(2906002)(478600001)(6636002)(4326008)(6862004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Stlfq8wcG1VBePxv/oIWxpzaQxqPrwHXUO8VFiILgcuTuhQS6QUEoDWCK2DnhrDnJ9dT5n6xkJNlZdVBVRIQSENhJDQ1iVugnom4ImyYhF3DigTZqMSwBKMTIw0lM4Zd+LijI80d2tUliYBKJSJzF1fPpLFFpMfj8/kFi2gJuiKl2KCsVKvzy5fA/HgH9ZleLL3fCkk7BgSblV+v0qsOadbsqhyuAGZQ7QnWWbWEXeunUIY4LFnJ3dZecBnB6PjZKFkhtdEy1uOxoQElfZKDSip1MupEL7zt4C2nXJZoRWiYMYAFZvQu5sfBf7kEK7x2KbmCinCMdvqaWdVy6+dyNaNiMat1RLVYJMgPMggKVjy3K3fozVApTP8oEW/VEDeqYCuGJmNOpty4UWsdbQ2qQAnsZ5FduP/m1bxc/upBmMQX7K+UQAP5FTU1/Oz135jmE9VyBd+EY+Yn+lojbJc+9cIzXm6ulbVW/SDSPYrgQUg=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66021f8d-5b23-4f99-904f-08d7fb2b26df
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 12:58:25.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p67wrTKI6nf9gtnOG40T2IMuzkQqxkJwzyHpQpht3spoNAuqrIpxPZGdo58R1KzL7s5dQrSAiq5Dnt6u5xLGEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB3964
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/18/2020 10:54 AM, Leon Romanovsky wrote:
> On Wed, May 13, 2020 at 02:52:40PM +0300, Yamin Friedman wrote:
>> A pre-step for adding shared CQs. Add the infrastructure to prevent
>> shared CQ users from altering the CQ configurations. For now all cqs are
>> marked as private (non-shared). The core driver should use the new force
>> functions to perform resize/destroy/moderation changes that are not
>> allowed for users of shared CQs.
>>
>> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
>> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
>> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>   drivers/infiniband/core/cq.c    | 18 ++++++++++++------
>>   drivers/infiniband/core/verbs.c |  9 +++++++++
>>   include/rdma/ib_verbs.h         |  8 ++++++++
>>   3 files changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
>> index 4f25b24..04046eb 100644
>> --- a/drivers/infiniband/core/cq.c
>> +++ b/drivers/infiniband/core/cq.c
>> @@ -300,12 +300,7 @@ struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
>>   }
>>   EXPORT_SYMBOL(__ib_alloc_cq_any);
>>
>> -/**
>> - * ib_free_cq_user - free a completion queue
>> - * @cq:		completion queue to free.
>> - * @udata:	User data or NULL for kernel object
>> - */
>> -void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>> +static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>   {
>>   	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>>   		return;
>> @@ -333,4 +328,15 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>   	kfree(cq->wc);
>>   	kfree(cq);
>>   }
>> +
>> +/**
>> + * ib_free_cq_user - free a completion queue
>> + * @cq:		completion queue to free.
>> + * @udata:	User data or NULL for kernel object
>> + */
>> +void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>> +{
>> +	if (!cq->shared)
>> +		_ib_free_cq_user(cq, udata);
>> +}
>>   EXPORT_SYMBOL(ib_free_cq_user);
> All CQs from the pool will have "shared" boolean set and you don't need
> to create an extra wrapper, simply put this "if (cq->shared) return;"
> line in original ib_free_cq_user(). Just don't forget to set "shared"
> to be false in ib_cq_pool_destroy().
Makes sense.
>
>> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
>> index bf0249f..d1bacd7 100644
>> --- a/drivers/infiniband/core/verbs.c
>> +++ b/drivers/infiniband/core/verbs.c
>> @@ -1990,6 +1990,9 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>>
>>   int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
>>   {
>> +	if (cq->shared)
>> +		return -EOPNOTSUPP;
>> +
>>   	return cq->device->ops.modify_cq ?
>>   		cq->device->ops.modify_cq(cq, cq_count,
>>   					  cq_period) : -EOPNOTSUPP;
>> @@ -1998,6 +2001,9 @@ int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
>>
>>   int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>   {
>> +	if (cq->shared)
>> +		return -EOPNOTSUPP;
>> +
>>   	if (atomic_read(&cq->usecnt))
>>   		return -EBUSY;
>>
>> @@ -2010,6 +2016,9 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>
>>   int ib_resize_cq(struct ib_cq *cq, int cqe)
>>   {
>> +	if (cq->shared)
>> +		return -EOPNOTSUPP;
>> +
>>   	return cq->device->ops.resize_cq ?
>>   		cq->device->ops.resize_cq(cq, cqe, NULL) : -EOPNOTSUPP;
>>   }
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index 4c488ca..b79737b 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -1582,6 +1582,7 @@ struct ib_cq {
>>   	 * Implementation details of the RDMA core, don't use in drivers:
>>   	 */
>>   	struct rdma_restrack_entry res;
>> +	bool shared;
> Lets do "u8 shared:1;" from the beginning.
Not sure what you mean "from the beginning".
>
>>   };
>>
>>   struct ib_srq {
>> @@ -3824,6 +3825,8 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
>>    * ib_free_cq_user - Free kernel/user CQ
>>    * @cq: The CQ to free
>>    * @udata: Valid user data or NULL for kernel objects
>> + *
>> + * NOTE: this will fail for shared cqs
>>    */
>>   void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata);
>>
>> @@ -3832,6 +3835,7 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
>>    * @cq: The CQ to free
>>    *
>>    * NOTE: for user cq use ib_free_cq_user with valid udata!
>> + * NOTE: this will fail for shared cqs
>>    */
>>   static inline void ib_free_cq(struct ib_cq *cq)
>>   {
>> @@ -3868,6 +3872,7 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>>    * @cqe: The minimum size of the CQ.
>>    *
>>    * Users can examine the cq structure to determine the actual CQ size.
>> + * NOTE: Will fail for shared CQs.
>>    */
>>   int ib_resize_cq(struct ib_cq *cq, int cqe);
>>
>> @@ -3877,6 +3882,7 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>>    * @cq_count: number of CQEs that will trigger an event
>>    * @cq_period: max period of time in usec before triggering an event
>>    *
>> + * NOTE: Will fail for shared CQs.
>>    */
>>   int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period);
>>
>> @@ -3884,6 +3890,8 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>>    * ib_destroy_cq_user - Destroys the specified CQ.
>>    * @cq: The CQ to destroy.
>>    * @udata: Valid user data or NULL for kernel objects
>> + *
>> + * NOTE: Will fail for shared CQs.
> Let's add WARN_ON_ONCE() to catch mistakes. No one should call to
> ib_destroy_cq_user() for the shared CQs.
Alright.
>
>>    */
>>   int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata);
>>
>> --
>> 1.8.3.1
>>
