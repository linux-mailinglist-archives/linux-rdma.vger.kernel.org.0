Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC292753E7
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 10:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIWI5t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 04:57:49 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34650 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgIWI5t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 04:57:49 -0400
Received: by mail-pg1-f173.google.com with SMTP id u24so3168809pgi.1
        for <linux-rdma@vger.kernel.org>; Wed, 23 Sep 2020 01:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TBPnG+CHB0X09ZgWc07SCH0OfizI4LGNA6p6v+TfQP4=;
        b=QDnRTHl+jMcYoHiT5y7rzax3srqVCJchLGvWntlj+MMQiZy1gpms+4LqTefGS9eOcF
         kOufkWjJZDG2uanVGYqU5BFzFr4LClTjT7/OWoV08PeEd0ndcRbsvjqRUDqZ+5x3/bMd
         YwCdr7dJogOLlSf5VQDxz4XLTmK7UtYse01eE3N7pkpkITS+Hv7cJl7mX1wuU/7MEtHZ
         2OCWs/SHPnJ0FprAY8nuf4r+7d/Q9HhriTea+72ySnTUyRIcbizcQ4vptK1/QUkob3eU
         9SUFWw3ytM1LsoFHRWlkfwOJNl/oJjJJD6ltLWhlB2wZTomMytyviBH9GoMD7yfcOxDo
         oxOA==
X-Gm-Message-State: AOAM533HVveWEdZQ8P4gEkjmTwtDbjSq4lNsbfUAi50NiUrmXcmhvLmL
        f4JD+oyOzCY7DKjBXy1JO50=
X-Google-Smtp-Source: ABdhPJycUVyMmGrv9UWGQ88lPh361ZNEGoPbgTOAxpti4AA79yfSfv0ZcdqpWoOHjeUBt80gdhXa2A==
X-Received: by 2002:a63:4a0a:: with SMTP id x10mr7023079pga.21.1600851469255;
        Wed, 23 Sep 2020 01:57:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a75d:44ea:221c:7030? ([2601:647:4802:9070:a75d:44ea:221c:7030])
        by smtp.gmail.com with ESMTPSA id i25sm18049893pgi.9.2020.09.23.01.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 01:57:48 -0700 (PDT)
Subject: Re: reduce iSERT Max IO size
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <20200922104424.GA18887@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <07e53835-8389-3e07-6976-505edbd94f2a@grimberg.me>
Date:   Wed, 23 Sep 2020 01:57:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922104424.GA18887@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Hi,
> 
> Please reduce the Max IO size to 1MiB(256 pages), at iSER Target.
> The PBL memory consumption has increased significantly after increasing
> the Max IO size to 16MiB(with commit:317000b926b07c).
> Due to the large MR pool, the max no.of iSER connections(On one variant
> of Chelsio cards) came down to 9, before it was 250.
> NVMe-RDMA target also uses 1MiB max IO size.

Max, remind me what was the point to support 16M? Did this resolve
an issue?
