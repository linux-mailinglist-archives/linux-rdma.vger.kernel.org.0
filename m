Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8EB953A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405433AbfITQVw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 12:21:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44373 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405430AbfITQVn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 12:21:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so3401292pll.11
        for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2019 09:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=znUURcKWjP6cNJFxDrebTLB4r5lbuVmLmcwFLHhx51U=;
        b=N/y52973kOWz0yD3kB5B4tyTemII86U2nBqLO5/k5dp1qeiLuiQOaEo7igN74lAu0V
         XAKvncpjceEkkdj+3KiWTKURfMUy6BH3SOZffPR9gnkZuZ5hspV/fjA3hi2+TenFyHWx
         9YwflIu8CUdiaQ5e9bd9hQ7KiZnPzE6jES+qckIZ865DoHAHckIck/HoRVgr29aGCV+N
         UiWWA28ooBZYHas13mT/dDNag/PnspsQ28gShUqwTTwpsCTC0GypGC7RjyiymuorM+Gh
         Mp2ZQmE50sfl5CNOirYuhocvCMvb6mba+Z+Nq/rLeMGMy7Y5M1BWGpL5g75nSdVmzO4D
         qa8w==
X-Gm-Message-State: APjAAAW44HObWnO4fVueVDfk+/kJe+e55rA7LWOUKF1JldJ+LnCOoxyw
        1NPQ2PLurYCTcZAA+iGGD7HkLea6
X-Google-Smtp-Source: APXvYqyxLlR2iv2mrSroKdE8kC+WY2BGI70baDMRp7rdKPM/PoAKpLeLYkd3qZac4jLgljXF9anruA==
X-Received: by 2002:a17:902:a606:: with SMTP id u6mr17615615plq.224.1568996501464;
        Fri, 20 Sep 2019 09:21:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e192sm3533982pfh.83.2019.09.20.09.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:21:40 -0700 (PDT)
Subject: Re: [rdma-core patch] srp_daemon: fix a double free segment fault for
 ibsrpdm
To:     Honggang LI <honli@redhat.com>
Cc:     linux-rdma@vger.kernel.org
References: <20190919064045.23193-1-honli@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9040e0e9-457e-26ec-6e9f-8e30251ca9f3@acm.org>
Date:   Fri, 20 Sep 2019 09:21:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919064045.23193-1-honli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/18/19 11:40 PM, Honggang LI wrote:
> diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
> index 337b21c7..f0bcf923 100644
> --- a/srp_daemon/srp_daemon.c
> +++ b/srp_daemon/srp_daemon.c
> @@ -727,6 +727,7 @@ end:
>   	if (ret) {
>   		free(*ibport);
>   		free(*ibdev);
> +		*ibdev = NULL;
>   	}
>   	free(class_dev_path);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
