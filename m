Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2393678E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 00:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFEWhV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 18:37:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46230 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEWhV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 18:37:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so109685ote.13
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 15:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=RITWU4Ye4hjb4QJb+jnuLgOCYW+LGqL8D8qWxI2VFYVmthux9TrIkTrZa5WjdPHrxE
         6sBCH+w6RDOZ83Uv/R59hS+oal/epIzpYS386u1Q/s9QO0f7lbM8LmOGu/ojLFNZOuI4
         6GRhesh/PzBFmNam9pFCvL0hx1PU0bP+FeH6BB/rMwNgEwZ+DPqL6S1Bx/WxQEfwTGF5
         lgy6mNB7sirSgUgsX7gjH2Zhofn/m4WqiPGsL9FsM4z6NzrvdGbZF7584nDt6l8mchwK
         9+LNzk8lONlIhONsv3sED5KKIeUOtIwoASrIjItuEHHyZusVKnth4sXYGKTodimgyE0S
         +gLA==
X-Gm-Message-State: APjAAAXVHmflarBXR3KIS5b1l2csglNUEhjhSy5GFJwWTwyOE3RSsHLI
        2VP7NVg1Ermi++VytpyMTnK+yIgl
X-Google-Smtp-Source: APXvYqzMQGFqZuV9p3ResDVJ8lQSEGY//LBzVumXTYQZnHUybKF5etQkdHEcyxez8GF9lamEcUjofQ==
X-Received: by 2002:a9d:69d9:: with SMTP id v25mr7200950oto.4.1559774240912;
        Wed, 05 Jun 2019 15:37:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id h1sm7104412otj.78.2019.06.05.15.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:37:20 -0700 (PDT)
Subject: Re: [PATCH 17/20] RDMA/core: Remove unused IB_WR_REG_SIG_MR code
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-18-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <00ccc7fc-e837-db88-573c-54c1bf04d973@grimberg.me>
Date:   Wed, 5 Jun 2019 15:37:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-18-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
