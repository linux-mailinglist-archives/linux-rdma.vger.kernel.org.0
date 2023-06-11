Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBED472B156
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 12:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjFKK0p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 06:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKK0n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 06:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C4D13E
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 03:26:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7D8061086
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 10:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2B0C433D2;
        Sun, 11 Jun 2023 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686479202;
        bh=bAZLjL4Krz+2zYfKrlGEAmkRYY6y1Y//j5SlWnR/EMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0JSbDJ077QTX/SFqKyRqXMSV2wK79Euypjw0kIjYmOMi2sun9wsHW9p55LrxTgzG
         Fb5bgWkS0eYrJsVwy3t4CqGmmlfYa3CaeRiV0jn89AwXTbuDuiRgs3aVr9csS2PGA1
         Dwpta2wrJs/VgS1YQjWhWcLZ8NUInKcnasVDSESmu6u89mj3HUC6YWJOgzsiggXsyQ
         F9X0kTAfxQITL16GQvIu2tyPhII7K1BpGO/pJY1ZrjlZBSLBbGaq3eSyMpGVqtgP/J
         wfnxkBCc+bjwUHVllE9Fu3mCmH7OHT9ngOZFchiEDwMF+5MCpdzdqVt2c/1ZeZZS0q
         D4YIj1kaKEeKw==
Date:   Sun, 11 Jun 2023 13:26:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Question about SQD in the mlx5_ib driver
Message-ID: <20230611102637.GC12152@unreal>
References: <6F7F6F24-2AF7-4BBC-9D6C-70C8CC451A3B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6F7F6F24-2AF7-4BBC-9D6C-70C8CC451A3B@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 11, 2023 at 04:16:16PM +0000, Haakon Bugge wrote:
> Hi,
> 
> I see that with commit 021c1f24f002 ("RDMA/mlx5: Support SQD2RTS for modify QP"), the driver supports the SQD -> RTS transition. Which is good.
> 
> But I see no way how the driver can transition a QP into SQD in the first place. Is the RTS -> SQD transition missing?

I see this callchain:
  __mlx5_ib_modify_qp ->
	  mlx5_core_qp_modify ->
	  	modify_qp_mbox_alloc
		mlx5_cmd_exec

Thanks

> 
> 
> Thxs, Håkon
> 
