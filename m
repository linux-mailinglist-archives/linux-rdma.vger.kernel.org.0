Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F905495A1C
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jan 2022 07:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348675AbiAUGrR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jan 2022 01:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348346AbiAUGrR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jan 2022 01:47:17 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330AAC061574
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 22:47:17 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso10636321otr.6
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 22:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yGFTkB10iBrHiX8rOrzfCHiDnxt7SN/dBC3FrWsXoEg=;
        b=aKDd/7CHi81+mVoICviy9xqA17eEB0E8ADU8e9xE1ek/yJnYY/5bD6tbkWgsJIpUYd
         sPs1YbGOf5nSUbX64prdlER2BF2WtB4g5EEu/4T+KgYw3jFcCa/RnA+m8XC+ySTzyXAj
         nkNjW//d0Zo3ayGWt1s7rJtmczDkxFbuFwq9aEvl4PvZoDnHZmIx9Q3FwCceDx8bChUu
         YmfXJiUCQuX/7eEkKr6U5C6z1xf9pc9VNcAU8Z9wig+RLHSI69/A20ffoSV9JR1Xj+JD
         2mRvPGRp8b82CgFHThPP4OlxQSJ7577L0z9M8lFCbHcU9wc9wctqLmS1I3jK6U4wABqt
         NmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yGFTkB10iBrHiX8rOrzfCHiDnxt7SN/dBC3FrWsXoEg=;
        b=ieUfkpgT8I+UN6Uj8fxUMkVLFJOCR6kY/NSZuAhBqyuV+BMmMfG+ZuVWVZw/pKo1YS
         IbvxWoyUa2X/8a54c4UYgE9CWhKYc+s13OKa8UtpVxC/UflHaXu/4vFwS12MVt8mHvYu
         0jIqmwnLGVjVesIYdJGb//KDoL5pWu5tznGivNRTPBIsq75Fj9rA6kAiW1KAsWVB+RZv
         DEtFx6tuL44Cd8Y8mtubc7qS5jtw34z8/lyliRtqK4GZWp+joace9ZVU/IsKvBZXBqL0
         woDQkDrDj5o0duWtLsWQk2isWNeofm7pgUy2ipATctxSg3rW+PPJ4B9aP5ldsuGwsHb8
         Z9Kg==
X-Gm-Message-State: AOAM532NYFckM7SiCLpYj/8d2jrh/HhpZ8WXg729bzmIeTt7hFgE7Q7Y
        KHSuID2H7HQ+4wXPtZmJ785rBLUt5Wc=
X-Google-Smtp-Source: ABdhPJxKgfwzJQEF/zxhSvG63hdRq1XT0tp4lHyF2RptC9reiOpYGGFsBx9Ci5uSbzWFACPQ2SePSg==
X-Received: by 2002:a9d:7492:: with SMTP id t18mr1866787otk.182.1642747636498;
        Thu, 20 Jan 2022 22:47:16 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id n65sm744026oia.18.2022.01.20.22.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 22:47:16 -0800 (PST)
Message-ID: <d4f3c2f1-d805-c80a-3182-a218c86d7950@gmail.com>
Date:   Fri, 21 Jan 2022 00:47:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH rdma-core v2] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Content-Language: en-US
To:     Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, leon@kernel.org
References: <20220121062222.2914007-1-yangx.jy@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220121062222.2914007-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/21/22 00:22, Xiao Yang wrote:
> The expression "cons == ((qp->cur_index + 1) % q->index_mask)" doesn't
> check the state of queue (full or empty) correctly.  For example:
> If cons and qp->cur_index are 0 and q->index_mask is 1, the queue is actually
> empty but check_qp_queue_full() reports full (ENOSPC).
> 
> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  providers/rxe/rxe_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h
> index 6de8140c..708e76ac 100644
> --- a/providers/rxe/rxe_queue.h
> +++ b/providers/rxe/rxe_queue.h
> @@ -205,7 +205,7 @@ static inline int check_qp_queue_full(struct rxe_qp *qp)
>  	if (qp->err)
>  		goto err;
>  
> -	if (cons == ((qp->cur_index + 1) % q->index_mask))
> +	if (cons == ((qp->cur_index + 1) & q->index_mask))
>  		qp->err = ENOSPC;
>  err:
>  	return qp->err;
> 
This is fine.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
