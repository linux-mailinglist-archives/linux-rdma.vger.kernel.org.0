Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6744879CC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 16:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348067AbiAGPif (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 10:38:35 -0500
Received: from mail-co1nam11on2069.outbound.protection.outlook.com ([40.107.220.69]:59169
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239665AbiAGPie (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 10:38:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of5cry/jsB7BbSlW+5AWlbBV1Oj+NpjgeOXyOkji500GopGsB15d2kCAJUTpEm62D19pzmvavxmcEWzKv1ISULbjMtS3zNIW3ZPQtgXdKO4TusbCsWz27ILtHaRnI1maK511VJzDlSG5DwvWcx6/y6Emd56o1BJtlygIDwTuHzvrrcPF+xpM8FAZBKRXVIq5gceCZnqQo2hpWmzt4aGrA5npNGhXv6YhcAMLGGJ2k3AtTcOgNfEeL+5bgmnp6e3G39cWdUB9rs6De4M+iC1+DiAke6eCSt4CJpk2K4zEhsWTgqoK8xGSfjHEmzJW6om+d/N/udSFGV4yUD8bBQ1POA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkGHBuxyseDmyFLnGe4sEJZR0m8T62yEcx2nuQh8uZg=;
 b=IsWUJg4/F1EHsw6ZfUvl7PDC5uiSGv75eMpf2Jr77C2tLXSQnLOpYdizro4rKevj5axHoDIe2dvseEQLPtijZey/MYL8nnuDgeZJALoC+5xH8+thU4erVJa8UgMMkqh9kSHpXINyoKu/z/7sqYjKouBv8NlsGtb0xtbsZ5wdw329HfZ8l2sLmt6Rc2A0yvSkHKAoiza2UJUvIXnpsLdlB5AV6BeZ9i8bII9n6t5lzBI9NIr8nJ9GQK5X6+/R+Sks6H1h8FpLolkXBb0LbDuoxQR8nrPINo8wEnTuWz1m7mK03LqemvPE4oAzm/8DMDuIT0e4SotNqRv8P3bXynENww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 BL0PR0102MB3443.prod.exchangelabs.com (2603:10b6:207:1d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Fri, 7 Jan 2022 15:38:32 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4844.019; Fri, 7 Jan 2022
 15:38:31 +0000
Message-ID: <472f1a2d-65de-91f7-35be-8338ec3c0635@talpey.com>
Date:   Fri, 7 Jan 2022 10:38:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
 <20220105235354.GV2328285@nvidia.com> <61D6C9F9.10808@fujitsu.com>
 <20220106130038.GB2328285@nvidia.com> <61D7A23B.40905@fujitsu.com>
 <20220107122244.GR2328285@nvidia.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20220107122244.GR2328285@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:208:fc::33) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1559583-126a-45f1-81b6-08d9d1f3c210
X-MS-TrafficTypeDiagnostic: BL0PR0102MB3443:EE_
X-Microsoft-Antispam-PRVS: <BL0PR0102MB3443412454F8A007A9481347D64D9@BL0PR0102MB3443.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjiZ7bsMA3BvmT/7npybfWSzJfi4wqDEEq/exc/NL20GrSSXpUPN/1yX38OJ+iF3mzFDIqkPoOBoDfdJL48uFp+AhCr8Snmvr7CaSbGpEQ8UrcDkNl2d+SApcnLRfF1+d3ET2BO8XvC73Od5N5lXNY0sQ0ysZjUyldbtNISWOqyYS6XtKrgFVXA4jVerLbSVKvMJ4RXD4dDtN4Ttjh3yCiacaViIPjl3K2t7w269UuQCL6udpjrdWTS1ssg77YdR+1xppLq+BKVwyrCQ1jS7feCbSR5lPliGH+dEbyy1Qe29TiU6XcBNMSQ5VEVDfvRxG+IfvtGi8B1V4iRLDfjrklbShY+A2BaMUVCm/AiMahmUTkvWbcSl+HJmBumhyGtXprG4oUhI1LqnNybFwfed+Wn1Uv/xKeJc8bXo69VAg3c3A8+A5OpUP6mBfghuRoYrBOaA5Rwy55z9DrNXKf4lwaOUdEDcpvgTi9lS2T3wOZxp4JzC/oM06zT90GDMGUbj8+NMM4QFK0m7kkLqJVpn2v+QeGVwgbyGOD44ZqKbwa0YKNfpJa8si3hYpU7hs07+CxutibiaxZ9osvOFamdtmqr3VWMmMenHeoG2SfYJC0mR5astOCVEdK72DqijaE7rCVKENRgE48v63NSGRdsfHiPJ4VWBezRjB7fWkgZW1LBpQlyOADaCV6EUeNIlEaln6A0fHkG1+vi+8gC/AOKjSGWihsXca10+TFmNYK7qkEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(39830400003)(396003)(6512007)(54906003)(186003)(83380400001)(2616005)(8676002)(4326008)(26005)(38350700002)(38100700002)(508600001)(316002)(86362001)(36756003)(66946007)(6486002)(52116002)(2906002)(66476007)(66556008)(53546011)(31696002)(8936002)(6506007)(110136005)(31686004)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEM4TVdENVo4VDVXNTdYUXFxWk5HS0ZsTGwvZ3c3aGFyTVFLcVh1UEpEUDAv?=
 =?utf-8?B?U3hueVBKanhHZHI0OUxRY0R0RFM5bmw0NVJmWms0a0NMS2FJRU9aemtxUGJq?=
 =?utf-8?B?K1cyTE00N0JrcXFJeFFISFRZZ21UTm1Vd1o5eExteUpqc3o3OG9Zbm9wQ2Jo?=
 =?utf-8?B?bzJ0YmJvbmdZdDlvRnk2Nnd5RDhQNEFqcHpxbVgxZGFILy91Y2hIYlovTGhx?=
 =?utf-8?B?dldVUDVVS1FTMHl6WHJCamFPdlYxcjZlRVgzcTlIeC9ZWWdHbzZscnVIbUJ3?=
 =?utf-8?B?bFZvdXFreFU0SHZ2Um1GNU1ORXlOL0FTNWF1djREeThqTmxjS0FRL3J0MXZn?=
 =?utf-8?B?UkhRYmpVakJJS1N3UThWZXBZa29zUmFZZ1BHckt6S09uaU9xbk5rS2Nnczd0?=
 =?utf-8?B?OHR1amlPMTBxQklmU0ZoRzdKbENTUWM1YTNUVUkyUmxKdTJXN3ZqN2RjaVpB?=
 =?utf-8?B?YVlIQmMzWWUvQkVCVnFWU0t0SjFManN3SXUvZnZVS0sxNW02TlJoekIxZjlQ?=
 =?utf-8?B?OUpsQUtKbnBsSVVuK3RzbVdyZmkwU3ZYdExycjlSUmcxZXpWMWdQVjh6cHRi?=
 =?utf-8?B?S2FKS1k2V3pVR1ZLZjZjQm5VdzB2bEtUbFk3aWw0c0pvNnUxcVQzclRYVjQz?=
 =?utf-8?B?blFsbnQwQmxtZkdwRWkrSU94Z3Y2NFZpMUk3YkF4clhOYjNCTW9oUXRvcUh6?=
 =?utf-8?B?djdLMWNteVlCNTVLSDAwSXZyUGI4TWxzRFhtVTJsMDhFVnltbkRMdmNvSDhS?=
 =?utf-8?B?Qi9JSVFZMFZHQWJjVkp2ek0vUUx2THlObTlvdk5LTCs0NThJdkppTlNhcENG?=
 =?utf-8?B?MGpkcFdINnliczBjMXVDRjZMcGlMMXY2cm5ycWpiU2MySnk5dStYNWRFalM3?=
 =?utf-8?B?b01lRHk5MGJIZS9JV21vZ3ZHYjdFb1AwYjA3MU8wZ1M3R3J1Y3Y4TTdsWVgr?=
 =?utf-8?B?M1JnVXQ0cml2SmlPZFkySjQyYm5UUmY0M0N1UHp3VENNa2hmeXNXZGU0cENu?=
 =?utf-8?B?eW8wSGxVUkhzL0J0MjNrTkVJSVowb0ZMYnUrelk1LzdOUFk4YVREQ0ZUSmF2?=
 =?utf-8?B?emU4RVNhL0l3TExMWit2MjBxL2FmMGpWNHpUZThnZ3FPK2U3QVR5a1krTGNi?=
 =?utf-8?B?ajZFQ2FUcjJWUGtGOFZ2dHBRTjdLSDFkejJpUzJyaDNiWjNRclpDSXA0ZTdS?=
 =?utf-8?B?LzhqTi9QbWZZRGp2bkZlTG5DWWRuL0x3R05MWE9iZWtOWHo4WHdlT05EMXBG?=
 =?utf-8?B?dEZhbE1xV2lXVnRuK2dvYzcrcjRBTTh5N3FzWGRnK2hDK2FjL3JoNUs0UWFq?=
 =?utf-8?B?SnNobGh0NXk1UjFkNHNxTkE5T1VYQVNLSUtENy9TR3UxaXNFRHFRcTJLZEhO?=
 =?utf-8?B?MGFNaFE2WW5YQi9tYjlRUkFMMktCeGFyWTh0ZnkrZlFHU3RxVXFNNXNqQ2R6?=
 =?utf-8?B?VUFxb2FSb0RFeUJqcU9DQ3hidys0UWZ1ZWZUOE5sU2l6N25ZQitFZjZsM1d1?=
 =?utf-8?B?NFF1OTJvZE9ZczNSUW8zSDV1VHFFUmdSYXROZ244UVZrTzNSTDg1WnBHUGQ4?=
 =?utf-8?B?NWFHN2hLRzhFR1lSNHo1TER3R3hYZjdhRitQTlNtUHVvcEluZEZYV3p0RStQ?=
 =?utf-8?B?L1NLdTRpRzNiYXd3eWRHbE9OLzNPMEZPTFhRMWhxQ2k2MTBwQ0FEYWRaOGky?=
 =?utf-8?B?YmF5YmcyYTB6TC9TR3VscTk3TzVRTG1hWCtMbDlkSFJWVWZnL0dSVUtRMEdi?=
 =?utf-8?B?V3BnM0NHT0xIOWxvcFd5MTRSZHA3SDRtYm93Q3lDQVEva0JjdG1iN2NFWWVh?=
 =?utf-8?B?YXpZSFVhb216UGVjakdqTWFQNkR5RERIVzd4OVBBZ0NYSFoyWlRWN2QyUVRX?=
 =?utf-8?B?U1VMaFF5ZWVCZzM3L1ZReHhzd2dkNzdkOXVXK2tHaUxRUkdaN0tFYUp6ZGdn?=
 =?utf-8?B?cFcrR3pqNWZRNnExdTNwMmtGNHI1VjcrMCtQQ0pEblBrcFR0ZXk0U3FhY0M5?=
 =?utf-8?B?UUtNRXptc3lucWNOczhrT1dyOWFteXBzeEUwb2dFbGdCK3BqNTJvS25lUTVZ?=
 =?utf-8?B?ODZmYkVnOTFNRTlNOVRiOE44eUVYd0NHWmhKQ2ZrOWhoekFXRk9kV3hBRS92?=
 =?utf-8?Q?3tlg=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1559583-126a-45f1-81b6-08d9d1f3c210
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 15:38:31.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kX02y/HShUwhcVdcsB0MZ0ZmaTGuU9I+rD6Xkjf6fO3iHdDGeAadxg4oqb9LMaUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3443
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/7/2022 7:22 AM, Jason Gunthorpe wrote:
> On Fri, Jan 07, 2022 at 02:15:25AM +0000, yangx.jy@fujitsu.com wrote:
>> On 2022/1/6 21:00, Jason Gunthorpe wrote:
>>> On Thu, Jan 06, 2022 at 10:52:47AM +0000, yangx.jy@fujitsu.com wrote:
>>>> On 2022/1/6 7:53, Jason Gunthorpe wrote:
>>>>> On Thu, Dec 30, 2021 at 04:39:01PM -0500, Tom Talpey wrote:
>>>>>
>>>>>> Because RXE is a software provider, I believe the most natural approach
>>>>>> here is to use an atomic64_set(dst, *src).
>>>>> A smp_store_release() is most likely sufficient.
>>>> Hi Jason, Tom
>>>>
>>>> Is smp_store_mb() better here? It calls WRITE_ONCE + smb_mb/barrier().
>>>> I think the semantics of 'atomic write' is to do atomic write and make
>>>> the 8-byte data reach the memory.
>>> No, it is not 'data reach memory' it is a 'release' in that if the CPU
>>> later does an 'acquire' on the written data it is guarenteed to see
>>> all the preceeding writes.
>> Hi Jason, Tom
>>
>> Sorry for the wrong statement. I mean that the semantics of 'atomic
>> write' is to write an 8-byte value atomically and make the 8-byte value
>> visible for all CPUs.
>> 'smp_store_release' makes all the preceding writes visible for all CPUs
>> before doing an atomic write. I think this guarantee should be done by
>> the preceding 'flush'.

An ATOMIC_WRITE is not required to provide visibility for prior writes,
but it *must* be ordered after those writes. If a FLUSH is used prior to
ATOMIC_WRITE, then there's nothing to do. But in other workloads, it is
still mandatory to provide the ordering. It's probably easiest, and no
less expensive, to just wmb() before processing the ATOMIC_WRITE.

Xiao Yang - where do you see the spec requiring that the ATOMIC_WRITE
64-bit payload be made globally visible as part of its execution? That
was not the intention. It is true, however, that some platforms (x86)
may provide visibility as a side effect.

> That isn't what the spec says by my reading, and it would be a useless
> primitive to allow the ATOMIC WRITE to become visible before any data
> it might be guarding.

Right. Visibility of the ATOMIC_WRITE would be even worse than if it
were misordered before the prior writes!

>> 'smp_store_mb' does an atomic write and then makes the atomic write
>> visible for all CPUs. Subsequent 'flush' is only used to make the atomic
>> write persistent.
> 
> persistent is a different subject.

Yep, absolutely.

Tom.
