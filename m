Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C628754FB0E
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jun 2022 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383278AbiFQQ3e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jun 2022 12:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiFQQ3d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Jun 2022 12:29:33 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73F141FAB;
        Fri, 17 Jun 2022 09:29:32 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id e11so4599320pfj.5;
        Fri, 17 Jun 2022 09:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x3T4D+yOaq9lo8BU1AjLyhVwMBWPQQL/H4Z2pOmaK6c=;
        b=4Khl2gGRyf7L+43yiabdDjXBA8VqhRIIDFlcT73gSUHUOiyPnHRkzw2Gq3DeSzAf0K
         CNguU7xpfX8rFyeAbRIVKcHjXRq8qL6dbJsYuKFHETjV9Q+CS8i421WFFC2tWQsVqF5E
         oaI6nJnLaMr3Jm4KBZdqy1oZNFuFmtwGs0Iu8+vTCVEwElXcHU9Qxnc050ubSVxjV3cE
         l3RRKikInhH5jyKZF/55fzJLHPXKj5uN9VprHGQ6gza+FDQUobtFM65IqMPEHjGwfs9Y
         ZoGf5vAK2izkpL0zZ7unc6INr25JosfXDxx0nuGClwsaPXwEs9C0NL8SgZGFe7aI/v9+
         /qyQ==
X-Gm-Message-State: AJIora++7bu4wBhKDS8uS1k2t7k8ZP7/iBuNmwJTEhQsUhjZSyKi3EPs
        /ZQX7nLN2AmUh1nE/dhpHPY=
X-Google-Smtp-Source: AGRyM1stNp1gT9uJQRkH23ZVZcEfOLXxdhPmA8X/nMhdFsuF8GV3jpeyCFDLLrooGlCGjlATeQWtWg==
X-Received: by 2002:a05:6a02:201:b0:3fc:6071:a272 with SMTP id bh1-20020a056a02020100b003fc6071a272mr9888178pgb.518.1655483372280;
        Fri, 17 Jun 2022 09:29:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id o2-20020a17090a168200b001e31c510f10sm5637387pja.54.2022.06.17.09.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:29:31 -0700 (PDT)
Message-ID: <6d84b3cb-a362-05ae-c7c3-62d3eddf9f02@acm.org>
Date:   Fri, 17 Jun 2022 09:29:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/5] blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com
Cc:     linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-4-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655463320-241202-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/17/22 03:55, John Garry wrote:
> With new API blk_mq_is_reserved_rq() we can tell if a request is from
> the reserved pool, so stop passing 'reserved' arg. There is actually
> only a single user of that arg for all the callback implementations, which
> can use blk_mq_is_reserved_rq() instead.
> 
> This will also allow us to stop passing the same 'reserved' around the
> blk-mq iter functions next.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
