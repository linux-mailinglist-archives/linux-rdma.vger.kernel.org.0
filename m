Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE99076C1A8
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 02:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjHBAxm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Aug 2023 20:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHBAxl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Aug 2023 20:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63A1E52;
        Tue,  1 Aug 2023 17:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A10D60C25;
        Wed,  2 Aug 2023 00:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD78C433C8;
        Wed,  2 Aug 2023 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690937619;
        bh=qrzmpZi6hydFeKd9V3EcDQx3aotLvdeCTmPFzSYgycE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M6fe6GkBHuOJCyzFdBx46ssTHZwe+rkNZ+m4kl7Bhti+gb5se65t7trtEZOGbu7wn
         kOkM5oQYETrtpaxCQcenta6yVPWetAFSx6kUjOvLabjYKCwtcT2E19CvQwbI0vQb9o
         P6l4HOKmuJPA5rTey7nOojgMJ7kThuT/j8U1GrHPxfuN4DDjIHZQeHASxXcz0yKatJ
         oHZKksU6bz0D9ywUbWzaWMQ/14Y9b9wcXSPz29q5jcPTqBqv2ZAM9+2dbMNUgTtoJN
         hPjcv1P9swQiPtWGdRzy8d3aSSVhZfE8d3x9PNSF1qOApjiSuHKUOfS3+Fs1j2JUkd
         gW3a+p0B78LTw==
Date:   Tue, 1 Aug 2023 17:53:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Lin Ma" <linma@zju.edu.cn>
Cc:     "Leon Romanovsky" <leon@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, fw@strlen.de,
        yang.lee@linux.alibaba.com, jgg@ziepe.ca, markzhang@nvidia.com,
        phaddad@nvidia.com, yuancan@huawei.com, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, aharonl@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230801175338.74bc39c2@kernel.org>
In-Reply-To: <385b9766.f63d7.189b3a33c6b.Coremail.linma@zju.edu.cn>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
        <20230731120326.6bdd5bf9@kernel.org>
        <20230801081117.GA53714@unreal>
        <20230801105726.1af6a7e1@kernel.org>
        <385b9766.f63d7.189b3a33c6b.Coremail.linma@zju.edu.cn>
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

On Wed, 2 Aug 2023 08:26:06 +0800 (GMT+08:00) Lin Ma wrote:
> This is true. Actually, those check missing codes are mostly old codes and
> modern netlink consumers will choose the general netlink interface which
> can automatically get attributes description from YAML and never need to
> do things like *manual parsing* anymore.
> 
> However, according to my practice in auditing the code, I found there are
> some general netlink interface users confront other issues like choosing
> GENL_DONT_VALIDATE_STRICT without thinking or forgetting add a new
> nla_policy when introducing new attributes.
> 
> To this end, I'm currently writing a simple documentation about Netlink
> interface best practices for the kernel developer (the newly coming docs
> are mostly about the user API part). 

Keep in mind that even most of the genetlink stuff is pretty old
at this stage. ethtool is probably the first reasonably modern family.
But do send docs, we'll review and go from there :)
