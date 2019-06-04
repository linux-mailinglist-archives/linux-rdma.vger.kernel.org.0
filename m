Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12BEE34090
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 09:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfFDHn1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 03:43:27 -0400
Received: from verein.lst.de ([213.95.11.211]:33935 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfFDHn0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 03:43:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EEB5368B02; Tue,  4 Jun 2019 09:43:00 +0200 (CEST)
Date:   Tue, 4 Jun 2019 09:43:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 11/20] IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI
 handover
Message-ID: <20190604074300.GP15680@lst.de>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com> <1559222731-16715-12-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559222731-16715-12-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On something very vaguely related:  Can one of you look into dropping
FMR support in iser/isert now that NFS as the other major user has
dropped support as well?
