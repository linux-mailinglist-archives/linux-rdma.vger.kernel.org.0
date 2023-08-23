Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AFA7860EF
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbjHWTqe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbjHWTqd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 15:46:33 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485A910CC;
        Wed, 23 Aug 2023 12:46:32 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6bd0a0a6766so4308131a34.2;
        Wed, 23 Aug 2023 12:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692819991; x=1693424791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4jOIqQFtRoqjLGEv4mDatBugt3hVKTLzS2seQK1Jvk=;
        b=k/lFBm7DvAvDw+f7T3TPSlfUmPaDkFwWmTMgCVAGFfM8c+6vnBgdy7Rz70BrkCzSBq
         rDCQP6iyvVvnTi6EmW6iq4XPZCrnrrqZtEEXL92sceHXbqhEAJT6VZSeB8OPotmbUphd
         ETgcHyjcalUPhqnyXUeDFTD5InUHH8I3OkmofXZirBUMCUPu4HkwkmJCOJjZoPMpDz5o
         mBAWYCR3MpLh6lGuY5zsk8PWyDc6vmtBecDsPPhSdo8oni2Dc9UILNmAAgJ6OM8HFDcT
         95u0DBPr+bgZqWI30P+jRn+iA9WXAbrUiSJy+iMa0bZclXQODaIOcCzheWgDu8uxUiqS
         oDEQ==
X-Gm-Message-State: AOJu0YzyUvPsr4Gfcm08J9TPdLB3YOXC5MGCoUFb8iB5bWIRAXcx2ZwM
        homKkARALbzGJXtIMFSoaruEWeLS/8g=
X-Google-Smtp-Source: AGHT+IFoUCesbrhxPJhkAPyN8lGtfPyw9z6ECRkpGfLVxxh1OKmGj1GzCbBY2Vf0ojLcV6Lin6yqSQ==
X-Received: by 2002:a05:6830:84:b0:6bc:9078:81c8 with SMTP id a4-20020a056830008400b006bc907881c8mr328908oto.20.1692819991403;
        Wed, 23 Aug 2023 12:46:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ecb6:e8b9:f433:b4b4? ([2620:15c:211:201:ecb6:e8b9:f433:b4b4])
        by smtp.gmail.com with ESMTPSA id d2-20020a639902000000b00564b313d526sm10062404pge.54.2023.08.23.12.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 12:46:30 -0700 (PDT)
Message-ID: <2668f6c9-df53-b3c5-3452-d411d11057e1@acm.org>
Date:   Wed, 23 Aug 2023 12:46:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <27e31e00-74a3-6209-5ad5-1783d6e67a0d@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <27e31e00-74a3-6209-5ad5-1783d6e67a0d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/23/23 09:19, Bob Pearson wrote:
> I have also seen the same hangs in siw. Not as frequently but the same symptoms.
> About every month or so I take another run at trying to find and fix this bug but
> I have not succeeded yet. I haven't seen anything that looks like bad behavior from
> the rxe side but that doesn't prove anything. I also saw these hangs on my system
> before the WQ patch went in if my memory serves. Out main application for this
> driver at HPE is Lustre which is a little different than SRP but uses the same
> general approach with fast MRs. Currently we are finding the driver to be quite stable
> even under very heavy stress.
> 
> I would be happy to collaborate with someone (you?) who knows the SRP side well to resolve
> this hang. I think that is the quickest way to fix this. I have no idea what SRP is waiting for.

Hi Bob,

I cannot reproduce these issues. All SRP tests work reliably on my test setup on
top of the v6.5-rc7 kernel, whether I use the siw driver or whether I use the
rdma_rxe driver. Additionally, I do not see any SRP abort messages.

# uname -a
Linux opensuse-vm 6.5.0-rc7 #28 SMP PREEMPT_DYNAMIC Wed Aug 23 10:42:35 PDT 2023 x86_64 x86_64 x86_64 GNU/Linux
# journalctl --since=today | grep 'SRP abort' | wc
       0       0       0

Since I installed openSUSE Tumbleweed in the VM in which I run kernel tests: if
you are using a Linux distro that is based on Debian it may include a buggy
version of multipathd. Last time I ran the SRP tests in a Debian VM I had to
build multipathd from source - the SRP tests did not work with the Debian version
of multipathd. The shell script that I use to build and install multipathd is as
follows (must be run in the multipath-tools source directory):

#!/bin/bash

scriptdir="$(dirname "$0")"

if type -p zypper >/dev/null 2>&1; then
     rpms=(device-mapper-devel libaio-devel libjson-c-devel librados-devel
	  liburcu-devel readline-devel systemd-devel)
     for p in "${rpms[@]}"; do
	sudo zypper install -y "$p"
     done
elif type -p apt-get >/dev/null 2>&1; then
     export LIB=/lib
     sudo apt-get install -y libaio-dev libdevmapper-dev libjson-c-dev librados-dev \
	    libreadline-dev libsystemd-dev liburcu-dev
fi

git clean -f
make -s "$@"
sudo make -s "$@" install

Bart.
