Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A0BBBEBE
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 01:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbfIWXFr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 19:05:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46662 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403772AbfIWXFq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 19:05:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so10120002pfg.13;
        Mon, 23 Sep 2019 16:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KaQ7m3DeMo4SnW2nQTSws1cs6+UUJVwp4lSCQ4fXeV8=;
        b=j9JIj1jGqVYrl2PKwtcSnek/Ds1TxyvTLskVU3NWB1ZQAH/C3F3h3Sc3sDn3wE2asT
         LbCjspY0wY3YtRwtHFVS8vEtD74wBzdKyh/FD3+fMyOxCj4MiY9eKrAk25w1GH705H1a
         WhewENTkX1V6RUpnJSUULBwOJ7udE49QsRbDG+ZVhWq1wVCVvQp7R5HF5B3mEBd3Pt0T
         kTTy3MdIS99AJDz85nCIu560H+qK6x3TCq3pUap4wwfGQ/QsW7wtATckiOuzidaXSw1x
         5l7iYj2SBZDx7qQCwVYYKNtBvZwdV10NnE4sYSbTd8NcakNfF7HtvjRMdeWA9gT1QnA9
         N8rA==
X-Gm-Message-State: APjAAAXLpBYTo+tIxaECOExCeHg7ufLY1q5QRAbeRmQPvBDJs9xDTiUG
        qr3/+SqyyVUEBwb80+QZJkQ=
X-Google-Smtp-Source: APXvYqxCHlZCArIGvnEluaVfn7aiFRv8HRpQ0xYFs/Dlnw5y1ohJo5jL4JfnRog2ZBUVaDIIabC3AA==
X-Received: by 2002:a63:83c3:: with SMTP id h186mr2303207pge.317.1569279945948;
        Mon, 23 Sep 2019 16:05:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b3sm1899668pfd.125.2019.09.23.16.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 16:05:45 -0700 (PDT)
Subject: Re: [PATCH v4 05/25] ibtrs: client: private header with client
 structs and functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-6-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c74a0a2b-c095-42e0-8cf9-e38e0cd6d6a7@acm.org>
Date:   Mon, 23 Sep 2019 16:05:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-6-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +static inline const char *ibtrs_clt_state_str(enum ibtrs_clt_state state)
> +{
> +	switch (state) {
> +	case IBTRS_CLT_CONNECTING:
> +		return "IBTRS_CLT_CONNECTING";
> +	case IBTRS_CLT_CONNECTING_ERR:
> +		return "IBTRS_CLT_CONNECTING_ERR";
> +	case IBTRS_CLT_RECONNECTING:
> +		return "IBTRS_CLT_RECONNECTING";
> +	case IBTRS_CLT_CONNECTED:
> +		return "IBTRS_CLT_CONNECTED";
> +	case IBTRS_CLT_CLOSING:
> +		return "IBTRS_CLT_CLOSING";
> +	case IBTRS_CLT_CLOSED:
> +		return "IBTRS_CLT_CLOSED";
> +	case IBTRS_CLT_DEAD:
> +		return "IBTRS_CLT_DEAD";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}

Since this code is not in the hot path, please move it from a .h into a 
.c file.

> +static inline struct ibtrs_clt_con *to_clt_con(struct ibtrs_con *c)
> +{
> +	return container_of(c, struct ibtrs_clt_con, c);
> +}
> +
> +static inline struct ibtrs_clt_sess *to_clt_sess(struct ibtrs_sess *s)
> +{
> +	return container_of(s, struct ibtrs_clt_sess, s);
> +}

Is it really useful to define functions for these conversions? Has it 
been considered to inline these functions?

Thanks,

Bart.
