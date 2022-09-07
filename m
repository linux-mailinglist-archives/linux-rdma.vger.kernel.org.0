Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEB25B0388
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 14:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIGMCF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 08:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGMCE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 08:02:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC12785FF4
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 05:02:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5824967373; Wed,  7 Sep 2022 14:02:00 +0200 (CEST)
Date:   Wed, 7 Sep 2022 14:02:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Patrisious Haddad <phaddad@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Israel Rukshin <israelr@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a
 QP moves to an error state
Message-ID: <20220907120200.GA12104@lst.de>
References: <20220907113800.22182-1-phaddad@nvidia.com> <20220907113800.22182-5-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907113800.22182-5-phaddad@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 02:38:00PM +0300, Patrisious Haddad wrote:
> From: Israel Rukshin <israelr@nvidia.com>
> 
> Add debug prints for fatal QP events that are helpful for finding the
> root cause of the errors. The ib_get_qp_err_syndrome is called at
> a work queue since the QP event callback is running on an
> interrupt context that can't sleep.

What an awkward interface.  What prevents us from allowing 
ib_get_qp_err_syndrome to be called from arbitrary calling contexts,
or even better just delivering the error directly as part of the
event?
