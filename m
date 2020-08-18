Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F40248CA9
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 19:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgHRROt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 13:14:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36940 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgHRROj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 13:14:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id y3so19007968wrl.4
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 10:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vb3zGwE1WCHx+27JTR7GFIFm9G79r4Q2mIZjMGFpqGY=;
        b=sTaTNL9SL0Pcd5vL3uEsrZ2bz0vkolgd/wNQeron6kgVAbCXSOVDyn6cE1k10HH5UJ
         hzcWlnvzKcs6BfSCaYvROEqYNqgBVnT70SqHya3JfKnqEHQQoEhHl4D3YKAjgM0C5JMC
         2J9s6fHUWjFcrTIUmAJn0rn5HwBB9veqytx6gspS72KwScAA1pt3ES4aL5GjXwbptwFa
         2S5yVK8tOs9bpWosZzldEf/SFZa5bzFPNJWkqG8PG3Qo/8GNSTeg36SW9MfvvpjhoHr0
         h869b6rJbLKejeHGPUF0ZZMNShHsQQU/HBSNPb17D7X3RBI0B9iaH2NLy4FvEs/glVz5
         phDg==
X-Gm-Message-State: AOAM531gYlAIWOuYk+iu+9A/WDoSsH7psgT9Ob928aFWeYK9m1Z57mEj
        SN47cRahAwJyYeZpByRHJywYr8Tu639PVw==
X-Google-Smtp-Source: ABdhPJyJHY/NJ3mG0RnRPvsuD1T6FVfsRe2a3gqSII96sXaJzw7NrhRfx5QMBsW4GuseFGLoY7t11w==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr241953wrn.345.1597770876875;
        Tue, 18 Aug 2020 10:14:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dce:63f2:5e83:391e? ([2601:647:4802:9070:3dce:63f2:5e83:391e])
        by smtp.gmail.com with ESMTPSA id z127sm703344wme.44.2020.08.18.10.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 10:14:36 -0700 (PDT)
Subject: Re: regression with "nvme-rdma: use new shared CQ mechanism" from
 v5.9-rc1
To:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
Cc:     yaminf@mellanox.com, kbusch@kernel.org, hch@lst.de,
        linux-rdma@vger.kernel.org
References: <1476432272.38046616.1597766884817.JavaMail.zimbra@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <797037be-c908-6c95-e459-4e997de51679@grimberg.me>
Date:   Tue, 18 Aug 2020 10:14:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1476432272.38046616.1597766884817.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

+linux-rdma

On 8/18/20 9:08 AM, Yi Zhang wrote:
> Hello
> 
> With Sagi's new blktests nvme rdma[1], I found one regresson that lead nvme/004 hang.
> By bisecting, I found it was introduced from [2], could anyone help check this issue, thanks.
> 
> [1] https://marc.info/?l=linux-block&m=159738590701657&w=2
> # nvme_trtype=rdma ./check nvme/004                      -------> hang and never finished
> nvme/004 (test nvme and nvmet UUID NS descriptors)
>      runtime  1.647s  ...
> 
> # ps aux | grep rdma_rxe
> root        1657  0.0  0.0   8292  1632 pts/0    D+   11:54   0:00 modprobe -r rdma_rxe
>          
> # cat /proc/1657/stack
> [<0>] disable_device+0xa2/0x130 [ib_core]
> [<0>] __ib_unregister_device+0x37/0xa0 [ib_core]
> [<0>] ib_unregister_driver+0x9d/0xd0 [ib_core]
> [<0>] rxe_module_exit+0x16/0x7d [rdma_rxe]
> [<0>] __do_sys_delete_module.constprop.0+0x170/0x2c0
> [<0>] do_syscall_64+0x33/0x40
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> # dmesg
> [  273.577444] run blktests nvme/004 at 2020-08-18 11:54:22
> [  273.615610] rdma_rxe: loaded
> [  273.623675] infiniband rxe0: set active
> [  273.627962] infiniband rxe0: added eno1
> [  273.639520] infiniband rxe1: set down
> [  273.643611] infiniband rxe1: added eno2
> [  273.655617] infiniband rxe0: set down
> [  273.659713] infiniband rxe0: added eno3
> [  273.673854] infiniband rxe0: set down
> [  273.677946] infiniband rxe0: added eno4
> [  273.695954] infiniband rxe0: set active
> [  273.700236] infiniband rxe0: added enp130s0f0
> [  273.717858] infiniband rxe0: set down
> [  273.721954] infiniband rxe0: added enp130s0f1
> [  273.739460] lo speed is unknown, defaulting to 1000
> [  273.744941] lo speed is unknown, defaulting to 1000
> [  273.750413] lo speed is unknown, defaulting to 1000
> [  273.757853] infiniband rxe0: set active
> [  273.762139] infiniband rxe0: added lo
> [  273.766229] lo speed is unknown, defaulting to 1000
> [  273.771681] lo speed is unknown, defaulting to 1000
> [  273.777135] lo speed is unknown, defaulting to 1000
> [  273.992958] loop: module loaded
> [  274.024550] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  274.039541] nvmet_rdma: enabling port 0 (10.16.221.68:4420)
> [  274.066081] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e5372c18c860491bb18adb3b5b025a20.
> [  274.081395] nvme nvme0: creating 32 I/O queues.
> [  274.120241] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> [  274.132037] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 10.16.221.68:4420
> [  275.171715] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> [  275.311794] rdma_rxe: not configured on eno1
> [  275.321210] rdma_rxe: not configured on eno2
> [  275.333410] rdma_rxe: not configured on eno3
> [  275.347527] rdma_rxe: not configured on eno4
> [  275.362830] rdma_rxe: not configured on enp130s0f0
> [  275.383157] rdma_rxe: not configured on enp130s0f1
> [  275.406067] rdma_rxe: not configured on lo
> [  513.938222] infiniband rocep130s0f0: set active
> [  558.930867] infiniband rocep130s0f0: set active
> [  558.948955] infiniband rocep130s0f0: set active
> [  603.930414] infiniband rocep130s0f0: set active
> 
> 
> [2]
> ca0f1a8055be nvmet-rdma: use new shared CQ mechanism
> 287f329e3131 nvme-rdma: use new shared CQ mechanism
> 
> Best Regards,
>    Yi Zhang
> 
> 
