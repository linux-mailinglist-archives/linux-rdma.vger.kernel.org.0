Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BEE38CCD5
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 20:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhEUSCN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 14:02:13 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38576 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhEUSCN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 14:02:13 -0400
Received: by mail-wr1-f47.google.com with SMTP id j14so20140765wrq.5
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 11:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K2OMHwJrFA1wNd3dbbnfZzfa7bj0/B6q6MDz93o2gys=;
        b=TJkpUeRXOP1ialbYwl5fprD0kZnnvZP2s3XHj6nBpGXSonmy9a0FNW8WXub+v7cXmH
         d5phnuknOUGF53AX3yAqlGuWk8Z7oLgWe87GYEGPW3v8wO5CstNH1Qjnq2Cn33/kZUfR
         Ju2kFFlp4GEdy6FiVSLRpqPjZYHfWgUM13YQqXlSAjRi3Jtj2izH3E1x1JqbGJvrG/rF
         kvcKrRGV/sJCcLj9OSq+lGQX2m19AqmDplmvze/IjLcVPUAMMeYAbFFruHbcpnGSULeh
         pwi8WW8gtCO/j/5VObER+PhcfS6lmn6Au6yrn9/9Re/oTHr5pdUeKowzKarKGMdw7X1U
         Su8Q==
X-Gm-Message-State: AOAM531LgP4glqxjBQOlJswo6pUi4gwlyTHXwWdPFMZzUH+V6T0D9mKX
        AjERqxA4RR6katli6jN4kW8=
X-Google-Smtp-Source: ABdhPJwSsgONsBUKuWTQWzH+H/MLK3jNvF2rYJSDp1OM5I/f4uKleXyGGzvfG+qvaGKFxNu6PVlOzw==
X-Received: by 2002:a5d:5404:: with SMTP id g4mr11078217wrv.286.1621620049533;
        Fri, 21 May 2021 11:00:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253? ([2601:647:4802:9070:66b2:1988:438b:4253])
        by smtp.gmail.com with ESMTPSA id u14sm238914wmc.41.2021.05.21.11.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 11:00:49 -0700 (PDT)
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org
Cc:     maxg@mellanox.com
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
Date:   Fri, 21 May 2021 11:00:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Hi
> I found this issue on 5.13-rc2 with NVMe/IB environment, could anyone
> help check it?
> Thanks.
> 
> $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> real 0m10.678s
> user 0m0.000s
> sys 0m0.000s
> $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> real 1m11.530s
> user 0m0.000s
> sys 0m0.000s
> 
> target:
> $ dmesg | grep nvme
> [  276.891454] nvmet: creating controller 1 for subsystem testnqn for
> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> [  287.374412] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> [  287.399317] nvmet: ctrl 1 fatal error occurred!
> [  348.412672] nvmet: creating controller 1 for subsystem testnqn for
> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> 
> client:
> $ dmesg | grep nvme
> [  281.704475] nvme nvme0: creating 40 I/O queues.
> [  285.557759] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> [  353.187809] nvme nvme0: I/O 8 QID 0 timeout
> [  353.193100] nvme nvme0: Property Set error: 881, offset 0x14
> [  353.226082] nvme nvme0: creating 40 I/O queues.
> [  357.088266] nvme nvme0: mapped 40/0/0 default/read/poll queues.

It appears that there is an admin timeout that is either triggered
by the reset or unrelated.

Can you run nvme reset /dev/nvme0 instead so we can see the "resetting
controller" print?
