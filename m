Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A21ACFB4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 20:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbgDPScG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 14:32:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:65499 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgDPScG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 14:32:06 -0400
IronPort-SDR: DGENHD06qhkzAu9ci1xk4mSHaBb60P6vpCx1fxyQchf06R6VB0yXLQ+/JZrX1NUc/SiHqxTCSI
 stOxxtdLSILA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 11:32:03 -0700
IronPort-SDR: 2r0hQ7QVl9EZtnVdqTH9gMjlEzUq7VzMigE8++46shCW8DBHxFUiEyTwvANTPCZk5ASfUdfdx/
 zkRbmEzXnxFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="277524877"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga008.jf.intel.com with ESMTP; 16 Apr 2020 11:32:03 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 11:32:02 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX163.amr.corp.intel.com (10.22.240.88) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 11:32:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 11:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj6sS5RCQJWiupCixTWVBYRiXMP0OA57+tWlTv+IIknK8X9IAh1+Dtmm1se+nrlDlSrPGkwjjTPkut5dmoU8n+Jq3TOvqHkOhxAbhbNJJ/su7/939vs2pUmZCgmPCz8pHmaattQgTV8wPDKupw6CNhJoUdspqeuRaA/wXr8kNovvjRTLUEdnPeIoTT31W186z8/2OlTLMOk4QfLRxZv6PN783yT1jRQNRfy6Bu8b9pyhBN+LR9ROOp2h4rqgeEUtaIun/BWMfBNgSgO4tnJu6TPEogPIartvLXfFY6izDExPfkvPDzUmYn7VPaPwsHTScrYUfJsiVrq3dqHgOb4y+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi2gihlN8K+I0AsfDOHFJdFQ7VZlxRWuJzJD31vp7os=;
 b=UwehTSBejr57RmFYNvmb3owER8YNtdJ3i7E6wuX6n2Q9yE1JZKle0hmaqXoMg9+Ybiy8L2wCd203ftpZwho6AxQN6mvSyQqFECTMnsNeq5GP+b2bT8IsEuwS9hY2w6IgWuBSueMT3KQ6hEXsqL6W49II9Z8O6tf09Mqtx0u9C8Ypt9YN3hg0eY62rRejIEm+oATMHE05FBjVE+Zg6NxA7lvzUPFPz896bI5AO9eVTqLu3vdp9nwhIh8CKpX6fqjV6iAGbYulkLAejxZuZAdCcWMGkJvgpnzdL5s1PvELENxNt9M4Zv+7VaD5Ufw7N+ltc1GeZ3PkBLWtqzxbJMwWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi2gihlN8K+I0AsfDOHFJdFQ7VZlxRWuJzJD31vp7os=;
 b=K5ucLj0HM/IJ0meCCsz2pNkzG9Hn2BLDhl2u9n7nF7yNm3+GxvCzYux4kZHxr9ouMCI0LRMb/jSNiV/Bzzu9xWxwFgT68x8U34nTqG91aF5jkyhYSHXVkk27Z6Ongar5wkIx+4Fhoxnj3laNpVV1ymVpxUdwwAnRglfYnUD5fpM=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 16 Apr
 2020 18:32:01 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 18:32:01 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Leon Romanovsky" <leon@kernel.org>
Subject: RE: [RFC PATCH 2/3] RDMA/uverbs: Add uverbs commands for fd-based MR
 registration
Thread-Topic: [RFC PATCH 2/3] RDMA/uverbs: Add uverbs commands for fd-based MR
 registration
Thread-Index: AQHWFBA2yF7HTDayL02EqZyaQbiAyah8BigAgAAJXaA=
Date:   Thu, 16 Apr 2020 18:32:01 +0000
Message-ID: <MW3PR11MB45556D47A2D3767A4ECC32BFE5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-3-git-send-email-jianxin.xiong@intel.com>
 <20200416174748.GS5100@ziepe.ca>
In-Reply-To: <20200416174748.GS5100@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jianxin.xiong@intel.com; 
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb2a4dee-1f92-48db-733a-08d7e234742c
x-ms-traffictypediagnostic: MW3PR11MB4684:
x-microsoft-antispam-prvs: <MW3PR11MB46843766A683F9C9AAA06766E5D80@MW3PR11MB4684.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(396003)(376002)(136003)(346002)(366004)(6506007)(66476007)(66946007)(86362001)(76116006)(26005)(7696005)(2906002)(6916009)(66556008)(64756008)(66446008)(478600001)(316002)(81156014)(9686003)(55016002)(4326008)(71200400001)(33656002)(52536014)(5660300002)(54906003)(186003)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFYr4LElLV6sB6pRzgaAYI1eBk8Ojy7XdDpxO2asy2xW9G91qZQ7xqKKvF8V8lgXCpDzrEmCwz40c04K5KiQtVPPdSgsytgxh8KSN9YfzlwvwLF08Wd1XADUHa6eLa6q9lDD9TRBm0bh0pQ6EnKNeKauNHQwsCTJBZX19QrpJiqqAzxCQyuS/PNdR0Kx6zAeYtozlWTxW0CLAnz57MUZ31VY7wsfRoYmYqk7vbBe58yVdiVzSVOsTzRjlTlNVUZRDPnRyYcGC8FSD2rIBg5XS4du1C8EkBN/ZT0DsHrgWclCU8zQZZ3UaxSU+/9wxspzKFE4ba8G2h5ZYeCIRRzYF0vanDZOllOrR+bgCo8k2m2rKdo93NrY74P9DW+dgSIxWliAH97D/k2g5ZaPKVY/QEEDWIppGcPtqOG+GmJjJiERz83T1C5NPqGzJ/Q1h1/s
x-ms-exchange-antispam-messagedata: iJU/A87w4pbUcWs5/pgRwBAusqYHZVNKvHEt2Y+LTSmYRCYSYB0grmA0nZ+fYoK7i9IluvDHEM65qlt5a2CVXb5f+yvtuFbEnh1pv3cZdYKDXAVoRHDyI7bwLfVW/Zd7duq+rGmyeIu1gSHpQnyCJg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2a4dee-1f92-48db-733a-08d7e234742c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 18:32:01.0694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+vTYyjNNR8bqJ69Q46oljW6sNs/fK27EJVNYRbVY7RGCKWYMG7biSXjBlE/wAMAhYnSUXExJELr8vK/DfPSSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> >  	SET_DEVICE_OP(dev_ops, read_counters);
> >  	SET_DEVICE_OP(dev_ops, reg_dm_mr);
> >  	SET_DEVICE_OP(dev_ops, reg_user_mr);
> > +	SET_DEVICE_OP(dev_ops, reg_user_mr_fd);
> >  	SET_DEVICE_OP(dev_ops, req_ncomp_notif);
> >  	SET_DEVICE_OP(dev_ops, req_notify_cq);
> >  	SET_DEVICE_OP(dev_ops, rereg_user_mr);
> > +	SET_DEVICE_OP(dev_ops, rereg_user_mr_fd);
>=20
> I'm not so found of adding such a specific callback.. It seems better to =
have a generic reg_user_mr that accepts a ib_umem created by the
> core code. Burying the umem_get in the drivers was probably a mistake.

I totally agree. But that would require major changes to the uverbs workflo=
w.

>=20
> >  static int ib_uverbs_dereg_mr(struct uverbs_attr_bundle *attrs)  {
> >  	struct ib_uverbs_dereg_mr cmd;
> > @@ -3916,7 +4081,19 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_=
attr_bundle *attrs)
> >  			ib_uverbs_rereg_mr,
> >  			UAPI_DEF_WRITE_UDATA_IO(struct ib_uverbs_rereg_mr,
> >  						struct ib_uverbs_rereg_mr_resp),
> > -			UAPI_DEF_METHOD_NEEDS_FN(rereg_user_mr))),
> > +			UAPI_DEF_METHOD_NEEDS_FN(rereg_user_mr)),
> > +		DECLARE_UVERBS_WRITE(
> > +			IB_USER_VERBS_CMD_REG_MR_FD,
> > +			ib_uverbs_reg_mr_fd,
> > +			UAPI_DEF_WRITE_UDATA_IO(struct ib_uverbs_reg_mr_fd,
> > +						struct ib_uverbs_reg_mr_resp),
> > +			UAPI_DEF_METHOD_NEEDS_FN(reg_user_mr_fd)),
> > +		DECLARE_UVERBS_WRITE(
> > +			IB_USER_VERBS_CMD_REREG_MR_FD,
> > +			ib_uverbs_rereg_mr_fd,
> > +			UAPI_DEF_WRITE_UDATA_IO(struct ib_uverbs_rereg_mr_fd,
> > +						struct ib_uverbs_rereg_mr_resp),
> > +			UAPI_DEF_METHOD_NEEDS_FN(rereg_user_mr_fd))),
>=20
> New write based methods are not allowed, they have to be done as ioctl me=
thods.
>=20

Will work on that.

> Jason
