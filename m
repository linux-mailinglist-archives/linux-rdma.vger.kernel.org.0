Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2436785
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 00:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFEWcI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 18:32:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36744 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEWcI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 18:32:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id c3so146736otr.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 15:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C923KQCcZor53yxkZDJt5iJIbdc1SEeM68FKOjc/BvY=;
        b=cl1rXsZZCyQ+QCu+XjvSBrrbSoeSip/B5tdcFuGh5EQm1+z8G2i5+Za9Q6w04rcf2W
         bzNihGWeybLWwS5O00/F6jckjDFbKYCDtBzUliiisgPJmFbQOAY6uFs2MF6+Oc5jy8n/
         7v1UuzLtN1U5czNJpPCJlRQiLt6PrN16utB7MMKgP3B8HOY7FPCYJqf5rVLcElFWOxVo
         VkLeXb6aBJ82SMbjaB56D1c+5yuYktEBa9O4rW1B7+7hdQbEceQaD3rT4S7dgnyD5522
         u3+LvCkexgdzbc22BBHpx4SnkCfYxPDYs6hydqJGvtEiEwsqKwp/OiTs9H6F3UjbI+W3
         +P2w==
X-Gm-Message-State: APjAAAUBycSumzwXIrfVPddv3AmWWOowIHkUHbaWAyxRA1QMIJzqXB9G
        ti2bipKd6ABPRiGKZa/IQYQ=
X-Google-Smtp-Source: APXvYqxy0AjlhOhREF0xZRIdSFV6SqLjIz1dRSryWmysBit1CcYCPM7Y4E/tWv2eWC6TBTI9M1IMfw==
X-Received: by 2002:a9d:12a9:: with SMTP id g38mr12048204otg.125.1559773927893;
        Wed, 05 Jun 2019 15:32:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id s63sm15257oia.34.2019.06.05.15.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:32:07 -0700 (PDT)
Subject: Re: [PATCH 10/20] RDMA/mlx5: Introduce and implement new
 IB_WR_REG_MR_INTEGRITY work request
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-11-git-send-email-maxg@mellanox.com>
 <e058cb80-7000-781d-8455-581ee5dee1b5@grimberg.me>
 <d4d4338e-f655-930b-b201-cd5f80c47bc2@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d22098b7-33b5-909f-faf6-6ba9fb71d6c9@grimberg.me>
Date:   Wed, 5 Jun 2019 15:32:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d4d4338e-f655-930b-b201-cd5f80c47bc2@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> +    if (!prot || (data_key == prot_key && data_va == prot_va &&
>>> +              data_len == prot_len)) {
>>
>> Worth explaining in a comment that this is either insert/strip or
>> interleaved case..
> 
> there is an explanation that you wrote (I think it's good enough):
> 
>               /**
>                   * Source domain doesn't contain signature information
>                   * or data and protection are interleaved in memory.
>                   * So need construct:
>                   *                  ------------------
>                   *                 |     data_klm     |
>                   *                  ------------------
>                   *                 |       BSF        |
>                   *                  ------------------
>                   **/

Right :-)
