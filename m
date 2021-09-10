Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD68407274
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Sep 2021 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhIJUYt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Sep 2021 16:24:49 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:38644 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbhIJUYt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Sep 2021 16:24:49 -0400
Received: by mail-pg1-f178.google.com with SMTP id w8so2866484pgf.5
        for <linux-rdma@vger.kernel.org>; Fri, 10 Sep 2021 13:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ljOI21cdk2UrqHQjsGOUpBpg89hnFir+XhsKCyt6Asw=;
        b=yk2REja2OjCi9tZd6MknhJDB1RiwF92jcqLCUB5ZfDRF9z3pWqw57Jit2LR+eJndSH
         8xa0f831h1n9J7gmiNtCtdYaRfwF3atoZK1Wv5xlMnviBb+nShISkMsA21/WOSXp6OwI
         QGTyZMj+o3hnTDT+kenQzV5Odi67Onpr9SAymxWhPdafMjwUBRZ7QrC/BgmrHYusQir+
         XnPLuJWt9VQLd8zDtr43uUoyT1VbA+yK7FfW/qjWsakcPPWWuCpJ3Fzq1T/5WEMugmFi
         qttKYJhKVYmU9lESez7TVXCszqrcninycAOjgqoMW06z+sthEM6FRvNukuKHuig84aCq
         YfvA==
X-Gm-Message-State: AOAM531ldlWyM3apmikYNteG+QzvRH9wr6iAJYMwU5K5EN99ywettEcC
        ZVAZs83wuvPMbcK0c0yxlfhilnK8LIU=
X-Google-Smtp-Source: ABdhPJxzlkibzS1AhIS4v3OGGPYX7kOrTrYeB9ttzXmgzc4iuZSiSROAvbVjeT/UbiM+lNoeS9ZXKQ==
X-Received: by 2002:a62:1b07:0:b0:438:4d73:82d0 with SMTP id b7-20020a621b07000000b004384d7382d0mr284981pfb.67.1631305417447;
        Fri, 10 Sep 2021 13:23:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8bd3:6a77:8a42:bdc5])
        by smtp.gmail.com with ESMTPSA id i21sm6138515pgn.93.2021.09.10.13.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 13:23:36 -0700 (PDT)
Subject: Re: [PATCH for-rc v3 0/6] RDMA/rxe: Various bug fixes.
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "mie@igel.co.jp" <mie@igel.co.jp>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
 <f0d96a3c-d49d-651d-93e0-a33a5eca9f1b@acm.org>
 <CS1PR8401MB10777EEC9CF95C00D1BA62ABBCD69@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2cb4e1cb-4552-9391-164a-88f638dd3acf@acm.org>
Date:   Fri, 10 Sep 2021 13:23:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CS1PR8401MB10777EEC9CF95C00D1BA62ABBCD69@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/10/21 12:38 PM, Pearson, Robert B wrote:
> 1. Which rdma-core are you running? Out of box or the github tree?

I'm using the rdma-core package included in openSUSE Tumbleweed. blktests
pass with that rdma-core package against older kernel versions so I think
the rdma-core package is fine. The version number of the rdma-core package
I'm using is as follows:
$ rpm -q rdma-core
rdma-core-36.0-1.1.x86_64

The rdma tool comes from the iproute2 package:
$ rpm -qf /sbin/rdma
iproute2-5.13-1.1.x86_64

> 3. Where did you get the kernel bits? Which git tree? Which branch?

Hmm ... wasn't that mentioned in my previous email? I mentioned a commit
SHA and these SHA numbers are unique and unambiguous. Anyway: commit
2169b908894d comes from the for-rc branch of the following git repository:
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git.

Bart.


