Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670BF7D5949
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 19:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjJXRC0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 13:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjJXRCY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 13:02:24 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF8F122;
        Tue, 24 Oct 2023 10:02:22 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a66a7fc2d4so176736839f.0;
        Tue, 24 Oct 2023 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698166942; x=1698771742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hy3+CRPCNWCZ0YKD6OUXTpD5Qmway7xYPuUglUxE3qo=;
        b=ZYziswNj+BpZnF7wRZzwPKEYIuw2ZSnd//0KRfExFWFgKKWn7ywuBBCCRKF2CNmz4H
         hUbRO+A3oXdV8Pr0vDAyF4te6oK/HvKY0FhZ179zz2/flYnA4O/ftkGLrQHlTjpzRLLJ
         QcFjZG+lvi0MrwGPSvv3wnBiva7iQ5ToCEvgOTOGTyPNu+wyVwMz4zKVcPfZRg6AvV2O
         ZVEo+X5+Tqn/edtOD/JYVgGMv7VfluMHzW8gPfq/+0sbXBNhO9l+GS09HSGiGk94L3Zm
         iLIu5qd6Hy7YVsxKHTPlWnlJxVtbRIdJkUXpAlBH/Mh2zR/O9d+EkeTbBuftIQFUc+83
         N8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698166942; x=1698771742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy3+CRPCNWCZ0YKD6OUXTpD5Qmway7xYPuUglUxE3qo=;
        b=faXm3DWuhmAEhXmMYwseSdopw6BM0qNejFJQTKy1FsCECBQgVORCcRGBnoceaOYprd
         mmN3tqVWEzDSoIMpyDYo/ugjL7WpsxIeYUhq6LtF3bTmtc0fzLZxJbZfhlQ+ybih2Asy
         FPdyfe29wJN7IJ4149EHZDK+2M/GtZONxNjD6KVidnZpNI0hojje/RRwI9jH+zNJQnYs
         2q6yBYOyEtxt5iKs0frtTc7E/Q12U7a9NCyh0mRxESvSRteAo1xV4Jcyh0wYFCGpXc/a
         2sZRxqfMM9eTlg9r2FIi5rZmC+XQvfMu8tdxkwLhVzqsbwsU0A1KRMBA5yqGa5fkBwzP
         dD/w==
X-Gm-Message-State: AOJu0YwkiftbYSMXW7vx4YvOegcWUPUwcnR5lCR1mN2C1cOfxJ63EvXn
        RraV6UytY6VhepJE6jD/ggo=
X-Google-Smtp-Source: AGHT+IHI4V/n+ADLtBEqfl2xmuUrCXu2vYEW+5AUBwfIlb3BtAEb99Q1BMOcudP1tfe86Fwy00bnWw==
X-Received: by 2002:a05:6602:15c2:b0:791:1e87:b47e with SMTP id f2-20020a05660215c200b007911e87b47emr18096321iow.15.1698166942029;
        Tue, 24 Oct 2023 10:02:22 -0700 (PDT)
Received: from ?IPV6:2601:284:8200:b700:d8d6:5f8f:cf7b:edca? ([2601:284:8200:b700:d8d6:5f8f:cf7b:edca])
        by smtp.googlemail.com with ESMTPSA id y16-20020a6be510000000b0076ffebfc9fasm3202921ioc.47.2023.10.24.10.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 10:02:21 -0700 (PDT)
Message-ID: <6a1632a4-28fd-4fdd-b9ff-34dd2f0bba88@gmail.com>
Date:   Tue, 24 Oct 2023 11:02:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 2/3] rdma: Add an option to set
 privileged QKEY parameter
To:     Patrisious Haddad <phaddad@nvidia.com>, jgg@ziepe.ca,
        leon@kernel.org, stephen@networkplumber.org
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        huangjunxian6@hisilicon.com, michaelgur@nvidia.com
References: <20231023112217.3439-1-phaddad@nvidia.com>
 <20231023112217.3439-3-phaddad@nvidia.com>
Content-Language: en-US
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <20231023112217.3439-3-phaddad@nvidia.com>
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

On 10/23/23 5:22 AM, Patrisious Haddad wrote:
> diff --git a/rdma/sys.c b/rdma/sys.c
> index fd785b25..db34cb41 100644
> --- a/rdma/sys.c
> +++ b/rdma/sys.c
> @@ -40,6 +40,17 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
>  				   mode_str);
>  	}
>  
> +	if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
> +		uint8_t pqkey_mode;
> +
> +		pqkey_mode =
> +			mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);

just make it mode so it fits on one line.

40 characters for an attribute name .... I will never understand this
fascination with writing a sentence for an attribute name.

> +
> +		print_color_on_off(PRINT_ANY, COLOR_NONE, "privileged-qkey",
> +				   "privileged-qkey %s ", pqkey_mode);
> +
> +	}
> +
>  	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
>  		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
>  

keep Petr's reviewed-by tag on the respin.
