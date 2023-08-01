Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6576AA92
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Aug 2023 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjHAIL0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Aug 2023 04:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjHAILY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Aug 2023 04:11:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73B611D;
        Tue,  1 Aug 2023 01:11:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D623614A6;
        Tue,  1 Aug 2023 08:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0373C433C8;
        Tue,  1 Aug 2023 08:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690877482;
        bh=OWZu55Ufaewrwq61zbQVPkXisyIVRzmtL9NXkGrrT08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVLDGFUjKNL9YQvEJbi0QhgdkVVETRueKCZ2xE2fcWVDSDYQjcZ3ajuQn8FA75WES
         QzJwkFIXIl53Hvt9giwEdNL08L9HRCrKEw4pZ3ieIyitW1B3bSZIIFjA1DSdoNNZsO
         /gxpzFmZuvW72e6fhmdqoFGybN5rw84F3gdG4ydJcOjopWXtNHsCtQeEqkrVAl4lRv
         Y9Ym7C7ibhuPCPwt2u0ZfZG66iMhiW0nNoAUH5NhRTGaeHmvy2GlP37pDtSuU2Q710
         wcoQYCuFKCk0tVd78iILIpWMKQLDwpnMM8MpM3+shJ4ZL6N4nv2nfQX6Fv/4tENdGt
         133UkLROCpQ1Q==
Date:   Tue, 1 Aug 2023 11:11:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, fw@strlen.de,
        yang.lee@linux.alibaba.com, jgg@ziepe.ca, markzhang@nvidia.com,
        phaddad@nvidia.com, yuancan@huawei.com, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, aharonl@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230801081117.GA53714@unreal>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
 <20230731120326.6bdd5bf9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731120326.6bdd5bf9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 12:03:26PM -0700, Jakub Kicinski wrote:
> On Mon, 31 Jul 2023 20:12:47 +0800 Lin Ma wrote:
> > In short, the very direct idea to fix such lengh-check-forgotten bug is
> > add nla_len() checks like
> > 
> >   if (nla_len(nla) < SOME_LEN)
> >     return -EINVAL;
> > 
> > However, this is tedious and just like Leon said: add another layer of
> > cabal knowledge. The better solution should leverage the nla_policy and
> > discard nlattr whose length is invalid when doing parsing. That is, we
> > should defined a nested_policy for the X above like
> 
> Hard no. Putting array index into attr type is an advanced case and the
> parsing code has to be able to deal with low level netlink details.

Jakub,

IMHO, you are lowering too much the separation line between simple vs.
advanced use cases. 

I had no idea that my use-case of passing nested netlink array is counted
as advanced usage.

Thanks
