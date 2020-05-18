Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCE61D7CA2
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgERPUE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 11:20:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:41831 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgERPUE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 May 2020 11:20:04 -0400
IronPort-SDR: FrE+UQpP7HDNwBGMZQwmDjPN10uTGjsx1xgU65oLGGBV//U8CJcE7sKRdXp7MJCGhpGrzW32y5
 uclWOLSiX4yg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:20:04 -0700
IronPort-SDR: TwvvZXgwz9Mj6McdJkAqv1pEp5DnVTd5wkGbiPqkHW1arH2E6zlkjzveMoQlX9u0HARdrWPXuw
 IDf5SnywEoaA==
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="252924699"
Received: from aarcot-mobl.amr.corp.intel.com (HELO [10.254.207.94]) ([10.254.207.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:20:00 -0700
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Max Gurtovoy <maxg@mellanox.com>, bvanassche@acm.org,
        jgg@mellanox.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
        leon@kernel.org
Cc:     sagi@grimberg.me, israelr@mellanox.com, shlomin@mellanox.com,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
References: <20200514120305.189738-1-maxg@mellanox.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <f2efe2df-14db-4e15-3807-f81b799cc0ec@intel.com>
Date:   Mon, 18 May 2020 11:20:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514120305.189738-1-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/14/2020 8:02 AM, Max Gurtovoy wrote:
> This series removes the support for FMR mode to register memory. This ancient
> mode is unsafe and not maintained/tested in the last few years. It also doesn't
> have any reasonable advantage over other memory registration methods such as
> FRWR (that is implemented in all the recent RDMA adapters). This series should
> be reviewed and approved by the maintainer of the effected drivers and I
> suggest to test it as well.
> 
> The tests that I made for this series (fio benchmarks and fio verify data):
> 1. iSER initiator on ConnectX-4
> 2. iSER initiator on ConnectX-3
> 3. SRP initiator on ConnectX-4 (loopback to SRP target)
> 4. SRP initiator on ConnectX-3
> 
> Not tested:
> 1. RDS
> 2. mthca
> 3. rdmavt

This will effectively kill qib which uses rdmavt. It's gonna have to be 
a NAK from me.

-Denny

