Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166107B8C9
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 06:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfGaEeq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 00:34:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33184 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfGaEep (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 00:34:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so31095438pfq.0
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jul 2019 21:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Fd0cI5+Giy+IQciyl8FGoRjxkuvGK7R0NOj6CX7dzw=;
        b=PYfpUNnuN1TIf6Ubq+59P3pGL60YrecD5LI1zrgIvOEyZYq0RHwGv+xcnL0DQ/LH4i
         qoNyOCCCLf+pOnwkQA+9BorlQ7WmVJLGEdTDXhi7aOQ77palEP7O7ZGuVl7Vsrqq+ha+
         oGoTSTkfwlI+NQEnN7r8p/RDUyBWt38zW3gZoHXyO97YkQsmslICFfgftP3aEvCRBtM3
         ty/uWcaEo2lsyLFCKGL9Vk/harwAqlgFC7vJP1viU5RiVM+5sV8pG79/xg5H8xDjl14h
         o4VCiKJ9/w3mFYLjlp0YiCZl37i2JfGoq8xFGw8UQq7J1rKC2AlcrHkmS0J1+lJXrJye
         PRuw==
X-Gm-Message-State: APjAAAXYo8YgSMMC1b1LwXHNFqGpneL/+Hk0MXTyxZrLMZY5Z1WYGXiJ
        jlY/9bojWQBZgHbEjcHI/x4=
X-Google-Smtp-Source: APXvYqz7A18HXnMLwVxoQgkVx/m8/NNY7X/DCzZG1y7O8eAZnvMqnPyrft6A2NgvyzdVhkK5cQcTrg==
X-Received: by 2002:aa7:8108:: with SMTP id b8mr46126581pfi.197.1564547685137;
        Tue, 30 Jul 2019 21:34:45 -0700 (PDT)
Received: from asus.site ([2601:647:4001:4ec6:b930:4dff:19d3:6998])
        by smtp.gmail.com with ESMTPSA id o9sm37274579pgv.19.2019.07.30.21.34.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 21:34:43 -0700 (PDT)
Subject: Re: [PATCH rdma-core] srp_daemon: check that port LID is valid before
 calling create_ah
To:     Sergey Gorenko <sergeygo@mellanox.com>
Cc:     linux-rdma@vger.kernel.org,
        Vladimir Koushnir <vladimirk@mellanox.com>
References: <20190730105455.15080-1-sergeygo@mellanox.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c6ff8446-c583-78d7-018d-78da8fadbb8f@acm.org>
Date:   Tue, 30 Jul 2019 21:34:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730105455.15080-1-sergeygo@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/30/19 3:54 AM, Sergey Gorenko wrote:
> From: Vladimir Koushnir <vladimirk@mellanox.com>
> 
> The default LID that is given to the port is not valid (a valid LID value
> is > 0 and < 0xc000), so in case the port didn't get a valid lid from the
> SM there is no need to call create_ah.
> 
> Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
> Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
> ---
>   srp_daemon/srp_daemon.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
> index e85b96686d47..337b21c7d7c9 100644
> --- a/srp_daemon/srp_daemon.c
> +++ b/srp_daemon/srp_daemon.c
> @@ -2228,8 +2228,9 @@ catas_start:
>   			pr_debug("Starting a recalculation\n");
>   			port_lid = get_port_lid(res->ud_res->ib_ctx,
>   						config->port_num, &sm_lid);
> -			if (port_lid != res->ud_res->port_attr.lid ||
> -				sm_lid != res->ud_res->port_attr.sm_lid) {
> +			if (port_lid > 0 && port_lid < 0xc000 &&
> +			    (port_lid != res->ud_res->port_attr.lid ||
> +			     sm_lid != res->ud_res->port_attr.sm_lid)) {
>   
>   				if (res->ud_res->ah) {
>   					ibv_destroy_ah(res->ud_res->ah);
> 

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
