Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8B8978ED
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfHUMKh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 08:10:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:44724 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbfHUMKh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 08:10:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="203005925"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2019 05:10:35 -0700
Date:   Wed, 21 Aug 2019 20:09:12 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     linux-rdma@vger.kernel.org
Subject: CX314A WCE error: WR_FLUSH_ERR
Message-ID: <20190821120912.GA1672@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
   In one system, it always frequently hit "IBV_WC_WR_FLUSH_ERR" in the WCE(work completion element) polled from completion queue bound with RQ(Receive Queue).
   Does anyone has some idea to debug "IBV_WC_WR_FLUSH_ERR" problem?

   With CX314A/40Gb NIC, I hit this error when using RC transport type with only Send Operation(IBV_WR_SEND) WR(work request) on SQ(Send Queue).
   Every WR only has one SGE(scatter/gather element) and all the SGE on RQ has the same size. The SGE size in SQ WR is not greater than the SGE size in RQ WR.

  There’s one explanation about IBV_WC_WR_FLUSH_ERR on page 114 in the "RDMA Aware Networks Programming User Manual" http://www.mellanox.com/related-docs/prod_software/RDMA_Aware_Programming_user_manual.pdf
  But I still didn't understand it well. How to trigger this error with a short demo program?
  "
    IBV_WC_WR_FLUSH_ERR
    This event is generated when an invalid remote error is thrown when the responder detects an
    invalid request. It may be that the operation is not supported by the request queue or there is
    insufficient buffer space to receive the request.
  "

B.R.
Changcheng
