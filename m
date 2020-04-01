Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED83519B909
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 01:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbgDAXkk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Apr 2020 19:40:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:57101 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387484AbgDAXkj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Apr 2020 19:40:39 -0400
IronPort-SDR: UMiRyoKdndtuB5afZFlySOtycAUznqAxfvaIXU8DXZEYWCNpOICvGY8Gio0dU5lQB51W70X0Gt
 ZjLqMzNsWrDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 16:40:38 -0700
IronPort-SDR: RlGonMBaS2L5DDZVJmlMOjYTm6IrWey3LLJVqzCi5feW9yRwImY9YJy/Qw7iYwGvhwNePw3rEX
 LtmlI1c653AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="252811963"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2020 16:40:38 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 16:40:38 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.220]) by
 FMSMSX126.amr.corp.intel.com ([169.254.1.221]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 16:40:38 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Colin King <colin.king@canonical.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Devale, Sindhu" <sindhu.devale@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] i40iw: fix null pointer dereference on a null wqe
 pointer
Thread-Topic: [PATCH][next] i40iw: fix null pointer dereference on a null
 wqe pointer
Thread-Index: AQHWCHfMm+gLXhUTAU2UIQaZoCR1S6hk7B9Q
Date:   Wed, 1 Apr 2020 23:40:37 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7C611609E@fmsmsx124.amr.corp.intel.com>
References: <20200401224921.405279-1-colin.king@canonical.com>
In-Reply-To: <20200401224921.405279-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0hdW25leHRdIGk0MGl3OiBmaXggbnVsbCBwb2ludGVyIGRlcmVmZXJl
bmNlIG9uIGEgbnVsbCB3cWUgcG9pbnRlcg0KPiANCj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNv
bGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gDQo+IEN1cnJlbnRseSB0aGUgbnVsbCBjaGVjayBm
b3Igd3FlIGlzIGluY29ycmVjdCBhbmQgbGV0cyBhIG51bGwgd3FlIGJlIHBhc3NlZCB0bw0KPiBz
ZXRfNjRiaXRfdmFsIGFuZCB0aGlzIGluZGV4ZXMgaW50byB0aGUgbnVsbCBwb2ludGVyIGNhdXNp
bmcgYSBudWxsIHBvaW50ZXINCj4gZGVyZWZlcmVuY2UuICBGaXggdGhpcyBieSBmaXhpbmcgdGhl
IG51bGwgcG9pbnRlciBjaGVjayB0byByZXR1cm4gYW4gZXJyb3IgaWYgd3FlIGlzDQo+IG51bGwu
DQo+IA0KPiBBZGRyZXNzZXMtQ292ZXJpdHk6ICgiZGVyZWZlcmVuY2UgYWZ0ZXIgYSBudWxsIGNo
ZWNrIikNCj4gRml4ZXM6IDRiMzRlMjNmNGVhYSAoImk0MGl3OiBSZXBvcnQgY29ycmVjdCBmaXJt
d2FyZSB2ZXJzaW9uIikNCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtp
bmdAY2Fub25pY2FsLmNvbT4NCg0KVWdoISBZZXMuIFRoYXTigJlzIGEgYmFkIG9uZS4gVGhhbmtz
IGZvciB0aGUgZml4Lg0KDQpBY2tlZC1ieTogU2hpcmF6IFNhbGVlbSA8c2hpcmF6LnNhbGVlbUBp
bnRlbC5jb20+DQo=
