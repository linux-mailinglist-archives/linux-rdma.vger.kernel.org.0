Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584573428F7
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 23:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCSW5z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 18:57:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:17705 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhCSW5X (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 18:57:23 -0400
IronPort-SDR: xPpPO85fRUUKHo3qJSEvu4pB6ZfZd5us1gZZll3Zi462p7V+9pHAzmP3f9vI7nPFwccENOeV+2
 +KWhCvPiBZuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="187633833"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="187633833"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 15:57:23 -0700
IronPort-SDR: hj0S1K5A1JtKi+XH3dzd9ReiBOnD97i+aB6RrQGK09NHvtks/JZ0W4zu26aa2+eKtfDpi1fObt
 QxvJAUXUjFTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="441471140"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2021 15:57:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 15:57:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Mar 2021 15:57:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Mar 2021 15:57:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JS7sXeFdMVbZ4RmUoFdeJ2pOXhO1Id2LBv9m1CS5l/XnrOnCwdr1RII8OGp/tRPXzPkHxBQ+MNJHhF4HzmK2N/G1ZcCC0PWXlsKwZtXfqz5AB3aUsosKkoUdT2wyKPcQo6cDYwTr5tSjnc1ti836PKqA4qRftAth1bv5kt69iDqULKJIs+QLSYbf+uNPs0NeI0KcBqM0w4Ftnx6HCXaY/AQOajPUuUeMS8Isc3w5UZ9cVy3qCKbE+OkDDb9pE/pKAcNbmJUrFTbKvG1BKmtM2egfqtuQEjygDZZo+agVQt56rmoZTGhcPlDBK4Eh2bnEt2dChhNvdT16kaYOnyMK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E66XY9ha/ijufz2n6y/QsBs/NSqsBpDIhrBdIFvp2F8=;
 b=UltDW5kRPZ1EyKrhD4PRQpLnddlphNX5gPbpCcKIxBiMfIzJ01kHuXVhObRakQW2t27MBGQtO0g5z/wZnnO4gKxqkEh/A8u5mFUGIk9aSWRUDdofpbkOWC3zunY5bpwN/sWGAWtgdLcASc5gCHZZUp7xxpiD+MQMnXTKV9QRfutCK3N2UNHxfJrO+Me+L2JCpyYqpDQ1R80oQe8GcCpEY/yHmqUSGXMcpGRGKCizRd/yWyMSozlx9F2dVmX0FDZMoe2DAH1tnAoflIP9Z6Rp837EM7uHBBj2tMNuLtOu8jRqoLIDf1auRdXzMelpyaob6AXsWST9BiCjfd+6+x9eRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E66XY9ha/ijufz2n6y/QsBs/NSqsBpDIhrBdIFvp2F8=;
 b=YPC4hHRAI5Nxc4+wcR2+XmRfKWZ/TA0TTkB34q++TgT1vsZhQGjKutjEApLNcJVbmoFYyJpekVXr78jNusdEtNzx73h8CgKTYNyKOurCnCzXndK+AVIr9Zm6ethFnoS49YuI0/uyd5z0EbZso6z5qsjNT7IFQhVitpSvoGNZAsQ=
Received: from BL0PR11MB3299.namprd11.prod.outlook.com (2603:10b6:208:6f::10)
 by MN2PR11MB4581.namprd11.prod.outlook.com (2603:10b6:208:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 19 Mar
 2021 22:57:21 +0000
Received: from BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::e93c:a632:64d0:a21e]) by BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::e93c:a632:64d0:a21e%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 22:57:21 +0000
From:   "Rimmer, Todd" <todd.rimmer@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9NWKHPWRS8q02lI/8GbNsnUaqLVNwAgAAPxoCAABBfgIAAO/qAgAAGJwCAAAPXgIAAB86AgAAC+OCAAAThAIAAAWWAgAAIBgCAAA2d0A==
Date:   Fri, 19 Mar 2021 22:57:20 +0000
Message-ID: <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
In-Reply-To: <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [100.34.146.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cef8d18-b073-4593-1929-08d8eb2a5a69
x-ms-traffictypediagnostic: MN2PR11MB4581:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4581344386544F1E24EEE8B0F6689@MN2PR11MB4581.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hIWzQRG5oaPOaV9+twtJROQ+nECcGycXA5ki5kJYmgro9N+uxH1v+eCLh6xppvlSZcJqGdU9CSMu8OX65wOzEbMRTaTstFQA1gZxrhWf2vIcSmnLR0QKsAmww9gyJImPvj7DugXFj0nyvwvaF/2nFV+GT1huwVh0RSJBIQ6WAWURDRL2DzqC07ywzNT3lbguRDJYyZ0l5fxzI//Cs1RW0o6SW7Bsz0oUWNrgNx8Kyz043wwE2QD6amQkW8CnKmiBQcHcv4ntF2pY42UpSfvruUjrqS4UNJivwSvJ9hsyBJgJNm8Wm4fdz/82jTc0mUGu3BihEFWXZmW/8bJ4nw68LmBCHrPfqFVU7wZE14km89h8dU5fk7X/i2xvXuoYVaV/GFxahQIlLfdiIoLaLhERE3X8ctmc1Y4ctUOhAzqaL5ib+VVc3SA/nsnRsJR8ICmFcEFvKndX7P1QAdGf8LQoOChHiHvafstw4kmY+iAqMENH+Uht4maQOOO4zE9Yo8gR6dcBfI8lIFZIblYBg3lZEx+rCv7NRj8fpjG0CFkHLzt0I0ViiEEywJCnRMiPBMSJqkB2DQtgmM9RhND+f6IaqavUw83RjwBxv/8UcPaJHwebCbOn35/yRwyrfPg11xeDDysSGcP07pz8inrjdbLjYrEjzsJ3IGgVVLf8gCjq5Ms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(366004)(346002)(55016002)(107886003)(9686003)(64756008)(316002)(83380400001)(66556008)(6506007)(186003)(66446008)(7696005)(52536014)(76116006)(5660300002)(2906002)(478600001)(66946007)(71200400001)(54906003)(110136005)(86362001)(8936002)(33656002)(26005)(38100700001)(8676002)(4326008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OHBHUitWbW5jRW91K2NLa3QvNFI5L2xTZjZtVmRLcCszUFFqczlRMEFlaE1p?=
 =?utf-8?B?MXphZFVTbmJJZkNZaGlOVy8yQnE4YmJFZWtZZWlQOWhLLzBJa0xwNWFhUW1L?=
 =?utf-8?B?R2FuaUdrSm1NeDI2M3ZrU3lsbklwTW1pRWw5NHZ0Q3UvVk5nMXFYUmVPYnI2?=
 =?utf-8?B?VmdDUmVrVXh5NDQ3S1JxKzdRVFlvU2tkQXZjcnc1TXhmV1gwQ0xGRkUzSmNt?=
 =?utf-8?B?QkNudFdzUWxyR25RWm1Bc0wxYkluUE9UR29ua3NFR1JLUlljZDMrdnRma2tJ?=
 =?utf-8?B?cGFNYkI3VS9iakswVnFwaWVjNXJ3VGpFZFlTYTIyRHJhUlJkMEx2aWpsREha?=
 =?utf-8?B?VWFIajJodUJKTnMwMXlKR2ZRSktybnJGbE5tUnB2STZ2QzEvaCtzQ0UrTmdw?=
 =?utf-8?B?ejJyUlVqRW9RRkFMa0lYYXNGVXI4SExCenYzQkxxVy8yajBLaXUzT3NIZzhS?=
 =?utf-8?B?VXFLS0d1UmkweE8wT0g3aUQ4QjhCeFFWckpNRjEycVFBNnh3R2t3dDNta2hD?=
 =?utf-8?B?ZndGSE9EakFoZU10WXcvdkN0clFZejcvOHVvdXVGcWt4bVpzdFZUTjB5SWJY?=
 =?utf-8?B?UHQ3TmVOM1ZPTDkySTBlSzNSMlVKenY5Y0pvRjE0d09FQkF2aXVaRFFpM2Q5?=
 =?utf-8?B?cHpEay9xZkpNYkR0MTZPM1p2ZUswbTkvb2QzZEwzSHBNL1pnSUE4ZlFpUWtx?=
 =?utf-8?B?MU9VSnROMXJHelcrdzdxVjFEQ00yOEo0RHhCcXlvMUZNUU1QdXdXWVZpMzAr?=
 =?utf-8?B?RkJaU2k4ODM1L0dMVDlXcFFPK2JuTnRKeDh4aXE4RmpTamlRejhJKzl3T2JO?=
 =?utf-8?B?alA1MVNBbXQvU1M3RjNEQW5QMkdRYnVLUHk4MndFeHc2SXpXVWliVWpiZEpM?=
 =?utf-8?B?YUZBdTQyZ0Riajh1VUxtZjhRcmU2ekVSY0NwOXNXOFpCaERvYzlYT1R1dVRX?=
 =?utf-8?B?Nk5rZVZFQ2g0Nlc5OXlEYXorS3QxUStuRFc3eXBxQmxzMWJockRxZDkwVnV6?=
 =?utf-8?B?ODY3VVJyMlcvZHp2dzlqZGZrZDZXSU5vUHAxUHNBMTBYTzlFTHJIY2lGOXlk?=
 =?utf-8?B?VXpFVW5tY2VwNXdwMGFsUnE0cHV3aDZWT29PUWJYYnU5WEF5eWZJSVhuekEw?=
 =?utf-8?B?T1Zrb0ZmRmtoWTlKTmlFbEorMjdvWW5JMEU3ZjFXSy9QaVJ6YzBtT0Q5S0Fr?=
 =?utf-8?B?V2MwVjdHSCtKZUZrdWVWcjlkS20yQkQxSG93dzJDRTJpMmZpK3hQTUMwcThP?=
 =?utf-8?B?NnVPQWxPVUY1MFVvdUhGSkdsb2s2ckpENVZnYkVsdHNrbXFvQUpFK0puVUNh?=
 =?utf-8?B?QWdwYjkwNDIveUFjNWlNL3BUbndkSUh4cHp3R3EwamU2SEs1bVd4akErY0Zs?=
 =?utf-8?B?Qm1nN2FsbnRGYmFNekZESW4wbWc4Wmg3WWJuUy9EM0hKSnYxV1FUdHZ4b1d5?=
 =?utf-8?B?bnF4bVc0bElFcUgwSmQrUExFZ2JXV0tPazRZQXRidGpaRGFpT2JSK2s5S2FZ?=
 =?utf-8?B?UmtidlAvM2JMT2FzTEMzekpxaStMaWJjdlRtbStVNmpHazNvM3g5YlBkTDhW?=
 =?utf-8?B?L1pvTmpQVXRUaW9pUnNpc3pJNk1DSVBuM0Y0c2Y1K3pDenBkL0I1SjBVTDRy?=
 =?utf-8?B?azE5MlYyeGVMUzZKa2FUd3ZIcERUa3YvTlZQZEZqTTdLTytDZ3RHQXNvOW9P?=
 =?utf-8?B?aVBrK2Jrbk1ORmNWUWt4Q0ZTWFZXZUpMN0crUmhQbjM4NFFwZVFvU0pSRnhm?=
 =?utf-8?Q?qmgHO9PrgqZJLohQlogryDrnxA4xGj6bK+hLlZv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cef8d18-b073-4593-1929-08d8eb2a5a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 22:57:20.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJujpO2PkgLFlsQyrNAUxatHNuVdR7kBz5dW6/HuiFodijhuj3CTgCmixgvZrGGM2/gjsIKtICvsjlYF11qLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4581
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiA+IFtXYW4sIEthaWtlXSBJbmNvcnJlY3QuIFRoZSBydiBtb2R1bGUgd29ya3Mgd2l0aCBoZmkx
Lg0KPiANCj4gSW50ZXJlc3RpbmcuIEkgd2FzIHRoaW5raW5nIHRoZSBvcHBvc2l0ZS4gU28gd2hh
dCdzIHRoZSBiZW5lZml0PyBXaGVuIHdvdWxkDQo+IHNvbWVvbmUgd2FudCB0byBkbyB0aGF0Pw0K
VGhlIG1vcmUgaW50ZXJlc3Rpbmcgc2NlbmFyaW8gaXMgZm9yIGN1c3RvbWVycyB3aG8gd291bGQg
bGlrZSB0byBydW4gbGliZmFicmljIGFuZCBvdGhlciBPcGVuIEZhYnJpY3MgQWxsaWFuY2Ugc29m
dHdhcmUgb3ZlciB2YXJpb3VzIHZlcmJzIGNhcGFibGUgaGFyZHdhcmUuDQpUb2RheSBQU00yIGlz
IGEgZ29vZCBjaG9pY2UgZm9yIE9QQSBoYXJkd2FyZS4gIEhvd2V2ZXIgZm9yIHNvbWUgb3RoZXIg
ZGV2aWNlcyB3aXRob3V0IGV4aXN0aW5nIGxpYmZhYnJpYyBwcm92aWRlcnMsIHJ4bSBhbmQgcnhk
IGFyZSB0aGUgYmVzdCBjaG9pY2VzLg0KQXMgd2FzIHByZXNlbnRlZCBpbiBPcGVuIEZhYnJpY3Mg
d29ya3Nob3AgdG9kYXkgYnkgSmFtZXMgRXJ3aW4sIFBTTTMgb2ZmZXJzIG5vdGljZWFibGUgYmVu
ZWZpdHMgb3ZlciBleGlzdGluZyBsaWJmYWJyaWMgcnhtIGFuZCByeGQgcHJvdmlkZXJzDQphbmQg
dGhlIHJ2IG1vZHVsZSBvZmZlcnMgbm90aWNlYWJsZSBwZXJmb3JtYW5jZSBiZW5lZml0cyB3aGVu
IHVzaW5nIFBTTTMuDQoNCj4gVGhpcyBkcml2ZXIgaXMgaW50ZW5kZWQgdG8gd29yayB3aXRoIGEg
Zm9yayBvZiB0aGUgUFNNMiBsaWJyYXJ5LiBUaGUNCj4gUFNNMiBsaWJyYXJ5IHdoaWNoIGlzIGZv
ciBPbW5pLVBhdGggaXMgbm93IG1haW50YWluZWQgYnkgQ29ybmVsaXMNCj4gTmV0d29ya3Mgb24g
b3VyIEdpdEh1Yi4gUFNNMyBpcyBzb21ldGhpbmcgZnJvbSBJbnRlbCBmb3IgRXRoZXJuZXQuIEkN
Cj4ga25vdyBpdCdzIGEgYml0IGNvbmZ1c2luZy4NCkludGVsIHJldGFpbnMgdmFyaW91cyBJUCBh
bmQgdHJhZGVtYXJrIHJpZ2h0cy4gIEludGVsJ3MgbWFya2V0aW5nIHRlYW0gYW5hbHl6ZWQgYW5k
IGNob3NlIHRoZSBuYW1lIFBTTTMuICBPYnZpb3VzbHkgcGx1c3NlcyBhbmQgbWludXNlcyB0byBh
bnkgbmFtZSBjaG9pY2UuDQoNClRoaXMgaXMgbm90IHVubGlrZSBvdGhlciBpbmR1c3RyeSBzb2Z0
d2FyZSBoaXN0b3J5IHdoZXJlIG5ldyBtYWpvciByZXZpc2lvbnMgb2Z0ZW4gYWRkIGFuZCByZW1v
dmUgc3VwcG9ydCBmb3IgdmFyaW91cyBIVyBnZW5lcmF0aW9ucy4NClBTTSgxKSAtIHN1cHBvcnRl
ZCBpbmZpbmlwYXRoIElCIGFkYXB0ZXJzLCB3YXMgYSBzdGFuZGFsb25lIEFQSSAodmFyaW91cyBm
b3JtcykuDQpQU00yIC0gZHJvcHBlZCBzdXBwb3J0IGZvciBpbmZpbmlwYXRoIGFuZCBJQiBhbmQg
YWRkZWQgc3VwcG9ydCBmb3IgT21uaS1QYXRoLCBhbG9uZyB3aXRoIHZhcmlvdXMgZmVhdHVyZXMs
IGFsc28gYWRkZWQgbGliZmFicmljIHN1cHBvcnQNClBTTTMgLSBkcm9wcGVkIHN1cHBvcnQgZm9y
IE9tbmktUGF0aCwgYWRkZWQgc3VwcG9ydCBmb3IgUm9DRSBhbmQgdmVyYnMgY2FwYWJsZSBkZXZp
Y2VzLCBhbG9uZyB3aXRoIG90aGVyIGZlYXR1cmVzLA0KCWFsc28gZHJvcHBlZCBQU00yIEFQSSBh
bmQgc3RhbmRhcmRpemVkIG9uIGxpYmZhYnJpYy4NCkFsbCB0aHJlZSBoYXZlIHNpbWlsYXIgc3Ry
YXRlZ2llcyBvZiBvbmxvYWQgcHJvdG9jb2xzIGZvciBlYWdlciBtZXNzYWdlcyBhbmQgc2hhcmVk
IGtlcm5lbC9IVyByZXNvdXJjZXMgZm9yIGxhcmdlIG1lc3NhZ2VzDQphbmQgZGlyZWN0IGRhdGEg
cGxhY2VtZW50IChSRE1BKS4gIFNvIHRoZSBuYW1lIFBlcmZvcm1hbmNlIFNjYWxlZCBNZXNzYWdp
bmcgaXMgbWVhbnQgdG8gcmVmbGVjdCB0aGUgY29uY2VwdCBhbmQgYXBwcm9hY2gNCmFzIG9wcG9z
ZWQgdG8gcmVmbGVjdGluZyBhIHNwZWNpZmljIEhXIGltcGxlbWVudGF0aW9uIG9yIGV2ZW4gQVBJ
Lg0KDQpQU00zIGlzIG9ubHkgYXZhaWxhYmxlIGFzIGEgbGliZmFicmljIHByb3ZpZGVyLg0KDQo+
IEkgaGF2ZW4ndCBoYWQgYSBjaGFuY2UgdG8gbG9vayBiZXlvbmQgdGhlIGNvdmVyIGxldHRlciBp
biBkZXB0aCBhdCBob3cgdGhpbmdzDQo+IGhhdmUgY2hhbmdlZC4gSSByZWFsbHkgaG9wZSBpdCdz
IG5vdCB0aGF0IGJhZC4NCldoaWxlIGEgZmV3IHN0eWxpc3RpYyBlbGVtZW50cyBnb3QgY2Fycmll
ZCBmb3J3YXJkLCBhcyB5b3Ugbm90aWNlZC4gIFRoaXMgaXMgbXVjaCBkaWZmZXJlbnQgZnJvbSBo
ZmkxIGFzIGl0IGRvZXNuJ3QgZGlyZWN0bHkgYWNjZXNzIGhhcmR3YXJlIGFuZCBpcyBoZW5jZSBz
bWFsbGVyLg0KV2UgY2FyZWZ1bGx5IGxvb2tlZCBhdCBvdmVybGFwIHdpdGggZmVhdHVyZXMgaW4g
aWJfY29yZSBhbmQgdGhlIHBhdGNoIHNldCBjb250YWlucyBhIGNvdXBsZSBtaW5vciBBUEkgYWRk
aXRpb25zIHRvIGliX2NvcmUgdG8gc2ltcGxpZnkgc29tZSBvcGVyYXRpb25zDQp3aGljaCBvdGhl
cnMgbWF5IGZpbmQgdXNlZnVsLg0KDQo+IEkgYWxzbyBkb24ndCBrbm93IHdoeSB5b3UgcGlja2Vk
IHRoZSBuYW1lIHJ2LCB0aGlzIGxvb2tzIGxpa2UgaXQgaGFzIGxpdHRsZSB0byBkbyB3aXRoIHRo
ZSB1c3VhbCBNUEkgcmVuZGV6dm91cyBwcm90b2NvbC4NClRoZSBmb2N1cyBvZiB0aGUgZGVzaWdu
IHdhcyB0byBzdXBwb3J0IHRoZSBidWxrIHRyYW5zZmVyIHBhcnQgb2YgdGhlIE1QSSByZW5kZXp2
b3VzIHByb3RvY29sLCBoZW5jZSB0aGUgbmFtZSBydi4NCldlJ2Qgd2VsY29tZSBvdGhlciBuYW1l
IHN1Z2dlc3Rpb25zLCB3YW50ZWQgdG8ga2VlcCB0aGUgbmFtZSBzaW1wbGUgYW5kIGJyaWVmLg0K
DQo+IE5vIHByZS1hZGRpbmcgcmVzZXJ2ZWQgc3R1ZmYNCj4gTG90cyBvZiBhbGlnbm1lbnQgaG9s
ZXMsIGRvbid0IGRvIHRoYXQgZWl0aGVyLg0KV2UnZCBsaWtlIGFkdmlzZSBvbiBhIGNoYWxsZW5n
aW5nIHNpdHVhdGlvbi4gIFNvbWUgY3VzdG9tZXJzIGRlc2lyZSBOSUNzIHRvIHN1cHBvcnQgblZp
ZGlhIEdQVXMgaW4gc29tZSBlbnZpcm9ubWVudHMuDQpVbmZvcnR1bmF0ZWx5IHRoZSBuVmlkaWEg
R1BVIGRyaXZlcnMgYXJlIG5vdCB1cHN0cmVhbSwgYW5kIGhhdmUgbm90IGJlZW4gZm9yIHllYXJz
LiAgU28gd2UgYXJlIGZvcmNlZCB0byBoYXZlIGJvdGggb3V0IG9mIHRyZWUNCmFuZCB1cHN0cmVh
bSB2ZXJzaW9ucyBvZiB0aGUgY29kZS4gIFdlIG5lZWQgdGhlIHNhbWUgYXBwbGljYXRpb25zIHRv
IGJlIGFibGUgdG8gd29yayBvdmVyIGJvdGgsIHNvIHdlIHdvdWxkIGxpa2UgdGhlDQpHUFUgZW5h
YmxlZCB2ZXJzaW9ucyBvZiB0aGUgY29kZSB0byBoYXZlIHRoZSBzYW1lIEFCSSBhcyB0aGUgdXBz
dHJlYW0gY29kZSBhcyB0aGlzIGdyZWF0bHkgc2ltcGxpZmllcyB0aGluZ3MuDQpXZSBoYXZlIHJl
bW92ZWQgYWxsIEdQVSBzcGVjaWZpYyBjb2RlIGZyb20gdGhlIHVwc3RyZWFtIHN1Ym1pc3Npb24s
IGJ1dCB1c2VkIGJvdGggdGhlICJhbGlnbm1lbnQgaG9sZXMiIGFuZCB0aGUgInJlc2VydmVkIg0K
bWVjaGFuaXNtcyB0byBob2xkIHBsYWNlcyBmb3IgR1BVIHNwZWNpZmljIGZpZWxkcyB3aGljaCBj
YW4ndCBiZSB1cHN0cmVhbWVkLg0KDQpUb2RkDQo=
