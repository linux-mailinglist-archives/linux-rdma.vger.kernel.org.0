Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635A339DFB0
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 16:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhFGO4U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 10:56:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:7934 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231565AbhFGO4L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 10:56:11 -0400
IronPort-SDR: ytL71b1zWRzII2jeqe56kNEPIXwa4Ahr3wWVMGX8Q/3wPKjgLgQp9ufTBLjxybZBJwsRNHKAKL
 XdynYUCTOFBw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="184318708"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="184318708"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 07:54:13 -0700
IronPort-SDR: GKfauxzmt5Wx+IUbSF2ECpSt8l7TrWzly7xm0vwJeU1VVHzH6NCWLcT13rQwJKR2Mpv3eAOqPe
 Cf+hUrFAb1vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551255634"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2021 07:54:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:54:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:54:11 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Mon, 7 Jun 2021 07:54:11 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Colin King <colin.king@canonical.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] RDMA/irdma: Fix spelling mistake "Allocal" ->
 "Allocate"
Thread-Topic: [PATCH][next] RDMA/irdma: Fix spelling mistake "Allocal" ->
 "Allocate"
Thread-Index: AQHXWaBDokSFZom3xk6g3wea5VbMR6sHHTrg
Date:   Mon, 7 Jun 2021 14:54:11 +0000
Message-ID: <2141f5220efd4b788dc7feda1f5018d6@intel.com>
References: <20210605001802.15948-1-colin.king@canonical.com>
In-Reply-To: <20210605001802.15948-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0hdW25leHRdIFJETUEvaXJkbWE6IEZpeCBzcGVsbGluZyBtaXN0YWtl
ICJBbGxvY2FsIiAtPiAiQWxsb2NhdGUiDQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29s
aW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVGhlcmUgaXMgYSBzcGVsbGluZyBtaXN0YWtl
IGluIGEgbGl0ZXJhbCBzdHJpbmcuIEZpeCBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9p
bmZpbmliYW5kL2h3L2lyZG1hL3V0aWxzLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lu
ZmluaWJhbmQvaHcvaXJkbWEvdXRpbHMuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS91
dGlscy5jDQo+IGluZGV4IDJmMDc4MTU1ZDZmZC4uOGYwNDM0N2JlNTJjIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvdXRpbHMuYw0KPiArKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvaHcvaXJkbWEvdXRpbHMuYw0KPiBAQCAtNjM2LDcgKzYzNiw3IEBAIHN0YXRpYyBj
b25zdCBjaGFyICpjb25zdA0KPiBpcmRtYV9jcXBfY21kX25hbWVzW0lSRE1BX01BWF9DUVBfT1BT
XSA9IHsNCj4gIAlbSVJETUFfT1BfU0VUX1VQX01BUF0gPSAiU2V0IFVQLVVQIE1hcHBpbmcgQ21k
IiwNCj4gIAlbSVJETUFfT1BfR0VOX0FFXSA9ICJHZW5lcmF0ZSBBRSBDbWQiLA0KPiAgCVtJUkRN
QV9PUF9RVUVSWV9SRE1BX0ZFQVRVUkVTXSA9ICJSRE1BIEdldCBGZWF0dXJlcyBDbWQiLA0KPiAt
CVtJUkRNQV9PUF9BTExPQ19MT0NBTF9NQUNfRU5UUlldID0gIkFsbG9jYWwgTG9jYWwgTUFDIEVu
dHJ5DQo+IENtZCIsDQo+ICsJW0lSRE1BX09QX0FMTE9DX0xPQ0FMX01BQ19FTlRSWV0gPSAiQWxs
b2NhdGUgTG9jYWwgTUFDIEVudHJ5DQo+IENtZCIsDQoNCkFja2VkLWJ5OiBTaGlyYXogU2FsZWVt
IDxzaGlyYXouc2FsZWVtQGludGVsLmNvbT4NCg==
