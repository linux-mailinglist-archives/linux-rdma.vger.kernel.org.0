Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43DE1E6002
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 14:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbgE1MG1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 08:06:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:38933 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388542AbgE1MGD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 May 2020 08:06:03 -0400
IronPort-SDR: TimAcTaAbz9xASzqzG035Xkk4ID7D0A6dHEgzf1R2GsADv7ksdvq2inETPoRxazgKzBQhBgCH0
 UT1H90HdosQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 05:06:02 -0700
IronPort-SDR: u84QpQ5IqhYypu7SUxlUsG6vo+VFTGP0sKs3nGhLi3A+qwIBXcUKU1s9f+mwe61bf/k4p+L/YD
 c6NltBp8W5eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="256141133"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2020 05:06:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 05:06:01 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 May 2020 05:06:01 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 28 May 2020 05:06:01 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 28 May 2020 05:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHieITKUgowE4XP5bs4avfXIfruqcO3Yqt3czEOavBqe1bpUY+SRsLhpEEG021ctz/YhCM83Y00D9OuG2Yrb/NDXst4tdVJDr9IyERpnO35EcbsyWSYPMKr9udkXxbjsfI096oJk82Wdb0Ofww5PAyOlLQTM0kqXsn0D2iZkU4jdSJgLypdvHbN1PRAhfY7UzvVodtnFETQv4PG0DZAVk5fP5NGgXLA8my0CQ2Ibwjru3Hxq/BPlJCjPaaOf/50gDd0eM9IwN3QqSNKvflXc9nvkqLseVir/ysLOJCkEX+GyrxLQrgSyHPDNk1d9wuBHE9Z/w+SpHK2KifQTnC1BOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ/t16MUYLrCuxaW1ZiDPT8DLOXec7dyPZflyTg2yVM=;
 b=c1KjuyT0BMQ2YWA58hZLNpuycMBHRbm5CuwK3GHR9+ow55/gtCW3R0uJ6Tmyudas+iaM7qhZR5RvNHP5at+okfjYgvU6+S8tJo3miTCtHk7Kl+dIbeNB1tH9HUNTzDNa7S4OoYacQOCEqRRkQhOyYrM7wAuCAiwV+miSALd3gzBuODDZIA58JmQDQVfJmqAnJ4hfSy0R43LoF6unjeXYddduJHOeTXY4E7fFydEOoKvS2Loyb5GWgutylhImW1OF/yw2+6XRvQCV2GXQduv4T4GG/YTqY/DLArVQ6j5Fa/efp91Sfok2Zr8QtcKS3btMCs3UDRwguwzKTYIeluNeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ/t16MUYLrCuxaW1ZiDPT8DLOXec7dyPZflyTg2yVM=;
 b=XKDi086kDjsgVwHGLd7Z2OV+B63S3SycewjB+omsfl0xO0FMKnCpQxUolFSTfyBksYGJPFbY64VClAsUKGEzDU9b2YfVgNj4m8FJrBCGnkRT06XeFoEdlkT5e28i2JfCWK1x9FrYGBKIJOpMR7w8baJlNIp9jWe72oIgxy1WjIQ=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 12:05:58 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::4dbf:49cb:dc7a:5b3d]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::4dbf:49cb:dc7a:5b3d%8]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 12:05:57 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     "wu000273@umn.edu" <wu000273@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>
CC:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/qib: Fix several reference count leak
 qib_create_port_files
Thread-Topic: [PATCH] RDMA/qib: Fix several reference count leak
 qib_create_port_files
Thread-Index: AQHWNJl7SA8NUO5mFkqEEZv/I2OK46i9ZzrQ
Date:   Thu, 28 May 2020 12:05:57 +0000
Message-ID: <MW3PR11MB4665C9149B684B4B9F00AFF5F48E0@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <20200528024037.6611-1-wu000273@umn.edu>
In-Reply-To: <20200528024037.6611-1-wu000273@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: umn.edu; dkim=none (message not signed)
 header.d=none;umn.edu; dmarc=none action=none header.from=intel.com;
x-originating-ip: [72.94.197.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a748bc5-1776-4f5b-c5e5-08d802ff7b2a
x-ms-traffictypediagnostic: MW3PR11MB4603:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB460353587BBD0001DCE88F14F48E0@MW3PR11MB4603.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:171;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qw5vxWPMJogo7kiFbGZxbD6oc8mBIGRJ6FaTmDeZ18DIzBYULjCvrab6ybw+SeYVPsB8BBxTBLicr3P/58qko/gJhSjo9vhCrjDtfelmvjyhomxaxETTZBQH+RvA9sH9PUB6oV5OWOIibNsX3WymP3b9HnwM63WNUNMacwczKn9J779j84DzwT/9YNQKwyb63Ayx06YfGXNmIjd4EVLTrcedwF7n5GlLVqLwylYjEulTLjIWXzar0skQ9POpRnZa15Zw9gZ/hkggETdL8gJ6cJ0yi1ArJ2BeNWPpCKthWNKMO5Xv/bcX4Z5fBXHmviOz4q1Xzz1VU7SvdbF4nGqGkmZ+CTduv8wDIEBBS2Tfsc9UEAY9ApFReS+nSg+Sz8zsMHon7xNarlYl6FaGdEvgjg4h62jprNtenkKOyz9NbWe9EkJPDNaYEY9Obh+S1QT6W+wmSZ/71s67Tzw4LdNVGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(9686003)(26005)(76116006)(66556008)(64756008)(7696005)(66476007)(66446008)(66946007)(6506007)(5660300002)(53546011)(71200400001)(52536014)(55016002)(8676002)(33656002)(186003)(86362001)(4326008)(8936002)(2906002)(478600001)(966005)(54906003)(83380400001)(316002)(110136005)(6606295002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MxNX0IAlYe2YGQy2onhtKNqXoNyDkVeNtmed7JtJXEisHYekWtxT6IMzxagfivy1KOpWy3o9Xr2LNjL9BpnJf40gKwddJYvnp3ma+SeGPu1F4hmIku+vENoje8KwE8IsYaFH3HtfClHzzBjHhrIgTIAPTZj/CLZB4DWSy5g/ZhoQK2l1+ERWTpWEt0T5zsthNNpLkTEQ/GDhxTRDf2uRX5VM/d36hxXiXrVy8m12tGA2ExAW4tORGxuczfqZtRjp+p80reBBpDY7ydFmS04x+O3Gr9AZwdAXfE5WxJdB558AlrkaPlvgcpjehhaWAnx4yR49Kuay3sU5o/TBSTAQU171FPLYJil+hkR880PiQkWAHayQWYK4V29mili7Rh/lLgdYJjQpwIhmHW9n9p4p1hMjqlQl4JYR5F6aD4D4ziOpN1X4UslN7PJW4H2tDSR33yJiyFVvejLrIuPAcpZGV9XDDznjkgdmRcM9dWtSiFg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a748bc5-1776-4f5b-c5e5-08d802ff7b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 12:05:57.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2EduTT2hD8ngHOH85Gm9rpg9ZxmZbGDcVtRPl5OjM4orvxyN4wiL4yTg5VntaYW25/Swkrpf/dVHiJA6ZI4d7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of wu000273@umn.edu
> Sent: Wednesday, May 27, 2020 10:41 PM
> To: kjlu@umn.edu
> Cc: wu000273@umn.edu; Dalessandro, Dennis
> <dennis.dalessandro@intel.com>; Marciniszyn, Mike
> <mike.marciniszyn@intel.com>; Doug Ledford <dledford@redhat.com>;
> Jason Gunthorpe <jgg@ziepe.ca>; linux-rdma@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] RDMA/qib: Fix several reference count leak
> qib_create_port_files
>=20
> From: Qiushi Wu <wu000273@umn.edu>
>=20
> kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to proper=
ly
> clean up the memory associated with the object. To fix these issues, we
> correct the jump targets when the calls of
> kobject_init_and_add() fail, to make sure they can be handled by
> kobject_put(). Previous commit "b8eb718348b8" fixed a similar problem.
>=20
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/infiniband/hw/qib/qib_sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c
> b/drivers/infiniband/hw/qib/qib_sysfs.c
> index 568b21eb6ea1..017ed82070f9 100644
> --- a/drivers/infiniband/hw/qib/qib_sysfs.c
> +++ b/drivers/infiniband/hw/qib/qib_sysfs.c
> @@ -760,7 +760,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8
> port_num,
>  		qib_dev_err(dd,
>  			"Skipping linkcontrol sysfs info, (err %d) port %u\n",
>  			ret, port_num);
> -		goto bail;
> +		goto bail_link;
>  	}
>  	kobject_uevent(&ppd->pport_kobj, KOBJ_ADD);
>=20
> @@ -770,7 +770,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8
> port_num,
>  		qib_dev_err(dd,
>  			"Skipping sl2vl sysfs info, (err %d) port %u\n",
>  			ret, port_num);
> -		goto bail_link;
> +		goto bail_sl;
>  	}
>  	kobject_uevent(&ppd->sl2vl_kobj, KOBJ_ADD);
>=20
> @@ -780,7 +780,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8
> port_num,
>  		qib_dev_err(dd,
>  			"Skipping diag_counters sysfs info, (err %d)
> port %u\n",
>  			ret, port_num);
> -		goto bail_sl;
> +		goto bail_diagc;
>  	}
>  	kobject_uevent(&ppd->diagc_kobj, KOBJ_ADD);
>=20
> @@ -793,7 +793,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8
> port_num,
>  		qib_dev_err(dd,
>  		 "Skipping Congestion Control sysfs info, (err %d) port %u\n",
>  		 ret, port_num);
> -		goto bail_diagc;
> +		goto bail_cc;
>  	}
>=20
>  	kobject_uevent(&ppd->pport_cc_kobj, KOBJ_ADD);
> --
> 2.17.1
Already fixed:

https://marc.info/?l=3Dlinux-rdma&m=3D158925321102485&w=3D2

Kaike
