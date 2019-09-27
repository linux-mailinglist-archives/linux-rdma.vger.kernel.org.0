Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224B6C0708
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfI0OKX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 10:10:23 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39908 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfI0OKW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 10:10:22 -0400
Received: by mail-qt1-f176.google.com with SMTP id n7so7427582qtb.6
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2019 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=8tnTIMv2UN2b0TmznJz6E04QWQKkP7V9hAIsoYEbEbU=;
        b=DDU3VLqCRGSmg1ewFCypf/zz7y73pcDmaGAcBc2mLlXfUK6QK2++clbYKdq2JEOX0T
         hz+FqQcvOiy7RxMOV/FpS2ItnEcfsZfo2dUSvXw4Ut9BfZx7aNkeS+41FJLWtiEtx8Qj
         gCBeAg+QONBegyY1OqWdEg3hbk9xuaoD48wBvN3YSBonb+t4ZBfiqyyl0Dblzgnwfpln
         9qPmqAozUZ/QXl3P07yRu3DK7fAFILL77KmOfAcZnay3vowTwvM4SBUxV2Nwj1ma79dE
         ElZjnnvTI2t+rDLnSXCMg//RoveBgw+oV98J6efDSSavlLkHnJNaK612MT9jiiUnXGWb
         oejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8tnTIMv2UN2b0TmznJz6E04QWQKkP7V9hAIsoYEbEbU=;
        b=cJ2RelmEsEN/X7k1UG5YVBvYWgkAf+poOh12r9T9jhJWqjRhzDdGo57F/btvlkmI8t
         zbD8TNEcmpMK0vTVXBHCBp3LuCxlsqzcdyM/WtX0KTkAi7X6vH2P/ek+YDimnU+yH3Jy
         EiNlptRcXlR1OfS+2s/exY836chiExn0G4QeeJUhKdvzvkNCWn51q1hSwGYLuoIp4ecW
         s9iRv7w4XUWsBqSNBiAsmZx8/WxizTmuCTZwU7mSA+RSMdQv1BCkuobquW4UqcrbAuCw
         QhH1xaKzJs81sVcqkQ5BeNHX05tLz5Pa/d1GHgwLb0YrBICRXBNzWQ479LNDj0VV3rMk
         piMw==
X-Gm-Message-State: APjAAAUb8a8/AJIjkS0qv4r98+YKzFG2rUugnWikw+wfXOu8oRFMe6P3
        kXizN4cfXdqomdcJK4/xoX5io/g1
X-Google-Smtp-Source: APXvYqyAmKX8vupGT91tpM7p2IQNgXytFQ//IeYb4gyS0hJAiqC8ZxhYU772Qdbkuuo01rIZfJTbFg==
X-Received: by 2002:ac8:550a:: with SMTP id j10mr10298402qtq.230.1569593421236;
        Fri, 27 Sep 2019 07:10:21 -0700 (PDT)
Received: from [10.48.108.64] (DATADIRECT.bear1.Baltimore1.Level3.net. [4.34.0.142])
        by smtp.gmail.com with ESMTPSA id x12sm3199509qtb.32.2019.09.27.07.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 07:10:20 -0700 (PDT)
Subject: Re: SRP subnet timeout
To:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org
References: <25ca594d-cb80-2796-01f3-50c40155b4de@gmail.com>
 <69ad7ea4-4b2f-8460-8152-ffe3505bea40@acm.org>
 <dbdc27d0-93bf-947c-0c6c-41f4a7d20385@gmail.com>
 <0068b947-a405-fec3-c0e4-6be4c78c7448@acm.org>
 <683077ff-834a-1184-fbd0-28b4e6e3eeda@gmail.com>
 <26d64d1f-2c73-aa53-233f-7a939266d354@acm.org>
From:   Karandeep Chahal <karandeepchahal@gmail.com>
Message-ID: <527bbf2c-13b2-428d-dbe1-962c48c7a827@gmail.com>
Date:   Fri, 27 Sep 2019 10:10:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <26d64d1f-2c73-aa53-233f-7a939266d354@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/19 10:50 PM, Bart Van Assche wrote:
> On 2019-09-26 08:24, Karandeep Chahal wrote:
>> The problem with adding 2 to SRP CM timeout is that it makes the SRP CM
>> timeout value far off the subnet timeout value.
>> Now you can either have a reasonable subnet timeout value and an
>> unreasonable SRP CM timeout value, or an unreasonable subnet timeout and
>> a reasonable SRP CM timeout.
> Hi Karan,
>
> Do you have a proposal for how the SRP initiator driver should be
> modified (patch)? After a patch is available the next step is to write a
> text that describes why that change will work for all users (patch
> description).
>
> Thanks,
>
> Bart.
Hi Bart,

I will come up with a patch/proposal sometime next week. Please stay tuned.

Thanks
-Karan

