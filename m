Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EDF366457
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 06:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhDUEXd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 00:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhDUEXd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 00:23:33 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E59C06174A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 21:23:01 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id e25so11267166oii.2
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 21:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HV+TuKRFLwkUfXsh7oTwDLmxOvD9McKB/o/4/0jz6Ec=;
        b=KmzrVIHgVehqkh1OvhcsuDRzP+Yr3pCcM3kNT6J3H20c+7LiaYPzVbYaDo1dVw6JfM
         +y3WreY3A1FNPsH3vq4zK6Ju15ZMqt49thf0P2KNzhAQsEh6XK7Xd8ak8Pja9YopJxjU
         /HKtn40GzW+giK+zPjlqFLnJ9VodsTnjltGLfoQeTNz2QvmWe0NrLUSQGoV1iJ6JSnWR
         90faJ2lcbklE79YZs/G+Liv/lilD19lLI7eL84DfhMPSX+zI8QOMeLXDBvrp5J9vxjil
         jG7Gok90FwYF0cINY6YRKKNf67a+fo7YJGPMSfO4x7vqIbOf4CbArOqDvvFtEAv6qy0y
         gZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HV+TuKRFLwkUfXsh7oTwDLmxOvD9McKB/o/4/0jz6Ec=;
        b=Vc8XyIb1N9XIJmSehXM8osoMQxU+/IhQTGaJcgglSqpEGswx1tFM48VPk0uI28/krr
         9CYBLW8AAAjeJEHVSdGR/vyKeQUxsEZgXgrjuzPKLzcBXSIOqHcaUC6Joovd/B00f0Cm
         fPwcMkSt6E9T7QdEZy22/rxcvqE1uHGMtMQHJOTH226gVAE64NUIDwSjuQZAEoj2rWUb
         iQxT1FOEQIc8XY1Hlue/qhQBBlsCNmDK8fmAn45DUYK8gFSBZKIKgtTjnWt2nEgc8m8x
         hPFTp24mjnala9GO3qS7TBpnTzK0G3HAdMr3LM2EC1wTpgMZ+Wc9VOkmkrDD9r4TTiPw
         ygEw==
X-Gm-Message-State: AOAM533Dqeztx2KcN8V8J1LhCl98h2IGUbEE6fvvWeoL0hvwfTqbxasn
        gJKR7bFAkKV37VpeEWVG3Cs=
X-Google-Smtp-Source: ABdhPJzHyzo9txeyAY8/bVoRVib0PEYo3tX62KyrjL3oip99Wtr6YCcL+LMLSPeR1at1Nl5RpRCuDw==
X-Received: by 2002:a05:6808:b10:: with SMTP id s16mr5547710oij.4.1618978979760;
        Tue, 20 Apr 2021 21:22:59 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:b446:281e:a20a:b0d2? (2603-8081-140c-1a00-b446-281e-a20a-b0d2.res6.spectrum.com. [2603:8081:140c:1a00:b446:281e:a20a:b0d2])
        by smtp.gmail.com with ESMTPSA id o65sm262014ooo.24.2021.04.20.21.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 21:22:59 -0700 (PDT)
Subject: Re: [PATCH for-next v2 8/9] RDMA/rxe: Implement invalidate MW
 operations
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210415025429.11053-1-rpearson@hpe.com>
 <20210415025429.11053-9-rpearson@hpe.com>
 <CAD=hENfNCVjsXn-qbVXoHWxKCDPOj5muhpSeJp5Lz8Rt=ZxdNA@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <2380a05a-4939-85ca-39ac-30a0d728ce5b@gmail.com>
Date:   Tue, 20 Apr 2021 23:22:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAD=hENfNCVjsXn-qbVXoHWxKCDPOj5muhpSeJp5Lz8Rt=ZxdNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/20/21 1:38 AM, Zhu Yanjun wrote:
> On Thu, Apr 15, 2021 at 10:55 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> Implement invalidate MW and cleaned up invalidate MR operations.
>>
>> Added code to perform remote invalidate for send with invalidate.
>> Added code to perform local invalidation.
>> Deleted some blank lines in rxe_loc.h.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_loc.h   | 23 ++++-----
>>  drivers/infiniband/sw/rxe/rxe_mr.c    | 59 +++++++++++++++++------
>>  drivers/infiniband/sw/rxe/rxe_mw.c    | 67 +++++++++++++++++++++++++++
>>  drivers/infiniband/sw/rxe/rxe_req.c   | 22 +++++----
>>  drivers/infiniband/sw/rxe/rxe_resp.c  | 52 +++++++++++++--------
>>  drivers/infiniband/sw/rxe/rxe_verbs.h | 23 +++++----
>>  6 files changed, 178 insertions(+), 68 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index e6f574973298..7f1117c51e30 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -76,41 +76,34 @@ enum copy_direction {
>>         from_mr_obj,
>>  };
>>
>> +enum lookup_type {
>> +       lookup_local,
>> +       lookup_remote,
>> +};
>> +
> 
> https://www.kernel.org/doc/Documentation/process/coding-style.rst
> "
> 
> 12) Macros, Enums and RTL
> -------------------------
> 
> Names of macros defining constants and labels in enums are capitalized.
> 
> "
> Zhu Yanjun
> 
Agreed. It's original code. I just moved it ahead of the prototypes. I've been wanting to fix this
so this is the perfect excuse.

Bob
