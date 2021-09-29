Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754FC41BDD7
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 06:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhI2EDm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 00:03:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27948 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhI2EDl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Sep 2021 00:03:41 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T2ECr9013615;
        Wed, 29 Sep 2021 04:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Gp/0PSi0ZruyQsIBOuU5ui+bHdk1ggdq2s3uwxt8kBo=;
 b=X21+gxCL2Hq/dfIrZT+LIR0Gtk9TryFcCewnAKS0Qo+zCh0ozbERhR7nrLGk/EeM23EK
 x8O/fbeFu/e6qN2jIwHvxn4aSPwHPtHM5yrYjzzAePi0NNmgpUp3sBYr5TtRsleSfb9P
 CU6AOYj7hE7Kb9g9SRC+/F5KxXyR/PDLFLd06RONeblne12ivg+4/o/NWgu8KwqGvXjz
 OhzxPzLjGzC75hIpfpsTY+v7kLtFA64NdEJQRK9ZkjloyHCr0ZV527VVc1xHRJY5VY4y
 PfQ4ODkncpISex6rU7UnAqvcjKo1IWAoFXM00+d9KMJ4BYUbP6wv6SlPTGgxlar6EUfI kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcf6crame-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 04:01:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18T3tePT077542;
        Wed, 29 Sep 2021 04:01:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 3bceu4u97b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 04:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0neyRlR7owyQOB5dXL7CCfx3zJaKkHRdGIOToZ29psTHLPXxsBlR/slisekum6nm/eSntzU2JjsjghgL+rp4242TVTwCD//fBb1v4XNIXD30V3k8IWLbViUGmhwGLbq1Cbp2yieW0tWt1aaXBwHr08ImuRX8n/Ki5L3KC7YjBQryuXUR93t9UFLqhF4PkM2bw9RawPxiLS5jRb6KricTDpYjjrp7PULcMnGVO2X7WL9JHD2/dmex7UoaPuozu02hes0fGN95BA2V1Nu5F/A1zhDke68Kf41hZl1pBFPlvUewR6BM04MwJCqTp9xvg8rvN5dDRsqLZO5mUX7Npx2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Gp/0PSi0ZruyQsIBOuU5ui+bHdk1ggdq2s3uwxt8kBo=;
 b=fkqQGpzSNnTlga+CaVmr9wqOVEchEMymRfj3t2VOVRJdrxry+e7sHorIooIEYd3o+Ln46qPnk297Jg66HxIqu7o/UaqQZYaEIGRmhhC0eXLDKU31qdS3WSFdsHlosT0dZWViQ2w5cG07tmO3VY5cUOLt3Naj+pgRsuuMExH67eGyFvRiOqFNiB+NZuFeuaLgnqI3JG++/RTusIzLQa25aNruaj48OzpTs0p5WVwGQIFppsijmSQ9P5TCjH18eyrB9QE4IpfAhRxhI34vqhbqjuxrLlRElFWfmQP3KAdpzXVs3IS8IRvtFVtZo9RnQyLa4db1Im89GSfmbGe0NLEvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp/0PSi0ZruyQsIBOuU5ui+bHdk1ggdq2s3uwxt8kBo=;
 b=YHrtEfuuF8i/hLUhLoOp3D/q+iAKm+nkqbVxVaW568pBXGTNpdWAokZzHoK0O+YFTBy99HC9mnfoWlHmmmkzKF6PLCyzqbzr60v0H41r/Xoknu0a/X1UHNMl0FdouNzrRFJ9TYJoNKP7Xuv+wqIURJWaistdQrCPI2pZ7rr+es4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by SJ0PR10MB4447.namprd10.prod.outlook.com (2603:10b6:a03:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 04:01:56 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%9]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 04:01:56 +0000
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
 <24e4ea29-557d-b2f6-8bef-30af19613b16@oracle.com>
 <CAD=hENcn6vZMx4YM3n4Kdo_kBCM_aHK8NOa+QgaAPnNk9jK60w@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <cd243ca0-859f-42b5-6851-6b0be7385a7e@oracle.com>
Date:   Tue, 28 Sep 2021 21:01:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAD=hENcn6vZMx4YM3n4Kdo_kBCM_aHK8NOa+QgaAPnNk9jK60w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN2PR01CA0045.prod.exchangelabs.com (2603:10b6:800::13) To
 SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:400:7444:8000::7e0] (2606:b400:8301:1010::16aa) by SN2PR01CA0045.prod.exchangelabs.com (2603:10b6:800::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Wed, 29 Sep 2021 04:01:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f0c26f1-cc71-45a1-10cb-08d982fde0c2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4447:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4447CC8CADF287A3F6978927EFA99@SJ0PR10MB4447.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9PohxLmEOP5g2CbnzHsmfN7x39QfR9KaPZXKEqNdGkXv47cwOngEZ2E7PEcqE9nByXkLD8WLf0Y5KaIl3Tv5k0lnGsBvMzpW+l55nhTSk7RtkSQ3AQK+A1sbkjffXSzOFFV6z3W4HdVxh+iT5WyWWpTxqEGGck9Iufi+KrfIxXBPb5FX24l9Jtmf+lulEcuevk4Oi2EggA4h/G+7kvZWrephNWW1BkAomQHkHYlv059g1cKpY0brSHntTs49NbsOhRIM/M7cMOBCLvA90DMFMIn02ksScqgAa5DxwiizQVN0KTLH2Um1B7IrtYczVjAI9OYNuTpTbzyYi0P7vA+dZt9vkHqLNSDEF/17CFWOIMoObQ9SktP6WiwzYlJ7eFST1XoKhHFMYTC5oFXRftdqMK3OiXpCBUG/V77XWe1XtAR2wg1XStfSLvJPY1BnPSkGyzFs4uj/ezLGOnBzJZ33N8HxWnEfoSHh90f1WZAeTBQ9202H+nWdE2iW2WM7EAx9UgzuZK9SZKVd4S5wL7UP6MDZRjmTbAnD8bDtEOJl1Mjq/0p4mpOavaFfGoKHPWFzaCAr7doQWpYVL9B8nHPSbOrLy/3E1zt6XcDnGRZjFkzx4ya0NlBZ2HEZyYxDPLjJ0g8BpMDL74Fd0jxABmIr1Bk1oDEtNeko+KaTIojA6gltAoGxrdryDSPM2tKGoui7hLGflEBim0uttjarBoQqFzYJACDycrtmKSVBmejBQnDRikOMIn57U5xLyNP5Ko/nVehoMaZAbizNotCO9W/xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(6486002)(38100700002)(5660300002)(8676002)(8936002)(186003)(508600001)(31686004)(966005)(316002)(6916009)(54906003)(66946007)(66556008)(66476007)(2616005)(36756003)(83380400001)(2906002)(86362001)(31696002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDgzdEZYa3VMQ0N0WGZaUGZKbmIvZm83RHNndFlWWUcxVVpUcFBQRWZMbnJz?=
 =?utf-8?B?ZFBYZXIrdEkvTVY0NHNFUjZpeUthbndIWS81SktxbCs3RjBmcmNGbnNmNkE3?=
 =?utf-8?B?UlAzQ2VkeVVRNXg4SXcvK2NkT3ROTVBMakJJUGFnc2piYWl1QXBPTmtYZDBJ?=
 =?utf-8?B?M3Z6ODJ1S2pEUDQ2Zk9WTGlzVVlsb053dmFhbm9NRi9reEY2a1VsWUsrbGRG?=
 =?utf-8?B?NUhxbk81MkxpZWRCdStWd1JoZEhqTllYbUlJZGROZjZtWkVFK2E0eFAyRWM2?=
 =?utf-8?B?NW1RMGorc2VJdG5uS2dNc3lVeGJjYlB6OVQ1bkRFTkRMM0trdlhTaTNjTXZi?=
 =?utf-8?B?MTd6VUFlYVJFcWkveWlRVW4rWE9WZUJpdzk4OWtZa1l1K2FHMTRpYWhiNGZE?=
 =?utf-8?B?a3VVSUxwc1BkRnZqVjBWZjE4emk1REVwU1NuYkhqbUNiQmpFeWlJTnl5TTc0?=
 =?utf-8?B?K3hucnVaem1sUm1DeHdrN1BacnZNT1ZqVkRGYXpUcVJuQ04xNFUyUlprU0RT?=
 =?utf-8?B?dFEyTHdkbU4wUEZ0eGtLRVZKc1dRUEFCUm14Nk9pNmtsUkQzR3hZV3NkR2Fr?=
 =?utf-8?B?WTlqRUJNcWZJYVBlMWN5VGlkbHpHT3FwM0k0RHRSM2hCVkZNOC8wdnN1eFFY?=
 =?utf-8?B?QmkyQzhiNjYyRGVKUmZkSG1KVFpHeURTcHpRSHpsL0hUbnRjMzV4R1dPNmlY?=
 =?utf-8?B?bG9vYUFBSmNDaGZRSFkzdElJV3hsT3F5L0dNZmFaT2RkSlAyTEhaNGhaUHVr?=
 =?utf-8?B?cmNMZ2lhQWhDc3dCbFgxK0d0bUlOL0JkRjgyVkpNTGFSOHhOQUExUnMzVGt5?=
 =?utf-8?B?cERxSmc2SjkyZHlXbXZrNlVQSzVNRDAvUysreURsbnBKeURCQTh1QWt2LzdQ?=
 =?utf-8?B?RkVPRzBTM0JuL01pV1Z4eHp2N2V0alJpTFByd3dwa2xoc3gwbHBFZmdZVHNo?=
 =?utf-8?B?N3lsY0pTc1VFcXl6MGRqZjY5SUhPTUFPb1YybXpBa2pHRDEweVBFSDQxelJ5?=
 =?utf-8?B?SStFcWNueS9DUEI0c3Y3ZFkzWmcyVjI4M29zbWVNMTQvMjMrUlQ1VmVxejVO?=
 =?utf-8?B?VHJDUWFoQktpNG1icjVSWFBkL2gxY1BzNWZ3Z2htNjd0N2g0ZlczRTFIZmta?=
 =?utf-8?B?bml5SVZMZi90UWlkbUQxTC9JUkRiUmRyaHNUeWJzR1MxeTVyU2lEK2ZtT3lF?=
 =?utf-8?B?WU5sVnlNY3ZCMjdSRXVnb3ltSVlpemo4azlWVFpPTGFHVVMwV2gwSGp1RVNk?=
 =?utf-8?B?MjA5N0tMajNzd3BYK2NjQWc0YU1YZnk1RGEwWTlpMWJReUpGZSttZEtrMW1t?=
 =?utf-8?B?Y09wbnN5czBZZmE4U3F1U0tUZnZ0OVNkNVRBWWVHS1NpUXpVYUZPYUg5MGtv?=
 =?utf-8?B?Wi80Zzliejg0Yk85ZlJNczAydXdySGovd3lzZHgvZmlUT0Z6cENKZTVLa2x5?=
 =?utf-8?B?OG5QZ3RzYnlkUy9sdTBNOGxPeVpWVzEwUUNvbFJXS3ZRcDY1Y2xZS28rcU96?=
 =?utf-8?B?OGIvTlRKZ2h0dHFzUWZ4am9vZEd0Y2hLN3VIMmF4aWptQ0J3WTJqVkczV09S?=
 =?utf-8?B?bGNGTWZIU3lqZFI4YTl1RnhHdDd3U3JJVnd1Q0c1MTBvbGFlZFM5aUhiQ1B6?=
 =?utf-8?B?ejNHZkM0U1BmdHVPUndGaExIUW8xcDZjVVhKQWtqR3B2bnZEZ0dlWGJkUlh4?=
 =?utf-8?B?SFNjQUtmM1Fqbk1yNmJ1QXFnZldWRTNwd1lZckNJL2ordFY4Z010Z0NXS05P?=
 =?utf-8?B?WXJjT2ZxRS9WemVQd0FQaU9iRVBvR3NraC9ybHhmbWwyYkJRUFRLZ0xldDJa?=
 =?utf-8?B?b3NpeFgxZzI5UFkrcU5TQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0c26f1-cc71-45a1-10cb-08d982fde0c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 04:01:56.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVCXpcCrcz9Jh7HH70gRfdvF7Z38R+/xdRBPkUfvZoBiGS7RwdfTakUiwY/z6FZzQSYpdL96T79ITzmK0LJuqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4447
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10121 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290023
X-Proofpoint-GUID: jHMsAThK5L2D00zds-_f0rlvAt5RkVof
X-Proofpoint-ORIG-GUID: jHMsAThK5L2D00zds-_f0rlvAt5RkVof
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/28/21 2:58 AM, Zhu Yanjun wrote:
> On Tue, Sep 28, 2021 at 5:41 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>
>> On 9/27/21 11:55 PM, Zhu Yanjun wrote:
>>> On Tue, Sep 28, 2021 at 12:38 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>>> On 9/27/21 6:46 PM, Zhu Yanjun wrote:
>>>>> On Tue, Sep 28, 2021 at 3:19 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>> On Tue, Sep 14, 2021 at 06:12:20PM -0700, Rao Shoaib wrote:
>>>>>>> In our internal testing we have found that
>>>>>>> default maximum values are too small.
>>>>>>> Ideally there should be no limits, but since
>>>>>>> maximum values are reported via ibv_query_device,
>>>>>>> we have to return some value. So, the default
>>>>>>> maximums have been changed to large values.
>>>>>>>
>>>>>>> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Resubmitting the patch after applying Bob's latest patches and testing
>>>>>>> using via rping.
>>>>>>>
>>>>>>>     drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
>>>>>>>     1 file changed, 16 insertions(+), 14 deletions(-)
>>>>>> So are we good with this? Bob? Zhu?
>>>>> I have already checked this commit. And I have found 2 problems with
>>>>> this commit.
>>>>> This commit changes many MAXs.
>>>>> And now rxe is not stable enough. Not sure this commit will cause the
>>>>> new problems.
>>>>>
>>>>> Zhu Yanjun
>>>> Hi Zhu,
>>>>
>>>> A generic statement without any technical data does not help. As far as
>>>> I am aware, currently there are no outstanding issues. If there are,
>>>> please provide data that clearly shows that the issue is caused by this
>>>> patch.
>>> Hi, Shoaib
>>>
>>> With this commit, I found 2 problems.
>>> This is why I suspect that this commit will introduce risks.
>> Hi Zhu,
>>
>> I did full testing before I sent the patch, that is how I found that
>> rping did not work. What are the issues that you found? How to I
>> reproduce those issues?
> Sorry. What tests do you make?
>
> Do you make tests with the followings:
>
> 1. your commit + latest kernel  <------rping------- > 5.10 stable kernel
> 2. your commit + latest kernel < ------rping------- > 5.11 stable kernel
> 3. your commit + latest kernel < ------rping------- > 5.12 stable kernel
> 4. your commit + latest kernel < ------rping------- > 5.13 stable kernel
> 5. your commit + latest kernel < ------rping------- > 5.14 stable kernel
> 6. rdma-core tests with your commit + latest kernel
>
> Zhu Yanjun

Hi Zhu,

With all due respect, I am a little surprised by the special treatment 
being given to this rather simple patch. Normally comments to a patch 
are submitted with technical data to back them up. In this case none 
have been provided. If we are going by gut feelings, then there are more 
involved patches that are being accepted without any tests as listed above.

My initial patch increased the value of 3 variables but the community 
suggested that values of other variables should be increased as well. 
The discussion happened on this mailing list and no objections were raised.

The two issues that you mention were mechanical issues, (one reported by 
you and one by the kernel bot) that have been fixed. They had nothing to 
do with the values being increased. As I have said I have tested the 
patch several times, most recently about a week or so ago with Bob's 
latest change.

I am not keen on changing the values of any other parameters, but the 3 
that were contained in my original patch. The link to those patches is

https://www.spinics.net/lists/linux-rdma/msg103570.html

Please let me know if those are acceptable. They have been tested 
*extensively* running several different kinds of Oracle DB workloads.

Regards,

Shoaib

>
>> Shoaib
>>
>>> Before a commit is sent to the upstream, please make full tests with it.
>>>
>>> Zhu Yanjun
>>>
>>>> Thanks you.
>>>>
>>>> Shoaib
>>>>
>>>>>>> -     RXE_MAX_MR_INDEX                = 0x00010000,
>>>>>>> +     RXE_MAX_MR_INDEX                = DEFAULT_MAX_VALUE,
>>>>>>> +     RXE_MAX_MR                      = DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
>>>>>> Bob, were you saying this was what needed to be bigger to pass
>>>>>> blktests??
>>>>>>
>>>>>> Jason
