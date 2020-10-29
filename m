Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83C929F299
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 18:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgJ2RJe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 13:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgJ2RJe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Oct 2020 13:09:34 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4492FC0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 10:09:08 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w191so3795533oif.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2AwA1hxFj/0BuLWtos4w6V8NcCJAERGAQVlsu77HYgw=;
        b=Ururn9CmqZ+XWzAGb7upSdzW/1ydgkJKq/2jdwHFRt5miG90OZz8d2hcJRa0VxfDyz
         APeLzfc4WGNHSMol+fId5cnCs3yNasFj7g9uM/yhjCgYmplgljdaAlI1jux/sSK27Z7P
         MErx/DVXZtoWdhJqsdaYhonnrZKAMEhUPnsDiR2ERaOfjfgxglOm0mBfu9FIqQ+Cjvc5
         hDc6nQslaUSxFkPd9Kpq9klYf0pX44WSMqIni+dioDj6bASU7VWAEWGUSfhAJBeaeSnb
         l4SlvqaH4i6CiKMAVIBqoP4nfuK/4kTxXF5rneRLnTAGLhGhxIIfaoQErZFPJ3Zkhnhb
         gReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2AwA1hxFj/0BuLWtos4w6V8NcCJAERGAQVlsu77HYgw=;
        b=qJnDvGyVz2ITqMY+8jVYNTErmbpPf9utiPjFIiaDJ683EEj9j5LhR2QZJ1C7VwYT/u
         DemrThsyV1GAJZ0oGjdhETI7pgi6qGO702iny4Ur6HrfQGRZ/vm7vm7uYnrpbbWAapCw
         rq0WOrDA3Vd9ArIPjiSpnSXleY/MaX4zl5/PqvtCvptJci9vOUAZMbkaC4jv++lQDoTe
         JxQ/9ecamRCtxDiMNG+pYXTdPy0WNNueDDPDY20qlY9/iHUmQtEbYo8E1IuzE9d7DW6U
         ZMMbZfofrCVKPz/lUAr5SJqMNEOBQf5fvLKBlci++rpWn6l5aDSVgMD52irbwR4+Dlkf
         ytCw==
X-Gm-Message-State: AOAM533CtCZhH7gqKnKPx0n49TBEHIONpiR9Vpo7398WliQgrwuIqPE6
        ddRedlxFe6HhYH/ihoXD3pk=
X-Google-Smtp-Source: ABdhPJy40ynpriJiF2DsqB7QsPWepQZenqRMV5q2KYH+UzJidWxwF3eT3K3Y88vSmXpERBAKCa+vPw==
X-Received: by 2002:aca:3b0a:: with SMTP id i10mr150994oia.167.1603991346992;
        Thu, 29 Oct 2020 10:09:06 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:c0b7:d10f:c08b:770f? (2603-8081-140c-1a00-c0b7-d10f-c08b-770f.res6.spectrum.com. [2603:8081:140c:1a00:c0b7:d10f:c08b:770f])
        by smtp.gmail.com with ESMTPSA id a80sm777706oib.2.2020.10.29.10.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 10:09:06 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe fixed bug in rxe_requester
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20201013170741.3590-1-rpearson@hpe.com>
 <20201029092754.GE114054@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <329c2fec-926d-b2de-2049-650503db8893@gmail.com>
Date:   Thu, 29 Oct 2020 12:09:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201029092754.GE114054@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/29/20 4:27 AM, Leon Romanovsky wrote:
> On Tue, Oct 13, 2020 at 12:07:42PM -0500, Bob Pearson wrote:
>> The code which limited the number of unacknowledged PSNs was incorrect.
>> The PSNs are limited to 24 bits and wrap back to zero from 0x00ffffff.
>> The test was computing a 32 bit value which wraps at 32 bits so that
>> qp->req.psn can appear smaller than the limit when it is actually larger.
>>
>> Replace '>' test with psn_compare which is used for other PSN comparisons
>> and correctly handles the 24 bit size.
>>
>> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_req.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>> index af3923bf0a36..d4917646641a 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>> @@ -634,7 +634,8 @@ int rxe_requester(void *arg)
>>  	}
>>
>>  	if (unlikely(qp_type(qp) == IB_QPT_RC &&
>> -		     qp->req.psn > (qp->comp.psn + RXE_MAX_UNACKED_PSNS))) {
>> +		psn_compare(qp->req.psn, (qp->comp.psn +
>> +				RXE_MAX_UNACKED_PSNS)) > 0)) {
> 
> qp->comp.psn is u32, so you are checking that
> qp->comp.psn + RXE_MAX_UNACKED_PSNS != 0, am I right?
> 
>>  		qp->req.wait_psn = 1;
>>  		goto exit;
>>  	}
>> --
>> 2.25.1

First, qp->comp.psn is a 24 bit unsigned quantity as is qp->req.psn.

RXE_MAX_UNACKED_PSNS is a reasonably small number e.g. 128 for now.

So qp->comp.psn + RXE_MAX_UNACKED_PSNS which is a 32 bit number never wraps to zero and remains in the
range [RXE_MAX_UNACKED_PSNS, RXE_MAX_UNACKED_PSNS + 2^24 -1]. The upper limit will not wrap back zero unless
RXE_MAX_UNACKED_PSNS is > 2^32 - 2^24 which would be a grossly unreasonable upper limit. You would have long
since run out of memory.

psn_compare(a, b) = (a - b) << 8 and is a signed 32 bit number.

This correctly determines the magnitude and sign of the difference between a and b as long as that difference
is less than 2^23.

Bob
