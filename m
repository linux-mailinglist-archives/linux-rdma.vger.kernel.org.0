Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C177A76A6FE
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Aug 2023 04:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjHACbX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 22:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjHACbW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 22:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47288E65;
        Mon, 31 Jul 2023 19:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D74FD6139D;
        Tue,  1 Aug 2023 02:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F803C433C7;
        Tue,  1 Aug 2023 02:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690857080;
        bh=mTxd6HdQzFWXD+l9R8aNLIJTw4K0Wg96Ajxe6Cwzwpw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KAG52lTMe9zgens46rA1eqv/cVT1kaIN46yTHYubtyBonBbMQC7xVE46a34uehmga
         31kWSsZKowpkD2MbkHQGzvlDaG+VeKKeumaCEJFWx1l38kPGdAx445eNnJf9W1AQYI
         vl1/r2x6mzXlfvj/rLlL6MMd6XlCwD/U6U1THCHc1VAWGL2xf5wHhSbZVLSwvRh++6
         qvWYTtlQ7AU1tja7v7JykjmZIrgOWlpI+j7yAb/QqsX6cQwhYaaajdO0Sm2Xevw57D
         uta6SqTz1Cg2sKs9BKsapSAlYej0MqzS9/ntVSPABQsROacNQHjl3FFg0CgrRS4Rfe
         B8hTP27zKtI8g==
Date:   Mon, 31 Jul 2023 19:31:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Lin Ma" <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        fw@strlen.de, yang.lee@linux.alibaba.com, jgg@ziepe.ca,
        markzhang@nvidia.com, phaddad@nvidia.com, yuancan@huawei.com,
        ohartoov@nvidia.com, chenzhongjin@huawei.com, aharonl@nvidia.com,
        leon@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230731193118.67d79f7b@kernel.org>
In-Reply-To: <38179c76.f308d.189aed2db99.Coremail.linma@zju.edu.cn>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
        <20230731120326.6bdd5bf9@kernel.org>
        <38179c76.f308d.189aed2db99.Coremail.linma@zju.edu.cn>
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

On Tue, 1 Aug 2023 10:00:01 +0800 (GMT+08:00) Lin Ma wrote:
> > > However, this is tedious and just like Leon said: add another layer of
> > > cabal knowledge. The better solution should leverage the nla_policy and
> > > discard nlattr whose length is invalid when doing parsing. That is, we
> > > should defined a nested_policy for the X above like  
> > 
> > Hard no. Putting array index into attr type is an advanced case and the
> > parsing code has to be able to deal with low level netlink details.  
> 
> Well, I just known that the type field for those attributes is used as array
> index.
> Hence, for this advanced case, could we define another NLA type, maybe 
> NLA_NESTED_IDXARRAY enum? That may be much clearer against modifying existing
> code.

What if the value is of a complex type (nest)?  For 10th time, if
someone does "interesting things" they must know what they're doing.

> > Higher level API should remove the nla_for_each_nested() completely
> > which is rather hard to achieve here.  
> 
> By investigating the code uses nla_for_each_nested macro. There are basically
> two scenarios:
> 
> 1. manually parse nested attributes whose type is not cared (the advance case
>    use type as index here).
> 2. manually parse nested attributes for *one* specific type. Such code do
>    nla_type check.
> 
> From the API side, to completely remove nla_for_each_nested and avoid the
> manual  parsing. I think we can choose two solutions.
> 
> Solution-1: add a parsing helper that receives a function pointer as an
>             argument, it will call this pointer after carefully verify the
>             type and length of an attribute.
> 
> Solution-2: add a parsing helper that traverses this nested twice, the first
>             time  to do counting size for allocating heap buffer (or stack
>             buffer from the caller if the max count is known). The second
>             time to fill this buffer with attribute pointers.
> 
> Which one is preferred? Please enlighten me about this and I can try to propose
> a fix. (I personally like the solution-2 as it works like the existing parsers
> like nla_parse) 

Your initial fix was perfectly fine.

We do need a solution for a normal multi-attr parse, but that's not 
the case here.
