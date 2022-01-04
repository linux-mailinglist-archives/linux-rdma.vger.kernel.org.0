Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD14A484469
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 16:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiADPRK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 10:17:10 -0500
Received: from mail-sn1anam02on2048.outbound.protection.outlook.com ([40.107.96.48]:44233
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229658AbiADPRK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 10:17:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnMwHx60IpxHlJZbrx4EC0qMp0+B3at5FsMeR4rztYcG8Y7K/mOuu9mXe5CQIqVOEeMu/+a9loHe5ToVqe+R2mH/fhM94TY1iD1CnOZjaY0up1UYDTBePzQEcHU7V3UToa3aKD3pbwMs2/eCQTkJIrPa5KpkNzrtoy/3NoLuf1TZ0rJ0uC7nl+8zg32YDWnfrWRweKQnBI8dtnYWuJbONiWP6A9JqB71Y0HTqBGlWSjdZ9+HMgpykCzY/eVZIl6CURaJ/ojd2izR5uFJEYfSBX4B9PBvaEOLnSwqeVEkOqd+uDOFUnd/NhGQteP0aSB3H51mccah8H+db1De6I55Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2wsCSJL12rcMr78IG30td4hfihhHjV+JgjGm0v1GvM=;
 b=giqj5zo8XxEPskXIS69dqKBOCQRM+EOxzzRoKixn9qe4WNLjeWeqJI6kjAcfzsiisEuqbfpJ/VtoxrE/m2LU9fjoqGf9cmEbLC63D7Bbn/2Bx9s12cXRpeG+hydnm9/xkdPY9wv62JL7nx+GSXdU1Oz47fKm/g7HMR9JCYgjzeb5XrHpnFY9hhwTBL1pTbRHCZaUwpgYofyHLTYt5v4INom4bJAW4x7zKiu0N8+lcudMRIk2L4TAgX8R7SNkVrkq6s1CoMcDNHu6ge7wGAaC8ev0e1LEnWYqlRswO4QTwM0+JmE9FQXXyB4L8HKQMLTaq3tNkN+db1ulRVzkw4+eSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 BL0PR01MB4052.prod.exchangelabs.com (2603:10b6:208:45::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Tue, 4 Jan 2022 15:17:06 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 15:17:06 +0000
Message-ID: <8c772721-2023-c9e4-ff28-151411253a7c@talpey.com>
Date:   Tue, 4 Jan 2022 10:17:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Content-Language: en-US
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
 <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
 <61CEA398.7090703@fujitsu.com> <61D4131D.5070700@fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <61D4131D.5070700@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0040.prod.exchangelabs.com
 (2603:10b6:208:25::17) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f79773bc-124a-4c46-8637-08d9cf9544d1
X-MS-TrafficTypeDiagnostic: BL0PR01MB4052:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB405224BEDE0C55067C4052C6D64A9@BL0PR01MB4052.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liXXDzxnbBvNw24v3V9GDmnXSKMRzdEs2JGmKosNbhFNAgZt0caLEwGk4DGlUAp+ZIB0XVlh0GFnvjHPvtWa4pshexhsLsgpYxgxv/znRt1D3AYI/E4wFyH1FOmyUNfVYD24Nj5nSKNb1vtiZpj8BWy1SxU7NackYTjBxhmcwm/MUtoQ+XynMYrfezKsxaenDm28XRSn9lplV2xF5RITpNMDukEEQ6r/KWsZRmXUW5C0HX/2FLPNhaaxBVKSJqYF04IjUUtwm2eo2Mbj++AP7UEgz8TJ8Ab/vxOdNZ1NUYMUsArGYGCGfF/GBwHiSbAPbLUdoke4IVvw4mgX18q+4N0d0w1GBfX74GztmZdAmYjrqA+7l/CHXwIa+FfumGVmLbknZyS5midbS9jpXv60xgbCeKmVukmNRSOehiNRJOAo/eOG29/1wmo/slTuUx5M4hFjumC7eAKvKRTv5uhDDUJaWwjo8y1+g/f+jL4bfctvzIZNABK7iMhU2uWYMVDo3OnsYNenjr/oFOWx7hVetJH9r2O3nUmCEcFHQZ3BcyoslrB/b6JySHUkyje/CQP3Qxv+rq6wrPchlbyirJa8oO7j6NWKwTyrhHh+YOX1dbJaAfxSkGUVRmBaKSC5yZhY3LWBGlGoR+cK/LSeveMEJUwEY/vokQZ3hN3mbOr8S+G4azK53X5Chkm1SgGszF/MGwGvm5SzDi8aNCZBdSsDjYXTqJCE86VMlbZ+N0+WKJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(136003)(366004)(346002)(376002)(66476007)(6486002)(83380400001)(186003)(66556008)(31696002)(316002)(5660300002)(508600001)(4326008)(36756003)(86362001)(6506007)(66946007)(53546011)(52116002)(38350700002)(6512007)(38100700002)(110136005)(2906002)(8676002)(2616005)(8936002)(31686004)(54906003)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNwclR1WlBuWm5jMXR4QlFqTjcvTDBLanJGOUFrQXQwOFREUmlHL2RWMWhN?=
 =?utf-8?B?dVpFMEc2R2x3ejRlL3pvNWZMZ0lxdDlZckVsaGZvcEtZSlArSXZnc01CZ0Y5?=
 =?utf-8?B?aTErWmVqUWtXZklnbEJzSHIwQjBTcE5vZUV0by9Ya2hucUhNVmYzS0Naa3Fv?=
 =?utf-8?B?NXVDUGpYdHcySTV1R1Y4eDJ4ckxJSDZMNzA3bUs4MkVYTVBYZ1VEbVhoR1NK?=
 =?utf-8?B?VCtaYlVuWGJ4MzdneXhQbFRHOHFEYzNJT1BxdVd0VzlQeTY3U3ROcUlDeW1G?=
 =?utf-8?B?dGhSRE9Tc0NhQmRSNXhXV2h0N25JNnlhb08ycHM5YTRIZGVia0QvK2F5THNz?=
 =?utf-8?B?L2R4S0pLWjNLSWd2NTNDUFFZRmVGYjhxclpHeFJBOXpPUUxtQy9KZjZvdzN0?=
 =?utf-8?B?MDRLVGVaenlJZjJ1MzBzYlRRd0N4Wm9NSmxsSDR2VkFRUlBKZFJBa2VKNjh5?=
 =?utf-8?B?ZldNbU0wQlVyVEVQOGNIdGZyOUsrVVFHYzBXemM2RDJWZDk2aW14YzFkdnhu?=
 =?utf-8?B?S2tuVVN0TlcveUc0SncxUDBVWmNHcUpWTnJQeUEzR0c0dXhqTktWeThOcFVN?=
 =?utf-8?B?L0Ryc0NSTVErV200c3J0bG92Y0Z4N0FZWnA1UU5lcDNxZm9hMmYxWHVMWVZ5?=
 =?utf-8?B?V2h4Rnc4MTU3Rnc1QXc3aFRtWkhLK21iRnJDQXB2ZTh3U21HakJ5SVhvajFS?=
 =?utf-8?B?Tjh0by8zL1EvS0Z4QmlVcHhIMHd4U3RhSEhoQkhQWmpTTVJCN0xQWXZvVHR3?=
 =?utf-8?B?NVJzOG5SNnQ4N0s3UEdqVTlISDlwc2VGSktjSEJnaHRmajhvRTZvQUgrajRh?=
 =?utf-8?B?R29VR2JzdVVHQjZqbVp3eStYeEtXcVFyNHpuOWlUTFJzQVpqbFcyQXdpdnZl?=
 =?utf-8?B?NTZpUlUrdEJPTWVNbUhlMUFoMWdwUG9FdXo4NExUYVFWeCsyRk1WbDhFMStr?=
 =?utf-8?B?RVpiaFpaVy9EY2RHNmw5cnBGNlVOVTVKNVNnUEk0b0E3L29aS2hDWmVoZ3Iz?=
 =?utf-8?B?VFE5TzFzQjJldU82YU1JNWRzc0F6aFBrMkI5ZzU0S2tHemMvczFpSXd2TFN5?=
 =?utf-8?B?NlI1WXJsTjZpRnhMbTc0RWVuc0xRVmRWWml3TDdnaDBhbHVGamFDK01Od2pn?=
 =?utf-8?B?d21MeHl3eTcyc3ZnUEFnNTlwazRkOXdXTTVQcWlUODBLZDhnbGZDZEN3aUVk?=
 =?utf-8?B?STRPdmlobDM0SkNaamU2UDcxN2pJcnF2SXJQNUN6SmJXOUpnaHVsYlBiVmds?=
 =?utf-8?B?OHdwRWg0TjkvNmZDQyszWGp0Z0tTWDVvOEwwUWQ1TnFQNi9mc20wdytJSTkx?=
 =?utf-8?B?N1g2TGdFdTh2MEc3aE0yeUVvaGlBdE02WVRXWFp6U2xmZ1NqcXczUVpyK1pM?=
 =?utf-8?B?a1NabEJiT2J4QWcrRlZlRHBnV3FOaTNsZkxRZGJLTzg1S0ZldUVHZkVGVXZC?=
 =?utf-8?B?RTVwTnlWVUJTK08rc0cyVWFIZEFaUXZRN1dicVF3QXNRRkV6ZFYrRUgvc21Y?=
 =?utf-8?B?M3V5MDZtNW5MaHVOc2FtRDhTN0NncWo5QXJWcG9HUVJJbEZvUDlnTUl0bEZh?=
 =?utf-8?B?TzhraXlNNnlKcnA0clpkQmpoMFF5OXM2cE5XaS9WZGRhdTFpckdXcFJtckhD?=
 =?utf-8?B?eFE5dFd3K01SNWt0SlhNbXNMMkQ0ZlhNYkNNM1RKblhsSml5RlBlZzZGL3V5?=
 =?utf-8?B?Z2dXWjRiTUo3Q0VGQVcrR1l2WWtMTDZpNE0ydThQVXpva1NrZjU4QVFLeElP?=
 =?utf-8?B?Q244dXM0OFpaVk1LWkpuRWJhL0RFSUhEZE8ybnU4OUxvclc0ZGlqd3JVZ2Ja?=
 =?utf-8?B?T1I0NTJWWU9qYlNPSG5WTEJWQnlqV2dTQTRIak0wUGMxeHNxbXVWSkxLOXVs?=
 =?utf-8?B?WWEvWEl2T0p5M3VoOE9MaWsvM0s0eEFFYzNjMkZIL3hIQ2k5Wk9EME9nSTJY?=
 =?utf-8?B?cG42OThrdzFNaVdWcE83SUp2T1h2R0djZ3VIOFpxUStOU0FQdkdUUTBmdFAy?=
 =?utf-8?B?MXRUOVJvZTM5QnAyZFNZTzBhaklTcENBQ0hseUxUcU5DYlJyb2lpYlYwcXJP?=
 =?utf-8?B?RURiRkJONGIvOUpxclBiYVRzVXBwazg1QjZwS3FSbnFFMFZXQWtIY2JnVERC?=
 =?utf-8?Q?1w+M=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79773bc-124a-4c46-8637-08d9cf9544d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 15:17:06.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0NwhqLu2cUvSWKgdOnSPYvn27CgnhUydSRg6lUR9U7DIeszaPa+DIar0snBFWIw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4052
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/4/2022 4:28 AM, yangx.jy@fujitsu.com wrote:
> On 2021/12/31 14:30, yangx.jy@fujitsu.com wrote:
>> On 2021/12/31 5:42, Tom Talpey wrote:
>>> On 12/30/2021 2:21 PM, Gromadzki, Tomasz wrote:
>>>> 1)
>>>>> rdma_post_atomic_writev(struct rdma_cm_id *id, void *context, struct
>>>>> ibv_sge *sgl,
>>>>>               int nsge, int flags, uint64_t remote_addr, uint32_t rkey)
>>>> Do we need this API at all?
>>>> Other atomic operations (compare_swap/add) do not use struct ibv_sge
>>>> at all but have a dedicated place in
>>>> struct ib_send_wr {
>>>> ...
>>>>           struct {
>>>>               uint64_t    remote_addr;
>>>>               uint64_t    compare_add;
>>>>               uint64_t    swap;
>>>>               uint32_t    rkey;
>>>>           } atomic;
>>>> ...
>>>> }
>>>>
>>>> Would it be better to reuse (extend) any existing field?
>>>> i.e.
>>>>           struct {
>>>>               uint64_t    remote_addr;
>>>>               uint64_t    compare_add;
>>>>               uint64_t    swap_write;
>>>>               uint32_t    rkey;
>>>>           } atomic;
>>> Agreed. Passing the data to be written as an SGE is unnatural
>>> since it is always exactly 64 bits. Tweaking the existing atomic
>>> parameter block as Tomasz suggests is the best approach.
>> Hi Tomasz, Tom
>>
>> Thanks for your quick reply.
>>
>> If we want to pass the 8-byte value by tweaking struct atomic on user
>> space, why don't we
>> tranfer the 8-byte value by ATOMIC Extended Transport Header (AtomicETH)
>> on kernel space?
>> PS: IBTA defines that the 8-byte value is tranfered by RDMA Extended
>> Transport Heade(RETH) + payload.
>>
>> Is it inconsistent to use struct atomic on user space and RETH + payload
>> on kernel space?
> Hi Tomasz, Tom
> 
> I think the following rules are right:
> RDMA READ/WRITE should use struct rdma in libverbs and RETH + payload in
> kernel.
> RDMA Atomic should use struct atomic in libverbs and AtomicETH in kernel.
> 
> According to IBTA's definition, RDMA Atomic Write should use struct rdma
> in libibverbs.

I don't quite understand this statement, the IBTA defines the protocol
but does not define the API at such a level.

I do however agree with this:

> How about adding a member in struct rdma? for example:
> struct {
>       uint64_t    remote_addr;
>       uint32_t    rkey;
>       uint64_t    wr_value:
> } rdma;

Yes, that's what Tomasz and I were suggesting - a new template for the
ATOMIC_WRITE request payload. The three fields are to be supplied by
the verb consumer when posting the work request.

Tom.
