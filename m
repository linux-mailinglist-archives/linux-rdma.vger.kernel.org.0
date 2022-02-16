Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687D34B8B4E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 15:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiBPOWE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 09:22:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiBPOWD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 09:22:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E629BBB8
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 06:21:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7856F1F383;
        Wed, 16 Feb 2022 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645021309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8fpjEnHRlFY7aGqEPlzq2ktfAdSJ8u70ifv1am08FT0=;
        b=twQkgBcJVtZwqHKJ1ZjbtrhJKF1g4lX2O4KTijA/iJugbegBe3NmDEecdaPJIrnokGBmB7
        Mabzxq9WlelW16lTWQh8K7541UsWmI8ex6FNCGyLtF6EPM0lHjHgcinYSL2Mkx6v8x8evn
        Hc36ArLu+yzarEsPzKrd7sh1BhYSNoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645021309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8fpjEnHRlFY7aGqEPlzq2ktfAdSJ8u70ifv1am08FT0=;
        b=k+kDkITtw6ynWMjCvoy6B6o3RSuNqiXawQhtTf5RjXWEPhzYzqXX90S2prOFxStpyjdfU0
        iIE14W3Ffm2P46CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32BFA13B24;
        Wed, 16 Feb 2022 14:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RWfzCX0IDWLBDgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 16 Feb 2022 14:21:49 +0000
Message-ID: <e7e530c8-5764-bfa6-b433-82ad590730ec@suse.de>
Date:   Wed, 16 Feb 2022 15:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Yongji Xie <xieyongji@bytedance.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Junji Wei <weijunji@bytedance.com>,
        Jason Wang <jasowang@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>,
        yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Virtio-Dev <virtio-dev@lists.oasis-open.org>,
        =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
 <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
 <YgzIfyx7WyGb39mV@unreal>
 <38D3D312-E507-426F-BB3E-211AC273593B@bytedance.com>
 <Ygzo2nMVicb3jkAn@unreal>
 <CACycT3vr8QgjR8SS7bbOGOurV5jKP9bh90jiPnekEZhqHPwtcg@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
In-Reply-To: <CACycT3vr8QgjR8SS7bbOGOurV5jKP9bh90jiPnekEZhqHPwtcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/16/22 15:08, Yongji Xie wrote:
> On Wed, Feb 16, 2022 at 8:06 PM Leon Romanovsky <leon@kernel.org> wrote:
>>
>> On Wed, Feb 16, 2022 at 06:03:29PM +0800, Junji Wei wrote:
>>>
>>>> On Feb 16, 2022, at 5:48 PM, Leon Romanovsky <leon@kernel.org> wrote:
>>>>
>>>> On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:
>>>>
>>>> <...>
>>>>
>>>>>>
>>>>>> What is the use case for this virtio-rdma? Especially in context of RXE.
>>>>>
>>>>> Hmm... yes, we didn’t find one. In passthrough case we can use RXE directly.
>>>>
>>>> It doesn't sound like a good sales pitch.
>>>
>>> Maybe I misunderstanded what you mean. We mean we didn’t find a user case
>>> for virtio-rdma with passthrough net device. Do you want to know the user
>>> case for our virtio-rdma(RoCE) proposal?
>>
>> Yes, please.
>>
> 
> I think one point is: when running RDMA accelerated applications in
> VM, the virtio-rdma solution should get better performance than RXE
> since it has a shorter data path (guest app -> host dpdk, bypass guest
> kernel).
> 
And you can (potentially) implement RDMA functionality in the hypervisor 
by 'simply' to a memcpy between guests.
(I know it's not simple. But you don't actually need RDMA hardware here 
and still should be able to provide RDMA functionality to guests.)

And if you look at the current RoCE CNAs they operate in exactly the 
same way; there's a network interface, and _additionally_ an rdma 
device. So for the OS both will be detected as distinct devices, who 
just happen to run on the same PCI device.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
