Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF53FB282
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Aug 2021 10:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhH3IbP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Aug 2021 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhH3IbO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Aug 2021 04:31:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7631C061575
        for <linux-rdma@vger.kernel.org>; Mon, 30 Aug 2021 01:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aSJzVIj1pmHt75jGXSMEtKblGuosXDrMPnV32eILPSk=; b=EavjJA9YPlRx/gPBVznvcBtHgS
        rtheqGjhg5Jy0GL2/LPSDlgTlJUgBIexoVBhmr83cOSjYPGpgbDrcDaQPTL652nqal2+JjeCWZzK7
        Ok2TZXBkoPwxXWAE7MCoXT8qnO8Lu5hoRaeoss1/gpOZh/GAnGw3SGTgfPMQGsr04Chr11awn3wjd
        DgPRLDRfHu8peQTwUVFDlXOemhT2FH38Uo5Vandj6rn6iiH9wSYFXQVp99zhEcVfl7kPLx16kseLQ
        3cgh1sP2a3KLE3n0cn7qXyvDHUSG5Efzhb6vuAWAECiJnTLsEVxKqPFqmnkv414zWfdrMxowq8d5Y
        uMXF1pKg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKcfv-00HVVT-Va; Mon, 30 Aug 2021 08:29:54 +0000
Date:   Mon, 30 Aug 2021 09:29:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Subject: Re: IB_MR_TYPE_SG_GAPS support
Message-ID: <YSyW/3T4w6LfrDdZ@infradead.org>
References: <D87B6648-A4C4-4D0B-A390-EA1F0A240C08@oracle.com>
 <YSiF6iER1CXmjit1@infradead.org>
 <e271256b-0276-eba0-ede9-ecebf8bb56ce@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e271256b-0276-eba0-ede9-ecebf8bb56ce@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 29, 2021 at 04:46:52PM +0300, Max Gurtovoy wrote:
> > > I have a report that net/sunrpc/xprtrdma/frwr_ops.c::frwr_map()
> > > is attempting to register a mix of GPU and CPU pages with a
> > > single MR during an NFSv4 READ.
> > What GPU pages?
> 
> I guess it's GPU device memory.
> 
> But as Jason mentioned, This is still not supported in RDMA. So there should
> be a bounce buffer in the IO path between GPU and CPU memory subsystems.

Well, the RDMA stack does support P2P pages, which can be exported by
GPUs.  It also supports device private pages by migrating them back to
the CPU through hmm_range_fault.  But none of this should require
SG_GAPS.
