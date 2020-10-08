Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47082286D0E
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 05:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgJHDMG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 23:12:06 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:33182 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgJHDMF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 23:12:05 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 23:12:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1085; q=dns/txt; s=iport;
  t=1602126724; x=1603336324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZmVQJlHLkObreD8mQaH1PUg0OW3RYWsnNNCsh7jZDQk=;
  b=WzuQU/2hwLvWgzpOYKM9x8NxWO7V0d884TDxuVIPOX0PxqGZv8yUyTC+
   u8TF7gR0aRm0LoN8ICFmzkixonbLShHlUblOHHI+DsEpy6gamDhh5pVTx
   D+nvOy6I4J2/w0EsTlRrYj1ewR+4pPI8tbfZ7ORCqt2aUEzw1l/aB3SXL
   4=;
IronPort-PHdr: =?us-ascii?q?9a23=3A7Gry1REuloMHIXCEPnxCfZ1GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e401Q+bRYjB4PJJkKzdtKWzEWAD4JPUtncEfdQMUh?=
 =?us-ascii?q?IekswZkkQmB9LNEkz0KvPmLklYVMRPXVNo5Te3ZE5SHsutf1DIqX2/9ngZHR?=
 =?us-ascii?q?CsfQZwL/7+T4jVicn/3uuu+prVNgNPgjf1Yb57IBis6wvLscxDiop5IaF3wR?=
 =?us-ascii?q?zM8XY=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CeCQDXgH5f/4gNJK1ggQmDIVEHgUk?=
 =?us-ascii?q?vLAqHeQONdph7gUKBEQNVCwEBAQ0BAS0CBAEBhEoCggcCJTgTAgMBAQsBAQU?=
 =?us-ascii?q?BAQECAQYEbYVcDIVyAQEBAQMSKAYBATcBCwQCAQgRBAEBHxAyHQgCBAENBQg?=
 =?us-ascii?q?ahVADLgGdeAKBOYhhdIE0gwEBAQWFIxiCEAmBOIJyikEbggCBEUOCTT6EBAQ?=
 =?us-ascii?q?BEgEjg0iCLaZIkRQKgmibCaEtkxqgGwIEAgQFAg4BAQWBayNncHAVgyRQFwI?=
 =?us-ascii?q?NkhCKVnQ3AgYKAQEDCXyLBoE1AYEQAQE?=
X-IronPort-AV: E=Sophos;i="5.77,349,1596499200"; 
   d="scan'208";a="574079399"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Oct 2020 03:04:57 +0000
Received: from XCH-RCD-004.cisco.com (xch-rcd-004.cisco.com [173.37.102.14])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 09834vJp025964
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 8 Oct 2020 03:04:57 GMT
Received: from xhs-aln-001.cisco.com (173.37.135.118) by XCH-RCD-004.cisco.com
 (173.37.102.14) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Oct
 2020 22:04:56 -0500
Received: from xhs-rcd-002.cisco.com (173.37.227.247) by xhs-aln-001.cisco.com
 (173.37.135.118) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Oct
 2020 22:04:57 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-002.cisco.com (173.37.227.247) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 7 Oct 2020 22:04:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgL9YxJ+7f33BXtIg8iYHTzB5RwzmKvUA7cEzaRqk4oItiwUG/bNK6KBe7O58y+M3DjKfk7j3XNWHpLH91JgRY14IPk6C0tg32ReNJ8lb/XDeHJYxqQ8qdj9rJ8MweZH4BN+zTvBgnIaRa/sPM0wyQ/WImRXVLRCFtf1iNdCPcMvt9+qOeoQTiOzv14ujrBd9nxszr/YbWGojX/lDcH7iZOc7U2ibItf5INU20CaeG8n2DU/6CNyPchcavZzLkRpaFJS39f7UmtoivWEeU7BtuyLzlqVjFTUIbv7E7wAufqlhZqIQmLYsaOIPJMZl/+V1sDFBJntbntbODItdVOcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQpXG7B+/WyZSz1yTsenOPF4i3XlA5EwonL/vXs8/6Y=;
 b=e9z/SryO1ptmNkFSFFoMmIOnvlAz/CNnLbo5bxnXrhC/bAvTBm1IzunoKy9VqJfmiZkKkIncf0lAeR/xig0OksPVoX2QC19NF7p021x2gWG8ZDNn5Qmsg4zrU7ksc0AgLPIni4aZWlc4yl7woz1kqW28DSrXADhIOYMznSDX5YAdICM+RCdhQ8T5LnWLs6FXWL4o3NcXQk/LcVv6rldBf6lEEKljlpymVWJQybmtBN2II8fgLqyKTOHnmr2b11jvgjmc6LzsRLSL6X4lRkN/RD6X+eCRl3c8zAXbG/A/yQaC4A4gPm1yQ1en+dMBb5Y30DqWlpPfx6sYzNflGOiSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQpXG7B+/WyZSz1yTsenOPF4i3XlA5EwonL/vXs8/6Y=;
 b=O4sDeLipq1D7v6P/Cz+T7uKEHq1m4riIsi06Dh0FgzGcC9+7BA1Q0nO8F1O7KDst1aBS7Ywl7B47ZC/G2POrmxBDdMtXaWDZNLTL9bo4Lb3tFK1r0+gZ+xroIUHUJnYnO/71bWXbWNXFrkA8Q0rDGbWQOhUB+DnYU22H/OycRzw=
Received: from BYAPR11MB3799.namprd11.prod.outlook.com (2603:10b6:a03:fb::19)
 by BYAPR11MB3286.namprd11.prod.outlook.com (2603:10b6:a03:79::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 8 Oct
 2020 03:04:55 +0000
Received: from BYAPR11MB3799.namprd11.prod.outlook.com
 ([fe80::84c3:7525:84dc:f171]) by BYAPR11MB3799.namprd11.prod.outlook.com
 ([fe80::84c3:7525:84dc:f171%5]) with mapi id 15.20.3433.045; Thu, 8 Oct 2020
 03:04:55 +0000
From:   "Christian Benvenuti (benve)" <benve@cisco.com>
To:     Joe Perches <joe@perches.com>,
        "Nelson Escobar (neescoba)" <neescoba@cisco.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [likely PATCH] MAINTAINERS: CISCO VIC LOW LATENCY NIC DRIVER
Thread-Topic: [likely PATCH] MAINTAINERS: CISCO VIC LOW LATENCY NIC DRIVER
Thread-Index: AQHWnR1Sa2wfz/5NnUq8A94kd8Uk16mNBF1Q
Date:   Thu, 8 Oct 2020 03:04:55 +0000
Message-ID: <BYAPR11MB379968BDB90A822F4E61E6B7BA0B0@BYAPR11MB3799.namprd11.prod.outlook.com>
References: <f7726a1873f14972f137f64a4d6cd35e530c6c95.camel@perches.com>
In-Reply-To: <f7726a1873f14972f137f64a4d6cd35e530c6c95.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [71.198.141.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e3e847b-47ec-4bdb-3b73-08d86b36ef3b
x-ms-traffictypediagnostic: BYAPR11MB3286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3286CA75E0A30EF052A0F16EBA0B0@BYAPR11MB3286.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tm9eRK2XFcpTLIA2UO/Atq1IKikys02XNbTVCHBsgkmGZI60e3yzhsPa5NVTwW9c+/VApdSaDaUQo1f3bI5fg1/7x+yP3Lel7ShRwD7ZKQNyQj7JCmZQpR8g3KTn4fDvb659iNmBdac6rqxXDtU0CBUhjOw3aV5u1HdiLbwigSNSqmQMmRv1hPg2qaBAz1czlOnxQBR11i5XJTOug7DDBCi3NgqJAZlFa+AHH0uyefOXRMbuS8tVIaNQ7oKxQ57ORQq573UBpgiU653/4y5ck3bCYmFKnP16XWi5qZOxA/yv1BhzXxXzbgnvYK2jNbGHF42mTk2GaUMU7cGKen9IEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3799.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39860400002)(376002)(136003)(316002)(9686003)(4326008)(2906002)(55016002)(53546011)(83380400001)(478600001)(186003)(26005)(86362001)(110136005)(71200400001)(54906003)(66446008)(64756008)(7696005)(6636002)(5660300002)(66556008)(76116006)(52536014)(8676002)(8936002)(4744005)(66476007)(66946007)(6506007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Bg4JeZ0NEsfBP+QbtTHgS0riJhg/iNmnpgX+yVynW0e0gxk87T7IDT3N4uLPsa5rlzyDBcX9kuuBRKhPKagitNqb4zrGA7a7CXjEN9vxfsXhpsWTnwWWQjanCeZWwGUShoZUNvq712393YNLzusOC5j0vMTKBzTkDY1hSGGIqCoSwhShayrnMxAbAwsP4f8e2nK4RT6I6MgpZkNWU5U9hxBFKiwO7nzK0MMf5wc2RqRxgV/LJbsLvLmhirSLFt3IeVl/9i2clLz6JxZgGmzR75Pl45LwBjNj4jaGkX6lpqSon4o8SIS4GS9RyWuGH+/sQjZJHxb9mHQMkPXF4wRUo/6fWFtHxjAKnPwienQ5EFQLl1wKmMl8VQKGFOeSP8dccnCmhPx92tssxf1xMqECuVv6ez2ToQkrduuASr44ymM/dFDBCBRZgk/J0Jw5vSHyrI+9EBtoKSKVzOQT2V60ZqGBIwzXKui7CVl8XTG85PoPkUAyo5p+Qcii14vrOpr7sdaR6GA78o3WWbT5dskQnXjKxlqJ0/k1SFqKpbJ0M6RntqRhBGTICDgdZ1DXFFwiEkO0AH7ENA57B65V082kOJvlkRvdA1g4+XEBFMqBOYt3Iwz/leeTD7nZEN2Jxtpty979oxZF2OoqqoqWmxIXng==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3799.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3e847b-47ec-4bdb-3b73-08d86b36ef3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 03:04:55.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHZB7oiUNAId0f7Yl/F3JhrDDZXIXq3cDfphzcFq/VSnHarVLS3X7OPOxB08sQg1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3286
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.14, xch-rcd-004.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Joe Perches <joe@perches.com>
> Sent: Wednesday, October 7, 2020 7:47 PM
> To: Christian Benvenuti (benve) <benve@cisco.com>; Nelson Escobar
> (neescoba) <neescoba@cisco.com>
> Cc: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> <jgg@ziepe.ca>; linux-rdma@vger.kernel.org; LKML <linux-
> kernel@vger.kernel.org>
> Subject: [likely PATCH] MAINTAINERS: CISCO VIC LOW LATENCY NIC DRIVER
>=20
> Parvi Kaustubhi's email bounces.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks Joe.

Acked-by: Christian Benvenuti <benve@cisco.com>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ecb727f0a8f..3647500be78f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4275,7 +4275,6 @@ F:	drivers/net/ethernet/cisco/enic/
>  CISCO VIC LOW LATENCY NIC DRIVER
>  M:	Christian Benvenuti <benve@cisco.com>
>  M:	Nelson Escobar <neescoba@cisco.com>
> -M:	Parvi Kaustubhi <pkaustub@cisco.com>
>  S:	Supported
>  F:	drivers/infiniband/hw/usnic/
>=20

