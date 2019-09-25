Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F032BE2BE
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 18:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391998AbfIYQqf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 25 Sep 2019 12:46:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:8811 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387922AbfIYQqf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Sep 2019 12:46:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 09:46:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="191395786"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 25 Sep 2019 09:46:34 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Sep 2019 09:46:34 -0700
Received: from fmsmsx123.amr.corp.intel.com ([169.254.7.221]) by
 fmsmsx163.amr.corp.intel.com ([169.254.6.229]) with mapi id 14.03.0439.000;
 Wed, 25 Sep 2019 09:46:34 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Michal Kalderon <michal.kalderon@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        "aelior@marvell.com" <aelior@marvell.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/core: Fix use after free and refcnt leak
 on ndev in_device in iwarp_query_port
Thread-Topic: [PATCH rdma-next] RDMA/core: Fix use after free and refcnt
 leak on ndev in_device in iwarp_query_port
Thread-Index: AQHVc56PbEQKb9j/ykOTB1nM7NIfhqc8f6Lw
Date:   Wed, 25 Sep 2019 16:46:33 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7AC7011C3@fmsmsx123.amr.corp.intel.com>
References: <20190925123332.10746-1-michal.kalderon@marvell.com>
In-Reply-To: <20190925123332.10746-1-michal.kalderon@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGIwMzY2ZjgtYjkxMS00NDg3LTk5NWQtMjhmMWM0YjZlMTUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUHF6OHloVDVQcEVnWXFaR2hOSEZ0eDBqdmtzQmIzU1JwMjRCY0kwQjJQaVpoOUsrVVkyVDVkYklyV0UrS2RnZSJ9
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

> Subject: [PATCH rdma-next] RDMA/core: Fix use after free and refcnt leak on ndev
> in_device in iwarp_query_port
> 
> If an iWARP driver is probed and removed while there are no ips set for the device,
> it will lead to a reference count leak on the inet device of the netdevice.
> 
> In addition, the netdevice was accessed after already calling netdev_put, which
> could lead to using the netdev after already freed.
> 
> Fixes: 4929116bdf72 ("RDMA/core: Add common iWARP query port")
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---

Looks ok. Thanks!

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
