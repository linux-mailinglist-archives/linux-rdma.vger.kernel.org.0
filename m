Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8931CD935
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgEKL7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 07:59:53 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:30711
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729416AbgEKL7w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 07:59:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz+USolSruac4iTcXW2MF0slsXO2B9cfd6LgrXDc9pBuIJUOx0wqmXBr2pbjpcyCyChfygthG44+1lnA4gmdbNOKSNuoRw8WoRzv7E5mpSKTdlyp2uB5+QKmY6jHiRKNsPSFy3KUVbEFwncxPzMHBitw35v0MsVQfdqWqSEJMYBAKLgPfhy/LQ+Awne2DqDm7FTSXuz1EjovPGa+AQRiU1EZy83WI+vJKJ9UOKvZvKjEjYWSi0FmvsbXqtlcXZtZzfuFDk+QldC/8QBkIEex8q0pf2bz2n7kx/btWhKXGr4JRy6y/EVXDGwIVOl3bSb8mRdOiRC/n4zfgs8z/NYEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y03A0g5H5PFNFp37l/2PaSUcxOrgwcuYfrnNG9pjK8=;
 b=dfwSMMy9Fqrp2QGbfsUA2XQFeGtYafjikSYxWl7NV4si8O42hoMjZJOnEWGMk1pv7XU/tQBg7X/4pNHuAeYE/wL/iIX5EiKjBTpFU4AMhiAeK9Pr7yPV2kciDw9DQ/CIIGSuF2QLspYY4xffOurNztJZTpwqeTdb9BJ6hXIZlz6J2qfyWh/t/v2M3ZigywI8F0j2lr5/C3QyMImcLSpg/iW+9FgF/Cr/5R6FcCjllQdsy+Qm/LuwX/XDnFaYUQ8vRr/o2HpnzI1S/Jm4gdibIWWa2XDki5+PJVDzqIIr3cw+eNYIP586Fhj5558cW9qgMNJ/oOin7eE7tV9jiJl43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y03A0g5H5PFNFp37l/2PaSUcxOrgwcuYfrnNG9pjK8=;
 b=IisrdLOeGeD1pyJMCrq3MhxQ1skBmLLCm3HhnpegAgcafSCdQxoU5txxySuUWEN5JUQiOMhlys1OV2EowvT8VGxCmE53ZSvrWcY7UppsKqWay4k2e5DYR+3FrygJF3GZS+y5Dsp4OJyfQI8+CI+O8KGoJSYjFTAcdMAys3Vvsz0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB4089.eurprd05.prod.outlook.com (2603:10a6:8:9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Mon, 11 May
 2020 11:59:48 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.2958.035; Mon, 11 May 2020
 11:59:48 +0000
Subject: Re: [PATCH 1/4] infiniband/core: Add protection for shared CQs used
 by ULPs
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-2-git-send-email-yaminf@mellanox.com>
 <20200511043753.GA356445@unreal>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <892bf273-b343-0ca5-ba96-b0c02bdb510d@mellanox.com>
Date:   Mon, 11 May 2020 14:59:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200511043753.GA356445@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:207:3::17) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM3PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:207:3::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 11:59:46 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6195691-aa4e-4f80-76b5-08d7f5a2cd6f
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4089:|DB3PR0502MB4089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB40892CC2D7C5E13D79F0DCC8B1A10@DB3PR0502MB4089.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cYX6yv9NCVWg67H7M72wu+u5zWy1yoWJAJoF6seUaGBC0M/36Itl651j7/bx1M2gVctQreVccrkc6lMop8qKIhd4Z7uN3qzuwr0TsJayz+LKiC1nwEKmDtbUPqNNz0s0pZDrXgDRlcdFdP1oGIh7naSwruNFrB7J1XOwf6QJ0VPFAIXKMsABvo1m0h9GRL3xz75xy0g1KuefjTzO/M7+S+/aI4Q96ULMgF+Lzrhc9vuelR1NkdbM2xKZbNAVucg2DnOFitd5i2zQLJhMY7fdu4SyvXW2+Q8/w+tlSLl4HKE/HC/q2WyojrMGP/+xsXB8FKBKpEMTSJWOT9JvUVscB/1hWzjurP/c00EON55QJVoUvaWvpWscvf3SUkQkwcTsV/h+brvzrQ2+ZEzSjRRa8uxTUpw2G6ZgmwiBR5yqP2Q921/lAxIINa2uYdnCV2Xgu1SY6V5HRGKb5IrI7ZpDAiMvjpoltRHvY/8uzlIguHcgkvNspAQAMGfiilOXkLUqkADHQ2v3Co3DP0R+4/JTUbq5l7wUJktU1RLYSI2vsry9elbD+oLaK7U+Is1TbSQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(33430700001)(86362001)(478600001)(8936002)(66476007)(66556008)(66946007)(36756003)(8676002)(6916009)(5660300002)(53546011)(52116002)(4326008)(31686004)(31696002)(6486002)(26005)(33440700001)(16526019)(186003)(316002)(2616005)(956004)(16576012)(54906003)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: k9m00uAUc27SZijeam42tr/LUcnHCKop7nlTBRDnbprCgrjIVa98hRLekjxp4nKzXIDdKYnTohVhU5z0oUKZZLUB/QHwRVQ2bazYxyHRksO1PAHH3oVI5bU3lG3l+ra0y9q8EdzYmWGHML7q9qZ03DEzhmVBzgiU8IKnwSpL8cJWS9f8laX3Fu0Sil3WY1bqRZhzB/iL2G5KFKirgGkQteCPujLlXenu0Ag2YnRss5SRJu7oQT3YGgA7K9XQgepUJ57yQ1uZVlMgUBik0Ks42nhJZgsH/dVXlNF+tPsRzFWARNIqI0lqO8Ud+cjABnsVKNwXmDnLj8lB/pyASVr2Z6r8KUFhNpI6/1cH+2FvRuy5Biwkcb8yA/izvo+nct6OClS3X7UEkdDO0Ic9k6eaQ1glsPsFasLKduVhkvVK7ra+jQy5mhSj/FYXoe68a/vE3jWh2vP2TKtzd5o4GSRlizZq0Sb9RTHvZm7E2w8sOiA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6195691-aa4e-4f80-76b5-08d7f5a2cd6f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 11:59:48.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3EvLfsdmGS+pthvfyk+FY3hD3Vj4frIDHkFfNTb8Xk5SSsD92F90THGov+Y5vdzO7oLGGGQo/zg/yYFpe5q9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4089
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/11/2020 7:37 AM, Leon Romanovsky wrote:
> On Sun, May 10, 2020 at 05:55:54PM +0300, Yamin Friedman wrote:
>> A pre-step for adding shared CQs. Add the infra-structure to prevent
>> shared CQ users from altering the CQ configurations. For now all cqs are
>> marked as private (non-shared). The core driver should use the new force
>> functions to perform resize/destroy/moderation changes that are not
>> allowed for users of shared CQs.
>>
>> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
>> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
>> ---
>>   drivers/infiniband/core/cq.c    | 25 ++++++++++++++++++-------
>>   drivers/infiniband/core/verbs.c | 37 ++++++++++++++++++++++++++++++++++---
>>   include/rdma/ib_verbs.h         | 20 +++++++++++++++++++-
>>   3 files changed, 71 insertions(+), 11 deletions(-)
> infiniband/core -> RDMA/core
Will fix.
>
>> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
>> index 4f25b24..443a9cd 100644
>> --- a/drivers/infiniband/core/cq.c
>> +++ b/drivers/infiniband/core/cq.c
>> @@ -37,6 +37,7 @@ static void ib_cq_rdma_dim_work(struct work_struct *w)
>>   {
>>   	struct dim *dim = container_of(w, struct dim, work);
>>   	struct ib_cq *cq = dim->priv;
>> +	int ret;
>>
>>   	u16 usec = rdma_dim_prof[dim->profile_ix].usec;
>>   	u16 comps = rdma_dim_prof[dim->profile_ix].comps;
>> @@ -44,7 +45,10 @@ static void ib_cq_rdma_dim_work(struct work_struct *w)
>>   	dim->state = DIM_START_MEASURE;
>>
>>   	trace_cq_modify(cq, comps, usec);
>> -	cq->device->ops.modify_cq(cq, comps, usec);
>> +	ret = rdma_set_cq_moderation_force(cq, comps, usec);
>> +	if (ret)
>> +		WARN_ONCE(1, "Failed set moderation for CQ 0x%p\n", cq);
> First WARN_ONCE(ret, ...), second no to pointer address print and third
> this dump stack won't help, because CQ moderation will fail for many
> reasons unrelated to the caller.
Would it be better to not include any warning for failed calls?
>
>> +
>>   }
>>
>>   static void rdma_dim_init(struct ib_cq *cq)
>> @@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>>   	cq->cq_context = private;
>>   	cq->poll_ctx = poll_ctx;
>>   	atomic_set(&cq->usecnt, 0);
>> +	cq->cq_type = IB_CQ_PRIVATE;
> I would say it should be opposite, default is not shared CQ and only
> pool sets something specific to mark that it is shared.
>
>>   	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>>   	if (!cq->wc)
>> @@ -300,12 +305,7 @@ struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
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
>> @@ -333,4 +333,15 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
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
>> +	if (!WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
>> +		_ib_free_cq_user(cq, udata);
>> +}
> It is not preferable kernel style - not on WARN_ON_ONCE() and do
> something later.
Should I remove the warning completly?
>
>>   EXPORT_SYMBOL(ib_free_cq_user);
>> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
>> index bf0249f..39c012f 100644
>> --- a/drivers/infiniband/core/verbs.c
>> +++ b/drivers/infiniband/core/verbs.c
>> @@ -1988,15 +1988,29 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>>   }
>>   EXPORT_SYMBOL(__ib_create_cq);
>>
>> -int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
>> +static int _rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count,
>> +				   u16 cq_period)
>>   {
>>   	return cq->device->ops.modify_cq ?
>>   		cq->device->ops.modify_cq(cq, cq_count,
>>   					  cq_period) : -EOPNOTSUPP;
>>   }
>> +
>> +int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
>> +{
>> +	if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
>> +		return -EOPNOTSUPP;
>> +	else
>> +		return _rdma_set_cq_moderation(cq, cq_count, cq_period);
>> +}
>>   EXPORT_SYMBOL(rdma_set_cq_moderation);
>>
>> -int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>> +int rdma_set_cq_moderation_force(struct ib_cq *cq, u16 cq_count, u16 cq_period)
>> +{
>> +	return _rdma_set_cq_moderation(cq, cq_count, cq_period);
>> +}
> All these one liners makes no sense, the call to
> _rdma_set_cq_moderation() in this function and above is exactly the
> same. It means there is no need in specific function.
>
>> +
>> +static int _ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>   {
>>   	if (atomic_read(&cq->usecnt))
>>   		return -EBUSY;
>> @@ -2004,15 +2018,32 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>   	rdma_restrack_del(&cq->res);
>>   	cq->device->ops.destroy_cq(cq, udata);
>>   	kfree(cq);
>> +
> Not relevant
Will fix.
>
>>   	return 0;
>>   }
>> +
>> +int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>> +{
>> +	if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
>> +		return -EOPNOTSUPP;
>> +	else
>> +		return _ib_destroy_cq_user(cq, udata);
>> +}
>>   EXPORT_SYMBOL(ib_destroy_cq_user);
> I would expect symmetric API, you can call to create_cq_user for your
> pool, but can't call to destroy_cq_user, am I right?
The only reason I changed destroy_cq_user is because it is something 
that could be done on a shared cq without realizing. Only the core 
driver can create shared cqs so there is no reason to change 
create_cq_user as it still only provides private cqs.
>
>> -int ib_resize_cq(struct ib_cq *cq, int cqe)
>> +static int _ib_resize_cq(struct ib_cq *cq, int cqe)
>>   {
>>   	return cq->device->ops.resize_cq ?
>>   		cq->device->ops.resize_cq(cq, cqe, NULL) : -EOPNOTSUPP;
>>   }
>> +
>> +int ib_resize_cq(struct ib_cq *cq, int cqe)
>> +{
>> +	if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
>> +		return -EOPNOTSUPP;
>> +	else
>> +		return _ib_resize_cq(cq, cqe);
>> +}
>>   EXPORT_SYMBOL(ib_resize_cq);
>
> It is not kernel style and probably dump_stack is not needed too.
Will change.
>
>>   /* Memory regions */
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index 4c488ca..c889415 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -1557,6 +1557,10 @@ enum ib_poll_context {
>>   	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
>>   };
>>
>> +enum ib_cq_type {
>> +	IB_CQ_PRIVATE,	/* CQ will be used by only one user */
>> +};
> Do you see another CQ types? If not it should not be a type but boolean.
> If yes, PRIVATE is not really type but property.
Makes sense.
>
>> +
>>   struct ib_cq {
>>   	struct ib_device       *device;
>>   	struct ib_ucq_object   *uobject;
>> @@ -1582,6 +1586,7 @@ struct ib_cq {
>>   	 * Implementation details of the RDMA core, don't use in drivers:
>>   	 */
>>   	struct rdma_restrack_entry res;
>> +	enum ib_cq_type cq_type;
>>   };
>>
>>   struct ib_srq {
>> @@ -3832,6 +3837,7 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
>>    * @cq: The CQ to free
>>    *
>>    * NOTE: for user cq use ib_free_cq_user with valid udata!
>> + * NOTE: this will fail for shared cqs
>>    */
>>   static inline void ib_free_cq(struct ib_cq *cq)
>>   {
>> @@ -3881,7 +3887,19 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>>   int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period);
>>
>>   /**
>> - * ib_destroy_cq_user - Destroys the specified CQ.
>> + * rdma_set_cq_moderation_force - Modifies moderation params of the CQ.
>> + * Meant for use in core driver to work for shared CQs.
>> + * @cq: The CQ to modify.
>> + * @cq_count: number of CQEs that will trigger an event
>> + * @cq_period: max period of time in usec before triggering an event
>> + *
>> + */
>> +int rdma_set_cq_moderation_force(struct ib_cq *cq, u16 cq_count,
>> +				 u16 cq_period);
>> +
>> +/**
>> + * ib_destroy_cq_user - Destroys the specified CQ. If the CQ is not
>> + * PRIVATE this function will fail.
> It is not only fail, but print huge dump_stack.
I will deal with the superfluous dumps.
>
>>    * @cq: The CQ to destroy.
>>    * @udata: Valid user data or NULL for kernel objects
>>    */
>> --
>> 1.8.3.1
>>
