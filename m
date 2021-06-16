Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67453A9449
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 09:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhFPHpO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 03:45:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42170 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231225AbhFPHpN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 03:45:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G7Rm63007068;
        Wed, 16 Jun 2021 07:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4vE7tKzALcSHHyZNql0Hw8OT86WravTeZqVxZBFBIFY=;
 b=V1TtQpFR7sB0XdCJzXSUQ/8zbD2XCXKHFvFPP+Mc2Hi5oMmC+MXv/O1UAuyY/w3kuefl
 1AL5GMt0vLYcP8w2aWMIPTSWsPmJOmn6hoVwXJZGszhythXERKIS/N28FAWMzdWsYqsS
 GWxNitSm2291z36jRcU8byWEXcoO5MalH8CbZrLnmHaNsVHdsCxsY9zSt8ozvWKkDI6A
 08DS/E6262gl+Cloqm7kpWPr4GaKkJ7Zvw8f2paDL798vUmJxLRqA6qQdZ5aitbTSVui
 VzJBMFqUapqbrmT2G0YcaXzmJiJLpY9QoKv/IznYTj9w+LnSTaKYV74WdckCs3iY1xEl Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 395x9qt4cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 07:43:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15G7PVCV148047;
        Wed, 16 Jun 2021 07:43:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3020.oracle.com with ESMTP id 396wavyrsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 07:43:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq6iTexgcglEyqzTiPqkS2vgT/z1i03fsE2jCHdK+ohxB6CNka3VbTPUQBg3RAGTAZETQf66KaDSzOUaOvNW6qDr5exdoIweByfTjF0r3qEfRx0B3xrVzA8ardya5iaGBfS4IH3RFKT21aXLDBxamYoxPZxao9BDfSoNYTQYPVJZcmxQJ5iO6R/uC3OA1vULPJ3hOTnQNLTnldrzKDjZo7N3Jo2Xd3k0SOUxVqQ4EbvM9DIHHcH8yVAjbGMAWk9bwVWdqfGXj55ShxpJ/zOoORzakzmEDck23EAHIW6HyDtuZW3aQvJy96ICzg7z6E1CPPqNQdCpL9gHC3+DpPCd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vE7tKzALcSHHyZNql0Hw8OT86WravTeZqVxZBFBIFY=;
 b=cV6WpaWxDcNVjuP51WMEQkFWvR/vic9BehVMEsc5HHGwc1WOUrW7iRcdSGUzPsn3iIGWNuxmyT32bliIwU3r+mNU2KI3v7hNRnIlr9j/NL2N30aFTA7LfEFyvi4GjZgjkMlWLWzxdgUkqHe8ji7NS2vSB4Lw1O66t0PaYHXsFTkUJraBRG+o2luEc28MWlCIqaGjHYILpg2dCanE43nogSdkJZJybQ5kk8q7HE/DOa+uf5DxA3JnnKAnUo9/QfVXdof6mro3qiM8yGGyo65tJW2fntz8blEKAMHqp+sScOdKvP3Q/VVxMe58Ts45ip4O2C9ILruX5dw2HPzHJeDesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vE7tKzALcSHHyZNql0Hw8OT86WravTeZqVxZBFBIFY=;
 b=dfjt/IyC5MMJSbiYGsScPUu1DYdRZ0cQFWE9sSMD6+tnJzRvnhKtubqFig+Dm6FFnubk3XuyQcxD7miR6Wmgpp9y9zVUEqTfzw0G7VT/ljnQxmJVrZ/mZoy2MDEiPwGhkChu8XECki0DRb4yAL46Fm0UDKGrinC+q8XAk4/XhEg=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM5PR10MB1818.namprd10.prod.outlook.com (2603:10b6:3:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 07:43:01 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 07:43:01 +0000
Subject: Re: [PATCH v4 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
References: <20210616065213.987-1-anand.a.khoje@oracle.com>
 <20210616065213.987-4-anand.a.khoje@oracle.com> <YMmnyE+rpLIf6e0B@unreal>
From:   Anand Khoje <anand.a.khoje@oracle.com>
Organization: Oracle Corporation
Message-ID: <ac8da9cf-9dec-a207-c80e-e9ee650b40fc@oracle.com>
Date:   Wed, 16 Jun 2021 13:12:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMmnyE+rpLIf6e0B@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [182.70.80.33]
X-ClientProxiedBy: TYAPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:404::33)
 To DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.8] (182.70.80.33) by TYAPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:404::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 07:42:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aeeb778-f327-4404-3ed3-08d9309a5e20
X-MS-TrafficTypeDiagnostic: DM5PR10MB1818:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB1818A4AE625B6DB70E89B089C50F9@DM5PR10MB1818.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkxs6I9eFdmXMxZB6+ABUBLLo34jpcCaKAQVrmkfK5tlzHrbcWrdXF6Fl7dVLX/7EFYQhxjaZevfJ9i51o8yKq684gpY7ugsx6pgtDkX/7PDQF/51Zu56UcH6w5VqQh5cUYtL8dg7iBrRFVZfq+WKrPn9BCymro8Q4u7peka+srH1KHrJEjwgPemJphSstNbOcEalOAnAeXMg3x2iYDyOqShC6k4XArOWF4qROj+7q/592kxOlVCt38a/8VFzGddaUIKJqLL0lAm2n6e7Dy2Ca2xHM3miYloyBTAxmovQUaVkdZNFRh7U7T8wBnzHmmYfG31M5MZKLN3iyWLbbV3UyElajG6s3o00jMFD4fvGkpQCALZUI+YAMhGVuVa9TQ09NwPYITXLjSa3R6ecPMiI0PryNvFs/92WpqZyC5Oz2ihGCdEW+biWxmgdq5BCCenJuPXeeb9a8RaccMnfUGBxPHxqMSGo8BjzDCEf32gSerkNyGJC1ty0I4sgChwV3CmEJJQ3c3GHAfJrrMAA+bElSjHMKOOMuBhsKv8EomuE4a7qxTUKwIKcPuEndwgkRFDiGgumPSciPjuIOi0WFUXXMH/IkC43geejE1/zN+/+TKu22Z+aaEh/UQ7QWLISotygyEDVYvp/1UU9E64hZ6Yl/OiL2CQoeUIaRcOTMcRcEzbWv3njEnyVAsQl15CnLCU+EcrRHGEy/2ygbb3At3fyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6916009)(6666004)(107886003)(36916002)(53546011)(66476007)(6486002)(31686004)(66556008)(4326008)(5660300002)(956004)(2616005)(66946007)(478600001)(2906002)(316002)(16576012)(8936002)(8676002)(31696002)(26005)(38100700002)(16526019)(186003)(86362001)(83380400001)(36756003)(120606002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVZmZFJjaEFIdkIyS2tjRDJndTEwdjVseTFkZm9KWUlFVmUvUTcvbzRENkMr?=
 =?utf-8?B?dThvaC81UmQyT0FKOGg4dlNNdm5oNGZxVzI1elJ4dDlBWjdLSFgzczdDWTFO?=
 =?utf-8?B?Q092ZDNZS1VxMEJMdzY5WDZ5VStBSVZKemJxL210dEtwRWlNdFZKNGp5YjF1?=
 =?utf-8?B?S080Y1JBeGxscTA0U2NlVytySVgvT3JkcWV3T0lxajBIZStVbmNSZTBsamF4?=
 =?utf-8?B?NHBua21KRjhGTHlSd0x2NXFRZDdXQzlYQi9mc3grTW9NeGEyTXQ3dVo4OU1O?=
 =?utf-8?B?aDBNTW0vM0l3WTc4Mm13UENqdnVLSVdOL1Y2SzdVd2tvMzcwUGJkZ1Q5cjlp?=
 =?utf-8?B?NDUwcEFlcHhpbEJSL0E5QlMrc0JwcEVpQVYzU0VPN2FVUlY5N1hHSEFkRlFp?=
 =?utf-8?B?NVZVaEZjemMwRXpnMzVSbEV3VmFWUWZLak9EYXg5d0RBYWl6TW5YcUsvcTly?=
 =?utf-8?B?QmNiQmFEOUdiRCtidGlGZDRVaS9ia0FCMFpvM3N1bVpKMCtPQlpGWENzR0Zl?=
 =?utf-8?B?dVhvM3JhTnBXY3ZUaDRnUFViWEo2TTQ1SjhqV1h0LzZiVDE1MWtURkg4VEFO?=
 =?utf-8?B?NWRNdEh3N0IrUUZHb3ovR3R6TjhZYnJjMElod3kwQkxvWlJlaGlvaExmeEdm?=
 =?utf-8?B?V05BQlVRK1dOMEE1S0NNWmhSQ2wyeGVEYmpvMEltZEg5MUpzeFpENkFhRmF3?=
 =?utf-8?B?aFpMeC9ydk4yZDYxQXlQU0x1WWltSXJIUmdrL1FGZVhjS1N5dEdOcm5Hd3Ew?=
 =?utf-8?B?SzY5R2ZLdzErQTdNWXJTOE1Fb3pkNW0veEFZUzZQWGtTbzRmOWsydUJxcWls?=
 =?utf-8?B?cG0yRXFUZ0JxRTYwWUgvS0JxaFh2cVlkNCt1endPWWJtdW1qcjd3ckRSMWFY?=
 =?utf-8?B?Mm10WDZQVlpxVGk2dG9EUUp1djRHNEdINFRyUHh2aGJLSTRiUFROVHluc2JU?=
 =?utf-8?B?bWpEdURrRW1Td25EaEVKRnNkcXdIRWM3YkhXSFNoMUlPcExxREZiS3o0T1ly?=
 =?utf-8?B?ZFpnZEhXM0huQzNhZlNDUVh1c0tuRkMwUDR3ZUxMVXdlNFdRVFJ6clpUNTZD?=
 =?utf-8?B?UUxUNUxJNDRVb1ZZOStnZS9QcHFEeUt3UTlmZllzNGNmejhHRzQ5YU5VNlRS?=
 =?utf-8?B?bG1taWNYRFg5Vk90cm1sZHRUR0RZblNxN1pEVXFCRnpKM09rZ1cyc2pwTGZ2?=
 =?utf-8?B?WEI4eFpMNHJkR0oxM0dTOVBEWDBYcm9vMGNvaDkrWjJnb3I2dERqZDdTOGJv?=
 =?utf-8?B?V1R1SHZKOWpLTHFaeitkcGFsQjNXK3lYQWxzTXp2TnREUXdRQi8reU01Smd5?=
 =?utf-8?B?VHhRaFR2eHd4UGE3d3FwUE5BTXVud2RsQ3BySEpHbGxubU53MXQ4eGdYdHdB?=
 =?utf-8?B?NkpmWXR6ejVCQytmT1hPWFpBWHJuYXFPQ0l6d2N0d1M0VEV4OXFkVW5ReWxZ?=
 =?utf-8?B?eUExclRMc1FLWkppTURzWUI5TjRSVFBiK0dVemtZaTZhTytTWVBURUhaaWxR?=
 =?utf-8?B?Q0Y2bEtwVkZyckdmWXM2eG02RE56b2RONXh0OXNmbnRYek0zbVBEZmM5d0pW?=
 =?utf-8?B?MHNVMnRlWXZOZkdKYXlUeUQ3VG9aK3dmQkI0WHRvcWxodzFWcUtKWGN4amxK?=
 =?utf-8?B?c2lSQVlPYVlvYWUyZVNxZ25uSGh2cWExK1FEblpocVN5S2hiZHFsOCthNE45?=
 =?utf-8?B?aTJYMGNDUCtjTHZNbldtbEVzZEtlZ2p1RWtwY1NaVnh3bWQ0UzZVd1ZVRnQ3?=
 =?utf-8?Q?w7hajJWTSeGp7ZG/iZT0T8EUrGSvrrCVBunUstx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aeeb778-f327-4404-3ed3-08d9309a5e20
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 07:43:01.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9UYXnFVkj0WqFzSe7/oD/4ACaF066qLHVbwbx0KyK8WRpmUGqQ7cTB5HDguniNbGiL1TI3afwWMzGfHPp76AIVaN1CChIsJO0Na4aaY0Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1818
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160044
X-Proofpoint-ORIG-GUID: f5H1MhWxuXZngB1w81oQd5OH4_wiYvp8
X-Proofpoint-GUID: f5H1MhWxuXZngB1w81oQd5OH4_wiYvp8
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/16/2021 12:57 PM, Leon Romanovsky wrote:
> On Wed, Jun 16, 2021 at 12:22:13PM +0530, Anand Khoje wrote:
>> ib_query_port() calls device->ops.query_port() to get the port
>> attributes. The method of querying is device driver specific.
>> The same function calls device->ops.query_gid() to get the GID and
>> extract the subnet_prefix (gid_prefix).
>>
>> The GID and subnet_prefix are stored in a cache. But they do not get
>> read from the cache if the device is an Infiniband device. The
>> following change takes advantage of the cached subnet_prefix.
>> Testing with RDBMS has shown a significant improvement in performance
>> with this change.
>>
>> The function ib_cache_is_initialised() is introduced because
>> ib_query_port() gets called early in the stage when the cache is not
>> built while reading port immutable property.
>>
>> In that case, the default GID still gets read from HCA for IB link-
>> layer devices.
>>
>> In the situation of an event causing cache update, the subnet_prefix
>> will get retrieved from newly updated GID cache in ib_cache_update(),
>> so that we do not end up reading a stale value from cache via
>> ib_query_port().
>>
>> Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
>> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
>> Suggested-by: Aru Kolappan <aru.kolappan@oracle.com>
>> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
>> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
>> ---
>>
>> v1 -> v2:
>>      -   Split the v1 patch in 3 patches as per Leon's suggestion.
>>
>> v2 -> v3:
>>      -   Added changes as per Mark Zhang's suggestion of clearing
>>          flags in git_table_cleanup_one().
>> v3 -> v4:
>>      -   Removed the enum ib_port_data_flags and 8 byte flags from
>>          struct ib_port_data, and the set_bit()/clear_bit() API
>>          used to update this flag as that was not necessary.
>>          Done to keep the code simple.
>>      -   Added code to read subnet_prefix from updated GID cache in the
>>          event of cache update. Prior to this change, ib_cache_update
>>          was reading the value for subnet_prefix via ib_query_port(),
>>          due to this patch, we ended up reading a stale cached value of
>>          subnet_prefix.
>>
>> ---
>>   drivers/infiniband/core/cache.c  | 18 +++++++++++++++---
>>   drivers/infiniband/core/device.c |  9 +++++++++
>>   include/rdma/ib_cache.h          |  5 +++++
>>   include/rdma/ib_verbs.h          |  1 +
>>   4 files changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
>> index 2325171..cd99c46 100644
>> --- a/drivers/infiniband/core/cache.c
>> +++ b/drivers/infiniband/core/cache.c
>> @@ -917,9 +917,11 @@ static void gid_table_cleanup_one(struct ib_device *ib_dev)
>>   {
>>   	u32 p;
>>   
>> -	rdma_for_each_port (ib_dev, p)
>> +	rdma_for_each_port (ib_dev, p) {
>> +		ib_dev->port_data[p].cache_is_initialized = 0;
> 
> I think that this line is not needed, we are removing device anyway and
> and query_port is not allowed at this stage.
> 
We have kept this for code completeness purposes. Just as we did with 
set_bit() and clear_bit() APIs.

>>   		cleanup_gid_table_port(ib_dev, p,
>>   				       ib_dev->port_data[p].cache.gid);
>> +	}
>>   }
>>   
>>   static int gid_table_setup_one(struct ib_device *ib_dev)
>> @@ -1466,6 +1468,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>>   	struct ib_port_attr       *tprops = NULL;
>>   	struct ib_pkey_cache      *pkey_cache = NULL;
>>   	struct ib_pkey_cache      *old_pkey_cache = NULL;
>> +	union ib_gid               gid;
>>   	int                        i;
>>   	int                        ret;
>>   
>> @@ -1523,13 +1526,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>>   	device->port_data[port].cache.lmc = tprops->lmc;
>>   	device->port_data[port].cache.port_state = tprops->state;
>>   
>> -	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
>> +	ret = rdma_query_gid(device, port, 0, &gid);
>> +	if (ret) {
>> +		write_unlock_irq(&device->cache.lock);
>> +		goto err;
>> +	}
>> +
>> +	device->port_data[port].cache.subnet_prefix =
>> +			be64_to_cpu(gid.global.subnet_prefix);
>> +
>>   	write_unlock_irq(&device->cache_lock);
>>   
>>   	if (enforce_security)
>>   		ib_security_cache_change(device,
>>   					 port,
>> -					 tprops->subnet_prefix);
>> +					 be64_to_cpu(gid.global.subnet_prefix));
>>   
>>   	kfree(old_pkey_cache);
>>   	kfree(tprops);
>> @@ -1629,6 +1640,7 @@ int ib_cache_setup_one(struct ib_device *device)
>>   		err = ib_cache_update(device, p, true, true, true);
>>   		if (err)
>>   			return err;
>> +		device->port_data[p].cache_is_initialized = 1;
>>   	}
>>   
>>   	return 0;
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 7a617e4..57b9039 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -2057,6 +2057,15 @@ static int __ib_query_port(struct ib_device *device,
>>   	    IB_LINK_LAYER_INFINIBAND)
>>   		return 0;
>>   
>> +	if (!ib_cache_is_initialised(device, port_num))
>> +		goto query_gid_from_device;
> 
> IMHO, we don't need this new function and can access ib_port_data
> directly. In device.c, we have plenty of places that does it.
> 
> Not critical.
> 
Added this function to have a way to check validity of cache, such that 
it could be used in future for the same check in areas to which 
ib_port_data is opaque.

>> +
>> +	ib_get_cached_subnet_prefix(device, port_num,
>> +				    &port_attr->subnet_prefix);
>> +
>> +	return 0;
>> +
>> +query_gid_from_device:
>>   	err = device->ops.query_gid(device, port_num, 0, &gid);
>>   	if (err)
>>   		return err;
>> diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
>> index 226ae37..46b43a7 100644
>> --- a/include/rdma/ib_cache.h
>> +++ b/include/rdma/ib_cache.h
>> @@ -114,4 +114,9 @@ ssize_t rdma_query_gid_table(struct ib_device *device,
>>   			     struct ib_uverbs_gid_entry *entries,
>>   			     size_t max_entries);
>>   
>> +static inline bool ib_cache_is_initialised(struct ib_device *device,
>> +					u32 port_num)
>> +{
>> +	return device->port_data[port_num].cache_is_initialized;
>> +}
>>   #endif /* _IB_CACHE_H */
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index c96d601..405f7da 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -2177,6 +2177,7 @@ struct ib_port_data {
>>   
>>   	spinlock_t netdev_lock;
>>   
>> +	u8 cache_is_initialized:1;
>>   	struct list_head pkey_list;
>>   
>>   	struct ib_port_cache cache;
>> -- 
>> 1.8.3.1
>>

