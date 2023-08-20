Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F561781F0A
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Aug 2023 19:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHTRgy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Aug 2023 13:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjHTRgx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Aug 2023 13:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E1435A5
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 10:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1298860FEC
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 17:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46D3C433C8;
        Sun, 20 Aug 2023 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692552843;
        bh=DwH8/E6OEyDYhHFfIi8u9Y2peuj+mgYbW8aCoiSO6HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToXwkM3jLEIhtcgsIbCyh/PHvewqIQ3TxoMgZXFLyVRnmOPgnaVSjKwbSrmITtecz
         mZYCnWRWrlP9ZX3buEfaKc0bRDGmwXQvGYbQQFmn1p+68ZWPuD62KvbS4nrQfuFk0S
         9trXpahxf4nzxyow1uGRmm+bjy8xS0dFNl+W33pvZPKtIR1mXc71+pwQDXI8mmo7/w
         BZkZlBe6z/7/BvgmQaFWmipX4UA5A1HQC6EJuEIGWWJoCDJ2Mtbctw6NKSkeZS7vc8
         cT4CRInUhno/AM59f5Q2K/xghwbHHTbgLvZv2yxlAY6MIVWVR2eima1aEUrli2khnb
         0MJVjrvp4MZyg==
Date:   Sun, 20 Aug 2023 20:33:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        saravanan.vajravel@broadcom.com,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: isert patch leaving resources behind
Message-ID: <20230820173358.GF1562474@unreal>
References: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com>
 <20230813082931.GD7707@unreal>
 <20230820094622.GD1562474@unreal>
 <4a628865-d555-4b60-3fc7-4675bb40af62@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a628865-d555-4b60-3fc7-4675bb40af62@grimberg.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 20, 2023 at 05:46:12PM +0300, Sagi Grimberg wrote:
> 
> > > > Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection") is
> > > > causing problems on OPA when we try to unload the driver after doing iSCI
> > > > testing. Reverting this commit causes the problem to go away. Any ideas?
> > > 
> > > 
> > > Saravanan, can you please post kernel logs as you wrote "When a bunch of iSER target
> > > is cleared, this issue can lead to use-after-free memory issue as isert conn is twice
> > > released" in the reverted commit?
> > 
> > So what is the resolution here?
> 
> We need saravanan to address the reported resource leak upon
> DEVICE_REMOVAL. If this stalls, I suggest we revert the offending
> commit and add it again without any leaks on surprise hca removals.

Thanks, I'll keep an eye on it, if we don't get patch by EOW, I will revert it
