Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D333E25733E
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 07:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgHaFPA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 01:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHaFPA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 01:15:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE95C061573
        for <linux-rdma@vger.kernel.org>; Sun, 30 Aug 2020 22:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uzerkfveBAC1QYwIubMwoIjjIrNXfyBsyJlcz4RXZEw=; b=v2QFgwGXIeWRPuD276CPgU95+5
        uR8mu0LEKW18qYL+EadHR3+uMh5OZQNMj7bOlZUD5fN1ffRFRIBLlNEEhuyxFCNtGXUYLskG0zEkY
        C2LSozJjT7JQ/TQK90hIPRH5SI5GPDnBulIW/QHBxEKHrx4tUNtk9NfelonpDg82Kwo8ywQNHJLNY
        H2Jrf8wID97SORk4A2/HJImeee3/+RPAJHQkxz+E5KQyVxlGkdPYq4RZOKDydSLDVp5Zd5cnTBTJM
        fa2y/0YVJqy/7fFgGooDSRZoNorIadZkr3FwNx+6tnUi8Numtoq3ROSxfvbqSRNlhlz9oTROPmCGD
        IRQ0M9HA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCc9d-0003TY-RX; Mon, 31 Aug 2020 05:14:53 +0000
Date:   Mon, 31 Aug 2020 06:14:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-rdma@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
Message-ID: <20200831051453.GA13058@infradead.org>
References: <20200830103209.378141-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830103209.378141-1-sagi@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 03:32:09AM -0700, Sagi Grimberg wrote:
> Currently we allocate rx buffers in a single contiguous buffers
> for headers (iser and iscsi) and data trailer. This means
> that most likely the data starting offset is aligned to 76
> bytes (size of both headers).
> 
> This worked fine for years, but at some point this broke.
> To fix this, we should avoid passing unaligned buffers for
> I/O.
> 
> Instead, we allocate our recv buffers with some extra space
> such that we can have the data portion align to 512 byte boundary.
> This also means that we cannot reference headers or data using
> structure but rather accessors (as they may move based on alignment).
> Also, get rid of the wrong __packed annotation from iser_rx_desc
> as this has only harmful effects (not aligned to anything).
> 
> This affects the rx descriptors for iscsi login and data plane.

What are the symptoms of the breakage?
