Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C250B1AE18C
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 17:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDQPt4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 11:49:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:35079 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729201AbgDQPt4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 11:49:56 -0400
IronPort-SDR: hJPaF70e/hiag6y4akr0nvG3W3R/FfR2kyRdmcTqvTCYfvjHeCzzsPtfQ+UJaKPHWeV7ELd4E/
 o/9ADFoT8YZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 08:49:55 -0700
IronPort-SDR: SW2YoprecyCMndiAJf/QHWLldoNi4Wk57t3rwU3CXjVdEum7Uc7HUuJXcSBj24n1qRYxOPEYBv
 EdE6KdOeAuXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="257614215"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga006.jf.intel.com with ESMTP; 17 Apr 2020 08:49:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Apr 2020 08:49:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Apr 2020 08:49:54 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 17 Apr 2020 08:49:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Apr 2020 08:49:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhWTpOFdwsFzA6/T0jW0gVagVvsY1m3MtqHg0sfg88w1/TeOKfRfTg5ecnDaJBfS2tPvU8shCH8/ITzvH4s4R0b245d1ag6yToXtYUHc+yJD0nPPEiPGjaFME+OrSDhIftJDYZYQz72XQ4nFQdCoDoRxzymNS5DsV/l8JhascxmRokOvkSHKXk9ESNtkH0F3XTfw9yEvPNOb+lzshytsIwuH9Oqi8tZwsctA4GzhDE14CdR9QMT5gsCdGvg0goglUULuJiGF4FLZGxAaXaAPzvAA8j9ca1yNsQrSHvLesn5WeehPVuVa8YkzB3tvMp+aD8RWRzAqiGqqzstE7GK9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jqIAnBoc7Ld/x+kHHYSYF4+gijAsyvB80tyn8D3Bn8=;
 b=A2qceNPJ3KCNoPi/D4C6xKurL35nD2MQedWqTs3F/cZ1rTYG5HmOvqnD7s2UTJVzUCmbejKBWFzVe/2A0pWGdWK9NdTKxN1JdtqFCaEFjzKzUA8qsiC9vpjLkC/twQUZwaL3COXWXUW7bbdaYF+v6dVMxXfHw7VIH1/0dWSHKrRj7u1okOpxhQefQXtXWEeYSPsUp7HzbQe85m2qExz7NUM6m4rDLG16AjaSUSf+NzPfAX0plcqph7CvCLlu4M7XTtl6DVGeeBHPbBPZ1h6bT1OWQ/b0+E4bXt3SNOc7O5ifJZXSr+ZmvykFelj/EeCUHdDbOV9VNVSm2qH7JIXfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jqIAnBoc7Ld/x+kHHYSYF4+gijAsyvB80tyn8D3Bn8=;
 b=smuZo6AH3LyVjODfQr7krjAZZzVvNJ1I9A6BMIOBYMf/NimOu2AOpNiyUOdYgge8tkFck5DTZ53Lcc+mLg/Dj2Z2KfnF7feaMaJzwhIN4lJfhV/Nlrv3VlvPLsp52fPBaARIU6xaGTOLxv7tDv/6IaS8pwhEhfkhjZB64j7GTcU=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4764.namprd11.prod.outlook.com (2603:10b6:303:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 15:49:53 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36%6]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 15:49:53 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Leon Romanovsky" <leon@kernel.org>
Subject: RE: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWFBA18200UyEIcUiReZoCYrPtRKh8ChWAgAASxpCAASM7AIAANFow
Date:   Fri, 17 Apr 2020 15:49:52 +0000
Message-ID: <MW3PR11MB4555F91FB31060B01343BCB0E5D90@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
 <20200416180151.GU5100@ziepe.ca>
 <MW3PR11MB4555DDC186D6F5EF30771EB0E5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200417123124.GA26002@ziepe.ca>
In-Reply-To: <20200417123124.GA26002@ziepe.ca>
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
x-ms-office365-filtering-correlation-id: 6c8cf675-34f7-4f31-436a-08d7e2e6f83b
x-ms-traffictypediagnostic: MW3PR11MB4764:
x-microsoft-antispam-prvs: <MW3PR11MB47642F49EC0F1B8BAE3F9E8AE5D90@MW3PR11MB4764.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(366004)(396003)(136003)(346002)(39860400002)(5660300002)(7696005)(54906003)(316002)(33656002)(8936002)(81156014)(8676002)(4326008)(478600001)(6506007)(26005)(4744005)(76116006)(55016002)(186003)(64756008)(2906002)(66946007)(66556008)(66446008)(52536014)(71200400001)(86362001)(66476007)(9686003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EfK/ihfDisf2/E6Xz7Q/GnrFhIA9QxJm/eIbth2WH3e5etov9D7gZvNSs8v6TTkg3wRm3+ZzzhRH8lmC0UaAarrwKywMYUBo/rRWHUIW1wBV2b3eGpP5dDff5FJCiiv9FvAJGJhDIfjJ7SrGWEsLTJn8rvr2QPpbhh95ooEhBSeRk3qDTqXZAyIJwKl3Ipid8Rs825FfTDM9+VoQQgc36ChRWO6Sy2xQHqhFNyCCfBB36a7J3Ow3NAbwAm98J1LA0m/ARyPthkSMXlkTufBFpNFnQ/IyqqgxSGtrBDNbJ2y+4dI4twrzvOkLT2PU4CXfdc2iDHTtq5bOAxsyh8gGnI8itK7586K3QVr+cqotgBb8BYSyhQzUtPRN2j1dbl+2DwYhctUWiTGZGuTNo1CX87/RfujnrqjRPU15Mc6KwSRJzn7+RzDx2vJli1rZ8FPp
x-ms-exchange-antispam-messagedata: eY8N5u9aWu8fPxsXDLAf8uLQvGgVwXNspJV1tAPcxILClnKMNwkwZyPJLKO7oiXyG1nt09J/+qacKwfMHKo7HQJqO570tqrhMC4QMGB+y56dSuvQdMTc/CLBnBCZi4KbK/OCSa7f01EiQ+87qLwktg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8cf675-34f7-4f31-436a-08d7e2e6f83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 15:49:52.9899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8s4jzfqxzcWq0pZ3/4zIxyK0JOetRmpThmThHKSwu11YyegiBiVkhlEmFbf5FuNcXrdueQxz58/0RZ+XtKCkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4764
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > > > +}
> > > > +EXPORT_SYMBOL(ib_umem_dmabuf_release);
> > >
> > > Why is this an EXPORT_SYMBOL?
> >
> > It is called from ib_umem_release() which is in a different file.
>=20
> export is only required to call outside the current module, which is is n=
ot.

Will fix it. Thanks.

>=20
> > > > diff --git a/include/rdma/ib_umem_dmabuf.h
> > > > b/include/rdma/ib_umem_dmabuf.h new file mode 100644 index
> > > > 0000000..e82b205
> > > > +++ b/include/rdma/ib_umem_dmabuf.h
> > >
> > > This should not be a public header
> >
> > It's put there to be consistent with similar headers such as "ib_umem_o=
dp.h". Can be changed.
>=20
> ib_umem_odp is needed by drivers, this is not.

In the current series, it's used by the mlx5_ib driver. However, if as you =
suggested the function prototype of ib_umem_dmabuf_get is moved to ib_umem.=
h, this is no longer needed.

>=20
> Jason
