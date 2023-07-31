Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4812A76A0C1
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjGaTDb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGaTDa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 15:03:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED661710;
        Mon, 31 Jul 2023 12:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB7261277;
        Mon, 31 Jul 2023 19:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1120C433C7;
        Mon, 31 Jul 2023 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690830208;
        bh=R0zigmPhGsigjTWmPKthafBHADUHNkDLel4KNYi7aMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZHBqddGTrYKJA4TC/9yeOXoiE0L7sFcEs3enH+JuXeq8SUXFVvs0zAwUJrmFRgl5y
         v48MaV2JVF3RC07Jln2Fj/oCAJNvJsbi2NstloDneHjjPVUjHS1MFESFsE2rAdFhPb
         9UNCtYho3pntwgoRtB3qCjAaRoSLkIvXSAv8b5CYSOIozbPbGFII44c2Pyp3tl3gwa
         8p4qkAkEyrJKnm1TN+U1iwiygmMJWk+U4nc2LICyQ7r83oirWNIChXwa8wWKpPP91s
         TOWfszb+TjpipTm8sxiRI2zedW56KwJya4WlwYgA22Nbpo7dT0LMIxfWea+4GNiJaY
         Zvena216695VA==
Date:   Mon, 31 Jul 2023 12:03:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        fw@strlen.de, yang.lee@linux.alibaba.com, jgg@ziepe.ca,
        markzhang@nvidia.com, phaddad@nvidia.com, yuancan@huawei.com,
        ohartoov@nvidia.com, chenzhongjin@huawei.com, aharonl@nvidia.com,
        leon@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230731120326.6bdd5bf9@kernel.org>
In-Reply-To: <20230731121247.3972783-1-linma@zju.edu.cn>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
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

On Mon, 31 Jul 2023 20:12:47 +0800 Lin Ma wrote:
> In short, the very direct idea to fix such lengh-check-forgotten bug is
> add nla_len() checks like
> 
>   if (nla_len(nla) < SOME_LEN)
>     return -EINVAL;
> 
> However, this is tedious and just like Leon said: add another layer of
> cabal knowledge. The better solution should leverage the nla_policy and
> discard nlattr whose length is invalid when doing parsing. That is, we
> should defined a nested_policy for the X above like

Hard no. Putting array index into attr type is an advanced case and the
parsing code has to be able to deal with low level netlink details.
Higher level API should remove the nla_for_each_nested() completely
which is rather hard to achieve here.

Nacked-by: Jakub Kicinski <kuba@kernel.org>
