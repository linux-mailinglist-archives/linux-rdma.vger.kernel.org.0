Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55FC283811
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJEOm5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJEOm4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 10:42:56 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FACEC0613CE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Oct 2020 07:42:56 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id h8so2272288ooc.12
        for <linux-rdma@vger.kernel.org>; Mon, 05 Oct 2020 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mQLk/twJ/7+XkInTz9BSG8tie/lsTknC4MNJPn+oH5s=;
        b=erigDT9rKn+KJE+RwjNsWH0M51AjaNwta4zPB11w0f0dnvo2i3s3hfc8KvyVbo/V0+
         0OKKmnLeAGvequ7dtQpA3Ng9kTR8Ppy9UlbEA5X2LxfIOHBBLj3Hl/wu4IexRr0myLIH
         iAahcWSS6gzPotlytWYD0ABOdlurvkq0UZdmdLeUEvqAJPd9h8eGSK94r84BS9eM/dP2
         k5Yx06g4IW72qX7KGihMtJVsA/x6dIOspK+FPRb6Q8TvhIsXIdRELhPLWSzlIctCRg6A
         nwEYHdAcINFj4hS3Hz/Zm710NaTfFGIujZezSrzQZxkdfzAqwGAQsYK+ppShUyDboP1G
         wGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQLk/twJ/7+XkInTz9BSG8tie/lsTknC4MNJPn+oH5s=;
        b=bc9vTtNIqba6n4ReEkwdG5EGtQa/MzVPG8pKDC1vv9jbNheaIYFlMwOrGj49u6blM6
         OWqCqe6YN5Ta2OKQbKO/rMxsCNqMvK9sIlqqhd/KZdJqHXhJH7Hkf7zTaTgGQ1MG8wKS
         ttTAmRCDqfw+cvO+2v7LdOBeAnhMIvPFgAnW+jCVZW3RZOE2w9Hr/AYGyBl1kOSgKfsQ
         Fd0ghMpRDtalOrAh5anMo4jBB6SYSx8Oe15/OPfRce2OFd/Kw5XNotgnJjAdC/m3/e14
         XDJzfOyV9oOV+ugod8jCHzCNhq11VHzVXMGoM+8pL7O8HZRnpo9BLHq70xYu5sImyhCQ
         08nA==
X-Gm-Message-State: AOAM533lCFaO+1Rc8UIzCdaNxNcWzN+iSlr9OZ66/QP6CZnstg9BUO+R
        JiFcdZoiiXQTBnVwB796EzeISaKZD8I=
X-Google-Smtp-Source: ABdhPJzABTquKWbHpdYpXl7ymmmo9HZ7dM9qenloR0P+JlbcpBkhD+TuOz0IJtR1a+vqzGRNt11LkA==
X-Received: by 2002:a4a:d485:: with SMTP id o5mr12529381oos.60.1601908975733;
        Mon, 05 Oct 2020 07:42:55 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:8d47:e8b9:65b9:9466? ([2605:6000:8b03:f000:8d47:e8b9:65b9:9466])
        by smtp.gmail.com with ESMTPSA id n10sm43357ooj.19.2020.10.05.07.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 07:42:55 -0700 (PDT)
Subject: Re: [PATCH for-next v7 10/19] rdma_rxe: Add support for
 ibv_query_device_ex
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
 <20201001174847.4268-11-rpearson@hpe.com>
 <20201003232153.GM816047@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <5819b623-c691-a9f3-e8a0-242b9f6bbf69@gmail.com>
Date:   Mon, 5 Oct 2020 09:42:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201003232153.GM816047@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/3/20 6:21 PM, Jason Gunthorpe wrote:
> On Thu, Oct 01, 2020 at 12:48:38PM -0500, Bob Pearson wrote:
>> Add code to initialize new struct members in
>> ib_device_attr as place holders.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe.c       | 101 ++++++++++++++++++--------
>>  drivers/infiniband/sw/rxe/rxe_verbs.c |   7 +-
>>  2 files changed, 75 insertions(+), 33 deletions(-)
> 
> This series should eliminate this patch and notably change the others
> 
> https://patchwork.kernel.org/project/linux-rdma/list/?series=359361
> 
> Can you take a look that it works for this?
> 
> Thanks,
> Jason
> 

I'll take a look. Let me know if/when you take it into for-next. Should be easy to adjust for these.
Currently I am working to try to improve performance. I have replaced tasklets with work queues. Low
QP count performance is not changed much but it should help high QP count performance. At the moment I am
trying to optimize UD since it is a lot simpler. Once that is done I want to look at core affinity.

Bob
