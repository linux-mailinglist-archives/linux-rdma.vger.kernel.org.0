Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F158F7D712E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjJYPtU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 11:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJYPtU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 11:49:20 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384B399
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 08:49:18 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2e73a17a0so3932505b6e.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698248957; x=1698853757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Ar+YkYcCFMkiXjFuqJMbMdTemjdrG07286mVYWaLdQ=;
        b=Ob4vtlUTycMFXoQjuIX9q2Q/vc7leWnJ2WuQy+kX32BHA2+iSiSE5fwuAt4nV5Ipxw
         bx+7PN0bYd1RVG5aikx+ajXyeqQLqthb0/ZFB+Mf/BQaSDmu8pJretkgxQuRV9JuEjSU
         ttPVSZpojm6z30eHZ/lu6SbNgmkBAhwaB13xpgA39nv7j4/iT/TDVb5KdQFSNLfJ43Ez
         FqKbI6mz38F/5oEcqJzemp4cZY3D7t187hdVKQpkwRm/KTFsv78AZvz0i0yw1T/P5qm5
         uMKU+xHACo0HugDRDKAbevrs9O95SELqR+CNmC4r1C8mSqWxxhNZBA/DtqL7yWrKHBB5
         oXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698248957; x=1698853757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ar+YkYcCFMkiXjFuqJMbMdTemjdrG07286mVYWaLdQ=;
        b=JrJg+uSSi6O9C9ExSJxHOfY/QBWIh491hRbGeVlRJhhJd7gnZlO9bC7jUrIp+Y9pMw
         /9LziSLT5KSqC8E+g5N4eD2lwlKvULVHXKoEqqcM7VENJD1vvRptO8iZ3VDeknR4YeN/
         wnD2j+wUNForALP5WLZxiO2UvjrjUDPKzK5teppZqRXCsnaie3/A1YuIi/WkFgxUISPb
         +au4z8P4lYG6LaQbT6BnFMRlf33KNATIug9R3Zwaha5OuSMMXL77k8jUXXV3ANE2GYfw
         7wHwOw8YHKjgp7X1mEF9wSSP3FkFzxU4merpHjr+GyjI4pEvFLis95Bhzix0y0zV6NrG
         9f0A==
X-Gm-Message-State: AOJu0Yz+D28JKptMQmGom0VmEYApFN89j6te/pbK+9+M1CU8EatzD3u0
        xt9wP+qqgbW4IuLersGtihL2QaVuKiTJYQ==
X-Google-Smtp-Source: AGHT+IGG9BlCSuddIcgqLx5hBDXVYQQnqe0teqj2jV3owMVOaJYp2yZzJJGZOSMJk7VyucBfiJksKA==
X-Received: by 2002:a05:6808:14cc:b0:3b2:f2a8:1a4c with SMTP id f12-20020a05680814cc00b003b2f2a81a4cmr17666760oiw.44.1698248957436;
        Wed, 25 Oct 2023 08:49:17 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:2ea4:90d:1bd0:54e7? (2603-8081-1405-679b-2ea4-090d-1bd0-54e7.res6.spectrum.com. [2603:8081:1405:679b:2ea4:90d:1bd0:54e7])
        by smtp.gmail.com with ESMTPSA id 24-20020aca2818000000b003b2daf09267sm985426oix.48.2023.10.25.08.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 08:49:16 -0700 (PDT)
Message-ID: <ec603876-6872-4e8e-9490-e28f7cca8c6d@gmail.com>
Date:   Wed, 25 Oct 2023 10:49:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: modify srq pyverbs test (new?) failing for the rxe driver
To:     Edward Srouji <edwards@nvidia.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
References: <401221fd-b41d-4db9-be22-b1af17b0d456@gmail.com>
 <99cafadf-a7c5-4217-9162-38fb6f8b56bf@gmail.com>
 <b4ee7c64-720e-5580-ce25-5d7c7991fca4@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <b4ee7c64-720e-5580-ce25-5d7c7991fca4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/25/23 06:29, Edward Srouji wrote:
> You're right.
> I've patched the test and pushed it Upstream (see PR link below [1]).
> Please notify me if you're still having an issue after applying the patch.

Will do. Thanks!

Bob
> 
> On 10/24/2023 8:47 PM, Bob Pearson wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 10/23/23 17:47, Bob Pearson wrote:
>>> Edward,
>>>
>>> There is a test which may be new since this failure didn't happen
>>> before. Modify srq tries to set max_wr to 4094 but the rxe driver
>>> rounds this up to 2^n-1 or 4095. My understanding of the IBA
>>> spec is that queue sizes can be set larger than requested.
>>> Also this same test tries to change max_sge using the same
>>> MAX_WR mask bit. There is no mention (as far as I can recall)
>>> in the IBA spec of being able to change the max_sge setting.
>>>
>>> Is this really the correct behavior?
>>>
>>> Bob Pearson
