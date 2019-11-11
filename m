Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3145F7507
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2019 14:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKKNeC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 11 Nov 2019 08:34:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:50894 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfKKNeB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 Nov 2019 08:34:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 05:33:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="197670958"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2019 05:33:58 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 11 Nov 2019 05:33:58 -0800
Received: from orsmsx160.amr.corp.intel.com ([169.254.13.204]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.131]) with mapi id 14.03.0439.000;
 Mon, 11 Nov 2019 05:33:57 -0800
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: RE: [PATCH rdma-next 16/16] RDMA: Change MAD processing function to
 remove extra casting and parameter
Thread-Topic: [PATCH rdma-next 16/16] RDMA: Change MAD processing function
 to remove extra casting and parameter
Thread-Index: AQHVjiIi6oSG3mnZKUWKNWhjPS34VaeGDHAQ
Date:   Mon, 11 Nov 2019 13:33:57 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC74671E3A@ORSMSX160.amr.corp.intel.com>
References: <20191029062745.7932-1-leon@kernel.org>
 <20191029062745.7932-17-leon@kernel.org>
In-Reply-To: <20191029062745.7932-17-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDYxY2U5MzAtNWEyNi00MWYzLThlYmQtN2YyODhkMzdiODUzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVWtvMmV0N3lGUTczVldVbmVPRFBPWDdKTVMzeDN3aUhobHp1QklESFBsM2dpK1BjUFBPV2REVFk3SGJuZFR5ZCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH rdma-next 16/16] RDMA: Change MAD processing function
> to remove extra casting and parameter
> 
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> All users of process_mad() converts input pointers from ib_mad_hdr
> to be ib_mad, update the function declaration to use ib_mad directly.
> 
> Also remove not used input MAD size parameter.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---

One workqueue failure we have been fighting  for a while, so the mad stuff looks fine.

Tested-By: Mike Marciniszyn <mike.marciniszyn@intel.com>
