Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A405513DD
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jun 2022 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiFTJPi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jun 2022 05:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbiFTJPh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jun 2022 05:15:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504F110545;
        Mon, 20 Jun 2022 02:15:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EEB761F383;
        Mon, 20 Jun 2022 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655716534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2V9KSRIUnTh1AKpdFntEf9h9/SEqHZY2hYmAfEYCjwM=;
        b=eEInt02yyEclQvA3D0SEGYc+rq9mULoWJl23aC/cc/WeOmQgssYUM0bgKG81gyKXZ1AEwL
        zwgK1/zm7xktivSvVNd+3KJm6nF+rTnXLRHJ8Fs3moVubMR7NY2YZM6mlgTfBOjHY+1pRg
        DaVklmB3dW5hOQSdHB0NUAhfDHKFrq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655716534;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2V9KSRIUnTh1AKpdFntEf9h9/SEqHZY2hYmAfEYCjwM=;
        b=KPcE/23utxmgudhl1CPBNXRHmmtKptsgtoHx9pw6K9ndhhzbUSv/5Bnae1veZijcAWD+Kb
        SDp56DXqSUrZPPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD3BF134CA;
        Mon, 20 Jun 2022 09:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u6HQLbY6sGITPgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 09:15:34 +0000
Message-ID: <28d5b284-f9a6-27f8-58e7-ccbbe8fe3214@suse.de>
Date:   Mon, 20 Jun 2022 11:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/5] blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, bvanassche@acm.org, hch@lst.de,
        jejb@linux.ibm.com, martin.petersen@oracle.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com
Cc:     linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-4-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1655463320-241202-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/17/22 12:55, John Garry wrote:
> With new API blk_mq_is_reserved_rq() we can tell if a request is from
> the reserved pool, so stop passing 'reserved' arg. There is actually
> only a single user of that arg for all the callback implementations, which
> can use blk_mq_is_reserved_rq() instead.
> 
> This will also allow us to stop passing the same 'reserved' around the
> blk-mq iter functions next.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq.c                    | 6 +++---
>   block/bsg-lib.c                   | 2 +-
>   drivers/block/mtip32xx/mtip32xx.c | 5 ++---
>   drivers/block/nbd.c               | 3 +--
>   drivers/block/null_blk/main.c     | 2 +-
>   drivers/mmc/core/queue.c          | 3 +--
>   drivers/nvme/host/apple.c         | 3 +--
>   drivers/nvme/host/fc.c            | 3 +--
>   drivers/nvme/host/pci.c           | 2 +-
>   drivers/nvme/host/rdma.c          | 3 +--
>   drivers/nvme/host/tcp.c           | 3 +--
>   drivers/s390/block/dasd.c         | 2 +-
>   drivers/s390/block/dasd_int.h     | 2 +-
>   drivers/scsi/scsi_error.c         | 3 +--
>   drivers/scsi/scsi_priv.h          | 3 +--
>   include/linux/blk-mq.h            | 2 +-
>   16 files changed, 19 insertions(+), 28 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
