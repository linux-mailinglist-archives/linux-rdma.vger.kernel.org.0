Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446CA7D5959
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 19:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjJXREx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjJXREw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 13:04:52 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D88C2;
        Tue, 24 Oct 2023 10:04:50 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so1466792fac.0;
        Tue, 24 Oct 2023 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698167089; x=1698771889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZOuYQtLmfcXzSVfHqSRbgJNw20LhS1+3cK891c4fcU=;
        b=jcBrLiEf53WJWafInLUtkDTpNg+HNJb2mF/aJy6zOisM4Rok8aVNw+p0Pwq+VUpO0H
         BL628eW3cHYinJ3ZcO3NUafF/JSc1Fit5QLwYCN48bFn02iXFuTIfQxUoGflFD4NyTk9
         kVXKes0N6jiY0QrgyLLIi5DnZnhHiohfsXnH0wleJB7Wgz2mi0s+7qkQd9mYVjqZMKJR
         D55Qk1FmBxkazxSa9+z364Xw7rQ+vQONGA/TFnBesmSbcXsaCPTizamiKX3ERP9Y+5u8
         1BCDyD088w4Cvelk1kyjDISPqMT9KO2BRRk2/Kk6FRyDK58k4seAcPCkvwWP7wMzcOpf
         /zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698167089; x=1698771889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZOuYQtLmfcXzSVfHqSRbgJNw20LhS1+3cK891c4fcU=;
        b=iodvMCY0PfyeWFyT2ojiQBgkaH3cOvahrH4ZSAgcc5AkcXQNil0w9phyGgduOxPVcs
         /+MWLltFDy5Agt+DrWASDp/RQuXEnQiGsPghBZ1Nz/jL2A16Ylj0Y4HaX2XPZbkgaQag
         uRK5TEuv/Jo6cMUzQlXD2scmSP7Lzh2R+CBxWd1z5mJvKpgn/H61XzSGMg++DfYAJDAa
         qzQD7FkpdnkAUdaBP7TgIKFxp39KmpOKcDX/mKf1FgNEMRvxplf+FrwFUMaiVzOKdRF5
         fYQtVCv6dxjDQ4xn+KlbgwoiXrNDBcGY464Xk58PPIemykHiqte6wAnj0Y0c+n/RL/iH
         8LbQ==
X-Gm-Message-State: AOJu0YyuIhEOi9I5x9l/tvVimMbGk2dQYtYljyz8bnYwC8s8ynSQ78KP
        EiOru5zbnp5xftybQCiXUbo=
X-Google-Smtp-Source: AGHT+IErFW7kHngINKDMEYohK3rgVPZMfEZ2IxWv+IqFG/CL/mD5Z7y15p8ziSSAXQuD0cYs6FaGWQ==
X-Received: by 2002:a05:6870:3c8d:b0:1ea:ca54:e51a with SMTP id gl13-20020a0568703c8d00b001eaca54e51amr16214102oab.45.1698167089551;
        Tue, 24 Oct 2023 10:04:49 -0700 (PDT)
Received: from ?IPV6:2601:284:8200:b700:d8d6:5f8f:cf7b:edca? ([2601:284:8200:b700:d8d6:5f8f:cf7b:edca])
        by smtp.googlemail.com with ESMTPSA id g15-20020a05663811cf00b0043a1b74a0e3sm2893089jas.90.2023.10.24.10.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 10:04:49 -0700 (PDT)
Message-ID: <4d20e1bd-4b60-4bae-92f9-6bd7814a27d0@gmail.com>
Date:   Tue, 24 Oct 2023 11:04:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 3/3] rdma: Adjust man page for rdma
 system set privileged_qkey command
Content-Language: en-US
To:     Petr Machata <petrm@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        huangjunxian6@hisilicon.com, michaelgur@nvidia.com
References: <20231023112217.3439-1-phaddad@nvidia.com>
 <20231023112217.3439-4-phaddad@nvidia.com> <87zg0856io.fsf@nvidia.com>
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <87zg0856io.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/24/23 10:09 AM, Petr Machata wrote:
> 
> Patrisious Haddad <phaddad@nvidia.com> writes:
> 
>> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
>> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
>> ---
>>  man/man8/rdma-system.8 | 32 +++++++++++++++++++++++++++-----
>>  1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/man/man8/rdma-system.8 b/man/man8/rdma-system.8
>> index ab1d89fd..a2914eb8 100644
>> --- a/man/man8/rdma-system.8
>> +++ b/man/man8/rdma-system.8
>> @@ -23,16 +23,16 @@ rdma-system \- RDMA subsystem configuration
>>  
>>  .ti -8
>>  .B rdma system set
>> -.BR netns
>> -.BR NEWMODE
>> +.BR netns/privileged_qkey
>> +.BR NEWMODE/NEWSTATE
> 
> What is this netns/priveleged_qkey syntax? I thought they are
> independent options. If so, the way to express it is:
> 
> 	rdma system set [netns NEWMODE] [privileged_qkey NEWSTATE]
> 
> Also, your option is not actually privileged_qkey, but privileged-qkey.

yes, and the command lines below show 'privileged qkey'

> 
>>  .ti -8
>>  .B rdma system help
>>  
>>  .SH "DESCRIPTION"
>> -.SS rdma system set - set RDMA subsystem network namespace mode
>> +.SS rdma system set - set RDMA subsystem network namespace mode or privileged qkey mode
>>  
>> -.SS rdma system show - display RDMA subsystem network namespace mode
>> +.SS rdma system show - display RDMA subsystem network namespace mode and privileged qkey state
> 
> Maybe make it just something like "configure RDMA system settings" or
> whatever the umbrella term is? The next option will certainly have to do
> something, this doesn't scale.
> 
> Plus the lines are waaay over 80, even over 90 that I think I've seen
> Stephen or David mention as OK for iproute2 code.

a few over 80 is ok when it improves readability; over 90 (with the
exception of print strings) is unacceptable.

