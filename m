Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89DABE6B0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbfIYUwc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 16:52:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43043 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfIYUwc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 16:52:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id o44so3572ota.10
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 13:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BFDm7bC+G9QL3HWU4EYk+7NKvCZUCnpbtH3C29T3oyLWwhLo+PIpcoJM1fYhKwkeDw
         AoHLzF8LYE54JsFuYS+J0QNOVVVJtkYsS+WG6L+vWFIgLikyuD5yd8SzF0VML94bailY
         3jnM9wuKNAkdfjxbdMVnVbs0i4SCJfkYdJKAy/udQKnaQT4fZEdO4BXHgP6bkwBwWwtO
         YQ9sNuuAs+PiehxM8CtfkfQT7EiFwLtUUGojiOQyrNS/Uv9W1Yt2Z47euZSY76h5rMY8
         7yTikYaUURZXnIpW9QPzGHBgc9SN1sR/HhUYUxSm7frH4aUH/yl5bL+AU5obMcuZvSxn
         k/Ug==
X-Gm-Message-State: APjAAAVKZlyARkkpAe+3VQrsbcxdK81BgWnHrkERaXG5APPAY7ZbETuV
        8PjmHea/El6GVEtWwtF17kQ=
X-Google-Smtp-Source: APXvYqzycX/wrfH9sWik9hitwFu3xb2FcgsCGAbHrOibAvgaW9J5fNo1J62ezucI5IxM31se/BsZIA==
X-Received: by 2002:a9d:128c:: with SMTP id g12mr43549otg.239.1569444751554;
        Wed, 25 Sep 2019 13:52:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id n9sm2088992otn.4.2019.09.25.13.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:52:30 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/iser: remove redundant macro definitions
To:     Max Gurtovoy <maxg@mellanox.com>, jgg@mellanox.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com,
        leonro@mellanox.com
References: <1569359148-12312-1-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <75490168-e8ab-bc1c-8755-a641a5b278af@grimberg.me>
Date:   Wed, 25 Sep 2019 13:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569359148-12312-1-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
