Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87280151CA1
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 15:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgBDOxa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 09:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbgBDOxa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 09:53:30 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65D7120674;
        Tue,  4 Feb 2020 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580828010;
        bh=8bJOqaIUZGco+4jF7PmgkcPoW1eDP04nTXTg+ErVxW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdHv68ZPfCETToLyOdvPC10GdViv+4Dm5Bwj08JMcc+OCUiGDj72O+wI+0yPNdquS
         kdYDb/9O6SmtNRj5a5QgIGgYpE7UZrzrppc6tANnKsnmY4ZbnqTTF0zgjdiECz52Uo
         y3BuhR51/EJNd+TxkrX5er+5e5wTo1oH9q8aktXo=
Date:   Tue, 4 Feb 2020 16:53:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Honggang LI <honli@redhat.com>
Cc:     "Goldman, Adam" <adam.goldman@intel.com>,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
Message-ID: <20200204145326.GX414821@unreal>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200204141440.GA1062279@dhcp-128-72.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204141440.GA1062279@dhcp-128-72.nay.redhat.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 10:14:40PM +0800, Honggang LI wrote:
> > +ACTION=="add", SUBSYSTEM=="infiniband", KERNEL!="hfi1*", PROGRAM="rdma_rename %k NAME_FALLBACK"
>
> Maybe, we should not enable device rename as default for all RDMA
> hardware. Leave it to system admin to apply rename or not.
>
> We are observing issues with RDMA device renaming too.

I can't say that I'm exciting to see such attitude, it is better to fix
broken software instead of limiting features in "independent" library.

Thanks

>
> Thanks
>
