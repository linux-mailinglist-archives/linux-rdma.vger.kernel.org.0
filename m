Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517D82D3E69
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 10:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgLIJTE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 04:19:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:61728 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgLIJTB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Dec 2020 04:19:01 -0500
IronPort-SDR: 1fQ6RBtfd+af7pwdMPPRB9BntrrZ0wRS2iYFkf0UjwdnRu3iGCRCHVVaHdy2aE9T8k3tXlrdLz
 f88GKRdDllrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="258755377"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="258755377"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 01:18:16 -0800
IronPort-SDR: ztL5sBazXDD7ixuWK7L6Q1Q1G4Mtq6vglNlxuvtw9oZQMTNCMLMK26LckT2vvpKR+LHt/JLBvP
 ijzRZnwBO75A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="332865269"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2020 01:18:13 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Dec 2020 01:18:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 9 Dec 2020 01:18:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 9 Dec 2020 01:18:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFVm3TUYhtVnSsMwU8jlQJY29YqoEPRZ6l5s86y9ShjbW5ByuUjnS51HEZtsWW/WdDTGPKj5Mu4E3pIYEFdBrhHMYhvuXH5l2w9JDORILsLGLJmGJMv4+BGhRr/FuXsjRtTeHM0tNEUQrHRbFQNHlWqf5LK82a6FCpZXdzxAOW+A7FYZeaN2TF948l2jLKEZnCsgERJPDI3plj4111wCkcfaGVZ8TY94J3TpOv7MVwGhesUxDUZs74TtVgpqLZ+AiCXC0nbguP28m8sQH6539j+mdSXj5P603fj7ZojSEaOrD+Ypyz75y9UflLOgfGnRDSAlW2/bPZGSTdieyR2ZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpEdvYD2S0sPpUsJaqzFfjba3maACAJD5ZuuBRpPyT4=;
 b=PkA/7T4APHS1lDj83uaqlaimSmwhmyntDkuMbO4313e6oThh4myoC0/XW7ouguD5x2qIXb4sovNpXuhJ1KlD80NhTJPhmL7HwzNnjk0FHhuq6DtZOdrBfL8sKBccHatXfFNg76OKFoKz5LTw3t6hXf+VNhiZ+HJm0XRgOe5vpRU32nyh6qvuMs86e/pt0alg16zzU3XshGCDOgPC2WBVc+t9KxduvmjksTARYsoVry//VPxT8zeKZZCIUiq95442d9hKwGJE6c+WmLU3BJhTEEN9y+YViAApcPf/n9hhlP02E8hLMB/B+K8C235DIkKb79Gz7EmxwejGD1z7U3v69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpEdvYD2S0sPpUsJaqzFfjba3maACAJD5ZuuBRpPyT4=;
 b=Pff/iECp1G+mhqc+bCdmEfC8lkP47xs5V2kyU/8AfxwLdi4YJ6NHf7GXHrO0Dy8ldtpnkdBQTsX3VRN1C5P5BbSkviLjAJVoH7WlyYvYXV5sc+p14/O4w7iwNL9h5j2Y0tIVDuiudXyMAJmwwCMAlczQvtMOmI+EW6bLQ6uVmUw=
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 09:18:10 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::b825:191:f494:c4e5]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::b825:191:f494:c4e5%8]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 09:18:10 +0000
From:   "Wang, Long1" <long1.wang@intel.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "Wang, Long1" <long1.wang@intel.com>
Subject: possible rdma-core memory leak issues
Thread-Topic: possible rdma-core memory leak issues
Thread-Index: AdbODB1lFvSGUPntQbqerwlcKqKHHg==
Date:   Wed, 9 Dec 2020 09:18:10 +0000
Message-ID: <MWHPR11MB13924162ECC06D1883E3F9B2C5CC0@MWHPR11MB1392.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfe80816-69f8-4a49-bb28-08d89c2358da
x-ms-traffictypediagnostic: CO1PR11MB4929:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4929E23EEE370282616DE0ECC5CC0@CO1PR11MB4929.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: enSMi8A3YEF8L6mJ8aLkQNHHkKCDL5uQg4Jvk5NN3XEyuzNZn7JfqWrhsJcSCfQ4zoBeiw3oBFeyHt2UpijNTgpl0Uyhr9AuJoLX7R+P07/WzJAGH/b0VsEvu7sif0fVsExiqG+p4jOxb3PPjlce8+Lc56HDaOPRJVE90lGgUvt/2mZjKax9sM9vR9n5nktRBpaPKAcW4m/9/k/2Yowpxw483L8SLwyaFB9SlgdykGSneO8ttJ1gUMAH9OqUMjC+bgJJ6DIl7S3m0+wzDCQ0JtUiW3SQEIagSU9FYxxmTYadidWwU2y9YlSzidytVkwZUaMGvkyeQI1u2WeNEt9/Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(71200400001)(66946007)(66446008)(8936002)(5660300002)(66556008)(2906002)(64756008)(8676002)(66476007)(83380400001)(508600001)(76116006)(86362001)(33656002)(52536014)(4326008)(7696005)(26005)(107886003)(186003)(55016002)(6916009)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ISdPegg0JqctHZh93AAQc8B7IjdEzL088PeYWVKrvCU7q4wG9C0LbMKp1pOD?=
 =?us-ascii?Q?5PRaTicUlaQFQGEjjVgSPSspCX6NB3JFftSB8iuSP58eyB1eeqm8OGEJdfuJ?=
 =?us-ascii?Q?5qA/cq/aVEuoSpHOkvnJNdknNNw4JLueccwn29aycEENvFHTkeD69A94ivT2?=
 =?us-ascii?Q?0qfhD80GhAVaesFHCvjtFPrdXPu0gr+R9Vdkasta9kqmtBnKlN4hTDKtdjah?=
 =?us-ascii?Q?GLaKHkhG9S1kGWgmIEcpwjGgGORFvlWNFul/ZhqU/eX8LBqf5e+vyRmHcszb?=
 =?us-ascii?Q?tQXYvoyJABa4mpxedrG2lOAta7qOsX5h3ZPTXwEpctv6qDr8MzjNSVCtZ5Hx?=
 =?us-ascii?Q?n1VsNQWcQu9+ofhE2ueE7rJtbYs/Mq62eOZCfnm30Zmdq3s+S1sWmNHpXB4m?=
 =?us-ascii?Q?hOkgELdEKxyjkkzT+z8kn2/GWWIUx8W313njDiTTA8+MBmdFzW1Y5ujZlffv?=
 =?us-ascii?Q?WaUitFsHvdOaCxBFcr3K5zRcfBwrxaz84OEPXMIjlN9etkWrqlCYJcKYiGXf?=
 =?us-ascii?Q?cGHBYAz43YKNwePnL9GjWEgo/v2hWvQviBW+YDmgmPQyu+0ILL9CULXPDyxE?=
 =?us-ascii?Q?yCSfcAnITJmGJ6mYox1guhg0dGiz4zRridp15Sm5okwnTg5bZ6yqwew6XetW?=
 =?us-ascii?Q?d19A8d7IsNWMDoFWI6Pr8+F4PPhZrD/lrhh7ARiaOvhmapKJDJ6FU+h8Xogm?=
 =?us-ascii?Q?H9IdUmjj6k40jesh5sU70aZ7MczDNo6bNPtX73MTgXNypytP5/BTEkSWZQcM?=
 =?us-ascii?Q?Oc+JIeHheQqoTF2D/OEonSJBppgroJe9Dox+C8duVRGSq3j2+nq42q7RJV+O?=
 =?us-ascii?Q?fA+plUsp2BS+FWMZrCURIcEICH/6LYpW2WsMCCDkDCl4pc7JNGdzkbVNNaI4?=
 =?us-ascii?Q?ogpICYgnMxhzEkGah+9m/E5fh5cqtzK6LHoZYbEFK+hq6taUCZA3kmHE1FKs?=
 =?us-ascii?Q?hfRyw/dL74yv2Be4jfBOMWUIEmNEVrWbMoyfXfu/tX0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe80816-69f8-4a49-bb28-08d89c2358da
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 09:18:10.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K638w1ptnMeilh4Y0SbQNEx2CyGPHdghbjp76El1j7H+YDRXuCWWEaHVe1wAJLanmxuqJsNopdMQihGdfoU/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When running valgrind memory leak test, there are a few possible lost warni=
ng reported from rdma-core/librdmacm library.=20
It could be real memory leak? Please see below print-out for one item withi=
n them.

=3D=3D26556=3D=3D 1 bytes in 1 blocks are possibly lost in loss record 1 of=
 14
=3D=3D26556=3D=3D    at 0x483A755: malloc (vg_replace_malloc.c:309)
=3D=3D26556=3D=3D    by 0x4A5E3FE: ucma_init_device.part.0 (cma.c:447)
=3D=3D26556=3D=3D    by 0x4A5EA6F: ucma_init_device (cma.c:628)
=3D=3D26556=3D=3D    by 0x4A5EA6F: ucma_get_device (cma.c:631)
=3D=3D26556=3D=3D    by 0x4A5EBD8: ucma_query_addr (cma.c:888)
=3D=3D26556=3D=3D    by 0x4A611D8: ucma_process_addr_resolved (cma.c:2245)
=3D=3D26556=3D=3D    by 0x4A611D8: rdma_get_cm_event (cma.c:2532)
=3D=3D26556=3D=3D    by 0x4A61AFE: ucma_complete (cma.c:1111)
=3D=3D26556=3D=3D    by 0x4A61BFA: rdma_resolve_addr2 (cma.c:1148)
=3D=3D26556=3D=3D    by 0x484E57E: rpma_info_resolve_addr (info.c:113)
=3D=3D26556=3D=3D    by 0x48507E3: rpma_utils_get_ibv_context (rpma.c:57)
=3D=3D26556=3D=3D    by 0x4012BD: main (client.c:45)

BTW. It is ran from rpma examples, which called rdma-core libraries.
