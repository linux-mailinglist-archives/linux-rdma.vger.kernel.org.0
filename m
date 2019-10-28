Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A12E7487
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 16:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfJ1PJb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 11:09:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:58260 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbfJ1PJb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 11:09:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 08:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="400832340"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga006.fm.intel.com with ESMTP; 28 Oct 2019 08:09:29 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 28 Oct 2019 08:09:29 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 28 Oct 2019 08:09:29 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 28 Oct 2019 08:09:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nG6O3pEAFaDPKG6ajCjoWIlvfRUE6R+O+UFbS1KwDv1B+Iwvap+4XvR3iebKxazsu8kxIm8Vn0VZcQyczhXWjUS/88wTQCpN1SQcFqcbp4H5DNrcGx4t4KOvFjCTUAc5aK1LbMjEbCU3E00/e1o7GcotwyNR5w+GkqVjO2H16PPtCIz6eK6WEXNs+23gc+zXq42Gi1wCLyJs2G2NMVIdVL2Gk0mj9YudRvbPGWK26pQ4WmrsMjv+Jw/+6pAuyX1+MqLDJSCDUxpS/UF2j91L8PDFHk1u8fiHiPkXuurX5apTaKtUQh8OBPaG/EKc+tQtdlZNbiG74FhHQy51VvaYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEamlow50TMiE+u2JiHt2dxJTkOdcK0WFdjJKhrw4Kk=;
 b=Zcf4XqiEt5xViSFIFyES5/bIPhgeIXwytOrFaa0wYiKQRFgd7vgSmM3STiCI4yRCQHQfT2Xj3GSky3pgQq1UZC8kMbs7uw5SHtILvN+1uZlHsV7ruSRFazRXjUHt+4udi8CFpRaQixRsCtuPOnEx9XlwAwDIkSL6BG6lUsH5RQsrbGYv6cyRtGNJ3yWnNFyN53rtSrQIzB8thqZGtAOSOE4DkSStfpRd0GChsZPPIHIFPHsFi7u9/OPzkHfYy/qX0/al3I78IeFtqECLLdnK7sHHUQtEsVCJk8P2n81mSiXfPwVBPlXcui7r38JqsW0JyNbLQBQk1tqrjF/Q50/kIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEamlow50TMiE+u2JiHt2dxJTkOdcK0WFdjJKhrw4Kk=;
 b=mgHzmutZnE0lmMq/LVk5PRp7PqQSzTr3lOIkdfh+BEOz2Unjs5RxtcZUglS74Frij+WGRyzTQXkGu0mWEaRfDKMLV/d9ua6xggaZ6OcQ1Xt1TWL4qlb0gYIzvbQeP0H+LPNqaLASFGwagSgIjODZio5Kf06QVobUNeCXiEPms98=
Received: from BYAPR11MB3157.namprd11.prod.outlook.com (20.177.126.222) by
 BYAPR11MB3736.namprd11.prod.outlook.com (20.178.237.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 15:09:27 +0000
Received: from BYAPR11MB3157.namprd11.prod.outlook.com
 ([fe80::41e8:3647:1c4f:1291]) by BYAPR11MB3157.namprd11.prod.outlook.com
 ([fe80::41e8:3647:1c4f:1291%5]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 15:09:27 +0000
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/ucma: Protect kernel from QPN larger than
 declared in IBTA
Thread-Topic: [PATCH rdma-next] RDMA/ucma: Protect kernel from QPN larger than
 declared in IBTA
Thread-Index: AQHVjZXvIDvehfkGF0eZEN2pZQxAEqdwKAxQ
Date:   Mon, 28 Oct 2019 15:09:26 +0000
Message-ID: <BYAPR11MB315708DABE251D7BDE8BB49F9E660@BYAPR11MB3157.namprd11.prod.outlook.com>
References: <20191028134444.25537-1-leon@kernel.org>
In-Reply-To: <20191028134444.25537-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDdjMzBjZGYtYWMxYS00NWQ1LWJkODctZTA2YzBjMmQ4ZjQwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNHdlcDErWTFUR0VFRWpUXC90TzVvXC9NMHdwd1QzWngyUXhoNnlRSTVEQVc4YmFvSE5yeWc4TXYzVmRhQVFhQitiIn0=
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sean.hefty@intel.com; 
x-originating-ip: [73.67.182.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c70239ba-e98b-420d-60e4-08d75bb8d320
x-ms-traffictypediagnostic: BYAPR11MB3736:
x-microsoft-antispam-prvs: <BYAPR11MB37369D3479C3AC193461385D9E660@BYAPR11MB3736.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39850400004)(396003)(376002)(199004)(189003)(54906003)(66946007)(6116002)(3846002)(25786009)(86362001)(256004)(14444005)(7696005)(52536014)(76116006)(9686003)(486006)(8676002)(8936002)(66446008)(26005)(64756008)(55016002)(446003)(476003)(2906002)(66066001)(66556008)(110136005)(478600001)(99286004)(66476007)(71200400001)(71190400001)(4326008)(14454004)(74316002)(102836004)(11346002)(5660300002)(33656002)(76176011)(6506007)(6246003)(186003)(81166006)(81156014)(4744005)(7736002)(229853002)(305945005)(316002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB3736;H:BYAPR11MB3157.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2DoFdbacqh45RX/ndljVb8ufIZqgYCFHc/+mbSu7PgfLJBVhlTMKX7t0DLRci+EmkrtuSz6g+5t9g6p+WpqLrF5JtEM9fRa3D63pP6e0dCJJZ2ypKM9rBPEDup7ll0o/7ufQ1dR3ZxbeOV8m5PI/D7h55JL3STWquhKdM4gbO/8R3tgh/obfyGFQNrLdNWUBzOs6HqFZC/kRz8TtdsEX1Cs2nOnjDehURaj+Y6YDuf7dshUgmE3xMs9PiqT4LDlcZLJpokc/z+VUCA0+nFsatcq2X2whFisiJvW1DupgCZeZQn4KtrR0gwqMw+8DY+t2YnzxvG+5RkTMRKzFUbMtGIJkKZJvzIAd59NyybVOqIrG4c5G/JBvUlQX+c21sVwvR7AxMUu2LI7DLXTdNwv4cvM3OL3IWsUeg+4jPoeAB4bOnQ6UqE7x+0jWOXUuGR8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c70239ba-e98b-420d-60e4-08d75bb8d320
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 15:09:26.7480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RgaxiJ9sCIrS66KO+3Rg/1UqVkU+xPY2EyzL9bE6VCf7Y+dnCOxacyOJX649kLBDtORPOjAaJKD37JHRuKFOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3736
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> IBTA declares QPN as 24bits, mask input to ensure that kernel
> doesn't get higher bits.
>=20
> Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  * Not fully tested yet, passed sanity tests for now.
> ---
>  drivers/infiniband/core/ucma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucm=
a.c
> index 0274e9b704be..57e68491a2fd 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1045,7 +1045,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id =
*id,
>  	dst->retry_count =3D src->retry_count;
>  	dst->rnr_retry_count =3D src->rnr_retry_count;
>  	dst->srq =3D src->srq;
> -	dst->qp_num =3D src->qp_num;
> +	dst->qp_num =3D src->qp_num & 0xFFFFFF;

Why not isolate IBTA restrictions in the ib_cm?
