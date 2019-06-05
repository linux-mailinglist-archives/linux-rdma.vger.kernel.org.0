Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64645364CB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFETgE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:36:04 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41435 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfFETgE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:36:04 -0400
Received: by mail-oi1-f169.google.com with SMTP id b21so15124314oic.8
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 12:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=tloYKB8ZB+z/GmyiqCe+92/P2z6kZWng27EsZ/9pTFkz5EsooaluxO6zZwEHTBOBlI
         RsfgxC4gcmDgXqtiIxApSfgqxB6ASHRgM0mGa39b8KkTE7qEGsgwZLKwO1tvaAAuFZUE
         S0wdMFzrP1D2WHDzS2IMN8VPAH+YuHQeWEI3HOWqAiIMhCOlG+sIFfhzTkYTTsGYpiDd
         ls9qMHjESTl0LYuIaU8Aana/GSWHIGijkD6S2VPQo3bR0Mg3EMuPQNF9QOYORvbCve3D
         k6+h3N0Cf9SeY/xT+bRuGiRwQC6kdR2ZYFnbeBILcKxP/+BZlJorVeUHpQX5+pojYnMY
         UpWA==
X-Gm-Message-State: APjAAAVXbTYB1h7f8Ru6izDsPExDZDLwVdkmyX+llyB+9Q7cSHB3qGJc
        Pj7x4+sw8LShBK4AGaWqdhc=
X-Google-Smtp-Source: APXvYqxLg2zyvnaGQwocTjIzDvKd3W7yDliAuDCuS3xFnS8jzpKLSWextprGCEzgcZDZuvL9k8R8qw==
X-Received: by 2002:aca:f513:: with SMTP id t19mr2304220oih.76.1559763363329;
        Wed, 05 Jun 2019 12:36:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id d204sm8088893oif.3.2019.06.05.12.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:36:02 -0700 (PDT)
Subject: Re: [PATCH 13/20] RDMA/core: Add an integrity MR pool support
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-14-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <df1143e7-8f16-9007-d8ab-d84775d95e80@grimberg.me>
Date:   Wed, 5 Jun 2019 12:36:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-14-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
