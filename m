Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F6013478D
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 17:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgAHQSg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 11:18:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:1769 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgAHQSf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jan 2020 11:18:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:18:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="215998036"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga008.jf.intel.com with ESMTP; 08 Jan 2020 08:18:34 -0800
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 08:18:32 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 08:18:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Jan 2020 08:18:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQBA9KVslEuYyDeey67T6R/QEBKZUqh9v0ZHm5pPtKOHCkU6CAfzWyBqWXn/wobeAE0CRLXL6mxr/99AURjJZzGVVRKjwAsyoDc2THEzjVOFzHiZcli065pK5QlnoQpRhCKuIRVMUIKv1iZQTT7bMxkCHEy+diM6IBl+HRfSvtj+JMLeoEoRIQqpSoXDvaGiYPAs1vVoipethNJy+7gIw60CfjsNL5H6EocbMp7QNlNx87AHu7jZXg8MkKZC8p8uwrhyN4Ro2MFWMV35N/5jTbLl4Do1QpQEuB3gsJ12e6y5ZO0FHVjnGH4/fyKJbpnnbBku6Iahirjzhs6OxUWmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BZqtfKR7fMbB4nHEBUo/Bt3c/p1/bllZwGTnWDSDEo=;
 b=ckEoLSgH8QxqL4aDWOhHhSCm2clKT6xxSdSm3vIuDJchgXWGJw7Hlnl+u6ml8BsBblo3jgGA3jBn7k2Em3EJm+xojXJfDDwmWESpyWa8KngepQRLJBQNsp5H+ygONOmI04B5JXYzzRcAnkZPL8+1k/pmBkr+BXRB3tYJXbATLmOmMRfGxumK2zJVMO4zaG6OpG9StYerTn8noVRfzn0VmJTwX4VDZkE2xqyhbWfzv0wlZDCaas9rt70S+Tj7LUNJRmEs1kT70F1bMkGf8Af/ndmRWirI/gXj84mkYM0QGmooioQLaR/dIcQUa7IIsSErz/KUjMJP61bNqu2Josf+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BZqtfKR7fMbB4nHEBUo/Bt3c/p1/bllZwGTnWDSDEo=;
 b=imd9YTqEQRne3I+tJO0efkKmWue+3PO2H2PbSkvWV2NWymrgvn84FZSUi2VuxV6YBuxzjnRuQx2Ay2C6FFxJ5HExyN7OUydSGKa6RP6KAXsg1trlA4TUFAjUyjbFltQwjjUwx3m1Y/caSukaZh3v+052g8V4fbP0emHli2TM9Co=
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com (10.174.97.23) by
 MWHPR1101MB2286.namprd11.prod.outlook.com (10.174.101.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 8 Jan 2020 16:18:31 +0000
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4]) by MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4%11]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 16:18:30 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>
Subject: RE: Recent trace observed in target code during iSer testing
Thread-Topic: Recent trace observed in target code during iSer testing
Thread-Index: AdXEvi9yRk7s01oGS3qaCUi6aFPrnAAR+a+AAE5GdrA=
Date:   Wed, 8 Jan 2020 16:18:30 +0000
Message-ID: <MWHPR1101MB227100196B12AF2494BB184F863E0@MWHPR1101MB2271.namprd11.prod.outlook.com>
References: <MWHPR1101MB2271A83D246FAE4710E47BB2863C0@MWHPR1101MB2271.namprd11.prod.outlook.com>
 <3b724797-275a-9a14-1503-1778780a5872@acm.org>
In-Reply-To: <3b724797-275a-9a14-1503-1778780a5872@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.marciniszyn@intel.com; 
x-originating-ip: [192.55.52.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4b672b1-d36b-40a7-4429-08d7945666d6
x-ms-traffictypediagnostic: MWHPR1101MB2286:
x-microsoft-antispam-prvs: <MWHPR1101MB228656D8402461DA910EC794863E0@MWHPR1101MB2286.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(66946007)(66476007)(186003)(86362001)(2906002)(81166006)(81156014)(76116006)(478600001)(966005)(26005)(8676002)(6506007)(33656002)(66556008)(66446008)(64756008)(8936002)(55016002)(4326008)(5660300002)(316002)(7696005)(54906003)(558084003)(9686003)(71200400001)(52536014)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2286;H:MWHPR1101MB2271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MDSllosKLGuWTo+pGdx8Gu2APxYvLHHH6GMEuRYHV0rlANUhbGP6Z1fAw6mUXA1bWFG+4n3hH0FgMa1NhWtsntt/McdxDh7SHQeeef+wLo3j4CKcqMfTp2itCuRoAOyan8Mq2ndsaCm3Ubge6Spar0vs/8QkevDXlMoKL2Q/zYHK1QmeKSaDc6P3ztel+czGRhOtr74hyVX2mHDF0ORovccbuoQ2KkHhy2JEfC9WM8+ZMND3B2gMS3yy10KYrDItywNF+HKmo6+pfRYrjj+uKrGFJfYD2tBn8BAnw5cwinngDcY+xVvKe5ZcuQOy2YjWlJJQ8jQ/nVjLn7lrjj9whIM26Zadbjcvst2ySFbNQxD7mRn5a77G8Gmb976IRZ4EENap0rY56MvYqeo6GKnQsl69WYj0iVseyiyJYsXbOrFIvlv7UAPDrU3bgSXuh8RIAKDnedMoKjBG43EXdP6aXKebBrXcTM6K4BuDAd0fqTKxIMybTAlPwLhJVPZCZws1vQ0KuV7hqrvyIqagqAYKqA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b672b1-d36b-40a7-4429-08d7945666d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 16:18:30.7821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWQHtwduKl30Be1A0WqL6WajbLVWhQG5t0LWDS6mC+Ipsy1Il1TclyhLMp4Ii5c6IvPEgDPVbLpxS3qyIlVlpq5m0hDFWET45jpveSR92fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2286
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiANCj4gQSBjYW5kaWRhdGUgZml4IGhhcyBiZWVuIHBvc3RlZCBidXQgbmVlZHMgcmV2aWV3IGFu
ZC9vciBhIFRlc3RlZC1ieS4gU2VlDQo+IGFsc28gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlz
dHMvdGFyZ2V0LWRldmVsL21zZzE3OTgxLmh0bWwuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0
Lg0KDQpJJ20gdGVzdGluZyB0aGlzIG5vdy4NCg0KTWlrZQ0K
