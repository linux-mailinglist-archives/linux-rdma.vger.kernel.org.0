Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66581B777B
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 15:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDXNu3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 09:50:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:15449 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgDXNu3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 09:50:29 -0400
IronPort-SDR: +fsqupmTXBmafTaycO/G7WYPN1Rad91lFmrgBvrmQFk2o8RISPMcKmRXP74vh2XxfoDwdAuyp3
 wsSOmEewv0Xg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 06:50:28 -0700
IronPort-SDR: 8fjcEJiDO2ruG7MQB1H8Gkca8dUfaKDbie26y/u/VTiS21bTGrdRcMTlc2PFBg2kUUXgphQK5u
 xQlb6tJFwWKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="246595304"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga007.fm.intel.com with ESMTP; 24 Apr 2020 06:50:28 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Apr 2020 06:50:24 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Apr 2020 06:50:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 24 Apr 2020 06:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXbdG/yPQvcyuAsloRxUmL0C7VQZR0cz3DYnl/ft0uHxGKBb3kyY32G4/6PdoeRtSXVtGEO5h2Awu9JWoFVQfGy9i20kTe2A3BMITf8X6TgZ+d5IpV+tOIWi/65w6tzc45ndyvlpVTnfFaIeJOJUhOOZoArxk3lhJMXMundgvCXR6KOl4xr64SoOpgQmtNjdZ22PB81g6SPbRDJIAZrkCBK8l61Gdaztm4DK7ch+bhLvJHNWfEveyZ9ib27IK/Lv3voFv/v4mJySt89jN4LydVe5BmWypus0enHqK68D+F2X0Z9GnMFbEnmOjTO7WXR+uZgtLJCrsW8a03/ViaRMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhQyJ5wBBBxXyzfMXBN/hpbIRlKfe82aShWmBP8c5xY=;
 b=lI7b/cJlXb1eA1pWdqMZsgdl0Zooc/x1/PWDv0+yx7BFxcxLEJIpicDCtyXOpWluaGxKWYN4jdSFw1v0+EeyNsU0stUpH2W+kGCv6P8gvweJcyisiXeZi1cqwdthbgD7KxxM+ZvXDPCf0ING+iok7/SsrGq02RL0FRdH3Pl2GCiSz9atvpef7vtfBXRXDrvSZ59AAFtt5HIyz0hS/xRGjK3VyVteACOiFZ4u1xiFPJFjrUsTJmX1+61ws6g0CXjJnmve+1dL0C6wXQACMuv2pv8TAPIfKb3OXZpLchh5njgp058wr3kb9FEEGvyv5/rjyoBFPFamKnv7a8svqiHgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhQyJ5wBBBxXyzfMXBN/hpbIRlKfe82aShWmBP8c5xY=;
 b=SwA6aEsdNkAI7o3/ZulYIqdE9lcPIGn06txmhFLb8ed7sJy0VaUZG8BJh/lEy//KAOpqhDEXRF8M0EEUjdc6Hfu4hvYSYaAXnX9jrDGO7jNUBFga5J6cM8BLimyO4cBaN3uphSsdeWDUywBxzpO6hFMlQbaTfjr3VZKn6L2uUhw=
Received: from BY5PR11MB3958.namprd11.prod.outlook.com (2603:10b6:a03:18e::19)
 by BY5PR11MB4021.namprd11.prod.outlook.com (2603:10b6:a03:191::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 13:50:22 +0000
Received: from BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::e57f:cc7f:1fda:69c1]) by BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::e57f:cc7f:1fda:69c1%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 13:50:22 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
CC:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] IB/rdmavt: return proper error code
Thread-Topic: [PATCH] IB/rdmavt: return proper error code
Thread-Index: AQHWGWd1CYnztpE4g0qOcUuaVAX/Y6iGvuGAgAGLwWA=
Date:   Fri, 24 Apr 2020 13:50:22 +0000
Message-ID: <BY5PR11MB3958DBE0C624D035D00E5AAB86D00@BY5PR11MB3958.namprd11.prod.outlook.com>
References: <20200423120434.19304-1-sudipm.mukherjee@gmail.com>
 <20200423140947.GX26002@ziepe.ca>
In-Reply-To: <20200423140947.GX26002@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.marciniszyn@intel.com; 
x-originating-ip: [192.55.52.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100d6c05-ca32-4516-0161-08d7e8566f0f
x-ms-traffictypediagnostic: BY5PR11MB4021:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB402140D47DA9448FB0B3937486D00@BY5PR11MB4021.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(39860400002)(376002)(346002)(5660300002)(52536014)(26005)(4326008)(76116006)(66946007)(186003)(2906002)(9686003)(478600001)(66556008)(66446008)(55016002)(71200400001)(64756008)(4744005)(33656002)(86362001)(110136005)(8676002)(8936002)(6506007)(7696005)(81156014)(66476007)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lkMJIXfVF182p1XOZHD08D6chUK0DidmRuv9+Ha5TmsZms7MJLFjWEJV061usSvT3KQ+4QzS4sXAhqR/hJkAiWojy4kVaA/rPNpB2DHaf6/ISevLC6a6RwTEFHsnoX7Q5loCEFf8F+dSX4xsKltG2wlG1fBmgG1h22Sy4HXhGVvpcZvnUw4lRlGJtVxqeOcuO3Mr8eO44KdSsnkAR3LfVPzsNjoIRzM1ZG0NYaP+EjdctaFrsTd4CyzU24Ai2PK0PjnbDlUATERysbqueXQGkmdn4w035gkuAMlIBBYgCOF8zrlWGGELMIsyJyJiuWGgbfmDY4ZEcyaH/EGE5aBqx9ujT8VNeKO4B+P5uifdEJS7EaqDncx2xhZJj0PVOTCfrGM6pSIu8po5iMeQv3+LUKEj4M4F42iBQSLb1LwwqphymDJ9CRbRvaQ2/mZv91FW
x-ms-exchange-antispam-messagedata: 6sSPDBuUcX9QRnN+I2kw6/DS8BqKoD/Cs9POdakGNbXOKpWTP/uQKk9p3Av/4lAEjaDFvkOfql/c6g4750bpuvX4L0H1ITtv62jiBwcV+z3YoSM4HLvzMw6Pk/Prnwl9oPeR6tP1KuN3APyteTBuQg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 100d6c05-ca32-4516-0161-08d7e8566f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 13:50:22.2681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LsDDikKhaNbIdifC0MWCCn+CO/TPCrvLLwW+JRFFQID47JOvxLuZ+1v0rvnS5UXRsD4ZdMHdDf1GV3JmuYf43J3JFAKx9V3fclYgTuxtUMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4021
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH] IB/rdmavt: return proper error code
>=20
> On Thu, Apr 23, 2020 at 01:04:34PM +0100, Sudip Mukherjee wrote:
> > The function rvt_create_mmap_info() can return either NULL or an error
> > in ERR_PTR(). Check properly for both the error type and return the
> > error code accordingly.
>=20
> Please fix rvt_create_mmap_info to always return ERR_PTR, never null
> on failure.
>=20
> Thanks,
> Jason

I agree on the ERR_PTR return, but the patch is incomplete.

The original patch:

Fixes: ff23dfa13457 ("IB: Pass only ib_udata in function prototypes")

Broke all the call sites: cq.c, srq.c, and qp.c.

Mike


