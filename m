Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C841D32737E
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Feb 2021 18:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhB1REv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Feb 2021 12:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhB1REv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Feb 2021 12:04:51 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888CFC06174A
        for <linux-rdma@vger.kernel.org>; Sun, 28 Feb 2021 09:04:10 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x9so9809574otp.8
        for <linux-rdma@vger.kernel.org>; Sun, 28 Feb 2021 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ww4uGcECpI3Nj4rsLuCNQEc83zwL8mSxy/o9PgvaFe8=;
        b=tgzxioWWEh53DteitPdLc9C+1ZDBH99ZU7/Fqxa445nKC1DoBBQEnCtXfA1Gr7Ftul
         ojksFV8+NUED1w3Ml6p9IcYcl8Yq6iJQP41CGIJafkDMeGCX/0u06IU5Hv9/QV8rs4il
         vq1C558Y5XJAgCXJ5HMwq/UXycFj+HfrLgaeGA7puZP+h/iXidmqds/65uVubFMO5EE7
         Qxa59uJL/vWktiMYzTM7wyadiGtRKiJaxZOi5UfTDRSVJkgAjyZXft6TvQfVIYsEWcaI
         Inb3pm6IJnC7k8F8+herpINS3ftQ8T+oXXjcYOvM+ZyPYfUbbe/Z1GHGXEpk61kL7RMR
         u3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ww4uGcECpI3Nj4rsLuCNQEc83zwL8mSxy/o9PgvaFe8=;
        b=HFo0ejvcUbhetNxN9aj5VoraaWStt2zzcP9kHHSExgsZx0Zo9jrL1yKA4hwuQbASnm
         EnRi34ROKzaRIPaNV3t881lH5nV0BR/M/5p0aFp78N3h34V85T4KVDeTAUT/SFizYbL5
         Up92X6NbAk6C83E3MuehB4nFJDKfFDGlcb+mkegO0Blw8R8M+QihWjAI4AHuuOgxxef+
         dwSwfTU3gpN8ShMWzX4o5PXDcBDyEEcErBWK0Kun3lxxABQKXhBOWx2MzmZerkFVq5Yw
         YCuBqaJz2eUafNU2KJJ1O7RfnQM9g1AfuUGlQjD8sJwh1K4mVokTfdvELgXz+plPbW2+
         N+cg==
X-Gm-Message-State: AOAM531nv9MrXUvNOhoR8myJaAlZ3Hq5XulsHcTwxAOZpvB6knVUjui2
        YSmjqH7YvI+9kPQkeonU850huC4Un7SHTw==
X-Google-Smtp-Source: ABdhPJzCrdJoCvn1PxdCv4stGV78labwc31RvhP/XwtbXaDrQeFJUkt9GOQulA4faFStJeLOh3qeYg==
X-Received: by 2002:a9d:75d0:: with SMTP id c16mr5246759otl.51.1614531849753;
        Sun, 28 Feb 2021 09:04:09 -0800 (PST)
Received: from [192.168.0.21] ([97.99.248.255])
        by smtp.gmail.com with ESMTPSA id d13sm3180522otf.52.2021.02.28.09.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 09:04:09 -0800 (PST)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, Frank Zago <frank.zago@hpe.com>
References: <20210214222630.3901-1-rpearson@hpe.com>
 <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
 <20210226233301.GA4247@nvidia.com>
 <3165add7-518d-9485-fa12-6d7822ed9165@gmail.com> <YDoGJIcB6SB/7LPj@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <db406802-25a8-bda8-6add-4b75057eec96@gmail.com>
Date:   Sun, 28 Feb 2021 11:04:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDoGJIcB6SB/7LPj@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/27/21 2:43 AM, Leon Romanovsky wrote:
> On Fri, Feb 26, 2021 at 06:02:39PM -0600, Bob Pearson wrote:
>> On 2/26/21 5:33 PM, Jason Gunthorpe wrote:
>>> On Fri, Feb 26, 2021 at 05:28:41PM -0600, Bob Pearson wrote:
>>>> Just a reminder. rxe in for-next is broken until this gets done.
>>>> thanks
>>>
>>> I was expecting you to resend it? There seemed to be some changes
>>> needed
>>>
>>> https://patchwork.kernel.org/project/linux-rdma/patch/20210214222630.3901-1-rpearson@hpe.com/
>>>
>>> Jason
>>>
>> OK. I see. I agreed to that complaint when the kfree was the only thing in the if {} but now I have to call ib_device_put() *only* in the error case not if there wasn't an error. So no reason to not put the kfree_skb() in there too and avoid passing a NULL pointer. It should stay the way it is.
> 
> First, I posted a diff which makes this if() redundant.
> Second, the if () before kfree() is checked by coccinelle and your
> "should stay the way it is" will be marked as failure in many CIs,
> including ours.
> 
> Thanks
> 
>>
>> bob

Leon,

I am not sure we are talking about the same if statement. You wrote

...
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 8a48a33d587b..29cb0125e76f 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -247,6 +247,11 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	else if (skb->protocol == htons(ETH_P_IPV6))
 		memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));

+	if (!ib_device_try_get(&rxe->ib_dev)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	/* lookup mcast group corresponding to mgid, takes a ref */
 	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
 	if (!mcg)
@@ -274,10 +279,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		 */
 		if (mce->qp_list.next != &mcg->qp_list) {
 			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
-			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
-				kfree_skb(per_qp_skb);
-				continue;
-			}
 		} else {
 			per_qp_skb = skb;
 			/* show we have consumed the skb */
...

which I don't understand.

When a received packet is delivered to the rxe driver in rxe_net.c in rxe_udp_encap_recv() rxe_get_dev_from_net() is called which gets a pointer to the ib_device (contained in rxe_dev) and also takes a reference on the ib_device. This pointer is stored in skb->cb[] so the reference needs to be held until the skb is freed. If the skb has a multicast address and there are more than one QPs belonging to the multicast group then new skbs are cloned in rxe_rcv_mcast_pkt() and each has a pointer to the ib_device. Since each skb can have quite different lifetimes they each need to carry a reference to ib_device to protect against having it deleted out from under them. You suggest adding one more reference outside of the loop regardless of how many QPs, if any, belong to the multicast group. I don't see how this can be correct.

In any case this is *not* the if statement that is under discussion in the patch. That one has to do with an error which can occur if the last QP in the list (which gets the original skb in the non-error case) doesn't match or isn't ready to receive the packet and it fails either check_type_state() or check_keys() and falls out of the loop. Now the reference to the ib_device needs to be let go and the skb needs to be freed but only if this error occurs. In the normal case that all happens when the skb if done being processed after calling rxe_rcv_pkt().

So the discussion boils down to whether to type

...
err1:
	kfree_skb(skb);
	if (unlikely(skb))
		ib_device_put(&rxe->ib_dev);

or

err1:
	if (unlikely(skb)) {
		kfree_skb(skb);
		ib_device_put(&rxe->ib_dev);
	}

Here the normal non-error path has skb == NULL and the error path has skb set to the originally delivered packet. The second choice is much clearer as it shows the intent and saves the wasted trip to kfree_skb() for every packet.

bob
