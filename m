Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332E028F5EE
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 17:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389731AbgJOPf5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbgJOPf5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 11:35:57 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C0BC061755
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 08:35:57 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e20so3248666otj.11
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fNYfWGLUuPV+Kb6UwvOD1/FjqWpxI+3aCb35zPNV+ys=;
        b=i94nJejxtXbuyieKHQC7tC17YkcQZRgIPauYb0ZEfqzYFOUApwJSH8u6HhGP4PVWVY
         UfIBlkA/vPmNtEYTLDo+aoCyuAKlWhPNH0bDxf3F8L4FMj/zVo93qpCxiw0F8ZtvKPbH
         cw5V4ztIUoNbzXruCGR5p0VguyL6jjAEjjb3XxiM7GYT/t5De776K2P/y5RTLcYMDsuS
         yMz+qWXlGRfvaOcyJ/6rx6M4/T0PtU0nxeqtMlpitj8S+QwTpJ0JnZBPiFrXjvTUrtgG
         BGw5LzYDWq+6bdN3DJ4GutzSiqWGwZhZKM3hYg6tybxCr64qDnYUgUX3ors/pIT+PHvd
         224w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fNYfWGLUuPV+Kb6UwvOD1/FjqWpxI+3aCb35zPNV+ys=;
        b=cngU3h13+CaH9ahLe0h03blheglwUQ+L4UvzezMqc06JUTvqbrFWloaYYom203x1AR
         Q6FUi8NoC5poLgK0Wipxs7ApsI8BKdQfPkPl5s0owZOAiLY1rP3FUCpDvAqFcYkvVRzc
         JOhLpG16bTZC9GOi7gyU+/qGMk4W2EJ0HDmpxSmFIt6V6wI45i02Tk2ks0wd7LBmQpC/
         MrOWAyn7zCVRV2aW2h8OnZSQG4EbxAordVmhUPtfayViLymj2or7+tTvMOQVp/yRZ5Nu
         NIoymPg4JVNtHkk9zm1ERxFH3bMnx7f/JEqYG+FqIBgMesn6F+SmrP/EPmsJsWNngz8U
         4XCQ==
X-Gm-Message-State: AOAM5334dQ/gbyonADRUMDuEeLnW/UaemJaKP2hQGDbr4ME0M3l2diNN
        tB2/KckyWAPzo9xa3YtS454iDjyl9jA=
X-Google-Smtp-Source: ABdhPJxJU9QDt+f73J84UTo21kWIg+HBusCj1FnyCWhGU9XYUQ0W88X10Grg18UqsNXhAs+Z7GeATQ==
X-Received: by 2002:a05:6830:19fd:: with SMTP id t29mr3029030ott.307.1602776156838;
        Thu, 15 Oct 2020 08:35:56 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:7547:59bc:fd97:5e88? (2603-8081-140c-1a00-7547-59bc-fd97-5e88.res6.spectrum.com. [2603:8081:140c:1a00:7547:59bc:fd97:5e88])
        by smtp.gmail.com with ESMTPSA id n128sm1434536oif.14.2020.10.15.08.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 08:35:56 -0700 (PDT)
Subject: Re: dynamic-sg patch has broken rdma_rxe
To:     Maor Gottlieb <maorg@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
 <20201014225125.GC5316@nvidia.com>
 <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <566a08ac-d4fc-baf0-eecc-4fb15a03c38a@gmail.com>
Date:   Thu, 15 Oct 2020 10:35:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/15/20 2:44 AM, Maor Gottlieb wrote:
> 
> On 10/15/2020 1:51 AM, Jason Gunthorpe wrote:
>> On Tue, Oct 13, 2020 at 09:33:14AM -0500, Bob Pearson wrote:
>>> Jason,
>>>
>>> Just pulled for-next and now hit the following warning.
>>> Register user space memory is not longer working.
>>> I am trying to debug this but if you have any idea where to look let me know.
>> The offset_in_page is wrong, but it is protecting some other logic..
>>
>> Maor? Leon? Can you sort it out tomorrow?
> 
> Leon and I investigated it. This check existed before my series to protect the alloc_table_from_pages logic. It's still relevant.
> This patch that broke it:  54816d3e69d1 ("RDMA: Explicitly pass in the dma_device to ib_register_device"), and according to below link it was expected.  The safest approach is to set the max_segment_size back the 2GB in all drivers. What do you think?
> 
> https://lore.kernel.org/linux-rdma/20200923072111.GA31828@infradead.org/
> 
>>
>> Jason
That's what I did to fix it.
