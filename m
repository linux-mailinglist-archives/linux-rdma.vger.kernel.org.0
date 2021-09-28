Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6689D41AC22
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbhI1Jna (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 05:43:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60028 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239549AbhI1Jn3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Sep 2021 05:43:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S8oMPl002954;
        Tue, 28 Sep 2021 09:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6AAoh3ecIAX+fz5AD8+hrUaQapO29tLrgIqfurlWrSk=;
 b=fYDhagXj5dIhKX7FW2lVASZWXYeVGx/CYzJG3w8fVxjQYa9BVlKf2UnlpnZmCes4EQGP
 76y8mo5lQAHE60Gbp0/44ApF4O0wcmCrzYz41x4zbmWq91HppTdruXh0ByYikkm8ceLl
 MIrTgUiBdsQjnlrHpUHnOMqYpWgUGCpFofR+XM4CwKpld4OleA4JGiriq04ca22tQSPW
 SLvmSffnRL6Happa6huW0fURkJAj/JqDhsOW/MQZiJC4XsXei5NeTFro0/xOrg5AGJ09
 0tRpsjiPaez+AkYiX28rgpEBtKb/ZElGJvnQEYDWEyNZGZmLRl5ohL6S9JimEVxpxqc4 KQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbj90mr4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 09:41:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18S9VQa1010424;
        Tue, 28 Sep 2021 09:41:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3020.oracle.com with ESMTP id 3b9x51u7tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 09:41:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB41Rm/EVZJKaZxNsdNFPqR0V1ApUuSS2Qg6qhu7BRjMhN71uNtxpoYV0KyapI/UMPR2bauvuWX8m9/zAemWI/cQbhX7UckcQcgNNnB0ABeeZV4hjpjEGF9r+dHh1YIjVg9/CXrtikXsfsTaEbN2VixgxWPURkwDapPgqsJiwJU46mdEV4sKMvhbBiZ/c19kvwcfu7OZJg7OtV0OezJGxfX5WnoU3F+GLMVXqf7Ljqo/soiZ4k4HEmTMfqFPuSXrsBeVJxu1moaCE7GOd9HAhH9HaZ18d/h4mU+GruvbgbsqvZMGLnXcfgl/YXvFMJt2Ur927BOGEqheMr6yNDlTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6AAoh3ecIAX+fz5AD8+hrUaQapO29tLrgIqfurlWrSk=;
 b=bTGdXJAlHNGhFnftRdoZjzxbUg+tx0h59AgIzNKfnxOilNDkx4W68x9zRiZIBpS/kZGrbqzN5KBEZLCUJCY4kiKukO5k7KlT8QEmMYv/p9dXjF1XBLrgt4B0B5/3UASgvV13ytL2jK4v1h0dkaF3vhaTVmKL6U7hULs3WDnhvQYaiV0WpMsl/tNslxYIWUOeh2mQAho2o2cJJTCm4KBLPEqfC138+bZ3EAn6eQ/NY7zGF+15cfIBGnH9zg5JBMyL4kTvpNZnTv8Bku/lUO4jAHTF8IOp3dZQhmPjDyTbEWe0BDPH8Hu5v2N05aQGv4vJ/Dhu0bisKeCIvFLBqD54YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AAoh3ecIAX+fz5AD8+hrUaQapO29tLrgIqfurlWrSk=;
 b=kaVedqHdzXptbdOQzFIOrIXvV7KhXVOYM91u76MUvSEztUQKdES5Npsa6+uUJfOvUDQj5SJYEn5uQxfQuAdPkt3Os4zfYp8ZVkCSIv5veShdm1vnQEC7y7uxvD+sYih2nCAVU1jq8TZuU2878hN46vjoL5YYRMqiJ7gWzA9mQBk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB3826.namprd10.prod.outlook.com (2603:10b6:a03:1ff::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 09:41:42 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%9]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 09:41:42 +0000
Subject: Re: [PATCH v1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
 <20210927191907.GA1582097@nvidia.com>
 <CAD=hENd0BDMS6BL_M2rDT7N8sZySQHLbzDEfWZ0AvSd6nmFmoQ@mail.gmail.com>
 <6a6cede4-32c3-45aa-86f9-4cd35d90ab4f@oracle.com>
 <CAD=hENeQrNPxjgxbPN0KuKF1XHT+GbEADKX1D3pP0qv=gNXN2Q@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <24e4ea29-557d-b2f6-8bef-30af19613b16@oracle.com>
Date:   Tue, 28 Sep 2021 02:41:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAD=hENeQrNPxjgxbPN0KuKF1XHT+GbEADKX1D3pP0qv=gNXN2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:400:7444:8000::7e0] (2606:b400:8301:1010::16aa) by SJ0PR13CA0205.namprd13.prod.outlook.com (2603:10b6:a03:2c3::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Tue, 28 Sep 2021 09:41:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 569da776-7022-4761-395f-08d982642da3
X-MS-TrafficTypeDiagnostic: BY5PR10MB3826:
X-Microsoft-Antispam-PRVS: <BY5PR10MB38265063CBDADEE05CF5C126EFA89@BY5PR10MB3826.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mANzju09/xxB/h3pXKdbBXIMIldqUpTBemlgakwPIkyM/+g6LvDGKiZYXv95RJgPAf5cj4m1fK0PLyQUb+aBalhWJmUX+eUSrmoEl5ANlzgwEJw2zkCpqZxQTOE4Y1vxY2vScfou6NJ520tXa9QxbukDHO58ERy/xUGcIW8McmkNBXA3kh/YEG1546r1fSnFfmrVG5Jpz/t3vQNVwWaRMsI7p3ZADSk6U4J2EP/pIX+wte+Cr7tCct5QOIQWyclz4vEuHqXdtLKtUP7sX8Tr+GbOIGf8rkwsBA4jS7FmixIGGD372q/V60UH/y1NnK//xxnuKxDvnsHISgLhreFRmiD4G+Ckv7bGZhnmvS3Nf59+XYklc22TdTdf8X/MrXt1/F4EEBSuuNAi9y2kN8kHYmdVoE4qJH739ngWUDqb0kDbvf+eCuvtPeh0ELmseDLXCWdYbe8i4MXcC4QnFEvJswUIuJz2jnQWUikFpm2hQ5DW9mOBf1011qDjhTpefV8FZqNviuBGu+tWovsGg20JHAtHnZSHT+sy2B8f09GA0eoUDCPjQneFO77zshFiVagMALnKaQrVap9d4yWsxiDN9brAgxDINuG2rudA+EfjbVDwLbOI9tSdVVBRmSbrIpJAx60dD1RnVaYEfwlPDpNTO+A6xaf8a4us/qIVCOVR/PDWc0dloI+vJ4BlLNmhmjUsoPs3K8FLQhhkxE39ziUvCM+rTai4+UfdMEXiKZr8AOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(53546011)(2906002)(316002)(8676002)(66476007)(6486002)(31686004)(8936002)(86362001)(5660300002)(54906003)(66556008)(38100700002)(6916009)(36756003)(2616005)(186003)(66946007)(4326008)(508600001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlaY0NoZ2ZmOXUwTEVEaGVrWUZlQldLZzJnR3hqcTZyQTFPNDR1aEJXY2pE?=
 =?utf-8?B?akRNTTJhZDhlbm1XYUtTR3gxRFVOZkF1UHAvZU9SbjBMZ1E2OHJmNmNpU25v?=
 =?utf-8?B?RldrKzBKaG5wZ3pLdnlWQXAzbXFjYStGb1Qvc1l6ZlNXRXJXRmtGRXJvSldB?=
 =?utf-8?B?N2ZnS1NENTJ0ajlkdEtxQzFqTlNoNHUvUmxSMWtNZldqVnlIZDRzMnNEZzB4?=
 =?utf-8?B?Y0NpWlp2QmRJalNHdXBjK3Aza3ptU25uKzVGSUprQ0psL1dPRUhwNm1veEpo?=
 =?utf-8?B?N1N6a2xKbnlmY3RCbXhUcmtvY0dacG9jSnhXazZSNmoxeEtBRmpEL00waHhw?=
 =?utf-8?B?OXBzQWhZNU4rRE4zOHZGcGREaWtYNEdtYTRMNkI5UVdYVWxTN090UkdxK0JM?=
 =?utf-8?B?WVNxdkFSUlk1Ly9hVlZtdmpEMldMQ2hkSGhUcHVISzRja3YyQ0dHS3RpZVRW?=
 =?utf-8?B?M0JwWjJKRmtPNVNKcWlHUG92TjBsUDdYcW45c2ErL1ZvVHgyS2dWZDY3em1L?=
 =?utf-8?B?aE53TXlsUWt2czZveTlOK1g1eTdIMzAxVG5WY0ovKzlaR3JZMi9PWTE0disy?=
 =?utf-8?B?VEdEQUcwbytQbU9ZejhxWkhVU3podjA0ZGVEc25YM3NYYW5qaUE3S3Z0UGJ5?=
 =?utf-8?B?MDA5KzhieDFkQWlWU3J0dzlDd1pPbmJFcmVpNkRkSk13bWhNdlJSeG1lRXVV?=
 =?utf-8?B?ZXFhZEQ4Q2F0UlZxWkl2OG5EOFpLY3BENHM0UkJWUGxsdVpVRUJWb3BtTWUx?=
 =?utf-8?B?MUM2anZmSFo3bzNPdjBMbmJIak9XVkJ3dEs2bEVYalVRcWlaK09veDdYaU5R?=
 =?utf-8?B?K1MxWWx4TWVyUyt1RmJRZ2xoYUVTLzdxNlhhWGd3djlnSDBnWjlKL2lQcjJa?=
 =?utf-8?B?aTJFTUcySXR0MzU5OWdGdjVxTTUzZlJQQlBwYktkV1IxSmVUR05wL2FSMWto?=
 =?utf-8?B?OGtic3kyMC9CY01xK21OdGxpWHNGemVnT01xNC9DNTBzRmwzcVJYV1JnWVlB?=
 =?utf-8?B?alFDS09Uenp6M2VGcjdsVXZNNWhhNDhmNVJocUhYcWJPZGF1em9nZEF4S0Vl?=
 =?utf-8?B?RjFCT0RVMjV1VXlpTDBVUHVuWHhYcUZRM0didkdMU0ZwVnBXb3loNGJDUXFX?=
 =?utf-8?B?aVJ1S3hIWkRsUjRTbC84TlAvb3dnM1lsSTFqOHd6a0x4Ry91WlQrOS9TN2hF?=
 =?utf-8?B?M1ZTNFdkdWZya2prcmhpWE0yeWtuanRlcm0zVnRlQllmQno1OWkrVnlneFNH?=
 =?utf-8?B?RDUxaHVubHVpY09zaHZrdzRXV3d2eWxxOUdUbGE2QW5NRkJBVjZMNlROaFlM?=
 =?utf-8?B?VlUwNDR2cTFyNTdWd0pkK0puK1J0UVFDQzJQOGpaWUtubkZ6TXhvWFNJeU5B?=
 =?utf-8?B?NmhMdUVyaUJSV3c5UHNUQ1FtcUhoQUYyRE82UU0zZFZQUUNtVkpVenpBTWl3?=
 =?utf-8?B?MVpaN2VKVEpTck5wRU5ackphR3gzVGJGV0FnRFJvT3FuUzdpazlsWEpMeXpG?=
 =?utf-8?B?aUUySUJuNUZVNnkrdTl6TFRYTnRKZjkwZzkvMGlaRERKcFZ6ZUpRcHcwSXN1?=
 =?utf-8?B?STNndFEzYXFaSlMwV1FyUlBOVzNwR2xvMnR1YVErNHZkYUR4bFhDUVVwN3Nj?=
 =?utf-8?B?c3pRYjBmOWNIRzNVVkpoaUg1WUtZbVBQOUhkdm1PQkV3M3FoTG9hbThBdjI0?=
 =?utf-8?B?cFJXcXQ3N1VnOFhvTXdhSCtaWllpUk51NXd3SEJib09iS1M3OXBjdXRRRVhS?=
 =?utf-8?B?UW9CTjZ3emJ5NVBzVSszeWpzdWFRZVVMbXNISG9IOXJnTE9PcjltQU16TlFZ?=
 =?utf-8?Q?WdK2Z6Z1gDvvolMEYhjDiVi2PD1dm3aLpbYPE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569da776-7022-4761-395f-08d982642da3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 09:41:42.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGMNCO6XuJ8LlemxGhMvH4kY4AeOxnnIz9BZ2PlxLQpbW4MHi/DfAJzelKQm6j9euAWggOL1dwPwX3v3XsRC5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3826
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109280056
X-Proofpoint-GUID: rpVo4ua0d68x_cDGUuSE6fsblUo4Ny9y
X-Proofpoint-ORIG-GUID: rpVo4ua0d68x_cDGUuSE6fsblUo4Ny9y
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/27/21 11:55 PM, Zhu Yanjun wrote:
> On Tue, Sep 28, 2021 at 12:38 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>
>> On 9/27/21 6:46 PM, Zhu Yanjun wrote:
>>> On Tue, Sep 28, 2021 at 3:19 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>> On Tue, Sep 14, 2021 at 06:12:20PM -0700, Rao Shoaib wrote:
>>>>> In our internal testing we have found that
>>>>> default maximum values are too small.
>>>>> Ideally there should be no limits, but since
>>>>> maximum values are reported via ibv_query_device,
>>>>> we have to return some value. So, the default
>>>>> maximums have been changed to large values.
>>>>>
>>>>> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
>>>>> ---
>>>>>
>>>>> Resubmitting the patch after applying Bob's latest patches and testing
>>>>> using via rping.
>>>>>
>>>>>    drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
>>>>>    1 file changed, 16 insertions(+), 14 deletions(-)
>>>> So are we good with this? Bob? Zhu?
>>> I have already checked this commit. And I have found 2 problems with
>>> this commit.
>>> This commit changes many MAXs.
>>> And now rxe is not stable enough. Not sure this commit will cause the
>>> new problems.
>>>
>>> Zhu Yanjun
>> Hi Zhu,
>>
>> A generic statement without any technical data does not help. As far as
>> I am aware, currently there are no outstanding issues. If there are,
>> please provide data that clearly shows that the issue is caused by this
>> patch.
> Hi, Shoaib
>
> With this commit, I found 2 problems.
> This is why I suspect that this commit will introduce risks.

Hi Zhu,

I did full testing before I sent the patch, that is how I found that 
rping did not work. What are the issues that you found? How to I 
reproduce those issues?

Shoaib

>
> Before a commit is sent to the upstream, please make full tests with it.
>
> Zhu Yanjun
>
>> Thanks you.
>>
>> Shoaib
>>
>>>>> -     RXE_MAX_MR_INDEX                = 0x00010000,
>>>>> +     RXE_MAX_MR_INDEX                = DEFAULT_MAX_VALUE,
>>>>> +     RXE_MAX_MR                      = DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
>>>> Bob, were you saying this was what needed to be bigger to pass
>>>> blktests??
>>>>
>>>> Jason
