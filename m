Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C45D364D9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfFEThp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:37:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35695 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFETho (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:37:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so1867938otq.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 12:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OSFhHu2cvmsGB8nQlVybpQlT7Ecc7Ele64hu1sQg3YU=;
        b=WVFXRhUg7GsTQk5ZZgbH1FRTumA9xywecI0kGp6ciaKbimb60p8sjoVXMpbjkB0mxZ
         hqkF7HpVsZ7VfdjmLm3a+cN2cSlVGqvTjhHjz5B/j4deB4VGHT690dACz4mzSbXO/zYo
         B9HZzi6I8NWrGkCz2dMF3TM5UCjYI4SYNUWN5dkrOv8wfb7gFoNjmF6UpcGxous+CRhY
         gpQZQSsy9NjjhI8qRa+PQ/wo0M64bM0QdsCVTMfaSwAjiD1u50RyF3aIR3wxzmrrnG1e
         an63zMQWsJqRwIO1PlR1BHXu6ZdDsD+mHh3jO3qR1Q3RlWG9CkzU06CoO4YGIZ4G0ljg
         Pbog==
X-Gm-Message-State: APjAAAX6l9ZBPFqp45p3Gdi+bUZbABoJPBYPDYlf6Q5SgGEzO8Z994yU
        W7LFYZHBJL0ssAuQcg5qA/hoIH3v
X-Google-Smtp-Source: APXvYqzoBB6AAd4QPTiyFgEf3JkeV6UwkHlkdH3V3DMBYd5DmLr7zg9oIkfnPd4cyIE03jT5Q68iPg==
X-Received: by 2002:a9d:12b1:: with SMTP id g46mr11063043otg.84.1559763464232;
        Wed, 05 Jun 2019 12:37:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o10sm8018208oif.53.2019.06.05.12.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:37:43 -0700 (PDT)
Subject: Re: [PATCH 14/20] RDMA/mlx5: Move signature_en attribute from mlx5_qp
 to ib_qp
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-15-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b3f40f6e-ad56-4e6e-b36f-f8afed2e054d@grimberg.me>
Date:   Wed, 5 Jun 2019 12:37:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-15-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> This is a preparation for adding new signature API to the rw-API.

I think it would be good to write how this is preparing for this?
