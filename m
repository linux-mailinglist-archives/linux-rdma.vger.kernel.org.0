Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11B367A5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 00:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFEWzS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 18:55:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41813 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEWzR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 18:55:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id 107so168838otj.8
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 15:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XqEo3vTk41HFJXnw4daJzKG4WRKKUhPkluLU1iI+LMI=;
        b=O7HVNsALN1EUCzbde6ybuvsVF5Ybbi1Q+MVXVKRIb+yjbu0zdjttbAJl5SdWW2ikqY
         /81uCcwN9aqXC47SXTq6cDoCO1MFgVQn+rs9LHAi9C4smgYn6JeoGFdqwSDPWpcDJs0d
         3wR3YpT92XAk6pwaTD9Ap/hO17+q5xtOQ26FGmVlurs805BUtEoDGJnIRe2bNuOWdiFF
         3yVIVEGmPqZ4pr1ItGsEKJJRjMT9cNenCmv5sLEYQVhAyEb0NXznB3LeRgoB+Q/ILJyl
         vCWf4QmfrRZ5bcpWTfD6IbQLb7bRnPbslXYkQdxvCM5Eo1IKg+NGMGdeONppEEPEVZmy
         DvGg==
X-Gm-Message-State: APjAAAVs5juVTA9HVFcMjtLilf3OKzi7OYdkSn6adWNuCIoAiYprNVIH
        ibYAI1dFGWFqfQUqUGfSxP8=
X-Google-Smtp-Source: APXvYqwO6Gj5OCtaVbFf5suhutkteNln0HElj5GW8hnpdMC/zc4Gfepm6KoeuuwtniI4iyapV8whFw==
X-Received: by 2002:a9d:392:: with SMTP id f18mr11375988otf.115.1559775317116;
        Wed, 05 Jun 2019 15:55:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l31sm23688otc.30.2019.06.05.15.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:55:16 -0700 (PDT)
Subject: Re: [PATCH 16/20] RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
To:     Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, bvanassche@acm.org, israelr@mellanox.com,
        idanb@mellanox.com, oren@mellanox.com, vladimirk@mellanox.com,
        shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-17-git-send-email-maxg@mellanox.com>
 <20190604075336.GS15680@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e67e80cd-a2ed-b76d-21c5-1189b682b7fa@grimberg.me>
Date:   Wed, 5 Jun 2019 15:55:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604075336.GS15680@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> +	memcpy(ctx->reg->mr->sig_attrs, sig_attrs, sizeof(struct ib_sig_attrs));
> 
> Why do we need to do a struct copy here instead of setting up a pointer?

Yea, can't we use the mr->sig_attrs directly?
