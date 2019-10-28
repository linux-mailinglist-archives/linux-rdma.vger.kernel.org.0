Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE4EE6B79
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 04:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfJ1DaE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 23:30:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:56507 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfJ1DaE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 23:30:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 20:30:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="202399338"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2019 20:30:03 -0700
Date:   Mon, 28 Oct 2019 11:27:28 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     linux-rdma@vger.kernel.org
Subject: qperf failure
Message-ID: <20191028032728.GA1026409@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
   I'm using qperf to compare TCP & RDMARC performance.
   qperf report that it failed to modify the QP to RTR status.
   Does anyone know how to solve the problem?

   Host A:nstcloudcc1 configuration:
       nstcc1@nstcloudcc1:tmp$ ib2netdev 
       mlx5_0 port 1 ==> ens261f0 (Up) 173.168.100.103
       mlx5_1 port 1 ==> ens261f1 (Down) 
       nstcc1@nstcloudcc1:tmp$ 
   Host B:rdmarhel0 configuration:
       [rdma@rdmarhel0 tmp]$ ib2netdev 
       mlx5_0 port 1 ==> ens801f0 (Up) 173.168.100.101
       mlx5_1 port 1 ==> ens801f1 (Up) 192.168.100.101
       [rdma@rdmarhel0 tmp]$ 

   Run below command on host A as server:
       nstcc1@nstcloudcc1:tmp$ qperf
   Run below command on host B as client:
       [rdma@rdmarhel0 tmp]$ qperf 173.168.100.103 rc_bw
       rc_bw:
       failed to modify QP to RTR: Invalid argument
   The log shows as above on cient that it failed to modify QP to RTR

--Thanks
Changcheng
