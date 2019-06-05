Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74609367AF
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFEXAl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 19:00:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36235 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFEXAl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 19:00:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so202817otr.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 16:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Ik60QtC7FiMwTxcpiPOFuAakQ2qgPerabf6f+RmyOb4/+zGuUydsQbB+d5YFZnfzyr
         YlgrjDl4Amzor3WLbuhxthTl3PmRCsHRZs+FfY6Io3dqOUs/t7fnA9LmFKS4ZEzHcY/E
         KfRsxMMvADm6iZocdhUwzFFz7jBTNNtomm/s63vFQE2FdcdW1GLzSNdgoZT8rADtWfCz
         gK8sTBJbXXHg0xdbVoqGYH1GuC/YNUT+OyXDPpRlTolkyPTVwJHkSmR+IB83VhoARZxr
         115bVLnJwJS+BWLyihg9DUhcsAFFIMNHkR0z/kPlfBkKQ8WnPZHbTdyD/L9e2F5PFZTq
         8x8Q==
X-Gm-Message-State: APjAAAV53a6vAYW2KlZQiP8CiJ2vcSFuKGq1Zpn8+VkvXerfdqTHfm28
        pkagXEjQoGFgO82qJGY+HXk=
X-Google-Smtp-Source: APXvYqx3W3Bijhigp0coBQw3lqj1MamjD3GRJ2bktDJFng/668Cjjgr1VrMckrUPEjjvCnVBD+Nqzw==
X-Received: by 2002:a9d:7d90:: with SMTP id j16mr11238437otn.95.1559775640971;
        Wed, 05 Jun 2019 16:00:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id p64sm52712oif.8.2019.06.05.16.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 16:00:40 -0700 (PDT)
Subject: Re: [PATCH 20/20] RDMA/mlx5: Refactor MR descriptors allocation
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-21-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6f1e1df0-25ce-bdfa-2c9c-db59d3c2fbca@grimberg.me>
Date:   Wed, 5 Jun 2019 16:00:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-21-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
