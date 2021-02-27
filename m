Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D625326A99
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Feb 2021 01:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhB0ADX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Feb 2021 19:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhB0ADW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Feb 2021 19:03:22 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA45C061574
        for <linux-rdma@vger.kernel.org>; Fri, 26 Feb 2021 16:02:42 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id j1so11577344oiw.3
        for <linux-rdma@vger.kernel.org>; Fri, 26 Feb 2021 16:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m0LYX4hhWQH2RlJZmky9pFyWPVEXlvZXcxftwF/mAFA=;
        b=QTxg7PPqkvdSugFhfEF0i4zr5GWoj3v3XkhBSvvYXgTwAN4F/5KhHYgVXmVAZlYHgB
         AwDSL+y2YKnSly18YykH6VR4wBbuJ5B1W2B0aIo7CL/XwMyy43KVefu/d90wB48iC4+/
         9ldRTFVv58EqyDHjHhS6dxtFso0CHG7zkThWaLRb+G5xRdSGBoqYFsaLtHImtPjXBrtR
         Zc4lNXjTGX1/qFRHIl0rvJ8K2xBs41PjKxgkaRpV3/DA5D3IPvKSPpByneAPiG2SwoQF
         om47wMnzxPgRdrUw/N29pmWSLkD/r0RE4gWTSywlnaL1YZ/09yN+zp/KEsAKQvlE2S40
         CazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m0LYX4hhWQH2RlJZmky9pFyWPVEXlvZXcxftwF/mAFA=;
        b=cK85VJxtq4VP5QxbxRjKa7ZBJLVKNDkJXt8r17OAI5DHJCxkQIE2hvuIROwUD1i+J6
         H6WvtnwruCbuk9j51YFSDn1h5olKZXIV36ovPrpphw8WtK49nK3ftIt6Qn/YXcffIS9U
         IEalxdyCwAi3qfYAvrWmQ9pqrnYYWzohE4XIU+QKpRRzExQ85+eBraLm6hxmUZxyIOOV
         fLi7oorJm1KwFNgXHjr6ntCA/YYcxoJEoJZ7vrVY8Twc9KbvqgqrAviEW8TAixURZqNF
         /unsQ7SJczvrX5AbbGhdWQXYRC/5NQMycIki0tU/k5iAwLi/icHJBp6AgMDcxjLULLU0
         CmDg==
X-Gm-Message-State: AOAM532oJE2rmQjFaezvdhBT8ums07YUnXxYXci9+s59hhTTn911VDJy
        Pv/IRvfOlx/DiAIOKFP42O82W4DCe/v19Q==
X-Google-Smtp-Source: ABdhPJy3KPUW+LbuSwr/FCDv1xm6aRB/m21lIH0QdbwP//rNqYrigD9SCmZGZbW2ET5LmUg+3UnarA==
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr3938913oij.130.1614384161429;
        Fri, 26 Feb 2021 16:02:41 -0800 (PST)
Received: from [192.168.0.21] ([97.99.248.255])
        by smtp.gmail.com with ESMTPSA id n17sm95038oos.20.2021.02.26.16.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 16:02:40 -0800 (PST)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210214222630.3901-1-rpearson@hpe.com>
 <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
 <20210226233301.GA4247@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <3165add7-518d-9485-fa12-6d7822ed9165@gmail.com>
Date:   Fri, 26 Feb 2021 18:02:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226233301.GA4247@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/26/21 5:33 PM, Jason Gunthorpe wrote:
> On Fri, Feb 26, 2021 at 05:28:41PM -0600, Bob Pearson wrote:
>> Just a reminder. rxe in for-next is broken until this gets done.
>> thanks
> 
> I was expecting you to resend it? There seemed to be some changes
> needed
> 
> https://patchwork.kernel.org/project/linux-rdma/patch/20210214222630.3901-1-rpearson@hpe.com/
> 
> Jason
> 
OK. I see. I agreed to that complaint when the kfree was the only thing in the if {} but now I have to call ib_device_put() *only* in the error case not if there wasn't an error. So no reason to not put the kfree_skb() in there too and avoid passing a NULL pointer. It should stay the way it is.

bob
