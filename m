Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3920C17B01F
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 21:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgCEU5G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 15:57:06 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42609 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEU5G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Mar 2020 15:57:06 -0500
Received: by mail-oi1-f171.google.com with SMTP id l12so255704oil.9
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2020 12:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6TNJyu56HtsytA/M+eXPaQjyFqz8KUspI7MR0nNmu3c=;
        b=jox4uZvyQ+o5zf/9WhM/cjac6gWxs3NLWHufAR8DxewDVR2QZrcan/JkDnV5y/r+Nt
         V0rJd4kmnMLiA/lijos9sZwQGr3yRE8PY0nROmcOSLyhUtb6P0mZR9nI4AIvDbXmGyRL
         OIQ21GSMGjZ+5rvcXPpfweHM5aFzHv78SUm63v3+Nno/WOrm63f9/5PpxlxatOAnNkpI
         1dw9fo1X2cjIKipIU5Uq2ZfjsiqTmUow8PxE5KJK4zOJmW9wkW4giv5T8b7D4/Mw4Iqb
         mGmWTPKj3OZS4jXXN5EV/pEIIqo0mDjCcBGWldV7N7oNv66N84QZiV61JXhcpJmaC56H
         vS1Q==
X-Gm-Message-State: ANhLgQ3QVWBA8Aru9HUQKNZbtxXREnsmEr0OUY1jmVV3o3icFm3i/efc
        pkojaiXIpWWImbCZu5ld41YQQe0B
X-Google-Smtp-Source: ADFU+vvhdNHVG/kGslmUXN6haxoACRebAb5kQgjrlPdPXJnBBebmU7gfq1eIh0IklIUlMStjNuuAZA==
X-Received: by 2002:a54:410e:: with SMTP id l14mr261096oic.42.1583441824592;
        Thu, 05 Mar 2020 12:57:04 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id e79sm1969540oib.10.2020.03.05.12.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 12:57:03 -0800 (PST)
Subject: Re: [bug report] NVMe RDMA OPA: kmemleak observed with
 connect/reset_controller/disconnect
To:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <215235485.15264050.1583334487658.JavaMail.zimbra@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ef49292b-c39d-2f0b-99ca-2835b6afff97@grimberg.me>
Date:   Thu, 5 Mar 2020 12:57:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <215235485.15264050.1583334487658.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

CCing Linux-rdma as I don't think anyone in nvme will
have a clue to whats going on here...

On 3/4/20 7:08 AM, Yi Zhang wrote:
> Hello
> 
> I would like to report a kmemleak issue found on NVMe RDMA OPA environment, here is the log, let me know if you need more info
> 
> unreferenced object 0xffffc90006639000 (size 12288):
>    comm "kworker/u128:0", pid 8, jiffies 4295777598 (age 589.085s)
>    hex dump (first 32 bytes):
>      4d 00 00 00 4d 00 00 00 00 c0 08 ac 8b 88 ff ff  M...M...........
>      00 00 00 00 80 00 00 00 00 00 00 00 10 00 00 00  ................
>    backtrace:
>      [<0000000035a3d625>] __vmalloc_node_range+0x361/0x720
>      [<000000002942ce4f>] __vmalloc_node.constprop.30+0x63/0xb0
>      [<00000000f228f784>] rvt_create_cq+0x98a/0xd80 [rdmavt]
>      [<00000000b84aec66>] __ib_alloc_cq_user+0x281/0x1260 [ib_core]
>      [<00000000ef3764be>] nvme_rdma_cm_handler+0xdb7/0x1b80 [nvme_rdma]
>      [<00000000936b401c>] cma_cm_event_handler+0xb7/0x550 [rdma_cm]
>      [<00000000d9c40b7b>] addr_handler+0x195/0x310 [rdma_cm]
>      [<00000000c7398a03>] process_one_req+0xdd/0x600 [ib_core]
>      [<000000004d29675b>] process_one_work+0x920/0x1740
>      [<00000000efedcdb5>] worker_thread+0x87/0xb40
>      [<000000005688b340>] kthread+0x327/0x3f0
>      [<0000000043a168d6>] ret_from_fork+0x3a/0x50
> unreferenced object 0xffffc90008581000 (size 36864):
>    comm "kworker/u128:0", pid 8, jiffies 4295778075 (age 588.608s)
>    hex dump (first 32 bytes):
>      84 00 00 00 84 00 00 00 40 01 36 5d 84 88 ff ff  ........@.6]....
>      00 00 00 00 00 00 00 00 00 00 00 00 40 04 00 00  ............@...
>    backtrace:
>      [<0000000035a3d625>] __vmalloc_node_range+0x361/0x720
>      [<000000002942ce4f>] __vmalloc_node.constprop.30+0x63/0xb0
>      [<00000000f228f784>] rvt_create_cq+0x98a/0xd80 [rdmavt]
>      [<00000000b84aec66>] __ib_alloc_cq_user+0x281/0x1260 [ib_core]
>      [<00000000ef3764be>] nvme_rdma_cm_handler+0xdb7/0x1b80 [nvme_rdma]
>      [<00000000936b401c>] cma_cm_event_handler+0xb7/0x550 [rdma_cm]
>      [<00000000d9c40b7b>] addr_handler+0x195/0x310 [rdma_cm]
>      [<00000000c7398a03>] process_one_req+0xdd/0x600 [ib_core]
>      [<000000004d29675b>] process_one_work+0x920/0x1740
>      [<00000000efedcdb5>] worker_thread+0x87/0xb40
>      [<000000005688b340>] kthread+0x327/0x3f0
>      [<0000000043a168d6>] ret_from_fork+0x3a/0x50
> 
> 
> Best Regards,
>    Yi Zhang
> 
> 
