Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2F645EDF8
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377403AbhKZMiO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhKZMgN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:36:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65797C08EA6B;
        Fri, 26 Nov 2021 03:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8ky68z8fFfmF8hU08cI9Wo2K0ZGNo3KnMJJP5fsiabg=; b=NDZmIhZG/Df0aWG7omTTLqNLka
        kQPymxy5SRwlCUNgJIPOey3i36xNULuLOX3/ZERCdSjjKng7mxKFT3I/lwRlokqiEs7WPdDrvaYXY
        kT33BUDrsbBUh/GWHUhUEl46zsDssFyjs7aTyzacT340muovuP9CtdMTYgAtDtwTvDBLgT4Vf6kjf
        T3e0V1OFSCODDMILF6+yKvJJdW+b2IByDfboq1JtA+18dgeopYrva3ihl9x9wOPUWgIWQlCGGZcd9
        /BpD8AwMoGbaLWPLU0FZGL0+ZCQS/LbEtedaxFSPVqwSIJY2iAaKubV5cMJ1iJm/FuY4eSySTNGi7
        SwPbOChw==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZrv-00ASH2-9C; Fri, 26 Nov 2021 11:58:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: cleanup I/O context handling
Date:   Fri, 26 Nov 2021 12:58:03 +0100
Message-Id: <20211126115817.2087431-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jens,

this series does a little spring cleaning of the I/O context handling/

Subject:
 block/bfq-iosched.c                   |   41 ++++++------
 block/blk-ioc.c                       |  115 +++++++++++++++++++++++++---------
 block/blk-mq-sched.c                  |   35 ----------
 block/blk-mq-sched.h                  |    3 
 block/blk-mq.c                        |   14 ----
 block/blk.h                           |    8 --
 drivers/infiniband/hw/qib/qib_verbs.c |    4 -
 include/linux/iocontext.h             |   40 +++--------
 kernel/fork.c                         |   26 -------
 9 files changed, 128 insertions(+), 158 deletions(-)
