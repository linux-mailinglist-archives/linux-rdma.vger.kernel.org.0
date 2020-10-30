Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520CE2A08FF
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 16:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgJ3PBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 11:01:34 -0400
Received: from verein.lst.de ([213.95.11.211]:54417 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgJ3PBe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Oct 2020 11:01:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7282B68AFE; Fri, 30 Oct 2020 16:01:32 +0100 (CET)
Date:   Fri, 30 Oct 2020 16:01:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Parav Pandit <parav@nvidia.com>
Cc:     dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, yanjunz@nvidia.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org, hch@lst.de,
        syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA: Fix software RDMA drivers for dma mapping error
Message-ID: <20201030150132.GB15733@lst.de>
References: <20201030093803.278830-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030093803.278830-1-parav@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
