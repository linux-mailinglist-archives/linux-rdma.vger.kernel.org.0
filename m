Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBBAE9712
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 08:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfJ3HLt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Oct 2019 03:11:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:3942 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfJ3HLs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Oct 2019 03:11:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 00:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="190192865"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2019 00:11:47 -0700
Date:   Wed, 30 Oct 2019 15:09:13 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     linux-rdma@vger.kernel.org
Subject: Re: qperf failure
Message-ID: <20191030070913.GA1901339@jerryopenix>
References: <20191028032728.GA1026409@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028032728.GA1026409@jerryopenix>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Does anyone use qperf to compare TCP & RDMA-RC-Send/Recv bandwidth and latency?

On 11:27 Mon 28 Oct, Liu, Changcheng wrote:
> Hi all,
>    I'm using qperf to compare TCP & RDMARC performance.
>    qperf report that it failed to modify the QP to RTR status.
>    Does anyone know how to solve the problem?
> 
>    Host A:nstcloudcc1 configuration:
>        nstcc1@nstcloudcc1:tmp$ ib2netdev 
>        mlx5_0 port 1 ==> ens261f0 (Up) 173.168.100.103
>        mlx5_1 port 1 ==> ens261f1 (Down) 
>        nstcc1@nstcloudcc1:tmp$ 
>    Host B:rdmarhel0 configuration:
>        [rdma@rdmarhel0 tmp]$ ib2netdev 
>        mlx5_0 port 1 ==> ens801f0 (Up) 173.168.100.101
>        mlx5_1 port 1 ==> ens801f1 (Up) 192.168.100.101
>        [rdma@rdmarhel0 tmp]$ 
> 
>    Run below command on host A as server:
>        nstcc1@nstcloudcc1:tmp$ qperf
>    Run below command on host B as client:
>        [rdma@rdmarhel0 tmp]$ qperf 173.168.100.103 rc_bw
>        rc_bw:
>        failed to modify QP to RTR: Invalid argument
>    The log shows as above on cient that it failed to modify QP to RTR
> 
> --Thanks
> Changcheng
