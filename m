Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50547B5A1B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbjJBS0o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 14:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbjJBS0k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 14:26:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B516CE;
        Mon,  2 Oct 2023 11:26:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D269C433C9;
        Mon,  2 Oct 2023 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696271198;
        bh=eur7A7Y3SzDW6ljEQkfCfCenQyoxYCoEfd1Tln8zfqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iJUIwUx4t7QNZst/Cx4lJwT62Xfz3o6VvavukhzSh5nzFA5PEry5FIMcU2nA5JHGH
         Nb2r2SQQVFOgadlBtnmsH168qXAkq+tjPtXwJtss3Jl6UnuhW8mm2r5J3RMQDjvzkm
         sCnKmGhA+n9Ur3yJp/MbievOAuPxiMRbhTG/3/Mt3q48+6gldE4VofhC8K27ng12hF
         kP7O62WOxp5G2s39ieBfQJ74BIA5eXjPW39F2I1G4opvSOlAuI9pC2ZpIl7nJQqgYn
         6Gmm7Q/Aonk710NI7tpIg4Ht2PCwSbaAOODvwmKGJSmGQfEUWwiSiCXnh9bPw42aYB
         2d5iDQxGKIWiA==
Date:   Mon, 2 Oct 2023 11:26:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Alex Elder <elder@kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
        dev@openvswitch.org, linux-parisc@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/14] Batch 1: Annotate structs with __counted_by
Message-ID: <20231002112635.7daf13ef@kernel.org>
In-Reply-To: <202309270854.67756EAC2@keescook>
References: <20230922172449.work.906-kees@kernel.org>
        <202309270854.67756EAC2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 27 Sep 2023 08:57:36 -0700 Kees Cook wrote:
> > Since the element count member must be set before accessing the annotated
> > flexible array member, some patches also move the member's initialization
> > earlier. (These are noted in the individual patches.)  
> 
> Hi, just checking on this batch of changes. Is it possible to take the
> 1-13 subset:

On it, sorry for the delay.
