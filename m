Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D61CB15FD
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 23:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfILVpq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 17:45:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44668 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILVpq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Sep 2019 17:45:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id 21so27519625otj.11
        for <linux-rdma@vger.kernel.org>; Thu, 12 Sep 2019 14:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3rRwpJFwBPUulMQVtfgTqxnlFgmWXlBO+OampqTZSEk=;
        b=iLniVTVf0XWXkqJOUDUNYRHGKlibMgnbXrlTHCdRTrboTL1Q7O3vrhF2i2Qd2VcmDM
         8pjgsm694fr4xb1+pcYwfGbuMOniApvEGbCDkpp+AMypDT10kZaEEsS7wg1z2VO9xjAW
         TmuKMaT7tLm4+2ZxIX3nwZtMxBRZfEo1twJ9soJncMZZL4c2tco9tzOQR/vqO5lsnogq
         uflg3vBjjx0imJj0c+AiUVJHW8RM39X3bFl5ySe8gtNNSbtw9CtgmJ7QqJ3+PzDvz4kf
         Ne0/1rP8cEbjVP5BehoLfEE7RUradgYv2F/CaXMU8EOsIDKsNUzZ52JiGV9k7wHTVQXw
         APYg==
X-Gm-Message-State: APjAAAUfS05+G8v6hrVy5RPkxvvPxgoUMPkZZM226BJpAEiEB30Vby5e
        wqwTZ/I3fbpD4HcaSbuAVpNOBvHD
X-Google-Smtp-Source: APXvYqyCS3wiu/iGVRS4Ag6S1k5Eluti1hRAsaPYJR9/19MVWk9ehXqmkFQ3/YQDwZheSPEqwO9ctw==
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr34962367ota.143.1568324743459;
        Thu, 12 Sep 2019 14:45:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id c24sm8978079otd.57.2019.09.12.14.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 14:45:42 -0700 (PDT)
Subject: Re: [PATCH v1] IB/iser: Support up to 16MB data transfer in a single
 command
To:     Max Gurtovoy <maxg@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sergey Gorenko <sergeygo@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190912103534.18210-1-sergeygo@mellanox.com>
 <20190912151931.GA15637@mellanox.com>
 <b49453d9-d419-f804-35a9-757a9b8206b9@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <31f80a22-04dc-d144-7bac-940eb8f2b97d@grimberg.me>
Date:   Thu, 12 Sep 2019 14:45:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b49453d9-d419-f804-35a9-757a9b8206b9@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> Maximum supported IO size is 8MB for the iSER driver. The
>>> current value is limited by the ISCSI_ISER_MAX_SG_TABLESIZE
>>> macro. But the driver is able to handle 16MB IOs without any
>>> significant changes. Increasing this limit can be useful for
>>> the storage arrays which are fine tuned for IOs larger than
>>> 8 MB.
>>>
>>> This commit allows to configure maximum IO size up to 16MB
>>> using the max_sectors module parameter.
>>>
>>> Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
>>> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
>>> Acked-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>> Changes from v0:
>>> - Change 512 to SECTOR_SIZE (suggested by Sagi)
> 
> is this always true ? 512 == SECTOR_SIZE ?

 From the documentation it is, and nothing suggest otherwise.
/*
  * The basic unit of block I/O is a sector. It is used in a number of 
contexts
  * in Linux (blk, bio, genhd). The size of one sector is 512 = 2**9
  * bytes. Variables of type sector_t represent an offset or size that is a
  * multiple of 512 bytes. Hence these two constants.
  */
#ifndef SECTOR_SHIFT
#define SECTOR_SHIFT 9
#endif
#ifndef SECTOR_SIZE
#define SECTOR_SIZE (1 << SECTOR_SHIFT)
#endif
