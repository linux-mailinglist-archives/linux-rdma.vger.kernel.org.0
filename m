Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104B76B5CA
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 07:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfGQFJl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 01:09:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfGQFJl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 01:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1+t8nFs6WiSQrcpholSuGb1chNm88t1z1W05LV8gtBA=; b=C33o6z7dsRbZbgbsRGLrnXpRe
        ihiesxs8jhZDMAvBPevR5fiLoy2KMXyKlkYq5Fef/fgSOO/8RQyuioDa+yhSieltnXtoEAqg3iEzH
        Wj5MOyt/xmiBUur+Qr7jkfl02DB2+Zxmk4nS/FEe1G2T9XsoZ4ofcwxRbMEnKZNfmudRoATV0sZMR
        OcTKQjDjZO8C5A3VmjnMrCweLMN45DO9ZmCHf/jlu3ELDO8M+mcAUAzFiftfYn00nynsYTPKB8UGr
        JijDwVIxGoRxSdnX6rD0o/QOtdy/GWGXZrL89E0Q5iadXT+NjvEYmiF/y5qTKXsQUoh9pRfyuekPM
        tbo0I04Mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hncC3-0004xJ-FC; Wed, 17 Jul 2019 05:09:31 +0000
Date:   Tue, 16 Jul 2019 22:09:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shamir Rabinovitch <srabinov7@gmail.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/25] Shared PD and MR
Message-ID: <20190717050931.GA18936@infradead.org>
References: <20190716181200.4239-1-srabinov7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716181200.4239-1-srabinov7@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 16, 2019 at 09:11:35PM +0300, Shamir Rabinovitch wrote:
> Following patch-set introduce the shared object feature.
> 
> A shared object feature allows one process to create HW objects (currently
> PD and MR) so that a second process can import.

That sounds like a major complication, so you'd better also explain
the use case very well.
