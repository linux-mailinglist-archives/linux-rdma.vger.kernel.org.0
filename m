Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA4579832E
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 09:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242619AbjIHHSp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 03:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbjIHHSm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 03:18:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066181BCD
        for <linux-rdma@vger.kernel.org>; Fri,  8 Sep 2023 00:18:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A813F1F45A;
        Fri,  8 Sep 2023 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694157517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2o4TwarVQvnF84+hUo8xiaDyhicYeSIVA1um74AYjU=;
        b=DBaXq36gLDVGaMSmUohuraQrbSWCTLmvMTT7QHTu1SleFLUTzF2/cM20d7l6Nj701AcC15
        NtjT3SLGe5N5WRGKWSV+YpTuyeEbuXI7Lv58Fb4V+GH4JsDQUp0daewGiGhxey0LDr7OBh
        Ji86d11jbfLaTUWRVDMO5EB3ra7j2EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694157517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2o4TwarVQvnF84+hUo8xiaDyhicYeSIVA1um74AYjU=;
        b=mNzzV+wT60weMatic2lco6MQWOspHSXkG0otc86io2PyE/GDyRvWO5NocQvDiWF6TSQWIA
        1bSBe2biDNMcmBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8099D132F2;
        Fri,  8 Sep 2023 07:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z8UXHc3K+mSHCgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 08 Sep 2023 07:18:37 +0000
Message-ID: <a9f6556e-c42b-4be3-819c-06cc302605e7@suse.de>
Date:   Fri, 8 Sep 2023 09:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Daniel Wagner <dwagner@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca> <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca>
 <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
 <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
 <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso>
 <3wxdjvmamxdk6s26q4hnxjazuajrp7xynfq7okywc2uzgcdqf4@ydiglvla3k3u>
 <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/7/23 09:47, Yi Zhang wrote:
> Seems I reproduced this issue[3] when I run [1] on the latest
> linux-block/for-next with kernel config[2].
> 
> [1]nvme_trtype=rdma ./check nvme/
> 
> [2] https://pastebin.com/u9fh7dbX
> 
But isn't this the same issue as the circular locking discussed earlier?

Can you check if the patch
'nvmet-tcp: avoid circular locking dependency on install_queue()'
fixes this issue, too?

Cheers,

Hannes
--
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

