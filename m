Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0483751B5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 11:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhEFJnH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 05:43:07 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41484 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhEFJnH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 05:43:07 -0400
Received: by mail-wr1-f51.google.com with SMTP id d11so4871322wrw.8
        for <linux-rdma@vger.kernel.org>; Thu, 06 May 2021 02:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=eYcTursilqoBb0NS6mUJy/uJbJscMo4ur2kt9ynsWpo6Iulym8I2i5OfcPGCxYhaEy
         LTWMCo3wxPZ75KemOqip1KMS7Cr+9+mWPc7dOP0EfajngFDDC8Pr3Qf0PxZ9ccKxeyW7
         vfmgogF2rnHVL1IMmjF95jODFkw6edsTMTbtcEq7B5aJmBAUbmeYkHw0+7j/+i9Oc60P
         7G1YlfXwDiTACu7L9PgSehsdCIRxApJQc2n0gw39IVEkrk2/mQxvXWmfPm0ojBvhAM+3
         ctx1NM3fIetExPvEXVdwb+dTH/FTHP7TWJ26H9cyMDxdFbmVQ4npW3Fpw1BVH+9oFi7G
         fGyw==
X-Gm-Message-State: AOAM533AZ2Ca6EAIGAKy3j2230DSD8zKcLpP4ZNjKETPDYV5iwavGfvI
        5O/O7x42I0f8JZtJKbR3+Rg=
X-Google-Smtp-Source: ABdhPJyUaqjAz3GRAiEx/ZRxrbT4E3AIC/Ncv/qVtgCa9NjThK9ECW54mRRUyP9vmj5C4k0L29EHAg==
X-Received: by 2002:a5d:55ca:: with SMTP id i10mr3858464wrw.299.1620294128513;
        Thu, 06 May 2021 02:42:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e504:8c1:c1db:d524? ([2601:647:4802:9070:e504:8c1:c1db:d524])
        by smtp.gmail.com with ESMTPSA id f6sm3983347wru.72.2021.05.06.02.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 02:42:08 -0700 (PDT)
Subject: Re: [PATCH] nvmet-rdma: Fix NULL deref when SEND is completed with
 error
To:     Michal Kalderon <michal.kalderon@marvell.com>,
        mkalderon@marvell.com, aelior@marvell.com, hch@lst.de,
        yaminf@mellanox.com
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Shai Malin <smalin@marvell.com>
References: <20210506070819.12502-1-michal.kalderon@marvell.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7290ab44-130e-1723-af23-8a5336b72334@grimberg.me>
Date:   Thu, 6 May 2021 02:42:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210506070819.12502-1-michal.kalderon@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
