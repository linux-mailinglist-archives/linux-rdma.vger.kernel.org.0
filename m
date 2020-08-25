Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F138C251DAA
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHYQ6T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYQ6S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 12:58:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9CDC061574;
        Tue, 25 Aug 2020 09:58:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so2794353wmk.1;
        Tue, 25 Aug 2020 09:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=T+c10JcfrGS91lxh/Fs8oD61/KkVCBP1xSQwLONf2xk=;
        b=N0YvEwzlNfbv2ENgL708TbnvP9W81MevHjVtFu+NP93kKyt6gaXF4nvCwRulA6qdYS
         EGuZcZPK10qzjBLB+JUs1ceVwimkfdkA5oajbeDDkrzBo108k2ckJ+7ndSHpFDVDavN3
         +q+7V1TMns5/aSHhT8lywhtCkqRjGgfMyPpPdMsiGpoY3QG+EXhoqckMOv6eIfidseBB
         z2Wrflu4Nb6GWTwUj2x2Pr/nugNVVx0+OYrfkgbQzvgkOiH/iaAan1JvsoaClXAc6b7N
         CcIV+Vqsklj9xtei+cFySXpGnKOt+m6knCouiJZ1yPRXL9mKag7FIXGrKBe0q/DQBtE7
         NQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T+c10JcfrGS91lxh/Fs8oD61/KkVCBP1xSQwLONf2xk=;
        b=EOWhI93AJ9UXGttLLzSUL641BwCDCylQzwXjBVocpgN81ecodVOCKREBmqhVQ76vvG
         XXNbkh71f4K3pHiac5TXD8gi2qGlPDf4dJbCWHIYoLj3WM+jirlXQ6DdzWAXtUO1adHr
         kNDEOrCnTU6z4btHSdHZfbuGQn7pxzC1JB6cAc4r+gC0exhtEYprvk/TtUP7bMEeNYK3
         vFfrIfrlESllfm+PI/bipkI5clu1oHdb+ept3KVta7w/RqWrZLzUFAIpYpah7jjuAura
         KDQT5D5kGKdlCfhcDrXjMMdnCUV62qgYTTgnMIfbGUmUU3SV2FnFzhESazEMaLXeAcNV
         RQzw==
X-Gm-Message-State: AOAM533H8MTld/AcNLHYm8SSAq84iT+lNqTN8dipeQRq5lIdBIg3OMg7
        gvp+PWZ19/zoY16TYKCcH/bExX3zCKIohzBv
X-Google-Smtp-Source: ABdhPJwk4nCd+wELim1WQCEsIcsR75mFn2eHpPfK0DSyrZDt5cesw/ZpuOk9voWBRXZPYqMxFddXGA==
X-Received: by 2002:a1c:a984:: with SMTP id s126mr3062109wme.163.1598374695222;
        Tue, 25 Aug 2020 09:58:15 -0700 (PDT)
Received: from [192.168.0.16] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id i22sm33277241wrb.45.2020.08.25.09.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 09:58:14 -0700 (PDT)
Subject: Re: [PATCH] IB/qib: remove superfluous fallthrough statements
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roland Dreier <roland@purestorage.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200825155142.349651-1-alex.dewar90@gmail.com>
 <4877c3a5-365e-4500-43c0-4a4361e2cda3@embeddedor.com>
 <086ee29ef75f657dcf45e92d4ebfdf2b3f4fcab8.camel@perches.com>
 <da65ca20-49cb-2940-76d6-7e341687a9e2@embeddedor.com>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <64d7e1c9-9c6a-93f3-ce0a-c24b1c236071@gmail.com>
Date:   Tue, 25 Aug 2020 17:58:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <da65ca20-49cb-2940-76d6-7e341687a9e2@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/08/2020 17:49, Gustavo A. R. Silva wrote:
>
> On 8/25/20 11:26, Joe Perches wrote:
>> On Tue, 2020-08-25 at 11:19 -0500, Gustavo A. R. Silva wrote:
>>> On 8/25/20 10:51, Alex Dewar wrote:
>>>> Commit 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
>>>> erroneously marked a couple of switch cases as /* FALLTHROUGH */, which
>>>> were later converted to fallthrough statements by commit df561f6688fe
>>>> ("treewide: Use fallthrough pseudo-keyword"). This triggered a Coverity
>>>> warning about unreachable code.
>>>>
>>>> Remove the fallthrough statements and replace the mass of gotos with
>>>> simple return statements to make the code terser and less bug-prone.
>>>>
>>> This should be split up into two separate patches: one to address the
>>> fallthrough markings, and another one for the gotos.
>> I don't think it's necessary to break this into multiple patches.
>> Logical changes in a single patch are just fine, micro patches
>> aren't that useful.
>>
> There is a reason for this. Read the changelog text and review the patch.
>
> Thanks
> --
> Gustavo
I think it probably does make sense as two patches. I'll do a resend.
