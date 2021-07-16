Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8063C3CBA57
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 18:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhGPQLk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGPQLk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jul 2021 12:11:40 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76292C06175F
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jul 2021 09:08:45 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w188so11401968oif.10
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jul 2021 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GOYuV4pKe/sE/aez2ubgXEmsVeFqPyk9H+nzGEcTV3Y=;
        b=JQjyukqZosfcp8lwyN8bhi1nE2yHnuDaSLRKdHaYFWtO2yaE1dlOUjDJ9Eh9VGzpcW
         /lgYjhN0TwGc8O5hMD18qif+ehOHwA1yHiQt1YBI+sjCeqF3W9ngyqDU/cFDoRaFeWGI
         zu8Q4CjVaHd6vRCBLwicgbg4ZZVpFfuF4YVrI6IpEv/XeYpYf/sjSXbdkDR7CrNIlFBb
         i1N3mh08uIKgrYbNbA7rf5wVdC5DEay7Q6I9cN34bE0VtgoS8e+5+i1ecCOJB5E3n4pe
         8cJ7/AvPamjGXufhQWSVWhqUbWMjvNEHHcveN6ZLSh+3Y15R7MM7NBgaIWavO2Jkr080
         BhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GOYuV4pKe/sE/aez2ubgXEmsVeFqPyk9H+nzGEcTV3Y=;
        b=gGo15iD6PI5dgf57G+zghe/HcXS/yHWqBhCwoDP8ZRDUr8zACtq79It3wJWCket9Px
         AszGmoKCqCzsOaKH+3jxpb49EcG46Nb66S0qZGaD/lzw1RrHyZE8YejqGzvZYiXR+V2b
         UxYEPbmFnPtlIigDS4KywpSRD+LktRizPWrKsvN917uYaEjhnY9aa3FmMZ7LcnWOlMeb
         21kB7AlGBcLoLV8PcttPmvwUKpO02lRIW2ObjQJsZIGmcoDXcYoS9UyxKmwSM1QxmxCk
         OdKICH2zQI8r6ngX8sKPUdyvEsPw89EmvpIG/nCuDic9wrmnjfYV5bQJKCK4+YMxIWgR
         5WNA==
X-Gm-Message-State: AOAM533yXhQaKa1gI7dx23Pcu8E7FKD/riWz7y79Ac9A7xO8YvyOlXMX
        w5Vj+Odd27dyqC90BsNmV5DRFtrhJQc=
X-Google-Smtp-Source: ABdhPJz7SsbsmApjHJhUAzqqFdqW3FEuDcLdt75STpO0Qms7WCMZY30/rAt9JiDIaAlWRfXZmc568A==
X-Received: by 2002:a05:6808:1286:: with SMTP id a6mr8498848oiw.121.1626451724756;
        Fri, 16 Jul 2021 09:08:44 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3254:da98:32e5:5358? (2603-8081-140c-1a00-3254-da98-32e5-5358.res6.spectrum.com. [2603:8081:140c:1a00:3254:da98:32e5:5358])
        by smtp.gmail.com with ESMTPSA id f26sm177596oto.65.2021.07.16.09.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 09:08:44 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] RDMA/rxe: Move ICRC generation to a subroutine
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
 <20210707040040.15434-5-rpearsonhpe@gmail.com>
 <20210716155759.GB759856@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <6a07ad6e-5167-9d71-e22b-94efb9b64401@gmail.com>
Date:   Fri, 16 Jul 2021 11:08:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716155759.GB759856@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/16/21 10:57 AM, Jason Gunthorpe wrote:
> On Tue, Jul 06, 2021 at 11:00:36PM -0500, Bob Pearson wrote:
> 
>> +/* rxe_icrc_generate- compute ICRC for a packet. */
>> +void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>> +{
>> +	__be32 *icrcp;
>> +	u32 icrc;
>> +
>> +	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
>> +	icrc = rxe_icrc_hdr(pkt, skb);
>> +	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
>> +				payload_size(pkt) + bth_pad(pkt));
>> +	*icrcp = (__force __be32)~icrc;
>> +}
> 
> Same comment here, the u32 icrc should be a  __be32 because that is
> what rxe_crc32 returns, no force
> 
> Jason
> 

I agree. The last patch in the series tries to make sense of the byte order.
Here I was trying to take baby steps and just move the code without changing anything.
It makes the thing easier for Zhu to review because no logic changed just where the code is.
However as you point out it doesn't really make sense on the face of it. There isn't any
really good resolution because both the hardware and software versions of the crc32 calculation
are clearly labeled __le but they are stuffed into the ICRC which is clearly identified as __be.
The problem is that it works i.e. interoperates with ConnectX. I would love a conversation with one
of the IBA architects to resolve this.

Bob

