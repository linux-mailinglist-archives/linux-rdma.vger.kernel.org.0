Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565A0762194
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 20:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGYSjb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGYSja (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 14:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCD9A3;
        Tue, 25 Jul 2023 11:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03AB06181E;
        Tue, 25 Jul 2023 18:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B83C433C7;
        Tue, 25 Jul 2023 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690310368;
        bh=3rExnCDOFyq/kHOV6hRNpRACHWdns6zbXSMexvXr6WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlD7DfZdeBR/OmQJQtWTpJ0sYKTrJAi0OXKk8XM40ddHF2Xn2GGnUtphMzPP8S6P3
         o1nVG1Gu7ka2cDz2Y2x2NftHFZVrMXw+/zHZUqdJmVStsomv3e2ENbdfDgpdQPsUeF
         icn/DfG4IJluteYaFQJWjWGHeKTmBUSD9F9ywxU+exCeKQK0VawRFT0Qi3Jf8/jANf
         /BihxJkXqjxbuGKoxLSzM5CliQDy+cBO9XO5B0gnsCqMqTUpNdvL1KUqHQxVce59ro
         nvJymTnRQ+v6MmOqICys8/jzdwGRAzMYZnyJukUxQ0pRjinbF0s/8GShp9tjcmqbKk
         gFGUUfEXrz1IA==
Date:   Tue, 25 Jul 2023 21:39:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>, jgg@ziepe.ca, markzhang@nvidia.com,
        michaelgur@nvidia.com, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, yuancan@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/nldev: Add length check for
 IFLA_BOND_ARP_IP_TARGET parsing
Message-ID: <20230725183924.GS11388@unreal>
References: <20230723074504.3706691-1-linma@zju.edu.cn>
 <20230724174707.GB11388@unreal>
 <3c0760b5.e264b.1898a6368f8.Coremail.linma@zju.edu.cn>
 <20230725052557.GI11388@unreal>
 <20230725101405.4cd51059@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725101405.4cd51059@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 25, 2023 at 10:14:05AM -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 08:25:57 +0300 Leon Romanovsky wrote:
> > > Yeah I have seen that. Just as Jakub said, empty netlink attributes are valid 
> > > (they are viewed as flag). The point is that different attribute has different
> > > length requirement. For this specific code, the RDMA_NLDEV_ATTR_STAT_HWCOUNTERS
> > > attribute is a nested one whose inner attributes should be NLA_U32. But as you
> > > can see in variable nldev_policy, the description does not use nested policy to
> > > enfore that, which results in the bug discussed in my commit message.
> > > 
> > >  [RDMA_NLDEV_ATTR_STAT_HWCOUNTERS]       = { .type = NLA_NESTED },
> > > 
> > > The elegant fix could be add the nested policy description to nldev_policy while
> > > this is toublesome as no existing nla_attr has been given to this nested nlattr.
> > > Hence, add the length check is the simplest solution and you can see such nla_len
> > > check code all over the kernel.  
> > 
> > Right, and this is what bothers me.
> > 
> > I would more than happy to change nla_for_each_nested() to be something
> > like nla_for_each_nested_type(...., sizeof(u32)), which will skip empty
> > lines, for code which can't have them.
> 
> In general the idea of auto-skipping stuff kernel doesn't recognize
> is a bit old school. Better direction would be extending the policy
> validation to cover use cases for such loops.

I'm all in for any solution which will help for average developer to write
netlink code without mistakes.

Thanks
