Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567C0425F9D
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Oct 2021 00:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbhJGWC1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 18:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhJGWC0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 18:02:26 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150FC061570
        for <linux-rdma@vger.kernel.org>; Thu,  7 Oct 2021 15:00:32 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id y16-20020a4ade10000000b002b5dd6f4c8dso2325698oot.12
        for <linux-rdma@vger.kernel.org>; Thu, 07 Oct 2021 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c6kbzffz2CNJ7Tja7Fq5mhESUt3Qgyr0RyzRm182XcU=;
        b=Yqyg2BklqkHr3KTVREuaRhQWsz9AM8WmiTVS8cirzAaazKE+XNv/QJX6Gfo7GITtZz
         m3A75lxBWYEqe3nGW2gX/GErxSmzuF8h1D5Ivwcr18aicpsGn3VFnLmiTH6niGZn6jWN
         rHPQlHoJzPBb3Rope4UTNVhdH0hNSa2l7c9K1qemeJkfSobDt8Oo1dKC6CpWZGbpuS9b
         kIDeKpSQX1SENjR3IV2cVkAZ4Bn8xIRtlMNUKKGtqzuAhZj9DhVvPgIn3BUtDBm+OVlu
         OgR//B/m0YWSmElWeDYDnR6v8sdhAk6phjxzQ3XHqgUoyKYrKOFf9WAs8Q2JMH0CGxFB
         1ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c6kbzffz2CNJ7Tja7Fq5mhESUt3Qgyr0RyzRm182XcU=;
        b=O8WveUjFLeFRovyxgn2SYXCqUvYZSv4cOmdIUzIaHfdCrHmN4O1Yr5FZWiOUrdU7mO
         x0mX3a/z8X24JraZOFGHC5XuAPpncDMpzLA83mkGRrm73bpmT6fBhd30zpKUi9kiByOo
         r2eGmjYCPrS2k8lraJiQYnAkGofZIoUDZbN3uK/A8wwxVGLtzjivpH1/FpxxAa0WF8Wy
         B8BbpO5m7sks3oMaIXNvjm0RJGRmJP/zj98U3SDLHLzkJLcrSDZVc5ECoAuaDofDBhZA
         44JNiK1OdM3Tcz//su/s3HviUHsjauWLeFVvEjdxUTie1L3NcHnofEWy/EUZN5qLIwbZ
         m2Qw==
X-Gm-Message-State: AOAM533nd5SvYQw0LxqzJIXE9wRfv6YLdondDbEiBwt1ZaGQ92hU3C1b
        RVb5xTu/KvhZGKegbU2eI6b8fg7Umtg=
X-Google-Smtp-Source: ABdhPJy4MCueOPQo3AfjG/ngxTPEWKg8BuU1MHfjsWLJio+R8/zeWwfIrQQdlhAqP0HtmB+X9vBg0A==
X-Received: by 2002:a4a:892f:: with SMTP id f44mr5326267ooi.95.1633644032026;
        Thu, 07 Oct 2021 15:00:32 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:28eb:c206:8f9f:7a9d? (2603-8081-140c-1a00-28eb-c206-8f9f-7a9d.res6.spectrum.com. [2603:8081:140c:1a00:28eb:c206:8f9f:7a9d])
        by smtp.gmail.com with ESMTPSA id bc19sm138361oob.29.2021.10.07.15.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 15:00:31 -0700 (PDT)
Subject: Re: [PATCH for-next v5 0/6] Replace AV by AH in UD sends
To:     Shoaib Rao <rao.shoaib@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
 <20211006193714.GA2760599@nvidia.com>
 <8fb347bb-81b2-2ba6-a97c-16a5db86541d@gmail.com>
 <20211006224906.GE2744544@nvidia.com>
 <086698cc-9e50-49be-aea8-7a4426f2e502@gmail.com>
 <20211007190543.GM2744544@nvidia.com>
 <5e8ff897-ca98-4dcc-a731-2bf150011fe9@gmail.com>
 <20211007195731.GO2744544@nvidia.com>
 <0d4b7d5f-c9fe-1515-170c-314d49feb974@oracle.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <d5ff112b-9607-fbb3-bc8a-902c89eb3eac@gmail.com>
Date:   Thu, 7 Oct 2021 17:00:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0d4b7d5f-c9fe-1515-170c-314d49feb974@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/7/21 3:40 PM, Shoaib Rao wrote:
> 
> On 10/7/21 12:57 PM, Jason Gunthorpe wrote:
>> On Thu, Oct 07, 2021 at 02:51:11PM -0500, Bob Pearson wrote:
>>> On 10/7/21 2:05 PM, Jason Gunthorpe wrote:
>>>> On Thu, Oct 07, 2021 at 01:53:27PM -0500, Bob Pearson wrote:
>>>>
>>>>> On looking, Rao's patch is not in for-next. Last one was
>>>>> January. Which branch are you looking at?
>>>> Oh, it is still in the wip branch, try now
>>>>
>>>> Jason
>>>>
>>> I see the issue. Rao is asking for 2^20 objects max by default which will
>>> require 128KiB of memory in the index reservation bit mask for each of them.
>>> There are 4 indexed objects QP by qpn, SRQ by srqn, MR by rkey and MW by rkey.
>>> That's 512KiB of memory which seems excessive to me for many use cases where the
>>> number of objects is fairly small.
>>>
>>> The bit mask is used to allocate and free the indices and there is also a red black
>>> tree that is used to look up objects by their index (or key if they use keys instead.)
>>>
>>> If there is a usual way to address these kinds of issues in Linux maybe we should
>>> consider that.
>> Use an allocating xarray
>>
>> But for these AV patches just fix the merge conflict to something sane
>> and go ahead
>>
>> Jason
> 
> I did not want to increase the values too high but we discussed it so I did. Let me know if I need to modify the patch and reduce the values.
> 
> Shoaib
> 

If we convert the rxe_pools to use xarrays as Jason suggests it looks like this issue
goes away. I'm looking at that.

Bob
