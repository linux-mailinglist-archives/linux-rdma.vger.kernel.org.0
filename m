Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E27F1C9D8E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 23:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgEGVk1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 17:40:27 -0400
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:65121
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbgEGVk0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 17:40:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scv5FnDfuQECC4Ez/7KIJd+PAsiLmXnmqN2udsBAX03bAhjbgnLYMRTNlXfTIcBav5QV537Bd329nXPWS/uZ70bqQ6G3jk62q092grAB2///yT2RXB3JljMdZXO1YQKTCKISVkCwXWKp54VIt/l38uL/r0jqfSBKLECklI9CkS37oji/jSUd6OlBS3R+/Euzoy8K5a6xDJ3QwithZMUZdYLjzaoFtbc+TLTvXVH5ZIIziKavOQzOjTmjMH7wJW0tXy23PofMYZ2gTFJE74hWOk/9txO0fRdsXFUJXjBeZ42ARD14hBbO6lSWe8PUKpFavw8Y+1jI11Y8IFivqE/BlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yun1YcQ5cLj4lSV8n4g0ZQ9usupNhm311sCTmwamL+s=;
 b=MrBx52e5zMnjJ9/yY6YoeH3PGDQ1Ueijfcgy0ov53oQGA8AcKo7GJxILWGR3VrH0DIEawXTZY4ylgyG4qOaQ6Za8FRi3gwWhs10GM0EDE5MKp9D4FrE17lOYrs0pIiYIIxUS7yib3yK4f/1EFxTuOjCrRQ8P/FR4Bym2x1dYBc4m0I4EhxSuhahNDPfNWVI5igYZ6Igd/TKg77S8HiiMCy1A/lF6xiX9KRJsgjuEo9w4zUICt0J7mP6EAW50ZekjZzuapEP6eVFemSMfekyj7l/mGv3qLlEw28kAp4m1jCa1q2PBG/xpbjVkXG5vKTLCoFzn2W+4TFMnswnVzi0uMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yun1YcQ5cLj4lSV8n4g0ZQ9usupNhm311sCTmwamL+s=;
 b=Y1cF6TJN8w/28ekENU+GqN0bBD1sKns7+3SwKC5/lieIFRTAZTVUcQWE6l2Xbng50nO37E2HZ1TbHixARxnxMxkOiq2cGd4DzG51Iyd8BOP1CeNioXkoLBeFVTi0gw+5tHiGq0MNFI1ruJEZnqPYwb5xF4cVDuDR9lSUi5cCabM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (2603:10a6:802:1d::15)
 by VI1PR05MB4317.eurprd05.prod.outlook.com (2603:10a6:803:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 21:40:22 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4d4d:706b:9679:b414]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4d4d:706b:9679:b414%5]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 21:40:22 +0000
Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
To:     "Wan, Kaike" <kaike.wan@intel.com>,
        Divya Indi <divya.indi@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
 <7572e503-312c-26a8-c8c2-05515f1c4f84@mellanox.com>
 <MW3PR11MB4665120FE43314C22A862324F4A50@MW3PR11MB4665.namprd11.prod.outlook.com>
From:   Mark Bloch <markb@mellanox.com>
Message-ID: <b387f32b-c990-614b-c631-b38ddf821757@mellanox.com>
Date:   Thu, 7 May 2020 14:40:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <MW3PR11MB4665120FE43314C22A862324F4A50@MW3PR11MB4665.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To VI1PR05MB3342.eurprd05.prod.outlook.com
 (2603:10a6:802:1d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.33] (104.156.100.52) by BYAPR06CA0057.namprd06.prod.outlook.com (2603:10b6:a03:14b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 21:40:19 +0000
X-Originating-IP: [104.156.100.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4dada75f-da15-4084-514f-08d7f2cf3e70
X-MS-TrafficTypeDiagnostic: VI1PR05MB4317:
X-Microsoft-Antispam-PRVS: <VI1PR05MB431747FFCBB2DD18DD2AF74BD2A50@VI1PR05MB4317.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZEjLW7gzPYVHPlBtWldSezQpiVZ3sM7LEkp2BSW0RhbCthRJ5FSD8p5VHTFyjY3+dTFAFxo9c/8+pbhoWd6edE18B+Z1FptKMjjxEWXYmTlL/YTJFjadr6XpQl9SD3Ggn4hVYIh2cigwQ0qf24A0NkgfFQ0xqJASrfRjtz4iBnU7V6eqgq2xpwQLPhJ8i45b5CD0SGxaqdqDKh0LPFgcUQggDKrV+w1kR5aQLwkkQ0p2Z5NPfgQ92sv1Vp3i+b2pVaegmOAuSXUIgfye2y/E3+0JsQQ9EdmQY4MR+ftNPlWPL/JuxxoaKF2fGMP6HorO+KMqlMIKMJ0pRZomgMT0RXFm+47Drs171HGHUqQwmb1MndNnV4ULYC0NW2rpL8HQM/4HJrAm8YX47aJYBqPV8+h2gBr2EbCZCZT03ew3yG99nGVNyKm/Q3lCP+gJM4ktZoXysj33OJt2T4f/iMtWs1W8tTKohfSP0mFoS7TetxViDyFcuCZ8fqrT5rw5Xf64mq+c2V4oCyHuCEjuPZMwaxRGOVWzK/tCPPdX8G7IJQlYqyQA9stjGRgYSL0SqO+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB3342.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(33430700001)(956004)(2616005)(53546011)(4326008)(26005)(52116002)(66476007)(66556008)(66946007)(6666004)(2906002)(36756003)(31696002)(31686004)(110136005)(6486002)(33440700001)(5660300002)(86362001)(7416002)(8676002)(8936002)(16576012)(54906003)(186003)(83320400001)(16526019)(83280400001)(83310400001)(83290400001)(66574014)(83300400001)(316002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ev2INBaz/+w3sjGjE45i14OPJ3ObZckB65jE5VOUR0u0+phoW7BSRe6Vrw3o9pE+XkqtSgQQH186LIj0pLb9VwUx1drLdUNoo2QBOE1bXzBxfXzFAF1u2IhQeIn3dklrqMTf0iTRgX6nFDJ/ay8b4sIfNe6YhXPyGVpdAw4jsLKWA0xo7D29a6FeZnvu0PuRnOfMDZD5JOO817l6iFvf6OxmtScMNARNX7U1jcgBTDf/bfvWWaljIYzGfEEh5XgmZG0fs+9tACvA+fpHiH9d8CLNAUw6Z32biG2pzs0uwlDuzaxb+CkerIPfRzKe/2ge43Y3/OCEOUn7E771qk+LydEPf+xpNwOKpdRyX7Xj4vB+Gpq2trVIU+9j1vUUtwKse3uZWO7t5AJaBWuhuso05pSrn6lhMFThQbjIuE1i/xMZAG7v6XbnwmX4S3ctUx6Quw8dQSCaYWePXn+yVrU+J909xGULnaEtKQJ6aOKpvsmdW1PRzP/NZ0EtuLI+/6GaYrBs+OkTlWvoPkpUQFX7/Dl2etcKHfPuTwUC2yoIWLyJPcUoVBwoDkczPpJ8h7xZ9I5MsppqDyCZT54epkflzMSVYmtC4ColS5Wv2cMTpAqsdAdX0g46fcgYV3bnS4g7YjQlFU7JI7nrW4pJbgVevDp3UjyfPhZG5K0N86QgeA4mwUYUiyP+i3V78hUQacKwAlsgrYcNUjTU0r61nAuAz6R3IY78BwLF4Rghp/x0J1NtfFjisIVXWqbDPfhop4cxX3zsUtMPGsQVs3hHH6Zx4Mgtdq9wzpz9C8iBMWJwG04=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dada75f-da15-4084-514f-08d7f2cf3e70
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 21:40:21.9172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTd1Dfh7IYtLEaVCjFCN39FMuBCOFpeOWX9HLKA3KimZzqY/ZEmx5iqFyhTJXZyQtnfEF8wUoBXBIV5AjI7w7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4317
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/7/2020 13:16, Wan, Kaike wrote:
> 
> 
>> -----Original Message-----
>> From: Mark Bloch <markb@mellanox.com>
>> Sent: Thursday, May 07, 2020 3:36 PM
>> To: Divya Indi <divya.indi@oracle.com>; linux-kernel@vger.kernel.org; linux-
>> rdma@vger.kernel.org; Jason Gunthorpe <jgg@ziepe.ca>; Wan, Kaike
>> <kaike.wan@intel.com>
>> Cc: Gerd Rausch <gerd.rausch@oracle.com>; Håkon Bugge
>> <haakon.bugge@oracle.com>; Srinivas Eeda <srinivas.eeda@oracle.com>;
>> Rama Nichanamatlu <rama.nichanamatlu@oracle.com>; Doug Ledford
>> <dledford@redhat.com>
>> Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
>>
>>
>>> @@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff
>>> *skb,
>>>
>>>  	send_buf = query->mad_buf;
>>>
>>> +	/*
>>> +	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
>>> +	 * processing this query. If flag is not set, query can be accessed in
>>> +	 * another context while setting the flag and processing the query
>> will
>>> +	 * eventually release it causing a possible use-after-free.
>>> +	 */
>>> +	if (unlikely(!ib_sa_nl_query_sent(query))) {
>>
>> Can't there be a race here where you check the flag (it isn't set) and before
>> you call wait_event() the flag is set and wake_up() is called which means you
>> will wait here forever?
> 
> Should wait_event() catch that? That is,  if the flag is not set, wait_event() will sleep until the flag is set.
> 
>  or worse, a timeout will happen the query will be
>> freed and them some other query will call wake_up() and we have again a
>> use-after-free.
> 
> The request has been deleted from the request list by this time and therefore the timeout should have no impact here.
> 
> 
>>
>>> +		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>>> +		wait_event(wait_queue, ib_sa_nl_query_sent(query));
>>
>> What if there are two queries sent to userspace, shouldn't you check and
>> make sure you got woken up by the right one setting the flag?
> 
> The wait_event() is conditioned on the specific query (ib_sa_nl_query_sent(query)), not on the wait_queue itself.

Right, missed that this macro is expends into some inline code.

Looking at the code a little more, I think this also fixes another issue.
Lets say ib_nl_send_msg() returns an error but before we do the list_del() in
ib_nl_make_request() there is also a timeout, so in ib_nl_request_timeout()
we will do list_del() and then another one list_del() will be done in ib_nl_make_request().

> 
>>
>> Other than that, the entire solution makes it very complicated to reason with
>> (flags set/checked without locking etc) maybe we should just revert and fix it
>> the other way?
> 
> The flag could certainly be set under the lock, which may reduce complications.

Anything that can help here with this.
For me in ib_nl_make_request() the comment should also explain that not only ib_nl_handle_resolve_resp()
is waiting for the flag to be set but also ib_nl_request_timeout() and that a timeout can't happen
before the flag is set.

Mark
 
> 
> Kaike
> 
