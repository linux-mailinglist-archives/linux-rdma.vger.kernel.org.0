Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D974C364C1
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfFETd6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:33:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39493 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFETd6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:33:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so1837202otq.6
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 12:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yYRmxaKRpjrZ8CV/K8p8rGSc5ffL/MhCU6JHgTXcdKs=;
        b=MGY8XjtoLxKwG4ju3WxFM4V/dn9CQjRjlYYVySjpFKu4ZO3Xu38YQvWd4QqXDroQYk
         p5fDBith2LU+qLEpH7yGuvzAZxOHT4O3tRztRLx79Zg/seJ1X4f57XUun0nusq5+Q4YJ
         d7YHDZb3ySSmzT/3cW1iKlITS/FDqO7CTsqvnjyQXfA+/lSo26kyTI+YbmQv8mb6YI55
         V9LJH4IKZ2eGramgIA5JuJ20fMYCwJoToz0FJesa/EY9KSsS14plTkarP5EBcWfKcDVV
         MOqkzRsCDtqM5GyF38H1+MYATSYVc4PitXtF+lsZ1rQrN4M5WF15ZcQ+RBFW9ICF1fAc
         6ssw==
X-Gm-Message-State: APjAAAVZDdI0droGlfyEueSvGyqUGBc/ewkKyNv0dY4/ejjDpxBqSkLH
        +6Xh+I9HB5OFHTpVr58cqK8=
X-Google-Smtp-Source: APXvYqx5xsGVkKEe6Y01+g77ggwLmeXUryw1M1mvnnXQHb8z86JNoTixLREjQp5EYhE41W5dlqt88Q==
X-Received: by 2002:a9d:3de6:: with SMTP id l93mr6407264otc.51.1559763237986;
        Wed, 05 Jun 2019 12:33:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id m12sm5832012oic.51.2019.06.05.12.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:33:57 -0700 (PDT)
Subject: Re: [PATCH 11/20] IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-12-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2d6c4cde-18a3-955c-bcf8-3ff4f0748dfd@grimberg.me>
Date:   Wed, 5 Jun 2019 12:33:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-12-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This looks good!

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
