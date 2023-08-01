Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6841276AAA9
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Aug 2023 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjHAIP5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Aug 2023 04:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjHAIPz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Aug 2023 04:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E901FF0;
        Tue,  1 Aug 2023 01:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAF1461493;
        Tue,  1 Aug 2023 08:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67930C433C8;
        Tue,  1 Aug 2023 08:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690877745;
        bh=WcMY7k07HhPU+xuvq3b3NbrbeI3Y0arTLnE3joJ1lKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIPfK86/vV7EtTLomxgkhmuqgbPfy194dvv6vCpANsdsCSldUvf9YOYi+24fj9KwL
         hUNcXa9X7gcgLTHnMrrF9aa+MvLdyHIjCRYispcmrPMxq2dS5hhvLmw9jkQi6KkFnq
         QkVSfXhnN8/65PXdWQ105b7w5eb7J1RIM60YiU4Rh7JLXcXURElPPvbS0fFBtBNnWw
         3yiYljdHmSIf5II0J7djpinUk7vNBEekemNvilfmBY10Ct7DkwdMXCdNUqMxovz1Df
         LJw7SlFEj+TWlmchWyntP8UDn+8RSjrqL0d+H40+RTWlmavjJY9CSjHQ3Z3D4EloDz
         FWYQIScjlQ0tg==
Date:   Tue, 1 Aug 2023 11:15:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     Jakub Kicinski <kuba@kernel.org>, jgg@ziepe.ca,
        markzhang@nvidia.com, michaelgur@nvidia.com, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, yuancan@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/nldev: Add length check for
 IFLA_BOND_ARP_IP_TARGET parsing
Message-ID: <20230801081540.GB53714@unreal>
References: <20230723074504.3706691-1-linma@zju.edu.cn>
 <20230724174707.GB11388@unreal>
 <3c0760b5.e264b.1898a6368f8.Coremail.linma@zju.edu.cn>
 <20230725052557.GI11388@unreal>
 <20230725101405.4cd51059@kernel.org>
 <20230725183924.GS11388@unreal>
 <7a2e7314.ee8a2.189abf00b34.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2e7314.ee8a2.189abf00b34.Coremail.linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 08:33:02PM +0800, Lin Ma wrote:
> Hello there,
> 
> > > > > Yeah I have seen that. Just as Jakub said, empty netlink attributes are valid 
> > > > > (they are viewed as flag). The point is that different attribute has different
> > > > > length requirement. For this specific code, the RDMA_NLDEV_ATTR_STAT_HWCOUNTERS
> > > > > attribute is a nested one whose inner attributes should be NLA_U32. But as you
> > > > > can see in variable nldev_policy, the description does not use nested policy to
> > > > > enfore that, which results in the bug discussed in my commit message.
> > > > > 
> > > > >  [RDMA_NLDEV_ATTR_STAT_HWCOUNTERS]       = { .type = NLA_NESTED },
> > > > > 
> > > > > The elegant fix could be add the nested policy description to nldev_policy while
> > > > > this is toublesome as no existing nla_attr has been given to this nested nlattr.
> > > > > Hence, add the length check is the simplest solution and you can see such nla_len
> > > > > check code all over the kernel.  
> > > > 
> > > > Right, and this is what bothers me.
> > > > 
> > > > I would more than happy to change nla_for_each_nested() to be something
> > > > like nla_for_each_nested_type(...., sizeof(u32)), which will skip empty
> > > > lines, for code which can't have them.
> > > 
> > > In general the idea of auto-skipping stuff kernel doesn't recognize
> > > is a bit old school. Better direction would be extending the policy
> > > validation to cover use cases for such loops.
> > 
> > I'm all in for any solution which will help for average developer to write
> > netlink code without mistakes.
> > 
> > Thanks
> 
> I have just come out a new solution for such length issues. Please see
> * https://lore.kernel.org/all/20230731121247.3972783-1-linma@zju.edu.cn/T/#u
> * https://lore.kernel.org/all/20230731121324.3973136-1-linma@zju.edu.cn/T/#u
> 
> I'm not sure adding additional validation logic in the main nlattr code is
> the best solution. Still, after investigating the code, the len field can
> be very suitable for handling the NLA_NESTED cases here. And the developer
> can do manual parsing with better nla_policy-based checking too.
> 
> If this idea is applied, I will also write a script to clean up other
> nla_len patches based on the nla_policy check.

It looks like Jakub didn't like the idea and we will need to add your
sizeof checks all other the place.

Thanks

> 
> Regards
> Lin
