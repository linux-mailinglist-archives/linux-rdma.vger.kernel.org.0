Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A713251979
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgHYNYE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgHYNYD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 09:24:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE737C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Emvrfxr3qkITgvdWBr+gDboVnyDPc1woat3HEGegVKo=; b=WomfYjGJAXRPAM6+8BlZhfV61I
        uMQYmf3piXZ1LBHao9NsoxAKYkFmSQlHbrFwctt5B9IQxpG3uFCikCdQXss7QZuIySk6tfJeA2s27
        9wxvtrpKLEHULBE7nOveW3cjBbwq7QhPG6UrWE/hHVzZDjG8ZyxusYHEZyf8QTlCkpFc6jYRjwZgJ
        RofoLuZF2YYcaO5dXUp6SWyGfgffKtehbOnXEDbbcXXvrR+yw57qVyMa3W1Etem4977pwQ6Wdz/RK
        eHMpXqQQerOyWCR3dP+LHMc2gNeYg6/OWN2mJPzq9W7EUUaaEhDOMXTyo+EzKbqKFl5RZxxXWsccC
        +sBy3FWA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAYvh-0006ph-B6; Tue, 25 Aug 2020 13:24:01 +0000
Date:   Tue, 25 Aug 2020 14:24:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Chris Worley <worleys@gmail.com>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: NVME module won't load ("nvme: disagrees about version of symbol
 nvme_uninit_ctrl")
Message-ID: <20200825132401.GA26089@infradead.org>
References: <CANWz5fhKJ=MbXdQo8gjAvioGj4V+V0wKZrU90OnCc+Nn0KkBLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANWz5fhKJ=MbXdQo8gjAvioGj4V+V0wKZrU90OnCc+Nn0KkBLg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 03:39:29PM -1000, Chris Worley wrote:
> Running MLNX_OFED_LINUX-5.0-2.1.8.0-rhel8.2-x86_6 on ConnectX-3 cards,
> attempting to run NVME-over-fabrics.
> 
> OFED installed with: "./mlnxofedinstall --add-kernel-support
> --with-nvmf --force"
> 
> The OFED install did indicate it couldn't load the firmware (although
> these are Mellanox cards) and said: "Note: In order to load the new
> nvme-rdma and nvmet-rdma modules, the nvme module must be reloaded."
> ... but the nvme driver doesn't even load.

That's what you get for using a completely broken out of tree version
of the RDMA code.  Don't do that.
