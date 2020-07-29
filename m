Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C3231C38
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 11:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgG2Jjt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 05:39:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35394 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgG2Jjt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 05:39:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id 184so2283721wmb.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jul 2020 02:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=L13k9ZqUkn7YE6stiP/1Gj4ciXQLh/awVeTfDvnf5oDIp6mbFtcw3sl+ENnogQAjsd
         A17Yl2yGWtoOXJrquhtbsZcN43l2cwwQ13H39pnum8K/0Htrcg4tGtgdHPJFI/qTAHEe
         9x98xcWZ1HISVerUzU1g+zpa+nyKIIqZkjFfxUUe3bFEP0xepZPjTu3HBf0VptaNRPs1
         wrO9e17EYk3DoxDMXBFuGxZ/EDzbXQWWp8Bh5I0VyJY+Hw9r/cA0/yo4I4AH0C/JwK11
         hmjHyGmlS623yV7D0l0hsYMLeHPfPMWvcMkVYQjnMZlhGP6enZvdoR7PNxC1n4fJh+qf
         +MzQ==
X-Gm-Message-State: AOAM532gac6+4WxuKFxZbhzc7QFOV/sMc+jZ1KklVO7pCwemCgQfOYxh
        WdneBWrDEv0vdSlsXcwgzjw=
X-Google-Smtp-Source: ABdhPJwJ8pdhbwj/hkwuqzFaRA9qJpEP2EJLIDfEMsL04kSTtzng8ZlGDip7NbQ8OQ0Yrv8GPv6x/Q==
X-Received: by 2002:a1c:7f91:: with SMTP id a139mr7580314wmd.153.1596015587897;
        Wed, 29 Jul 2020 02:39:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8475:db3f:c2a2:c61c? ([2601:647:4802:9070:8475:db3f:c2a2:c61c])
        by smtp.gmail.com with ESMTPSA id j5sm4052964wmb.15.2020.07.29.02.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 02:39:47 -0700 (PDT)
Subject: Re: [PATCH 1/3] IB/iser: use new shared CQ mechanism
To:     Max Gurtovoy <maxg@mellanox.com>, yaminf@mellanox.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, oren@mellanox.com, jgg@mellanox.com,
        idanb@mellanox.com
References: <20200722135629.49467-1-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <465d7849-c2f6-f9c9-a8c5-d0ac62421c69@grimberg.me>
Date:   Wed, 29 Jul 2020 02:39:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722135629.49467-1-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
