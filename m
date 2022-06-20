Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5275513E6
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jun 2022 11:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbiFTJQC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jun 2022 05:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbiFTJQB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jun 2022 05:16:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF0E11461;
        Mon, 20 Jun 2022 02:15:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 886301FA93;
        Mon, 20 Jun 2022 09:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655716556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwQ4wbJ2J3BpsHA9sanoJTXO4MMQzFNGd9/de0EGoBY=;
        b=0evdLip207AMccHMFhzVsCpz9WWDB8kZBWhy46M1Os/TZq8J86x5R1wXT0FMZM5wk1rAKv
        2hliiqFK/qcQVwYmwSCmlIajWgZKhDzTA6fKL8lgt9C8D8nGJqthRywxi7sAyRrSyde036
        OUUL7i7k98RUdKjS3owRzEbPwyc4AMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655716556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwQ4wbJ2J3BpsHA9sanoJTXO4MMQzFNGd9/de0EGoBY=;
        b=cQYqw4WBBdTSCSXGh9NrtwH3roY9H/MFeqRDYT+tT+h2/mPXHCiXbuc1VvoURkrcB4IcV4
        ZmMmzxRfzzuriWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63B26134CA;
        Mon, 20 Jun 2022 09:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VWQgGMw6sGJLPgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 09:15:56 +0000
Message-ID: <3a5bed1b-4daf-6f9c-6746-b0592a84d05d@suse.de>
Date:   Mon, 20 Jun 2022 11:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/5] scsi: fnic: Drop reserved request handling
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
 <1655463320-241202-5-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1655463320-241202-5-git-send-email-john.garry@huawei.com>
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
> The SCSI core code does not support reserved requests, so drop the
> handling in fnic_pending_aborts_iter().
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/fnic/fnic_scsi.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
> index 3d64877bda8d..e7b7f6d73429 100644
> --- a/drivers/scsi/fnic/fnic_scsi.c
> +++ b/drivers/scsi/fnic/fnic_scsi.c
> @@ -2019,8 +2019,6 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc,
>   
>   	if (sc == iter_data->lr_sc || sc->device != lun_dev)
>   		return true;
> -	if (reserved)
> -		return true;
>   
>   	io_lock = fnic_io_lock_tag(fnic, abt_tag);
>   	spin_lock_irqsave(io_lock, flags);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
