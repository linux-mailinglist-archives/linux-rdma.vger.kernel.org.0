Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5F5362D6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 19:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfFERiP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 13:38:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35736 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFERiP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 13:38:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so1519488otq.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 10:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=iNecNP23pPU96aSX0EE9VxyG7zO565jXem/GRxwDic5l6Uej+WwipoGBEdOyyWNaz8
         a9vzyX94O68eY8SFQGRSJ7knsZ30uVDNqDR9ov8FbeuXQSBE/dN44/X3OBTY/SGwQdE3
         p3XUpGb7TCP70vfmp6Rv/P9x9Qj0QsosdvsMQOYVdrv8kvLTW0jZn/RWfN827QIafXIc
         Pgk1I8GlICrZc+xR6fA3kRSPuYpA7SKALv0jVGxJYyRYg9Wd/QjZbzfkALVVKxpBAMTw
         Jvyr9Z5bgSkYD0CibCV0S43jmKRGuHyrvXymd5qbVxAPbqoXoNf5SUiZdctYLhakfuZJ
         Vg1A==
X-Gm-Message-State: APjAAAUBicu6PUCuYlmzfmdXLY4BxidvwvBtjt0idO5yOqpnzYSGXSY1
        7TbjT3fGfE+2bGpt5gd7Iag=
X-Google-Smtp-Source: APXvYqyDhgcZ3AAOKsiDfhyLIgLOm19K53Xz5+hUWX4kQKNWo89ebLP6CbO2ftq2TXSb4AYZSkBSLw==
X-Received: by 2002:a9d:ece:: with SMTP id 72mr9187205otj.163.1559756294446;
        Wed, 05 Jun 2019 10:38:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id j62sm7904415otc.31.2019.06.05.10.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 10:38:13 -0700 (PDT)
Subject: Re: [PATCH 05/20] RDMA/core: Add signature attrs element for ib_mr
 structure
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-6-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2d77db57-1f93-d866-c49f-8ca6e671f6e4@grimberg.me>
Date:   Wed, 5 Jun 2019 10:38:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-6-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
