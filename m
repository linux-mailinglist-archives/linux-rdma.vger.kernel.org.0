Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5615E37564D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhEFPOI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 11:14:08 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:36553 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbhEFPOH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 11:14:07 -0400
Received: by mail-pl1-f174.google.com with SMTP id a11so3560491plh.3;
        Thu, 06 May 2021 08:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pRnGiGHsKWfVBqXpARWMO9JiAiHKrow49Ba7ktw3qHY=;
        b=d45NtWU3rq6RVb+Z1EsMxS4eFHS0RWLIJta2qtEB59fL9RTxZ32QPs2B3UlKcadEsV
         G3YeWl5zTGSK4XgugNPahs8XEzzpDGr+sWFcxV65WsLNLLACVIPLdUUf4YJFPrvoG/Jv
         8e9DnWB2vNvTevaOuvCH5eBLs/A5fbryJZkJq/oExx9i3pY4o6gScOtWmzTrmX9Mp3FP
         PUlvplZ7gGQXUuiE5Srr3ktmn+AmfgfL+KANaSI6d7qu8Uo9SM/v3QCuCojJjLPBs2m7
         oSO4Mb08I+MjZqTAxRDfnCm2Ra2BBKAFd+sMTy7/m/04bthh6JGX4cl9+TjIDHDGfZeu
         mgTg==
X-Gm-Message-State: AOAM532Jp2l1xtSh7LbnyNCfLXSN1DTr+gpG3foC2H80hT3V5pDdlvWZ
        CIJ3OWWnL3WMNqtdCSyDG3uCf0QRLpI=
X-Google-Smtp-Source: ABdhPJw8IsXYWTECgE+bP7mQDAdCUNb17MCajwCifVpimtINEmO1pgVLYSewwp8XbqX6rR6G2E0G/Q==
X-Received: by 2002:a17:903:22c9:b029:ed:7d2a:8d13 with SMTP id y9-20020a17090322c9b02900ed7d2a8d13mr5001619plg.72.1620313988091;
        Thu, 06 May 2021 08:13:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c791:bbbb:380d:7882? ([2601:647:4000:d7:c791:bbbb:380d:7882])
        by smtp.gmail.com with ESMTPSA id j12sm2374018pff.49.2021.05.06.08.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 08:13:07 -0700 (PDT)
Subject: Re: [PATCH] ib_srpt: Remove redundant assignment to ret
To:     Leon Romanovsky <leon@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, nathan@kernel.org,
        ndesaulniers@google.com, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <1620296105-121964-1-git-send-email-yang.lee@linux.alibaba.com>
 <YJPUQkQCS86mS9gw@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b67909dc-c5d6-a8ce-5bea-36b1c7a2b04b@acm.org>
Date:   Thu, 6 May 2021 08:13:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJPUQkQCS86mS9gw@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/6/21 4:34 AM, Leon Romanovsky wrote:
> On Thu, May 06, 2021 at 06:15:05PM +0800, Yang Li wrote:
>> Variable 'ret' is set to -ENOMEM but this value is never read as it is
>> overwritten with a new value later on, hence it is a redundant
>> assignment and can be removed
>>
>> In 'commit b79fafac70fc ("target: make queue_tm_rsp() return void")'
>> srpt_queue_response() has been changed to return void, so after "goto
>> out", there is no need to return ret.
>>
>> Clean up the following clang-analyzer warning:
>>
>> drivers/infiniband/ulp/srpt/ib_srpt.c:2860:3: warning: Value stored to
>> 'ret' is never read [clang-analyzer-deadcode.DeadStores]
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
>>  drivers/infiniband/ulp/srpt/ib_srpt.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
> 
> Fixes: b99f8e4d7bcd ("IB/srpt: convert to the generic RDMA READ/WRITE API") 
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Reverting commit b99f8e4d7bcd and handling queue_*_rsp() errors in the
LIO core probably would be a better approach. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
