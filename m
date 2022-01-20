Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4724946A9
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 06:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiATFIh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 00:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiATFIh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jan 2022 00:08:37 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCB6C061574
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 21:08:36 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so6141284otc.13
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 21:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=mE+T8t2CHoSBcSYFTcNXJA0w0cvX+pbqcoMdliYfgd4=;
        b=GhedJue5DHTRtQmff7ZKF88wPvV1ZeGjq04/nssxJ2xk1JS53EmbKo/wR3xaSCVDyG
         lhM3UNivI4tyMp/jW41CA0p6PeKQjJSb9pMEj5JpezotdzQKJao2caeIC4CybAhP+2ZS
         W7xGqHk1r6TGK6MvjZxk6sb3PQeg7hPExvz6tpGSj+pPJf4btAESEBDFUeZJw0Y4iHAH
         pcB2Hou1Gj67HVuXXVHW6XFtXdLvRBI+/jTNmd49M8FooSxYFWhamkPRxJgjHpIPhy4D
         Qd9Ml1SmDx/FW64aiUtfQlGqtnmXkmqxRDqQOVLgWO5Fcfgrym2aSmCP1Rg2XULr1C2T
         HyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mE+T8t2CHoSBcSYFTcNXJA0w0cvX+pbqcoMdliYfgd4=;
        b=d7nSDO707Ck13q9KmQa+x95qVB+xq/CQTusP5979suUN4twqqeSRAk15niQfYRCvGQ
         3Fjdu+yfhxFsr3j/QKjZUGfC33ybjykvQQX9XnHuiyXo3CYgGh4y0a6ucFbFNuMBriMG
         rgcvrZXS+TgwOe3xKJl5R7JZLNl4IwhlqaWbUM9t6SEYadVD3wbD1FV/VQf+Aq/V9l2S
         d4Drx5ab8qqPeVnhqyDX5S3ut76BenoCl1Id7dX36L2C9V3H0lWLbU4fFFv+OI66CQ6z
         CgYIXSJdUYC7l8UCnhFyb090IvRTh04432yKKml7wwsfwJ7pdVG2wNXocO8zuYUT9y/z
         QLAA==
X-Gm-Message-State: AOAM531C0O+8ZOBu4LDI4SOsjAV6rVnaK5Ihete9pE+EnGBFoNVbbGb7
        jrgRaRxWWAH/XHsx2nV/Epu6uU6l4eU=
X-Google-Smtp-Source: ABdhPJxwXOZ3qxCrxQsT8bwXoKk7jx6+UV2U/MmQxN8WNp6MrIEyYeAOJboy39tft9W1H52qODAnmQ==
X-Received: by 2002:a05:6830:612:: with SMTP id w18mr26797022oti.155.1642655316231;
        Wed, 19 Jan 2022 21:08:36 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id z18sm772894oot.33.2022.01.19.21.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 21:08:35 -0800 (PST)
Message-ID: <b25e4695-000f-0f8f-3e50-184e567132b8@gmail.com>
Date:   Wed, 19 Jan 2022 23:08:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Fwd: Re: [rdma-core PATCH] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Content-Language: en-US
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <61E6823E.9090808@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <61E6823E.9090808@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/18/22 03:02, yangx.jy@fujitsu.com wrote:
> CC: linux-rdma mail list
> 
> On 2022/1/14 4:51, Bob Pearson wrote:
>> The way these queues work they can only hold 2^n - 1 entries. The reason for this is
>> to distinguish empty and full. If you let the last entry be written then producer would advance to equal consumer which is the initial empty condition. So a queue which can hold 1 entry has to have two slots (n=1) but can only hold one entry. It begins with
> Hi Bob,
> 
> Thanks for your detailed example.
>> prod = cons = 0 and is empty and is*not*  full
full = (cons == ((prod + 1) % 2)) = (0 == 1) = false
empty = (prod == cons) == (0 == 0) = true
>>
>> Adding one entry gives
>>
>> slot[0] = value, prod = 1, cons = 0 and is full and not empty
full = (cons == ((prod + 1) % 2)) = (0 == 0) = true
empty = (prod == cons) == (0 == 1) = false
>>
>> After reading this value
>>
>> slot[0] = old value, prod = cons = 1 and queue is empty again.
full = (cons == ((prod + 1) % 2)) = (1 == 0) = false
empty = (prod == cons) = (1 == 1) = true
>>
>> Writing a new value
>>
>> slot[1] = new value, slot[0] = old value, prod = 0 and cons = 1 and queue is full again.
full = (cons == ((prod + 1) % 2)) = (1 == (0 + 1) % 2) = true
empty = (prod == cons) = (0 == 1) = false

and x % 2^N is the same as x & (2^N - 1) or x & index_mask. 
>>
>> The expression full = (cons == ((qp->cur_index + 1) % q->index_mask)) is correct.

Actually you are correct. If you look at queue_full() it uses
full = (cons == (prod + 1) & q->index_mask) and queue_empty() uses
empty = (prod == cons) *but*
check_qp_queue_full() uses
full = (cons == ((qp->cur_index + 1) % q->index_mask)) with % instead of &.
I was so used to looking at the first two I missed the error in the last one.

% should be & like the others.

Bob


