Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ADA55C4B0
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 14:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbiF1GNQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 02:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245674AbiF1GMz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 02:12:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4452610A;
        Mon, 27 Jun 2022 23:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E921861861;
        Tue, 28 Jun 2022 06:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DDFC3411D;
        Tue, 28 Jun 2022 06:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656396774;
        bh=ZMK15kcXso+fNPsECBAYSOYMDprHtCHXtk0Ght0FfCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npnTq94uHW4Qqeuk9ZKxMDMQbjVMtHDweOM75rn9uT2GQMLGwpHeMRUJRIgg13bFO
         DcxEVLj0gGHILKJQrGa9GPihIaV7jrndGM0khsvAki/lKh/mVcPdSogojH/PFNEDT8
         1paV6fcqAbDeV43HSwPvrb9SvaluiczwN+6AfWcs=
Date:   Tue, 28 Jun 2022 08:12:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report from blktests nvme/032] WARNING: possible circular
 locking dependency detected
Message-ID: <Yrqb47ozk5IWTnWp@kroah.com>
References: <4ed3028b-2d2f-8755-fec2-0b9cb5ad42d2@fujitsu.com>
 <YrqauCHdcieF5+C7@kroah.com>
 <YrqbNfF9uYMSwZ4V@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrqbNfF9uYMSwZ4V@infradead.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 27, 2022 at 11:09:57PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 28, 2022 at 08:07:52AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 28, 2022 at 04:03:55AM +0000, yangx.jy@fujitsu.com wrote:
> > > Hi everyone,
> > > 
> > > Running blktests nvme/032 on kernel v5.19-rc2+ which enables 
> > > CONFIG_LOCKDEP and CONFIG_PROVE_LOCKING triggered the below WARNING.
> > 
> > What was happening when this trace was created?  It looks like you were
> > manually removing a PCI device from the system through sysfs?  Why would
> > blktests do that?
> 
> To test how the block layer copes with the fact that the underlying
> device goes away.

Ah, so it's a fake PCI device, or is it a real one?

Anyway, it's a valid thing to do, I'll look at the report in a bit...
