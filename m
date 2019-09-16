Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 025D6B375D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbfIPJn5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 05:43:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:8472 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfIPJn4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 05:43:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 02:43:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="185794281"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by fmsmga008.fm.intel.com with ESMTP; 16 Sep 2019 02:43:55 -0700
Date:   Mon, 16 Sep 2019 17:42:34 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     linux-rdma@vger.kernel.org
Subject: rdma performance verification
Message-ID: <20190916094234.GA11772@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
   I'm working on using rdma to improve message transaction performance
   on distributed storage system(Ceph) development.

   Does anyone know what's the right tool to compare RDMA vs TCP peformance?
   Such as bandwidth, latency. Especially the tool that could measure
   the time to transact the same data size.

   Previously, I use iperf & ib_send_bw to do test(send same data size).
   However, it shows that ib_send_bw use more time to send data than
   iperf.
      nstcc1@nstcloudcc1:~$ time ib_send_bw -c RC -d rocep4s0 -i 1 -p 18515 -q 1 -r 4096 -t 1024 -s 1073741824 --report_gbits -F 192.168.199.222
      real    3m53.858s
      user    3m48.456s
      sys     0m5.318s
      nstcc1@nstcloudcc1:~$ time iperf -c 192.168.199.222 -p 8976 -n 1073741824 -P 1
      real    0m1.688s
      user    0m0.020s
      sys     0m1.644s

   In Ceph, the result shows that rdma performance (RC transaction type,
   SEDN operation) is worse or not much better than TCP implemented performance.
   Test A:
      1 client thread send 20GB data to 1 server thread (marked as 1C:1S)
   Result:
      1) implementation based on RDMA
         Take 171.921294s to finish send 20GB data.
      2) implementation based on TCP
         Take 62.444163s to finish send 20GB data.

   Test B:
      16 client threads send 16x20GB data to 1 server thread (marked as 16C:1S)
   Result:
      1) implementation base on RDMA
         Take 261.285612s to finish send 16x20GB data.
      2) implementation based on TCP
         Take 318.949126 to finish send 16x20GB data.

B.R.
Changcheng 
