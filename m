Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868C45E7174
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 03:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiIWBki (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 21:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiIWBkd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 21:40:33 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87647D58A0
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 18:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcnZ+YBp5WtS7dzA1tccfRzzJB6s66bdV0UpsAaIFM4bZiHhZesjy+5h1qFA84TQXIqr4oddYq7ZlQCZamu9npBiJcH0qPsELf9t4L+ggCTU+BMqpmz8NeK4kGBewb9lBzOrrTYCyuQ0uEN1hjkTQOc/Q27W20M7jvLCYNqfH/jD4Rk//tLdxeqRxGj66fuKrpX0gSKup8YAMjJOGlYxLa/j1wbnvrcOYU5/r5MWuPxt/aRwf7LFJXA+qTKz9iZFtXzZwztvEyQfTRQGRNSV07caN3qKoJfG2WOZ++ApI+svtO/PkwPNrvQq/1jPZNGtaOVt8Y6gPlLmdCetcYCspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9gGjV5SVqaE10aQEcM+W87ixNXQvw6XiVn4mM4eYtQ=;
 b=b0vByNxZ3lZR3ICIYc3klxc6n7kITqTr+VU0S/9v/46hJOcNA5A4zGzcOnrXogzO5NVJfDwyIjwW73Q6UrCRHz7HDNT36qepuD1fZhtDtuVGD9lOi9z0UQbk6SU3HoYZqiA48w+UCEmHHeku0AWRWmKej16PJlw4wKkUXMHPCs94PSEp9NDxWSJvGnwyiUl9/yuGp2FO4eJOg3vDHQBcXBb6N07o9ZOyf2ICDqRXpq6EW0kN83WyqoRVLciNR9cOg6uBRPqJhXc9N6dZE3FUZq7/0XzQVRebqUc7js5BsBV3Mgq/GrP5vnmIt61IhBgKtJmFDIqIouZI8lJis4etPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9gGjV5SVqaE10aQEcM+W87ixNXQvw6XiVn4mM4eYtQ=;
 b=WdHodjLbuJDtyPy5qYVXXwQgIw7lh5m8W8K2K7fDLOa1iKBq5/P06B/k83YIKmggD/CJDXEOfW84Jw7POIUcMfsKdYJJ/+HG6iowKL567cHwk8hgMax9Dpwf/ph4fEqEenA5jLIi1G45WeIMslZ2S0wLUCKQuAb0bNLl/xeQPGYZKE4dKzYqt0I+lO4XAoL4At6qIp2m2w3rKaXvllKbzzpX8S9Z37Seyd4NbKUjxBVO9l6kvXD2llOgwjIkJj/hAoE/S1cQ78d/+OIHuxfcmbHikyR5jUozOnvgFHIp/o5HbswmlaU/1FkLvs+gdCucMEMtWbKoVl61eMFFQj5eNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Fri, 23 Sep
 2022 01:40:31 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::1c13:dfca:d0c5:4d5c]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::1c13:dfca:d0c5:4d5c%10]) with mapi id 15.20.5654.018; Fri, 23 Sep
 2022 01:40:30 +0000
Message-ID: <969cf0aa-a066-5142-d917-f07130974764@nvidia.com>
Date:   Fri, 23 Sep 2022 09:40:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH rdma-next 2/4] RDMA/cma: Multiple path records support
 with netlink channel
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        Mark Bloch <mbloch@nvidia.com>
References: <cover.1662631201.git.leonro@nvidia.com>
 <2fa2b6c93c4c16c8915bac3cfc4f27be1d60519d.1662631201.git.leonro@nvidia.com>
 <Yyxp9E9pJtUids2o@nvidia.com>
Content-Language: en-US
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <Yyxp9E9pJtUids2o@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:300:59::27) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1366:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: f3afbc6b-96a1-4d8e-72f1-08da9d049937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV6aKm3PFc7R9GErLvazJ7B8AKr5+WciGjV+2OM0AeJJ2pPaR5oAI/i6+oq6jGSp+34hxtnPRmKjbg/jWebqlQ+EHMeuVfD5ebgP5Rmlh8GSdPTrNLmLhWJznzBZpZe9lmaz+Tj6R1hH3M3zXkewrL1d/O8XdjBEZIau1QrlU+u0fAqrSh3G7bxwShrwKcxhUt5SN2TNdcUxxbFFXCMMmTg+Ys7ksRy6qp6OQpuA3B269gI9MI4o5QJborDg27XsQcoiA0I7PanuZGNf6b49IWxZOMEwmYM/wLZGoBEDADoV0bbj/aeEbElIJDe8wjg4p7/7D+EMwEQVs2iuRm51Qw94wEQxI5TRVe0Ga5s5MMIF22OSMlmAEdDLSAPse/qQBQ9oPwEQoRD0JsWcJ0fRCkp9mTeDopT9mAxiqoRINVBluYjtOyyfpN/W0p8x0s6/rkayDSlOhPf98u/bjtlNfc3DebyugUANiFT0AwkRmDL5Y+GDp/YFdXAUu1T2p1M39yZ/IZ7/TpRBvU5TEH9s3tQ1BkrzxxSYP9Fs+iqbwgIynUax797wVKaKLkoGr/FGa9DP6kx51fVQdc401v9ycJldnwadUWWdu2EDUYc9+TV69sKzgtv/COTq7Bz47vZTkX7P6UqE6UEu3UgiE6p71zVA2cIz7cuxl6iLhDIUhBJubZqUTLKdLP3ywNEOB61RAm2p20xF2JQPr/6uK77Mw36Wiaxz6iTqrhvjCz/VMrZvXBYyNb+XgTQOZElM6ajrkUd5ZrZCgBgGdVkEMnP7idJHdUrk+EQvlNBkC1cQ+fA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(41300700001)(2616005)(83380400001)(316002)(6486002)(38100700002)(66946007)(66476007)(6666004)(478600001)(53546011)(2906002)(107886003)(66556008)(26005)(6506007)(186003)(5660300002)(8936002)(6512007)(54906003)(110136005)(4326008)(8676002)(31686004)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azZVOUp3Vm15cTRuQ2Z3NDRQMWZHSmpLVXlvY1BGWXF0clZ6dHNqTjRlTnpv?=
 =?utf-8?B?OXQ4T1YrTk12NE8vV1UzYlcwYWxXdUVaY1krQWtQR2x1bHRCckU4L29kY2Z3?=
 =?utf-8?B?YTFyUG9KTERZWUVYN2xxbUhWeGlUOUxPVlZsbmxZMVI2VkJyMEdpS0tkdDNS?=
 =?utf-8?B?RDNQZGpjT25yRHlhS2praEoxMGgvMzFqZ2lUV3FKN1Bqb1ZZTGR5V21NbW1s?=
 =?utf-8?B?blFWZDMzY2RBZlBrSTRHaEh6N3ZpWXhyYjhodnIyb3Fib3FoamFlTG4zdDRm?=
 =?utf-8?B?dW11cnNTV28zYS9jcmJnQ0lydjlySW5qcWpHUjdVczhkVEp1Rnk1dkwzWnBR?=
 =?utf-8?B?Q09DL3RHMjFiS1NLS3BJYUFPTkZHOHlFTVpKZk1LSDdkb2x5MVFUR1NjRXNp?=
 =?utf-8?B?YnF3dFRUV2lBSVpQU1p2OFVjSXZDUVBmY2YyQVQyMkZMM1dGNlVjcmwvbFpn?=
 =?utf-8?B?YTJhVGdKd1VxNkdLazJuMkl1cjdQQWZoRzVjUHkxQXZCT0RCMGRIUktKN0p2?=
 =?utf-8?B?cy9lVHVGR1VGM2ZsUFYyWVhDUFFKZmNPL3hmbWdCWWFFcHkzalhkaStYVEMv?=
 =?utf-8?B?L1pSNVVVdCt3UWVGTUR4UGNhck9kSWNPS25FK1psS210aCtXTmFVbVlJSUtj?=
 =?utf-8?B?MW9jOVNiQ3RPakI4MVpLWFd6VkxaZ0JyZjFPQnlkeWpUalI5d0gwUWtlQVlZ?=
 =?utf-8?B?UmJWQzdnNk1qUGE2dnZ2YUpXZlB6MGdsayt2MEM0aXk3b2Nva1lCME5NK3B4?=
 =?utf-8?B?L0s3UGRQQnI2T2xmQkRaMjV6Q2pmUk5kRWZxbHJxY1hvQlR2dzN0UFpLbk5p?=
 =?utf-8?B?U1hvdWhsQ09ZWUVISWFmeVdaVFJ5dm1aK1J5NDQ3ZVZpSS9DUWlBTU9IbWQw?=
 =?utf-8?B?TWdZUCtxNDFULzkvT2VidURNRTE5RjMrdzh2QWpVZXFuNGNMRU0wa3dwbkZQ?=
 =?utf-8?B?c09hdUNRRG1VbzRIR2E2QkNod3JodzN4Y3J4dUxQQ01zY1k0c3V0aHFad01G?=
 =?utf-8?B?SlVrcFFRTnEyZTF6MVIrekJvbUIvUG5pUVBpNXI2KzU2Q3VqR0w3UlNBcDJO?=
 =?utf-8?B?eUxKQllCeG5KZ2w2MjNNOC9raE53aU94WUFjdHdEWnV3RTRCUkZZdXUxMmdk?=
 =?utf-8?B?aEpWcjZiL0FQMUJtdWlTbEZ0Z2lJWmRSOE9zUlROSmNKWURxaGNSREVaSDVB?=
 =?utf-8?B?ZjM0WHBsNW0yK0thVWExUVpYRjhaNFRHSmdVcGJzWExXemFvd0RzVy9POWI4?=
 =?utf-8?B?NmJxZkJQRlNldjlaU0RtRVhiZlcwa040aytFV1N0RkpJNG9XRkliQ09COHMz?=
 =?utf-8?B?dW52TVVXV2JIbEo5a3BEVWV0WHg1T2FyNDZacnZBQWZhYlg5cld6T3c3b1Jj?=
 =?utf-8?B?amNEeEJwdnVnYkg5NHBjbDNmTDVoVG1KUXRRSXg4OENZU2UrZkN2bjVzT2hJ?=
 =?utf-8?B?NXpuK2poWkpXVlpER2d4LzRmckVmUlQ1dmRUMEdjK0Nrak5nbWlDUVk2UFVU?=
 =?utf-8?B?eFhmWUpMT3laV1JJQW92UnRJZ2VhcyswVkFMWFRsZWtKLzBMYzVYNjBTUzJI?=
 =?utf-8?B?d00wZHpiU05ZNTQ4aXlkOGdRVzRZVnNDbWZYY2p1ajFsWUdhK0lvV1FrWlUv?=
 =?utf-8?B?NTdoUEs3L0lESWF5bVFhQ3lxMzh5K2hKNm1qdzBXN3B6Z3BiUjgybkZxd3FZ?=
 =?utf-8?B?a0lUckNlcVdyU0kxRVZIQkRyZWNkM0VpNXAzektZc1NQd3V4S0FhSlV3VzAz?=
 =?utf-8?B?dGsxbFFNdzQ3TTltN2lkUDk1UDYzNVdsTlB4RDlxWW9uZVJTWVpDWVJOUTlF?=
 =?utf-8?B?WUprMGpTWHp0SFRTTHFNU0VETHJmcEp1VDJUcThLdXVVd0E4RFZscHl3OFNa?=
 =?utf-8?B?dXV3OWpnL1Q4TFUraWc1Qnk2Yy9ZVzh3c284UTBHNTlmZWVrWlZXVzMyNTZ2?=
 =?utf-8?B?VmtuU2xoazN2QUZyWVdVYXprbHFkc3VJRTQrWDdmajJOMDExWXl5Y1FyMmti?=
 =?utf-8?B?MVk4UUt2bWIzR0Q2VWpMdDRYL0twbWhTNzlYdGJvTVNsbFZOQ1dlWUR3S1Bo?=
 =?utf-8?B?QnZwSTNTT1MwQ2JFcmZadlJXUWg0UlhLRVltbGJNblBpZXdhSUIwSnB2NHRu?=
 =?utf-8?Q?xXMSUIHohku1wiNHGBwClmmAi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3afbc6b-96a1-4d8e-72f1-08da9d049937
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 01:40:30.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXVNUB6Bhv6cqpdHkFMjZFPOeCklsrYZ4oT+4/tnG+UUn3Koijm3+HJUurzwUjBZxgxiSEKqCzr0/4ApAM0znw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/2022 9:58 PM, Jason Gunthorpe wrote:
> On Thu, Sep 08, 2022 at 01:09:01PM +0300, Leon Romanovsky wrote:
> 
>> +static void route_set_path_rec_inbound(struct cma_work *work,
>> +				       struct sa_path_rec *path_rec)
>> +{
>> +	struct rdma_route *route = &work->id->id.route;
>> +
>> +	if (!route->path_rec_inbound) {
>> +		route->path_rec_inbound =
>> +			kzalloc(sizeof(*route->path_rec_inbound), GFP_KERNEL);
>> +		if (!route->path_rec_inbound)
>> +			return;
>> +	}
>> +
>> +	*route->path_rec_inbound = *path_rec;
>> +}
> 
> We are just ignoring these memory allocation failures??
> 
Inside "if" statement if kzalloc fails here then we don't set 
route->path_rec_inbound or outbound;

>>   static void cma_query_handler(int status, struct sa_path_rec *path_rec,
>> -			      void *context)
>> +			      int num_prs, void *context)
> 
> This param should be "unsigned int num_prs"

Ack

> 
>>   {
>>   	struct cma_work *work = context;
>>   	struct rdma_route *route;
>> +	int i;
>>   
>>   	route = &work->id->id.route;
>>   
>> -	if (!status) {
>> -		route->num_pri_alt_paths = 1;
>> -		*route->path_rec = *path_rec;
>> -	} else {
>> -		work->old_state = RDMA_CM_ROUTE_QUERY;
>> -		work->new_state = RDMA_CM_ADDR_RESOLVED;
>> -		work->event.event = RDMA_CM_EVENT_ROUTE_ERROR;
>> -		work->event.status = status;
>> -		pr_debug_ratelimited("RDMA CM: ROUTE_ERROR: failed to query path. status %d\n",
>> -				     status);
>> +	if (status)
>> +		goto fail;
>> +
>> +	for (i = 0; i < num_prs; i++) {
>> +		if (!path_rec[i].flags || (path_rec[i].flags & IB_PATH_GMP))
>> +			*route->path_rec = path_rec[i];
>> +		else if (path_rec[i].flags & IB_PATH_INBOUND)
>> +			route_set_path_rec_inbound(work, &path_rec[i]);
>> +		else if (path_rec[i].flags & IB_PATH_OUTBOUND)
>> +			route_set_path_rec_outbound(work, &path_rec[i]);
>> +	}
>> +	if (!route->path_rec) {
> 
> Why is this needed? The for loop above will have already oops'd.

Right, this "if" is no needed. We don't need to check if route->path_rec 
is valid in this function because it is allocated in cma_resolve_ib_route()

> 
>> +/**
>> + * ib_sa_pr_callback_multiple() - Parse path records then do callback.
>> + *
>> + * In a multiple-PR case the PRs are saved in "query->resp_pr_data"
>> + * (instead of"mad->data") and with "ib_path_rec_data" structure format,
>> + * so that rec->flags can be set to indicate the type of PR.
>> + * This is valid only in IB fabric.
>> + */
>> +static void ib_sa_pr_callback_multiple(struct ib_sa_path_query *query,
>> +				       int status, int num_prs,
>> +				       struct ib_path_rec_data *rec_data)
>> +{
>> +	struct sa_path_rec *rec;
>> +	int i;
>> +
>> +	rec = kvcalloc(num_prs, sizeof(*rec), GFP_KERNEL);
>> +	if (!rec) {
>> +		query->callback(-ENOMEM, NULL, 0, query->context);
>> +		return;
>> +	}
> 
> This all seems really wild, why are we allocating memory so many times
> on this path? Have ib_nl_process_good_resolve_rsp unpack the mad
> instead of storing the raw format
> 
> It would also be good to make resp_pr_data always valid so all these
> special paths don't need to exist.

The ib_sa_pr_callback_single() uses stack variable "rec" but 
ib_sa_pr_callback_multiple() uses malloc because there are multiple PRs.

ib_sa_path_rec_callback is also used by ib_post_send_mad(), which always 
have single PR and saved in mad->data, so always set resp_pr_data in 
netlink case is not enough.

> >> diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
>> index 81916039ee24..cdc7cafab572 100644
>> --- a/include/rdma/rdma_cm.h
>> +++ b/include/rdma/rdma_cm.h
>> @@ -49,9 +49,15 @@ struct rdma_addr {
>>   	struct rdma_dev_addr dev_addr;
>>   };
>>   
>> +#define RDMA_PRIMARY_PATH_MAX_REC_NUM 3
> 
> This is a strange place for this define, it should be in sa_query.c?

That's because path_rec, path_rec_inbound and path_rec_outbound are 
defined here, but yes it is only used in sa_query.c, so maybe better 
move it to there.

Thanks Jason.


