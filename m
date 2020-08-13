Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E12243B8F
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Aug 2020 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMO36 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Aug 2020 10:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgHMO35 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Aug 2020 10:29:57 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB52C061757
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 07:29:57 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v21so4906987otj.9
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=r+XuBEGU73yZn/yp1ZpUJuWWUarLLj0Xw9lf+BCQb/A=;
        b=k2/bNIvYGlmJyGAbUh/ngXrNg+KU5dCvclZFhl2g1ClGHbR2gtUDD7moi7Uir3px7r
         fZsrWalBJymAxQ8+i5zIYL3huPgQ4iqQewqVGAn2KaYZ3kWAG3dbVBW0+vmd1XcnPc2v
         69QpOc6MltRqmpoI4f98pb2lRDdV8TLvrmwEcLG9agR9S4uH4N7EUygipoamdxtCgxAH
         95lNFv2rBB50BAfKQvAkTnSupKA0owoPHrQEPOTqbp6gRfU8Tmcx0n4gurHCLLcoXtnt
         Ree4s5ona7bC3ful5QSq8dHjyQATa4kyGRlqXj7Y/Q4KOEKRiTpEusZMtgQZ7Dimgdeq
         a+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+XuBEGU73yZn/yp1ZpUJuWWUarLLj0Xw9lf+BCQb/A=;
        b=H5YZwWyNYBjWhCHAVd0DYqudqzdb0573S/lvqs5LW8F08d623wwMSLAD9AZfdet950
         Wk0iXvX3kd2cqsi11YW/HtPYHCiZmvYQ55UmAkVA/fDPdZDnDfmax99mZ60Y58CpI3DN
         N7h0DyInwoFtYzwxNegIP/NG5MWpJqm+5h0ndD2yE4DW6+n5P9I9x75rzSDfe0JKwnBN
         csN3tY+TE4B7JFTx3B6zp0ADBEYst46qYAOYt7ciBt+7f/LEFEjZZWGIjSN6V9SlUL17
         t9s2N8I92i4sqMH8CPhg49rJliiXnrtRrfF0vXkNMxpLo6lXC/pixHPU5gawKUv3M0L3
         Gcwg==
X-Gm-Message-State: AOAM530/E3pb5XhVH7z0uqwvpV+4F+OiqddwbS1BB1OtThVkwS2lfYMd
        hbAvFyf0hrpRm8e0P5F1KD4=
X-Google-Smtp-Source: ABdhPJyIkSEUupRDZs2HO54nZL4Yp2Z4VWiDwUziqphBetB+08SiLPqAx139KumCFKIASdHFQ27TmQ==
X-Received: by 2002:a05:6830:310b:: with SMTP id b11mr4175791ots.71.1597328996971;
        Thu, 13 Aug 2020 07:29:56 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:d46:5113:64d8:597c? ([2605:6000:8b03:f000:d46:5113:64d8:597c])
        by smtp.gmail.com with ESMTPSA id z72sm1139029ooa.42.2020.08.13.07.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:29:56 -0700 (PDT)
Subject: Re: Is there a simple way to install rdma-core other than making a
 package?
To:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <75bbc81e-cde9-c8ac-0ba3-04bf17b8d5fa@gmail.com>
 <23cc5656-882f-f8a8-426c-ff065cb0b969@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <b96411c7-367f-010a-3f5d-fd6cb59662e3@gmail.com>
Date:   Thu, 13 Aug 2020 09:29:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <23cc5656-882f-f8a8-426c-ff065cb0b969@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/12/20 12:14 PM, Bart Van Assche wrote:
> On 2020-08-11 20:41, Bob Pearson wrote:
>> There doesn't seem to be a documented way to make install rdma-core, at least in the README file. However trying the obvious
>>
>> $ bash build.sh
>> $ cd build
>> $ sudo make install
>>
>> seems to work, almost. After a few 100 lines of promising output I get
>>
>> CMake Error at librdmacm/cmake_install.cmake:76 (file):
>>   file INSTALL cannot find
>>   "/home/rpearson/src/rdma-core-git/build/lib/librdmacm.so.1.3.31.0": No such
>>   file or directory.
> 
> This is how I do this myself:
> 
> export EXTRA_CMAKE_FLAGS="-DCMAKE_BUILD_TYPE=Debug -DENABLE_WERROR=1" &&
>     mkdir -p build &&
>     cd build &&
>     cmake -G Ninja CFLAGS="-O0 -g" -DCMAKE_INSTALL_PREFIX=/usr .. &&
>     ninja &&
>     ninja install
> 
> Bart.
> 
Thanks, I'll try it.
