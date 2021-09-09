Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29660405E3F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 22:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhIIU7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhIIU7x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 16:59:53 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C1C061574
        for <linux-rdma@vger.kernel.org>; Thu,  9 Sep 2021 13:58:43 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso4315035otu.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Sep 2021 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ls9Mi1s9abK5D2OhiJT8bub+9zcZXx/7nvgAl3/QSEo=;
        b=dgvPZDb1keoHHCj5VocD2aNQEYUcmfO07/BETVm/cxCpx2lKj6SCD/F6Qj+5BmCuQv
         nneuFfMY3sCv6ebZvtqBqJ+bK31qoP1lXwM/h+RXODEn53bLp7Tr7JZjoxCj7PzbEdB5
         +X8pFH/7zLBVJftPx9ORyDOJEkZZ0Id5jq82CPrZpk9kIAP7seVQIu8cAM32/7naM+1D
         rtLXCou13CXuVtkkAe5GFtjVnV7u4My+r7WlFFPP/YofSGRb88XRVjIIy/iBm3+gUgfp
         gTRRG7+yyI15tjyLHYIJylEZUQu9Lm+KqaXGCX+hUozdAcFCg7Xp6RDimtVxObVGixbw
         ++NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ls9Mi1s9abK5D2OhiJT8bub+9zcZXx/7nvgAl3/QSEo=;
        b=VDlH1gPSnlFqUnVnoWEGw/kUtnvK3kM36aOFgS8L5INHqznu5OTkkZj/jZ8v8g1IzP
         pLHcHQDA8fUH+UT2Lzcu/csGGyulDOXXo9afg2ZV68mVP3mFXUBxBoNQLBoGkzj2GtKW
         SPKLKjKDGT3TA1FaPfnjvORypBwOL1KU0vGxq/pO68dSymkDIkyMTjjrgB9CRW+WNeAO
         RGQqza50dppwPT5MxwE0AzCOOscohuxIrvJVqCgGoDjNPYoaTMPN03PU32gcrvOI8rvt
         LvY7LOlilke/RLytnwJMt1S5e3LydT869E0288OTVKrKfXG8hSKO2H/ymjioRQgvFhnH
         RSjw==
X-Gm-Message-State: AOAM531ClFWVmJTSso7/P61/KxpsVfBKwU9RF51OdCXEAKuWqDXTpJYW
        QqkCqWZPqfls8exA//ntVyKFxxSNaukgRA==
X-Google-Smtp-Source: ABdhPJz9WUfZ/M3iUkX2wZzltquUQC4JUOU1ZvaFBJOox5+56uQmeGBlthVghGSq9dmjftw+VYBbNA==
X-Received: by 2002:a05:6830:1105:: with SMTP id w5mr1599262otq.85.1631221122698;
        Thu, 09 Sep 2021 13:58:42 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:5ca5:4fba:424d:ae92? (2603-8081-140c-1a00-5ca5-4fba-424d-ae92.res6.spectrum.com. [2603:8081:140c:1a00:5ca5:4fba:424d:ae92])
        by smtp.gmail.com with ESMTPSA id c75sm654812oob.47.2021.09.09.13.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 13:58:42 -0700 (PDT)
Subject: Re: [PATCH for-next 0/5] RDMA/rxe: Various bug fixes.
To:     Bart Van Assche <bvanassche@acm.org>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210908052928.17375-1-rpearsonhpe@gmail.com>
 <c6e80fc3-6417-a770-d90a-46eb9955f82f@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <08eb3b4a-5302-2765-ae6c-979c22fcb0e4@gmail.com>
Date:   Thu, 9 Sep 2021 15:58:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c6e80fc3-6417-a770-d90a-46eb9955f82f@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/8/21 10:52 PM, Bart Van Assche wrote:
> On 9/7/21 22:29, Bob Pearson wrote:
>> The first patch is a repeat of an earlier patch after rebasing to
>> for-next version 5.14.0-rc6+.
> 
> Hi Bob,
> 
> What is for-next version 5.14.0-rc6+? I tried to apply this series on v5.14, v5.14-rc6 and Jason's for-rc branch but 'git am' refused to apply this series on all these kernel versions ...
> 
> Thanks,
> 
> Bart.

Bart,

I think I fixed the git am issue and resubmitted to the correct queue. You were on copy. Please
try to see if this gets you to joy for blktest. The one case you mentioned srp/002 is working
OK for me now.

Bob
