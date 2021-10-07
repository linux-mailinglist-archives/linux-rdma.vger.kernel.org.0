Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A91A425DB7
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhJGUmo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 16:42:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2914 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhJGUmn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 16:42:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KYYUN007651;
        Thu, 7 Oct 2021 20:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yjuTWJiVXUp0Zce6cqOTjHt+z7VAXCTX5FRymkFX0Rw=;
 b=mnAgtW1XNljguUnxZcVy4mt1UMttvf/O7UfB+fvuPMHQxVqNXlwwnr14IDg2pkK04pMi
 Xzn79QzzTARPM5KIuEQwaXtwz04CVzGlqA9WBjZoVtf3v4ZBlPmSQiQqr7bjQIHnEO6P
 oQLnqLb81gaBMbBOTQV1b05PVzxXObcDpaUq2GDz7qA2quU+/5A18hcOhNRvDNnaegDg
 WOJTVXPsCKF94CeNOdP+7Zu+lP+hxy81V63aokg6TbDoqzq/eye0CXo5U3rV9k3tNI+A
 ib36DDGIGIRqZURK7zDUq9x7qWadsLibaNo3lWEjDeE4cb0ncmy8H8K59LiKU7O7xJ/r Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bj0pw3tv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 20:40:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197KaR3I186615;
        Thu, 7 Oct 2021 20:40:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3020.oracle.com with ESMTP id 3bev91jmjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 20:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuleBDnudNUsCSTVbo26sJ8AYVXwUcV0rijU38sHK+6YfXxYNCGix9p75uSbBGVAYebMwHF/y6CaeIQ7iwsK/K6/Hg/M//5ReyHyJ2+1wlN9j21BFA9/Q2zf5PDh6Idiesy2K72wU9jNwwKOglmy/80eNB6Oqj7d2Udr8dEW0CeiHCRNzrL0LoCkexXybH+67kRyAEU2mgXx6GKSVlVY+rAUQIbNx6SeDCdCiSclP+lyQYvRAL13cJxjVA9RxJcKIgIAE3wfu0fveThtEQBVflYQnpObAJlwSBdokYaH/ZGUgBi+naizYNxn4Q83LQ9t/dCQxzisAJBrWQ8HsZ2u4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjuTWJiVXUp0Zce6cqOTjHt+z7VAXCTX5FRymkFX0Rw=;
 b=UZfMQnzcm2BXkM0b3h5+8TCvk/Pt6g47qpP66Ey/gcVWJqyx7LqVdZudo7vNPrfQURZUI3aCYNxXnABZ8tEF5XeduTlzyFhTS6atrrbS9LozUT1R5lJzb75SAB7SSnTRY1J2U7xS3YoeabIbQwHxwPCVOFeWyvH14+YK4Ljk2DINiUwaw7OAT7DomG3EI7sRBhHKX2tSXW3RWaM59oNKBV5Gxu//j6oxb41R9rogQlw26ZyQcZsl5UhZ2vpUGlagXVH5bxZD7x6jxhb7R1un5bPnH5/YjDN3wm1Q2XkVQNMJFX+VWObNQs9yNd8kiHRfBAr8M2jsUpcLb/EtvaCQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjuTWJiVXUp0Zce6cqOTjHt+z7VAXCTX5FRymkFX0Rw=;
 b=z9d7ql9TyshYUEpb8si3m6hvX6743h+Ki3sToifGgd8frU1mrrK1RoD0nDHjXAtBGByv74tZt07s4QU41mOQFO8JPYWQK1MN94QGnN+hSJK4LYKbtCfviq4dwBWlPFRFhI7EkhE9p/a+6Tcmrd2QdIt2cZjN5TZArRf+gVhrN5Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB3381.namprd10.prod.outlook.com (2603:10b6:a03:15b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 7 Oct
 2021 20:40:44 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%7]) with mapi id 15.20.4566.023; Thu, 7 Oct 2021
 20:40:44 +0000
Subject: Re: [PATCH for-next v5 0/6] Replace AV by AH in UD sends
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
 <20211006193714.GA2760599@nvidia.com>
 <8fb347bb-81b2-2ba6-a97c-16a5db86541d@gmail.com>
 <20211006224906.GE2744544@nvidia.com>
 <086698cc-9e50-49be-aea8-7a4426f2e502@gmail.com>
 <20211007190543.GM2744544@nvidia.com>
 <5e8ff897-ca98-4dcc-a731-2bf150011fe9@gmail.com>
 <20211007195731.GO2744544@nvidia.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <0d4b7d5f-c9fe-1515-170c-314d49feb974@oracle.com>
Date:   Thu, 7 Oct 2021 13:40:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211007195731.GO2744544@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY3PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::19) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:92:8000::45] (2606:b400:8024:1010::17c6) by BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Thu, 7 Oct 2021 20:40:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84fc59e7-86eb-4506-a20e-08d989d2bbf2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3381:
X-Microsoft-Antispam-PRVS: <BYAPR10MB33814C2A030F9954B6689944EFB19@BYAPR10MB3381.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ju4V+KEdIFO1TDy8CaFrQFM2I5yrkV0SDlcGE5emUoqvMl5z0WWbdMiAAocHydOXY8tcp23qyvHufByYToZk40sdp1dqSvDYTd2Kf6DFaK+65YFSgG1u+uXtSCiP1yGBAU8WeJbgyGURVcVtQ7O1V+Wavj7kvuvpEM9g5U61OBAB5pftCDhWZXoDwqtLMSwMPSeSSoPIZMD0VBtpgleMt6VM4WKxZd9hDJeWa2EY09DiVmKVJAG3s3RToAZ/No1PLsX+y1BLzUTDwk0z4sRlOCcOv9QU5RRa5jE0eay+LrqIkpEeSCVs32wEEJz/jc3ipi9W3XWJGYbpFcHtthtjv8c+SJDQQk+u0Fq2FDHRM9h/GRdl9BI9LaNmtfNFwebxlbBsboukAUncvHCp/dkK3EBr83SyXSRWkw9SzXOoYAT0FB6otPvCJ7L1yi+teAvlw8t+LfJIqybVby6UZnv1wevOoTanXv5lGKNaUskDqztYeN/1E+vJe7uDfyFCsuwNnx4vPCpBnpVbrJ3+/y7+1kuFjAcMKRKSD/4mFUchd0pgIe9+lanIodbVxCRlslo7n29LnGqmiB8NXhVw6mdjQ7nnMl26mmXC+8PgJIJHJQheQRL9VThrgoE9fvNAufnAZ3hYK+k0L1iSn1YJYetU//N3eS1NETfTDZbhNmtBnSx44rCLgffKVF/I3c//RFpHhY+t+fXxcXdc+kEDOCd4kNBQlg/vJEUOPZc6KoCZzFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(86362001)(8676002)(6486002)(316002)(31696002)(5660300002)(508600001)(36756003)(38100700002)(6666004)(110136005)(54906003)(66946007)(66476007)(186003)(53546011)(66556008)(8936002)(2906002)(31686004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHNLSlVkbEVwUmNua1Q4TGkza1owY09HRU5vMlJKNUordWE5Tm5HYSs0ZHFN?=
 =?utf-8?B?WGErSVdYS1lJMW9uVExRWjdmY0l3T0pSMWNlRTRvcUpYWkFvODRxVEwzeW9V?=
 =?utf-8?B?YUdYTGtqbTc0V0tOeGtxSmJCWmNHL2MrRXFkMHc0WVpDYmNFWHRYYW9Ma256?=
 =?utf-8?B?aEl2T0RaV1ljWmUyeEZRQXEzVGRNOHMyT29zdmtncXRYUlM1WkdEZ0ZKN0VJ?=
 =?utf-8?B?N3h0QjNzVHNwTThvcXJYcjN2MHVZbCtBdnMxU2xWYVhEUlpsUy96cTdFMG1G?=
 =?utf-8?B?WjgyNG5jeml1ajQ0Zk40b3J6Y2N1Njl4bTdyN25KdnpDVjAwak1JZm1wLzFE?=
 =?utf-8?B?YzJEdk5zL3hvcmErVitPcXFFcTFVMFVXeXVmYjFOQktHWThXemQ5WEtzSGg1?=
 =?utf-8?B?YkV4TUhmZG9VV3RST2JGOUF0L1ZhUWhaengyWk5CUThqRFlNRkZyZkIwVWpY?=
 =?utf-8?B?WnptSFVBbkcrd0ZSMVhFTWYzNFFjbE1jTlVpSDNWQ25PamJkQkxDK29wejcx?=
 =?utf-8?B?dG9yOWF3b3JwNVR6R1pWUUQ1eURmaVhyaDRrSGYrc09obVdqekQ5NFJiV0VH?=
 =?utf-8?B?c1JhOGwwMGVjOFRTSHlVdWFCU3VFUUIvZ1BFV3B6dE01VEJIelJTWlBrdlFG?=
 =?utf-8?B?YjNaWllFNXVPaXhVV21jRktxQ3RYMDFieFVjMVlmYXpJdy9CeXpDUnVLVVg5?=
 =?utf-8?B?dEY2SWlWMi80am4wam1DbGY1VkF0MUlkSWZuTGttMFNrUnVDQXg2NGUvemkr?=
 =?utf-8?B?bWJ0ejU5RGlnSmpBc0dIVGI1dnFjMTQ4M0J1V3RpUTdsSHgyY2xtOUt5aC9Q?=
 =?utf-8?B?V3pOZ3JMZGFUMG5lL0FiV21Qc3Q5RUZsRnkxM0pIM1RUVFZRbU1YVGxhYmNt?=
 =?utf-8?B?YkUwdTZ0WDQyL2dnaDFQNGREK1U4M3gvbm5IcHV1VkJBTHd5Tll0dXFRdm1D?=
 =?utf-8?B?TjE3TjZuYmhTVXBJSVBWbzRVRDhFM2VTOXhJM2pNbG95aFJRNXlmNVVYc3U0?=
 =?utf-8?B?NkJjVE9xUXd0eTZaNDZnWVpkNHErcFVPVG0raEFjNllYV1h6R284djBxS2F4?=
 =?utf-8?B?LzY2MjQ1K0Z6cTJlelZta1dTY1pRb3VjSGlMc0MyQ3VyN244Q1NYNW91QlpS?=
 =?utf-8?B?YTNwMEFQcEtsVno5cEI2bzZQUmZ0Mmt0ZEdCWXFBa2pSeVF0dHJ3bi9tcWJp?=
 =?utf-8?B?MklTYkdiR1p0SDlvYWIvbzgwRDg0NlE0UkFEcTVLcFV6ZUtqN3p3eXZORzVW?=
 =?utf-8?B?dzIyVFhFTnMyZytCM05iRmhqL1c1RytiYjZ2WklycUlQbEdNYVdiSWVlYzd5?=
 =?utf-8?B?ZDFaVm1ZMzFFQTVVY2x3VEpBSWNyeHd0ZitRWWNLa2NWeFZuTkRXaEpNUjgx?=
 =?utf-8?B?bDBwT2VLYkJHdlpoVHMxUEFGaVJqdENpd1h0V0tDWXBGVEFpZS81VTY2UWty?=
 =?utf-8?B?VWJWakVaQkU5eEdDaVI0WnhBMThNVkJnblJUa251VVRURklUenN0WWJuVldn?=
 =?utf-8?B?SG9UN2xPenNZb2N1aFY4Z2xwdFRkK2F6VlppK0dJMGRzUm9pZEd6ZW55T1NF?=
 =?utf-8?B?ek90VWpIdXRjUDBPT1ZTY2Y5SlIzSGowOWttQldBcTkvWGdlSHlaMzY2aHZG?=
 =?utf-8?B?TWtVaXErekxzQ1M3UzBrQSt0S1BPdXBCNkFIVmdSeUZOM2FXUXNKZHpFVkpS?=
 =?utf-8?B?WVRTQUkrSlRkSHFrMzFjVWlOTFgxWHlpNnl6UXpmbFovdm11d3BLUng3S3cy?=
 =?utf-8?B?cElzOHJ2aDJIakFLbzZ5NWxqazE0NS9pZlcrYUozakg3bjZXOG1ZQk1VTGFZ?=
 =?utf-8?B?SmcrSUZ2T0hBT2c4V28rZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fc59e7-86eb-4506-a20e-08d989d2bbf2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 20:40:44.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2KlEmavlF2kQlnvf7HB5fXPeZSqy9D3hAqEMhvL5l6GotPT4IB/7mc7t0qy87ZLV+lNVjgOZoqK5dDSGnKfFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3381
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070132
X-Proofpoint-ORIG-GUID: Ba5pcbbny_3Y_wv--wBgwCLq5fAeQAQ9
X-Proofpoint-GUID: Ba5pcbbny_3Y_wv--wBgwCLq5fAeQAQ9
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/7/21 12:57 PM, Jason Gunthorpe wrote:
> On Thu, Oct 07, 2021 at 02:51:11PM -0500, Bob Pearson wrote:
>> On 10/7/21 2:05 PM, Jason Gunthorpe wrote:
>>> On Thu, Oct 07, 2021 at 01:53:27PM -0500, Bob Pearson wrote:
>>>
>>>> On looking, Rao's patch is not in for-next. Last one was
>>>> January. Which branch are you looking at?
>>> Oh, it is still in the wip branch, try now
>>>
>>> Jason
>>>
>> I see the issue. Rao is asking for 2^20 objects max by default which will
>> require 128KiB of memory in the index reservation bit mask for each of them.
>> There are 4 indexed objects QP by qpn, SRQ by srqn, MR by rkey and MW by rkey.
>> That's 512KiB of memory which seems excessive to me for many use cases where the
>> number of objects is fairly small.
>>
>> The bit mask is used to allocate and free the indices and there is also a red black
>> tree that is used to look up objects by their index (or key if they use keys instead.)
>>
>> If there is a usual way to address these kinds of issues in Linux maybe we should
>> consider that.
> Use an allocating xarray
>
> But for these AV patches just fix the merge conflict to something sane
> and go ahead
>
> Jason

I did not want to increase the values too high but we discussed it so I 
did. Let me know if I need to modify the patch and reduce the values.

Shoaib

