Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF5E3403F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfFDHet (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 03:34:49 -0400
Received: from verein.lst.de ([213.95.11.211]:33863 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfFDHeq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 03:34:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4FB6768B20; Tue,  4 Jun 2019 09:34:20 +0200 (CEST)
Date:   Tue, 4 Jun 2019 09:34:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 02/20] RDMA/core: Save the MR type in the ib_mr
 structure
Message-ID: <20190604073419.GK15680@lst.de>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com> <1559222731-16715-3-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559222731-16715-3-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 04:25:13PM +0300, Max Gurtovoy wrote:
> This is a preparation for the signature verbs API change. This change is
> needed since the MR type will define, in the upcoming patches, the need
> for allocating internal resources in LLD for signature handover related
> operations. It will also help to make sure that signature related
> functions are called with an appropriate MR type and fail otherwise.
> Also introduce new mr types IB_MR_TYPE_USER, IB_MR_TYPE_DMA and
> IB_MR_TYPE_DM for correctness.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
