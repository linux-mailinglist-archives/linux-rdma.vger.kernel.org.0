Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3644A7A2
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 18:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfFRQvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 12:51:52 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:38285 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbfFRQvv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 12:51:51 -0400
Received: by mail-pl1-f173.google.com with SMTP id f98so373018plb.5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlltVR/XsALb+JL+y43zL1E8EKO/23686wqaMw7nrDM=;
        b=qQw8YSEWz6fylwKdPZbuQCh4hGX5F3mes+iiy6woz8BRf7P8X+E+dfFDk5Q2ZRqlWq
         JIb889J3fUnIt4nim3XITn38pYhpvTwr3AsMVltxlmr7EpfflKo4jIX9x2CkPGyU9Q1T
         jMIXgn2u7cysh6fbS8ci/MmIrlThkQ+zJZfQxnBLqTYs6KQGHxMIxucjoJfhH5usGk6f
         CNJAXnlPLQEESrX19KgAHSbZWwPnMX0xeE1a4m3cVx6tOpRCSinT6oOI9nK8+XFDjeoC
         hM0AmUGtiIXB/jd+uwOw8/J4/6uXES5RD+y7nHbAT5edSeXPZL1E5C6IbgM3pk8GULPt
         Eq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlltVR/XsALb+JL+y43zL1E8EKO/23686wqaMw7nrDM=;
        b=VuJNk0vdiQlaju5LjUiiYdoVbszwGRiq29+JeMDsJZgJHx/3hRYbpPpKGITSbdWgvn
         oDTrqqPFy6kxEiXrM/wUWZayhKKrbmqFDGXYh8g3rmfoiMnfKIBjVeOKOhTJ6tMZI4tb
         jimsgZl7E0VJ0q+OV9Q1dud3F/HcrN+jXM7/wqOtRddVKNqGwkjI4BIpgjrREbz8Tz0F
         gWe0QKWsAWcXioerAD6AZTJ0e9r29MxJsMi4Q6ZhhWnVg0JDgsHOB0mDBidvfzbHCRRw
         GwUhVscibZw8t79Pxy79vWdnJCfVKvYNciXMtC5gnQ5CNUDyCbSAXck10Pj8jbqQUFZg
         PGZQ==
X-Gm-Message-State: APjAAAVhO7GCsX152tNMAtkh9P3ZiM/Ds65AUbPPsNNRQaFNz1vm8hvy
        gMxnRP99ngwnJM01sE57FWk4rQ==
X-Google-Smtp-Source: APXvYqzXdzzCqU4+WWmyhrTT/BwhEe9Jl4njGcfsCfF9Wckc0YMWrSri3z1my0Q6BJo5CjT6xL/TTw==
X-Received: by 2002:a17:902:7d8d:: with SMTP id a13mr2110361plm.98.1560876710919;
        Tue, 18 Jun 2019 09:51:50 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d5sm46075pgm.49.2019.06.18.09.51.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 09:51:50 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:51:44 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     dledford@redhat.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, mkubecek@suse.cz
Subject: Re: [iproute2] ipaddress: correctly print a VF hw address in the
 IPoIB case
Message-ID: <20190618095144.4ef794a9@hermes.lan>
In-Reply-To: <20190615114056.100808-2-dkirjanov@suse.com>
References: <20190615114056.100808-1-dkirjanov@suse.com>
        <20190615114056.100808-2-dkirjanov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, 15 Jun 2019 13:40:56 +0200
Denis Kirjanov <kda@linux-powerpc.org> wrote:

> diff --git a/include/uapi/linux/netdevice.h b/include/uapi/linux/netdevice.h
> index 86d961c9..aaa48818 100644
> --- a/include/uapi/linux/netdevice.h
> +++ b/include/uapi/linux/netdevice.h
> @@ -30,7 +30,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/if_packet.h>
>  #include <linux/if_link.h>
> -
> +#include <linux/if_infiniband.h>

You can't modify kernel headers in iproute.
These are updated by a script and your change will get overwritten.

I did go ahead and put if_link.h and if_infiniband.h in already.
