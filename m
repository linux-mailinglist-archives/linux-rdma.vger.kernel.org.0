Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7907F550FEA
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jun 2022 08:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiFTGAD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jun 2022 02:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbiFTGAB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jun 2022 02:00:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D74DFA8;
        Sun, 19 Jun 2022 22:59:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7F18668B05; Mon, 20 Jun 2022 07:59:44 +0200 (CEST)
Date:   Mon, 20 Jun 2022 07:59:44 +0200
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
Subject: Re: [PATCH 4/5] scsi: fnic: Drop reserved request handling
Message-ID: <20220620055944.GC10192@lst.de>
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com> <1655463320-241202-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655463320-241202-5-git-send-email-john.garry@huawei.com>
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

