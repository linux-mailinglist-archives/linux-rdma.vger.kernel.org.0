Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55211793782
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Sep 2023 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjIFIyd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Sep 2023 04:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjIFIyc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Sep 2023 04:54:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882B3E9
        for <linux-rdma@vger.kernel.org>; Wed,  6 Sep 2023 01:54:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 407DE20293;
        Wed,  6 Sep 2023 08:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693990467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBNWBZeFhh/iXD8952Q1ruU9rljb6K7/zzx/5z/MaMY=;
        b=UdfAi9hzXY8TguA04qmRopOyjQZYTtcdBFrtUa3d3I93HU6DFe0T9QwBB6VHl9LBg+mGA3
        pV/JV2dC+BtQ6H5tucZmQUktdRHaqe/iFOo/oJq5eyCtY4x48zSWnz5q9yYjmlQshzjB/Z
        6V/XjhI0nBHq/I95xoiUsZ1kb8xCl4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693990467;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBNWBZeFhh/iXD8952Q1ruU9rljb6K7/zzx/5z/MaMY=;
        b=ujhp3XYwi8qSAbTfM2maftWVW6Jsg4Qe+i903Cj0bPyD2+HZV/cQKOVcWn2hOTZ27UZxfG
        KMnVCYen088ucjBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3235F1333E;
        Wed,  6 Sep 2023 08:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id loA7DEM++GRGeAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 06 Sep 2023 08:54:27 +0000
Date:   Wed, 6 Sep 2023 10:54:56 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Message-ID: <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca>
 <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca>
 <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
 <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 05, 2023 at 12:39:38AM +0000, Shinichiro Kawasaki wrote:
> Two month ago, the failure had been recreated by repeating the blktests test
> cases nvme/030 and nvme/031 with SIW tranposrt around 30 times. Now I do not see
> it when I repeat them 100 times. I suspected some kernel changes between v6.4
> and v6.5 would have fixed the issue, but even when I use both kernel versions,
> the failure is no longer seen. I reverted nvme-cli and libnvme to older version,
> but still do not see the failure. I just guess some change on my test system
> affected the symptom (Fedora 38 on QEMU).

Maybe the refactoring in blktests could also be the reason the tests are
not working? Just an idea.
