Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244253DF8A5
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 01:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhHCXxx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 19:53:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54098 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233784AbhHCXxw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Aug 2021 19:53:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173NkSag005330;
        Tue, 3 Aug 2021 23:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DTrxqB0xfZSAt8gNxdZFVVk6v0JeZvEG04M4boe9wls=;
 b=pak+KeSoZmQHxrhz7cRf0a6N40RSsZs0ZCk73kBproofgLvMpeDjI02co0zqZZwOpo+S
 6O29bhBaN9CIfgjtU9iP4lupPlAUqbLAJjb0HTvpCeU8kTBfpZIzV61WjXPybV+Fg1tC
 sBIJKrY9OzkVLg1I7n2K6jd0WyoD+yePShtdDSrXnW6yuxrHf5ipmhEELloxdmeooOCa
 HZvA1A47e8678c5eYdxqh2mC5JqMBFO9Uats1QPYTi+nie1cRuqlu1/t1tKebQR4CLEu
 LYqSZ6Eqy8n1FBqundGLwRh4RzShIQgVngYJOXmBB+z1PZtFaek4TZqqJCLaQ9Efvj66 YQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DTrxqB0xfZSAt8gNxdZFVVk6v0JeZvEG04M4boe9wls=;
 b=X8hDTHnsReO4x3eZjSuRjU95AZhtfmdOzL1D1uFD6SjsLOohkxezbyn5ARRV74lRbsQ3
 z06BnKNW6b1EhxaY9czZGdHvKbavROoSQB7Vih4nZVB1xai1/hw46uW8u61YDaMviAy0
 vAV5j6Cxr+hgK1+cDGpTy5S05y7QQvgA9FWgI89vT3rQmRTAJF7k0qlqrjykaLxc55Oj
 hlGHHEufClgfNuB8te8F6sh7xcJKdCDdJu3HX4C+VSeX0m9jVUChWO1RF8UU/vDf4h72
 4kU9PRmJi4eecBWaad9nia2PeQNC9bT4e6pAMa73whPonAkAhnwUFdjflIh3NaZw7P5k rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6gqdcgcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 23:53:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173NpN3Y159528;
        Tue, 3 Aug 2021 23:53:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3020.oracle.com with ESMTP id 3a5g9vym8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 23:53:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVMJ0xw3KjN3ncXPG9LIvRxxULMbY0FNBsyxqz/Kmgk6uWQc4BCqS7col8TH4eJq2oQSVB7MpfR5qMiW47vEtj9oYPOVoYLb2HkfoJMH2WgnRsPfeYVenoZmlxmYCs0G54Ii8qg8gyP8Y/dTSx1+JpyR5b7NY3ytByTkzYffvaRr9MVF+Aoo+QL4/oz+isxEx9mMGGo4tMboSncKCpsoCXoAFMw01U67SuL0tpzufFzIALP9TGavbZpTyeeA1xD5drhlP+pBijt1wDY+GD5Eif3zLuP1vzWEqYW9uiyEdnxQWspshTO0BRKkmQ2hQ9w0gDscj/vd0Z/OIKYjHd9V2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTrxqB0xfZSAt8gNxdZFVVk6v0JeZvEG04M4boe9wls=;
 b=mOnma9mjNa/XQnG6xf7WiJbvvo35ZqRv7WfEEJSVfwChOkZsfRuIi5pDBtNECyNGZOA5apEVP9C5f/ngjD3Ti5mNADpWyRgxZBTcKYfDNnhcbnXX36WepSVlfLyn4bqTepxEDCLpLCCzrxdc3HcJ3sVxun3x3tXKNfm4/aa01aQICJzoVb7sCKoAYraEE6EBg+oLk31qV0H5Zdyv1xuTFMnEudBk2A7n/8SKgjicQtlDMKMCv9pZC+KABInqFLpHOtP36JJerIRybrWHhiVlImNPdn1FJUveI/NDz3Owy2Jud31CW19R6U5k5Iqf47SEfnQkjUTKfzvo/BEy/vESMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTrxqB0xfZSAt8gNxdZFVVk6v0JeZvEG04M4boe9wls=;
 b=YYGpk/V0G25ZyoBk0BVv6ePbQnLNBkdVKsDlZ3Ul0guph6KIug3q0ez6ePbxMxQV9r6UvGzmKb4cMeqmIwxRhSECrmLLCQ2nPv9OE1ZTqdKEn9Asd3QplT5TYuscBjb/x2+TPVBsOlINf2FW7fLIrXgJY3xe04p36LpONWV8CUE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 23:53:37 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 23:53:37 +0000
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
From:   Shoaib Rao <rao.shoaib@oracle.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
 <14b9f35a-0086-834a-c05f-361a26befc13@oracle.com>
Message-ID: <90ab34d4-92d1-986d-80e5-4253d208d073@oracle.com>
Date:   Tue, 3 Aug 2021 16:53:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <14b9f35a-0086-834a-c05f-361a26befc13@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31)
 To SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7444:8000::cb0] (2606:b400:8301:1010::16aa) by BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 23:53:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13e5d69c-d4e9-46f4-2b4f-08d956d9e958
X-MS-TrafficTypeDiagnostic: BY5PR10MB4388:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4388C806CE39990990F96B57EFF09@BY5PR10MB4388.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJ6RzXAXMXbN7j2wTLobh/dfHHf0okdokBPmQbARV0ju6qDTL2yi9Zh45YSYTDTpTUJIZnRBTOWhCrnPNe97fbtAIesGIreKqcwNNMP/XrRJE8T/nj3Wxx4sgS7zxWG/iYI0oBo+svns5q16IrDu97LOqI2IyLwBnMx17zrH/q5ZpQ4qlV/bmg99iugTpLVqBAeOhKoQh8JSN0mTiizkDTkomTsmdgCuDrMOaGf4Unz9rBWQVq80N8760KeziADOVNsjlWwKuwvrSo9/MsQRDSqDOivlIcyRFhcFaSWPdf0dGF03lHLe8dfa7UjU6mgxQO/LUJTI0wwVZlKANn6VUqZFSrLqjEZoDExZb3oXNdabvwvj0cZ4oHFpaqYANnPEbO8PZxXv+oR1v6r1v8TEzqT0ikHWdaKx/QAm7OQj0u837LeBQrwG5afSxettJMWcNuH5kDyY/UwcTx9magC30YDEMTSe+a4K/vOEkoa7tbZZNC9F2JDo++IEiYPqZ6aY1nTOuwO4W8h6uCL7/J3SrAMaT8PeT5+rKlFtjORJLCYakO+ctILBuOZTJSw1XXVEKN0Bp9VF/4VtGWPRPbyWifEPx2pTItenpwcT0w0brEUpNUtDV6cxbreNOKhcEISUJqny2OVN0+7Pw/mCdBH4sLnGebA2np+b3Tw4oTyI7M08cN5zfFD+YBLJ2V+UGZK1kAh0Evu37vTkvaaZhxLU+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(83380400001)(186003)(53546011)(2616005)(508600001)(66946007)(86362001)(316002)(2906002)(5660300002)(31696002)(36756003)(6486002)(8676002)(6916009)(4326008)(8936002)(31686004)(66556008)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE55QmFIR0RvS3BOZXo3TjhMUFJjMWwxcHZ0OXhpcTJ3dE5LY3lxSjBRZk13?=
 =?utf-8?B?SG9ha2s5bGRRSXRhMXM3ckhWQTBLcmFhOXZsV0dQTjJYaUN0UGNvK1ZBKy85?=
 =?utf-8?B?aGIzVXk4c05ZUnhUdjdsbkd2dUcxeGVGSlNETVdqcURsRmQzWFJWRGE5RFFC?=
 =?utf-8?B?a2kza1llZHNReS9XRkNDaDhCTG9idVdVOGVXd1J3UCtIOFBCSGhQRy8xelQ0?=
 =?utf-8?B?clVJWkMyMnMyZ3gxUVNoRGNVZkxvcXFBVmpDTzJWdnpMZU1NYXNXSzF5TENY?=
 =?utf-8?B?WXNxZmRWNU9NNXdJRFpSSGxod1Fodk5XdXFGaTRTaU9JL3pINzZyL3JzQ0Ft?=
 =?utf-8?B?RWdCVDkrUENlSmlaQ1NGOEpjbS92VkI3SnNwaGJOa0tReUhEUmMyYXFDc0p5?=
 =?utf-8?B?UUZ1STNHWElnS2x1ZHpBTld2UCtVbFBmcFBHZVdYNzBCZXE5aWc2d0cvbHQx?=
 =?utf-8?B?RS9Ud1gzUmtjdFh4a2JLazFQby9OeU5CN1g3UFhPNTE4bUZ2VmRoSnh2YlQz?=
 =?utf-8?B?RUp2ajQraVpCdVB0aVdSTjF3c0VjYVJMMXpwd0pCbUpTZDdVVmpnOG9CZzQv?=
 =?utf-8?B?SG1rTTFBQ2VwQkZhUWU0R0g3SzJUU3dpS1R1b3RwVzV4VHlIMmdxMHc1bnNO?=
 =?utf-8?B?WVA1VkYzc25DSmh1VENjMWlVWDRTVUVzVVZWODdiV2FyZVgzUmVQUkF3VHg0?=
 =?utf-8?B?ZGsrVXBDU2JBeG9QM2NkMWpLVkxDYThOZHVudEovWHBlR0Q2QWFCcUt4ME9S?=
 =?utf-8?B?TlRiRlJnTFZGdjZIOXVmc015bUkzMG1WRmZhNG1HYlFyUzRHaVdaUTdwNW90?=
 =?utf-8?B?U0ptRmN0eEkrcTA4S0Z2aS9HdWZYR2o1WWs2RXliaE1pdElsWnZGUURDdzNF?=
 =?utf-8?B?UEs1MGEvcTA0UGZFNm9uSjhUTi9QVFhNeGlsQTVZUUlUYlNrU3BJZGttYS8z?=
 =?utf-8?B?UGg0R2htemNpdCtpYzdqTmtnZHdBclJqMCtTSnFnVVlTc0FJOXBkbnBtb2VC?=
 =?utf-8?B?bFU3RFRHTEFFdXhHa0Y2WXN6RWplQnByUHJCRnhQMlBRK2xML3NwUkpqL29P?=
 =?utf-8?B?SDJqeFIrcDVMcXdsM2xMbnRCcE1XbmlnT2Uxbit4TFh0VXpEalJDbHpWQkQ3?=
 =?utf-8?B?RVEyc29LbkQ1N1hFcmo0M0dHdmx2YzFmN0dMZGZ3UGRLR0dZU2FJY05vbHla?=
 =?utf-8?B?RFEvOHdScmx3VXJ0bnE2VnBha0JCMjlqRE4zU1ZaZzVMOHo5NVpRQkRnb0RH?=
 =?utf-8?B?SDVsdDVnbXZCR2hDSDJmNWYxQ2xhUG1uQllocEFld250M2srTXZwQmFyVzJP?=
 =?utf-8?B?cng3Nm51UklDeW9LOTlINWxuaWo3TThPMVJMTlF3c0lnd0Q0d3NRY1hHT1RD?=
 =?utf-8?B?cEVHMUNRa3hhQVpGOWtGY2ZYZ3lDbTdKVGtnUWZsSmY1M3VsaHdheVAzZVFS?=
 =?utf-8?B?SGdkSEZUcVpuKzdNQVZJUWp3eFdzWkZQOGQ5VGVjK3FjanR4K2Y5T1VOd1dp?=
 =?utf-8?B?WU5pYmhwUFQ2dFVXNGdsUE42M1JDaTlhamVxUlBuM3gwMVBHZ3p2YkdvdTZI?=
 =?utf-8?B?amsxVEhMRk5IOFB2azZON1FKcEFDWEVvMlVmeStOZitwUzIxd1dhTnVmc25n?=
 =?utf-8?B?SmFHZkhyZllEZmpyQ3ZwdWxUUnpTTXlYRVhvb0lENkdvcmV0RjNLakFPMFU0?=
 =?utf-8?B?bWl2MmpNQXhJZUpBNUVtNjRxNlJBc3U2N0NsYUpwc01CZ2lYaUpFb2RtQTJO?=
 =?utf-8?B?L2ZzQjBKNjlMMDZhTGZtY0NxZ3R4dzlacSsrMll2SVdBR3kyV0NML0kyb3Np?=
 =?utf-8?B?OHdSSklpaHdmM3NIUndtQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e5d69c-d4e9-46f4-2b4f-08d956d9e958
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 23:53:37.4617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3pCfQg9zUm+3Rw6e/4+thHOok459E0WCMLeHnEmXRb4vNm2C8TDRmvL34UhFUnspIkFGfgmOUqa1tkx2uHO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030145
X-Proofpoint-ORIG-GUID: 7oo6xvE3-jsyI8pnbRcwMMwYbFvXiD8G
X-Proofpoint-GUID: 7oo6xvE3-jsyI8pnbRcwMMwYbFvXiD8G
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Zhu,

Any update on your testing after applying Bob's fixes

Shoaib

On 7/29/21 5:34 PM, Shoaib Rao wrote:
> Thanks Bob.
>
> Zhu can you please apply those patches and test.
>
> Shoaib
>
> On 7/29/21 4:08 PM, Pearson, Robert B wrote:
>> I found another rxe bug (for SRQ) and sent three bug fixes in a set 
>> including the one you mention. They should all be applied.
>>
>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Thursday, July 29, 2021 2:51 PM
>> To: Shoaib Rao <rao.shoaib@oracle.com>
>> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>; RDMA mailing list 
>> <linux-rdma@vger.kernel.org>
>> Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values 
>> used via uverbs
>>
>> On Thu, Jul 29, 2021 at 12:33:14PM -0700, Shoaib Rao wrote:
>>
>>> Can we please accept my initial patch where I bumped up the values of
>>> a few parameters. We have extensively tested with those values. I will
>>> try to resolve CRC errors and panic and make changes to other 
>>> tuneables later?
>> I think Bob posted something for the icrc issues already
>>
>> Please try to work in a sane fashion, rxe shouldn't be left broken 
>> with so many people apparently interested in it??
>>
>> Jason
