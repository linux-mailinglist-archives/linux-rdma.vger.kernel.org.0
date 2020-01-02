Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9095812F092
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 23:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgABWxp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 17:53:45 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40043 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgABWV1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 17:21:27 -0500
Received: by mail-pj1-f67.google.com with SMTP id bg7so3934426pjb.5;
        Thu, 02 Jan 2020 14:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w8RjK4aftLZxkYESHjiXhuMfaSosoMz2QGwQm1yGCxw=;
        b=M0/X2u5+kxoL3yppAOAUg9+0tKFNNhbjkhpgqPbgp1rdHptNqWTfpBuyf4GuWd5eTX
         pHIjNh5i84gbtmKQAXhfjHOZeq4+SYycicWuUH/Tcj5R5KbYIy+/YsaWeDbxD+35UtE1
         xLmIf48PLaQ/VDpJ9uAqt0uai/+9p5ARuzfl2topyuTHrPadcEIUb/9LAaM40rjn0S4d
         iNz19nLs5AvSKoCstGcoqqOl3RBzTMDVenB0ZmHUs6UyQq909mlodKVAUF2QjOiAtNut
         Fukg6sna0FoCVudMJ0ty8TBRQWtbbW++eNTaPs7Ru+ZXrA3WKYS40v0dUehZdXeHtT3Y
         AlEA==
X-Gm-Message-State: APjAAAXHBDttFkloMew+JG96rOrcLJuWwFGAc5U6aNzNn/rAt5JpFgN1
        yAuowqfANy7sjoprfHnGbnCKlXgv
X-Google-Smtp-Source: APXvYqzKn2fxYO5t+3k2rLLRrKegG6hlyWEbJfBx++NBBKCapm8vcB1QCRucYm5+8zR1Rzjhs1aiYA==
X-Received: by 2002:a17:90a:6484:: with SMTP id h4mr21717824pjj.84.1578003686433;
        Thu, 02 Jan 2020 14:21:26 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 199sm67865209pfv.81.2020.01.02.14.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 14:21:25 -0800 (PST)
Subject: Re: [PATCH v6 14/25] rtrs: a bit of documentation
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        linux-kernel@vger.kernel.org
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-15-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bb668d4e-f768-a408-c541-d862d1a2f959@acm.org>
Date:   Thu, 2 Jan 2020 14:21:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-15-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
> new file mode 100644
> index 000000000000..8b219cf6c5c4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
> @@ -0,0 +1,190 @@
> +What:		/sys/class/rtrs-client
> +Date:		Jan 2020
> +KernelVersion:	5.6
> +Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
> +Description:
> +When a user of RTRS API creates a new session, a directory entry with
> +the name of that session is created under /sys/class/rtrs-client/<session-name>/

Thank you for having included this ABI description. This is very 
helpful. Please follow the format documented in Documentation/ABI/README 
and make sure that all text, including the description, start in column 
17 and please use tabs for indentation.

> diff --git a/drivers/infiniband/ulp/rtrs/README b/drivers/infiniband/ulp/rtrs/README
> new file mode 100644
> index 000000000000..59ad60318a18
> --- /dev/null
> +++ b/drivers/infiniband/ulp/rtrs/README
> @@ -0,0 +1,149 @@
> +****************************
> +InfiniBand Transport (RTRS)
> +****************************
> +
> +RTRS (InfiniBand Transport) is a reliable high speed transport library
> +which provides support to establish optimal number of connections
> +between client and server machines using RDMA (InfiniBand, RoCE, iWarp)
> +transport. It is optimized to transfer (read/write) IO blocks.

Is it explained somewhere how the optimal number of connections is 
determined and also according to which metric the number of connections 
is optimized? Is the number of connections chosen to minimize latency, 
maximize IOPS or perhaps to optimize yet another metric?

Thanks,

Bart.
