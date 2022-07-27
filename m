Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD235826AA
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 14:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiG0Mci (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 08:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiG0McP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 08:32:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAFA218C
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 05:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A6216118C
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 12:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F81DC433D6;
        Wed, 27 Jul 2022 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658925103;
        bh=H69oCB6xnYuRDVAF8HIgEWz2VCc0QmfpwkVCAekMf+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZoXKZ1MKA1svm8/7tQZRVAZ6KGfbG0a/nyh/e6I3lPb1rOK7rg9euFKRxKcn9ZmOU
         4wj8LY6HAngiz6TwcSAuyNzKPZk9dAh7kjTp+xRu5OI8i0O11KQn5vUGxhcf/Fs4mj
         IepahU6y6LI+M0syXpV/f/L35CJDGzE2y+0LgpIdXj7PxPR6TsOYUcEmdh2aAymm8E
         Ym7SJtWEjE1OW2uXk5qUIxPVqKcunRt+eowXxgrT32185iPxrwc33SXMsCtmXtRSI6
         a3xgoPR67V/1X/SFpGyiJiFRshdtbpjBRORveVjAeSFQikT8OqrpljiXvLZ1JTHohL
         3fcmcFun2Eukg==
Date:   Wed, 27 Jul 2022 15:31:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 3/3] RDMA/srpt: Fix a use-after-free
Message-ID: <YuEwK35/xuNe24/G@unreal>
References: <20220726212156.1318010-1-bvanassche@acm.org>
 <20220726212156.1318010-4-bvanassche@acm.org>
 <YuEHOM/iGFEtaGde@unreal>
 <alpine.DEB.2.22.394.2207271426110.1244244@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2207271426110.1244244@gentwo.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 27, 2022 at 02:26:43PM +0200, Christoph Lameter wrote:
> On Wed, 27 Jul 2022, Leon Romanovsky wrote:
> 
> > Please no BUG_ON() in new code.
> 
> Do we now prefer NULL pointer dereferences causing bugs?

There are two possible scenarios.
1. "NULL can be in this flow." - In such case, the code should deal with
such flow and do not crash whole machine.
2. "NULL can't be in this flow." - Put WARN_ON() which serves as a
documentation/debug help to catch situations that are not possible.

Thanks

> 
