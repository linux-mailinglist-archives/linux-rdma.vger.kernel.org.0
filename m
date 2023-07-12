Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3F8750FF2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjGLRs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 13:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjGLRs4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 13:48:56 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 10:48:53 PDT
Received: from smtp.rcn.com (mail.rcn.syn-alias.com [129.213.13.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0C61FFC
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 10:48:53 -0700 (PDT)
X-Authed-Username: dG10YWxwZXlAcmNuLmNvbQ==
Authentication-Results:  smtp01.rcn.email-ash1.sync.lan smtp.user=<hidden>; auth=pass (PLAIN)
Received: from [96.237.161.173] ([96.237.161.173:51669] helo=[192.168.0.206])
        by smtp.rcn.com (envelope-from <tom@talpey.com>)
        (ecelerity 4.4.0.19839 r(msys-ecelerity:tags/4.4.0.0^0)) with ESMTPSA (cipher=AES128-GCM-SHA256) 
        id CE/40-05333-3D2EEA46; Wed, 12 Jul 2023 13:28:52 -0400
Message-ID: <a31b0568-f8f0-1940-9fce-6a011112d6a0@talpey.com>
Date:   Wed, 12 Jul 2023 13:28:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Chuck Lever <cel@kernel.org>, Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
 <168805181129.164730.67097436102991889.stgit@manet.1015granger.net>
 <1132df9f-63a1-f309-8123-b9302e5cdc3c@talpey.com>
 <7F4E0CAA-A06B-4F43-B019-4E471B10DDE7@oracle.com>
 <ZKM4jM6Ve5PUhHFk@nvidia.com>
 <a8f54410-f680-190a-5e00-3226f186b2d6@talpey.com>
 <50C32C40-D3D8-40CF-B332-C12FEE894FDF@oracle.com>
 <ZKw6rySZlRLCls+L@nvidia.com>
 <3748AE3D-95E1-4C22-925F-FA24740D1833@oracle.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <3748AE3D-95E1-4C22-925F-FA24740D1833@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Vade-Verdict: clean
X-Vade-Analysis-1: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdduudefucetufdoteggodetrfdotffvucfrrhho
X-Vade-Analysis-2: fhhilhgvmecuufgjpfetvefqtfdptfevpfdpgffpggdqtfevpfdpqfgfvfenuceurghilhhouhhtmecu
X-Vade-Analysis-3: fedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgj
X-Vade-Analysis-4: tgfgsehtjeertddtfeejnecuhfhrohhmpefvohhmucfvrghlphgvhicuoehtohhmsehtrghlphgvhidr
X-Vade-Analysis-5: tghomheqnecuggftrfgrthhtvghrnhepudethfegfeejjeeghedtffegkedttdduueekleejhfduudek
X-Vade-Analysis-6: gfehuedvudfgudefnecukfhppeeliedrvdefjedrudeiuddrudejfeenucevlhhushhtvghrufhiiigv
X-Vade-Analysis-7: pedtnecurfgrrhgrmhepihhnvghtpeeliedrvdefjedrudeiuddrudejfedphhgvlhhopegludelvddr
X-Vade-Analysis-8: udeikedrtddrvddtiegnpdhmrghilhhfrhhomhepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthht
X-Vade-Analysis-9: oheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihgu
X-Vade-Analysis-10: ihgrrdgtohhmpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuefovfes
X-Vade-Analysis-11: iihurhhitghhrdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgv
X-Vade-Analysis-12: rhhnvghlrdhorhhgpdhrtghpthhtohephigrnhhjuhhnrdiihhhusehlihhnuhigrdguvghvpdhmthgr
X-Vade-Analysis-13: hhhoshhtpehsmhhtphdtuddrrhgtnhdrvghmrghilhdqrghshhdurdhshihntgdrlhgrnh
X-Vade-Client: RCN
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/11/2023 6:49 PM, Chuck Lever III wrote:
> 
> 
>> On Jul 10, 2023, at 1:06 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Tue, Jul 04, 2023 at 02:54:59PM +0000, Chuck Lever III wrote:
>>>
>>>
>>>> On Jul 4, 2023, at 10:23 AM, Tom Talpey <tom@talpey.com> wrote:
>>>>
>>>> On 7/3/2023 5:07 PM, Jason Gunthorpe wrote:
>>>>> On Sat, Jul 01, 2023 at 04:27:23PM +0000, Chuck Lever III wrote:
>>>>>>
>>>>>>
>>>>>>> On Jul 1, 2023, at 12:24 PM, Tom Talpey <tom@talpey.com> wrote:
>>>>>>>
>>>>>>> On 6/29/2023 11:16 AM, Chuck Lever wrote:
>>>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>>> We would like to enable the use of siw on top of a VPN that is
>>>>>>>> constructed and managed via a tun device. That hasn't worked up
>>>>>>>> until now because ARPHRD_NONE devices (such as tun devices) have
>>>>>>>> no GID for the RDMA/core to look up.
>>>>>>>> But it turns out that the egress device has already been picked for
>>>>>>>> us -- no GID is necessary. addr_handler() just has to do the right
>>>>>>>> thing with it.
>>>>>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>>>> ---
>>>>>>>> drivers/infiniband/core/cma.c |   15 +++++++++++++++
>>>>>>>> 1 file changed, 15 insertions(+)
>>>>>>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>>>>>>>> index 889b3e4ea980..07bb5ac4019d 100644
>>>>>>>> --- a/drivers/infiniband/core/cma.c
>>>>>>>> +++ b/drivers/infiniband/core/cma.c
>>>>>>>> @@ -700,6 +700,21 @@ cma_validate_port(struct ib_device *device, u32 port,
>>>>>>>>   if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
>>>>>>>>   goto out;
>>>>>>>> + /* Linux iWARP devices have but one port */
>>>>>>>
>>>>>>> I don't believe this comment is correct, or necessary. In-tree drivers
>>>>>>> exist for several multi-port iWARP devices, and the port bnumber passed
>>>>>>> to rdma_protocol_iwarp() and rdma_get_gid_attr() will follow, no?
>>>>>>
>>>>>> Then I must have misunderstood what Jason said about the reason
>>>>>> for the rdma_protocol_iwarp() check. He said that we are able to
>>>>>> do this kind of GID lookup because iWARP devices have only a
>>>>>> single port.
>>>>>>
>>>>>> Jason?
>>>>> I don't know alot about iwarp - tom does iwarp really have multiported
>>>>> *struct ib_device* models? This is different from multiport hw.
>>>>
>>>> I don't see how the iWARP protocol impacts this, but I believe the
>>>> cxgb4 provider implements multiport. It sets the ibdev.phys_port_cnt
>>>> anyway. Perhaps this is incorrect.
>>>>
>>>>> If it is multiport how do the gid tables work across the ports?
>>>>
>>>> Again, not sure how to respond. iWARP doesn't express the gid as a
>>>> protocol element. And the iw_cm really doesn't either, although it
>>>> does implement a gid-type API I guess. That's local behavior though,
>>>> not something that goes on the wire directly.
>>>>
>>>> Maybe I should ask... what does the "Linux iWARP devices have but one
>>>> port" actually mean in the comment? Would the code below it not work
>>>> if that were not the case? All I'm saying is that the comment seems
>>>> to be unnecessary, and confusing.
>>>
>>> It replaces a code comment you complained about in an earlier review
>>> regarding the use of "if (rdma_protocol_iwarp())". As far as I
>>> understand, /in Linux/ each iWARP endpoint gets its own ib_device
>>> and that device has exactly one port.
>>>
>>> So for example, a physical device that has two ports would appear
>>> as two ib_devices each with a single port. Is that not how it
>>> works? It's certainly possible I've misunderstood something.
>>
>> That is how I would expect it to work. Multi-port ib_device is really
>> only something that exists to support IB's APM, and iWarp doesn't have
>> that.
>>
>> Otherwise verbs says a QP is bound to a single IB device's port and a
>> single GID of that port. It should not float around between multiple
>> ports.
>>
>> So, I don't know what the iwarp drivers did here.
>>
>> As for rthe comment, I don't think it is quite right, this code
>> already knows what ib_device port it is supposed to be using somehow,
>> so it doesn't matter.
>>
>> I think it should be more like:
>>
>> In iWarp mode we need to have a sgid entry to be able to locate the
>> netdevice. iWarp drivers are not allowed to associate more than one
>> net device with their gid tables, so returning the first entry is
>> sufficient. iWarp will ignore the GID entries actual GID, and the
>> passed in GID may not even be present in the GID table for tunnels
>> and other non-ethernet netdevices.
> 
> I can make that change and post a refresh. I'd like
> to hear from Tom first.

The extra detail is helpful, but I'm still queasy about tying this to
iWARP. The situation seems much more general. But the breadcrumbs are
here so if the situation arises in another transport, there's a trail
for others to follow.

Tom.
