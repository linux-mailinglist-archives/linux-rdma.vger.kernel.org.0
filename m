Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF724626F9
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 23:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhK2W74 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 17:59:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:35260 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236029AbhK2W7O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 17:59:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="233593327"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="233593327"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511902766"
Received: from sindhude-mobl.amr.corp.intel.com ([10.255.35.224])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:55:10 -0800
From:   Sindhu Devale <sindhu.devale@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, tatyana.e.nikolova@intel.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com, Sindhu Devale <sindhu.devale@intel.com>
Subject: [PATCH rdma-core 0/2] Validate input and fix return code
Date:   Mon, 29 Nov 2021 16:54:44 -0600
Message-Id: <20211129225446.691-1-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series includes two patches. One to return the appropriate WC
return codes and the other to validate the input during memory window bind.

Sindhu, Devale (2):
  providers/irdma: Report correct WC errors
  providers/irdma: Validate input before memory window bind

 providers/irdma/uverbs.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.32.0

