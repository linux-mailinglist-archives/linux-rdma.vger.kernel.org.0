Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE80687F83
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjBBOFZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 09:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBOFY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 09:05:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50543FF28
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 06:05:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 768F261B66
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 14:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B41EC433EF;
        Thu,  2 Feb 2023 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675346722;
        bh=NfkEnp+t9nciEZCj8gfCIOpeLdNEzHWQM+X3oepNvak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=riVvBanOvY46Hum5pDgJ+ZmYpSVLATssivomUIBeixmBNuy/VE8DBA5W/XD3kYdEu
         RQJ4qnDcKuNVn7p5xtuqmnbXcw1bAn1nzQbKjg3pG9fUynqnDArd+I9d72zFihQrYq
         nAHO4xgLmB/y3rG+d5xef1Yd1fds2a4IGeRD969HN2QTEXXLeGprruRPgueSMCvy3j
         0OYIaehqqjA21WVNnkPEFBfNAA7XrtoD+KFH++fS2YxGUsuyIQzarw5E8O8M+gauB5
         f6pyBXO0qm8Jh05RNy5KI06oF8dxaJ1Piv21j+oHSHE219YSkDV8ITfcVaEdicRCNB
         KPLuQbt9p18VA==
Date:   Thu, 2 Feb 2023 16:05:18 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Fix MR cache debugfs in
 switchdev mode
Message-ID: <Y9vDHixeSgYvhVVT@unreal>
References: <cover.1675328463.git.leon@kernel.org>
 <482a78c54acbcfa1742a0e06a452546428900ffa.1675328463.git.leon@kernel.org>
 <Y9vBI044qJTsdHZ3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vBI044qJTsdHZ3@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 09:56:51AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 02, 2023 at 11:03:06AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Block MR cache debugfs creation while in switchdev mode and add missing
> > debugfs cleanup in error path.
> 
> Why does switchdev have anything to do with this?
> 

Because we always had the following code in cleanup:
   697 static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
   698 {
   699         if (!mlx5_debugfs_root || dev->is_rep)
   700                 return;
   701

MR cache shouldn't be used at all for IB representors, and more
comprehensive patch will take more work than this simple solution.

Thanks

> Jason
