Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733F6306472
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhA0TuR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 14:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344516AbhA0Tks (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jan 2021 14:40:48 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D090FC061573
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 11:40:06 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id w8so3457684oie.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 11:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HTnhwAYgkqhwM343pbYPL8v0Rv0DzQewT8wizJtCiKs=;
        b=dsY+YEYU9Zq+cYJI0FdT+xChiqXeSrQwbhk7lq8czN3gKKyHPWNFBP20GYIEf8jFSj
         idS99NsavD3DpoJ+Ghvrt2LNPpBmWuFJNXIP95PTq7LRl667XEZWZX81Jh3M5gOSbeq5
         Yur7DK+VomzVsMoZELrelXLX+QC1LTrQU0q9izFe9btVOTfWWn/8uE4K7zHNvVXx6jX7
         qquM7+JU7/oPH6OHc0yfiGVYnhdEFcI3Nz6wbSDnaVJc35chiSwf4Wv0Gx+vDxgwjUVa
         /v4P0dHC6i6AD46MKfPWwubN+aox6s5WThlzUblVEI/e/UVfqF+uS9w3wdI7k+Uu357/
         Xuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HTnhwAYgkqhwM343pbYPL8v0Rv0DzQewT8wizJtCiKs=;
        b=RJMz0M/eQjfcc1YD6/5Q0yX5JQ2Cutc16Hci82HaCG2oZ3n043nAMbmsnxevN6YX30
         jYrqU/JsNho44bY1b2G8wjW6/wkmMqjPkK7VxeKjdUHLbsrDXFK0+eRwKO0qB37mU/vm
         us3+meWayrqXVrEVy6MisHsF2h2UU8ogtk+IO6+m7jmYhAm2RgJcGd5iVYzbdiMpsz2m
         Q8LywLVTRWImh8+7aZusV2pDmd0sUFbwGvf/qlUzrYMzGscsgDSI9Jo0w4w7aLJvHZEL
         GZUpnJzcFiSNeTEnbsudDTIs2MoeZuhAsCFtrtTuEP3gSQLIBnWnOHQll8pnQg4LZeHU
         rPbQ==
X-Gm-Message-State: AOAM53135WslX3AmruOev4unmhpXQcUgw5DR5wa0dt6nFNX8hweYyq5d
        9vmcR10jfQgwYlVcOqPm0ck=
X-Google-Smtp-Source: ABdhPJz1WYoBS0YUywa8TnOuUEhxuldk4bhsElNS70T2D/xxZb93Ap+IsOGKS2yxDLpmhtqblIkXzQ==
X-Received: by 2002:aca:bd54:: with SMTP id n81mr4226280oif.162.1611776406322;
        Wed, 27 Jan 2021 11:40:06 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:cafb:59e1:a2d3:7bc7? (2603-8081-140c-1a00-cafb-59e1-a2d3-7bc7.res6.spectrum.com. [2603:8081:140c:1a00:cafb:59e1:a2d3:7bc7])
        by smtp.gmail.com with ESMTPSA id l110sm539593otc.25.2021.01.27.11.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 11:40:05 -0800 (PST)
Subject: Re: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
To:     Leon Romanovsky <leon@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com
References: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com>
 <20210127120427.GJ1053290@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <b4f0d73c-9624-b971-e56a-f1db02d683e3@gmail.com>
Date:   Wed, 27 Jan 2021 13:40:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127120427.GJ1053290@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/27/21 6:04 AM, Leon Romanovsky wrote:
> On Wed, Jan 27, 2021 at 04:24:31PM +0800, Xiao Yang wrote:
>> Even if we enable sq_sig_all or IBV_SEND_SIGNALED, current rxe
>> module cannot set imm_data in WC when the related WR with imm_data
>> finished on SQ.
>>
>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> ---
>>
>> Current rxe module and other rdma modules(e.g. mlx5) only set
>> imm_data in WC when the related WR with imm_data finished on RQ.
>> I am not sure if it is a expected behavior.
> 
> This is IBTA behavior.
> 
> 5.2.11 IMMEDIATE DATA EXTENDED TRANSPORT HEADER (ImmDt) - 4 BYTES
> "Immediate Data (ImmDt) contains data that is placed in the receive
>  Completion Queue Element (CQE). The ImmDt is only allowed in SEND or
>  RDMA WRITE packets with Immediate Data."
> 
> If I understand the spec, you shouldn't set imm_data in SQ.
> 
> Thanks
> 

This seems a little confused to me. wc.imm_data is set in rxe_resp.c in response to an incoming request packet that contains an IMMDT extension header. I.e. a write with immediate or send with immediate opcode from the remote end of the wire. This wc is delivered to the receive completion queue when the message is complete. It should not have anything to do with the local send work queue entries.

Bob Pearson
