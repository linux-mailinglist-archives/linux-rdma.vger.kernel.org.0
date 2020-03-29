Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D25196E0E
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgC2PF2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 11:05:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2PF2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Mar 2020 11:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bJFSAZG1n+xzVtSP1SVc825QUuF9GdC/2ZtU7S6cLkA=; b=PEz8hf0lPNmRCSWD16vqwenN8R
        dMerh5AqGy54wYPNu34Q1sZWVb3NRoRgHC8EW5iQIzT5I+nhaX/Xenj2IVTd3m6UAp7B9GNk6+LJn
        YgmkE3twkrMKLyoIC1HG4RdwMXgtPh86nO3s3ja3IqIAp8R5vV3pplvCR1IOsjz/VdVUklxmDMZWY
        uymiEw1eHSe1w86hSvrCMd3Zh3me3FRujRr1bXG2vB560+3mej+NTFwBpbOxCE0DyD0fY7BBIjaHm
        NczVwADlVMCO7iE+gjNEvvwPPdw1LVme8VCNGh3yU/80KHZK8u8XprJagnmyi6Q0tzmhBKgVL39/p
        BISc2ODQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIZV6-0004wG-IX; Sun, 29 Mar 2020 15:05:24 +0000
Date:   Sun, 29 Mar 2020 08:05:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, sagi@grimberg.me, leon@kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v11 15/26] block: reexport bio_map_kern
Message-ID: <20200329150524.GA13909@infradead.org>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-16-jinpu.wang@cloud.ionos.com>
 <15f25902-1f5a-a542-a311-c1e86330834b@acm.org>
 <20200328082953.GB16355@infradead.org>
 <bbba2682-0221-4173-9d00-b42d4f91f3b8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbba2682-0221-4173-9d00-b42d4f91f3b8@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 28, 2020 at 09:16:55AM -0700, Bart Van Assche wrote:
> There are more users in the Linux kernel of bio_add_pc_page() than only
> bio_map_kern(), e.g. the SCSI target pass-through code
> (drivers/target/target_core_pscsi.c). The code that uses bio_map_kern()
> is in patch 22/26: "block/rnbd: server: functionality for IO submission
> to file or block dev". Isn't that use case similar to the SCSI
> pass-through code? I think the RNBD server code also implements storage
> target functionality.

No, it is not at all.  The RNBD case submits normal read/write bios, for
which bio_map_kerl is the wrong interfac given that it
uses bio_add_pc_page.  Read, write and other non-passthrough requests
must use bio_add_page instead.
