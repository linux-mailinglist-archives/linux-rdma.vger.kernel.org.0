Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8F40826D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 02:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhIMAvu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 20:51:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16726 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231303AbhIMAvr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Sep 2021 20:51:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18CEPnTG003903;
        Mon, 13 Sep 2021 00:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ocJLNbzgj/e6IAevBlKnVB4EpuJHl4hgbn22sHyDnqg=;
 b=zG0Xky+0ln8gFmFDoJRMDq6bOzTphbUW8mOmZ7pvot95xAskAbN8NKUODmZsRDroAyeO
 qBC17be6iyB0PxGjUhpJZnFKFRKeTLyLClQoBBSLB2yESPzQOj64kYvlZSW+TqvJdl5W
 1pvts6lb3nqZBX+UqlQ/Y+c6F5/zJY97VrGBykVlx8hLwubxR0CQ8dtkrqz+zQiLYiM6
 BOnGlerCvDyM0/dUnT4BfpLYdoSlN9QAgNUJgNsZxN2vc7XPIalIikUdom4RijQXdtC1
 h8WbHXoyapJlkK57giZuVYScWJyMCameKFCSbqj+VZIaj87XUi81Kq8VuCng9yhDdRil cg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ocJLNbzgj/e6IAevBlKnVB4EpuJHl4hgbn22sHyDnqg=;
 b=g6JETquuCfDdwgfpTkwHJ7Q+XQ53RGBQYHzS5KPAuGKJuR4j9mxm+rXuHN7QwdFN284H
 Xbozvq0Lp6/W0VUPklEGlRNSE6QwY22a9fAHhEFdZtMSrl6o1JPbkHQ8ghc25SKAZizY
 rC/dEqm9n8iueJs1x1thQPESrLcMyI0DVRnfhttXpMGuwedqpE9Km3yBb9D50Ebj7zSP
 9kCuMkmQOTR6I6YHm7Bmg+FUPavM1Fhj+/FRwsg9JVUJb+pRoF4doUcfWpHOe7j/kaoW
 CfdU0KslE1WMHYctFo9Ye2D+Sg6+ljAACBZfCFLUtxFdlut98TZr3aVozAEuMN2Yxw35 pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b1ka90rpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 00:50:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18D0oQR5078495;
        Mon, 13 Sep 2021 00:50:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3b0jgavg8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 00:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByCYFlCJ6+dqYNG7ZMidt1w3ithwl9FxiN0gtbhQwy3HYOdCHd6c447wLyQ9W088g1xo1/mHQ/2+Y1P3W3jzBb4Y8w1j0uo/BgWisiY5VDJLDwgHNyJtxzzTkkbpplx1lgNdjSfiW8Ory4tpggedfcOpBm5+F7NOF1wvQcNmyfhWNgldlf0Dr6d/dJx+yHsxX/6GNgXag9AXFFR+k/vk4JYNL1anw6G5ATN9dPvcHZsFsTyuX6ueeWCvbiarr8698LamdmRF1XqE0ISaDddYk8qKfo2Myvxwi3ltNzLbOl0klr6UYRT1sggBJohT7+YF4Zcd43i2JdpG5S2qfsQyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ocJLNbzgj/e6IAevBlKnVB4EpuJHl4hgbn22sHyDnqg=;
 b=NwEdfHFmBI4GrJ/MU75dSW/XaG6bz378YVhAsH4tjLIVtJmhvfJSy0KP7tDOuutNJR3WuRrCX3uTZP31Vd1ZAw4Wn1KXkjzA8xwFVibtBDfyr8vYc0rU4LCSC/QT+bb+cUz0CQ8s4fV5fNob2v7EfXrS58ZtumOR4LnKRFBjraOxiTKVnB/vPmgFgddSMD8HenggGRQFjhTZKR6qRaunbHz0rT73dh4m5LoWD3YfSfXK1uDVnkuUrIASgcJv1XTI4xN2WsdX10W+OVm6vTSnr1ZLbX34ZPpz2jQU6tjgXfodC+HkzoV9xuSBfLkav6zNPFh8p6Vc3UqZq9xYkuuk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocJLNbzgj/e6IAevBlKnVB4EpuJHl4hgbn22sHyDnqg=;
 b=rFQ7RG/PKx+YqAO898H8GDEJX7a5WOpaOGqB/rAipwM8ke+cIS3zFURJWHmhga6mKjPmklyNYXJEvK+qgtGZ6MIkc82VU9Utk+2DsWzgo4fTwrcGvJQU6QkkzJR47KW0gGcHk1I0lAKLkEu0X+Y+0JNi2rtlN1Cf0YWn1Ut2834=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 00:50:15 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 00:50:15 +0000
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
 <d89b2a2d-e72b-4942-28d6-c2a528053416@oracle.com>
 <20210806134939.GN543798@ziepe.ca>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <f3849d06-f25b-5119-f2be-4974a72f9bad@oracle.com>
Date:   Sun, 12 Sep 2021 17:50:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210806134939.GN543798@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:400:744d:8000::23] (2606:b400:8301:1010::16aa) by BY3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:39a::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 00:50:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ba26dd1-c7c8-40d1-e9b5-08d976507366
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4798:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4798E8A5F8466A50596AD03FEFD99@SJ0PR10MB4798.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSneVL7RCL9zIdWHKeXgePxWDP5a6G9ZFVxM+q1uBfKRqG8trwZ/B23lkMHFDCecHWNbLJMmamM68AIG5LUtAztZmqjVQjsaPgU0VGD35yyt8CUkWJd6NSIvEcf/Pw4pwUwMzB0wawpuOAwIHlwMmkl2/Fl0t4RcCUv6OCAiPu0ILO/gyRYZwfadJtMZ4LFOFXW9rQGvcyZ/aca7MBqLkrtv7BGxklDhwJI0u9z7J49n4XVkU3F4ei+jetKA3YlaERV/9+vDUSROjwx4Idg+D/pz9Mn1K6o9B1o28/TnF+qfdBfWPZjOL4lQ1tHtYzvoViwfk+Wupsmm7qKUZIepzbAduEBgPKqopFIdyfWyIrWaLZB807Tbq/u0wVaW8Aknng3d8kyBISNEKlNkePdO6HiPt7OJmSXrqpiigl5KbjFILCln3m79o8eVBEh+/s1hO0Bm1PCzJ112ZVPIGuYVn0tNATsZR7CfTwQQ3K/2eVHt2lVxfhlfspgetW2egPB5rkJOF+enmmb9Sg6tclDNgZLPnFUUNrQuxfdEMo5GCNd/QUD9ObWkK8otGoP90thYsDCD2JUFaN4zClti/OlKOTLmsOn2vaVXk1Njy32xmNzK1kP+mDuWViQtKUfzlcs5R7s+yEG6ULVKt+qe6r06vLGEuOhBoCKE+MsLIFva4jJR6/gBxYtDPCgGc//9nrGQmzyzQo8CRJav+wpbvX6BvZk7Ts8Dgt4Vwl3Wnt25qng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(366004)(396003)(346002)(38100700002)(6916009)(53546011)(4744005)(8676002)(478600001)(66476007)(86362001)(2616005)(316002)(8936002)(2906002)(186003)(4326008)(6486002)(31686004)(54906003)(66946007)(5660300002)(31696002)(66556008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVB2bWtMOWtwUzcxWjZJRGlVY3VYN3ArVjN3YmhBb0VVdzUwU1JVVmV6Q3cx?=
 =?utf-8?B?dStxZ3pKdHg1VkVSK0dkS0pVYnZ2bHhSbGUrNUQ0QW1TZ2ZqOGZFWjU2NEJZ?=
 =?utf-8?B?SnZYR1B6VGNISysrSUw0UlVGVUNhR3ZXdXZjOFdvQnZhNWM2Q0NtUjRMWitW?=
 =?utf-8?B?UFVzUWhGNUs3MjJ2NHUrMTlnKzliSE8veldVdXBxa0oxRVJXMWRQN25tdmZ4?=
 =?utf-8?B?a3VBS3J2UnM5RUV6N3NnSFVrMzhaRmhJUlk5Skc4MjhvcDVjN1hsWnd5S2R6?=
 =?utf-8?B?NVJRSnpzTmdlbXpmS0VSNzQ0Tnk4YUVlL1B0dzZXRklPcGRzaWw1SUJ2Yy9h?=
 =?utf-8?B?akpZUFl6VHAxMVR3T3g0L3U1cW5xVFBOWDlzUUZXc1ltenMya1RiL3lLUldm?=
 =?utf-8?B?aHVtTit5cTVjeGFTdFZyN0tCdHMybDVRQk1sM0pJc3Z5NnRIdHdPOXNpOW8z?=
 =?utf-8?B?WTN4YmhsSWFEWDYzcUs1cll0NDNjVU5KUW4wOWloV09OZEJSSzl0MjE4ZEpY?=
 =?utf-8?B?VHdEenB5a213cm9LTUNncGVUVENpVjZCa1hZWm91cVBicWp3SmdySk9NWnUv?=
 =?utf-8?B?Sm5VYkorZS9mSTMveTUzaU11SGNvZHV6blBrckVMUHJzLzNzazFNTEk0MG9W?=
 =?utf-8?B?M1Y2VE9KamtqWEpIRmtrYnBqdGVWOEJXQ0xrZGMzbE9IaE9OcmdrMzRkb3h3?=
 =?utf-8?B?QkErVVMyckFnWFl0WjNGYjdqbzVOelR4VmF0TEU1QUNPb1pZTldKYW8vRVJL?=
 =?utf-8?B?cVBaL0NsWWNJVGRsRTRBS0NpZDRLZkRJbVE5QTV2dklxV0FvSXJlYU4vNDQw?=
 =?utf-8?B?Mm9jZTNHeXRoTm56bnhzWjc2NmM4S2Y3OERZV0F5WG41c2JmMTFDQ2gvcUdV?=
 =?utf-8?B?TzVJL3M1d1N2Rm1xM1ZpU3ZXMUhQUlJmZzhDek1xM2lMVUJIVXRhVWxDaUJE?=
 =?utf-8?B?MjBTdm5zOWJpaWpVTkJxeDkwbmE3RXVsK0dhQVRpSVFVRGxML0c4YTBVdDlN?=
 =?utf-8?B?MWdTRzRxdU1SZTRKSkJWNjlVYXJ1aDF0SDNZU2dWYjRRZnBXVm5yNWszQll5?=
 =?utf-8?B?N2xteEo3SEVPOHBRdElNRVhLazgzNXlHNGtOb0VvRVBhWjFhNDhrcWQ0TG5W?=
 =?utf-8?B?VVVCYjVuUDZsNjl6ZklST29pWk1xTWp6aWkybnY1eUlWWllWN1BjeDluc3Ar?=
 =?utf-8?B?Qk8zcGljMjhCdGM4Y3IyOVdiVjA4UFQzaDNpakd1d3ZTTGRwYzk3RE9pN2l4?=
 =?utf-8?B?cHR4am5hdmxPNDJFYUFtTlhvdG44Y1dGdml3YXhUdFRSblM0QnY0UHNwZ0VG?=
 =?utf-8?B?elVoS2VabHp4cjZKL0tZRVM4RkdzdUFEUThFZFFYSjBjWEVYM0EyNDBDNjVq?=
 =?utf-8?B?cFZEZ0hDT3hFV08yUzd4OVlLZmhvUnM4QTUvVWlPOHg4SFVZaGVaTFNEQXRt?=
 =?utf-8?B?eVhBTndRejlJajN6WlJRQU9zdVo3enhPaUlwS05xc3Nqd3RPbytJT0ZQUXJH?=
 =?utf-8?B?ZkRTejlSMHd4MUxwZXloZnJuTjFYZnJhTTZ0R0ExenRTaHFLR1JDZEdIVUxz?=
 =?utf-8?B?bkQyc2l3WmQ0am1GVnZwdHMvNXliNkMzaGtNRzNjQ3QwR3RxVU96VjNub2ln?=
 =?utf-8?B?bVpYakZJSm5yQ3JvdU5lR2NtWUJDYUkvV3pYKzdJdXJTR2V0em9RR3hZMzhS?=
 =?utf-8?B?aTJYYk8zYlcyNVFsdzBSR3ZWRDh1aHVQa0VtTnpTRjlCckV2VVBTNUtNRDhr?=
 =?utf-8?B?MzN4S25tUlpnZWYxY25kQzdzUG0vMHc3TGtvc1phWnRPQTRyczdhb0IwRStC?=
 =?utf-8?B?MmpPMW5UbnpLc1NWNFFUUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba26dd1-c7c8-40d1-e9b5-08d976507366
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 00:50:15.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McGAKLJ49BXJNHusAAmO9ublhQgF4tfrJF3PWADAYA2Hll8hg2nnVTplHC22Ve6XOmTNMIZ5BMFn0Im67t+3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10105 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130005
X-Proofpoint-GUID: NhXn4LCluHBsqbdYx7gCAasDr4509K8I
X-Proofpoint-ORIG-GUID: NhXn4LCluHBsqbdYx7gCAasDr4509K8I
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/6/21 6:49 AM, Jason Gunthorpe wrote:
> On Wed, Aug 04, 2021 at 11:11:15PM -0700, Shoaib Rao wrote:
>> Bob,
>>
>> Your third patch has an issue.
>>
>> In rxe_cq_post()
>>
>>
>> addr = producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);
>>
>> It should be
>>
>> addr = producer_addr(cq->queue, QUEUE_TYPE_FROM_CLIENT);
>>
>> After making this change, I have tested my patch and rping works.
>>
>> Bob can you please point me to the discussion which lead to the current
>> changes, particularly the need for user barrier.
>>
>> Zhu can you apply Bob's 3 patches + the change above + my patch and report
>> back. In my testing it works.
> I'll expect Bob to resend
>
> 	[for-next,v2,3/3] RDMA/rxe: Add memory barriers to kernel queues
>
> Jason

I have not seen a reply to this email thread. Has the issue been 
resolved and I missed it?

Shoaib

