Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626A42114A1
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2020 22:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgGAU73 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jul 2020 16:59:29 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:34834 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGAU73 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jul 2020 16:59:29 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 061Kx4l4018508;
        Wed, 1 Jul 2020 13:59:05 -0700
Date:   Thu, 2 Jul 2020 02:29:04 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     bvanassche@acm.org
Cc:     sagi@grimberg.me, maxg@mellanox.com, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        krishna2@chelsio.com
Subject: Re: iSERT completions hung due to unavailable iscsit tag
Message-ID: <20200701205903.GA31964@chelsio.com>
References: <20200601134637.GA17657@chelsio.com>
 <d316fdb7-4676-0bb9-c208-b06e43d46534@grimberg.me>
 <20200604151341.GA20246@chelsio.com>
 <20200616094904.GA21817@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616094904.GA21817@chelsio.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bart,

Looks like this issue belongs iscsit as the hung is at schedule() in
iscsit_wait_for_tag(), as I mentioned in my initial post.
This issue is observed with both iWARP and ROCE adapter drivers.

Note that this issue will occur only if the disk(I used RAMDISK) size is
511MB or below. Even 512MB will not recreate.


Thanks,
Krishna.
