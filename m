Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A844CDA38
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 18:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiCDRYy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Mar 2022 12:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiCDRYy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Mar 2022 12:24:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBBB156C75;
        Fri,  4 Mar 2022 09:24:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD90661E83;
        Fri,  4 Mar 2022 17:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA25C340E9;
        Fri,  4 Mar 2022 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646414645;
        bh=sKIE43FuoKzxA9J2rZA6k8NGfDYTGF0hkk3YnB5jMCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikUHPzFOoq7I8BAqGOMMDNa+1gY2GWMxOJ51nBFsoAqpNrF/ugKMuiVgwXpg4W8B/
         G0heglFOjOLGy/9ZK+l3i09N6/YFgYq9wcu0vBJhNyYJv3BwLU5rKzQYJvtPmlbfsU
         QwKr97+NIIxKjKF0BFiS25gaQZVeo7PNdqMHlNS7W5jSkG3qaMZJeQkytWiO0C3qaS
         gLwvOByVokgAhQ4wEVk1XozLbqzawjsvK95iRaKy8ulB1PTJ+kRxSxceDqjL1sNcJz
         wK0QeccwOjKAIhzVxNug45rrbojerJRVhKwtRF+BYFxRiGBu84AFMW+4g48g0qLQ94
         Z7zjTqm+9/tpw==
Date:   Fri, 4 Mar 2022 19:24:01 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] Revert "IB/mlx5: Don't return errors from
 poll_cq"
Message-ID: <YiJLMaPUzrTgsAPL@unreal>
References: <1646315417-25549-1-git-send-email-haakon.bugge@oracle.com>
 <YiESUNnzBBN5fRCl@unreal>
 <726B8D27-B7C7-4779-A56B-3AE9266BC208@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <726B8D27-B7C7-4779-A56B-3AE9266BC208@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 04, 2022 at 10:53:34AM +0000, Haakon Bugge wrote:
> 
> 
> > On 3 Mar 2022, at 20:09, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Thu, Mar 03, 2022 at 02:50:17PM +0100, Håkon Bugge wrote:
> >> This reverts commit dbdf7d4e7f911f79ceb08365a756bbf6eecac81c.
> >> 
> >> Commit dbdf7d4e7f91 ("IB/mlx5: Don't return errors from poll_cq") is
> >> needed, when driver/fw communication gets wedged.
> >> 
> >> With a large fleet of systems equipped with CX-5, we have observed the
> >> following mlx5 error message:
> >> 
> >> wait_func:945:(pid xxx): ACCESS_REG(0x805) timeout. Will cause a
> >> leak of a command resource
> > 
> > It is arguably FW issue. Please contact your Nvidia support representative.
> 
> The RC for the whacked driver/fw communication has been raised with Nvidia support. This commit is to avoid the kernel to crash when this situation arises. And inevitable, it may happen.

I'm confident that support team will find best possible solution to the
raised issue.

Thanks

> 
> 
> Thxs, Håkon
