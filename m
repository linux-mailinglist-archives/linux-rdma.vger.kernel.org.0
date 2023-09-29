Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949E57B2C05
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 07:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjI2Fs1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 01:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjI2Fs0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 01:48:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6E81B0;
        Thu, 28 Sep 2023 22:48:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A6BC433C7;
        Fri, 29 Sep 2023 05:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695966504;
        bh=95yNdcgmvuWqj13LeqKRmbFxH0PYoXNj1UcdpQc657w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uC0QUc4mTdlmCuyvnpcIEbWCTxUawh6C1ODrSbxb/fACwjk8XLcBSJOE7NKCsjOLE
         rKnHRR6su640o9XroQbTu8xGHyfD0zJ8QAQ1sb/6anjfFGJKA4ZUAbDX2+lQDrEwYs
         mp8x89IvpSrhytSd/4nGMkLGPibEM1tZjpy1ZhZMm3C+ZwJvlimFvU2RyXEC+cczVI
         l5kJp26mN758vJoZ7i2szS91vj0Zt6gAPZLJq55XvHpOqj8MgH+OG+2XLqy6KhrRMt
         nZNdqmi9BfZBBEb/gPBElmKpgfv/Lii7WZNs0aPb4kjB90kOfunAnKQlCBD5ftWg9I
         1r17WqBgKpfmw==
Date:   Fri, 29 Sep 2023 07:48:17 +0200
From:   Simon Horman <horms@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
        ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com,
        bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
        hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net, 2/3] net: mana: Fix the tso_bytes calculation
Message-ID: <20230929054817.GR24230@kernel.org>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-3-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695519107-24139-3-git-send-email-haiyangz@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 23, 2023 at 06:31:46PM -0700, Haiyang Zhang wrote:
> sizeof(struct hop_jumbo_hdr) is not part of tso_bytes, so remove
> the subtraction from header size.
> 
> Cc: stable@vger.kernel.org
> Fixes: bd7fc6e1957c ("net: mana: Add new MANA VF performance counters for easier troubleshooting")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>

