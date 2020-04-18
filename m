Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8E1AF5E9
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2020 01:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgDRXjl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Apr 2020 19:39:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36916 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgDRXjl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Apr 2020 19:39:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id r4so3156895pgg.4;
        Sat, 18 Apr 2020 16:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ow2EkRDoLLtHNIRXc3/SVFgML7s4vwR6e3S9bOQfdDY=;
        b=O/UzJl/6L1dVn3Cpb4zGFmwWVeDB3/A7iv2c3j+6m/7cYRj2IvSNIOjWuv7vNtmPCq
         xoxKtwqmlKkeut1wfcLJzsor7p1euIi9dFNeNVYtTe7zVbHvoOWFAmWDfs7EDMqbkAFl
         VUNOTPM9vCmjIuInMQn+kvsnJrxrCkS6HTVTroWzjVaW8Pj9dIpa1Ej+tTH0CM0BQaF+
         lYPWJjDz3lj1I61bzmoFS7BG91nwIovjCePtae0sDDILVEaxt+BEniv6kOBRbeaNLDoC
         tpvVElif77YO6b9VzUcZpdtM+vPbXUu7KvIEH8FiS7B5hjCjshJ3wQenj2jOEGHiERQY
         CGSw==
X-Gm-Message-State: AGi0PubWWq2DdvRb9GcFLu4ytr2yk8FPT8NSJoSmV1Z6eYnL9EaFmqxV
        Sxz/ImnBvRnMjVHDzYOOARQ=
X-Google-Smtp-Source: APiQypKEBxfrOO9V/dWdP21camw6ITI0zfO8EalvelaZRxOa/SwyGTzZgP7dDI84xbkJ6FojCfBdVA==
X-Received: by 2002:a63:f707:: with SMTP id x7mr10283601pgh.374.1587253180266;
        Sat, 18 Apr 2020 16:39:40 -0700 (PDT)
Received: from [100.124.15.238] ([104.129.199.8])
        by smtp.gmail.com with ESMTPSA id l15sm21903029pgk.59.2020.04.18.16.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 16:39:39 -0700 (PDT)
Subject: Re: [PATCH v12 22/25] block/rnbd: server: sysfs interface functions
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-23-danil.kipnis@cloud.ionos.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0b161f96-c6de-ff6a-e71c-b0e2e623105a@acm.org>
Date:   Sat, 18 Apr 2020 16:39:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415092045.4729-23-danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/15/20 2:20 AM, Danil Kipnis wrote:
> This is the sysfs interface to rnbd mapped devices on server side:
> 
>    /sys/class/rnbd-server/ctl/devices/<device_name>/
>      |- block_dev
>      |  *** link pointing to the corresponding block device sysfs entry
>      |
>      |- sessions/<session-name>/
>      |  *** sessions directory
>         |
>         |- read_only
>         |  *** is devices mapped as read only
>         |
>         |- mapping_path
>            *** relative device path provided by the client during mapping

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

