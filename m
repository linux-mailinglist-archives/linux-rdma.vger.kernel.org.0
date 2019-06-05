Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5A362C0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFERei (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 13:34:38 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38386 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFERei (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 13:34:38 -0400
Received: by mail-oi1-f194.google.com with SMTP id v186so4510777oie.5
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 10:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=RKRg56fm9bXW1sGD3xs0AUhv8oL/yWqY8HoZcBMm1B8h/4MywkuKsPb8uukEFtRbg7
         dGHphCSc6GHxUdOWKv1yIcgM3xy5F87l5Hs+IHMQEW+hpBg81BsOKI+5KOD7PSe59c46
         7ayy5qu4OJrEYH7aMH4l1hMm2dxq6QZHEi4yxgDTazMasAHcr29sDkiLCW/ZKEOKIrsd
         /0mMicX3dekmXo1lTo/34WYBwrtkqJmcgXX8FJmnblFhSCs9YRZ2cN9A2WHwQhW/5L1M
         a7AgVoy7eI+9/pU7P59s5UmnYN8NNcVuAW8ACOfAVeb18Sb9zv7KZ91+f5uTB11E4Lb6
         wfzg==
X-Gm-Message-State: APjAAAW7IZR7XZuBbxyjFdNOm0//vQuTMkL621gqmCILoH4nL484ty4r
        4WycKe0ozJ2y/QRuWogkhVI=
X-Google-Smtp-Source: APXvYqyzKY7TNIWyJ+PqTdlFTA3mUAzn00uqeJD9nSXOrN9hoxBqF0yhciCWtvTj5Ezd6fHkmgwWtQ==
X-Received: by 2002:aca:bcc6:: with SMTP id m189mr9277062oif.45.1559756077863;
        Wed, 05 Jun 2019 10:34:37 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a18sm3063581otf.67.2019.06.05.10.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 10:34:37 -0700 (PDT)
Subject: Re: [PATCH 03/20] RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and
 ib_alloc_mr_integrity API
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-4-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ade1ec70-bc70-aa75-2025-1a46b8fc09cb@grimberg.me>
Date:   Wed, 5 Jun 2019 10:34:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-4-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
