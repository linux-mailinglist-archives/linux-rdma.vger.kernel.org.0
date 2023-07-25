Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84678760932
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 07:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjGYF0D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 01:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGYF0D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 01:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC56A6;
        Mon, 24 Jul 2023 22:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12CE761503;
        Tue, 25 Jul 2023 05:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FBAC433C8;
        Tue, 25 Jul 2023 05:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690262761;
        bh=bhUiI8tKngWF8aIibFJdKp8OVXvAKhVHmOkI8xo0b+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/GOZF3nRKydRMlbSS1zKR5/kzUcRmnxUE/dpJ3Vg6fLVnTgZume0nNEMmM896KCE
         rGw82/0xS3USB5vxG0IZPRV2DsJWUqD/J1NznK9s9ieqsO7qk1NIRiNXTSz5hPphwX
         s2VJ/WcuLZ7tWFN58ySdUAyFuIHNpmRxasSsroRdIilwqkMXEQL5jotZQ9jxNRBQpl
         v+x66wIV8JJjjC6y7uRqS4aV9OIZff8nugABlaO7u4AVy8AamANsDAZ4kKos7hgo17
         /DeJhhe2QgbdI1brCe1ENi8DCaYQxMFtHYrLylcRIUtIEv0wqy8Tk9q44FWcOKWq5f
         BJLgl0+oaN3Kg==
Date:   Tue, 25 Jul 2023 08:25:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>, Jakub Kicinski <kuba@kernel.org>
Cc:     jgg@ziepe.ca, markzhang@nvidia.com, michaelgur@nvidia.com,
        ohartoov@nvidia.com, chenzhongjin@huawei.com, yuancan@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/nldev: Add length check for
 IFLA_BOND_ARP_IP_TARGET parsing
Message-ID: <20230725052557.GI11388@unreal>
References: <20230723074504.3706691-1-linma@zju.edu.cn>
 <20230724174707.GB11388@unreal>
 <3c0760b5.e264b.1898a6368f8.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c0760b5.e264b.1898a6368f8.Coremail.linma@zju.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 25, 2023 at 08:11:58AM +0800, Lin Ma wrote:
> Hello Leon,
> 
> > 
> > On Sun, Jul 23, 2023 at 03:45:04PM +0800, Lin Ma wrote:
> > > The nla_for_each_nested parsing in function
> > > nldev_stat_set_counter_dynamic_doit() does not check the length of the
> > > attribute. This can lead to an out-of-attribute read and allow a
> > > malformed nlattr (e.g., length 0) to be viewed as a 4 byte integer.
> > 
> > 1. Subject of this patch doesn't really match the change.
> 
> My bad, a stupid mistake. I will fix that and prepare another patch.
> 
> > 2. See my comment on your i40e patch.
> > https://lore.kernel.org/netdev/20230724174435.GA11388@unreal/
> > 
> 
> Yeah I have seen that. Just as Jakub said, empty netlink attributes are valid 
> (they are viewed as flag). The point is that different attribute has different
> length requirement. For this specific code, the RDMA_NLDEV_ATTR_STAT_HWCOUNTERS
> attribute is a nested one whose inner attributes should be NLA_U32. But as you
> can see in variable nldev_policy, the description does not use nested policy to
> enfore that, which results in the bug discussed in my commit message.
> 
>  [RDMA_NLDEV_ATTR_STAT_HWCOUNTERS]       = { .type = NLA_NESTED },
> 
> The elegant fix could be add the nested policy description to nldev_policy while
> this is toublesome as no existing nla_attr has been given to this nested nlattr.
> Hence, add the length check is the simplest solution and you can see such nla_len
> check code all over the kernel.

Right, and this is what bothers me.

I would more than happy to change nla_for_each_nested() to be something
like nla_for_each_nested_type(...., sizeof(u32)), which will skip empty
lines, for code which can't have them.

Thanks

> 
> > Thanks
> 
> Regards
> Lin
