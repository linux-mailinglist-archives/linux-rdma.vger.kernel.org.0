Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39560DACF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Oct 2022 07:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiJZF6T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 01:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiJZF6R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 01:58:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303BAB448C;
        Tue, 25 Oct 2022 22:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB7BBB81F42;
        Wed, 26 Oct 2022 05:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C149C433D6;
        Wed, 26 Oct 2022 05:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666763894;
        bh=qkTBdkFOelF82FnEM+JQO4iw9eRJY7E7oDovtc9IK8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5XfY1QAPlc0Gfw+g2HL7WK/o3K1P6RKDIgB6Zt4Y/jnO/TpwLD07S0W4LHot9I4H
         UEPKl7ksDPdFBo1VFrBqA3hGscUUcquKaUVxtYrJR357Sbk9HaDmEgDSdYy/0GBnEK
         c19TA7g6qfXPHRBEQ86nNaIG7WQAsEKe97utT4rqpjUtq69D1ZVocEBszE6By30Oak
         7ZW+0AbiJ607WlMr3BMqD+bCWWTHNvWCEfZ7SUUzYbMM6agLlQRlCYwN7PcGyAMScB
         dK+LESkigPpv9uYPBQxsa2itnl6j0Jz9DbawPyyB22gCc/bXvrgyrkDpj2PJWPXUKY
         k3/qVFEfClfDA==
Date:   Wed, 26 Oct 2022 08:58:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Arumugam Kolappan <aru.kolappan@oracle.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, manjunath.b.patil@oracle.com,
        rama.nichanamatlu@oracle.com
Subject: Re: [PATCH  1/1] net/mlx5: update debug log level for remote access
 error syndromes
Message-ID: <Y1jMcm/GIO8JMlWQ@unreal>
References: <1666689721-30424-1-git-send-email-aru.kolappan@oracle.com>
 <Y1jKHcBdcUnluIdU@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1jKHcBdcUnluIdU@unreal>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 26, 2022 at 08:48:13AM +0300, Leon Romanovsky wrote:
> On Tue, Oct 25, 2022 at 02:22:01AM -0700, Arumugam Kolappan wrote:
> > The mlx5 driver dumps the entire CQE buffer by default for few syndromes.
> > Some syndromes are expected due to the application behavior [ex:
> > MLX5_CQE_SYNDROME_REMOTE_ACCESS_ERR, MLX5_CQE_SYNDROME_REMOTE_OP_ERR and
> > MLX5_CQE_SYNDROME_LOCAL_PROT_ERR]. Hence, for these syndromes, the patch
> > converts the log level from KERN_WARNING to KERN_DEBUG. This enables the
> > application to get the CQE buffer dump by changing to KERN_DEBUG level
> > as and when needed.
> > 
> > Suggested-by: Leon Romanovsky <leon@kernel.org>
> > Signed-off-by: Arumugam Kolappan <aru.kolappan@oracle.com>
> > ---
> >  drivers/infiniband/hw/mlx5/cq.c | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)

And more general comments:
1. Patch title is "RDMA/mlx5: Update ...." and not "net/mlx5: updated ..."
2. No need 1/1 notation for single patch
3. [PATCH ...] is better to include target [PATCH rdma-next ...]

Thanks
