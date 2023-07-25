Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF84761FE4
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 19:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGYROJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 13:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGYROI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 13:14:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FD1BE;
        Tue, 25 Jul 2023 10:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30F0D6181E;
        Tue, 25 Jul 2023 17:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450E4C433C8;
        Tue, 25 Jul 2023 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690305246;
        bh=f5oiwP4sqXIe3tfN9l/gfp7nkZmncAoyMafjK+B8OaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ocvybNMJ4UQC6VVtbH2qJszlBUMXGQvLiXPlv2EGFkkmN34dqvczYPUxwUqabw09O
         PgMi4gsOA2Ab2Xra+T9d5DZecyW0t/Lr71VF4cxXjBfMoCvNAzIkHvUz9xBI4TEDcg
         PyPom0h9anV/4WXAxzO9cV0hlxHZWIOJuLRKyQ7xP05wug2yleS12KyxSec0vfF86G
         G5XYtKieoFJSutexpz+CvXOxVbD16HFAWXOBgAJQdFi6/FI2UnajsRiTfwmQSZF9SY
         nek+3W2Gonm8n+nO8+4fiCMw3MUgwb998sBcI8YllrDslsvY8HZMl0anlA2sP7yYhV
         nDKSV87heBQEQ==
Date:   Tue, 25 Jul 2023 10:14:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>, jgg@ziepe.ca, markzhang@nvidia.com,
        michaelgur@nvidia.com, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, yuancan@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/nldev: Add length check for
 IFLA_BOND_ARP_IP_TARGET parsing
Message-ID: <20230725101405.4cd51059@kernel.org>
In-Reply-To: <20230725052557.GI11388@unreal>
References: <20230723074504.3706691-1-linma@zju.edu.cn>
        <20230724174707.GB11388@unreal>
        <3c0760b5.e264b.1898a6368f8.Coremail.linma@zju.edu.cn>
        <20230725052557.GI11388@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 25 Jul 2023 08:25:57 +0300 Leon Romanovsky wrote:
> > Yeah I have seen that. Just as Jakub said, empty netlink attributes are valid 
> > (they are viewed as flag). The point is that different attribute has different
> > length requirement. For this specific code, the RDMA_NLDEV_ATTR_STAT_HWCOUNTERS
> > attribute is a nested one whose inner attributes should be NLA_U32. But as you
> > can see in variable nldev_policy, the description does not use nested policy to
> > enfore that, which results in the bug discussed in my commit message.
> > 
> >  [RDMA_NLDEV_ATTR_STAT_HWCOUNTERS]       = { .type = NLA_NESTED },
> > 
> > The elegant fix could be add the nested policy description to nldev_policy while
> > this is toublesome as no existing nla_attr has been given to this nested nlattr.
> > Hence, add the length check is the simplest solution and you can see such nla_len
> > check code all over the kernel.  
> 
> Right, and this is what bothers me.
> 
> I would more than happy to change nla_for_each_nested() to be something
> like nla_for_each_nested_type(...., sizeof(u32)), which will skip empty
> lines, for code which can't have them.

In general the idea of auto-skipping stuff kernel doesn't recognize
is a bit old school. Better direction would be extending the policy
validation to cover use cases for such loops.
