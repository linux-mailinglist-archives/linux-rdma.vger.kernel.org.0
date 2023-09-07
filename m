Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8787977A8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Sep 2023 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbjIGQa7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Sep 2023 12:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjIGQas (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Sep 2023 12:30:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85545D151
        for <linux-rdma@vger.kernel.org>; Thu,  7 Sep 2023 09:29:18 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-56c2e882416so892685a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 07 Sep 2023 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694104104; x=1694708904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+cQ2MfzLw1WADqz2zgRLT4sBwBSOkrxB3AhO4MOxPo=;
        b=fSfzX2FaCvrnJACIkRP51FNtJmO5/sqo0LzqHolMZkmmDvQzkpu5qw+uG717jRANlN
         GEOKNQeCgm2gbk5WRs5IP70YfGz3nnD/ZHQW0Y63rnyj5G3sLb/vDTD+QQF+ZJtE+Hp4
         BacQy3pZ/3ns0CFpKiiYCn2RrjUk0v+H8cBU6a6NoOGmdhCPpoB1rAwy7lfhoOn5RaIz
         WVO/L1Ngwut0wTYnNDunxmSt7ITwKppPB2cshIBB5pq4fhNGTGXqme10Mfb5GMJ7xjOI
         SuIrxcRmbocOv+CeROhgI1LeP8V5nvQFy0/hPmCUnBpFygzCetUi5M5tCOXVZ8UOCSa7
         bPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104104; x=1694708904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+cQ2MfzLw1WADqz2zgRLT4sBwBSOkrxB3AhO4MOxPo=;
        b=FVE3e10pKWiT8/vOhT9SN5J9GNua+EqOZxRh2UiptTdIW0F4w2aECAfRYvtV9CE6Ll
         x/Tg86/DfFGBOr65HMzBNAL4fn6aoXjjJ4KqiNC7pJ2lZcJhgv8S5kLCVvJotDaFYX5a
         Kw6/TmOYo2MUdA9RzzY6t11WwvWU96rl4X9QdTzjJJ0Yiba912f7SikP9LR4Ub/YkEJo
         KDVnRCsMp1iT0pBYjZLWCosOJ+NXCg+fVzjQGE39m5d5uREenb3LCYu7yKBSo8rngQCY
         CNzPymzdf+evcghbrxhOrhM73tzSXvTg52c+OOnmRL2A0EaMqiw2FYNeDm2yS1E254Dr
         +/QQ==
X-Gm-Message-State: AOJu0YydHnsStFnyLJe3/9jWdvg67VkfuJ/WcYrgmEJecL2yLmSMeuiT
        u1+9tRFwmS4uM4iRkzTw4gZHe+PjOfW28YRkBSA=
X-Google-Smtp-Source: AGHT+IHrBIJuqPG+mbaM+AQrOoCznnafSoTdOsbWiZnoHco2OnVxn+u9eZ14RDvzB35AV4+gpVJ7lA==
X-Received: by 2002:a05:620a:4511:b0:76c:9391:6922 with SMTP id t17-20020a05620a451100b0076c93916922mr27531022qkp.24.1694103424207;
        Thu, 07 Sep 2023 09:17:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a137500b0076ef004f659sm5915009qkl.1.2023.09.07.09.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:17:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qeHgk-00174a-Vp;
        Thu, 07 Sep 2023 13:17:02 -0300
Date:   Thu, 7 Sep 2023 13:17:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Message-ID: <ZPn3fryQDQeckq4k@ziepe.ca>
References: <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca>
 <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca>
 <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
 <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
 <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso>
 <3wxdjvmamxdk6s26q4hnxjazuajrp7xynfq7okywc2uzgcdqf4@ydiglvla3k3u>
 <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 07, 2023 at 03:47:03PM +0800, Yi Zhang wrote:
> Seems I reproduced this issue[3] when I run [1] on the latest
> linux-block/for-next with kernel config[2].

https://lore.kernel.org/linux-rdma/13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me/

So far nobody has come with a solution

Jason
