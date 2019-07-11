Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2219B65F71
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfGKS3f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 11 Jul 2019 14:29:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45063 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfGKS3f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 14:29:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so3445630plr.12
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 11:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2FZqjVb5LwZAsd2gDLPUsuS+nntSbAlPSMbCB3G9FQ=;
        b=aFHAncWWBc6LtJhcqXGqcSqOsV5U9Plv2t7HGZchl3TlIFNlc0xYoP5l8hRImYQZA9
         Tsm3tBVBfYBiahHfGHO6ySXhvCod9pZ/X2yDbLod6V25RF5JgtlXoVNP23p6Z1+Q7zRB
         ECOKQIghqi/IdsfBC4m53vBNwn1ws/LbQB28fYxleBL23hOXmSWbdCdgaLiViHGaGIa5
         W1NOH518AMCWA/f2aMrvaD65Iv1vtvjxO13Phhk2gjtHhX2kqghj8ZAjMnnioQ/h7rfW
         jBlhHAhUGV2YLsJtkmVkOlPOwAMv7VrMW2qIoQq4uA2DcLz1OA/FarGS8Ttj3Ou5UDIQ
         +1Zw==
X-Gm-Message-State: APjAAAV4OJwZ7sX6DmLlIT0aCrDaksSI2mpuIN7jU9taZkgJFGskbR03
        WRXT7LEJpPLDmGKNbMZi4m49w4mG
X-Google-Smtp-Source: APXvYqwSJAYi+uRKy+2IobrSyNzKipIUqrAfiMd3FZmbqk6DLPwSuiCLS1JTF47piP6FHHMsIrtrQw==
X-Received: by 2002:a17:902:2ae7:: with SMTP id j94mr6262161plb.270.1562869774252;
        Thu, 11 Jul 2019 11:29:34 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id i14sm11678401pfk.0.2019.07.11.11.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:29:33 -0700 (PDT)
Subject: Re: [rdma-core patch] srp_daemon: improve the debug message for
 is_enabled_by_rules_file
To:     Honggang Li <honli@redhat.com>
Cc:     linux-rdma@vger.kernel.org
References: <20190711024001.14648-1-honli@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5bee2fbe-c255-fc1d-b7c3-4757e5d8569c@acm.org>
Date:   Thu, 11 Jul 2019 11:29:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711024001.14648-1-honli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/10/19 7:40 PM, Honggang Li wrote:
> Signed-off-by: Honggang Li <honli@redhat.com>
> ---
>  srp_daemon/srp_daemon.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
> index a004f6a4..f27dd569 100644
> --- a/srp_daemon/srp_daemon.c
> +++ b/srp_daemon/srp_daemon.c
> @@ -349,10 +349,11 @@ static int is_enabled_by_rules_file(struct target_details *target)
>  	int rule;
>  	struct config_t *conf = config;
>  
> -	if (NULL == conf->rules)
> +	if (NULL == conf->rules) {
> +		pr_debug("SRP target with id_ext %s allowed by rules file\n", target->id_ext);
>  		return 1;
> +	}

How about changing that message into e.g. "Allowing SRP target with
id_ext %s because not using a rules file"?

> +		pr_debug("SRP target with id_ext %s %s by rules file\n",
> +				target->id_ext,
> +				conf->rules[rule].allow == 1 ? "allowed" : "disallowed");
>  		return conf->rules[rule].allow;

Is the "== 1" part necessary?

Otherwise this patch looks good to me.

Thanks,

Bart.

