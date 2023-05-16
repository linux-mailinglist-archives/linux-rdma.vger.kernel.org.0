Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376A3705AA7
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 00:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjEPWh1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 18:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjEPWhF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 18:37:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC7B6195;
        Tue, 16 May 2023 15:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BD7863D83;
        Tue, 16 May 2023 22:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819DDC433EF;
        Tue, 16 May 2023 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684276622;
        bh=IiAK7QVYdYVsem35FW1p0MBdsSji3BGNOue2Nk3ycaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mnlM+uflWJJDIsrLLf0MHYw1Qtc10DB6EptX1eyhePE1rkuuQq5jqvjjAOzr0xT/w
         jw4Gx0v4RROfQKogfvGcpFlPFNr7fLN3ThHBUMvOfXz5y0gTGCldqh2yO6Pu07Uasb
         mVDJr+oG7kUxV1IRulWJDZIICYAwPCHyUt5fs2pKvBmQCqc7MNdBBIDIV6kG3X/vlX
         bFCLuxMrJ4bVxjDNtf/l2wEuJSdfzV1uvvE3Q+bf3xASNUYVTEFQNmjlqhDT/oMddX
         UvacSHjIq99/8yBrUSfmPd7g1N9VGekjaX0eqnu8b9lD68yD7l1AsBRJqbAZnvAxSV
         CRejixJeTV3FA==
Date:   Tue, 16 May 2023 15:37:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Remote Direct Memory Access Kernel Subsystem 
        <linux-rdma@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net v2 0/4] Documentation fixes for Mellanox mlx5
 devlink info
Message-ID: <20230516153700.2bd46b47@kernel.org>
In-Reply-To: <87zg64b05d.fsf@meer.lwn.net>
References: <20230510035415.16956-1-bagasdotme@gmail.com>
        <30df7ad7-3b8b-c578-b153-7bf0a38fa0cc@gmail.com>
        <87zg64b05d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 16 May 2023 12:29:18 -0600 Jonathan Corbet wrote:
> > If there is no response from mellanox and/or netdev maintainers,
> > would you like to review and pick this series up?
> 
> They seem OK other than the gratuitous use of Fixes tags.  The netdev
> maintainers are generally responsive and on top of things, though, and I
> don't think there would be any justification for bypassing them here.

I'm expecting Saeed to pick them up to the mlx5 tree. Either that 
or tell us to take them in. I think he was out and traveling recently.
Let's give him some time :|
