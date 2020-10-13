Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97CE28D250
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgJMQeb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJMQeb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 12:34:31 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F89DC0613D0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 09:34:31 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id m22so608642ots.4
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fYXc1GYzkLYpOsWrmudmLUIH+WssinhSShDKjcB0jw0=;
        b=iFUdESmhXGng9QZdt1TdB4rh+EoskljdnXxVO/vQwnBs4CFkMiPOPQVajDZ9LTySBB
         leD9zo4lc+8fZUzzEzdGfz7d6CmEKikigO7vAr2IvEGa1W82YMkiAdRw/T0kVb59c0/Y
         TBxsc2LOaSqROQs0yMMKsLalzYKiN46/uGKpkqUOWsXPgKfxgJRIzolf4hkwy160BU7u
         QBhhKDJ59G4cfK+i6q6CAusSuaw6dJGGs5vNxG0LZtlw9bzT7TxHy5s3MxP4z45c5fde
         irtAkd3m+BUA6Az+FvMwflX9C2yYjgcvdhidiTonyY+uniwiwh1cifjogkB6j1LCF6iN
         S9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYXc1GYzkLYpOsWrmudmLUIH+WssinhSShDKjcB0jw0=;
        b=XnZw0PxazRvA0B4q3U3AICn2vvaBUjqlkWZhA0+LCVZkxfifxWTi8DKdNLxnx5IyTY
         nYA6Chou/ia3hHYPKUw9h6vuXSWiVOY0nZg31uxhEZwE7qGg8fvX4H0yrS9nfL39LO2q
         INBdtuUhBgqNeY/712hU7SK2FX1uObm7TaUEUYciuk4XNz5B+AtBTm53kf47D1JlE5st
         K3nc5QrbwMQRmJHbbj9w9fgFBxNwuBJevizvLoB8j14skNjjIXtqVYgCKrxd0J9sBvEJ
         swC7SgrYvOHfrFNDHSvv0QnVIniRNFeaGT9ViPy4MZH9AdtD6QAz9cbnvYHmdA9MXR1g
         3d8w==
X-Gm-Message-State: AOAM533Qk1ZElPK5AAcwlj9l/G1jr7kuAVskqPSx5RVN2co5RwejtjCH
        UWpHw+aia8ZXGafF2cv/St5xMKbiPO8=
X-Google-Smtp-Source: ABdhPJxiz75v8BScCptJlGnzRxLXW5BImj7gmT9dMrcijMdDJQ8g61/yMoim0ngTw1kv7ZBHPdjx2g==
X-Received: by 2002:a9d:1ec2:: with SMTP id n60mr356704otn.63.1602606870356;
        Tue, 13 Oct 2020 09:34:30 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:f92c:93be:3e9d:c2cd? (2603-8081-140c-1a00-f92c-93be-3e9d-c2cd.res6.spectrum.com. [2603:8081:140c:1a00:f92c:93be:3e9d:c2cd])
        by smtp.gmail.com with ESMTPSA id q64sm100747oib.2.2020.10.13.09.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 09:34:29 -0700 (PDT)
Subject: Re: dynamic-sg patch has broken rdma_rxe
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
Message-ID: <06d6710b-f05e-e370-2acb-68f88040948e@gmail.com>
Date:   Tue, 13 Oct 2020 11:34:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/13/20 9:33 AM, Bob Pearson wrote:
> Jason,
> 
> Just pulled for-next and now hit the following warning.
> Register user space memory is not longer working.
> I am trying to debug this but if you have any idea where to look let me know.
> 
> Bob
> 
> [  209.562096] WARNING: CPU: 12 PID: 5343 at lib/scatterlist.c:438 __sg_alloc_table_from_pages+0x21/0x440
SNIP
> 

I found it. The rxe driver had set the max_segment_size to UINT_MAX (0xffffffff) which triggered the warning since it has an 'offset into page' in __sg_alloc_table_from_pages. Can you tell me what this parameter is supposed to do and what is a reasonable value. What scares me is that the default used in ib_umem_get is 64K. Does this have anything to do with the largest SGL size or is it something else.

Bob
