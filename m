Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD1D59B2E7
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 11:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiHUJJe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 05:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiHUJJd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 05:09:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C41AF37
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 02:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 225C7B80B94
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 09:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2CFC433C1;
        Sun, 21 Aug 2022 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661072968;
        bh=GI85NMSXPs88KiZGH7wmCFLde2Pmqsd/mRcnp9AJvcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uP0MXR/0PSdA/pcj3Sw2/dOM2TYQpxxHjJUJIgmt+tUtWM6ZMv0Dde2tThbcPHai+
         6AnnGaou58fmhqx4Eoj9XSvJiQqCmlmzgbm0h5uklvo8MgHhy9p06Dn828GKD2N7Gt
         3FlHxAAJm/fYqxVXLioL8/Ehmvy9n0+vitoQ7TFwNGSQ3adpHuv7S9BLT6BWchylbI
         5+95BZ/pZlsOW3GTZDa7TxZLDallbGS1AwUD4gWDMd3M5vAKWa7gyo2z/POdsYAwvk
         RQwFyaUhsB/R+pYqdePId+zlFOwHBbSShTx/Pn4KkRk3zH2A64eZW3DnQIaMBNmZEg
         Ls9zBk+Knda2A==
Date:   Sun, 21 Aug 2022 12:09:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, jinpu.wang@ionos.com
Subject: Re: [PATCH for-next 0/2] Add trace event support to RTRS
Message-ID: <YwH2RGj/3qsubb8c@unreal>
References: <20220818105240.110234-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818105240.110234-1-haris.iqbal@ionos.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 18, 2022 at 12:52:38PM +0200, Md Haris Iqbal wrote:
> Hi Jason, hi Leon,
> 
> Please consider to include following changes to the next merge window.
> 
> The patchset is organized as follows:
> 1: Adds trace event to rtrs-clt
> 2: Adds trace event to rtrs-srv
> 
> Santosh Pradhan (2):
>   RDMA/rtrs-clt: Add event tracing support
>   RDMA/rtrs-srv: Add event tracing support
> 

Thanks, applied.
