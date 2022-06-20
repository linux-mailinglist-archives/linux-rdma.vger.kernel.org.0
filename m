Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303AE5513D7
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jun 2022 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbiFTJPK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jun 2022 05:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiFTJPI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jun 2022 05:15:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50E101E6;
        Mon, 20 Jun 2022 02:15:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 963E121BCC;
        Mon, 20 Jun 2022 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655716506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nB/yp3HEkDLSR53YvvZ+cc5b/XzsxSbMJCE0yslr6zc=;
        b=NbhPF3eiBjOwpBjTxTBUKGLcxsUpBieYpaa2bJ0nJbYXBQ1DPLTOv6PAryYp6pYuLkGJMp
        3tgfG0fa6fCminQ1DLzfMd+WjxmVl6rS3eV3Ue98Pv9uCHk+cY4HYM23Vh4hlY/v6JSEwM
        aDLxRMGXFqqMCswLEfi5wCfSCrf/UVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655716506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nB/yp3HEkDLSR53YvvZ+cc5b/XzsxSbMJCE0yslr6zc=;
        b=VbVTFwKgG2nIUv1fgI3haPjroW7GO/BMDsd2lrneNkiRPCEGxdO4NFMQyrPoSvjY0kdG6w
        7BnNKKpZ/4fiogDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 779E5134CA;
        Mon, 20 Jun 2022 09:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rzLrHJo6sGK+PQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 09:15:06 +0000
Message-ID: <34c6fd01-fcb7-b618-959f-331b65cc8739@suse.de>
Date:   Mon, 20 Jun 2022 11:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/5] blk-mq: Add a flag for reserved requests
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
 <1655463320-241202-3-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1655463320-241202-3-git-send-email-john.garry@huawei.com>
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
> Add a flag for reserved requests so that drivers may know this for any
> special handling.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq.c         | 6 ++++++
>   include/linux/blk-mq.h | 6 ++++++
>   2 files changed, 12 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
