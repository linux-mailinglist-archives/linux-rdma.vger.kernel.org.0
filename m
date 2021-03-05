Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C21F32F213
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Mar 2021 19:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhCESCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Mar 2021 13:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCESCD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Mar 2021 13:02:03 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A477CC061574
        for <linux-rdma@vger.kernel.org>; Fri,  5 Mar 2021 10:02:03 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id i21so3454705oii.2
        for <linux-rdma@vger.kernel.org>; Fri, 05 Mar 2021 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ReXcmjoLQlUHRgT7PgUc/pdL9d2s9cj1lM2/RVA/qcc=;
        b=O772nluWYhyQSSnXGzem5lGMqDhXK+8VAhsavmkkWkZdgvCVp5X5dTO8xgMm334U7w
         /W4vJcWthesq6FbLy0oMBrbtHD+aEZH3hV/ElNRd3njNmkSKD6m0fG2ZdTLT84Not3qo
         yvKNtU8Ki3Ctz5F7Gjd9C6QQstrMFz17T/XaTA4laOXc75Y+kZxhaZ3p9HvMVVxSOqBX
         GifVq2eVS3kmVGyUbvIVE2cW/jRnseYA5rgajVqoMn+2Zgev83ASetAJNwIk4n7BZrGH
         wO/wLcZrk+Lm1acTGwVQX339YR1K+aUf1lDn3AzEtaIssRv+LzLKKBnvIoDURBoNciaQ
         f0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ReXcmjoLQlUHRgT7PgUc/pdL9d2s9cj1lM2/RVA/qcc=;
        b=GQm+tWA3M4CKKfeF4cMXpOMKn9lA8WHuSLH+sOMDvJ9zz76+D6XMSbRU5OeoK1q/Lr
         Z3vPtah30BIJd1r7l4Osze5pgX54JP31fUn9x2ToyMSOo1V80EAcH3bn9bhHMne4rm9/
         rJYUIuROzr7gZ05OyF6GycYahqDCVmct8yoXTi6chc0Kr+zW2uZCi6Ij2he62MMBtPzL
         9zqcgRgNM1/YJVj0s9IKEu2eW5uzLXiprxkjnQH7HvS7RkJmXSF63xvpSvGlEJ05L8nM
         axbrsgqloDudijxJPdh8lURqRPaU+yTD+cnJ96wWh9CUfRM9XOLxJqBJIF3deXUDlZ0/
         D6Bw==
X-Gm-Message-State: AOAM533CAhqrccyNdp2BROog3smlu3HX6Eaced0Ff/HVe0xfOGOW0UPa
        qzz/MwUb+uCueWw2yWsI/CI=
X-Google-Smtp-Source: ABdhPJxAhABTmBJOafc8u3hAMiuMkRAkwplEDNvNHzy21z5ozrMpWO2k4XffWft9BgHyJoMP3eHyVQ==
X-Received: by 2002:aca:3383:: with SMTP id z125mr7918855oiz.48.1614967323145;
        Fri, 05 Mar 2021 10:02:03 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:4367:b935:ca34:b256? (2603-8081-140c-1a00-4367-b935-ca34-b256.res6.spectrum.com. [2603:8081:140c:1a00:4367:b935:ca34:b256])
        by smtp.gmail.com with ESMTPSA id m8sm354498oib.4.2021.03.05.10.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 10:02:02 -0800 (PST)
Subject: Re: [PATCH for-next v3] RDMA/rxe: Fix ib_device reference counting
 (again)
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <20210304192048.2958-1-rpearson@hpe.com>
 <CAD=hENfsiX23GSLGJ6xhfE19BTaeYfpfgH2O7Qg0Q24kztyUjg@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>
Message-ID: <119d85b9-4ab2-e69e-9a39-e60bcac37de6@gmail.com>
Date:   Fri, 5 Mar 2021 12:02:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAD=hENfsiX23GSLGJ6xhfE19BTaeYfpfgH2O7Qg0Q24kztyUjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> 
> Where do these not-freed skb come from? Except these skb, are other
> resources freed correctly?
> 
> IMHO, the root cause should be found and other resources should be also handled.
> WARN_ON_ONCE() should be kept on exit and done.
> 
> So if some skb are not freed incorrectly, we can find these skb in the loop end.
> 
> Zhu Yanjun
> 

In the original code (before the patch that this patch is trying to fix) there was one path
through rxe_completer() that *could* have leaked an skb. We haven't been seeing that one though.
Every other path through the state machine exited after calling kfree_skb(skb). You can check
but you have to look at an older kernel.

The earlier "Fix FIXME" patch, which is upstream, collected the code related to freeing the skbs
into a subroutine called free_pkt(). This was an improvement but even though it calls
kfree_skb(skb) it didn't set the local variable skb to NULL. This allowed some bogus warnings
to show up as you have been demonstrating.

This patch "fix reference counting (again)" fixes both of these issues by getting rid of the
warning and moving the free_pkt() to the end of rxe_completer(). Now, after applying the
patch, the end of the subroutine reads

...
done:
	if (pkt)
		free_pkt(pkt);
	rxe_drop_ref(qp);

	return ret;
}

If you check, you can see there are no other return statements in the routine. (skb and pkt are
pointers to the same packet. the macro SKB_TO_PKT sets pkt = &skb->cb and PKT_TO_SKB sets
skb = container_of(...) so passing pkt is equivalent to passing skb.)

The only way out, therefore, frees a packet if there is one and we cannot be leaking skbs. The
free_pkt() routine handles all the other stuff that needs to be done when the skb is freed.
(The rxe_drop_ref(qp) drops the reference to QP taken at the top of the rxe_completer() routine.)

The default behavior when receiving an ack packet that isn't expected or perfectly correct is to
drop it. This includes ack packets received when the sender is retrying a request. The comment
after case COMPST_ERROR_RETRY: is misleading because you do have an ack packet when you get there
but it could be unexpected if no wqe is waiting for it. This was the path that before could have
lead to leaking an skb but that is now fixed.

As of now there are no remaining paths that can leak a packet and no reason to check that
skb == NULL. If it makes you happy you can clear it like this

	if (pkt)
		free_pkt(pkt);
	skb = NULL;
	WARN_ON_ONCE(skb);

but that would be a pointless waste of time.

Bob
