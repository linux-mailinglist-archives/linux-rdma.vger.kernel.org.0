Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C52C270BEB
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 10:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgISIoU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 04:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISIoU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Sep 2020 04:44:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEF1C0613CE
        for <linux-rdma@vger.kernel.org>; Sat, 19 Sep 2020 01:44:20 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so5000910pfn.9
        for <linux-rdma@vger.kernel.org>; Sat, 19 Sep 2020 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dXTE9kRebpI2fqAbGF/FvcZmxRuOFWxC/UO3k/YK9h0=;
        b=T9sJoYf1VvHM3K0UED7d3yYVH4GnfP+jqGRZEd3ncMjHBkXA0DU2G/tpfHUaH3oxhU
         AtMhVmSgvbz9FkjbVDe/z/qHjhMYtkP7OD58JWX+du4YSlO63evV/MfXOGYXoC/YZunQ
         vrM3FccKZrpar0byDbDtMHMA+8eblGmkUbULxjk+mBEfvKCaimPWXb7mgt4J2IBh0w1e
         uuwlr85r5qRDdstHmitwxURSrgiyn0lEHwW7RLqnCSdrF8VHzY1wdZNEMRA8k0z6Kd0I
         u7pXGLf2Nfv3zgGNhhDhVYuXMDhCHQ8tchMdVuWs9nigIGJuAxxox+ksrxWsvLEVnPus
         BfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dXTE9kRebpI2fqAbGF/FvcZmxRuOFWxC/UO3k/YK9h0=;
        b=shla1Wi0tCCJHLIGtFk7UsYEw8y2SU5IRIBixoLX0btEIz5KYaQ6D/XXILTUdX6M5G
         bQ9DyIbBDxMjdV8kISbk5n2ohIALb9kR8ixXRqC2+RZ7ze5T0fwUipmvnrIGjIY4sOd5
         ccPV+RKpfRrsDiJKIbNPNtIOFkLg22GClQmbD0ekWyWkRnlHOLVAq0nabL/iez3mq6q/
         hrVkdxqYxgRpQUAAaXycFuGjT8RLen0Wzqfsb0ENdUj026zAhW3CHsd5wKGIgSLJVktE
         npFC36ZEqqE8OKBILWO2Cr5sAmw2rRgxbklWUbdRhRU2/hXAl/fW7xHIqqLX8LcCG16p
         AEZQ==
X-Gm-Message-State: AOAM533OG+BpXUSg39L4O+oadooKfywMgkEeoLwh84XGYQ4DcbhNJfNM
        nd5ol5HVaNQaio1MVN3fb96bm9ZsEHs=
X-Google-Smtp-Source: ABdhPJxKmeysGZWwY5RtqjJ56pLYEGpt23bEva5ki5MEo4OaDOaIO989WcwZNDXVFVs2oh56EevspQ==
X-Received: by 2002:a63:e015:: with SMTP id e21mr30730214pgh.264.1600505060117;
        Sat, 19 Sep 2020 01:44:20 -0700 (PDT)
Received: from [10.75.201.17] ([129.126.144.50])
        by smtp.gmail.com with ESMTPSA id k5sm5920294pfu.77.2020.09.19.01.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 01:44:19 -0700 (PDT)
Subject: Re: [PATCH for-next v5 00/12] rdma_rxe: API extensions
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
 <20200918235117.GK3699@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <ec3bf0ed-8dde-5f36-656f-3cf6d64bd7a2@gmail.com>
Date:   Sat, 19 Sep 2020 16:44:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200918235117.GK3699@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/19/2020 7:51 AM, Jason Gunthorpe wrote:
> On Fri, Sep 18, 2020 at 04:15:05PM -0500, Bob Pearson wrote:
>> This patch series is a collection of API extensions for the rdma_rxe driver.
>> With this patch set installed there are no errors in pyverbs run-tests and
>> 31 tests are skipped down from 56. The remaining skipped test cases include
>> 	- XRC tests
>> 	- ODP tests
>> 	- Parent device tests
>> 	- Import tests
>> 	- Device memory
>> 	- MLX5 specific tests
>> 	- EFA tests
> It seems like a big improvement! Thanks!
>
> Zhu, can you look through this too?

OK. It seems that a problem occurred in this patch set.

Hi, Bob

Please fix this problem. Thanks a lot.

Zhu Yanjun

>
> Jason
>
>> It continues from the previous (v4) set which implemented memory windows and
>> has had a number of individual patches picked up in for-next.
>>
>> This set (v5) includes:
>> 	Ported to current head of tree
>> 	Memory windows patches not yet picked up
>> 	kernel support for the extended user space APIs:
>> 	  - ibv_query_device_ex
>> 	  - ibv_create_cq_ex
>> 	  - ibv_create_qp_ex
>> 	Fixes for multicast which is not currently working
> I would like to progress the simple independent obviously OK bits,
> could you split them out?
>
> Jason
