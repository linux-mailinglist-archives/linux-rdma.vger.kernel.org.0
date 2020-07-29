Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7738C231C39
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgG2Jj6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 05:39:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51742 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgG2Jj6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 05:39:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id p14so2110151wmg.1
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jul 2020 02:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YYaIY9bjHV3jVgsHd+lTa0k8JhDRTAjAqGZmZXz4FL7AQpmgSjyx4EkL8MiVtaC9dD
         MqM0WCI2uPE5iILhoKPdO4yPmTs0kIH+wqUAte+CH962u0PySjDNt58zLxt9z77ZzOdu
         EECugKa8+/FZIxCzBXdkJvpYUyYZLBlJ/9U4DT6EFMlN5RxGIgRohFmBWIC6wCysEWkI
         6YwQk20pUEicU+hgjhcdLARbF86cE483Sf5IkJD2YjtVf/woZxshZ1KCBqj5qjUHdnsO
         9qkbKjeBVOBYjcMXVwT5cSi+1sNNt3+9xkGWEQymbCFEsj8mLAl6azeb3CUXljV7J+9Q
         3vNw==
X-Gm-Message-State: AOAM532vI3FMNFuYldbbSLQCcWuj7Wn8htCyhAyxvMRLOuL1YN5u1pfA
        aYvp1hjedFsa/xIcyMTOqm8=
X-Google-Smtp-Source: ABdhPJzEE03DjCdpXnW0zIT5+jK83QUj4Zq5QnshuHYwgDhtyGebp12gNTe8ozyTBN6BvUq7zIW/6A==
X-Received: by 2002:a1c:b787:: with SMTP id h129mr109541wmf.93.1596015595678;
        Wed, 29 Jul 2020 02:39:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8475:db3f:c2a2:c61c? ([2601:647:4802:9070:8475:db3f:c2a2:c61c])
        by smtp.gmail.com with ESMTPSA id 32sm5582263wrh.18.2020.07.29.02.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 02:39:55 -0700 (PDT)
Subject: Re: [PATCH 2/3] IB/isert: use new shared CQ mechanism
To:     Max Gurtovoy <maxg@mellanox.com>, yaminf@mellanox.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, oren@mellanox.com, jgg@mellanox.com,
        idanb@mellanox.com
References: <20200722135629.49467-1-maxg@mellanox.com>
 <20200722135629.49467-2-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bf2b2b58-f599-a22f-91a1-5c2d51772608@grimberg.me>
Date:   Wed, 29 Jul 2020 02:39:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722135629.49467-2-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
