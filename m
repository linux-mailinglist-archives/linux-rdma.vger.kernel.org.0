Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C87E6031D5
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 19:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJRRzo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 13:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJRRzo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 13:55:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F320402C0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 10:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C94AB820E6
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 17:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F7FC433D6;
        Tue, 18 Oct 2022 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666115740;
        bh=lF4dI0TiH1tEQAcjgnjM9tovbbcdacV39RGzpJvPA6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gsDs493X5IpMVObMXgMQYFNmjSXyfKza0uflp+3XgDEZsHWryJ9+MnyvnoG0MVFe/
         Yp0IHYxNJ1Yluf1e7bQrXt9vSufGVIkOKFifDcAqdBWKuCtN68Xzze3kG6dm7Cd9n/
         hesSseTbGDy4xkNDBUPw7SOipGITvljBQlOLkYpOMzqlGn74ayUlUGbPrz+bZ8+Zvc
         FMY5zQTThVGhiCY6wYzpByx7lHdCxG/SLYsm/T/XxEARBJnMPggv7FvI/a5U19F7XU
         eeNSrsqKES+ZlxR9xgrmR2soP/U9oxF41gC83UDineQ4m0XK0q+Pe+nzqvN1ibXmr1
         i/rPWdCyH0bCA==
Date:   Tue, 18 Oct 2022 20:55:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Subject: Re: [PATCH for-next 16/16] RDMA/rxe: Add parameters to control task
 type
Message-ID: <Y07omEJwrEZ+XIbT@unreal>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <20221018043345.4033-17-rpearsonhpe@gmail.com>
 <Y05rjL+ufktJslNU@unreal>
 <c178c3b6-8a3f-7167-4463-4a450684ea80@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c178c3b6-8a3f-7167-4463-4a450684ea80@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 18, 2022 at 10:22:09AM -0500, Bob Pearson wrote:
> On 10/18/22 04:02, Leon Romanovsky wrote:
> > On Mon, Oct 17, 2022 at 11:33:47PM -0500, Bob Pearson wrote:
> >> Add modparams to control the task types for req, comp, and resp
> >> tasks.
> > 
> > You need to be more descriptive why module parameters are unavoidable.
> > 
> > Thanks
> 
> I asked Jason what was the best way here and didn't get an answer. These are tuning parameters.
> Generally I am not sure how to present them to users. They are pretty specific to this
> driver so the rdma app seems a bad choice. I know netlink is the preferred way to talk to
> rdma-core but I haven't figured out how it works. I suspect this is temporary and work queues
> will replace tasklets in this driver once people are used to it.

I think that the best way is to remove tasklets from RXE, unless someone
comes forward to explain why they must to stay (not theoretical explanation,
but practical use).

Thanks

> 
> Bob
