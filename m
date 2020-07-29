Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412BE23174F
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 03:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgG2Bga (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 21:36:30 -0400
Received: from mail-vi1eur05on2052.outbound.protection.outlook.com ([40.107.21.52]:12160
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730117AbgG2Bg3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jul 2020 21:36:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6BcvtD/30FyCh60IJczp8bKOiOOUyw5wK5XhL9sqNMmu31Od2M9RpBpIVQ92aonSMbQ8yEMIv18IY/Uxzu4vX5uwA+on2P4p/0JJiABwZKVWmFKOMt8e11KtEXpb0havQjw0Ud9kghLckPHNdFhyk297bh5Mvk0REbXGsvifmlKaTSm6kcbnm2riqqlM/7KUEQq8YoAxHvc+sBQS6EJfRvkpruhCyY3f6VpYc5HgnBsQNhVmoMJa43ftY/LVrH/F7+AwG5hWFwTTE7vHtOobY7HY5w6kwWMhPvyEBKzoMVoZQC8xuLQYqfscxSGV4tOhi6s+rdSfo9F4PIRm1ma/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Uv7RLgCws3wQGrbC+C3Hxmw5s/sE5ZP6AL1x9pz45Y=;
 b=L3nJgrHMKoOp+4EWnlYUg2Pyee2ylerpSmKJjIVY6B5Ig3edjrg1J+l29Q9XkruN7432/xYTucY+IU42mB3dbx054yOfmVNiRfUhvNbv0aDsoKu5OsNQqDJMH3dUrq0/8oQL3lPVh6mRJrlwVNWKPosHRPqVl9cVSQ3QBM4ozmTx8qio6JbLtTHcCEaRZbUrEPjUwWxdoRSoiBKNBGgtXx4bdfjE+zq7j3cLYE83eqXEGCQLcWUFMwRZo6gcitKki2L0motq1wFqXoeoK+d0DqMkpUfngUUkSmCfCGuz0awS2MmXlI3QfZObUwPm2ZWr9RskLYwtGzH4uMb+s7fWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Uv7RLgCws3wQGrbC+C3Hxmw5s/sE5ZP6AL1x9pz45Y=;
 b=Srqw4wf3xfkGJgGxfzX0iAXuLwvWBYzUoNUi1xiOh91MfBgRhv2dpQf0I+Ufj9voc2Ht3Hz4rMRjrDsHukG+ClZimlL5iNC8jXCqcjiFDN5APlvNlo86s6ZqS3/ycbp0FhEn2PCh24QDuj9gtMNc1aN90PVK52iBhQacwqFIKdQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from HE1PR05MB3337.eurprd05.prod.outlook.com (2603:10a6:7:34::15) by
 HE1PR0502MB3913.eurprd05.prod.outlook.com (2603:10a6:7:89::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Wed, 29 Jul 2020 01:36:25 +0000
Received: from HE1PR05MB3337.eurprd05.prod.outlook.com
 ([fe80::c860:86e8:5520:856d]) by HE1PR05MB3337.eurprd05.prod.outlook.com
 ([fe80::c860:86e8:5520:856d%5]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 01:36:24 +0000
Subject: Re: FW: [PATCH for-next] RDMA/rxe: Remove pkey table
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Kamal Heib <kamalheib1@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Yanjun Zhu <yanjunz@mellanox.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
References: <20200723055723.GA828525@kheib-workstation>
 <7a6d602f-1adc-cc36-5a11-e0beb6e31cec@gmail.com>
 <20200723072546.GA835185@kheib-workstation>
 <81816c7d-9b14-98de-c6ee-0a6b4a43a060@gmail.com>
 <20200723131549.GM25301@ziepe.ca>
 <4796e70a-ca67-2d48-fdd8-e5593474d204@gmail.com>
 <20200728083557.GA73564@kheib-workstation>
 <9a6f21eb-a9c7-ed77-31b3-f9befa5a49b0@gmail.com>
 <20200728134442.GA29573@kheib-workstation>
 <93160a8d-fca7-defc-b39e-e6e5a97ddb87@gmail.com>
 <20200728174225.GA52282@kheib-workstation>
 <b12cf75a-1459-bee9-8d38-19a73d048a62@gmail.com>
From:   Mark Bloch <markb@mellanox.com>
Message-ID: <9e2beff9-ff0a-a6e6-c4b5-621650480044@mellanox.com>
Date:   Tue, 28 Jul 2020 18:36:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <b12cf75a-1459-bee9-8d38-19a73d048a62@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0033.namprd19.prod.outlook.com
 (2603:10b6:208:178::46) To HE1PR05MB3337.eurprd05.prod.outlook.com
 (2603:10a6:7:34::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.6.80] (216.156.69.42) by MN2PR19CA0033.namprd19.prod.outlook.com (2603:10b6:208:178::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Wed, 29 Jul 2020 01:36:22 +0000
X-Originating-IP: [216.156.69.42]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 251d8641-4de0-4982-5424-08d8335fcdfe
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0502MB39134A6DCFB672F7AF40ACDCD2700@HE1PR0502MB3913.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBxxb2ZiIdnu8DZZyc6QNy1cilYU0lGGUKhN9c83eQ7fLLdu1Ds5wDTiDW7CFJF+citquonMu3HQHoAXryhX3YRpupd1e9j6Hz3e7NtFnkLR38NE1+6Ai5z1oEZxP8gHTD65ygoy6G+puqihGB0Xo2TN1MqWbewueaevjEIWrF4Yc8BkKM+xHfT/6O1NO+GYEHQoQF/nxgvNTmBWYl1EDsHKX3fTEE8U+biWgPfw3A4erOSbEBAlgY5F3tIhQMn7gmMNBYK3aXpEvWA210kLyR7yDPdOVRDiPp/w3vmS3N4IW73E5u8ts+mcWzwJwPgoqVewS6iw0m7sKEHoyO4jyXUwesopOt+9ViWY5y94BVqXqmW2qzmZxYr/PcsqrOQo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR05MB3337.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39850400004)(6486002)(110136005)(54906003)(5660300002)(4326008)(186003)(31686004)(31696002)(6666004)(16526019)(86362001)(2906002)(478600001)(36756003)(83380400001)(956004)(8936002)(16576012)(52116002)(66476007)(66556008)(26005)(2616005)(8676002)(53546011)(316002)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: b92WqWX9rBLvlBULqY1BcMv0eR6AFJc7I0nnPypyGwSg3VteSfwIRohYK5xmuRZBlzCnV5iEmadM4Y5GVl1f/PywKaN/2CQR3opUhg6Y+2/pP2QOVZJ5Pq8ZEgNYuF7RZpemHiarbM66Wor+6CfSGnx/mZqxDG49QIC6Q5ThyzKKTbyYPL9VhZsDlODnaGGl2MUnlU/mz9/6rKSi+44J/ZoG+TGJTYT22fhEa/xSzwMInd4UlRibr39qwoh2iypSGvSzSV5F9IkSnXZCbmFscAlYvC/SU+pnF3VdA2YTqC0R9TgpXoAFx/49uMnfyjPL9jXVOIytueghJaOOJCM1x7Tvl7l1MJ7Ma0acUlWG+TPAl4aPUmQU21fKFTuObEsL0xNDNGnOn9pMLySDPpT2US8lhh+TkPWwnHFvYuwBXW/Ylv/kPwUSOrXJx0LlNS7PJsHNULQBazV3gAPTz4TVyqQk6YEZYH1mO2MRZy9C+TI=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251d8641-4de0-4982-5424-08d8335fcdfe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR05MB3337.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 01:36:24.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tu4scA0Aa1jLmTJRM1qu4h7wP6JavkZM9ksjFn1UDRscSlaWrq0V9HnJLah6sce068k/aC8BYC/dtkX+RgzVzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3913
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/28/2020 16:45, Zhu Yanjun wrote:
> On 7/29/2020 1:42 AM, Kamal Heib wrote:
>> On Tue, Jul 28, 2020 at 11:46:36PM +0800, Zhu Yanjun wrote:
>>> On 7/28/2020 9:44 PM, Kamal Heib wrote:
>>>> On Tue, Jul 28, 2020 at 09:21:06PM +0800, Zhu Yanjun wrote:
>>>>> On 7/28/2020 4:35 PM, Kamal Heib wrote:
>>>>>> On Thu, Jul 23, 2020 at 11:15:00PM +0800, Zhu Yanjun wrote:
>>>>>>> On 7/23/2020 9:15 PM, Jason Gunthorpe wrote:
>>>>>>>> On Thu, Jul 23, 2020 at 09:08:39PM +0800, Zhu Yanjun wrote:
>>>>>>>>> On 7/23/2020 3:25 PM, Kamal Heib wrote:
>>>>>>>>>> On Thu, Jul 23, 2020 at 02:58:41PM +0800, Zhu Yanjun wrote:
>>>>>>>>>>> On 7/23/2020 1:57 PM, Kamal Heib wrote:
>>>>>>>>>>>> On Wed, Jul 22, 2020 at 10:09:04AM +0800, Zhu Yanjun wrote:
>>>>>>>>>>>>> On Tue, Jul 21, 2020 at 7:28 PM Yanjun Zhu <yanjunz@mellanox.com> wrote:
>>>>>>>>>>>>>> From: Kamal Heib <kamalheib1@gmail.com>
>>>>>>>>>>>>>> Sent: Tuesday, July 21, 2020 6:16 PM
>>>>>>>>>>>>>> To: linux-rdma@vger.kernel.org
>>>>>>>>>>>>>> Cc: Yanjun Zhu <yanjunz@mellanox.com>; Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
>>>>>>>>>>>>>> Subject: [PATCH for-next] RDMA/rxe: Remove pkey table
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The RoCE spec require from RoCE devices to support only the defualt pkey, While the rxe driver maintain a 64 enties pkey table and use only the first entry. With that said remove the maintaing of the pkey table and used the default pkey when needed.
>>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi Kamal
>>>>>>>>>>>>>
>>>>>>>>>>>>> After this patch is applied, do you make tests with SoftRoCE and mlx hardware?
>>>>>>>>>>>>>
>>>>>>>>>>>>> The SoftRoCE should work well with the mlx hardware.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Zhu Yanjun
>>>>>>>>>>>>>
>>>>>>>>>>>> Hi Zhu,
>>>>>>>>>>>>
>>>>>>>>>>>> Yes, please see below:
>>>>>>>>>>>>
>>>>>>>>>>>> $ ibv_rc_pingpong -d mlx5_0 -g 11
>>>>>>>>>>>>         local address:  LID 0x0000, QPN 0x0000e3, PSN 0x728a4f, GID ::ffff:172.31.40.121
>>>>>>>>>>> Can you make tests with GSI QP?
>>>>>>>>>>>
>>>>>>>>>>> Zhu Yanjun
>>>>>>>>>>>
>>>>>>>>> Is this the GSI ?
>>>>>>>>>
>>>>>>>>> Please check GSI in "InfiniBandTM Architecture Specification Volume 1
>>>>>>>>> Release 1.3"
>>>>>>>>>
>>>>>>>>> Then make tests with GSI again.
>>>>>>> The followings are also removed by this commit. Not sure if it is good.
>>>>>>>
>>>>>>> "
>>>>>>>
>>>>>>> C9-42: If the destination QP is QP1, the BTH:P_Key shall be compared to the
>>>>>>> set of P_Keys associated with the port on which the packet arrived. If the
>>>>>>> P_Key matches any of the keys associated with the port, it shall be
>>>>>>> considered valid.
>>>>>>>
>>>>>>> "
>>>>>>>
>>>>>> The above is correct for ports that configured to work in InfiniBand
>>>>>> mode, while in RoCEv2 mode only the default P_Key should be associated
>>>>>> with the port (Please see below from "ANNEX A17:   ROCEV2 (IP ROUTABLE
>>>>>> ROCE)):
>>>>>>
>>>>>> """
>>>>>> 17.7.1 LOADING THE P_KEY TABLE
>>>>>>
>>>>>> Compliance statement C17-7: on page 1193 describes requirements for
>>>>>> setting the P_Key table based on an assumption that the P_Key table is
>>>>>> set directly by a Subnet Manager. However, RoCEv2 ports do not support
>>>>>> InfiniBand Subnet Management. Therefore, compliance statement C17-7:
>>>>>> on page 1193 does not apply to RoCEv2 ports.
>>>>> "
>>>>>
>>>>> C17-7: An HCA shall require no OS involvement to set the P_Key table;
>>>>>
>>>>> the P_Key table shall be set directly by Subnet Manager MADs.
>>>>>
>>>>> "
>>>>>
>>>>> In SoftRoCE, what set the P_Key table?
>>>>>
>>>> No one is setting the P_Key table in SoftRoCE, and no subnet manager in
>>>> the RoCE fabric.
>>>>
>>>> Could you please tell me what is wrong with this patch?
>>> Please read the mail thread again.
>>>
>>> GSI QP number is 1. In your commits, the handle of qpn == 1 is removed.
>>>
>>> It seems that it conflicts with IB specification.
>>>
>>> Not sure if it is good.
>>>
>> Could you please read my patch again and point to what do you think is
>> wrong?
> 
> What I said is very clear. Good luck

qpn == 1, qpn == x it, qpn == i, it doesn't matter. Please read the RoCEv2 annex:

A17.4.7 INFINIBAND PARTITIONING
Methods to populate the P_Key table associated with a RoCEv2 port are
outside the scope of this annex. Note that this annex relies on the partition
table being initialized at power on time with at least the default P_Key as
described in Chapter 10 (Software Transport Interface) of the base specification. The P_Key contained in the BTH is validated for inbound packets
as required by the packet header validation protocols defined in Chapter
9 of the base specification.

A17.7.1 LOADING THE P_KEY TABLE
Compliance statement C17-7 describes requirements for setting the
P_Key table based on an assumption that the P_Key table is set directly
by a Subnet Manager. However, RoCEv2 ports do not support InfiniBand
Subnet Management. Therefore, compliance statement C17-7 does not
apply to RoCEv2 ports.
Methods for setting the P_Key table associated with a RoCEv2 port are
not defined in this specification, except for the requirements for a default
P_Key described elsewhere in this annex.

rxe =  Software RDMA over Ethernet, so we are dealing only with RoCE traffic (no IB).
We don't have an SM.
The spec requires that at least the default pkey is defined (and rxe defines only the default p_pkey).
Kamel is doing just that.

Mark

> 
> Zhu Yanjun
> 
>>
>> What I did in this patch is to verify that the pkey value in the
>> received packet is the default P_Key regardless of the qpn, because RoCE
>> devices should maintain only the default P_Key.
>>
>> Thanks,
>> Kamal
>>
>>>> Thanks,
>>>> Kamal
>>>>
>>>>>> Methods for setting the P_Key table associated with a RoCEv2 port are
>>>>>> not defined in this specification, except for the requirements for a
>>>>>> default P_Key described elsewhere in this annex.
>>>>>> """
>>>>>>
>>>>>> Thanks,
>>>>>> Kamal
>>>>>>
>>>>>>
>>>>>>>> rping uses RDMA CM which goes over the GSI
>>>>>>>>
>>>>>>>> Jason
>>>
> 
