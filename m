Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B8C463EAE
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Nov 2021 20:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhK3Tir (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Nov 2021 14:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhK3Tiq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Nov 2021 14:38:46 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53953C061574
        for <linux-rdma@vger.kernel.org>; Tue, 30 Nov 2021 11:35:27 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id r26so43339587oiw.5
        for <linux-rdma@vger.kernel.org>; Tue, 30 Nov 2021 11:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RT80yFMKn8dWNqeWSqmO9J70gyGq/6jNwFSxId/tD7I=;
        b=grIkuFlgqqd4t0uF7KcukqHQEaUK82siIT6sUJDl1qE2fVhNYQtz5U0+MvT67orxXX
         3QeowlelNLaX7r94REJI7RkdZ8bG+8MSq8XzbjxbMxY7C5YzobuT0KFzu4rWHf21RwiR
         3+G/oyHYMsv/K4feYscU5HsuE+mFUpqagxHKz0hTfBLZhKquLXHzzCeWDyOAsLhGGTs6
         qorjsDr619uO9DCiihliP8kLPHZgbDeuC1a47SLGVMG2YNRA4r7oMOdObaus5/UeF5bt
         ZoA57uAjY2gWRc/moKWonV5MezJqGmG4IKJKBz2wacmcKUM8H7OPsUwe7mhhMBR/D10e
         3UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RT80yFMKn8dWNqeWSqmO9J70gyGq/6jNwFSxId/tD7I=;
        b=2u/i5/nPltIS6hv5AGaHVV+booPgNkpTH8f0k4ltOQotPkRsTmgQpUf/TK9duunA1T
         wPk21dnkQ1pUjESEeAGS4nujfLJgGUwbwcbbw1c7Z81uEavN7UUvDplX8A22R9tMzuDM
         7hkiA2jOcjOKhAEn6EDfawY+WBIJ09lzqzaHTYaUHd8Q/9Eg6unY4QjByUU1CtSS/W5u
         r/zvK9tPzQH6WB/099K2LY1ahR+JxY5DYdAkxkEoxax718PTXU6L9aEWKlw21J85BbqS
         h5q0yHJfuyrYv+JrpsuwdDfbVLcUxKfAlPfg6AzRNIgszd+D/ah917IozCp4BUJ6pJX/
         kEgw==
X-Gm-Message-State: AOAM532pzMUwbJ08vshLO6BAocxFjI0QMxnnLSHM14UpV7rJ7JBYFjY6
        R425v4Ob7UaEbEZPf4nmdCM=
X-Google-Smtp-Source: ABdhPJyHQuxC1wsb+vph0KO1FtcvqNRM2LM9aVq+LmxyDnTH+mDX23N21+FUl1J71pGv9uM6zKSMfQ==
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr1008452oiw.175.1638300926572;
        Tue, 30 Nov 2021 11:35:26 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:7ffe:5e29:2a05:810? (2603-8081-140c-1a00-7ffe-5e29-2a05-0810.res6.spectrum.com. [2603:8081:140c:1a00:7ffe:5e29:2a05:810])
        by smtp.gmail.com with ESMTPSA id bn41sm3882307oib.18.2021.11.30.11.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 11:35:26 -0800 (PST)
Message-ID: <f5204655-758a-d95f-24ec-869bc2371d37@gmail.com>
Date:   Tue, 30 Nov 2021 13:35:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH for-next v4 09/13] RDMA/rxe: Replaced keyed rxe objects by
 indexed objects
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
 <20211103050241.61293-10-rpearsonhpe@gmail.com>
 <20211119174115.GB2988708@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20211119174115.GB2988708@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/19/21 11:41, Jason Gunthorpe wrote:
> On Wed, Nov 03, 2021 at 12:02:38AM -0500, Bob Pearson wrote:
>> +	if (mgid->raw[10] == 0xff && mgid->raw[11] == 0xff) {
>> +		if ((mgid->raw[12] & 0xf0) != 0xe0)
>> +			pr_info("mgid is not an ipv4 mc address\n");
>> +
>> +		/* mgid is a mapped IPV4 multicast address
>> +		 * use the 32 bits as an index which will be
>> +		 * unique
>> +		 */
>> +		index = be32_to_cpu(val32[3]);
>> +	} else {
>> +		if (mgid->raw[0] != 0xff)
>> +			pr_info("mgid is not an ipv6 mc address\n");
>> +
>> +		/* mgid is an IPV6 multicast address which won't
>> +		 * fit into the index so construct the index
>> +		 * from the four 32 bit words in mgid.
>> +		 * If there is a collision treat it like
>> +		 * no memory and return NULL
>> +		 */
>> +		index = be32_to_cpu(val32[0] ^ val32[1]);
>> +		index = (index << 32) | be32_to_cpu(val32[2] ^ val32[3]);
> 
> I'm not sure failing is such a good thing, can it chain them on a
> linked list or something?
> 
> Jason
> 

I had developed a version of the proposed patch which did what you suggest and felt that
it wasn't an improvement over the current code. Just too complicated. This patch is only
marginally cleaner than what is already there. I am leaning towards just leaving the
current red-black tree based code in place for mgids which don't fit nicely into xarrays
which however are quite a bit better for 32 bit indices (qpns, qkeys, rkeys, etc.)
Multicast is not an important use case for RoCE since plain IP is a better solution.
Unless you think otherwise we should just drop this patch.

Bob
