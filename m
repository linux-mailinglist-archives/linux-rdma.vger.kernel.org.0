Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D854E1E7ED9
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 15:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgE2Neo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 09:34:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:59265 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgE2Nen (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 May 2020 09:34:43 -0400
IronPort-SDR: vcDZTYIGcvYaYu08piN6SfhGb6b9GCPIx3dch9obX5zIVMF4LTX+krZO3PgCS8TSr6b8dbG8ip
 O4CTBQlOm8wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 06:34:42 -0700
IronPort-SDR: Z6Hbs3H2YsnEPwDEjLEuqNWfNkrmnyWLTl58a0QkOYsuFQ5CvejQsycf9ABbyFQfq32JjiD6wM
 ocTsh2MMCHoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="271216833"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga006.jf.intel.com with ESMTP; 29 May 2020 06:34:42 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 29 May 2020 06:34:42 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX122.amr.corp.intel.com (10.22.225.227) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 29 May 2020 06:34:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 29 May 2020 06:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAWSVQyAx7Pdsz7oUFrfs04ilbsCjam6DvxkmMC6jrh6kt2ZNHahK9ESj2/ssWekhR/ZLMH0+QXcq0ZzU1iUde8jdAFRE7AO0TKDjZh/W3y+7Qe+v86wl4lrbvawf8JXgrV4asHWTB+5cPx66/6+OqPxalyangNw66eHnuGxoEA6GZ+Jtmmep5CpvAmgk3WqNKTlY1RxQfQR9x6R/0dVP54L1zkH8L9wtprz0wNxPVGXpxNSNTmazeKiYF4bYC5qbTiAzSeW9aDZYQ3MdPztvf9v0TclzUfDa5Jn5poxCM7/VtbhsRfRNmswkUhxueumFortlafEqv6zDJFIKvDjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw/frJ3dpTzq20kTp5YJXclz7XUIeqE6EYoRC5xztH4=;
 b=lM1mUk4xk50B9lpPfypMpNC71Wf8beZEozE6T/XS2VG9xmKyoh9ZsEc+o1ubhusONAdcd/MSXekGTzYYpd4PqsNnaUOD4L/2OLoPc4brdQXZLJ2TRtfd/IUw/DWIESnh+0iok/bNQSTP02r3dTRHbXeKLOfEFraYcdHk6zpiOfXh77uXeb9nQEKoy77ALwJgrDiDwOldGC4teI3eEY7vYMNW3iZcAkHt29Tgjsgauov8IEdMzPEDfT2vrgcTvkZgV1k9Yp+6oH5zGsZkAofPqLT7OMY17pS8PjwlntODZUoaOSytpY23QVrdX1YVzjEzF2tPaeMR1u4ddhhWMwn42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw/frJ3dpTzq20kTp5YJXclz7XUIeqE6EYoRC5xztH4=;
 b=CuWCSVvdrrzQeADku0A+ZvhBDsw02g4CJk7/J00ixqTmQRLJooFKqDNLUlgWJ2RGaQVPJhicCwrwiLCvdRkH5okbz812FyCzdLJUYpzSPdInXvdzYuL+do2hKtKKVcxnd3yJygyEWcZ5tJTwgBk0soV3gXDZrPAN+DPnv6vHZWM=
Received: from BY5PR11MB3958.namprd11.prod.outlook.com (2603:10b6:a03:18e::19)
 by BY5PR11MB4008.namprd11.prod.outlook.com (2603:10b6:a03:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 13:34:06 +0000
Received: from BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::3989:158:8990:7125]) by BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::3989:158:8990:7125%6]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 13:34:06 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Andrejczuk, Grzegorz" <grzegorz.andrejczuk@intel.com>
CC:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Vishwanathapura, Niranjana" <niranjana.vishwanathapura@intel.com>,
        "Kacprowski, Andrzej" <Andrzej.Kacprowski@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] IB/hfi1: Fix an error code in hfi1_vnic_init()
Thread-Topic: [PATCH] IB/hfi1: Fix an error code in hfi1_vnic_init()
Thread-Index: AQHWNaC6wvf9hJ7CpE+SvKSLWbzsSqi/D6IA
Date:   Fri, 29 May 2020 13:34:06 +0000
Message-ID: <BY5PR11MB3958CF61BB1F59A6F6B5234D868F0@BY5PR11MB3958.namprd11.prod.outlook.com>
References: <20200529100302.GC1304852@mwanda>
In-Reply-To: <20200529100302.GC1304852@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17ff7123-6ca8-4f5f-c48e-08d803d4f5e4
x-ms-traffictypediagnostic: BY5PR11MB4008:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4008BF34238406AF9F649A90868F0@BY5PR11MB4008.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FsGdE0U1L9u60YIHY+OVQs/mZmWrD1oLsZvXqicMz4r3qpXp6Z+8M/3xuk27QbI9Z1j0P1cYyF03+RnCI3v10DK6o1cGQqhqPzMnjglTlRjpVBckvG666UWgIRttXQ0vXH8iSKwCJAhUvHz/85ojKPHwlrmYzYz9BxsGLRR2TDskhyVYqzaeYnpBWOqKklcVEr6eeaCca6C1MVQWOk8/SI3NvlnFx6UJdnjpzGZ6EsRBBcT+x4fPpyz9UYPOvJ4t3JT5ZOqv5JRZnY+hZZlyA0PYWHFaeu5Sg15DsDtUbYmpdhH9Bb+8lBYmMkbg2G0z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(66556008)(6506007)(66476007)(71200400001)(66946007)(7696005)(55016002)(76116006)(8676002)(4326008)(186003)(8936002)(5660300002)(52536014)(26005)(4744005)(110136005)(86362001)(64756008)(2906002)(66446008)(478600001)(316002)(54906003)(33656002)(9686003)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3OBwvPaKw+4oPpvIx0/9b3IdSek4FBSkm6dG/mivI+dbpQ5+1PTunY4fRBqqiCZ8UORrGzyp4rmKV9tZiQRmlh2bmBKjlJDIAQg+xVzdi7ThhhUSeUXaqB6bYkkwB9oJze0aKkn+oA6lDPy4G2CDQ4Ogk19g/tBEWwvlrTStH6EKRNeEsl3AbhAMUXYyNSHzTIfxndABmAvM4lDd8SibHcMeb1TT4APUKY0JNDybhC35Lcn54LMV/mAv0Flm1rk3gYCEdJZdLbTdZG1C+41/2oEf2lhL7bSqIDvOypBLS4bN9nnXZI51bppejh4O6H2Olr2GBbG2vvC50AJTDu664NfUMGr7WHaSLudXDbRg2gk/3PM7EnMpOAqTu34hh+xd06Kmu1ZmayBdleRG1uQf6sAMM4x9LLVv0qWlLPWbwbdQyy5+dWfZBrecf52Lde5MjpVrmjuflzkemSBisYfTHH2lkN4aOphcFWTilpyqFi537TsloBgsc2gxz9stZiX0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ff7123-6ca8-4f5f-c48e-08d803d4f5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 13:34:06.4296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pe0nNjptBN1pyXkBrvA7CsIgEtz4eFSqynaKTe1sx6izzs14/KxHVIWLWWjJywV/vs1U8nVEN4Um0iDdejayKKKkKvfCeIJLPWDTdtUebIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4008
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Dan Carpenter <dan.carpenter@oracle.com>
> diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c
> b/drivers/infiniband/hw/hfi1/vnic_main.c
> index b183c56b7b6a4..f89d0cb1c7204 100644
> --- a/drivers/infiniband/hw/hfi1/vnic_main.c
> +++ b/drivers/infiniband/hw/hfi1/vnic_main.c
> @@ -512,7 +512,8 @@ static int hfi1_vnic_init(struct hfi1_vnic_vport_info
> *vinfo)
>  			goto txreq_fail;
>  	}
>=20
> -	if (hfi1_netdev_rx_init(dd)) {
> +	rc =3D hfi1_netdev_rx_init(dd);
> +	if (rc) {
>  		dd_dev_err(dd, "Unable to initialize netdev contexts\n");
>  		goto alloc_fail;
>  	}

Dan,

This is definitely wrong, but another call to  hfi1_netdev_rx_init() exists=
 in hfi1_vnic_up()  that needs to be fixed.

Can you address that too?

Mike
