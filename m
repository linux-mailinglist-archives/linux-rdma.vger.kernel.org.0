Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05026151DA6
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 16:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBDPvs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 10:51:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgBDPvr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 10:51:47 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916452051A;
        Tue,  4 Feb 2020 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580831507;
        bh=bRoAPGE4fBDor/qqTGNARArchAJP82WdIUOxVPRfVbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITAS9s+4H8gDFXBdRDGyLhWt8H6uPvDBxV3NQLrLULJj7R2zouaDiegzszKaKaL8p
         9FRN1GSiEXgKwV6bkf0TXzlP58VMJ+YuFKK9VyPgn1R6mmHwSt47ERSGtYLcfaANwB
         kWYDdDQY6ZzQLvYznf47AcM58ghiV5mgemWJ7qP4=
Date:   Tue, 4 Feb 2020 17:51:42 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Honggang LI <honli@redhat.com>,
        "Goldman, Adam" <adam.goldman@intel.com>,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
Message-ID: <20200204155142.GZ414821@unreal>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200204141440.GA1062279@dhcp-128-72.nay.redhat.com>
 <984452af-7c41-cad0-be9c-ed74d269b89d@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984452af-7c41-cad0-be9c-ed74d269b89d@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 04:59:47PM +0200, Gal Pressman wrote:
> On 04/02/2020 16:14, Honggang LI wrote:
> >> +ACTION=="add", SUBSYSTEM=="infiniband", KERNEL!="hfi1*", PROGRAM="rdma_rename %k NAME_FALLBACK"
> >
> > Maybe, we should not enable device rename as default for all RDMA
> > hardware. Leave it to system admin to apply rename or not.
> >
> > We are observing issues with RDMA device renaming too.
>
> +1, we're experiencing similar issues as well.
> If not disabling by default, we need an easy way to disable the feature.

There is super easy way to disable it.

Copy 60-rdma-persistent-naming.rules to /etc/udev/rules.d folder and
change default to anything you want.

This file is not overwritten during rdma-core upgrades and will keep
whatever behavior you need.

Thanks
