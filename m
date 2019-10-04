Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19BFCC493
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 23:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfJDVJN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 17:09:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:48665 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbfJDVJN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 17:09:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 14:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="191699362"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga008.fm.intel.com with ESMTP; 04 Oct 2019 14:09:13 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 4 Oct 2019 14:09:12 -0700
Received: from orsmsx160.amr.corp.intel.com ([169.254.13.209]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.180]) with mapi id 14.03.0439.000;
 Fri, 4 Oct 2019 14:09:12 -0700
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>, Greg KH <greg@kroah.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "Hiatt, Don" <don.hiatt@intel.com>
Subject: RE: [bug report] IB/hfi1: Eliminate allocation while atomic
Thread-Topic: [bug report] IB/hfi1: Eliminate allocation while atomic
Thread-Index: AQHVeRsrXvx5iv7efkOZGUpXiG3n5adJRvyAgAG0jsA=
Date:   Fri, 4 Oct 2019 21:09:12 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC72911CA9@ORSMSX160.amr.corp.intel.com>
References: <20191002121520.GA11064@mwanda>
 <3452a307-5f87-4587-b289-63ea8bc594b5@intel.com>
In-Reply-To: <3452a307-5f87-4587-b289-63ea8bc594b5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2U4YzM3NWYtNDhjYi00MTAwLWE1ZWYtNzgzM2I2MTllZDRjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMmNGM3RMK3lcL0VuZll3ZE5JWll1eCtGTkk0bjdJekZRdHRvSmZHbTIwTUVrcWYwREdiRjloU3Z4ek5zVFN0Y0cifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiANCj4gVGhhbmtzIERhbiwgd2UgYWN0dWFsbHkgZ290IGEgc2VwYXJhdGUgb3V0LW9mLWJhbmQg
ZW1haWwgYWJvdXQgdGhpcy4gV2UNCj4gYXJlIHdvcmtpbmcgdXAgYSBmaXggcmlnaHQgbm93Lg0K
PiANCj4gLURlbm55DQoNCkRhbiwNCg0KVGhpcyBqdXN0IGhpdCB0aGUgbGlzdCBpbiBodHRwczov
L21hcmMuaW5mby8/bD1saW51eC1yZG1hJm09MTU3MDIyMjE3OTI3MTQzJnc9Mi4NCg0KQ2FuIHlv
dSB0YWtlIGEgbG9vaz8NCg0KWW91IG1lbnRpb24gYSBjaGFuZ2UgaW4gZG1hX21hcF9zaW5nbGUo
KS4NCg0KRG8geW91IGhhdmUgYW4gZGV0YWlscyBvbiB0aGF0Pw0KDQpNaWtlDQo=
