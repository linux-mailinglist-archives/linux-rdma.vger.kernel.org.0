Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997817B6553
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjJCJUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 05:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjJCJUl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 05:20:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BEBAC;
        Tue,  3 Oct 2023 02:20:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABD2C433C7;
        Tue,  3 Oct 2023 09:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696324837;
        bh=kEex/DR+e1njfBDkl+EL3adoifBZXSVht3DKH7tUYRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArTUptzCqhOST0Uaoi72u5yMW0ydgIc86ROgVjTLFDFWxPTcOPQTUgzsMI141XE4q
         rIaY6q16ph24Ufu7uVZbwnLNCCDVSPll7IS0axSwfE7h2XK1BzeN+wf5v5R7O04t5D
         9pVYACvLp2GYijTFvCguAi12ExIc6Lc2aQRNCUXMvvJAvSo/cx9GuFPE+ZGntMMqe+
         mf4fZqq1o3XzdKLAZsVH4ZgUCttIEBs0Po4wNXHlLe6FDUUD9UCwthviFgnTd5/myj
         7FHzg+gFe14HmKhB2rqR0+JTr3/PlS0uGCrMaJ9QykqZV4ucJcY3txIGXCS4JqX1D9
         1YvjRcc/EcOeg==
Date:   Tue, 3 Oct 2023 11:20:29 +0200
From:   Simon Horman <horms@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
        paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
        longli@microsoft.com, ssengar@linux.microsoft.com,
        linux-rdma@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        sharmaajay@microsoft.com, hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net,v2, 3/3] net: mana: Fix oversized sge0 for GSO packets
Message-ID: <ZRvc3fi1Whe+wnJy@kernel.org>
References: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
 <1696020147-14989-4-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696020147-14989-4-git-send-email-haiyangz@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 29, 2023 at 01:42:27PM -0700, Haiyang Zhang wrote:
> Handle the case when GSO SKB linear length is too large.
> 
> MANA NIC requires GSO packets to put only the header part to SGE0,
> otherwise the TX queue may stop at the HW level.
> 
> So, use 2 SGEs for the skb linear part which contains more than the
> packet header.
> 
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v2: coding style updates suggested by Simon Horman

Reviewed-by: Simon Horman <horms@kernel.org>

