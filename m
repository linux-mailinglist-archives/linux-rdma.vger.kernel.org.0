Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F4F5513F0
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jun 2022 11:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiFTJQ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jun 2022 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbiFTJQY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jun 2022 05:16:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE99DEF0;
        Mon, 20 Jun 2022 02:16:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF0561FAC7;
        Mon, 20 Jun 2022 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655716582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkZ/s7WtxAVkUPGyFHjjsumLTjVdh8+OYxSihbuC8vY=;
        b=AT4AJuShz4HqBI2nlNRveK+IXlQV8HIOKAgtrR2dlMOMs20lwZHTyCbhE5eEk8tI/cG/fj
        quaiOztyq0SMOWroxPTUcgPBBHEEwj6WJHy+ROUkSs/TpDjBAUgInuK1DliqMkKE/IOTfX
        BqL6WAPrDjNpcJ7KOac8i/pepCoiIE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655716582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkZ/s7WtxAVkUPGyFHjjsumLTjVdh8+OYxSihbuC8vY=;
        b=hQzyTiyG7q8KmJWCAEayXC6ZF4/JTsIl4bU+RsHupP/su5ogfLFj+IAglbIHxtqzPUIhsL
        feoOPgyoZEA8q6Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6ACE134CA;
        Mon, 20 Jun 2022 09:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3sI0KOY6sGKXPgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 09:16:22 +0000
Message-ID: <97f428d0-8039-709c-f632-db1acc9a4315@suse.de>
Date:   Mon, 20 Jun 2022 11:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 5/5] blk-mq: Drop 'reserved' member of busy_tag_iter_fn
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
 <1655463320-241202-6-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1655463320-241202-6-git-send-email-john.garry@huawei.com>
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
> We no longer use the 'reserved' member in for any iter function so it
> may be dropped.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq-debugfs.c              |  2 +-
>   block/blk-mq-tag.c                  | 13 +++++--------
>   block/blk-mq.c                      | 10 ++++------
>   drivers/block/mtip32xx/mtip32xx.c   |  6 +++---
>   drivers/block/nbd.c                 |  2 +-
>   drivers/infiniband/ulp/srp/ib_srp.c |  3 +--
>   drivers/nvme/host/core.c            |  2 +-
>   drivers/nvme/host/fc.c              |  3 +--
>   drivers/nvme/host/nvme.h            |  2 +-
>   drivers/scsi/aacraid/comminit.c     |  2 +-
>   drivers/scsi/aacraid/linit.c        |  2 +-
>   drivers/scsi/fnic/fnic_scsi.c       | 12 ++++--------
>   drivers/scsi/hosts.c                | 14 ++++++--------
>   drivers/scsi/mpi3mr/mpi3mr_os.c     | 16 ++++------------
>   include/linux/blk-mq.h              |  2 +-
>   include/scsi/scsi_host.h            |  2 +-
>   16 files changed, 36 insertions(+), 57 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
