Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A6378753D
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242510AbjHXQYj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242587AbjHXQYc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 12:24:32 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE4F1BDF;
        Thu, 24 Aug 2023 09:24:20 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bcb5df95c5so31687a34.1;
        Thu, 24 Aug 2023 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692894259; x=1693499059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3TaNkEt9dhjFMeqFrTDb5qD2TAwVnHtpUgyNK//NxU=;
        b=RtFTNyEG93a5jPIkKjgcbQNaUQnI5u9kr4GOr98vFlr2zK7Q8qtAnhhtNwsc4fFsvX
         xqukXhPrQIg3K8R7NSaU1kcmCiOZ9foeUcRi8/J2K+bF2McKm3NU/p0zaCVpan7kuDVP
         2BXb6eHJbFCv5oW0FCJrSaw1JYGrQjFbX3vnBpaZToLbzH05+bGATYx69rg7BqFvk5Hn
         Fh7TooQZzSTMcNmYbGD6InAc8hZ5aefYgIhY1ozd6pgi/ryLRLIKDDLiSGYMgGDXqX9i
         4lxGR+dnYTMI5/EMeMF7sY6OiT7y5cqtuPvbZFvu7HNzsq8J/TWuU3N49zjbv722gy4p
         5s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692894259; x=1693499059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3TaNkEt9dhjFMeqFrTDb5qD2TAwVnHtpUgyNK//NxU=;
        b=UHuK5jo06g4LaQu8l6c5Ku1Y6M8FxpZZXAnS2XEHnmJio1fSSLLyMBzFHdEcrx4t95
         iITrm9o1oHiH0LsYbI8o0FK9DSia8CekEdN5jxBevM5MS4+B9xTdA1QKOF+T/UIiQgEd
         QSKPAKX49iV5vojaTcpt3eJYAv8g4fub/aCqlczbuNL+jwas/vtQzNB9s6LKuYf+6m2E
         lpcrKO/l8AQN/DexGIBKy8TAu2hgm8JVyRGbi/EL+Kil2tdfCNKLNyaLsr3U2TqFWjna
         jxsOvvIa+RSNxW30CkZtcIhR169pytxUOJJjCIP2leAOrT3UofsU0/8XxjREczn1ZNZv
         m1tg==
X-Gm-Message-State: AOJu0YyWFWmD1j9WcDzBJHaIIVg79fWu0oSvlBdSIVSAEwptv4EJKRQg
        gLLAUUxDAKWBsoiqKqPt/pIbU5tQMOPciA==
X-Google-Smtp-Source: AGHT+IHELkuxZ4614+xdTmuCI9/scypcyiF9HZco6olxXUMtZj5ofpx8YDBgPC8w/nCXaRbGSlFOxg==
X-Received: by 2002:a9d:7a5a:0:b0:6bc:96c3:b6ce with SMTP id z26-20020a9d7a5a000000b006bc96c3b6cemr2754424otm.16.1692894259206;
        Thu, 24 Aug 2023 09:24:19 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:16dd:44f3:4ece:f186? (2603-8081-140c-1a00-16dd-44f3-4ece-f186.res6.spectrum.com. [2603:8081:140c:1a00:16dd:44f3:4ece:f186])
        by smtp.gmail.com with ESMTPSA id y16-20020a0568301d9000b006bdb67efd4dsm3468411oti.31.2023.08.24.09.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 09:24:18 -0700 (PDT)
Message-ID: <c1c55bff-ed73-06c0-abea-ad80c70465d9@gmail.com>
Date:   Thu, 24 Aug 2023 11:24:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bug report] blktests srp/002 hang
To:     Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <27e31e00-74a3-6209-5ad5-1783d6e67a0d@gmail.com>
 <2668f6c9-df53-b3c5-3452-d411d11057e1@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <2668f6c9-df53-b3c5-3452-d411d11057e1@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/23/23 14:46, Bart Van Assche wrote:
> On 8/23/23 09:19, Bob Pearson wrote:
>> I have also seen the same hangs in siw. Not as frequently but the same symptoms.
>> About every month or so I take another run at trying to find and fix this bug but
>> I have not succeeded yet. I haven't seen anything that looks like bad behavior from
>> the rxe side but that doesn't prove anything. I also saw these hangs on my system
>> before the WQ patch went in if my memory serves. Out main application for this
>> driver at HPE is Lustre which is a little different than SRP but uses the same
>> general approach with fast MRs. Currently we are finding the driver to be quite stable
>> even under very heavy stress.
>>
>> I would be happy to collaborate with someone (you?) who knows the SRP side well to resolve
>> this hang. I think that is the quickest way to fix this. I have no idea what SRP is waiting for.
> 
> Hi Bob,
> 
> I cannot reproduce these issues. All SRP tests work reliably on my test setup on
> top of the v6.5-rc7 kernel, whether I use the siw driver or whether I use the
> rdma_rxe driver. Additionally, I do not see any SRP abort messages.

Thank you for this. This is good news.
> 
> # uname -a
> Linux opensuse-vm 6.5.0-rc7 #28 SMP PREEMPT_DYNAMIC Wed Aug 23 10:42:35 PDT 2023 x86_64 x86_64 x86_64 GNU/Linux
> # journalctl --since=today | grep 'SRP abort' | wc
>       0       0       0
> 
> Since I installed openSUSE Tumbleweed in the VM in which I run kernel tests: if
> you are using a Linux distro that is based on Debian it may include a buggy
> version of multipathd. Last time I ran the SRP tests in a Debian VM I had to
> build multipathd from source - the SRP tests did not work with the Debian version
> of multipathd. The shell script that I use to build and install multipathd is as
> follows (must be run in the multipath-tools source directory):

I run on Ubuntu which is Debian based. So perhaps that is the root of the problems
I have been seeing.

I'll try to follow your lead here.

Bob
> 
> #!/bin/bash
> 
> scriptdir="$(dirname "$0")"
> 
> if type -p zypper >/dev/null 2>&1; then
>     rpms=(device-mapper-devel libaio-devel libjson-c-devel librados-devel
>       liburcu-devel readline-devel systemd-devel)
>     for p in "${rpms[@]}"; do
>     sudo zypper install -y "$p"
>     done
> elif type -p apt-get >/dev/null 2>&1; then
>     export LIB=/lib
>     sudo apt-get install -y libaio-dev libdevmapper-dev libjson-c-dev librados-dev \
>         libreadline-dev libsystemd-dev liburcu-dev
> fi
> 
> git clean -f
> make -s "$@"
> sudo make -s "$@" install
> 
> Bart.

