Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75724587EB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 19:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfF0RFP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 13:05:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:47771 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfF0RFP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 13:05:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 10:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="185340006"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2019 10:05:12 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Jun 2019 10:05:12 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.17]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.41]) with mapi id 14.03.0439.000;
 Thu, 27 Jun 2019 10:05:12 -0700
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Ali Alnubani <alialnu@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2] rsockets: fix variable initialization
Thread-Topic: [PATCH v2] rsockets: fix variable initialization
Thread-Index: AQHVLQUFI7uyxcyygUuZc6gEB6qXz6avupgQ
Date:   Thu, 27 Jun 2019 17:05:11 +0000
Message-ID: <1828884A29C6694DAF28B7E6B8A82373B3EB0432@ORSMSX109.amr.corp.intel.com>
References: <1828884A29C6694DAF28B7E6B8A82373B3EB0374@ORSMSX109.amr.corp.intel.com>
 <20190627162523.5734-1-alialnu@mellanox.com>
In-Reply-To: <20190627162523.5734-1-alialnu@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzIxM2I3OTEtNmIwYi00OWRkLWE3MzctZjk5ZWEyMTQzYmJmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSm9ZZThjUlwvUXhQcVpLS2dSUENsUEdPTSt1XC9xalJCaWtOb3N0NlQ1dFZxdWtKT0ViQWlIYnlqc2hVWmhzUGhlIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBUaGlzIGlzIHRvIGZpeCB0aGUgZXJyb3I6DQo+ICAgYGBgDQo+ICAgWzExNy8zODBdIEJ1aWxk
aW5nIEMgb2JqZWN0IGxpYnJkbWFjbS9DTWFrZUZpbGVzL3JkbWFjbS5kaXIvcnNvY2tldC5jLm8N
Cj4gICBGQUlMRUQ6IGxpYnJkbWFjbS9DTWFrZUZpbGVzL3JkbWFjbS5kaXIvcnNvY2tldC5jLm8N
Cj4gICAvdXNyL2Jpbi9jYyAgLURfRklMRV9PRkZTRVRfQklUUz02NCAtRHJkbWFjbV9FWFBPUlRT
IC1XZXJyb3IgLW0zMg0KPiAgIC1zdGQ9Z251MTEgLVdhbGwgLVdleHRyYSAtV25vLXNpZ24tY29t
cGFyZSAtV25vLXVudXNlZC1wYXJhbWV0ZXINCj4gICAtV21pc3NpbmctcHJvdG90eXBlcyAtV21p
c3NpbmctZGVjbGFyYXRpb25zIC1Xd3JpdGUtc3RyaW5ncyAtV2Zvcm1hdD0yDQo+ICAgLVdmb3Jt
YXQtbm9ubGl0ZXJhbCAtV3JlZHVuZGFudC1kZWNscyAtV25lc3RlZC1leHRlcm5zIC1Xc2hhZG93
DQo+ICAgLVduby1taXNzaW5nLWZpZWxkLWluaXRpYWxpemVycyAtV3N0cmljdC1wcm90b3R5cGVz
DQo+ICAgLVdvbGQtc3R5bGUtZGVmaW5pdGlvbiAtV3JlZHVuZGFudC1kZWNscyAtTzIgLWcgIC1m
UElDIC1JaW5jbHVkZSAtTU1EDQo+ICAgLU1UIGxpYnJkbWFjbS9DTWFrZUZpbGVzL3JkbWFjbS5k
aXIvcnNvY2tldC5jLm8gLU1GDQo+ICAgImxpYnJkbWFjbS9DTWFrZUZpbGVzL3JkbWFjbS5kaXIv
cnNvY2tldC5jLm8uZCIgLW8NCj4gICBsaWJyZG1hY20vQ01ha2VGaWxlcy9yZG1hY20uZGlyL3Jz
b2NrZXQuYy5vICAgLWMgLi4vbGlicmRtYWNtL3Jzb2NrZXQuYw0KPiAgIC4uL2xpYnJkbWFjbS9y
c29ja2V0LmM6IEluIGZ1bmN0aW9uIOKAmHJzX2dldF9jb21w4oCZOg0KPiAgIC4uL2xpYnJkbWFj
bS9yc29ja2V0LmM6MjE0ODoxNTogZXJyb3I6IOKAmHN0YXJ0X3RpbWXigJkgbWF5IGJlIHVzZWQN
Cj4gICB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0
aWFsaXplZF0NCj4gICAgICBwb2xsX3RpbWUgPSAodWludDMyX3QpIChyc190aW1lX3VzKCkgLSBz
dGFydF90aW1lKTsNCj4gICAgICAgICAgICAgICAgICBeDQo+ICAgLi4vbGlicmRtYWNtL3Jzb2Nr
ZXQuYzogSW4gZnVuY3Rpb24g4oCYZHNfZ2V0X2NvbXDigJk6DQo+ICAgLi4vbGlicmRtYWNtL3Jz
b2NrZXQuYzoyMzA3OjE1OiBlcnJvcjog4oCYc3RhcnRfdGltZeKAmSBtYXkgYmUgdXNlZA0KPiAg
IHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxp
emVkXQ0KPiAgICAgIHBvbGxfdGltZSA9ICh1aW50MzJfdCkgKHJzX3RpbWVfdXMoKSAtIHN0YXJ0
X3RpbWUpOw0KPiAgICAgICAgICAgICAgICAgIF4NCj4gICAuLi9saWJyZG1hY20vcnNvY2tldC5j
OiBJbiBmdW5jdGlvbiDigJhycG9sbOKAmToNCj4gICAuLi9saWJyZG1hY20vcnNvY2tldC5jOjMz
MjE6MTU6IGVycm9yOiDigJhzdGFydF90aW1l4oCZIG1heSBiZSB1c2VkDQo+ICAgdW5pbml0aWFs
aXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdDQo+ICAg
ICAgcG9sbF90aW1lID0gKHVpbnQzMl90KSAocnNfdGltZV91cygpIC0gc3RhcnRfdGltZSk7DQo+
ICAgICAgICAgICAgICAgICAgXg0KPiAgIGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQg
YXMgZXJyb3JzDQo+ICAgWzEyMi8zODBdIEJ1aWxkaW5nIEMgb2JqZWN0IHByb3ZpZGVycy9lZmEv
Q01ha2VGaWxlcy9lZmEuZGlyL3ZlcmJzLmMubw0KPiAgIG5pbmphOiBidWlsZCBzdG9wcGVkOiBz
dWJjb21tYW5kIGZhaWxlZC4NCj4gICBgYGANCj4gV2hpY2ggcmVwcm9kdWNlcyBvbiBSSEVMNy41
IHdpdGggNC44LjUgMjAxNTA2MjMgKFJlZCBIYXQgNC44LjUtMjgpDQo+IGFuZCAzMi1iaXQgbGli
cmFyaWVzLg0KPiANCj4gQnVpbGQgc3RlcHMgdG8gcmVwcm9kdWNlOg0KPiAgIGBgYA0KPiAgIG1r
ZGlyIGJ1aWxkMzIgJiYgY2QgYnVpbGQzMiAmJiBDRkxBR1M9Ii1XZXJyb3IgLW0zMiIgY21ha2Ug
LUdOaW5qYSBcDQo+ICAgLURFTkFCTEVfUkVTT0xWRV9ORUlHSD0wIC1ESU9DVExfTU9ERT1ib3Ro
IC1ETk9fUFlWRVJCUz0xICYmIFwNCj4gICBuaW5qYS1idWlsZA0KPiAgIGBgYA0KPiANCj4gbWVz
b24gdmVyc2lvbjogMC40Ny4yDQo+IG5pbmphLWJ1aWxkIHZlcnNpb246IDEuNy4yDQo+IA0KPiBG
aXhlczogMzhjNDkyMzJiNjdhICgicnNvY2tldHM6IFJlcGxhY2UgZ2V0dGltZW9mZGF5IHdpdGgg
Y2xvY2tfZ2V0dGltZSIpDQo+IENjOiBzZWFuLmhlZnR5QGludGVsLmNvbQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQWxpIEFsbnViYW5pIDxhbGlhbG51QG1lbGxhbm94LmNvbT4NCg0KVGhhbmtzDQoN
CkFja2VkLWJ5OiBTZWFuIEhlZnR5IDxzZWFuLmhlZnR5QGludGVsLmNvbT4NCg==
