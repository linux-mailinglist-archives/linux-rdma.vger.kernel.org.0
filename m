Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBD839EDDC
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhFHE5d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:57:33 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39872 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhFHE5d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:57:33 -0400
Received: by mail-ot1-f41.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so18041281otu.6
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X11vlXib9mFb0FLrAtVxRzeuM8Db7mTZ0L6vtEgAWOg=;
        b=HJHLdEof639+P2blcKlb9TtjIB8FJSw2nrfSLgCeZUawxavMh/9aTE52DV3uvgLFXO
         aAsULeJfvbLmENid2WZjPyMqtCDUMuMqjZg7K7VHO7ZzmhdHMi+d0ZMV4VYHdAcOyEjR
         JWd93llLEOhFV1yv+qQGt7y/n1NcyULencBt+/QVoWYFcXnGdZ+ikUz+SyOgQ0VUWfyq
         fLV14I3LI2q7uztm5g05l2r+COiT+mxYN5aso77pE4Av/tEq6HX2z+ZMliwWbbcK1Woi
         3eX6krv/Pl4JVMjm+JtSAn+fWjouW56ahvk5yz1A5h4LGXua66qJpqiI7Ljq6z3is6SJ
         JiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X11vlXib9mFb0FLrAtVxRzeuM8Db7mTZ0L6vtEgAWOg=;
        b=ugU0ozIJKUIME8VqlRRyf/t56vdw6Qz4soLsw0WOVxcVM2TVOrasSJtq97Pq5zqe8H
         /Ih2Vf1XE31W5Fyun5eve1T4mth4hMUSxIjnLELcjSw5cQfEORn4cCcBMKQsY8XGPmVw
         CAOPAZzkz3MU0MWrsjxxcrZe96cn8eNyFW864PbuVHRVAQQqAWXLtGeB15BJprlMmmUF
         5mnNdb9JTiNSkbAsTRaQCDUsNCUviJn8Ai2Qs+B1hemDck6ZylP32VxMQfCsMmpJP+Nl
         3Od4KM5vPO1kEuMwe6YKYocBw5rtkcAoc19eNNlsFgLqA2qBZ3naR21zF3s6XC+axSTU
         TzYQ==
X-Gm-Message-State: AOAM530ephQNHA5ICBdpRqiHTF8fDP4OuEFyApjzqzzYTsvn1r6dERkI
        WTSjiVv/60U7w2MNEuWuk5NxJN8VJEI=
X-Google-Smtp-Source: ABdhPJyd6MrweX5dj3e2tQrSS0HPhi4ON/SwLLr2I8WRy1JbrRF+3rlWwxw3BLREbIyICuVmHAnZzA==
X-Received: by 2002:a9d:684d:: with SMTP id c13mr16361183oto.201.1623128070182;
        Mon, 07 Jun 2021 21:54:30 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:c5c4:ae82:7e0d:a0c? (2603-8081-140c-1a00-c5c4-ae82-7e0d-0a0c.res6.spectrum.com. [2603:8081:140c:1a00:c5c4:ae82:7e0d:a0c])
        by smtp.gmail.com with ESMTPSA id t39sm2608110ooi.42.2021.06.07.21.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 21:54:29 -0700 (PDT)
Subject: Re: [Bug Report] RDMA/core: test_qpex.py attempts invalid MW bind
 operation
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <8d329494-6653-359b-91aa-31ac9dc8122c@gmail.com>
 <YL704NdV9F15CDtQ@unreal>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <474ad554-574c-120e-97ba-b617e346f14d@gmail.com>
Date:   Mon, 7 Jun 2021 23:54:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL704NdV9F15CDtQ@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/7/2021 11:41 PM, Leon Romanovsky wrote:
> On Mon, Jun 07, 2021 at 04:50:20PM -0500, Pearson, Robert B wrote:
>> sorry/this time without the HTML.
>>
>> ======================================================================
>> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
>> Verify bind memory window operation using the new post_send API.
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>    File "/home/rpearson/src/rdma-core/tests/test_qpex.py", line 292, in
>> test_qp_ex_rc_bind_mw
>>      u.poll_cq(server.cq)
>>    File "/home/rpearson/src/rdma-core/tests/utils.py", line 538, in poll_cq
>>      raise PyverbsRDMAError('Completion status is {s}'.
>> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Memory window
>> bind error. Errno: 6, No such device or address
>>
>> This test attempts to bind a type 2 MW to an MR that does not have bind mw
>> access set and expects the test to succeed.
> Does the test break after your MW series? Or will it break not-merged
> code yet?
>
> Generally speaking, we expect that developers run rdma-core tests and
> fixed/extend them prior to the submission.
>
> Thanks
>
>> Bob Pearson

Nope. I don't have real RNICs at home to test. But (see my note to Zhu) 
the non extended APIs do set the access flags correctly and the extended 
test case does not. The wr_bind_mw() function can't fix this for the 
test case. It has to set the access flags when it creates the MR and it 
didn't. It is possible that mlx5 doesn't check the bind access flag but 
that seems unlikely.

Bob

