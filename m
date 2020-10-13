Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E3428D023
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgJMOWz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgJMOWz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 10:22:55 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30179C0613D0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 07:22:54 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id f37so94453otf.12
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w2uVrQnMXCdczkxQuHKHgPFM/qz5f9lfQz9hhJd62E8=;
        b=Ae0aAlWtReElyUfYsniPv/sElE6bsVmqPZGTi+HNZ2hgaHwyS18teLSVGX9XTm/c9c
         l+u6xCbgHR3QbgrArWZQ/kpVqt8SDaLAAylJ7wN8kSMG2SUnqtN0d2prMB3GYIEtJoGY
         t0ZJhvfjDeSVAOrfZLVkpiswh/+Qq6QMlqGMWy10VA7TYymA9sFVY4Zs3PzGmVaaNQh5
         AwBQsuA52zXSfRMMWCJH6YXqi0Sf+q3EmgwbkKm9NWmcXI38Z5ovHVT7uKL2BkhyEMX1
         XQbXESviTqdt/av9Yz8aI++V74cq5QhG62UwecYHwqfkM/xVkBBCx1idMrB/QPMJwEGt
         hBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w2uVrQnMXCdczkxQuHKHgPFM/qz5f9lfQz9hhJd62E8=;
        b=Mn4oqq8uLmVGO0iJivwEO2fldB+/V90vwdWjSwq3uO0cagmgLaCPIpoy/19ASbU4D+
         lyvRMSjla9O6JtRCvmtB8hh6eB/rwDgUISei2SLm2wNFrGdj7g168WQ0jdWi2BAWDYiH
         eCrKuuh2vFKAiRB6zBwoLuLm0XQH/BK/GuTHrpJcIpRQW+RvSUFw42VVOy1v4dLTmQqa
         Fqp9vxA/22CU+XBUSHIymovJgtEx5HfHJQlpx9SlB0GmPrxPQiyAy6+tCCPUiXHWl8vG
         iCA/Phyy4nHvZqUwsC1iBhCKmkbv7o5YLF9gR0a0ho1RhP1E8NLtAWwHfQpseLIk8aRk
         x2Hw==
X-Gm-Message-State: AOAM531027g+DEgUe04lVu/rDJph5m2Tolp0rbeqdICfas1cJAPI7aJD
        DJi7a1VNz0RAL8KUnVFJ/Uo=
X-Google-Smtp-Source: ABdhPJzPDepVcQwf4neF3hetjt4Khgv6J7v5V8HpVGIiFivxY8/Fz11QaF2UHjEkwdWk8eiR2KcbpQ==
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr22693473otn.44.1602598973487;
        Tue, 13 Oct 2020 07:22:53 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:d1f8:586d:5100:2ad4? (2603-8081-140c-1a00-d1f8-586d-5100-2ad4.res6.spectrum.com. [2603:8081:140c:1a00:d1f8:586d:5100:2ad4])
        by smtp.gmail.com with ESMTPSA id 91sm10066080ott.55.2020.10.13.07.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 07:22:53 -0700 (PDT)
Subject: Re: py verbs tests
To:     Edward Srouji <edwards@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
References: <1c6511ba-e92e-c285-e00d-f2dba04a6747@gmail.com>
 <20201008190708.GF4734@nvidia.com>
 <585b94bf-cd80-f135-0823-b68c7ce9fcdb@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <57ecdc40-9c71-a543-a692-032c19f95e08@gmail.com>
Date:   Tue, 13 Oct 2020 09:22:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <585b94bf-cd80-f135-0823-b68c7ce9fcdb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/12/20 5:31 AM, Edward Srouji wrote:
> 
> On 10/8/2020 10:07 PM, Jason Gunthorpe wrote:
>> On Fri, Oct 02, 2020 at 04:34:22PM -0500, Bob Pearson wrote:
>>> I am currently trying to figure out why one of the pyverbs tests is failing.
>>>
>>> I added a check implementing C9-205 (p 419) of the IBA spec. I requires that a responder receiving a packet longer
>>> than the receive buffer or the PMTU shall be silently dropped. I.e. a class D error.
>>>
>>>      C9-205: Before executing the request, the responder shall validate the
>>>      Packet Length field of the LRH and the PadCnt of the BTH as described
>>>      in 9.8.3.2.2: Responder - Length Validation.
>>>      The following characteristics shall be validated:
>>>      • The Length fields shall be checked to confirm that there is sufficient
>>>      space available in the receive buffer specified by the receive WQE.
>>>      • The packet payload length must be between zero and PMTU bytes
>>>      inclusive in size.
>>>      If a packet is detected with an invalid length, the request shall be an invalid
>>>      request and it shall be silently dropped by the responder as specified in
>>>      Section 9.9.3 Responder Side Behavior on page 435. The responder then
>>>      waits for a new request packet.
>>>
>>> tests/test_cq_events.py passes PATH_MTU = 1024 in the modify QPs verb for RC and XRC but not UD.
>>> This should be a required parameter as part of the primary destination address but is not getting
>>> set for UD. The test then proceeds to send a 1024 byte payload to the destination and for UD hangs
>>> waiting for the completion.
>>>
>>> I don't want to mess with these tests because I am a poor python coder. Is there some reason why it is
>>> OK to not set the PMTU for UD QPs?
>> Edward is the person to ask about the tests..
>>
>> It seems like you are right and it should be set for UD too, if it is
>> not set what is the default?
>>
>> Jason
> 
> AFAIK PATH_MTU (when modifying a QP) is valid only for connected types (e.g. RC/UC etc.). It's not valid for UD. If you look at the code you may see that modify_qp does not update the PMTU according to the user attribute.
> 
> There is a default PMTU set for UD (usually it's the maximum PMTU).
> 
> Edward.
> 
> 
Totally agree. Sorry for the wild goose chase. 
