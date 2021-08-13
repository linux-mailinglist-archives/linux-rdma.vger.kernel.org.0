Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C823EBE46
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Aug 2021 00:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhHMW0x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Aug 2021 18:26:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:41681 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235029AbhHMW0x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Aug 2021 18:26:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="215668289"
X-IronPort-AV: E=Sophos;i="5.84,320,1620716400"; 
   d="scan'208";a="215668289"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 15:26:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,320,1620716400"; 
   d="scan'208";a="470215180"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.251.143.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 15:26:21 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core] irdma: Restore full memory barrier for doorbell optimization
Date:   Fri, 13 Aug 2021 17:25:49 -0500
Message-Id: <20210813222549.739-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210810115933.GB5158@nvidia.com>
References: <20210810115933.GB5158@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>> 1.	Software writing the valid bit in the WQE.
>> 2.	Software reading shadow memory (hw_tail) value.

> You are missing an ordered atomic on this read it looks like

Hi Jason,

Why do you think we need atomic ops in this case? We aren't trying to protect from multiple threads but CPU re-ordering of a write and a read.

Thank you,
Tatyana
