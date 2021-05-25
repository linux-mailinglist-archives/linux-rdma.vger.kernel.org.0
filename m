Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD57A3905E3
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhEYPyK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 11:54:10 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:41729 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhEYPyJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 11:54:09 -0400
Received: by mail-pg1-f173.google.com with SMTP id r1so8221807pgk.8
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 08:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AyPB6++3ab02wP7rdnsqF2K+nmGNG8JnFlxZ/NnYux+uJQD6EY2jBiq2c0fM0QSWQ1
         z07defaa5NkBohddXM7XRPAdewk+lEww8A20nEGjtnqmkJnHpYoo6ukdF88fhpPfUikO
         VhWTBlWHD3Vyf8gZyUYFxuT3R0KUo78EQskhgiobNK/ma7f7SE3GQh6GKpY8G/7zvP/B
         a3g/JRU1KThCodqW0TCYRTSjUa9ckPLHKbnC4IljK+N2nqXOtJY8CtsU22iu5MJP73jV
         C7r/abQgL1FyzZCGZe7j77HRbEv4NPmk0VUQthRfFbJipcgoczQYze3Qr0gEqo4GrTCH
         ezaQ==
X-Gm-Message-State: AOAM533H+/674HDxCYcrBP6w8qYpwisRaOOS/jWUwWm1jqEEEJEiHWpb
        XwRyuLmwQIdveV7ivIIytOg=
X-Google-Smtp-Source: ABdhPJyqERrDfI/xijyjm3Z/64ZSAnRvD5+rrLpvT+p9caQogPe0akFN4td3RfOuUvLrOLpRtnBfVg==
X-Received: by 2002:a63:1149:: with SMTP id 9mr12561555pgr.156.1621957958907;
        Tue, 25 May 2021 08:52:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4f6:7b8c:d4a2:7714? ([2601:647:4802:9070:4f6:7b8c:d4a2:7714])
        by smtp.gmail.com with ESMTPSA id o5sm14014678pfp.196.2021.05.25.08.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 08:52:38 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/isert: set rdma cm afonly flag
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Cc:     israelr@nvidia.com, alaa@nvidia.com
References: <20210524085225.29064-1-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <585d04b8-9f7f-e9fe-29b5-6b495c0b4fe3@grimberg.me>
Date:   Tue, 25 May 2021 08:52:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524085225.29064-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
