Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74C73A94B6
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 10:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhFPIHe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 04:07:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57810 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231195AbhFPIHe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 04:07:34 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G7u1Qa024427;
        Wed, 16 Jun 2021 08:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XBvFbVpbYvWmmxmrL78uBPA54ZlFVcisHojfIAu+0vs=;
 b=xK4fJeHf//3yW6COHZ2HGtpGbkMUA2ZN1J1YoMuj8rMjhS80p6K7oRQvGsMU/2bSC9+G
 rEb0JddsGhDuuL8iQ7QXuyxvguPXg+Nrsi2EBolJLnMG274w5BhQFVQHlYoIpIp/29KZ
 ajM7SUIrzS++ZMhe1rg8AkqCvnDp171QmpK4anuUUHg82aURXWlL2xAsjnuNsU6wuXp7
 jwm2phE8B4CAjva0N6V/Pl7AvjPzO9w5mCqIsusiMxod4JWtoTbalx4cSj/znZJVHYff
 ZCy6wDT7TGmmMAPqcy/NlKBYtgpX8ABQoHh6A6jkQlR11SJBbzBjMgyVMadVdIOtkUWy KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 396tr0snt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 08:05:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15G7tTCd049263;
        Wed, 16 Jun 2021 08:05:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by userp3020.oracle.com with ESMTP id 396waw0ewv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 08:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzbA7qO3A++d37qnJlbpgZWT+brIzN4Hqqt+oXEEqtNVFbedQWuIFsH78XIY5L3JFY5joQx/krz8x2+VuOfXWcwuFscXmQ/WWqWP6yjbAApzNyRjqxfYC0vODsl1MD1bVwO2ScVqrjVZV0XeFBZJZ0D4nxDA3fIxNaGOoS3AFRQ6FICNLJW0wQZ8yrnWgXmh79Ji6nHLF32U/m34pzLQGHlIa3QYzoOqYbezI0FVLbazH28cTbmldp27S4L8k1OjBTSrAwHc3rAF39u/9S3LjNmbMFVGBmjC4MdI562w+vtV6iUL+pAVyLZI86L/LzPAIJehkAvNZWNR3OwpdDI1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBvFbVpbYvWmmxmrL78uBPA54ZlFVcisHojfIAu+0vs=;
 b=Of7vvj/veVi6gzALPF+8M43gUUw27azNKRdgY7mO1K3Artq964nHpxkY6To/I04lkvAwhpfars3MfqoBe0HDcBosdCy6GhXi24Idzg1qDr1AnH6hYSeHbx7D73Py2vWZP5HLkVXZk23pN2QTQqjQUpPEFlezcnFeM7DoqR37lZgle774mBz1fPgbL2w88wFvNWEEjAtYiTDtK29LraDjqQhJmbciaLp5aXM5Hd7wxs9sj22e5TZ3qN5PwNEgzvXmFnj8KuD/pVe3Cty8iNMxfmEedKw35ssHR6GK9PdUymrTF7OscqYGaW2hdcVsEKEtpNSlpXrQhm4Dd28xvfWhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBvFbVpbYvWmmxmrL78uBPA54ZlFVcisHojfIAu+0vs=;
 b=vORqGA5F+WL9BY5Ul30CLncAPyXxc1zytAOshJ9dkbtGabgsAI3afv5xmL5hsbwHAh0YD443fQfrBlVRoMeB9xw8cOiHUNguTtoDuipTTemOFDI/thEuIWVuflKgtpCqkC+oR/EslMvZv0kayLNVQei9eA8S4hNsDty65j1zLGU=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 08:05:20 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 08:05:20 +0000
Subject: Re: [PATCH v4 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
References: <20210616065213.987-1-anand.a.khoje@oracle.com>
 <20210616065213.987-4-anand.a.khoje@oracle.com> <YMmnyE+rpLIf6e0B@unreal>
 <ac8da9cf-9dec-a207-c80e-e9ee650b40fc@oracle.com>
Organization: Oracle Corporation
Message-ID: <d80308c7-ac9d-b7e5-a465-a51bf42f5146@oracle.com>
Date:   Wed, 16 Jun 2021 13:35:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <ac8da9cf-9dec-a207-c80e-e9ee650b40fc@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [182.70.80.33]
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.8] (182.70.80.33) by SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Wed, 16 Jun 2021 08:05:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b17291b3-cf9d-4c4b-a955-08d9309d7c4b
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR10MB5416A5AD944B23D1A1DBEE1BC50F9@DM8PR10MB5416.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2BkHq6tE/69qzwdaRvlrLSI8f+62mw8jXhvwUqrtzsjdwSX2IoXYswU63R+hXNZBGqryMWYXqB0EvFUB65cY4/8uQYGlkWH8fefJM7JdkqGMpgGLJ6xVK9naDB6Uz3WCyT8aEgsrBzn3yHWB2eBLtQaUeq2GUY6YHN/KtGLZlO6+FcqE/pDRrfAFnIowySmMFYB5HKN0mIEzqY80qy0qIVcc9DAiEKk/mYL6O9rjcScpXaiq+G8MBg+m4XW6cC5HzWOICcFoyCqll9F+992arF5orRce0WxDw0MvAp93beJaIP611QeqqrgmA64zwegQhwNjUsYKI1i4gBBVxA4g+svsqgVOvDanmw1x6DQXp1eM+ksjccq2h0B3pov13eOhzRhgpM+RIyn3p8QpFXhvne4NFEuj6AQujJJsJaQFRaP4VNlydlSK0Khq7QIVBby392JzTtTVqbUOpz1skGHPrmONh46q3XXt76vZyrj4n1+d5OsCS5kYajfx0zweJLSQ3D5ZkigsVkgP8CiBdrtGXLk9Io+58PgU3dSs3zFpEkMD+3KbqGTnjGdI1NkBX8o6JIgyKKkilG4ZA5+zMj5dLtCdDsLnaLuE5bkeJ6taFc6MI0rUyF+LIvx8hUnVAz5nrXDd/0ylxl6tQPceqKEFk+SD1FEu9rJa7xbsbk1bS+j0vHNrTzcNIDdEdpaKaTAoza+WwcshLmiM4JKBYU4BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(376002)(396003)(366004)(8676002)(16576012)(8936002)(316002)(86362001)(36756003)(38100700002)(31696002)(26005)(16526019)(186003)(83380400001)(53546011)(6666004)(6916009)(107886003)(36916002)(5660300002)(66946007)(478600001)(2906002)(956004)(2616005)(66476007)(31686004)(4326008)(6486002)(66556008)(120606002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNIMy9NRWdYZE9OTnFubVNoV0lzcTZOeU5zQ3VHbkhJYzA4eHZERXRGWXh5?=
 =?utf-8?B?MW9WYi9iS2NveHVUbklnOGFmb2hJcFR4NWpKcjNIdlpBdGRMV0Y5QytHeDlj?=
 =?utf-8?B?cDV4QzRRZUxMNmdEcmp6WVV5ejhTTnRnSUFHNWVHd21UYUdicE5MLzFBMlpT?=
 =?utf-8?B?d3JvOCtoMURMK0xMd1VzZXM0bVlrTW9YY2VGM2E2L0c0bnpmRWFjQjZhbDAw?=
 =?utf-8?B?NjlEaFpkTXd1RnBDMCtFT3RyWk5YS2FiVWUra1ZQSWNaTDE4dGFaeUlad29I?=
 =?utf-8?B?Ym5ycEtoSHgyeFdxQ2tOU3hJSUNPelo1MEszcEVrQmJzVmlQRHRrT050RGZU?=
 =?utf-8?B?RmR3eGF4a3pvZlJiZlBJRit2Zno5akhMSUlVeXNlU3N2SnhET05USm1ISEs0?=
 =?utf-8?B?WElMcG45VE9qeTMxZmNnaW5XazBxOUN6S3VLRU42cW1JUFpkNDVJRURSMkpw?=
 =?utf-8?B?dGpOKzJ0K0RuZzFKOGJXNGdUYU9ER0x0LytIVkVhUDJVTko0Wm82d3pabS9Y?=
 =?utf-8?B?OFlYNjYzRFJNTUZhSU5xanNUV0x6RDRLOWhRMFMrZWhDMld5bGZtTFYrWUNt?=
 =?utf-8?B?VEpxUUIzZTVFUHI3eEdURzlCRmM0QjFwUGxBVTVaSk9FQTVEWWN1NzY2Ti84?=
 =?utf-8?B?SlA4ZXlrcG5VVlV1ZjRPZjQ1WkVDMFdmU29yYnp5VnJldWdkeHF0d3k3UTNN?=
 =?utf-8?B?WlVtcmtVZ1hNaEdMeHZYclMwQVJnd1B6UmdETGtnVHdCQThnelNyUTZWZGVN?=
 =?utf-8?B?bkc4RG9JSTVaWXI2ZHRDVjFJa3RzaHlZNXpTZ0R6S1VUSGd3Y1g4R0MzUXhx?=
 =?utf-8?B?ZUN5aDI1dGFoc2ViMlFQTmZFSC9qTjI2ZExjSUZ1d3JNKzRraEhJenVEeVhX?=
 =?utf-8?B?MHNtQnV1YXlqK2h6YkFXOXdnVXd6Z2tCc3prVzB0ZHBuYUx4S0FEdjZUODFv?=
 =?utf-8?B?THJBQnhhNUU3dEk0MzV2RWVkbHdTMnpQR1ZoakhvajN4QW5YWitmYVlGM1RU?=
 =?utf-8?B?emd6YkdjLy9WRlhQUUVIMkwxWGFWYTZWbldEZ3JYSG9rMlc1WC9kcHc1YU1u?=
 =?utf-8?B?L0VqK2N2ekJhZGI2Vll3QmpRbmdjMVhJWXNObTZlRDM4dGFnNkF2TDFlZVll?=
 =?utf-8?B?TUdUWFpNc3ZKNTVzdVRMR0dBVEl1VjFmbXdjWlVod3Y4d3MvcEg1L29vS0FR?=
 =?utf-8?B?NDFpak83bjRmbHVpbGxjZ0doS1EvMmFab0NBRVU4STNyTDVra0EwcTNjaGFp?=
 =?utf-8?B?V25Ta3JPanVHQ1NweEVOVjA4Q3lSTkgzZmdlVEJ5dVVMcTdVL3ZYQUhjbWJJ?=
 =?utf-8?B?RjRDM012UEc0K0gzYkxRNTQzWGh6M2ZOZHZ3UWdpa1VqZVJ2T2Qwd0JoQmdP?=
 =?utf-8?B?cjBGd2svektRby9TaVBGSVNjNys5MHlZWlRRS09rdSt6VHBKUnlTZlFCdjRL?=
 =?utf-8?B?ZHYzYjBHYnZSSFM1UXRRTjEyUlkxK0tub0JsZElWbUJFSzJiRWYvUzZIZDI3?=
 =?utf-8?B?czVvYnI4U29VQ3I2YUxaZFVWekJDbnJmS2hGUTZkcnlLdXNXcHlzaUdSODNP?=
 =?utf-8?B?ZW5xWkhhWXlNWWZNc0JqUGx2Z0JrZURiUUhTd2JTWEN0eU92WDhyeEFzeGxG?=
 =?utf-8?B?SWtBVVdhTHVOakErYk53RVh1S2ZPUFNCZk5KTUpaRytDVzE3WHp5ckQzLzU4?=
 =?utf-8?B?R1lYelN5L0lXYzZ5Q1MremlKOVpJUU5nNk82amlBQ0g2MzNDMzVnSG5YeUJi?=
 =?utf-8?Q?HVjjJmfQx3ui2yIirauW+annSfvMj1ERu4bPgQd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17291b3-cf9d-4c4b-a955-08d9309d7c4b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 08:05:20.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCN3n3wk3cLTcxjIWzZBW8bxpR4cOMjtNxcdCOfQ186BA2NWKTIjAKmLekqVn+zolqS8NBNVId3I7umoalI8PrIjJpsB4b38WciI3pRv7yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5416
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160046
X-Proofpoint-GUID: cxXsblMbe0EhkvfUhnpMC0AdYS53pI52
X-Proofpoint-ORIG-GUID: cxXsblMbe0EhkvfUhnpMC0AdYS53pI52
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/16/2021 1:12 PM, Anand Khoje wrote:
> On 6/16/2021 12:57 PM, Leon Romanovsky wrote:
>> On Wed, Jun 16, 2021 at 12:22:13PM +0530, Anand Khoje wrote:
>>> ib_query_port() calls device->ops.query_port() to get the port
>>> attributes. The method of querying is device driver specific.
>>> The same function calls device->ops.query_gid() to get the GID and
>>> extract the subnet_prefix (gid_prefix).
>>>
>>> The GID and subnet_prefix are stored in a cache. But they do not get
>>> read from the cache if the device is an Infiniband device. The
>>> following change takes advantage of the cached subnet_prefix.
>>> Testing with RDBMS has shown a significant improvement in performance
>>> with this change.
>>>
>>> The function ib_cache_is_initialised() is introduced because
>>> ib_query_port() gets called early in the stage when the cache is not
>>> built while reading port immutable property.
>>>
>>> In that case, the default GID still gets read from HCA for IB link-
>>> layer devices.
>>>
>>> In the situation of an event causing cache update, the subnet_prefix
>>> will get retrieved from newly updated GID cache in ib_cache_update(),
>>> so that we do not end up reading a stale value from cache via
>>> ib_query_port().
>>>
>>> Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
>>> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
>>> Suggested-by: Aru Kolappan <aru.kolappan@oracle.com>
>>> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
>>> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
>>> ---
>>>
>>> v1 -> v2:
>>>      -   Split the v1 patch in 3 patches as per Leon's suggestion.
>>>
>>> v2 -> v3:
>>>      -   Added changes as per Mark Zhang's suggestion of clearing
>>>          flags in git_table_cleanup_one().
>>> v3 -> v4:
>>>      -   Removed the enum ib_port_data_flags and 8 byte flags from
>>>          struct ib_port_data, and the set_bit()/clear_bit() API
>>>          used to update this flag as that was not necessary.
>>>          Done to keep the code simple.
>>>      -   Added code to read subnet_prefix from updated GID cache in the
>>>          event of cache update. Prior to this change, ib_cache_update
>>>          was reading the value for subnet_prefix via ib_query_port(),
>>>          due to this patch, we ended up reading a stale cached value of
>>>          subnet_prefix.
>>>
>>> ---
>>>   drivers/infiniband/core/cache.c  | 18 +++++++++++++++---
>>>   drivers/infiniband/core/device.c |  9 +++++++++
>>>   include/rdma/ib_cache.h          |  5 +++++
>>>   include/rdma/ib_verbs.h          |  1 +
>>>   4 files changed, 30 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/core/cache.c 
>>> b/drivers/infiniband/core/cache.c
>>> index 2325171..cd99c46 100644
>>> --- a/drivers/infiniband/core/cache.c
>>> +++ b/drivers/infiniband/core/cache.c
>>> @@ -917,9 +917,11 @@ static void gid_table_cleanup_one(struct 
>>> ib_device *ib_dev)
>>>   {
>>>       u32 p;
>>> -    rdma_for_each_port (ib_dev, p)
>>> +    rdma_for_each_port (ib_dev, p) {
>>> +        ib_dev->port_data[p].cache_is_initialized = 0;
>>
>> I think that this line is not needed, we are removing device anyway and
>> and query_port is not allowed at this stage.
>>
> We have kept this for code completeness purposes. Just as we did with 
> set_bit() and clear_bit() APIs.
> 
>>>           cleanup_gid_table_port(ib_dev, p,
>>>                          ib_dev->port_data[p].cache.gid);
>>> +    }
>>>   }
>>>   static int gid_table_setup_one(struct ib_device *ib_dev)
>>> @@ -1466,6 +1468,7 @@ static int config_non_roce_gid_cache(struct 
>>> ib_device *device,
>>>       struct ib_port_attr       *tprops = NULL;
>>>       struct ib_pkey_cache      *pkey_cache = NULL;
>>>       struct ib_pkey_cache      *old_pkey_cache = NULL;
>>> +    union ib_gid               gid;
>>>       int                        i;
>>>       int                        ret;
>>> @@ -1523,13 +1526,21 @@ static int config_non_roce_gid_cache(struct 
>>> ib_device *device,
>>>       device->port_data[port].cache.lmc = tprops->lmc;
>>>       device->port_data[port].cache.port_state = tprops->state;
>>> -    device->port_data[port].cache.subnet_prefix = 
>>> tprops->subnet_prefix;
>>> +    ret = rdma_query_gid(device, port, 0, &gid);
>>> +    if (ret) {
>>> +        write_unlock_irq(&device->cache.lock);
>>> +        goto err;
>>> +    }
>>> +
>>> +    device->port_data[port].cache.subnet_prefix =
>>> +            be64_to_cpu(gid.global.subnet_prefix);
>>> +
>>>       write_unlock_irq(&device->cache_lock);
>>>       if (enforce_security)
>>>           ib_security_cache_change(device,
>>>                        port,
>>> -                     tprops->subnet_prefix);
>>> +                     be64_to_cpu(gid.global.subnet_prefix));
>>>       kfree(old_pkey_cache);
>>>       kfree(tprops);
>>> @@ -1629,6 +1640,7 @@ int ib_cache_setup_one(struct ib_device *device)
>>>           err = ib_cache_update(device, p, true, true, true);
>>>           if (err)
>>>               return err;
>>> +        device->port_data[p].cache_is_initialized = 1;
>>>       }
>>>       return 0;
>>> diff --git a/drivers/infiniband/core/device.c 
>>> b/drivers/infiniband/core/device.c
>>> index 7a617e4..57b9039 100644
>>> --- a/drivers/infiniband/core/device.c
>>> +++ b/drivers/infiniband/core/device.c
>>> @@ -2057,6 +2057,15 @@ static int __ib_query_port(struct ib_device 
>>> *device,
>>>           IB_LINK_LAYER_INFINIBAND)
>>>           return 0;
>>> +    if (!ib_cache_is_initialised(device, port_num))
>>> +        goto query_gid_from_device;
>>
>> IMHO, we don't need this new function and can access ib_port_data
>> directly. In device.c, we have plenty of places that does it.
>>
>> Not critical.
>>
> Added this function to have a way to check validity of cache, such that 
> it could be used in future for the same check in areas to which 
> ib_port_data is opaque.
> 
Also, there was a review comment from Mark Zhang for patch version 2, 
where he had suggested to shift clear_bit(IB_PORT_CACHE_INITIALIZED, 
&device->port_data[p].flags);
to gid_table_cleanup_one().

Thanks,
Anand
>>> +
>>> +    ib_get_cached_subnet_prefix(device, port_num,
>>> +                    &port_attr->subnet_prefix);
>>> +
>>> +    return 0;
>>> +
>>> +query_gid_from_device:
>>>       err = device->ops.query_gid(device, port_num, 0, &gid);
>>>       if (err)
>>>           return err;
>>> diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
>>> index 226ae37..46b43a7 100644
>>> --- a/include/rdma/ib_cache.h
>>> +++ b/include/rdma/ib_cache.h
>>> @@ -114,4 +114,9 @@ ssize_t rdma_query_gid_table(struct ib_device 
>>> *device,
>>>                    struct ib_uverbs_gid_entry *entries,
>>>                    size_t max_entries);
>>> +static inline bool ib_cache_is_initialised(struct ib_device *device,
>>> +                    u32 port_num)
>>> +{
>>> +    return device->port_data[port_num].cache_is_initialized;
>>> +}
>>>   #endif /* _IB_CACHE_H */
>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>> index c96d601..405f7da 100644
>>> --- a/include/rdma/ib_verbs.h
>>> +++ b/include/rdma/ib_verbs.h
>>> @@ -2177,6 +2177,7 @@ struct ib_port_data {
>>>       spinlock_t netdev_lock;
>>> +    u8 cache_is_initialized:1;
>>>       struct list_head pkey_list;
>>>       struct ib_port_cache cache;
>>> -- 
>>> 1.8.3.1
>>>
> 

