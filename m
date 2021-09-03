Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11754007D8
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Sep 2021 00:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349960AbhICWTF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Sep 2021 18:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhICWTF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Sep 2021 18:19:05 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2975C061575
        for <linux-rdma@vger.kernel.org>; Fri,  3 Sep 2021 15:18:04 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u25so942370oiv.5
        for <linux-rdma@vger.kernel.org>; Fri, 03 Sep 2021 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qag07c8DOGOAqe7+/qKyOH0m5gifXrVu+g70FwU6E74=;
        b=dAKbSG7Jx+9a9kbfAsigMIu8ZC8eqazCMDeBKHEfbZRMFAh850hEBE8Bd9tA9ovmEo
         5DLMr8j5FTMO/TQsHeaHn4TM0vjB39+dgI4GIVpgwPPImPDOe9ByHVOLs5isV5ULdPGl
         tOmYUsXW1SThnsKbhSApCWMtSu/+LbPaySvNDOE06DddbslFoycp205pvE/TKUqoqaeO
         WcDV02+3lIkATHD1O0nLsXg5KrihVCiN/ssqcosgnU9UHOqfrzwfvMx5QQfaTp89Kn2P
         TDIYMvLfa7mRY8mw8wnWchRfbXJrIjh7oBCL/8WXO6Ve4vdeZ0Gv5Nq/R8uphXcrGQgr
         HCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qag07c8DOGOAqe7+/qKyOH0m5gifXrVu+g70FwU6E74=;
        b=PFpiNyIvBpLr12+d8BBhVu20E0+XsQQO/mdshfi6ei+ivtJ8a48ebpnFV8eBhTSYVE
         FTI+9jw+ruCgLA9UejXaYy6nRf//m2QZGIfIr7xQ/+rXmIyskNV/LsDaSRnC3KHZAhpy
         XBocxCiABpVCl7jfTSCgDo7KrE91o8kz7H3FvVRyeKidsD6XDiY5pEk+lBXPMvg3f1U/
         Lw6PKxD+Tf/QjcNtlFZHp/o1DLOjS5Ygbdpbd/hgxjU7A6RGpVWYYCIzT/3nGLmNJblx
         W/AHNjjBWQ/jUPgFD+EQeHPMMtxNaVfP7P+ZNVSYi1svv2QVqNlgYUDGSXng98qRZOAO
         r2Pg==
X-Gm-Message-State: AOAM530U5HY7hHL5btDNVJ6LWl/TAsf9XFPSRhTqyRGzCvF3plNz/cnF
        3NuodjbbuN3xy/QOZN1iW4fEb/BvIVY=
X-Google-Smtp-Source: ABdhPJwnofa1F5FkMh+Ql3GLa2pcxhN0KA+K6AIt8vSFGzl6i0nrxGTbXqVN1uz+k4HaFytRkYUV/Q==
X-Received: by 2002:a54:4402:: with SMTP id k2mr728164oiw.166.1630707483915;
        Fri, 03 Sep 2021 15:18:03 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3791:ec59:7791:159? (2603-8081-140c-1a00-3791-ec59-7791-0159.res6.spectrum.com. [2603:8081:140c:1a00:3791:ec59:7791:159])
        by smtp.gmail.com with ESMTPSA id l16sm138823ota.55.2021.09.03.15.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 15:18:03 -0700 (PDT)
Subject: Re: blktest/rxe almost working
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
 <20210902233853.GB2505917@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <1610313b-e5d0-a687-a409-d1275baf7f95@gmail.com>
Date:   Fri, 3 Sep 2021 17:18:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902233853.GB2505917@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/2/21 6:38 PM, Jason Gunthorpe wrote:
> On Thu, Sep 02, 2021 at 04:41:15PM -0500, Bob Pearson wrote:
>> Now that for-next is on 5.14.0-rc6+ blktest srp/002 is very close to
>> working for rxe but there is still one error. After adding MW
>> support I added a test to local invalidate to check and see if the
>> l/rkey matched the key actually contained in the MR/MW when local
>> invalidate is called. This is failing for srp/002 with the key
>> portion of the rkey off by one. Looking at ib_srp.c I see code that
>> does in fact increment the rkey by one and also has code that posts
>> a local invalidate. This was never checked before and is now failing
>> to match. If I mask off the key portion in the test the whole test
>> case passes so the other problems appear to have been fixed. If the
>> increment and invalidate are out of sync this could result in the
>> error. I suspect this may be a bug in srp. Worst case I can remove
>> this test but I would rather not.
> 
> I didn't check the spec, but since SRP works with HW devices I wonder
> if invalidation is supposed to ignore the variant bits in the mkey?
> 
> Jason
> 

I am a little worried. srp is pretty complex but roughly it looks like it maintains a pool of
MRs which it recycles. Each time it reuses the MR it increments the key portion of the rkey. Before
that it uses local invalidate WRs to invalidate the MRs presumably to prevent stray accesses
to the old version of the MR from e.g. replicated packets. It posts these WRs to a send queue but I
don't see where it closes the loop by waiting for a WC so there may be a race between the invalidate
and the subsequent map_sg call. The invalidate marks the MR as not usable so this must all happen
before the MR is turned on again.

Bob
