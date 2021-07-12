Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C889B3C63D0
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 21:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbhGLTge (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 15:36:34 -0400
Received: from mail-bn8nam11on2116.outbound.protection.outlook.com ([40.107.236.116]:25952
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236249AbhGLTge (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 15:36:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCWKxeO7DFmSz0Vsz1Jpr7IoAxnzSaA5uupuVzdFDmDenFA3m0uDuZTJHk7nQQPJheVNtn8aMBU6FvzAkJWtrHZp2+WYMc7A2DlL7eGpdu1zYJteSBd7mq4LW8r6mW9xQVNY0VdXpwUwMnjAkTGXrCuoZgxTmntFowYB1BfJQs4KyXcyw/OweoK197915nzqsluTUN69pN9W5SpjhZRw28veTHT0stKz+iO33vAtB9LDdZJdHnGG/c4oJyIhoCSuLx6P7fFFz6uLjTph9AOsz1aiSnSAffGJ9cZzXeLBr11yV4CQhuhexgkbpiL5aFW1e0i1g5RZNoz2fexTZRPmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsAtpMFXKKHW0QPeb5HogvJsgSRThYX0tWScAiKrk/w=;
 b=REC1wuHUTkhAeaUAtf94ubrQrvdX82oI9A6R5JayVXhYXXdHjAPL+qruDJldyDJARoKP3L6Q0fG7TMrK1k1+/affz8U5X4N+3mVLknOzoO4fPUZ6aA2fKeNDAhCJrS56mcLIfI+brQhtV/uCrOXkHhA3mwH9yK6iOOZHShBlQSY6/es4VTkJfJNLNA1dtfTKj5WvT5tOfJXUTkXSLiXpLQvH+HbNQqpKeGO+aVyO9toavULWxJr+X6av9kVEAwajguDO5aDJDGhuS+RWeaDVsi4J+vEm166uxuinDIsTLpih72KtHJFoHN8otyQERKuQcJriIVbmic8+0iQ4lcODKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsAtpMFXKKHW0QPeb5HogvJsgSRThYX0tWScAiKrk/w=;
 b=eZM3CAn3iNM7JKSpPyZw0DUfje94HezzmSGws9Yd6GeRjQ7YQHaf39xHzPuz/QFagtmYH3jRE0+UagqstD3mU7qyTXZ/GEip9Aq4jdFCqDer/45YOJdjP2vJSrJTtqtq1TOVaKbpLNz0pRjdb2JaWpdpXNpwScvoRxhbcc3OaFR0jBnJWZqOEWgi5UvI4IoJ4+qrxmdceiGzzQp9eHdNAf5D/4c3s3htMonjYS4lX+1bSD9+J0ht1LYt0kKvuJiEwKmQ4NEeRjq9klPUvFuNlbXJspAPmzcHJom/luCiQU5yTuJs4C45I0tK9Zt0YyLuglnj7iiUcXUozKpTeOiogQ==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6586.prod.exchangelabs.com (2603:10b6:510:95::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Mon, 12 Jul 2021 19:33:42 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb%7]) with mapi id 15.20.4287.032; Mon, 12 Jul 2021
 19:33:41 +0000
Subject: Re: [PATCH for-rc or next 1/2] IB/hfi1: Indicate DMA wait when txq is
 queued for wakeup
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
References: <20210706171942.49902.72880.stgit@awfm-01.cornelisnetworks.com>
 <20210706172345.49902.10221.stgit@awfm-01.cornelisnetworks.com>
 <20210712174214.GA259846@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <ddae0dc9-383b-00eb-b6f1-c5d3ba92694a@cornelisnetworks.com>
Date:   Mon, 12 Jul 2021 15:33:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210712174214.GA259846@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::31) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by BL1PR13CA0086.namprd13.prod.outlook.com (2603:10b6:208:2b8::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.11 via Frontend Transport; Mon, 12 Jul 2021 19:33:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51c588a7-e618-42e7-07f0-08d9456bf480
X-MS-TrafficTypeDiagnostic: PH0PR01MB6586:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB658698FF96C1211AF8127444F4159@PH0PR01MB6586.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EM1AVYodSm3J3fYSEkBKKd5Nbtc0b8rTYrLVO+DEv5hSRjGxblJoNd2MW7EtaESQIwf3YLzQUqdKFAAkcvUxX3GqYDWjYAH/NurahHJ2qxyuJzcGYdBXLOX2IRn3RVb4HABeD1wErj76E4/pogKut3gorX+e0UsFrpfQ47J235+ui45Euu68VHUayTu/oQV/DXwyUfmY3u88T7R0QIqpZlrcnX+zzi7HLePFuv/Iq43brBnEpG/u2o7Ek1dJ+eSbhB92e75e72K3+ELMWigF7P5J7zkJF6ulfglqDGDes5GJ5Y7sj9rCnd+lcG90tG3JgEhjZBLs3N0OmT/FznHUEl7rRHDRrDlI4KgH8LWSRpo8XA6fHOXat1ZfqulhvfOlnP5QXXFhFbohXVhjfydjYUOQmi4LPmzAUGZzYD1QP/LeeLNin7dgB8lyDhVedzrHRUl+59V/mjBLNyyP9A8Zab8nPPdMS6lMoUrzvSMUi2FLS+u9vJR3PMql/oqYn/TfX1Izd3Yk/6T7oaFXBb6aPzbCktEj670YbLZyBHRnQ/RP8uELENbqb36l/1udJofW6GsR2Jf5YwYeOoTgwzIuiCdZJu1x2oGHLm8RKIJTvhx6Hyzb99Bf7PdJUTw+IY9DRz/DAum3rouNohqJRE9KmjVVCgvzzxz3hdI1PokZshy6xeBLGsa2v3g5dor/m8TLCPr05IhxtZ2rplf5kj1w6kqUvY+UvqNBC29sR3NFI3/ZA67jfsWV4q0/3TRN9s8B2Bty5IdLFbiDE6IgUQvCkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39840400004)(8676002)(38100700002)(36756003)(956004)(2906002)(2616005)(44832011)(8936002)(5660300002)(38350700002)(6666004)(6916009)(53546011)(31686004)(4326008)(6506007)(86362001)(31696002)(83380400001)(6486002)(52116002)(478600001)(316002)(6512007)(107886003)(66476007)(26005)(66946007)(66556008)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdxcWc2UFpoQzZVY3hQeUF1Qi80VEJPdHZvOEdoLzdLOVRvb1oyb0VIUSto?=
 =?utf-8?B?bUZkdndMQUtlcTFBYXZxRi9wby8yME03TjFGWnd3eTFXMVNhQUsyd2hld1RZ?=
 =?utf-8?B?L3F1N3V5OTZOR3NiUlhiWkJqWHR1T1hobXNHaG55TmZBbUFQcG9CQkZsaTRI?=
 =?utf-8?B?aFptWFFyVGM1R0hEMlVQNnd0RHBWWUJmYkJFbnlCQnZ2bnQwWWdIbzZxKzla?=
 =?utf-8?B?TXg5cVZYL3dUUktkcG9EWDBYRDN5YmpwYkNJT0ZxczBtQXFLNXhNSGZCTU9T?=
 =?utf-8?B?M0FJWXFqL0JTQ2JtUHV4bEFnM0FNdU9oaDNnTTVvWXpwK1UwbDJDYjlUTEps?=
 =?utf-8?B?YU94WXVXRXVTekdwb0xlbzZLNlFFYW10YUFZa3UrMmxHTWc4aCtZY1BlRGFO?=
 =?utf-8?B?MGx0MFVDZVBrOU1DalhMOWdQTWNyT2JsYzNaRW9WVUF0MHVTK1k4ZEYzdWE0?=
 =?utf-8?B?OWtZckdZWDJ0dUlFbmlTYk53enFCUDJQbFhjTEJKbG8vbVVtNGs4bXdGYjhl?=
 =?utf-8?B?bjkwTmQ1YlhNbE1WVVVnRExROUVGVFV1OFZuZkFVekpzVS9OYmhaYXBzZ2Zl?=
 =?utf-8?B?YnQvWk1DZ0NhZUYvYTZpTElVQVphYlhSdzlCWGFTNWhyUEphUlhVaEkzZW9t?=
 =?utf-8?B?NTFWTllCQ0x0b0NocDBURHJ1YkxrRlZXWnVoNkpzMlp0N0QwWEliZS9DcUxj?=
 =?utf-8?B?eEl2Zk5aTlJrWUNNRk1iUFlPSnNER3d0Q1V0VU94ekJjZ1d6ZjB6TzBUNDVM?=
 =?utf-8?B?bHN1enB1dk1xcXdmVmc3ZHV2MkFPeDllTkNZZkxVSmxzUmF6NFArT0FIalNC?=
 =?utf-8?B?WTYyaWlpek5TM0QvNWlaTGE0cFhWYmZBeVIza2NlK1RWOHFiM0s4RlpjYXBq?=
 =?utf-8?B?UUNydDJlOHFoSDR5bUJMSXFlcVdWZGcvNC9qNUtRSTd4U0Z0Q29xODhOM1Z2?=
 =?utf-8?B?WTRnS1pyVHh0MW9ua2FFdVZVQWNpd2pUQk4wN0c2V2I4Nmx5SVVnZEh6RzJy?=
 =?utf-8?B?V0JIU21ERGpiVFlSMWRMOGJwSzRHbFNrNmNjMmxlN09DVUJTODcwaDd1cXRE?=
 =?utf-8?B?VzN1VW15a2hwQzRQOTRSWmdka2ZrcDNzekxFWENsTTdHdTJSV0dYMVc1TTUv?=
 =?utf-8?B?OFluOG9GUkVGQVJTNlVnRDR0QVc2QVZuMUdUVGhlbDBwNk03NTlUZzZFM3Yv?=
 =?utf-8?B?QkxGSm8rMVZJU2xTYjZDYkRGQ3B4OHIwcFoxdjZEOUdSVldQSUdnNEdJWFZX?=
 =?utf-8?B?c0pYOER4b3V0c0ZHVlNqcW9EZXdpUGNkY0h1MnRDOGg2aGFPcEFpeUJ5MS9G?=
 =?utf-8?B?NE8wdlJHdFp4bHFEcTV4ZkY5Y3pGRVFGV2JUQzFlb01nd3FwTTdYUkcwZWQz?=
 =?utf-8?B?elVIWVRBTzlEYlNubnZrRmJCZzM2eGYzYVJnbzBmeU5aQUpoMzhUNEtOV2Ro?=
 =?utf-8?B?R1gxRWxmZlpzV05YdEtmK1lqSzE2UTNzVTdVUTBaMGVJM0NVZm9zM1F4YVdh?=
 =?utf-8?B?cEZ1QUp2UkFkNG1RVmN1YjZzQlRvbWQ3bjJZYkk2UENGSHFmOEtZcDRTRGhE?=
 =?utf-8?B?dXNwNDl1T2JrNHpTRjZNQTdFT3JKZ1ZWMnNnc2FYaUkraExraU9JQWZqZ2I5?=
 =?utf-8?B?MldsT2xUZXcxdlJrcmZXWldBcHFSZXBpdytWalJTRVhCT2I1OXdDREh4U2Zx?=
 =?utf-8?B?SXBsYmZ6MkhQZjVSSEw0M1ZwenJTVW9xbEIzc3p2eEJiZ0h1Y1pYelN0SnZj?=
 =?utf-8?Q?zuDoK160g4y6EIylxFpMjlrsjiPg5uQ+0+k/65C?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c588a7-e618-42e7-07f0-08d9456bf480
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 19:33:41.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7DsetQ9HUBDcRyCmBj9oi9ZnSHz2yd8p8Qj2zBho4L4GtdqqJVyvql7WolX4FlPdxPv2LdUnbpeT2SWiLiNpAx+S0mIXntIneSdKSK5EB6rhXc5ofWQljRtA5GXGPGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6586
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/12/21 1:42 PM, Jason Gunthorpe wrote:
> On Tue, Jul 06, 2021 at 01:23:45PM -0400, Dennis Dalessandro wrote:
>> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>>
>> There is no counter for dmawait in AIP, which hampers debugging
>> performance issues.
>>
>> Add the counter increment when the txq is queued.
>>
>> Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
>> Fixes: c4cf5688ea69 ("IB/hfi1: Indicate DMA wait when txq is queued for wakeup")
> 
> Neither of these fixes lines are correct, please resend it with
> correct fixes lines.

I believe the thinking is these are fixes that should have had the counter in
the first place.

> This commit message is not quite good enough to justfy adding a
> counter increment to rc, can you explain how this is an existing
> counter and it is a bug that this single case was not incremented?

Yeah, agree. Fine to go to for-next instead.

I don't know why zero-day builds threw up on this commit. Seems unrelated.

-Denny
