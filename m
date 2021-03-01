Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3124F3285B5
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 17:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhCAQ5j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 11:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhCAQzN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 11:55:13 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F6FC061756
        for <linux-rdma@vger.kernel.org>; Mon,  1 Mar 2021 08:54:23 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id h22so17102200otr.6
        for <linux-rdma@vger.kernel.org>; Mon, 01 Mar 2021 08:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ni+b9KqebYED7x9o3lHYC5k2cPstM6TLrE+abovJicU=;
        b=hORdyf25EyCHv/gOnboM2zAQjH1eksPcZadPFNYAO2snTGy9Z2dTn44TtK5bWoeXH/
         PvYseUGBnT+XW91tfIobVdOJ9bNhv9cFFtoVKCiM9fWDPZiBngOI9//D27eXNTuOWuER
         fWpzV01AfSZxcnf0u1MThRB0uUmhGeZyTY6T+XIRwgrcZ5HmnhwU21HpGXW3P/bVL7xF
         OFPzgD4288WrA8UCgxaoZqiFsLtg8qC/4kJRZIbG+lBDGw50Ze91H9tjKfTvksV9rBFW
         n2FD7uKPWrA/z+H9eIzvZmJvhcur03qLmbnM5SmBZmuk5stQMv5S/Ip3IAGr7HcsuaVQ
         fftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ni+b9KqebYED7x9o3lHYC5k2cPstM6TLrE+abovJicU=;
        b=djn8nQOjR2mykZDVJBzI7tGRG679U+PQJf9tT+rnZVBREN0fQZMwlbQxwAjt9BU0Dh
         Q/qg0DqFBXlvVKmMppOqFzCYJCqmZsYJ/3KAo9UH9/ErxgLtg3nfIiWAg4354ntwlfpJ
         IMr0EBkGEv4K+/GGIQCxXV/BOnNKkloL66Qm5sKw1VmDdh2imcZjA67nM1yu0IzpWbF3
         aq1xyAUmc+a/MrdOdI3Q+qMiYCtVQPU/s7rPelhIJuSWcQHCM5rfXOmRgFDo2+Y1UTi6
         f9MUW9vs4Dgo+yBx9vSvbn8usWCNQfIAR+XHhpAv9+OfbYVu+uacwD2bfVee/YCgmDJs
         mZqA==
X-Gm-Message-State: AOAM5317wCCjVsWjIK8M3LFaKeOVw0vr6czozkFo4Zr6JA/+NkFCfOPr
        IttOcg9pGh2KjClDgzzs0d+eSsTXd2gExw==
X-Google-Smtp-Source: ABdhPJz+cryA+h3OvXG1dhjd/jUFE2rVUYaXntCACg1PcUW0u+7PYllNwpzE4gSh1TxqjHpAjVchpQ==
X-Received: by 2002:a9d:7512:: with SMTP id r18mr14421545otk.90.1614617662545;
        Mon, 01 Mar 2021 08:54:22 -0800 (PST)
Received: from [192.168.0.21] ([97.99.248.255])
        by smtp.gmail.com with ESMTPSA id 3sm3492383oid.27.2021.03.01.08.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 08:54:22 -0800 (PST)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, Frank Zago <frank.zago@hpe.com>
References: <20210214222630.3901-1-rpearson@hpe.com>
 <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
 <20210226233301.GA4247@nvidia.com>
 <3165add7-518d-9485-fa12-6d7822ed9165@gmail.com> <YDoGJIcB6SB/7LPj@unreal>
 <db406802-25a8-bda8-6add-4b75057eec96@gmail.com> <YDyWqLuRw33mU63D@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <b1fec0dc-6b4a-8364-2b90-a4ef5cd839c6@gmail.com>
Date:   Mon, 1 Mar 2021 10:54:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDyWqLuRw33mU63D@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/1/21 1:24 AM, Leon Romanovsky wrote:
> On Sun, Feb 28, 2021 at 11:04:08AM -0600, Bob Pearson wrote:
>> On 2/27/21 2:43 AM, Leon Romanovsky wrote:
>>> On Fri, Feb 26, 2021 at 06:02:39PM -0600, Bob Pearson wrote:
>>>> On 2/26/21 5:33 PM, Jason Gunthorpe wrote:
>>>>> On Fri, Feb 26, 2021 at 05:28:41PM -0600, Bob Pearson wrote:
>>>>>> Just a reminder. rxe in for-next is broken until this gets done.
>>>>>> thanks
>>>>>
>>>>> I was expecting you to resend it? There seemed to be some changes
>>>>> needed
>>>>>
>>>>> https://patchwork.kernel.org/project/linux-rdma/patch/20210214222630.3901-1-rpearson@hpe.com/
>>>>>
>>>>> Jason
>>>>>
>>>> OK. I see. I agreed to that complaint when the kfree was the only thing in the if {} but now I have to call ib_device_put() *only* in the error case not if there wasn't an error. So no reason to not put the kfree_skb() in there too and avoid passing a NULL pointer. It should stay the way it is.
>>>
>>> First, I posted a diff which makes this if() redundant.
>>> Second, the if () before kfree() is checked by coccinelle and your
>>> "should stay the way it is" will be marked as failure in many CIs,
>>> including ours.
>>>
>>> Thanks
>>>
>>>>
>>>> bob
>>
>> Leon,
>>
>> I am not sure we are talking about the same if statement. You wrote
>>
>> ...
>> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
>> index 8a48a33d587b..29cb0125e76f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
>> @@ -247,6 +247,11 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>>  	else if (skb->protocol == htons(ETH_P_IPV6))
>>  		memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));
>>
>> +	if (!ib_device_try_get(&rxe->ib_dev)) {
>> +		kfree_skb(skb);
>> +		return;
>> +	}
>> +
>>  	/* lookup mcast group corresponding to mgid, takes a ref */
>>  	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
>>  	if (!mcg)
>> @@ -274,10 +279,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>>  		 */
>>  		if (mce->qp_list.next != &mcg->qp_list) {
>>  			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
>> -			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
>> -				kfree_skb(per_qp_skb);
>> -				continue;
>> -			}
>>  		} else {
>>  			per_qp_skb = skb;
>>  			/* show we have consumed the skb */
>> ...
>>
>> which I don't understand.
>>
>> When a received packet is delivered to the rxe driver in rxe_net.c in rxe_udp_encap_recv() rxe_get_dev_from_net() is called which gets a pointer to the ib_device (contained in rxe_dev) and also takes a reference on the ib_device. This pointer is stored in skb->cb[] so the reference needs to be held until the skb is freed. If the skb has a multicast address and there are more than one QPs belonging to the multicast group then new skbs are cloned in rxe_rcv_mcast_pkt() and each has a pointer to the ib_device. Since each skb can have quite different lifetimes they each need to carry a reference to ib_device to protect against having it deleted out from under them. You suggest adding one more reference outside of the loop regardless of how many QPs, if any, belong to the multicast group. I don't see how this can be correct.
>>
>> In any case this is *not* the if statement that is under discussion in the patch. That one has to do with an error which can occur if the last QP in the list (which gets the original skb in the non-error case) doesn't match or isn't ready to receive the packet and it fails either check_type_state() or check_keys() and falls out of the loop. Now the reference to the ib_device needs to be let go and the skb needs to be freed but only if this error occurs. In the normal case that all happens when the skb if done being processed after calling rxe_rcv_pkt().
>>
>> So the discussion boils down to whether to type
>>
>> ...
>> err1:
>> 	kfree_skb(skb);
>> 	if (unlikely(skb))
>> 		ib_device_put(&rxe->ib_dev);
>>
>> or
>>
>> err1:
>> 	if (unlikely(skb)) {
>> 		kfree_skb(skb);
>> 		ib_device_put(&rxe->ib_dev);
>> 	}
>>
>> Here the normal non-error path has skb == NULL and the error path has skb set to the originally delivered packet. The second choice is much clearer as it shows the intent and saves the wasted trip to kfree_skb() for every packet.
> 
> Can you please configure your mail client so your replies won't be one
> long unreadable lines? It will help us to read your replies and we will
> be able to answer them separately.
Sorry about that. It's Thunderbird. Looking for a solution.
> 
> Once the rxe_rcv_mcast_pkt() is called, the device and SKB are already
> "connected" each one to another, so I don't understand the claims about
> different lifetimes. It is not the "if ()", but the whole idea that every
> SKB increments reference counter sounds very strange.
The purpose of rxe_rcv_mcast_pkt() is to replicate the original received skb
as many times as necessary to enqueue to the multiple QPs which are listening to
the multicast address. Depending on the queue depths, which CPU, etc. they will
take more or less time to process. There is no telling which one of them will be
the last one to get done. Counting them is the easiest way to figure out when we
are complete.
> 
> All QPs, mcast groups and SKB points to the same ib_dev and even one
> refcount is enough to ensure that it won't vanish. This is why it is
> enough to call ib_device_try_get() at the beginning of this function.
I agree that ib_device_get/put is attempting to solve a problem that it not
really very critical since ib_device is very unlikely to be shut down in the
middle of a data transfer. The driver never worried about this for years.
But now that it's been put on the table it should be done right. A data packet
arriving is completely independent of the verbs API which *could* delete all the
QPs and shut down the HCA while it was wondering around the universe or worse
yet while the packet is being processed.
You are correct one call will protect the address, but how will you decide
when you are ready to drop that one reference? You have N clones of the skb sitting
on queues waiting to get processed. Where do you stick the drop reference so that
it only happens once and only when all the skbs are done?
> 
> Also the combination of ib_device_get() together with unlikely() to save
> kfree call can't be right either.
That is not why they are there. The ib_device_put is there because the skb holds
a reference to the ib_device so it needs to be dropped. The unlikely is because it
is actually unlikely. It only happens when there is a bad packet.
> 
> Thanks
> 
>>
>> bob

