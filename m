Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEE44C33BF
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 18:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiBXRaY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 12:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiBXRaX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 12:30:23 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35E8186B8D
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 09:29:41 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id a6so3640090oid.9
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 09:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uP9TaKZZQALyA9SHYM+h4VLl34soCbzFECoEJpC65U4=;
        b=F843cWiMR4DeEyN1EwVgcYq6d6ZeYTOTdn7J+YMX5dkOeKORRRGy2K0cjcrJA7znEF
         NoD2f0v6JMll2uTb9J+06/OqLPJzkzBCD1k/pTiG7pfsnE9qqfb5ummKGEi7zEPjJG4f
         2nAZrDWM21wfE1E0gh+UtGf0/woosbUE2JHChd0p2GxrM2tMKJyZN//knGZq87jjK3pT
         wN1rPNHs4fbQgkw6aBaPw+SyYPJwQQdMzoCp8BwmZ7+tUj/BS4NZsnc29mQQPuPSlcKk
         0EiUhbk//ncRvlxQRMnZn2hHHQENHRFh51QSLlf3UqlqKyMHpIyjxdRN86tw1Di785JH
         ursw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uP9TaKZZQALyA9SHYM+h4VLl34soCbzFECoEJpC65U4=;
        b=HXQ9VasQP7Kj9VdvIs4xdfDmQl5IVzE9OjnxTArSdH1UtP8/cFt8ZYV06fajFOCVFX
         KrDv6hpbvU59FbyxHgJphbhQPKJkcw3A4fUP177dX31e1151mnpmsLWSBKcZ53MZjAIy
         UWrQWsZm8KP38v7/rtf3d5o9nOwC2NY/6lq7lcVVgQ6eUYtw6VqdfpxnvXewokEO2lJc
         rlm4zo0oT5LbaiZayzyRCtoQ9k0bZDi1RkTiENb6pg5C8dW0z3uY0WuEhaGzmg09BNrX
         d5KiZ4kypD8QfBtUvJVGnjX/eEKcshjqNnpyI0VcOFu4mrNwPWolgKWqP6ULzHDFT4Vk
         xVuw==
X-Gm-Message-State: AOAM531t92u5W0GABvlnH2doorsMJ6cJSVzJkrwlcZdihVPeql43pZFg
        VlfqnNf1m1KQZBSQC1kMI8k=
X-Google-Smtp-Source: ABdhPJxmtb3USeTfGXRIJ7vgEg+KrJGh+pVSWjYendvVTL4p0h9F1fw4CeiAEO5Z7KrDFdPhnKjv2w==
X-Received: by 2002:a05:6808:d4c:b0:2d7:eda:dd3c with SMTP id w12-20020a0568080d4c00b002d70edadd3cmr1958349oik.73.1645723777851;
        Thu, 24 Feb 2022 09:29:37 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:2cee:5c5:defb:ee71? (2603-8081-140c-1a00-2cee-05c5-defb-ee71.res6.spectrum.com. [2603:8081:140c:1a00:2cee:5c5:defb:ee71])
        by smtp.gmail.com with ESMTPSA id n42-20020a056870972a00b000d6ce21e05asm92465oaq.20.2022.02.24.09.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 09:29:37 -0800 (PST)
Message-ID: <f2c51036-4068-fffb-01e0-6df4a5ee75a4@gmail.com>
Date:   Thu, 24 Feb 2022 11:29:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v13 for-next 5/6] RDMA/rxe: For mcast copy qp list to temp
 array
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220223230706.50332-1-rpearsonhpe@gmail.com>
 <20220223230706.50332-6-rpearsonhpe@gmail.com>
 <20220224002606.GB409228@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220224002606.GB409228@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/23/22 18:26, Jason Gunthorpe wrote:
> On Wed, Feb 23, 2022 at 05:07:07PM -0600, Bob Pearson wrote:
> 
>> +	/* this is the current number of qp's attached to mcg plus a
>> +	 * little room in case new qp's are attached between here
>> +	 * and when we finish walking the qp list. If someone can
>> +	 * attach more than 4 new qp's we will miss forwarding
>> +	 * packets to those qp's. This is actually OK since UD is
>> +	 * a unreliable service.
>> +	 */
>> +	nmax = atomic_read(&mcg->qp_num) + 4;
>> +	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);
> 
> Check for allocation failure?
> 
>> +	n = 0;
>>  	spin_lock_bh(&rxe->mcg_lock);
>> -
>> -	/* this is unreliable datagram service so we let
>> -	 * failures to deliver a multicast packet to a
>> -	 * single QP happen and just move on and try
>> -	 * the rest of them on the list
>> -	 */
>>  	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
>> -		qp = mca->qp;
>> +		/* protect the qp pointers in the list */
>> +		rxe_add_ref(mca->qp);
>> +		qp_array[n++] = mca->qp;
>> +		if (n == nmax)
>> +			break;
>> +	}
>> +	spin_unlock_bh(&rxe->mcg_lock);
> 
> So the issue here is this needs to iterate over the list, but doesn't
> want to hold a spinlock while it does the actions?
It's not walking the linked list I am worried about but the call to rxe_rcv_pkt()
which can last a long time as it has to copy the payload to user space and then
generate a work completion and possibly a completion event.
> 
> Perhaps the better pattern is switch the qp list to an xarray (and
> delete the mca entirely), then you can use xa_for_each here and avoid
> the allocation. The advantage of xarray is that iteration is
> safely restartable, so the locks can be dropped.
> 
> xa_lock()
> xa_for_each(...) {
>    qp = mca->qp;
>    rxe_add_ref(qp);
>    xa_unlock();
> 
>    [.. stuff without lock ..]
> 
>    rxe_put_ref(qp)
>    xa_lock();
> }
> 
> This would eliminate the rxe_mca entirely as the qp can be stored
> directly in the xarray.
> 
> In most cases I suppose a mcg will have a small number of QP so this
> should be much faster than the linked list, and especially than the
> allocation.
The way the spec is written seems to anticipate that there is a fixed
sized table of qp's for each mcast address. The way this is now written
is sort of a compromise where I am guessing that the table kmalloc is
smaller than the skb clones so just left the linked list around to
make deltas to the list easier and keep separate from the linear list.

An alternative would be to include the array in the mcg struct and
scan the array to attach/detach qp's while holding a lock. The scan
here in rxe_rcv_mcast_pkt doesn't need to be locked as long as the qp's
are stored and cleared atomically. Just check to see if they are
non-zero at the moment the packet arrives. 
> 
> And when I write it like the above you can see the RCU failure you
> mentioned before is just symptom of a larger bug, ie if RXE is doing
> the above and replicating packets at the same instant that close
> happens it will hit that WARN_ON as well since the qp ref is
> temporarily elevated.
> 
> The only way to fully fix that bug is to properly wait for all
> transient users of the QP to be finished before allowing the QP to be
> destroyed.
> 
> But at least this version would make it not happen so reliably and
> things can move on.
> 
> Jason

