Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB455DCCB
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbiF1GIC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 02:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbiF1GIC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 02:08:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B032315F;
        Mon, 27 Jun 2022 23:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99A4DB81C0C;
        Tue, 28 Jun 2022 06:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF718C341C6;
        Tue, 28 Jun 2022 06:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656396475;
        bh=qXz5gzlfeJcLBrqesZHeSe5DJNs8xr/HiIO/kMPwVds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwderX56PSSyBiEfcUkhi+AmhLzOyvZB5HrHb2xytVF9/v1Duprb5b9IsVGdKEhnE
         LYEvUfJnb3s49tKuJxLm7+LAQ0sgYD2W8dEiNRQ3xRtdh8U+tQPeDykWm6TB/78Tp5
         HgLr1coWgYJ1JqwGnIdeWDMgYKzyrf9dsVlmpA4Y=
Date:   Tue, 28 Jun 2022 08:07:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report from blktests nvme/032] WARNING: possible circular
 locking dependency detected
Message-ID: <YrqauCHdcieF5+C7@kroah.com>
References: <4ed3028b-2d2f-8755-fec2-0b9cb5ad42d2@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed3028b-2d2f-8755-fec2-0b9cb5ad42d2@fujitsu.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 28, 2022 at 04:03:55AM +0000, yangx.jy@fujitsu.com wrote:
> Hi everyone,
> 
> Running blktests nvme/032 on kernel v5.19-rc2+ which enables 
> CONFIG_LOCKDEP and CONFIG_PROVE_LOCKING triggered the below WARNING.

What was happening when this trace was created?  It looks like you were
manually removing a PCI device from the system through sysfs?  Why would
blktests do that?

thanks,

greg k-h
