Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF964CC5AA
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Mar 2022 20:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiCCTJz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 14:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiCCTJz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 14:09:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5927214FFE1;
        Thu,  3 Mar 2022 11:09:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E82A861A5E;
        Thu,  3 Mar 2022 19:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4528C340EF;
        Thu,  3 Mar 2022 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646334548;
        bh=82P4dYXVNC/cQyX9wKbbOy5G7nGoCFC41X836sNuIGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSs9IyWEMN1Ue6j6rujOAK2m/2ws8iIGYc7BkEZKzRwWuyWtei9smuP8z+kASadoq
         WJPnay6R/C2R0AcJck/uvbulNy9UrNY59ToYKAkGlaiXS7N9WuPnSViVASa3W0nv/J
         +z55UKHCOh3cuEinvB65fSTSk3yRuv9r8EanPPDZwWeo5AxSrXPCPDdXfvtuaI7x6j
         axijlLrui0nFtpUENQy9YoPaWkcXAEYAxqsw2vvP5+EPSXMkC1nInagSOv9YoQDo6C
         ZWCylrToABoOy3U6rMaG0Nv9jpVescyvROci54l1r+ChsnPTbh92Y508HgwwWCp+GC
         ywTJNGfVfkz/w==
Date:   Thu, 3 Mar 2022 21:09:04 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] Revert "IB/mlx5: Don't return errors from
 poll_cq"
Message-ID: <YiESUNnzBBN5fRCl@unreal>
References: <1646315417-25549-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1646315417-25549-1-git-send-email-haakon.bugge@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 03, 2022 at 02:50:17PM +0100, Håkon Bugge wrote:
> This reverts commit dbdf7d4e7f911f79ceb08365a756bbf6eecac81c.
> 
> Commit dbdf7d4e7f91 ("IB/mlx5: Don't return errors from poll_cq") is
> needed, when driver/fw communication gets wedged.
> 
> With a large fleet of systems equipped with CX-5, we have observed the
> following mlx5 error message:
> 
> wait_func:945:(pid xxx): ACCESS_REG(0x805) timeout. Will cause a
> leak of a command resource

It is arguably FW issue. Please contact your Nvidia support representative.

Thanks
