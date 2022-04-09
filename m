Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947334FA4DA
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 07:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiDIFJ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Apr 2022 01:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiDIFIN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Apr 2022 01:08:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F77E334112
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 22:04:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0714468AFE; Sat,  9 Apr 2022 07:04:06 +0200 (CEST)
Date:   Sat, 9 Apr 2022 07:04:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: blktest failures
Message-ID: <20220409050405.GA17755@lst.de>
References: <533dc3b0-e58a-0bc8-2f07-5dbfb3d1235e@gmail.com> <28b4c636-c5a7-451b-965b-6201ac5af460@gmail.com> <98f2a27d-7fa6-074f-a3e5-6b172c79ccd7@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f2a27d-7fa6-074f-a3e5-6b172c79ccd7@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 08, 2022 at 04:25:12PM -0700, Bart Van Assche wrote:
> One of the functions in the above call stack is sd_remove(). sd_remove() 
> calls del_gendisk() just before calling sd_shutdown(). sd_shutdown() 
> submits the SYNCHRONIZE CACHE command. In del_gendisk() I found the 
> following comment: "Fail any new I/O". Do you agree that failing new I/O 
> before sd_shutdown() is called is wrong? Is there any other way to fix this 
> than moving the blk_queue_start_drain() etc. calls out of del_gendisk() and 
> into a new function?

That SYNCHRONIZE CACHE is a passthrough command sent on the request_queue
and should not be affected by stopping all file system I/O.
