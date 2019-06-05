Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64508362BF
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 19:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFEReN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 13:34:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41794 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFEReN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 13:34:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id 107so1480369otj.8
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 10:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Rnq1plBLSjikuDTcLcoj2mWNKzfo+aC1qCdCCh5BvT2Ellv9u6swc5eJMFGM10e43Z
         VAaUPeMPb0TSK+5ZByQ0bWYXXbEVVKyO6ZAb0NBnBe+37OXzIrYoiuRp13bqKoWkoJn7
         B5shgq6KcsCp3IzJkzv9iRKFV6MUp7GBrssLpRkaNlgF3gMe6UwCrJS/N3C2FW8G029u
         SIwWBufaQxMMpbi/OPuQZ4aR0kQEoId3OS4ouJfpXlmlVcmbCJ+BBOjxCMtnQJ95Q6gU
         CCDZ6McSKK7wdhFxi19uBNBNAH04Zm1IQyDmqLZ4rz2PPiVWTyKWgEHogcykhhCeDIFI
         IUgg==
X-Gm-Message-State: APjAAAUdXhGzfsiEDY+8ah5oKFZSDhE9mQJkAaNm/SdI/EypCW/w082b
        sOzl9prJuNYB1e1x1s/SPHg=
X-Google-Smtp-Source: APXvYqxnkCZaVvLm1cM8NxA5JmqFLTFpncw9ST6xRNp0nQrH86TY1hRE9otsl8s+W0mzM6DkGoj7Lw==
X-Received: by 2002:a9d:2af:: with SMTP id 44mr11199773otl.187.1559756052664;
        Wed, 05 Jun 2019 10:34:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id s201sm8393742oie.40.2019.06.05.10.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 10:34:12 -0700 (PDT)
Subject: Re: [PATCH 02/20] RDMA/core: Save the MR type in the ib_mr structure
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-3-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9d7c391b-7e5f-9778-870b-d104af586d0f@grimberg.me>
Date:   Wed, 5 Jun 2019 10:34:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-3-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
