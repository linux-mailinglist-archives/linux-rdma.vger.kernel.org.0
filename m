Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA03C2630
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jul 2021 16:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhGIOtn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jul 2021 10:49:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62280 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhGIOtm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jul 2021 10:49:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169EedbI032404;
        Fri, 9 Jul 2021 14:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MiL6UlH/w6tSpiCcTrQl2qmBA2s8iZZwpjLRW7/yPPI=;
 b=TxrB570gRWC3MP38gVDM67UX/pcXyAmzQr2UGzjLJCjG40xX+VTxu1ahxpoWR01Da0Rt
 y7mIslfJP5ZoA0pS7pdBl8CTvYWPUGMXh4Oio9lSTnFs9eEoP5kZYujrRvHbtstHePi6
 zovJPJrBmnQZ8+UEaX4txTiYgwJmGphe1uAjUNomGXAk23x9P4PsK7YgGNKA4pWMg+hY
 S/LTHOZ9OccegbQT5IvMTUbDsBnLyUGQ1QiBw5DyZiHERqaHjybK4rh94x9l+xNvGcMT
 DLRHgdyBDyRz572vnUb2gvtpwZF8qZYia+CTOLy2f+4gJ1ZWgF9Mudy1DQ/UbNfGUoWT 9w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39npwbujw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 14:46:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169EehhU172124;
        Fri, 9 Jul 2021 14:46:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by userp3020.oracle.com with ESMTP id 39k1p4y86y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 14:46:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8PsCFEYQci6xv5FLd8HJq/cgEMsf0jWIZRxGZ/JeElNBkuPljIzosfAPz6srLs4qkW8QymuxxUXdWBah9KUC0WajVvXzgA/TnAt37b0Jlmc4EjEaH4dZMYVJrhJkwWZ4yEytG93+nkCkhrJZdJEVYCLMC5u6eZC/aY6VRiSQI8P+jke5nJagM4Cb3DJHBsmERyAGCASSmwXBQgPYoxrAz5OmJfq0cwYWKxsclYp6BFGkGY9cAxq87HDoO6uQ4HNaex9N2NqojAf3j7+kkRbCmBdw3S8nYZXaNXSB6tyDDrdeHE2cz08xdxETV6fpnWKetQJ4PTyNKzsZVijkvjEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiL6UlH/w6tSpiCcTrQl2qmBA2s8iZZwpjLRW7/yPPI=;
 b=BS6eHKlSv40uY+uc3xRFU4HSGq+B62prRUosxj8eMsWRggG3wzmFLcCkFYkWaVdt/iKohYBsKMBj4AfHv30NZ8eBnwYk1LlGYHuNqVKlxBxdZD4EeI9RzM39bYZWcvuc26M6pTfiAAEWnFbe9mzykMg864nMRL3SmWWBngd6H7YJREfjp+sEijXKmGLgvucACGV21YqiwYhQUBpbMw3pZieYDTVlcvOPWAECv+w77cX5TvSKyJbex/DMg4VqEngL0W8dyQFv+PmQeBsdswdk16VLjFjylTKCvjjGq22QLbcRT0q8KjRqbt4GAADub/cojXNONM5bRY5P9GYf6L94+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiL6UlH/w6tSpiCcTrQl2qmBA2s8iZZwpjLRW7/yPPI=;
 b=J97KW2Js76VIChCcxGzB/wdPR5rhQiZ3kg0rJprRTBx3TmDm4e1mLZnAsVUQL5yr0difA3HAhpo1EZ8JJyP9y7ep5zGRpLUJY6/Ighuntj6cMqsBpdH7GJFt/NKQbOsgEZ42jTg7VElND6/1rWIbyZILzT8yHtETLZe4QvQ23/0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1944.namprd10.prod.outlook.com
 (2603:10b6:903:124::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 14:46:53 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5%6]) with mapi id 15.20.4308.021; Fri, 9 Jul 2021
 14:46:53 +0000
Subject: Re: [PATCH v7 for-next 0/3] IB/core: Obtaining subnet_prefix from
 cache in
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, haakon.bugge@oracle.com, leon@kernel.org
References: <20210630094615.808-1-anand.a.khoje@oracle.com>
 <309d7800-73a3-41c6-542f-cdcb5a72e969@oracle.com>
 <20210709132104.GA1582827@ziepe.ca>
From:   Anand Khoje <anand.a.khoje@oracle.com>
Organization: Oracle Corporation
Message-ID: <8f4d395b-317d-ec09-9d4a-4e88e8e7a245@oracle.com>
Date:   Fri, 9 Jul 2021 20:16:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210709132104.GA1582827@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.101.2] (103.155.226.254) by TYXPR01CA0044.jpnprd01.prod.outlook.com (2603:1096:403:a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 14:46:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa318ab7-672d-4dcc-ec09-08d942e863ff
X-MS-TrafficTypeDiagnostic: CY4PR10MB1944:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB19446EDCA0B616C0E9D18881C5189@CY4PR10MB1944.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxsZ8IsOEWA4C+2Y17GtPTCkbmHxUfvxssS1LVT1E0+tj3GDh18Jsjt4oNpw0qaxgK6ETYYiOREVv7+OPmE0rjM8v6pO/yjaMskVh2On+oAbuFdJUuNS8ljcizB5wmVLInSeZoIYR89WsTdJlPoQON1XTRqzCDIam4kbxGlaKVj0RvGYdWDcGphGRuPeHSWx5Lc4Z3YcfcbhSttpL0oi7NekFJuMR0NtzemPDwCFl2gsYGv9WbBG+xRGzoq0DTequ55JGmGay6B7stCcoxcm2n7rvqRfmTPr5HtQs0fXGArDEXzH2G/pNZWGgV6kKcsZsSA/sXEhlnpXoV8woI1lRBg+X0OvWRbUnRgsque2S3qVAnJkCjYdmTDKSTHAX2Miq9jJvxlSevM1va7Q1PZCWaKb1KWFlJyO9LGD+juLxa7j+cAPK0e3tP8GtvFZZJCZPvJ/jDq1UBNW+22SmEH3mfmH3hko9LoMCBILi1N/w4tRGAYb4qZS1vWnSIgxLRY/ywK82FwzOBWIVs4piG1SpLkuDqQlIPj27tsLvRljE2D/JHMFFTpBcKVWa4qA4i/I5Yi93SNlQ8Oz8GkNgJOOWreRH6xYnrX7l7U6n9+8GtN8gmDhdQLJyu3nzCRzTKisN6/HD2snOQkbtz3gLiTz+JgdNl4EKnIOy75/Fv7DGTyY620sYmyxL+zz839xeTuWYnTBonwJlwHppX3mEZhvX8BtsYpbIVu91DVyvMWBS9wTQKO7pWkAN6URUSymSDwl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(366004)(396003)(346002)(4326008)(66946007)(316002)(66556008)(36756003)(8676002)(36916002)(86362001)(31696002)(53546011)(66476007)(26005)(6916009)(2616005)(16576012)(5660300002)(8936002)(6666004)(6486002)(2906002)(186003)(38100700002)(478600001)(31686004)(83380400001)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enVMVDNhQnBiWktucHdTNEZNeUZtR0x2N0NVRWlKSTZEWmY0L3IxNFp2VTNM?=
 =?utf-8?B?YmNGZjJlTmJyeVprYkw4Uk1TanZ6UWFUMmkvZjhpYTBFcEo5RFR6R3pPSXV5?=
 =?utf-8?B?NjByMUlydE9NQkowT2g5bEV1dGtvbTR0bGRzeW9QSGtrVi9tN1JTVTFYMks3?=
 =?utf-8?B?QW5tWEFRbms0MVNyWUZtcjN0V3M1ZExmVHZhaGNkSWNaUlVremZjV3pvc0Ri?=
 =?utf-8?B?c1l2b1pOQmlaUWZvL21Zc3Z4c2FiTG9UT0h0cm5WaXI5cDEwNlBhUFpBeDVz?=
 =?utf-8?B?VXU0MFZZNDMzWmVmRTdrSEF4UnIvU2ZVYW90ZzdMaklxWlM1QWFPY0VPVkMw?=
 =?utf-8?B?SWVNTkdmUU1FSlREQ0lCQlFGQnVnUkh5dCtOZ0N6ZHI4M3dYWFJ4WDhZQWI2?=
 =?utf-8?B?eVdRN0I1dk0renVJWTJ5WkJaVjUzNFRGeTU4U3hnVUdyeG1BckNYTGdOYkYv?=
 =?utf-8?B?VDhzbVh6MUZTdnJhVCtuZlRxZWM0TFV0WXRFekNGTmFjV3N0Tjl1Qld6V3BI?=
 =?utf-8?B?RzVjNHNFU3RnVUx2YkFQd3pEUEM0ZWpMTkhkdlhVdENiK0tneGZGc0ZtMzVn?=
 =?utf-8?B?YWNKSDE1N0FLRGJFK3I1bHNhN3VkVzc5RUxQdmR4NXlTY05oeWU0aUU0Tmht?=
 =?utf-8?B?SUVNU1FrOGhSNC9iVTA2cHFVVUh3T3pUbmFyazRsUmszTE5qN0Q4cDRLYk1B?=
 =?utf-8?B?MGNDM2xNU0dSMi96MG1GT2lLdWlhQTlYd0JRRkwwY0g4RzlFRmF0RWRBQWww?=
 =?utf-8?B?UWJEQ2JzYjVWWURvanJ0amlrWEJnT2FWeC9aZzNTOXRIaVhiQ2JXQnhVU3Qr?=
 =?utf-8?B?RU9aVERYdXU5WUxzZXdBbzNRVnhUQUFlRSt0Mno3SGZQaDh4citUOGZZaEJq?=
 =?utf-8?B?N0xlb0hwOE1aaG5ocU1UY0dzREloQ2F5RXlkZG1HdEZOYURqeVl6Z0h6RGVI?=
 =?utf-8?B?MzBJUytzYktTOE1oWFhKazRKdUNmUEkwNnRIWVoyaWYvMzVyRjFqcC9VZXU5?=
 =?utf-8?B?cDNOdkVOcW40TW9uOFZHem1UZGhjckRMWjVoOVN3dkp5TXc0WEMvU0VMOFVU?=
 =?utf-8?B?aVJWRkt0ZWZ1WFpFWkhDNTJiQWU5QWN3dHNvc3RWeGthdlN6aHQvWTkrVGNy?=
 =?utf-8?B?VGdzTzdwK3JaZEh3MWp0Y1pac0lic2NmVU5ISXc0cEp2Zm9LTERpdWJTeXls?=
 =?utf-8?B?T2RYd0VOQVByTVZkSDFZcVAxM0k2akR1YXR2TUxPWTFHMnJOZzlEbEJoR21m?=
 =?utf-8?B?OE9QOGgraUQvaWJTU1B2M3lFZUY3SVN2K1FpQnZuTlpadG5rVEZ3S3Mzeisr?=
 =?utf-8?B?cGtTd2pMVDEvbFlSVWdCWlR1QzVleWhiTXNyby92N01VUmx5WDBZcnpXa1hU?=
 =?utf-8?B?dFk2VEMzZWxiaFQraWVlRjAveWxwMDhLcTVGZXYwcmtOYkJmWm5iZ0J6NUZE?=
 =?utf-8?B?T2o5bkZsSzlxMFpwV3hZUXhZUExnUVM1K3RkVjB2TE10S2dWVHlXYWVrYnNs?=
 =?utf-8?B?YWd5cmpCbEFMRGhjR0t5YTQ5dlhhN3hZZzdsNG9KQTlBZVNFSENmSTF0a1pL?=
 =?utf-8?B?TjI3RmVucm5XTm1yODRhNW9DNENRM2JQNERwd3I1VWNUM1pCa3RaVzBuVHgr?=
 =?utf-8?B?cTY4U29PVEFuajlWWThjRVBmNW1TelREbnFFK3I2dW43ZG5iSlp1dlVuaERl?=
 =?utf-8?B?NzlkcHJVTUE4VUZYcFZNcjdjeTViSkZJV3NrSS9lTnBhQXFVNmQxVm5tNXhh?=
 =?utf-8?Q?7xoYQ5oIn7daFszgSzBgfq9e2DbSl2iEI4vKjuR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa318ab7-672d-4dcc-ec09-08d942e863ff
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 14:46:52.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooX/rUKp4Sj+l013YZ+BDd52mlybUAsRN3IIIIS1oEOKmeccNqR+UB4wyOybp0XVVTzWBp9r9a76OQ/f7J7VsZKyAsBhzYipqN1RMK2p3ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1944
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090073
X-Proofpoint-GUID: _XJ8h5S0E14OpVNKW6zzvri5iEy9d6U0
X-Proofpoint-ORIG-GUID: _XJ8h5S0E14OpVNKW6zzvri5iEy9d6U0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/9/2021 6:51 PM, Jason Gunthorpe wrote:
> On Tue, Jul 06, 2021 at 12:55:48PM +0530, Anand Khoje wrote:
>> On 6/30/2021 3:16 PM, Anand Khoje wrote:
>>> This v7 of patch series is used to read the port_attribute subnet_prefix
>>> from a valid cache entry instead of having to call
>>> device->ops.query_gid() for Infiniband link-layer devices in
>>> __ib_query_port().
>>>
>>> In the event of a cache update, the value for subnet_prefix gets read
>>> using device->ops.query_gid() in config_non_roce_gid_cache().
>>>
>>> Anand Khoje (3):
>>>     IB/core: Updating cache for subnet_prefix in
>>>       config_non_roce_gid_cache()
>>>     IB/core: Shifting initialization of device->cache_lock.
>>>     IB/core: Read subnet_prefix in ib_query_port via cache.
>>> v1 -> v2:
>>>       -   Split the v1 patch in 3 patches as per Leon's suggestion.
>>>
>>> v2 -> v3:
>>>       -   Added changes as per Mark Zhang's suggestion of clearing
>>>           flags in git_table_cleanup_one().
>>> v3 -> v4:
>>>       -   Removed the enum ib_port_data_flags and 8 byte flags from
>>>           struct ib_port_data, and the set_bit()/clear_bit() API
>>>           used to update this flag as that was not necessary.
>>>           Done to keep the code simple.
>>>       -   Added code to read subnet_prefix from updated GID cache in the
>>>           event of cache update. Prior to this change, ib_cache_update
>>>           was reading the value for subnet_prefix via ib_query_port(),
>>>           due to this patch, we ended up reading a stale cached value of
>>>           subnet_prefix.
>>> v4 -> v5:
>>>       -   Removed the code to reset cache_is_initialised bit from cleanup
>>>           as per Leon's suggestion.
>>>       -   Removed ib_cache_is_initialised() function.
>>>
>>> v5 -> v6:
>>>       -   Added changes as per Jason's suggestion of updating subnet_prefix
>>>           in config_non_roce_gid_cache() and removing the flag
>>>           cache_is_initialized in __ib_query_port().
>>>
>>> v6 -> v7:
>>>       -	Reordering the initialization of cache_lock, as the previous
>>> 	version caused an access to uninitialized cache_lock.
>>>
>>>    drivers/infiniband/core/cache.c  | 10 +++++-----
>>>    drivers/infiniband/core/device.c | 10 ++++------
>>>    2 files changed, 9 insertions(+), 11 deletions(-)
>>>
>>
>> Hi,
>>
>> This is just a reminder note requesting review for this patch-set.
> 
> You'll probably have to resend it after the merge window closed on
> Monday, rebased on the new rc1
> 
> Jason
> 
Hi Jason,

Thanks for the response. Ok, I will rebase and resend this patchset.

Thx, Anand
