Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5F550FE0
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jun 2022 07:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbiFTF7J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jun 2022 01:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiFTF7F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jun 2022 01:59:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7784DF8B;
        Sun, 19 Jun 2022 22:59:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8F98668AFE; Mon, 20 Jun 2022 07:59:01 +0200 (CEST)
Date:   Mon, 20 Jun 2022 07:59:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        bvanassche@acm.org, hch@lst.de, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, linux-rdma@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH 3/5] blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
Message-ID: <20220620055901.GB10192@lst.de>
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com> <1655463320-241202-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655463320-241202-4-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
