Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C408568A48
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiGFN55 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiGFN54 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 09:57:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DE017A90;
        Wed,  6 Jul 2022 06:57:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8B0FE2262B;
        Wed,  6 Jul 2022 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657115873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiUjfUaxXUHtTpdwighgqJkP8dPW871+3s1BnMx2Ltw=;
        b=yvPvbIuuxtdk2ZX8Q8tSoKYC5cW9dKB+5Zw1LzSQH7197bMhDdli0CWLiflL03yBVSxu31
        3GMcXYJKFvhvNqtUy2cQiQ4XZHsfkN6pzZ7I3g+QRQgLeWpktmJqk3iii4LCOU5lITaQ9i
        sL2Y/gJxVd14DsEMqswdcEn7ilbN6V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657115873;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiUjfUaxXUHtTpdwighgqJkP8dPW871+3s1BnMx2Ltw=;
        b=DrSRj0EvDTIpUIt/FJqzoaO8ehUFDCc6m4Kks/eb8UIsdpsS4gF3k4Myi2JAHEtoQp9hzo
        OUxLU3k8ElQq8jAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F0F213A7D;
        Wed,  6 Jul 2022 13:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RZFGFuGUxWKNOAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 06 Jul 2022 13:57:53 +0000
Message-ID: <18d78bd6-2150-f771-9a6e-2b972d2e1192@suse.de>
Date:   Wed, 6 Jul 2022 15:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 6/6] blk-mq: Drop local variable for reserved tag
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, bvanassche@acm.org, hch@lst.de,
        jejb@linux.ibm.com, martin.petersen@oracle.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com
Cc:     linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org
References: <1657109034-206040-1-git-send-email-john.garry@huawei.com>
 <1657109034-206040-7-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1657109034-206040-7-git-send-email-john.garry@huawei.com>
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

On 7/6/22 14:03, John Garry wrote:
> The local variable is now only referenced once so drop it.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>   block/blk-mq-tag.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
