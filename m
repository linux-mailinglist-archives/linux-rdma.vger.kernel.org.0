Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9451D4227
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 02:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEOAhW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 20:37:22 -0400
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:50209
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbgEOAhV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 May 2020 20:37:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j745SQt+FKkgPyXZcjIQdkmEpUI+WaZZPAH1pLEOCh883VqNJ6CLfFB+uRvhVgaNR+Z+tsFHmPyU29GRzJfCprg5ozInqEShdV3Xl7nVU5mqnhDvX+ri/ydzLofA/hfDv7y+h552m4Oj7cy4TgK9L2ZJ6H3/uQFkYo5aUsJXP9QCXe4/x/+iLGn0lBoY7g6s50RuvFTGTiv6NgwoC7gtbdwBUsiin+npV8IAmtyidnRxejOAUOLMMDsXyRH2HKYXC+qGLpdw8ZcC/4bbnLX2SUOp2X0WNgTj6YgV7t6k+fmO9IFs0dnbzjCeNZXD6dHo9sU0DctMpEiy1EDcLUO5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd8+j570AfAQwSIOXDHSkFj4L0yalt9YJiVxrxXB8CM=;
 b=ChgsRheUpdAEC6+Gov+XczDPeQ0WEgR9UtbkDBJAkZQZXnB5iJYOucIGDuNUHBMuTHKJmjo5dyo+HikHTpRs++vZ7vyNGkbnXnq+mDTb4Qfugdv0T0qIV8Bb7EESooIfoR/ODc0xuOhpuMxDmvTxe0uPjDGC3/KoJZCDyGLCo7irPKD9j2v+0XsX2/n4a6zfeBIurR0uVxfgtWQatvddpSDLKLzXXdCN4XLQE+mV13zQhX9cOepJ/JlnGzKJc9u+ZZXjGM+YbhdP9SWqk7sKNk+iA2rK2Fte3kV5qu/P3gqvN0kq30RxPF49N43NoR1R1RNMjOkDC+N1wJ7voVlHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd8+j570AfAQwSIOXDHSkFj4L0yalt9YJiVxrxXB8CM=;
 b=XtZNaZX548CcibmtBVmHO1Qtng7OiNSwN5RyrsHztagYrQjD8+pJRUk59eA/IUKSooGfJySpPEE25f6p5SB3REugIshpETVG6ml6TxpZ0SlySLOeATOtcjQodLze+m0y55cG4ue9SXHEnNDsxWLIXJapc8N5Zg11WmQ+Wp5Uc9Y=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5905.eurprd05.prod.outlook.com (2603:10a6:208:131::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 00:37:15 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 00:37:15 +0000
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Sagi Grimberg <sagi@grimberg.me>, santosh.shilimkar@oracle.com,
        Aron Silverton <aron.silverton@oracle.com>
Cc:     bvanassche@acm.org, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
 <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
 <479add48-6fdb-f925-c3b9-699c6aa4cfbf@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <1bd4bf77-b97b-3c6f-ce3a-4d5fc428f454@mellanox.com>
Date:   Fri, 15 May 2020 03:37:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <479add48-6fdb-f925-c3b9-699c6aa4cfbf@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0302CA0029.eurprd03.prod.outlook.com
 (2603:10a6:205:2::42) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM4PR0302CA0029.eurprd03.prod.outlook.com (2603:10a6:205:2::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Fri, 15 May 2020 00:37:14 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8a44c7d-8bfd-4c7a-49bd-08d7f8681da2
X-MS-TrafficTypeDiagnostic: AM0PR05MB5905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB59058C6AE7C53867124012DAB6BD0@AM0PR05MB5905.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hESl4Y0c7BpM+kxuXDb2oWe/hQJiLxCffPdqtXQFWLBY2R7UQYnovA/Vc/oLqDAk4O2HL4aXOYxyC15raDHd8ET4x7o7Nvh1auva6IiQ+vWXwoDAH+cU0+cbCw1qDNSe2EENVY0HP2fJaHJJ3kjY/Tk4F+j/LfMQ0oiJ4g9j/vCro9qOx0lY121svLCzO9n3PpUWQaMk3tR1aoj7pKpZ8jRzQkRwYFsbKYvSqUtq+r95pK1jv2bYAtUwmHvRrRowS7lrUaxmt0r5T7O8hmblmXlvlLGwZvnw7H7Elybd4vpygTbTqEeNjJlW9EqSqf4GtSa5d9erXw0qM29l0dWzkipzPq2cht6a88AJyqxZjCPkxW5SdiZ7UJ943Gu4FnxGH/0nPbromGcdpZ5aONA5opG4nddZYBsZNTLa1L04irmcR1XAxGH3lLVeQFYyYpYeMxuLREoXquTf5mn8rjnFEVQlvYWOIKycqwHOkutQSZ5bAjUqIdCjmwTTAsqXfbUb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(53546011)(16526019)(186003)(16576012)(316002)(5660300002)(107886003)(26005)(66946007)(2616005)(66556008)(66476007)(956004)(2906002)(6666004)(8936002)(6486002)(31686004)(52116002)(36756003)(86362001)(31696002)(110136005)(8676002)(4326008)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fqsj8kEdj3Ehi1H3ZtPZj05TzuXKtPdyiM3+nDcUgsYWPxeDYR2olb7NJ54NuYnUxkKJvkWpM6PeQ2j4l0AlO407WrrYYjXDc1uV35TqqVP76ugcv3/NFgZVIZq37xJwDAt1oPYwqJcu01vztrR53TnoljqgQcGlooh+shXLnIi7sQ8Vj4VnfP7ArdqPX7c+iT3CzBvU61uoRQ7eNKqU8xvcqmmNnpDizkPdDVSk2/VEVVEWriiqUG3fM2+rH5wc0NCiCIuTG41QEsgHaD6fmbKdwMmGlYyS/fbnav5jp67HvkVwFQSz2nMBKy4EKx9A3rg8+3nflOrgOFl+y0pULWgcMQE/Nri/N+CI5eexDk3xghzgETxOqikaqv9TOW2PBh523tJadbdVDkQi0dppeC9ujVght3l6xeETClDn5PYUj1WRF231NxH1u2OLKty6j9FVYv6wfOwDVOAYWZGCGvLOnTxF0LVoKDGKC1tpeAOmja+Ov4Iow8aCHI05pmjK
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a44c7d-8bfd-4c7a-49bd-08d7f8681da2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 00:37:15.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN+l1qgq7EdgVqAJqayLgtI0eorpw3OPvAs0WBZhGI8hHVZH6dI/iWV/ol1YIoI7CrDXGZBTWPm3z5Nn2kdbAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5905
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/15/2020 1:23 AM, Sagi Grimberg wrote:
>
>>> +Santosh
>>>
>>> You probably meant to copy the RDS maintainer? Not sure if this 
>>> should have
>>> also been sent to netdev@vger.kernel.org.
>>>
>> Thanks Aron.
>>
>>>
>>>> On May 14, 2020, at 7:02 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>>>
>>>> This series removes the support for FMR mode to register memory. 
>>>> This ancient
>>>> mode is unsafe and not maintained/tested in the last few years. It 
>>>> also doesn't
>>>> have any reasonable advantage over other memory registration 
>>>> methods such as
>>>> FRWR (that is implemented in all the recent RDMA adapters). This 
>>>> series should
>>>> be reviewed and approved by the maintainer of the effected drivers 
>>>> and I
>>>> suggest to test it as well.
>>>>
>> I know the security issue has been brought up before and this plan of 
>> removal of FMR support was on the cards
>
> Actually, what is unsafe is not necessarily fmrs, but rather the
> fmr_pool interface. So Max, you can keep fmr if rds wants it, but
> we can get rid of fmr pools.
>
>> but on RDS at least on CX3 we
>> got more throughput with FMR vs FRWR. And the reasons are well
>> understood as well why its the case.
>
> Looking at the rds code, it seems that rds doesn't do any fast
> registration at all, rkeys are long lived and are only invalidated (or
> unmaped) when need recycling or when a socket is torn down...
>
> So I'm not clear exactly about the model here, but seems to me
> its almost like rds needs something like phys_mr, which is static for
> all of its lifetime. It seems that fmrs just create a hassle for
> rds, unless I'm missing something...
>
> Having said that, it surely isn't the most secure behavior...
> At least its not the global dma rkey...
>
>> Is it possible to keep core support still around so that HCA's which
>> supports FMR, ULPs can still can leverage it if they want.
>>  From RDS perspective, if the HCA like CX3 doesn't support both modes,
>> code prefers FMR vs FRWR and hence the question.
>
> Max can start by removing fmr_pools, fmrs can stay as there is nothing
> fundamentally wrong with them. And apparently there are still users.

Ok we can start with this.

Please review patches 5, 6, 7 that are stand alone.

And I'll send a V2 for SRP/ISER/FMR_pool only.

