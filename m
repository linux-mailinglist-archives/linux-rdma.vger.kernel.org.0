Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B63B53E2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 19:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfIQRTk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 13:19:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45853 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfIQRTk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 13:19:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so2526414pfb.12
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 10:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gv/TDMGflI0y3unHsxjm0uYjBhMMMNVxgN6XChX/CBQ=;
        b=J2OOHNvXg8qJoiPmERY9HlLjUWiNSQxObZpsduvuSmA18yQzLVJ96/LkNX6E0NmslR
         kDYFDFtIqf3tQFNe4BLfEQDjoqGvYSkH2YZLswq5WHUYyKqN2SWlN/505DLsuUO//Rh+
         QBudqu6Yt9qVoLcP8V42eSkh9q3rJQ0soMrMQLACtr8mz6aXeeXjLlgF///T84CjxJjF
         FjyDPfUZ/7GQhV1PZDYHXiMXdHj9zfNXoldGsZl7if0PIcZsy5aX2MP5JIvnsK1Li+e5
         ixbllffTrDp4dOy/mmfhySsVPGT70QAdOH5sOwAdHGB3XFAa5bvpoZJgeLWTdYm+ax4w
         XdKw==
X-Gm-Message-State: APjAAAWc94qtgTn1SM3QkbjVfXoArTUg9kTqtUxQlpa343dckdGbfsyB
        3/WU/rUhyzvYL24U14mqCWySBidA
X-Google-Smtp-Source: APXvYqxDLdaKadO1k1N4A3j/U3nyM0t3yxVoT+Lc+V1FPL2l4dPnxFV2x1ksuei/gGYQ/2hjybPLQA==
X-Received: by 2002:a17:90a:d0c4:: with SMTP id y4mr6285359pjw.116.1568740779162;
        Tue, 17 Sep 2019 10:19:39 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 2sm3672322pfa.43.2019.09.17.10.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 10:19:38 -0700 (PDT)
Subject: Re: [rdma-core patch] srp_daemon: print maximum initiator to target
 IU size
To:     Honggang LI <honli@redhat.com>, linux-rdma@vger.kernel.org
References: <20190916013607.9474-1-honli@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <deb829a3-813e-6b99-c932-ceecc06e09b3@acm.org>
Date:   Tue, 17 Sep 2019 10:19:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916013607.9474-1-honli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/15/19 6:36 PM, Honggang LI wrote:
> From: Honggang Li <honli@redhat.com>
> 
> The 'Send Message Size' field of IOControllerProfile attributes
> contains the maximum initiator to target IU size.
> 
> When there is something wrong with SRP login to a third party
> SRP target, whose ib_srpt parameters can't be collected with
> ordinary method, dump the 'Send Message Size' may help us to
> diagnose the problem.
> 
> Signed-off-by: Honggang Li <honli@redhat.com>
> ---
>   srp_daemon/srp_daemon.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
> index 337b21c7..90533c77 100644
> --- a/srp_daemon/srp_daemon.c
> +++ b/srp_daemon/srp_daemon.c
> @@ -1022,6 +1022,8 @@ static int do_port(struct resources *res, uint16_t pkey, uint16_t dlid,
>   			pr_human("        vendor ID: %06x\n", be32toh(target->ioc_prof.vendor_id) >> 8);
>   			pr_human("        device ID: %06x\n", be32toh(target->ioc_prof.device_id));
>   			pr_human("        IO class : %04hx\n", be16toh(target->ioc_prof.io_class));
> +			pr_human("        Maximum initiator to target IU size: %d\n",
> +				 be32toh(target->ioc_prof.send_size));
>   			pr_human("        ID:        %s\n", target->ioc_prof.id);
>   			pr_human("        service entries: %d\n", target->ioc_prof.service_entries);

How about using the terminology from the InfiniBand Architecture 
Specification? This is what I found in release 1.3, table 306:

"Maximum size of Send Messages in bytes"

Thanks,

Bart.
