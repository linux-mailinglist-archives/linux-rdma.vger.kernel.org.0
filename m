Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802B91BE2CC
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 17:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgD2Pdi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 29 Apr 2020 11:33:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:8618 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgD2Pdi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Apr 2020 11:33:38 -0400
IronPort-SDR: NCPOqmRNQEwt/lEYKO3OrRp6m/RsVEyDKp9PPeyf0xNxwsZDhSDKYBaicHC6bzCkHuZwqCcfcz
 uCDnK6PMB6NA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:33:34 -0700
IronPort-SDR: RJYX6NhL9qb6YXik0zGyrdsVjGAZts+z5OR23h/AT1O1RfL4r9BCr92aVLXAMEfP2p78jM7Zhd
 JTaLfbA5ZX7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="459236582"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2020 08:33:33 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 29 Apr 2020 08:33:33 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.70]) by
 FMSMSX161.amr.corp.intel.com ([10.18.125.9]) with mapi id 14.03.0439.000;
 Wed, 29 Apr 2020 08:33:33 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Denis V. Lunev" <den@openvz.org>
CC:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] i40iw: remove bogus call to
 netdev_master_upper_dev_get
Thread-Topic: [PATCH 1/1] i40iw: remove bogus call to
 netdev_master_upper_dev_get
Thread-Index: AQHWHV8iCMr9rO8fnEWOWdKxb9e/t6iQNmwQ
Date:   Wed, 29 Apr 2020 15:33:32 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7DCD5849C@fmsmsx124.amr.corp.intel.com>
References: <20200428131511.11049-1-den@openvz.org>
In-Reply-To: <20200428131511.11049-1-den@openvz.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 1/1] i40iw: remove bogus call to netdev_master_upper_dev_get
> 
> Local variable netdev is not used in these calls.
> 
> It should be noted, that this change is required to work in bonded mode.
> In the other case we would get the following assert:
>  "RTNL: assertion failed at net/core/dev.c (5665)"
> with the calltrace as follows:
> 	dump_stack+0x19/0x1b
> 	netdev_master_upper_dev_get+0x61/0x70
> 	i40iw_addr_resolve_neigh+0x1e8/0x220
> 	i40iw_make_cm_node+0x296/0x700
> 	? i40iw_find_listener.isra.10+0xcc/0x110
> 	i40iw_receive_ilq+0x3d4/0x810
> 	i40iw_puda_poll_completion+0x341/0x420
> 	i40iw_process_ceq+0xa5/0x280
> 	i40iw_ceq_dpc+0x1e/0x40
> 	tasklet_action+0x83/0x140
> 	__do_softirq+0x125/0x2bb
> 	call_softirq+0x1c/0x30
> 	do_softirq+0x65/0xa0
> 	irq_exit+0x105/0x110
> 	do_IRQ+0x56/0xf0
> 	common_interrupt+0x16a/0x16a
> 	? cpuidle_enter_state+0x57/0xd0
> 	cpuidle_idle_call+0xde/0x230
> 	arch_cpu_idle+0xe/0xc0
> 	cpu_startup_entry+0x14a/0x1e0
> 	start_secondary+0x1f7/0x270
> 	start_cpu+0x5/0x14
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Konstantin Khorenko <khorenko@virtuozzo.com>
> CC: Faisal Latif <faisal.latif@intel.com>
> CC: Shiraz Saleem <shiraz.saleem@intel.com>
> CC: Doug Ledford <dledford@redhat.com>
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: linux-rdma@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 8 --------
>  1 file changed, 8 deletions(-)
> 

Looks right. Thanks!

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
