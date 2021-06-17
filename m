Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EA13ABF1D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 00:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhFQXAE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 19:00:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39840 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231623AbhFQXAD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 19:00:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HMpc0v026033;
        Thu, 17 Jun 2021 22:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lKz5DNXE38Qmc9uS3ekAdz1djjkMK/zVvEn4FW6D7QE=;
 b=ETc7FBUiIChr+f8vtS724/VR8d5riF5YjwnVi7WoFbuUnpnjd/SC4VpH2yzgFBGLqH/b
 BFrXRAvsLvaDyBCh/u7bj1xJP1F9eJvKY8gd/pxS+rXwVg4Pr56HB5EX40FxQh/Jvuxu
 TOU3wW09RklhXrZDdb1BC4rujqwRq7lO9dOH9zo/EPKHgtt1J33X40p6YGJe7pdsuXlX
 5UPLYrQgrayXpreMkNRuW4wA2bIpzjtvZTGyM5dQVgb2lcfhc53f3rYkrdjTwoHfqd7f
 MghtfLc5nuwvqSdziQTXpgtofhs+q6kcmhiG6wj2eWnGKexqJ/2GhTwJcBlG/bqMJ4Zl sw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39893qrr20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 22:57:54 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15HMvrmp137494;
        Thu, 17 Jun 2021 22:57:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 396waw2cvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 22:57:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cykLFRlUtENrV8k2pXHyW2KPmoJcj66A79a4jsMd9T3YIuCGyJDRmSiQHLCK3QsqAIzDxLjc4RooHi7wIQqtk7k2meFIGoOAfKt1c4fqW3MBUaBBcfSGsmHEwjLh5G7HL3fyy1k2+vSH8fWrRL3xfSPeX7SIMfE+C5u/bQljwbfVagJFl+nV9AnCw1AySPBiAgARYoYXXk8nLGE4Dj/4eHa8WJMyBNyhnrpgRDEM3bXOdR4bJhK2t5ARMYI9SzONTkKlai0hOTEmXkHR4bZeQ6xBC1HJ/iWQO0+/7FmfxQ2rHPJmZ8041e3hsDRkOQHg7pVlExCdrcFUaIJIhW+BBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKz5DNXE38Qmc9uS3ekAdz1djjkMK/zVvEn4FW6D7QE=;
 b=AVzIgIzIeD/bEWxpoAYwvzdVkCohbSeLHQclTg++zXpUoS7SF62JJbN2Kq4H31YpDG+puiv6r65BAt1x/JMwyd1S0K5ZobbZk41y4KUCAFZpjz6RW4PKIdhJSC1vv72AVpYbeHM567g05RdK/8KOAuuoD/bEDY9v0/VasT2Z11IfSOV4I9zZbEhJzuzbaLr12T4KqYZBAOf9i90QF+CxjkHmvXIXK/O0C7Fa+ovFvSYRfZWS13/hyz9VCA/JIk6YsBuEy/BVzshwekIY00XRQCSVuFT30VP3PvziRMZctE4S9yRH45GiR1qAewiPldByEA23XzLW7Ammwo3iZly56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKz5DNXE38Qmc9uS3ekAdz1djjkMK/zVvEn4FW6D7QE=;
 b=t36c3OfDMaYNZggSetm6XVlGIlbBCvokD/VdzJ0SS7VMyeVn6gY9rbRhBxqf881+NPsbCIdCRIwC7YDaPBlAjpJITFIuwcIUUh5GCKHk0qmpfLVfigf7z1h8qnHBzVe81Wpe47fACsByFW9IQgFnLkkUrOQD6TM0om8yQU4YI2c=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by SJ0PR10MB4525.namprd10.prod.outlook.com (2603:10b6:a03:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 22:57:51 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd%3]) with mapi id 15.20.4219.024; Thu, 17 Jun 2021
 22:57:51 +0000
Subject: Re: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
 <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <10d9763c-4d10-3820-93a0-b79f55acfa8e@oracle.com>
Date:   Thu, 17 Jun 2021 15:57:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.170.87.114]
X-ClientProxiedBy: BYAPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:a03:117::36) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (73.170.87.114) by BYAPR08CA0059.namprd08.prod.outlook.com (2603:10b6:a03:117::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 22:57:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4fbcc09-85dc-4ebe-226e-08d931e355b9
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4525:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4525E003CD61A74C7BE39B5BEF0E9@SJ0PR10MB4525.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBes4vFEp2tdu+mS2/w12bKDxLOREZi5dLgRKOfRhtJIoYiLo+vcjVmBaImmETGYuPgRBKV3axCpCDma5SKBWPDGugnnz/VReVWNML//htlqvxNzJxE0CpUktE4yKHNP8VldJo5Apb3hJR4j0od7NDPrOSln1/KILOMdbRqNtxclQq2ZKwS8OegKlvHOLCYYSAfaLr8ISZrhLeorTQGYo9buIvtLbTbzCuLZHwf/vy8uVoEMlbeIdfOKgv3LA4MGyoQscrjvm4LPr/ddPAcaTSHzqlJ4zs4ePzVzDjr7WTg8iYwDbzmKk6eeEJ4Csn4vdWFa0rguOVuRcDGYUBpmtvN4NTUeDUh10bl3fBH+X9u1GOrbrVtApDp40O1uF/cRQ8/QOh1h+Bde63PpFniDQ8kOBO1XMXOa1ViccSepCPoO9Y8lhMMoeB6vlFgoWbnjSpGiEcoXtss1oNQXC/YEaEWz/30wpWns4+RxsOlrgWmBDJ/zYAfv6323kuWIKXx4uJ1FsB8ZVbRO2hn6vMJd2fFbvThHJ2bmYJLRB3uqHvpVS6Hc8EJ3/QS/lIZy1XYEVyf71u0ALqyhqhm8vnXl9GuzAhnWAwa9SJBgcCfhjhF8p07vv1HpEzys567XfmoG2aIRcRWVHyUeWuQ/O0bAFxo12Fj8n8BltIxMWSkPdSbQ/5wbJt6QrIDDY33Jv0lm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(376002)(39860400002)(5660300002)(186003)(16526019)(316002)(38100700002)(110136005)(66946007)(66556008)(66476007)(26005)(478600001)(16576012)(8936002)(53546011)(6486002)(8676002)(2616005)(956004)(2906002)(31696002)(86362001)(36756003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3lNcFRiSFlQUGRCc3c3UHJTSkdiMVI1bTlHYUZUQmphd3Y0Z2FpY2p6MXQy?=
 =?utf-8?B?SmFhM3lROEFXWDhJTklJUy9ZcGx1M2gxUGpyR1B4RjRzcjZGa1BIUU4wUmZw?=
 =?utf-8?B?Rzh1Vkc1bkJiMjBqNURPbjVyT0hRR1JUcnl2MytvUlUyRWVDZng0aThURDZ0?=
 =?utf-8?B?YitQSUJiMEFJMGFKNXBYRkRVOHM0VXJqSWM4MEhkVmhxWjU2OStUc1NtZ0Fj?=
 =?utf-8?B?YkFEaTlENHJSSzZxU2p1b1JUTENsTjAxTzh3cUNGUGFIVk13azVSMysyVXY0?=
 =?utf-8?B?MjJjT0dKOFVxRlFUMW1yUGtaeDA4cEZLdGo3MFpTMTRraFBTSDROOXlpdEdu?=
 =?utf-8?B?N1c1bjkzTklzYmJ5by8ySE5CdkNvMnM2cFFxOTlocUxuRXRheDdQRkVibW1h?=
 =?utf-8?B?alBpNHdJUGhnYmtCMTVoL3VqVHZIdHZqMiswMmgwQS9CL21Kd2kyWHRVbktG?=
 =?utf-8?B?VHlXYnVwVGkzRkUzazc3MjdvMkc0cTZHU0pLMTVtNTBjdGVNZHVEQjdBZVM1?=
 =?utf-8?B?Y3FYTjRPZnBselg0enhzSTRXKzVPeFRxNEE0WjFuYmhFeUJPeWtHaFNjMU4x?=
 =?utf-8?B?a1h5TFp5MlFSSlR3YzZodzI1dk1sR0NoQkhBVENVTVM4VjIwS21Qa3pCMnVW?=
 =?utf-8?B?V1dSbm9UVW80N2J0d2hOQmRpMkdBV3hHVk9QZnNKbEV5OXZyaDF6Z1lJVnFX?=
 =?utf-8?B?aXBGTnlUc2c0TmZlS1Zpd25sSW5DdStzbWlLN1FJQ3cvNU0ycjVHSkRRLzVJ?=
 =?utf-8?B?UmpkVjE2RjA4amt4cGRtK0pscUpieW1XMGYva0twNkpXS2JzdE1NWW1vaEQ5?=
 =?utf-8?B?dHB2VkEzZEl3MjJRZHdjRi9oVWFZY2cyaXNuRXZNc1NGUDM3NkFvVTRsY1Ux?=
 =?utf-8?B?L2MxdWhEdTJwTXNEQkFaNHV2Z0c3VVo0YlpYNVZEaUFWR1BSTFBNZHBiNElF?=
 =?utf-8?B?NHF4R0dsbEhrQ3pQV3VITm1ENVZ6QTFpR1ovbktMRlc3QkdTdWVNalZVQ0Qr?=
 =?utf-8?B?Tmo3NURIMkVDb3E0cGFGYVg5M1hCaExvcjVoUVlRVzB0Zk5ZMkVNc3p1MU54?=
 =?utf-8?B?VEJ4UjZORGpPZ0R5dENpWi85aHNLUzh4NGNtcFJyM3JOYkt0NHhBbXRYT2Ro?=
 =?utf-8?B?a3hOR2dKNHB5bExCM1h1YWxnSmNBZStCalg4NEtCdzBWeXhvV0ZiYWtiTXFG?=
 =?utf-8?B?NjloZWNldCt1QnJpVWh6Rm5wY3JYNDFmL3VtVmNpK2lmRnE1OWM3OVkvL2c4?=
 =?utf-8?B?ZEtCT1Nmb2N3YjM2cU9QWmxUVkhoZ1hoblZzNndsTUIwTVlmUDFnOGNUSEFB?=
 =?utf-8?B?d2ZHT2NNcElBVXR5bEE4ZC81dmQzTzJvWWdKc0w2MlZsa1JSeXl0elJreTVV?=
 =?utf-8?B?T1daYXZhWXpuUk01aFpZRVJRVTNFTTlvRnFLSytpc1FCQk5XdytwZzV5R3pW?=
 =?utf-8?B?c3oyMlZSbTQrbTFvcUNMOENpd09uTjFzM1EvbjZzRGREZmtwVmx0RXlvdnk0?=
 =?utf-8?B?YVdsMTBUWEl2TkliU0xEYjYxTXkxdTNUdlN3dmIzc3NNY1hrd0hZa0ljSVpU?=
 =?utf-8?B?bGcySXNYUUk1SGhrL3k4NG51aUpnYnJIZzltcU45Ykl0em9HWTZLdm9zcmQ2?=
 =?utf-8?B?dXlYbzFCY0xKZGFBdThMYkJzYjBMa0ZQWEpMVllDdmdINGhmZGhtaHFPMnN3?=
 =?utf-8?B?RGxSbTdSckduUFMrQVVJSzcvVnBMMXNpK2xZcExtbkJPN2QyL2E1WkgyWkd3?=
 =?utf-8?Q?O5nC/aqj/8GIuHrSYSmgBDIHvHyXDQhpI7Ib27x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fbcc09-85dc-4ebe-226e-08d931e355b9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 22:57:51.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KugZms6EcHrQtjpXETX6wzJ3KuIj83xaN8nMYOfF54lxxjeehtpy/Z6Cz87YucZqXh5+azH8ZRD0O5k9gjXnLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4525
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10018 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170138
X-Proofpoint-ORIG-GUID: PxEY-eErWQAEbhCVNFmgMrvCucojCRI9
X-Proofpoint-GUID: PxEY-eErWQAEbhCVNFmgMrvCucojCRI9
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/17/21 1:45 PM, Bob Pearson wrote:
> On 6/17/21 1:25 PM, Rao Shoaib wrote:
>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>
>> In our internal testing we have found that the
>> current limit is too small, this patch bumps it
>> up to a higher value required for our tests, which
>> are indicative of our customer usage.
>>
>> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
>> index 3b9b1ff4234f..d375f2cff484 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>> @@ -66,7 +66,7 @@ enum rxe_device_param {
>>   	RXE_MAX_MCAST_GRP		= 8192,
>>   	RXE_MAX_MCAST_QP_ATTACH		= 56,
>>   	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
>> -	RXE_MAX_AH			= 100,
>> +	RXE_MAX_AH			= 64000,
>>   	RXE_MAX_SRQ			= 17408,
>>   	RXE_MAX_SRQ_WR			= 0x4000,
>>   	RXE_MIN_SRQ_WR			= 1,
>>
> Interesting. There is no real reason to pick most of these values since it's just memory and does not reflect underlying hardware resources. It is advantageous to also be able to set them smaller to verify whether test cases correctly limit resources. It seems that there should be a way (module parameter or other) to adjust these values without having to recompile the driver. Thoughts?

I agree with you 100% but it seems like the original design did not 
intent to make them configurable at run time. I see that recently some 
other values were bumped up by others so I went with hard coded values. 
In the inhouse kernel version we used to decide on the values had them 
configurable because we did not know what values we wanted, and 
recompiling was time consuming.

While some tests may require small values we want to test with lots of 
users/connections.

If there is consensus I can submit a different patch to make these 
values configurable. In the meantime I hope we can bump up these values.

Kindly let me know.

Shoaib

>
> Regards,
>
> Bob Pearson
