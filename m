Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF42E2C3
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfE2RDM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 29 May 2019 13:03:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:56751 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfE2RDL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 May 2019 13:03:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 10:03:10 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 29 May 2019 10:03:10 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.29]) by
 FMSMSX103.amr.corp.intel.com ([169.254.2.236]) with mapi id 14.03.0415.000;
 Wed, 29 May 2019 10:03:10 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: RE: [PATCH for-rc 5/6] RDMA/efa: Use rdma block iterator in chunk
 list creation
Thread-Topic: [PATCH for-rc 5/6] RDMA/efa: Use rdma block iterator in chunk
 list creation
Thread-Index: AQHVFVOA5dKzcOgI5k217EohYF8d96aCVaeg
Date:   Wed, 29 May 2019 17:03:09 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5B07A3B@fmsmsx124.amr.corp.intel.com>
References: <20190528124618.77918-1-galpress@amazon.com>
 <20190528124618.77918-6-galpress@amazon.com>
In-Reply-To: <20190528124618.77918-6-galpress@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2E0OWQxY2ItNWRiNC00Yzk0LThjZTktYWZiMTU0ZGUyZDc5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNGFyOGRFMDY4dnBiN2RcL1FaTHROVmQyMHg2TmtxcjBwZkhDeDZkMldMclZpUWQzRXlrUWpQRmVFWnFQTTIwZEUifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH for-rc 5/6] RDMA/efa: Use rdma block iterator in chunk list
> creation
> 
> When creating the chunks list the rdma_for_each_block() iterator is used in order
> to iterate over the payload in EFA_CHUNK_PAYLOAD_SIZE (device
> defined) strides.
> 
> Cc: Shiraz Saleem <shiraz.saleem@intel.com>
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---

Looks ok.

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
