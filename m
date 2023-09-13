Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E1979F073
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Sep 2023 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjIMRgH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Sep 2023 13:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjIMRgG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Sep 2023 13:36:06 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6751A8;
        Wed, 13 Sep 2023 10:36:02 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a9ee3c7dbbso26637b6e.1;
        Wed, 13 Sep 2023 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694626562; x=1695231362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVrYJV4w5Dg5YDYQoYNIPf+TLoTL3D2orZps/Ab0/MQ=;
        b=IV8zTrk7yylB9D1LdRYrJlsA8k+qX9YlnNsc5dXMZXWK4TrsvZWU5sH+NYIMN9zdoP
         Fvhp/pIt12QusOP3Wo4Bwhji5CF9Hwi3BoJ+Q3k4VO8bg3jl+Ni/XTrfV0807XaxdzmT
         8d9mP+9REcAunUcP1wad7pN+rziH9zO8xa//BVZA85YO8WmKuMwmSJD4BgxZGAx6Z3Y1
         zBd+aVC2Hlci3DWWIJQWf1AutYPcMGmaE0deTYxuIrmsyg58H7HPbr+zpyLV0miPE9up
         b71lJidKnSDIswNdtKMcR72slj2Q4S89ynPNyVGUvCNzOlRUefqnG0/yQFTlv5QUwm1I
         Sbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626562; x=1695231362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVrYJV4w5Dg5YDYQoYNIPf+TLoTL3D2orZps/Ab0/MQ=;
        b=fcSYSpzf5J85a3Rj6AH6r4nodLqFOjxx1p3UqPAFRVZtPiLYNyZ+LjOc/YNybTZPAT
         H0H2oOS7Bac2y3xlY4FQGfFXk7ELIwa8SbGqr1yIj5n7LrSgDRThAl4z3ygw3CzFZG3J
         ifbOBJIskiNkI7GkTQHT/QDw8FouQZ7rdbjf/xjWMmp1xUWd0zq84r62OJuiJLO2tKW3
         1iutE22wYlQJr546GC7qNGWDyyN87vuK7x2XiaK4PbA52eKtAyInep4K402orE2sP3Id
         dWz3Ht6bQZ9fEZeRTRrjWHFmTTTGWYNa/nMGgtF8WrZ1ts5KW5H3cqLh9AH2Hec3ZqGq
         Wc5Q==
X-Gm-Message-State: AOJu0Yw74azOZV0tfPMvOTB+NLFcc5aij84qxjabs6KypMRY4TowH6s5
        fmV+p+yLGlrVoWybFcSjXxn+uPw8TR0=
X-Google-Smtp-Source: AGHT+IERssZtsE/Shj9yraXHFHZ5tl/3mIaUX959EBYcb1GpReRkoCku0BYhe0HRZ37soRk0JnUvFQ==
X-Received: by 2002:a54:4118:0:b0:3ab:83fe:e18f with SMTP id l24-20020a544118000000b003ab83fee18fmr3407340oic.35.1694626562009;
        Wed, 13 Sep 2023 10:36:02 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:3305:65ce:78cc:72fb? (2603-8081-1405-679b-3305-65ce-78cc-72fb.res6.spectrum.com. [2603:8081:1405:679b:3305:65ce:78cc:72fb])
        by smtp.gmail.com with ESMTPSA id z10-20020a056808048a00b003a42c45c109sm5399866oid.2.2023.09.13.10.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 10:36:01 -0700 (PDT)
Message-ID: <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
Date:   Wed, 13 Sep 2023 12:36:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [bug report] blktests srp/002 hang
To:     Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/25/23 08:52, Bart Van Assche wrote:
> On 8/24/23 18:11, Shinichiro Kawasaki wrote:
>> If it takes time to resolve the issues, it sounds a good idea to make siw driver
>> default, since it will make the hangs less painful for blktests users. Another
>> idea to reduce the pain is to improve srp/002 and srp/011 to detect the hangs
>> and report them as failures.
> 
> At this moment we don't know whether the hangs can be converted into failures.
> Answering this question is only possible after we have found the root cause of
> the hang. If the hang would be caused by commands getting stuck in multipathd
> then it can be solved by changing the path configuration (see also the dmsetup
> message commands in blktests). If the hang is caused by a kernel bug then it's
> very well possible that there is no way to recover other than by rebooting the
> system on which the tests are run.
> 
> Thanks,
> 
> Bart.

Since 6.6.0-rc1 came out I decided to give blktests srp another try with the current
rdma for-next branch on my Ubuntu (debian) system. For the first time in a very long
time all the srp test cases run correctly multiple times. I ran each one 3X.

I had tried to build multipath-tools from source but ran into problems so I reinstalled
the current Ubuntu packages. I have no idea what was the root cause that finally went
away but I don't think it was in rxe as there aren't any recent patches related to the
blktests failures. I did notice that the dmesg traces picked up a couple of lines after
the place where it used to hang. Something about setting an ALUA timeout to 60 seconds.

Thanks to all who worked on this.

Bob Pearson
