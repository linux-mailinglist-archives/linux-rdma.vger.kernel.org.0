Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4C5344E0F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 19:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhCVSDh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 14:03:37 -0400
Received: from mail-dm6nam08on2068.outbound.protection.outlook.com ([40.107.102.68]:40673
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230368AbhCVSD1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 14:03:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAEoP8qYiti+UsZFh7p3V5Hk0MDhR20aH1AN6KjmbwOwW6hnW25H/sRkEzAPk0f5KzIQVn8naw7UkC2NJlKMZ4e/NYJ6dGBtApgAZI0L5Es4QaSOUdD4gom2xxkYKZHKz3Nj5vw4tHvfAb32jljQmoNQb9qFa+btp2VQTZL17PibP3s6Zpqiz1TVycv9o8aiHdODv/3rpaeZV/LxTkOMKXf2WZYobxDX9NEYsl+WlGP/dGPEOGXS9yLySZ4Rt+mSaEPzKGi/iDJjaTL5ZlVdkuLlZwXDHmOqXn9+624aJaymo4S1i6Wh/h15KsBCikM5wD5Rilzy+WeTzri/XPu4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFsZpd8t/9vaeHWd9jHrKrlSOWzdT9LUf3+DYFARB98=;
 b=M3qo4J6BFyN2MBMSXsY2FdHSX51N/XfiPPD5Ncsnxy+/7lsYpJpfeVKbt5gb6z+tlRsH9bNVjSiFSrYeOn8TnV+rFKkwwDuV90Aq/Jp3CA/B5RMjV74KBLFnOPmIeRb65Cx1ipXr3fvrrS7RqOEvkRAj8WnxKIUUvbmnD5v6E2QiHbz68rvzQPt2kiH+SYg33yDXMWApYZHCpuM+dPq7LslaERZm5JvI7FMTjn5aZRpBJ/rGN8eY/sdATcBnhZBxmOOpHXr0vzc8MMsxEC++eKdDVx3r5DZ3kMID3LJxLHrsZ9+fZOoP+Oq57Fqw5043Lrond62c4LIjD/35f/vGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFsZpd8t/9vaeHWd9jHrKrlSOWzdT9LUf3+DYFARB98=;
 b=hIDzfjSS05BBsDUbFWjjxHwH7I0D5S8TnnYBhmuSkURnwcKENMy475d7uZOQ+rKV6rE72Mz/goPltmY0CFoF60+I6n6GcwhfyGBcnssoTWDJSjjSs7klECpYBTwvLStOAYuZx7AgLQzjk5Ur+jwzkXF9tqzn0bgbYt/yP++6o2Q=
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=vmware.com;
Received: from BY5PR05MB7155.namprd05.prod.outlook.com (2603:10b6:a03:1bf::24)
 by SJ0PR05MB7471.namprd05.prod.outlook.com (2603:10b6:a03:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.16; Mon, 22 Mar
 2021 18:03:21 +0000
Received: from BY5PR05MB7155.namprd05.prod.outlook.com
 ([fe80::8c33:8eab:566:f63a]) by BY5PR05MB7155.namprd05.prod.outlook.com
 ([fe80::8c33:8eab:566:f63a%5]) with mapi id 15.20.3977.022; Mon, 22 Mar 2021
 18:03:21 +0000
Subject: Re: [PATCH rdma-next 0/2] Spring cleanup
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
References: <20210314133908.291945-1-leon@kernel.org>
 <20210322130012.GA247894@nvidia.com> <YFil0nfFgSSh0mXb@unreal>
From:   Adit Ranadive <aditr@vmware.com>
Message-ID: <5dc500be-3f7a-574c-8b40-c16de5dcc203@vmware.com>
Date:   Mon, 22 Mar 2021 11:03:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YFil0nfFgSSh0mXb@unreal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [71.204.167.113]
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To BY5PR05MB7155.namprd05.prod.outlook.com
 (2603:10b6:a03:1bf::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aditr-a02.vmware.com (71.204.167.113) by SJ0PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:33f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Mon, 22 Mar 2021 18:03:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68d413b9-40c3-4b13-42e3-08d8ed5cc73a
X-MS-TrafficTypeDiagnostic: SJ0PR05MB7471:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR05MB7471427DFD7F19200E0FD1E2C5659@SJ0PR05MB7471.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SrJvCh5/ngYb3MNzCj7LOL5ovLi+ysRgVKZOdvcX5eOzDSnPHAV3yaVB6X3RsRHSJWFhc5ZRVL99c4rqPQ08/LWa5tCNwVsGyEFUwTiJ6hXz5a9rlZwPZRsA4vv1wh/yISweLfIW/euoSpV4ad9n/wF5HSW/oYUswwe6LUwHymA6LTbiPOIIvBl7P53M4uRshg/nryFMFqzOrqDVrzuT7q9Xgh5ZmY7zJ9rQODDlpNGU5zF38WT3X+Jzo/jhy+51Nh9eUgQZ5l/so9ZHEKgbS0j/8tgSlJSb4aniVrcUYB2L7kCabBU7vw6IhV+6McWivdlj32ACgRridi/ujOFtvWwf51RjLntWlA+z4Yem14RQoPif8dS/6ERkj6i6yQRtuDeHTpQv3yywX+10ZoxGA87to2gG8+Q7JMdLFIbjgb3YnGRahlML7+QKArdMkCrDLnwoaphYHRqGwDOBJ1ZHf81yCp07vlXOTU2q3lninM0TLm7qhmVrXfWTxxI2PuePVYIQRxg8VizzyCOKqJ9kvoldql7AqRIKa8As348eTgwikAM2Z2h9sspMEDonny6baasl8mWt4qaT38tDRaUIzmQjw5Xvl+HQyZ6365hv/InYccGVX7I6TqDx8UwgspvkOdKt9R3/AToktlK2U06aHSYepaw65i7c0gGeAsMOs6QQzdahC+CLFyizs/2MJxsusGi6Emm0/Po46ClSWEcNDnFtseA7d2jNB5C/f9UY8q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR05MB7155.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(66556008)(86362001)(316002)(7416002)(38100700001)(31696002)(66476007)(478600001)(2906002)(36756003)(110136005)(4326008)(54906003)(7696005)(26005)(186003)(16526019)(4744005)(6486002)(8676002)(956004)(83380400001)(5660300002)(53546011)(31686004)(107886003)(66946007)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QXQ3UzFhWmRqMlh5eVVEK1QxYklLbDlPdlVlaUZtd1AycXBCYStHaCtGNmlE?=
 =?utf-8?B?dVdQZXZraURBekwrQWZGeTVHZkFaL21wVXpzckJmakZJZXVJaGVTT2ZNRFJ2?=
 =?utf-8?B?Z2tTSjlmakhlZ0RjR01BeW9CVEJOUUZyMDdzWGJLdk1LWUwvM0kwS0Z6eGNH?=
 =?utf-8?B?VHhha1FmZExETzhBY2Q5MUM4WUtpVjZ6dEduSGxJYmt3TTVoUTFtUkJjeVVH?=
 =?utf-8?B?MThEZHk2NE5SSVVJcy9RbzNDbFJDL2l4Y1krUmpPV2o1ZGVrNjdENHBsZWxs?=
 =?utf-8?B?UnYvTEoxRDFLKzZBTVpYc3llSmdCSFlDMXc4bERPL1cxSkU2eGEwd29tS2VC?=
 =?utf-8?B?WFNqL1BDVlBuOStmbjNPS3pTOUdNU0Z0NkxwSHJpajRwTVI3eHhsNXZMVDI1?=
 =?utf-8?B?cVZkaEIxaFFXck0vSzNobmx2VTdEOWx3QWFqUHdyajJzRXB4aHViWlE4UXlV?=
 =?utf-8?B?WXZGaldDeXpxcmVWK1dtanQ0MVVsTXlJREpqZG5HSmplMEhsSUVSWnowR0cw?=
 =?utf-8?B?UUEvWXJTbDVxS0kzNjF1NW05eElsZlJOc3RCTzJsN1FDL2FXdWZrR3FZeFh1?=
 =?utf-8?B?dlRlL2M0ZkZNemdoRi9vKzVmWk13aUZ0ZGdYWk1YZE5UK0R0NVNHdU40ejdZ?=
 =?utf-8?B?WXhJZHlmU2tJemxXckpHa2xNK0lzRkIxUDJtMjh4enRRWFRzU3NiOS83eDQr?=
 =?utf-8?B?NUdSV3d5eXcxRjhYalMvSEZpRmZZUjRpeStvK0N3SFpYMVhzbm9MY3krTGFj?=
 =?utf-8?B?OExQQjNMYlRUNko5N2JFcldZc3FwekZRSldSdGNIMGNQRGJWamNXNldTS0Ix?=
 =?utf-8?B?WDNSYlhDV1kwcXpKdUYveFRvUW5OelpOU2ttd0Exd0RkcHhkRUdmQU1aZVZ0?=
 =?utf-8?B?NDdpWjU3S0xUT2pzZ1BxblVSYTJhZTBpalhHS2paQ0Q3WFV5RjAxb3d5Wmlo?=
 =?utf-8?B?QVltSXNFMTVURmNjbVNmVm54Nms2ZGoyMFhBZkpDU2JGK3UwK21TbVJjKyto?=
 =?utf-8?B?cGY0S1NlWHh0OFBVQVdYV04rRksvQ0lpWEN2dDdUVzhEb1M4Q0wyaW5zVGc4?=
 =?utf-8?B?dE93VVY3dHg0ZzZYR2s5cFl5VW5OaWlUK1NoWngvRG9ZL1djbVZ3NC8wbDVG?=
 =?utf-8?B?UE1pZzlCLy81ZmtJcWxRMzh4RmQvalU5emJCNlZ2SndBb25sSVp5bWh4WnJ3?=
 =?utf-8?B?Zi84TFZqNE9mSkszeC8zTGU1WEh6bEU5UzN6cDhyVzY2eDRGbjBLcEh5S1B5?=
 =?utf-8?B?M2k5TDFrZHN4SG02NytPNFozY0tkOXBkM3ZCSHNpTTdBWUJQZFBpS2F3dW44?=
 =?utf-8?B?UnJFdEN0cEJUMEFaMUt5cUEzb0pUMlNaTUUyQ1ZTdjNERHVUaytTMHMwVWZ2?=
 =?utf-8?B?c2ZBZFdrcVk5czNVV3FWeTZReVR5VTBabHlORTNsZ3hqYWRGcHVCM1h5QVI2?=
 =?utf-8?B?dUFoYXU5ajhZcWUyallXb0Y0eStxMCtrZnViUXEzeUhIdFdvYlVRMEhyaHdP?=
 =?utf-8?B?SkdnYis3OFdrSFpuZTJwYkpNVmZmSnlTOHB5VFlMdVlGaldMRTJqRHdnNkFo?=
 =?utf-8?B?M3AzRE16blE4a1RjOUFoeGFOYWNvUXNwdXN6S3N1SnpLNTZ3Z3Vvdm51QW52?=
 =?utf-8?B?dGlZS3FSZUgwY1NWMThETFVmMzJUbWYxdkt5TmpodHJRQW5lUUdRZm8wQnFs?=
 =?utf-8?B?M0FBQ28xOFFNUjFUQUYyN1JRLzhWSllGdG1zSitUbzk3Y1Bpa2l5STkxS0t0?=
 =?utf-8?Q?JMdjSiMpMzjE38/XidtDHYABJFQWqi2zpgyF/pK?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d413b9-40c3-4b13-42e3-08d8ed5cc73a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR05MB7155.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 18:03:21.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vHDMfkf/a59RRONdpzOaeVX8UhyVpUjztxA9o/k6UqIASlnJLwrpXa1aaPrOrOdBOJoZeGL5b48Qpbkf6qYjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7471
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/22/21 7:12 AM, Leon Romanovsky wrote:
> On Mon, Mar 22, 2021 at 10:00:12AM -0300, Jason Gunthorpe wrote:
>> On Sun, Mar 14, 2021 at 03:39:06PM +0200, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> Bunch of cleanup in RDMA subsystem.
>>>
>>> Leon Romanovsky (2):
>>>   RDMA: Fix kernel-doc compilation warnings
>>>   RDMA: Delete not-used static inline functions
>> Applied to for-next
>>
>> How did you find the unused static inline functions?
> Accidentally spotted such in pvrdma and later wrote one liner to create
> me a list of functions to delete.

Thanks for removing these.

> Thanks
>
>> Thanks,
>> Jason

