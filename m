Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1A3BBEEC
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 01:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503551AbfIWXVc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 19:21:32 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:44753 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503544AbfIWXVc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 19:21:32 -0400
Received: by mail-pl1-f172.google.com with SMTP id q15so4197pll.11;
        Mon, 23 Sep 2019 16:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gsnjv/9E3hmWnnivSRqgLgwY2JaggRRHnlzmYVYGCAA=;
        b=N4KZfJah0dnx/qqGNDz4euk5eXQna66SpI27nQYQXTrndAip+GQlZYcC03S4iP1q9R
         Dq85JiphiRbQ1KTTYN45onsQl+Rli+7UIHHUaQXr9k/A224cyUsdnyqY7XiTdY2bst55
         uSIjppPnbDVf3pcLp89oG0kLSvvGOBBaM1HJDZbRoPlUghj/HDXn1kJgmnL4dHMZuYd/
         g2oZGwG5iG2674ndeuCmo4aENR/2KqUZSd/Hnb2C+vebXHLiPrgl7UXja35mrCbT9dQI
         5Reg8hOrVgrHPZmyYvikpoKNzjKCfK0z3+6fAHXqj0oMxT3qAMcQcAYMYabMFRER20TU
         IZEA==
X-Gm-Message-State: APjAAAUWCdnT0pZZcD81BNLTePF/hsRUMqWAUTqQulHG/kvOkdvzw0aw
        f4nbj37iA2FwDYldI+TouHk=
X-Google-Smtp-Source: APXvYqzKnRHkGyxGjCKTbTwPL1KuJPVxEJIyI0mDYHLrrFK+ogTEou9Oj7v2XFQFPtNXGhWWXm6DMg==
X-Received: by 2002:a17:902:868a:: with SMTP id g10mr2294834plo.235.1569280889887;
        Mon, 23 Sep 2019 16:21:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id k8sm10953407pgm.14.2019.09.23.16.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 16:21:28 -0700 (PDT)
Subject: Re: [PATCH v4 09/25] ibtrs: server: private header with server
 structs and functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-10-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c0ca07e9-2864-b1a2-1b78-b9f1de5702c0@acm.org>
Date:   Mon, 23 Sep 2019 16:21:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-10-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +static inline const char *ibtrs_srv_state_str(enum ibtrs_srv_state state)
> +{
> +	switch (state) {
> +	case IBTRS_SRV_CONNECTING:
> +		return "IBTRS_SRV_CONNECTING";
> +	case IBTRS_SRV_CONNECTED:
> +		return "IBTRS_SRV_CONNECTED";
> +	case IBTRS_SRV_CLOSING:
> +		return "IBTRS_SRV_CLOSING";
> +	case IBTRS_SRV_CLOSED:
> +		return "IBTRS_SRV_CLOSED";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}

Since this function is not in the hot path, please move it into a .c file.

> +/* See ibtrs-log.h */
> +#define TYPES_TO_SESSNAME(obj)						\
> +	LIST(CASE(obj, struct ibtrs_srv_sess *, s.sessname))

Please remove this macro and pass 'sessname' explicitly to logging 
functions.

Thanks,

Bart.
