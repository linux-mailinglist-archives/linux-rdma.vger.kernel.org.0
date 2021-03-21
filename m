Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAAF3433AE
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 18:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCURWE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 13:22:04 -0400
Received: from mail-eopbgr760109.outbound.protection.outlook.com ([40.107.76.109]:55493
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230264AbhCURVa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 13:21:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmTQeustWWqGkl1U5l7XC59yJdsdzPOeSPyMsAsOk2rLRjqCPcDaYZ5oIFRZAnDikiyUNQTxlG/fkIbHoAoZdDndGkA8CWFAe03qEJB1ZKPDdB1H0/NY5yXl0QJtGpu0r8AiEwEAzIYK+HwI+F4GFvO/Au3bE6sg4x76hjvP3Hm8ZPT+9I1KiBNOXxlY6uiyxtkh3y3nBNJE7DE1bY37K1WVWg4sy2IGMrqBF6aHD2qLWn5khndx9a3sdcb9zl7NFGhGm8xwA6zucP09ufTykrXjpqw8v/FzxW8g5iwu3M5/HuiFkuWPKf8qjfBM5D78JXkUBYJByAYosEv7nNdkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9R4nLHtOW4JYlNKn0FKkdPebuU7aCO4d0gjk/f0Y3w=;
 b=DA5HE0+shw9qMziUYBRfWJ2idUNHBTl1+b70NX9308penMCcXXYxw+2N5bjEtOO7Hj/vTJssgiYGIvBOizZcQyy4/zk7PZT73wsruCKnW5rNsrvCDS2OeBVHvQaW2lVSNvhxovkeNYYnfGkOZYjx5tds+efPaBAvwou0yYjUB5CqCcIJsn8tzT62D1F15a+YenpwJazVaY5T0K18PinMXpSbp06VUE0s1Wxy2scwsg+AXVW3bDKdEM80vH4Huh8nNstLinQ8xDjQyFEkIbK0NNi8AjNO60Odu/DU0EzFLIekWDzHe3hedcho6UMUruHd1NUNXlY9xI1e+oDQ/RV0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9R4nLHtOW4JYlNKn0FKkdPebuU7aCO4d0gjk/f0Y3w=;
 b=O7dYF9+iAJE6sAO+zfW5qdq6Ye/zgxMu9uK97JZ86Ok+j+TjTsDqB0cReZawWyPXqsmlKhqXh+di/UvG2TIyJ/OYuIqH0HmU1DRYnvNh8RC4JkdRC2jS7oMkUcVXgsvelEmRIDkPP2lPn4Y14CrMECqAqwgTnDjJsOF9ubOFmN82wH+Pbw9qQ+vBMIKB6B99vaaMUgAVX6u6NkSMBcu6Oa26K5P32qlg0hR/ydq5T9Shevp8K/ABkB6L5+fi+y3o7AoRuoiJEnnW+ZdqR+sTiVS8CkWFPuAXxtpa33qeVKk6OAscuF0/5dCzQvNLsJ5eZVSIXwbSEkM3erE7gafEfQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6134.prod.exchangelabs.com (2603:10b6:510:13::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Sun, 21 Mar 2021 17:21:27 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3955.025; Sun, 21 Mar 2021
 17:21:22 +0000
Subject: Re: [PATCH RFC 0/9] A rendezvous module
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
 <20210321164504.GS2356281@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
Date:   Sun, 21 Mar 2021 13:21:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210321164504.GS2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BLAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:32b::34) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by BLAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:32b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 17:21:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 325a8184-5111-4849-d00d-08d8ec8dbf83
X-MS-TrafficTypeDiagnostic: PH0PR01MB6134:
X-Microsoft-Antispam-PRVS: <PH0PR01MB61341F1B5F06A68AABC9C823F4669@PH0PR01MB6134.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNpME0W0ZdGKW/6AyUlgP+CwtXZJwcuXAtdwa83zFImahQt1uydvX5AlpxEiDwZnWqWQEwuOofEAN6kJBK5Cx5NV6i11lNVUu0PeWzhGQzhNgHc0eFY/zk4NqD+eLqYAvDVaQSgRbYdCmjfJ0NBSckCSvIof0vOiqNdM050zwPrKhgPF2FEC/WEtHFEZzKlsShaZ1AGNNNL2HfjegFXI4FZrP5mqH0/0UdG4Nj8XzKqjKXJ1oLyBCMKlawiu9tutvi9vM8WoHIoJCV98DwLFvZNpt4mmLn6HKEfYfGf+yC3a9kmqKrkJHSCv4DsRcdpXI34JooLuMo13fbZjJorD/4RzIfrw9+d/mM3i7OYzOfkce8rI+RuasrdGtW7Gtcfk4qdWmwh6XRyC64isauITWNYE5NkF3ldBXD1kZIqol5HJkoatng45CdHXw6XsdnCNSHKkzcvLr0XrkQrNoo1VI7OPWz5Q7QPXwpkkMU2RjaKAxdWAHkuBV6y8diexbPwc6jwDbnc7VOtJClPdi35L6H83HNSFD+MlRYr5TcMeC/ZIv/dhtrVST9JvlUeS61PEK7r3XzQwPQAGxXEh90qq8fg0vgOv4uxuRkg23E+cs5ohPy/hKwDyxmEYya80VHgBDWoZ7nClNKpdCvVrUFHpYfidFJRwqmOLGI11v9fBVxH7M9xHjUL3Yzgb3GGVI2ykMEmbDFYiul6OMoj6Jx80DMQG8eOrmmtz7ZfqxXjMTaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39830400003)(136003)(366004)(376002)(396003)(6486002)(44832011)(31696002)(31686004)(186003)(26005)(2616005)(38100700001)(6666004)(4326008)(956004)(54906003)(478600001)(16576012)(83380400001)(86362001)(316002)(52116002)(66476007)(6916009)(8936002)(8676002)(36756003)(53546011)(2906002)(66946007)(66556008)(16526019)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d0kwMWVVSmwydnZ1MEswNFoxMnlBeWFvamFNdXNXWmppVGlEVlU1Q3lmQzJ4?=
 =?utf-8?B?Y2w1VXJZZEJUeTkzYzB6a3N6b053MUg3MXY2NjFYTC9NeVV3OTJCQ3BtVEZa?=
 =?utf-8?B?SjI0c3B5cUVlTnNXSm9tb2s3bHlrR0pkb2c5L1h6OHMwaStRY29LcGhHOXcw?=
 =?utf-8?B?aWo0Z1N2U3crN042RHZlQzFpbHdORVV1cWhxNzduSmh5cFZtb3MyUk55bVRI?=
 =?utf-8?B?UUNucmtNeWVHd2VqNmlPaWYwdFlCTDBnTU1NTElJQ0FpNmRpTVBWN2taRDV2?=
 =?utf-8?B?TW5CdGtrQjRMOFJ1QUJMdm5XNGkwelZrWTdvdUNkL3dUcEk3emcvZjVDZmpL?=
 =?utf-8?B?MG1nTjVKb2o4bmFnNys1eE5JaSt4U2hFVVUxR0Q4R0c4R1ZXTmFHVXlUK0NV?=
 =?utf-8?B?VUI4RnF1ZTZLZ3gwdkVkcDM4N1lOOXVjMlpuemxGMGlTSUxFSkdaOUpVcnc3?=
 =?utf-8?B?TG42eSs5eUJCWWZWMkpFU0RDam5YOXBNWHlpU3NPQVc4UDJFNHc2aWhiTHEy?=
 =?utf-8?B?b0tUUnlrZHlBVFZ1TExUMmM0dU5UUFhxQmlFNjhIR2hKdVROSmw5QUpsMGhU?=
 =?utf-8?B?R3NPWG1aWEVFQU42U0h1NUhEY25PSEZISjlyKzFZbW4vZXM4WXJsS3dpVXBI?=
 =?utf-8?B?UWJmck5QZGFxOVRDd04ycEMwWGRHR2pvVm53V0x6aFRBdlg4djRPNXF5YWdn?=
 =?utf-8?B?TXhETHZZN0JJUWZJd3R5OGljbEp4dk1EdThscDlzS2pFb3FXdmZ2OWlRaWo4?=
 =?utf-8?B?WWdBS1lVdzFOakRjU0FRR0tDSDdSc3JQbzUvOXNmdTRnUmhyNUlWaHErNzlk?=
 =?utf-8?B?U08wWFZ0dTM3WE1mb1RXRXZYWEk0NC9NTDN1Rk1wUWVUQjFldTdSUTdNaG1J?=
 =?utf-8?B?bG1NeStyZDcvOXpkb3dqVDVONUtEVnEzcUplUlRESEd6TVBRWTdNTWlxeHdu?=
 =?utf-8?B?OGdjWVdXcHRBaHlBNitXVU90VnllaWVNK0ZBYTBsSUpxaUFEeUhMLy9EVlNp?=
 =?utf-8?B?Ump1cjlCUU9jNHZObm9wTDZwalNtZlllYzVUVk9hYU51ZmVhMVMxYnlIL0Uz?=
 =?utf-8?B?TkZ4U1hocEp0SzJSVzVSSnIwWHNWTXlobHR4NU9jK2dYQUtSUWh6VmRNanZT?=
 =?utf-8?B?ZURabUZnL0VoVE91czJrL0gwcGJBNVJtaE9EbXJzbmlwT0wwS0tYT2ZRUktr?=
 =?utf-8?B?ckQ0Z29CMmFNQmk2d0xzdFl0TlQyNTNrSUJkNFpZdHp2QjFjVzRURHNTZmRw?=
 =?utf-8?B?ZUQrUnk4MEJzQVlPZCtTcUNzMVRvbzBYMlBRNzVaQy9EN0dDYzNCWHZKdzBC?=
 =?utf-8?B?RUZXL0lGMkx2NkNQdENGNFd3STFxVEQrNnBvUUh5ODdXUDVSRVV4YUtYRjNo?=
 =?utf-8?B?UCt2bU5XVVhQUGcvSmp0d2M1N0tIekprTW5DNHFwVmpkR1BZaEF5eEVoZkRM?=
 =?utf-8?B?dkd1eGpqUzV4RVFmR21uaURZckliNVZxcXBvd2lpZzlnSGlaRWN1bTF0S2dR?=
 =?utf-8?B?em5idm8veWZyM0NyVE9aSllEY29FYW5JRWlJTkpJaERpZkVxTVdJamNxdi9w?=
 =?utf-8?B?TzhHc0lPOFd5dVg2Y0E1R3lYMFd6OXE3aUVYZjlEbmRnU2thUk16V25CZExp?=
 =?utf-8?B?eTlrQXBMQkM4VkVOK2JocjdqejlxT3oyTndVb0tYcnR1UG9oNlpmMVU4OWxs?=
 =?utf-8?B?THZENWtycFU1Qi92U2xJUGhyS21QeDdFeDFudkNVc1BlVjBSdnNBMzVoQ28r?=
 =?utf-8?Q?3HY2mq/wyaY3LHTsJUl9Lc10jcsnvwXeZfyB0vz?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325a8184-5111-4849-d00d-08d8ec8dbf83
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 17:21:22.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uATkz1qXOYp5U89dc5MW2LlibdoSmBsuMrwD/cmNv+c/L5vGKTBVpFXRtC321vjoLXJQz5RmRU5P1Gqga6wHQEzCPQhSHtnFDfi5zoJe3ahjtYXZIj5Ms19Yx/OV/wKA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6134
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/21/2021 12:45 PM, Jason Gunthorpe wrote:
> On Sun, Mar 21, 2021 at 12:24:39PM -0400, Dennis Dalessandro wrote:
>> On 3/21/2021 4:56 AM, Leon Romanovsky wrote:
>>> On Sat, Mar 20, 2021 at 12:39:46PM -0400, Dennis Dalessandro wrote:
>>>> On 3/19/2021 6:57 PM, Rimmer, Todd wrote:
>>>>>>> [Wan, Kaike] Incorrect. The rv module works with hfi1.
>>>
>>> <...>
>>>
>>>>> We have removed all GPU specific code from the upstream submission, but used both the "alignment holes" and the "reserved"
>>>>> mechanisms to hold places for GPU specific fields which can't be upstreamed.
>>>>
>>>> This problem extends to other drivers as well. I'm also interested in advice
>>>> on the situation. I don't particularly like this either, but we need a way
>>>> to accomplish the goal. We owe it to users to be flexible. Please offer
>>>> suggestions.
>>>
>>> Sorry to interrupt, but it seems that solution was said here [1].
>>> It wasn't said directly, but between the lines it means that you need
>>> two things:
>>> 1. Upstream everything.
>>
>> Completely agree. However the GPU code from nvidia is not upstream. I don't
>> see that issue getting resolved in this code review. Let's move on.
>>
>>> 2. Find another vendor that jumps on this RV bandwagon.
>>
>> That's not a valid argument. Clearly this works over multiple vendors HW.
> 
> At a certain point we have to decide if this is a generic code of some
> kind or a driver-specific thing like HFI has.
> 
> There are also obvious technial problems designing it as a ULP, so it
> is a very important question to answer. If it will only ever be used
> by one Intel ethernet chip then maybe it isn't really generic code.

Todd/Kaike, is there something in here that is specific to the Intel 
ethernet chip?

> On the other hand it really looks like it overlaps in various ways
> with both RDS and the qib/hfi1 cdev, so why isn't there any effort to
> have some commonality??

Maybe that's something that should be explored. Isn't this along the 
lines of stuff we talked about with the verbs 2.0 stuff, or whatever we 
ended up calling it.

>> We should be trying to get things upstream, not putting up walls when people
>> want to submit new drivers. Calling code "garbage" [1] is not productive.
> 
> Putting a bunch of misaligned structures and random reserved fields
> *is* garbage by the upstream standard and if I send that to Linus I'll
> get yelled at.

Not saying you should send this to Linus. I'm saying we should figure 
out a way to make it better and insulting people and their hard work 
isn't helping. This is the kind of culture we are trying to get away 
from in the kernel world.

> And you certainly can't say "we are already shipping this ABI so we
> won't change it" either.
> 
> You can't square this circle by compromising the upstream world in any
> way, it is simply not accepted by the overall community.
> 
> All of you should know this, I shouldn't have to lecture on this!

No one is suggesting to compromise the upstream world. There is a bigger 
picture here. The answer for this driver may just be take out the 
reserved stuff. That's pretty simple. The bigger question is how do we 
deal with non-upstream code. It can't be a problem unique to the RDMA 
subsystem. How do others deal with it?

> Also no, we should not be "trying to get things upstream" as some goal
> in itself. Upstream is not a trashcan to dump stuff into, someone has
> to maintain all of this long after it stops being interesting, so
> there better be good reasons to put it here in the first place.

That is completely not what I meant at all. I mean we should be trying 
to get rid of the proprietary, and out of tree stuff. It doesn't at all 
imply to fling crap against the wall and hope it sticks. We should be 
encouraging vendors to submit their code and work with them to get it in 
shape. We clearly have a problem with vendor proprietary code not being 
open. Let's not encourage that behavior. Vendors should say I want to 
submit my code to the Linux kernel. Not eh, it's too much of a hassle 
and kernel people are jerks, so we'll just post it on our website.

> If it isn't obvious, I'll repeat again: I'm highly annoyed that Intel
> is sending something like this RV, in the state it is in, to support
> their own out of tree driver, that they themselves have been dragging
> their feet on responding to review comments so it can be upstream for
> *years*.

To be fair it is sent as RFC. So to me that says they know it's a ways 
off from being ready to be included and are starting the process early.

-Denny

