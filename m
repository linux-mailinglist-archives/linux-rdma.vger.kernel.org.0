Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8021E5E2F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 13:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbgE1LZh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 07:25:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:14151 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388198AbgE1LZg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 May 2020 07:25:36 -0400
IronPort-SDR: 0qeoA6ibhUb7w7PfICrwoblmgoilirjWfIh6dqE8AZYNspPpqeCdet7MHY/1gIKj1GSx37t8yR
 AIOcHHeD6cDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 04:25:33 -0700
IronPort-SDR: lOTOZAVizNth27/WtTY6i5sJgns0n3S9iRNS8braDnkYdKbMMOvrAZT71rxwvDn7GcmZAV6nTx
 WfcqcMDg0WeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="345876460"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga001.jf.intel.com with ESMTP; 28 May 2020 04:25:32 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 04:25:32 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 04:25:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 04:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN9hRgLpuXpTDb5C6q8njJsToYKdKtYyl/nFzks9M6S9Oo8ZGzXnvnm5uXp3UM0H+WONR+uvZKr35dRSVw/l3xSna0oCnNdtN5jNgZjT+uD0F0+1IEeZZOVm+K7ySHxbISxbCOeh8vbgaxidm/tsSeXJWrJKwAJKIyJ5KH0jCuAMbsHD4yknPHpkjY/y1XYrgNkCeIXvEYQc+ZRUo/6I2lyD1J7agQwYyZdC9aC+xaONLVCm7aijk6I5s2GxRA9qbiC61X7oYKYjn+BMkazE8NoACJfTbtd8vopvCfjGHfYljjUZarfVftb6xyXVdIykNMJ4xtulJlQ9gZ9xlg1gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWCfRjL2YaxvUDfFswqMeeOpD6O15VBZx3ykkSTC2LQ=;
 b=lLhgiq8nYkGx+9bR/uBEiDRPfTpiM8eWUmfzMx9pYwKco7ZImoZ5q2SOihU7TbnjLLvld5ZEZwAkHHQ8h7bIzMxPEyjnG1wNmxL/up01dafwmlSUGZNmFD25m7g4gkQkNBjsSVjgKg6uron/B8h1EuXBWQ2NLOMIrX6NbpjiMHpZeht0WUCS2R0yCdZadGTHL4IuVB415FLRvYRtOdh7kpItW8zi/qMK1EgA9B/CL/t/ZWq0jfgLEf8oh1TPFT0mRLxewSW6LFFu3OF7QEPJ9AWz7lopoAZ5/ZfjZKDz+cjCdg3Qe6PJ2OYAGknfkpBgjwGrQZ80BUnrsZ+3/wL3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWCfRjL2YaxvUDfFswqMeeOpD6O15VBZx3ykkSTC2LQ=;
 b=iDZgC2loDVkxyrAM1tPPxi7bb9ZeLc9Kh7oA+nIIcGvsgW+Ug6MU1NIdXQYqiSQmatQZb7NyP70DxxnussxqngCP2kQnXwALf1rTwX3hZHWIzlw8WfhKh2Lz+iNp0by+LJgpIOG+7SjslD7m4llVy5Int/jttaFYm/AvMZrz+Oo=
Received: from MN2PR11MB3966.namprd11.prod.outlook.com (2603:10b6:208:13f::29)
 by MN2PR11MB4694.namprd11.prod.outlook.com (2603:10b6:208:266::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 11:25:28 +0000
Received: from MN2PR11MB3966.namprd11.prod.outlook.com
 ([fe80::78c9:f01:f72a:49be]) by MN2PR11MB3966.namprd11.prod.outlook.com
 ([fe80::78c9:f01:f72a:49be%3]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 11:25:28 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Dan Carpenter (dan.carpenter@oracle.com)" <dan.carpenter@oracle.com>
Subject: RE: [PATCH -next] IB/hfi1: Remove set but not used variable 'priv'
Thread-Topic: [PATCH -next] IB/hfi1: Remove set but not used variable 'priv'
Thread-Index: AQHWNMWJ57Z9dRfTGkyb/GYsnUmJpai9WFSg
Date:   Thu, 28 May 2020 11:25:28 +0000
Message-ID: <MN2PR11MB396654BC46500F828609C6A3868E0@MN2PR11MB3966.namprd11.prod.outlook.com>
References: <20200528075946.123480-1-yuehaibing@huawei.com>
In-Reply-To: <20200528075946.123480-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 001c96c4-7a98-48bf-bc91-08d802f9d35b
x-ms-traffictypediagnostic: MN2PR11MB4694:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB469444DED721504E7626B16B868E0@MN2PR11MB4694.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:187;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBZG+Ui3TEBoyG3p9CsM1JfCDHRYcpHfneUv9yDmLHAVJvtUdjptv6Y6bzKFGe1SOKPbUFJ/WHrYxZXaHS04AgUgt3E5yt3b78Wx4tJ72PDLi6FSHFpS+uY/UBY7Cg0ggwQf9PMfsejkHUWGISu/B2Z8ZLSahRDKeUmWJAVOxvyY2MER5pTgrw5UJdff1PvoMlTuOzkWsLR6DIvGN768rNifx6J9wiYDrThLf0IF50OppYuW9Woj9/HURslMrdmw29nK/op0LxX9U8BLPIWFbqkPnCzsUcHG1gwfSneWlE0toFrrvzDc+XWZs4QlN0vR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(346002)(39860400002)(366004)(52536014)(66446008)(66946007)(478600001)(66476007)(64756008)(66556008)(76116006)(6506007)(8936002)(2906002)(8676002)(316002)(7696005)(9686003)(86362001)(186003)(26005)(4326008)(55016002)(110136005)(54906003)(5660300002)(33656002)(4744005)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RviR0LBn7cHBK7k5F/f3QS+DLWiO91DZhxz+cwQQD6huzf3ZVdd5udgMc2xWiXJzo3udYNzew+leRi8J5JNrp+tYkRwoM0mMfzekrGtcC0bn+l30ww3ttVwHk7DTK6/QXqyIpMokSMsQnZPTit3JUmdisVWpCGzOI5Y0tp2qtk5Pr9BCQXVj6W5M9V5tJyWlN+eWSr0r+XTSJBxErdOyo+wPw0BtEOmghnRkXYSIViogh+F96tlJX+jeYnoNUHKl2b581dBPIUFj9CIn9k5RHDT0cVjUiePnTPizpTPEbBQwP1iJhZ33QV/E1v6QUM0eseqdVtY161KN+4dqN1B0aOwniQfAwhXkwpPduZcPeptbydK6dp/36evmQids/gkooJuVNghdtRSEaZTFmH8S/mgzL3UXwaIWrtUXqNjYKFft9ZXEocuKpn2XD98HItEKLX+8ZOj7BFywRUBe5AE057O7QuASsy7lW8jaZirGk5qXwPOFL/ZlvKBu07W7S2yw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 001c96c4-7a98-48bf-bc91-08d802f9d35b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 11:25:28.7692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWRA3RzecZeoJggssXJoVW3MvfhaIptuoElxOBK1hQc7KycqWAQORxZpx/iBmi45ehpv6eri7f0DEm75jZXvBcbUnQy6rghrJ5Qg1tOZ9R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4694
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Thursday, May 28, 2020 4:00 AM
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/netdev_rx.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c
> b/drivers/infiniband/hw/hfi1/netdev_rx.c
> index 58af6a454761..bd6546b52159 100644
> --- a/drivers/infiniband/hw/hfi1/netdev_rx.c
> +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
> @@ -371,14 +371,9 @@ int hfi1_netdev_alloc(struct hfi1_devdata *dd)
>=20
>  void hfi1_netdev_free(struct hfi1_devdata *dd)
>  {
> -	struct hfi1_netdev_priv *priv;
> -
> -	if (dd->dummy_netdev) {
> -		priv =3D hfi1_netdev_priv(dd->dummy_netdev);
> -		dd_dev_info(dd, "hfi1 netdev freed\n");
> -		kfree(dd->dummy_netdev);
> -		dd->dummy_netdev =3D NULL;
> -	}
> +	dd_dev_info(dd, "hfi1 netdev freed\n");
> +	kfree(dd->dummy_netdev);

Dan Carpenter has reported kfree() should be free_netdev()...

Mike
