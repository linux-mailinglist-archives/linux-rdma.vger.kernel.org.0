Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED755B25C
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jun 2022 15:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiFZN7B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jun 2022 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiFZN7A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jun 2022 09:59:00 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DE9DEF1;
        Sun, 26 Jun 2022 06:58:59 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id v14so9497042wra.5;
        Sun, 26 Jun 2022 06:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2AbSkeFZUioPAQ3a70nNyeL3mIPEJabq4zioJ0USaqA=;
        b=geSJHIbg5t3jd54nRzJoLOR/s7fT7SkWRtJuYJnPsWfbEZyqK4XKlBl3ZvBskPd2oj
         k/soBnos/N0cL8mZfrCw6KqM7WOgIyQzDzmP9esNMGls56ISU6KAGcithnhQnqvmBlRz
         wjrFKNY5pvcjCBvfS4Ieron3r35hz1SP8j7aNwuBcUFA4SV+Ik7OChn9qc3++2EUzzs1
         miSJsOflGOYxku9ZqzRgrbdcdDq78z/EjEmt3o1By8yXjKw9uottB0Nl1j1B9PsOLh5T
         4ZGjMsfNctiLedXxhlTrwnPNpy8PmrVDvEb8aiUMiKcK5cj8ubAowDLWjrsYHD9IRpw2
         PTog==
X-Gm-Message-State: AJIora9lifaGOyMShuRarCPnfspoj6gOeu5wlIVQUn0lNDkCtTMAMvJ7
        RdRMC7ybQnQAMkBmnLQqQOw=
X-Google-Smtp-Source: AGRyM1tsNjy9pUQ2/KlwB69wacP4xwTylLY6Td/+6NMMtK1xKOX8O1lC5Yu/j8LwK2/38EbSaAC5PA==
X-Received: by 2002:adf:f102:0:b0:21b:8bba:5025 with SMTP id r2-20020adff102000000b0021b8bba5025mr8255000wro.174.1656251938109;
        Sun, 26 Jun 2022 06:58:58 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l16-20020adffe90000000b0021b9a4a75e2sm7723716wrr.30.2022.06.26.06.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 06:58:57 -0700 (PDT)
Message-ID: <bb9ba2df-ca20-1126-4393-d2f1e6ba6a1b@grimberg.me>
Date:   Sun, 26 Jun 2022 16:58:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/6] blk-mq: Drop 'reserved' arg of busy_tag_iter_fn
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, bvanassche@acm.org, hch@lst.de,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de,
        satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com
Cc:     linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
 <1655810143-67784-6-git-send-email-john.garry@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1655810143-67784-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/21/22 14:15, John Garry wrote:
> We no longer use the 'reserved' arg in busy_tag_iter_fn for any iter
> function so it may be dropped.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   block/blk-mq-debugfs.c              |  2 +-
>   block/blk-mq-tag.c                  |  7 +++----
>   block/blk-mq.c                      | 10 ++++------
>   drivers/block/mtip32xx/mtip32xx.c   |  6 +++---
>   drivers/block/nbd.c                 |  2 +-
>   drivers/infiniband/ulp/srp/ib_srp.c |  3 +--
>   drivers/nvme/host/core.c            |  2 +-
>   drivers/nvme/host/fc.c              |  3 +--
>   drivers/nvme/host/nvme.h            |  2 +-

for the nvme bits:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
