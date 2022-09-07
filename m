Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD705B0849
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIGPSX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIGPSX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 11:18:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE5171BF6
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 08:18:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A89967373; Wed,  7 Sep 2022 17:18:18 +0200 (CEST)
Date:   Wed, 7 Sep 2022 17:18:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Israel Rukshin <israelr@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a
 QP moves to an error state
Message-ID: <20220907151818.GA26822@lst.de>
References: <20220907113800.22182-1-phaddad@nvidia.com> <20220907113800.22182-5-phaddad@nvidia.com> <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me> <YxiTxJvDWPaB9iMf@unreal> <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 06:16:05PM +0300, Sagi Grimberg wrote:
>>>
>>> This entire code needs to move to the rdma core instead
>>> of being leaked to ulps.
>>
>> We can move, but you will lose connection between queue number,
>> caller and error itself.
>
> That still doesn't explain why nvme-rdma is special.
>
> In any event, the ulp can log the qpn so the context can be interrogated
> if that is important.

I also don't see why the QP event handler can't be called
from user context to start with.  I see absolutely no reason to
add boilerplate code to drivers for reporting slighly more verbose
errors on one specific piece of hrdware.  I'd say clean up the mess
that is the QP event handler first, and then once error reporting
becomes trivial we can just do it.
