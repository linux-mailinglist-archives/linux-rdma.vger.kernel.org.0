Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253D597901
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfHUMQB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 08:16:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:12626 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbfHUMQB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 08:16:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="378119052"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by fmsmga005.fm.intel.com with ESMTP; 21 Aug 2019 05:16:00 -0700
Date:   Wed, 21 Aug 2019 20:14:36 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     linux-rdma@vger.kernel.org
Subject: why ibv_wc src_qp is zero
Message-ID: <20190821121436.GA1834@jerryopenix>
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
   Does anyone know the usage of the src_qp field in struct ibv_wc?

   I’m using RC transport type with only Send Operation on Send Queue.
     On the requester side, when SQ WR is finished, there’s one WCE is on CQ. ibv_wc::src_qp is checked with zero value.
     On the responder side, when RQ WR is finished, there’s one WCE is on CQ. ibv_wc::src_qp is checked with zero value too.
   Why the ibv_wc::src_qp field is zero instead of recording the peer's qp number?

--Thanks
Changcheng
