Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D567144113
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2020 16:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgAUP6A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jan 2020 10:58:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:46584 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgAUP6A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Jan 2020 10:58:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 07:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="215581230"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2020 07:57:55 -0800
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jan 2020 07:57:54 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jan 2020 07:57:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 21 Jan 2020 07:57:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lewZTmzphLN4st30Q3Cd+mIyw1/C8cNA+s4JMQdTk6EVyNe5NBI+F0ogcGkrpdjirkgeXGfQFUWHP8Bf1BCGuvwRQ5FOaV0XKtabxTF2//8q55NUVORLpAVqreCPAkUoNP9mfIh6JUE3MfLfdd/GoLQGWvE/JzGTkZkGG+KD30LVwPgNUP+QhgkMT4jrdWYejdwd6+Wy1dnPxZtmLB6uVZ+c0EIsKagoUBKR6TJdh4BrLol80RrMh6JsMBOhKifkav+cp66RScrPN0xksU05SwhT9lAwYeFwolbeK2CE/2taToHZI+AqHLAbjUXWOFmdotrYCIXHQmNGGsgegHn9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BMBkcc7n4M2za4hLsFLBwo3yN7xLShpg6ZhFNMNIcU=;
 b=gHow72Igs5rCPoDDckhJ5E43oYVPeXzlSgD4ao9G3Z29xGiZbWzbiRoY3gMxMKBQyyYAQo11MCjUwBukNZSoYNP0Fy64x5fLWXElOvt/tc9vQwp8k+4Z55Je8yr3XYDRzpIs/nrNd4oes1mCjHB+YI8qmzDxs/DoCCNzddGjGidAKYmz3324vGHFLFJcXs9izwrCIZrP+/lhCa57ljYf3tz6SjoMsvBY8Wcc/ViUXcLidFW9vPL+7FuvROiJMKQVvRgk1yCpyiqkaByHFfTxtYZgO1kDJVMKqrPtvoIqnASorgW0quH6CwNqM912jgWKN1U5dNR2Ca08HqraYQscbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BMBkcc7n4M2za4hLsFLBwo3yN7xLShpg6ZhFNMNIcU=;
 b=h4P0Iq/qATUxxuopgkX4IIJ23a2uwKrcr5f4NVj0nCXyVmn3DZRdWr9UPwX5WeNL2SGxGKSRqfcw6nePLcaRoSAGCNNuWQh9sFjltRkQYTUrO3mX/e6ZVKxXRjQdKbrp03zvQvFMnZd+YkB7tdQIHugBxNW3KB2pP/LsDMQFo2M=
Received: from BYAPR11MB3272.namprd11.prod.outlook.com (20.177.186.74) by
 BYAPR11MB2888.namprd11.prod.outlook.com (20.177.226.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 15:57:53 +0000
Received: from BYAPR11MB3272.namprd11.prod.outlook.com
 ([fe80::695c:9bae:99c1:32ca]) by BYAPR11MB3272.namprd11.prod.outlook.com
 ([fe80::695c:9bae:99c1:32ca%5]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 15:57:53 +0000
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Honggang LI <honli@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: resource leak in librdmacm
Thread-Topic: resource leak in librdmacm
Thread-Index: AQHV0FVu1T1pGcLIMkKSo2QDIdq5E6f1RiGQ
Date:   Tue, 21 Jan 2020 15:57:53 +0000
Message-ID: <BYAPR11MB3272F4913688AE9B3BFF815C9E0D0@BYAPR11MB3272.namprd11.prod.outlook.com>
References: <20200121122133.GA105701@dhcp-128-72.nay.redhat.com>
In-Reply-To: <20200121122133.GA105701@dhcp-128-72.nay.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjBmZjI1NTItNmE1Ni00MzFiLTlkZTQtMGJjNDcyNGUxM2JhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiblZDVWE4Qm5BbE5mYVFPXC9XVEtvOVRqNzRTUW80Nkp0S01OZW5MVG9VdlJqb0djXC9ldnBaM2pXelRPRGZUbFhMIn0=
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sean.hefty@intel.com; 
x-originating-ip: [192.55.52.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7394403-66fd-4a76-bdc5-08d79e8aacb9
x-ms-traffictypediagnostic: BYAPR11MB2888:
x-microsoft-antispam-prvs: <BYAPR11MB288833834752881357D7B5C69E0D0@BYAPR11MB2888.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:85;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(3480700007)(4744005)(71200400001)(76116006)(6506007)(66556008)(66476007)(64756008)(66446008)(66946007)(478600001)(2906002)(86362001)(55016002)(33656002)(9686003)(7696005)(316002)(52536014)(26005)(8676002)(8936002)(186003)(5660300002)(110136005)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB2888;H:BYAPR11MB3272.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PxzGzCFsflei9J6MMV8DUmK9AP67JMUNbqUUycNbmFET/BWhHnD4R9LCXeMMWnsbIW148aD/SOOw/Qhmy1I5PSnpC6QWV2prKYIe0jX/Pvd+kGvZh4dPiyO8wxXq+sr/JVpsFOSmNKttM8JFKKCr1//P1U9+8crNhyOjznTbAaf6HoSOAK1oFKc5lEIwQhRxnpiQdFFZ5qqMPSQdFvDrisQh8y8v72SJTd1yKhA/GzvSruPxOb9+ncSJb7eDx5r4xuQtUqUXU7g8gmmQ/IMRtBdjeVNWCLqBiE4PBwbJsbLfbunjUibQcNdCA+ZLo7zLgbhR3oXHc1RtTDyqE2ENl86lMzMmYuOUyqqDwJDIfT88VNVrAyjbhIB5OEw9O6ppANNetvJiuQMsCsD0u1Nz7HmatdFrGVqcSAxDGJMiv9VIrUjfk2HWRyIVUziL09TR
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b7394403-66fd-4a76-bdc5-08d79e8aacb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 15:57:53.4755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3eBhkfJ+gnJrD/ceERyNACkeZWywKU2Zaoe8NbuwO7gZfdne6aLR6Wx0QneygqwxvnP1tEAFbnrGl+qIGaoiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2888
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> 	ch =3D rdma_create_event_channel();
> 	if (ch =3D=3D NULL)
> 		printf("rdma_create_event_channel failed\n");
>=20
> 	ret =3D rdma_create_id(ch, &id, NULL, RDMA_PS_TCP);
> 	if (ret !=3D 0)
> 		printf("rdma_create_id failed\n");
>=20
> 	ret =3D rdma_bind_addr(id, (struct sockaddr *) &ipoib_addr);
>=20
> 	if (ret !=3D 0)
> 		printf("rdma_bind_addr failed\n");
>=20
> 	rdma_destroy_event_channel(ch);

This call should fail, since there's still a valid id open on it.

> 	rdma_destroy_id(id);
> }

- Sean
