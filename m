Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF5362BE
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 19:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFEReE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 13:34:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40529 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEReE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 13:34:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id w196so9291979oie.7
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 10:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ZAXnmsOZBtvTi7KWGfStyKVi4JMF7DQVT4DEygmkSVrouVkiWMhd5j5m/K7zDXrsqg
         D7cP6LR9v0CfWesT4ZBi4fnBev/98cSjRmpqcnAKC4snSHKmbVZtUJUZQh2U27moRI+q
         GuLSwDRVKKONq7lUvKvS1e42HnDHy+sm8y5p3oeMtIfRHoPZS0P6Ew8V+9IsPTWEaDju
         zlr/J5Vz/X1C1XJfM4BK7jLIw96IL+ZB6SEXkt7ny3mBN9BkhOiNx6gcxPpYBttdL7Zc
         CIQoK9gLeyyUCAIUsrGAjJiiafSk27Lpo0kKupqGKMgughCZ2id64/s0FFFEWg4jmQaP
         bzNg==
X-Gm-Message-State: APjAAAU2rjIf3GY7cd6f9tYpxMNqhucLUgs+NyNS3SPU78Z1et/Wtn4h
        /XQaECYpQVmlkElGi6VKk20=
X-Google-Smtp-Source: APXvYqzZPK7nWRi+wBNjfz51iOBSbRfDMzVxP4nk4tI50unKWPARUIMIVnDmQyhV0anUTNSKpH6lzQ==
X-Received: by 2002:aca:fd0b:: with SMTP id b11mr5680078oii.109.1559756043432;
        Wed, 05 Jun 2019 10:34:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id z30sm1734501ota.75.2019.06.05.10.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 10:34:02 -0700 (PDT)
Subject: Re: [PATCH 01/20] RDMA/core: Introduce new header file for signature
 operations
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-2-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <28880806-936c-0a40-43b8-dbb2257aa1eb@grimberg.me>
Date:   Wed, 5 Jun 2019 10:34:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-2-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
