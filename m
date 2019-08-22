Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30A99EF8
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfHVSiJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 14:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbfHVSiI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 14:38:08 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E4192173E;
        Thu, 22 Aug 2019 18:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566499088;
        bh=sObG0UbpI1qTxLdjgAMsILJ0Mof+IkrlwZulCrXX1Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AsGxedEYBdbpvlyQ/fsGNKUOKz6xoO954t5wLPqzwz91r3841tLuvjhGErZx38h8F
         6HsSFFchHFP21C9ukYTgz32yTWes0C14JFvfFyUXfkGtHssvP4Wz6MVV1Fvbd4ZxjM
         qjAZ+fNwHADKE1U7HAjMnACgEB3XpYoXBeKNrTEc=
Date:   Thu, 22 Aug 2019 21:38:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Marcin Mielniczuk <marcin@golem.network>
Cc:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        linux-rdma@vger.kernel.org
Subject: Re: Setting up siw devices
Message-ID: <20190822183807.GN29433@mtr-leonro.mtl.com>
References: <421f6635-e69c-623d-746a-df541c27f428@golem.network>
 <20190822154323.GA19899@chelsio.com>
 <20190822155228.GH29433@mtr-leonro.mtl.com>
 <bf42725d-d441-0237-9df5-bd39cb981dcc@golem.network>
 <20190822172155.GL29433@mtr-leonro.mtl.com>
 <b46f158f-61c9-b949-9174-ec110dc92f9a@golem.network>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b46f158f-61c9-b949-9174-ec110dc92f9a@golem.network>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 07:58:56PM +0200, Marcin Mielniczuk wrote:
> On 22.08.2019 19:21, Leon Romanovsky wrote:
> > On Thu, Aug 22, 2019 at 07:05:12PM +0200, Marcin Mielniczuk wrote:
> >> Thanks a lot, this did the trick. I think this is worth documenting
> >> somewhere that this step is needed.
> >> I'll make a PR, would README.md in the rdma-core repo be a good place?
> > I'm not so sure, but it is better to have in some place instead of not having at all.
> I think it's the first place one would look for some information. I'll
> make a PR today or tomorrow.
> >> Does <NAME> have any significance? I did:
> >>
> >>      sudo rdma link add siw0 type siw netdev enpXsYYfZ
> >>
> >> but the resulting device is called iwpXsYYfZ. I couldn't find a trace of
> >> `siw0` anywhere.
> > I would say that it is a bug in kernel part of SIW, because kernel rename
> > (the thing which change your siw0 to be iw* name) is looking for absence
> > of mentioning PCI inside of /sys/class/infiniband/siw0/*
> > https://github.com/linux-rdma/rdma-core/blob/master/kernel-boot/rdma_rename.c#L378
> I don't have /sys/class/infiniband/siw0 on my system, only
> /sys/class/infiniband/iwpXsYYfZ.
> iwp probably comes from iWARP.

Your iwpXsYYfZ was siw0 before rdma_rename was executed.

I can't test the patch now, but hope that this change below will fix your problem.

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 05a92f997f60..38c25a26dfb2 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -326,21 +326,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	struct device *parent = netdev->dev.parent;
 	int rv;

-	if (!parent) {
-		/*
-		 * The loopback device has no parent device,
-		 * so it appears as a top-level device. To support
-		 * loopback device connectivity, take this device
-		 * as the parent device. Skip all other devices
-		 * w/o parent device.
-		 */
-		if (netdev->type != ARPHRD_LOOPBACK) {
-			pr_warn("siw: device %s error: no parent device\n",
-				netdev->name);
-			return NULL;
-		}
-		parent = &netdev->dev;
-	}
 	sdev = ib_alloc_device(siw_device, base_dev);
 	if (!sdev)
 		return NULL;

