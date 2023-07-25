Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A232760938
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 07:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGYF2q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 01:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGYF2p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 01:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CEE4D;
        Mon, 24 Jul 2023 22:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9297861469;
        Tue, 25 Jul 2023 05:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8002AC433C7;
        Tue, 25 Jul 2023 05:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690262924;
        bh=JZvjEkgcW9fNzleH1G5nw2OYpz1YGQMf70dpnLcihWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQO3EnneGqPKXGJ4ekTaqGdpufvQLDAPS6omo/+AJb7cmtNwNFJ7opIMT8eBjOtnC
         BU8GGJPIrIzdvSKRv4Lx0OdANCirV8eLjiiyW4ojr9hFDxtBOXYP/G8ZqiqMWJNw94
         vKabNQP8wqLyz9GsQin6FdmVDLnwIfquPZERztoZRBiOwZs0zi88Ky64EKmWy4P4jh
         cbOv3lrPsIy4FY/Xxm1o0ySmW6zMglD42SN91nqbIE6cSp7WVhxtDmMDrHHHpD+Fcn
         hnR4soh8zrO7PVUbQq2ofwcm8XUT6VmEMiCbv1SUhOx6VSyxJ/+xhmcJNBDdrTWWxJ
         N2LuegJK2QP7Q==
Date:   Tue, 25 Jul 2023 08:28:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ajay Sharma <sharmaajay@microsoft.com>
Cc:     Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] RDMA/mana_ib : Rename all mana_ib_dev type variables
 to mib_dev
Message-ID: <20230725052839.GJ11388@unreal>
References: <BY5PR21MB1394FE30BA84A501D4FA72C6D602A@BY5PR21MB1394.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB1394FE30BA84A501D4FA72C6D602A@BY5PR21MB1394.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 24, 2023 at 08:26:16PM +0000, Ajay Sharma wrote:
> From 8c45d1a89495a1ba10ba6bfbc8dbc3c376b14812 Mon Sep 17 00:00:00 2001
> From: Ajay Sharma sharmaajay@microsoft.com<mailto:sharmaajay@microsoft.com>
> Date: Thu, 4 May 2023 15:29:14 -0700
> Subject: [PATCH 1/5] RDMA/mana_ib : Rename all mana_ib_dev type variables to
> mib_dev
> 
> Renaming all mana_ib_dev type variables to mib_dev to have
> clean separation between eth dev and ibdev variables.
> 
> Signed-off-by: Ajay Sharma sharmaajay@microsoft.com<mailto:sharmaajay@microsoft.com>
> ---

Please fix your mailer and send patches as plain text.
Also your patches have wrong emails and should be grouped as series.

Thanks
