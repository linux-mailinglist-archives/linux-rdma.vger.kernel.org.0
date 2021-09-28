Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D4041A6A5
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 06:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhI1EkU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 00:40:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19980 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbhI1EkU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Sep 2021 00:40:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S3Bkrs003190;
        Tue, 28 Sep 2021 04:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=blqoNK8CGM9ty+M3u5ilSRFL5IY6T/fQ4UHZRH8HYhw=;
 b=WhsaVWW3jPnd4zu/XuNsjC5/xjik3ly7wf9XjAnXg5vpa2sVGHBrnxrkMyNzCTZDFHnM
 qX3/LqhgrqUMCvXMYlhhWSUBGPgtMQowsOU79t6IuroMwTgkxK8pym7kXynIsBJLDMg9
 2jQNJCQSIEDp1B5HQ1z/MrO9naze2Nh8V8pS7H33sj2jHIG+GjT/gSTa0sSWWySSMF/Q
 ZGZ5f8N9zzpLtWnHXvtumIW+E/rzDAvPa/IZ97MChCRE7XnFMYEH05HqTm6naEaEOaZ5
 rxK53tRIDQEn3to3y0QQdKIYPxLZMyYqhVHxmeVclUraZrnU6MdzoYxlPHg1E9EJytYd OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbejee62n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 04:38:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18S4Z8rT082936;
        Tue, 28 Sep 2021 04:38:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3b9x51e9sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 04:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYwhE+N1w1XLsknWb8fANT65DR8whKU3zaJ6Ljcda4goC4kyJN9TfPS5ImIfg1XZXlYYe8zXu2C3r/zWAdADmg+xYnYbvIDnt+gjNaAXzREIs4nxARGTAwUKsQIux/SUaSxluEysyRUxxt0XglzMYz5VNFksaEae8LnSkYxNOxMvSlbetqKGze4X8iBYgCDDWWeT2P4JQEP4LseRswFY97MROrkRZgb8g/BOGRIRzCAJILTyfNoJiEy9IaQ/VDwFPQr+ycD/JuC7tAC9CSgO/I2Jnoo1kBcRuPmDdPMD9+omMZLNMEZm4PJN2zwyYgU+NicCfyNxI684AmgfHhwhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=blqoNK8CGM9ty+M3u5ilSRFL5IY6T/fQ4UHZRH8HYhw=;
 b=BvArph480TwRkjnBNl5SaHOWh4Q3yTT+Bw2OeVcV4DCXHlwx/dmT2tO6Eez+6ACFXrTgWIWx3wRC8s8GfqUP03vExju78pWmtWYGDe6YoP+LGqSV4VOD77DxK9TByyCEzH4UpNDBEy7LfWzTrn/xgEjs0xF+Ew402AhRraecljSbEP5ugAKHXVI8xZcZ9HKEHCdCnxYC83RtA80OX/AbOi3kOSa5d+J45r2vofZErafT9+W606eUWM7MSdioXtm9sYHHyE5v1K6rwapVLwEPz7z6DoUnXJqtwOFmYu5w/0iAAjG8Ph8PEScrsvpuC9w2Wnz5YtRTJWV087zmRieVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blqoNK8CGM9ty+M3u5ilSRFL5IY6T/fQ4UHZRH8HYhw=;
 b=mjXWw6Eb2biZyeEaJGoounbHMcjAld0K8qpeXX+9wsmUTjP6vyVIFrch0pYOXIsMXoygNnu2rhRHaxr7vpvJkFgspG8OEQ73BOzN09LvlHCj9WyPbsmJX94GndC7cQR9EG/3W1AVAg6WD5mlEac480//db1J28gdpR6luCPmDdQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB3461.namprd10.prod.outlook.com (2603:10b6:a03:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 04:38:34 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%9]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 04:38:34 +0000
Subject: Re: [PATCH v1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
 <20210927191907.GA1582097@nvidia.com>
 <CAD=hENd0BDMS6BL_M2rDT7N8sZySQHLbzDEfWZ0AvSd6nmFmoQ@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <6a6cede4-32c3-45aa-86f9-4cd35d90ab4f@oracle.com>
Date:   Mon, 27 Sep 2021 21:38:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAD=hENd0BDMS6BL_M2rDT7N8sZySQHLbzDEfWZ0AvSd6nmFmoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:806:6f::15) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:400:7444:8000::7e0] (2606:b400:8301:1010::16aa) by SA0PR12CA0010.namprd12.prod.outlook.com (2603:10b6:806:6f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 04:38:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8249a7d0-2d8f-41ec-722f-08d98239d458
X-MS-TrafficTypeDiagnostic: BYAPR10MB3461:
X-Microsoft-Antispam-PRVS: <BYAPR10MB34614DAFA4EA040FE14BD79FEFA89@BYAPR10MB3461.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3H/7fltyO/OhDeaHho6UAE2FoUlmFIg8t6Rx3+g3ae/VzNSlTrC9tHfrxV/MPiNq9mxh52MRve1HG894wA3m9NnNy3iieCZCw3Ac9Deetcw1YMFltJYlcrg8pF03JlAxWRNi5k8Q5iiCZS/N8ZHyrcNhDstXuY+HebIs0Zp2EcmKSwwd0tmFe6edp4ABc++LutQiOzps6mHXhAc3SWSW9vbfrR7VJ1LxaujwOq7rYIIdelsMvcQFuGCz6fW5fYkY5kqdP1tVmX9Q1MUeTRhvKWXvAzx9f5IvNkgejxy9wkitTjKvzAMZFYCmRXfYh8NiqN7ftduCtkS+UcXGiIb8AUtf2MrRLNhx9OGx5/oD0RYQv3yEyET+eWklnaFzv/ToX4A0b7mLj/EeO6p1N3oTBb1hi8Ln+piRgBXL9M+Fcl7RcrZX5aK5zen2nLW3E2l8IzY0FO7WEawo+xfHR7ZKDXBgcrE3pJIhuq8MHfDfWLuSVurDH6ROMMH69ozKnx5281bxGxETwwNaYKWajXbVYn5e3xoAeTMRz6gD7adYrTF0zWdehNYXAKdayXd8GRq+zjSsoeSWaw+YANPTGdOvxPF7WYc++LcTi5j91GLJniLsH3Cagz9LWwftn0ivB0NGglb5hWzmQLrpnpn0MEY7FFGwXXdXmpLQ81ZPOaPxHb1earLca5zLj01TjHrDDIdv1Tu30/b3WcS6YqUac5GrraNL4onBL+hQSvmYp27Sto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(83380400001)(38100700002)(4326008)(2906002)(2616005)(86362001)(66556008)(54906003)(508600001)(8676002)(186003)(66946007)(8936002)(5660300002)(110136005)(31686004)(316002)(53546011)(36756003)(31696002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXVlblpQOE8zVDZsUmw4bGN2ZHA5OEF4UW5LazIwaGdpNHlqNlYxSnRIVG9p?=
 =?utf-8?B?WWxzR3p3S2JETUlDQWsybTVuc0t4S3ZFSkc1TDk5M0JEOWdvY05rT1FPaFJM?=
 =?utf-8?B?VHYzM0cvY3gxRTN0T3kxK3E1ZS9yaEplMEVjUVVmSzNGaE5FMEQwdE5KWjNP?=
 =?utf-8?B?SWRYbWRSZjI5YllMWEdLYW9uaTlXRmdaVDhHd2FnbmZwZEczUnJuV05VSVJF?=
 =?utf-8?B?WE1ycUNneHl4cnh3TWxCbFovY2Nmb2xjTm5lRzhrZzQybzFGc29WRzh4V2dx?=
 =?utf-8?B?dVBCVUJkNU9SMm42cnplcEpQb0FJY21ZTmhvQlUzWlIrZE1jd21jZXlhb21M?=
 =?utf-8?B?V3hnK2lVd1h0S3ZsMms2SDk1NnJzVTRidGkrcW1rckFMZnlpZEtPUWFBYTlu?=
 =?utf-8?B?enVrckRUZ0QzRTlVcXFrUWdFYXRIRW4wYlJuUkdjNzFhUTRNSFIrRlRRNnRl?=
 =?utf-8?B?SDdzOFhqQlJkallxODl4NnFZVnY4VEhZdjVXTlYxdzlwL1I4REFScUZKY0x3?=
 =?utf-8?B?WTIvZzROdDdxUUFSalQ2YzluS0M3dm9XVThXOUY5ODBNb1pMa0FONVpwdkVv?=
 =?utf-8?B?SmU5bm4wczFUSldUWUU4ZXNXNTE3WHZVY01TZlJsWUN0VVFGcTdOTU13YmpE?=
 =?utf-8?B?RVZ3OTdBUnNzWVF5cEJlc1F4cEFoeUJyYkE3WmJDbzkwbEtNVkI1Y1NYSWF5?=
 =?utf-8?B?czkzZG9YdUlybGFFT0RtMkVMYzkra01YZmRFZUlweDY3eEtyYVphQzVYY0Iw?=
 =?utf-8?B?dlRrTk1YdzJlRnF6ODdyamxCajFjamdPcVBIQTYrWEQyWDIvczZsTitVWmxk?=
 =?utf-8?B?NGlTUmFRUFRWbTl4WVZUb0g0MHlzSUNJcCs3NU85UkFWTTNRVzF6VWJ4blUz?=
 =?utf-8?B?UWh4Wi9kb1lKaEk3M2lRRitXazM1a3JPUUNZSThJU043MWJuUldUakhidzli?=
 =?utf-8?B?cGxXT0FEbzdDc1huUThrelVLVis3MlNhWGFaN2JROG54cGZRd2VvcFRMc085?=
 =?utf-8?B?cmZNWWhNaGpicXF5NTdUVGpOWFVYdWRoTVdORXRRYXNWNGdVdFZhQ0Fod1N4?=
 =?utf-8?B?Sy9Fb3U4VnFyUXplekgwNWhsYkVjNnRzb1EvdGlmdjQ1dncwZWthR05QQ0w0?=
 =?utf-8?B?RXZLK3RJTW5SeXk4MlV5NzRCVklVRk5VVHhTdnFveUt1QmNZczNCcDZwa3Np?=
 =?utf-8?B?bm9jN2xqUkR2ZHR2Y1U2T3ZmV3orSmliQS9FQUFqQ3VjZlJPWHFDWVhxOXdi?=
 =?utf-8?B?K0Q4YVJuWXViSVZOOXhlY2VkemNGN2syYXR2Yy9ucWxNdWZuam9wN090WXhH?=
 =?utf-8?B?RDFZeDhpOTVTR3dYUE4wNjF1RDN4Znl6RDVra3hkM2JwOWViODVlNTRZaE1B?=
 =?utf-8?B?TFUzSU9wVmgxcHZaVzQrUnFCcVdiRGE2WVhpVHRPZEVYMGRrMWFqQmU4Vlpv?=
 =?utf-8?B?RXc0UDlOWXNTdVRuMDVpMlBBTVFWdVp2WkF4VTBoYVBCSnZTYkRZREx4VE9R?=
 =?utf-8?B?bVdvdmdIRkVQKzVaTkJkaFRSM3RFQ05sZVJOVmx6ODBITHQwM3lzRTFxOEhv?=
 =?utf-8?B?Tm9icjN1S1pMSXpUeWg3MENuM05jQVZjRDRobnNVOFpzM2VydnJ5T05wVCtl?=
 =?utf-8?B?OGxtTU0rT0x0UGpaMVlwcllQUGpoMHlmS0dZcUQyaDhhUndoSG50b1ovcndQ?=
 =?utf-8?B?YmFrcy9DYUdoc3VtaGxnZWw1L25Ccm5xVXlpM1hibGFtRG9ySldQMUhwWHg3?=
 =?utf-8?B?U0l5eWIzME5VcENWQ3d0N0RxMUdqcVFaL2syaHkwajQ4YjBISXQxanFZV3Q3?=
 =?utf-8?Q?D24jQ291i9GLuHaK/qsLaDapCRKUlk9amhMJg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8249a7d0-2d8f-41ec-722f-08d98239d458
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 04:38:34.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAWFULauSZ8FNznFe9zBDsJxoc0CsW8/xMyu4iDXa9Ua3xSJb0zQOt49dfgnDmU0NBo6k6X8aoybviZ6tE0G5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3461
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109280029
X-Proofpoint-GUID: v5R2liIK7g2xqea5MyMUUFm_2Jrwtupk
X-Proofpoint-ORIG-GUID: v5R2liIK7g2xqea5MyMUUFm_2Jrwtupk
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/27/21 6:46 PM, Zhu Yanjun wrote:
> On Tue, Sep 28, 2021 at 3:19 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>> On Tue, Sep 14, 2021 at 06:12:20PM -0700, Rao Shoaib wrote:
>>> In our internal testing we have found that
>>> default maximum values are too small.
>>> Ideally there should be no limits, but since
>>> maximum values are reported via ibv_query_device,
>>> we have to return some value. So, the default
>>> maximums have been changed to large values.
>>>
>>> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
>>> ---
>>>
>>> Resubmitting the patch after applying Bob's latest patches and testing
>>> using via rping.
>>>
>>>   drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
>>>   1 file changed, 16 insertions(+), 14 deletions(-)
>> So are we good with this? Bob? Zhu?
> I have already checked this commit. And I have found 2 problems with
> this commit.
> This commit changes many MAXs.
> And now rxe is not stable enough. Not sure this commit will cause the
> new problems.
>
> Zhu Yanjun

Hi Zhu,

A generic statement without any technical data does not help. As far as 
I am aware, currently there are no outstanding issues. If there are, 
please provide data that clearly shows that the issue is caused by this 
patch.

Thanks you.

Shoaib

>>> -     RXE_MAX_MR_INDEX                = 0x00010000,
>>> +     RXE_MAX_MR_INDEX                = DEFAULT_MAX_VALUE,
>>> +     RXE_MAX_MR                      = DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
>> Bob, were you saying this was what needed to be bigger to pass
>> blktests??
>>
>> Jason
