Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85F7C9E09
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 05:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjJPDyV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Oct 2023 23:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJPDyU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Oct 2023 23:54:20 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DEAD;
        Sun, 15 Oct 2023 20:54:17 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3513c435465so9510535ab.0;
        Sun, 15 Oct 2023 20:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697428456; x=1698033256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kL9vRKZWkxdmpBYxrVOOiXDRyOSSPaW0P3GH4wQ9cEk=;
        b=mhq42raTGwJn9yXLL3Ru0L3K1S2lpdnQjnTg/eYfYw8vEPofywb7Mlv7QWuKSCJQm7
         ZIp7jszwzB8go5LtqKkfXiuNI0LC2U69h1m5gTDof86+iGcD6zDjrIJ9ITqsljpSmm/S
         TCG1ejjmuUgHMGGg7NAM4G+wRvCtf0DZoO6Q9fDPg4ssNWLOv98PbBeGWVGBc5V9pL5w
         j7WpZv35At48Ydcaan77wy8nL48V+dCfFzmgD++yU9gWrUxGm6LdL4jP+RXAtZyF6vRR
         F6x2vOcGtL2XqDstOr1Y2667QGJuRvmchv09onKxeMsJdN60g9zXAadqx2C8XM7ebReO
         cbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697428456; x=1698033256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kL9vRKZWkxdmpBYxrVOOiXDRyOSSPaW0P3GH4wQ9cEk=;
        b=m4Mw5/Mu40VPxn5kz3TBfkpW6lIKwMaKWg2IG7YLZ1IGdfnS0SUBhGOWwert6kidal
         Ez0xIvQQjN1Y2BUKLiqqXw34URcspbqnEEBWXuJwHdP7gI6yrs0+E+vSkGIOsxx86p0E
         Mvl7Eu95T4ix1LAxixC81iZcCkR7G+qLiMBtAJmzaXu9/g9OuYLt6Ui26JsW6tS6AtXO
         JouX8YwQ8WgIDJzolWj+NUQPJgjUtQWgQmFFltuRke5FJrMf2CLWO4NULWL6+xD34TdH
         NIsSP9viwBonSoelxERHgDDD3sCIstrz5CXvCdKM5lAKCYEUrR1SjgyKxFotVooamv29
         mbiA==
X-Gm-Message-State: AOJu0Yxw7tI3ei1nyNFugrOW/JAjNgScEvX+n6FDLLQ72+hEa5YtwxSL
        bPWgVmNfGKE8Ae9yi8RBV5gCfzlfpWQ=
X-Google-Smtp-Source: AGHT+IHexA5e9hBHSEkhXFH8IfpCuDjwX2WC62p1KEktm8eoajEtjufjcLgw+myQ/hCxU9kTYpvhCg==
X-Received: by 2002:a92:d1d1:0:b0:34f:7e2f:b837 with SMTP id u17-20020a92d1d1000000b0034f7e2fb837mr4305115ilg.2.1697428456487;
        Sun, 15 Oct 2023 20:54:16 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:6964:515b:e2e1:e1eb? ([2601:282:1e82:2350:6964:515b:e2e1:e1eb])
        by smtp.googlemail.com with ESMTPSA id z16-20020a92d6d0000000b00351268dfbd5sm3113192ilp.57.2023.10.15.20.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 20:54:15 -0700 (PDT)
Message-ID: <e12077e2-ac6e-ae76-bc11-7795034df6c0@gmail.com>
Date:   Sun, 15 Oct 2023 21:54:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 iproute2-next 2/2] rdma: Add support to dump SRQ
 resource in raw format
To:     Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
        leon@kernel.org, stephen@networkplumber.org
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
References: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
 <20231010075526.3860869-3-huangjunxian6@hisilicon.com>
Content-Language: en-US
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <20231010075526.3860869-3-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/10/23 1:55 AM, Junxian Huang wrote:
> @@ -162,6 +162,20 @@ out:
>  	return -EINVAL;
>  }
>  
> +static int res_srq_line_raw(struct rd *rd, const char *name, int idx,
> +			    struct nlattr **nla_line)
> +{
> +	if (!nla_line[RDMA_NLDEV_ATTR_RES_RAW])
> +		return MNL_CB_ERROR;
> +
> +	open_json_object(NULL);

open_json_object with no corresponding close.

> +	print_dev(rd, idx, name);
> +	print_raw_data(rd, nla_line);
> +	newline(rd);
> +
> +	return MNL_CB_OK;
> +}
> +
>  static int res_srq_line(struct rd *rd, const char *name, int idx,
>  			struct nlattr **nla_line)
>  {


