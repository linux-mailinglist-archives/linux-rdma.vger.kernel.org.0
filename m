Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F420F6DBF6F
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Apr 2023 12:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjDIK2D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Apr 2023 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDIK2C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Apr 2023 06:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A243A81
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 03:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B3760B89
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 10:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53010C433D2;
        Sun,  9 Apr 2023 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681036080;
        bh=TyQWVMYmfXdar5GE0F5W2cObxYpPU+dF1bB16k6q4ig=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Kw8wLPGgHdipiAivSOZtrP8zOHXAJu/MpLT2XDbsaT8zIoUnAjLg7oonBvn+3Cjb5
         ndi2BA7H4RNtkOqGdQLqHttuUa+5wgLnyCUtqvg4ad73owq/1U/ENNjEgdh9b203mN
         iAv6XAfkCB9laz6mAHpgobdUnIb+48WrAlgHQYzZBXuz5LBQvqxFIcKciOvXzGjRFD
         Ya+2zJ+JGyxsyQoRBUJhqcKOHHYj2tZ4WCJlcHiSWfdvnSEMTsVjIGQ0LXjLNbFO7q
         VXjI3gLEwMHFCWNiTrufP132CcBDSAj4eWzGiIRtp9JIifM7Wq2TfHmNTvz/a4Wq/l
         ImzbJrcUjLVjg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C168088607365=2E3027109=2E2194306496858796762=2Estg?=
 =?utf-8?q?it=40252=2E162=2E96=2E66=2Estatic=2Eeigbox=2Enet=3E?=
References: =?utf-8?q?=3C168088607365=2E3027109=2E2194306496858796762=2Estgi?=
 =?utf-8?q?t=40252=2E162=2E96=2E66=2Estatic=2Eeigbox=2Enet=3E?=
Subject: Re: [PATCH for-next 0/5] Updates for next cycle
Message-Id: <168103607661.170852.10541162686308465242.b4-ty@kernel.org>
Date:   Sun, 09 Apr 2023 13:27:56 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 07 Apr 2023 12:52:23 -0400, Dennis Dalessandro wrote:
> The patches from Patrick by way of Brendan are part of that monster patch [1].
> Brendan has been working on whittling it down to make it more consumable.
> 
> The other two are minor cleanups.
> 
> [1] https://lore.kernel.org/linux-rdma/167467690923.3649436.11426965323185168102.stgit@awfm-02.cornelisnetworks.com/
> 
> [...]

Applied, thanks!

[1/5] IB/hfi1: Remove trace newlines
      https://git.kernel.org/rdma/rdma/c/d2590edc93e894
[2/5] IB/hfi1: Suppress useless compiler warnings
      https://git.kernel.org/rdma/rdma/c/cf0455f1a92b7e
[3/5] IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order
      https://git.kernel.org/rdma/rdma/c/9fe8fec5e43d5a
[4/5] IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests
      https://git.kernel.org/rdma/rdma/c/00cbce5cbf8845
[5/5] IB/hfi1: Place struct mmu_rb_handler on cache line start
      https://git.kernel.org/rdma/rdma/c/866694afd644cd

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
