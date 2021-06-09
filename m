Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978623A0F96
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhFIJ2G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 05:28:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50010 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhFIJ2F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 05:28:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1599EIrU031194;
        Wed, 9 Jun 2021 09:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xzs/gOsv2c1uAVXi+rmfxpqK/N0f0aZ1XZ/0JrecBoU=;
 b=etSaUY30+M8uT8ee/zxehIhjlNhdFcnRYEI38d5eEakXfygLH/+mipVGirwsRb74IHsQ
 5d847M/mt4haL3tnYZRQsYxzRYr16Mjytpnu8Bc3jAdtsgtJVFfi7DivIfr+JMMjcEKH
 4v7EQz3LpySyBerVU0fe3WI8C41g77OM4YPumbGWoub5Jeb3poQOx9DkDVVzxoZKYAgh
 P74E/0g+tliO5hqD3tznDumQ7SheSssZBXHTT4tgp6pJfhFqawhY3Zq4IHldAMp9eA0w
 zUf1Z5SAfVpxvwTmGKB07F5MJdIbVu7aKi+Z9NVoK1s6ZwztY9W7WmwPnozjzL0tIreE Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 39017ngjxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 09:26:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1599AP0j143936;
        Wed, 9 Jun 2021 09:26:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3030.oracle.com with ESMTP id 38yxcvgtay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 09:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS7axSQmtcrKo6R0RUcH37eQDMyZXyU/PLzRHSlTkoCdZOJvKGJxFnKGA8+V++ekEM8hkHB1bgSZnsjRkayDCtkoloeb91weNfQ6sfWuZsKlfMonTKFLr3Q4rFUTet6h5Owp+DziBBbueG+KoN4sWEtoWnzKqoSm2DW4a73peMNOgwRaaS9HeEWc0rlhBDGsSK/9x59r0YXy9c+PAsVu6Cr/jWr/WEeNOBIoLRywxNGF1vE7dLqD5VEz+CWkYiA43H2nHcRbuLKE9g/cqy1qINPtHcCh5+g7j5Dfzyf1peOPE9dkyIUn2FYSgVcZ5kuN9+WBARbrTILILwzZtyNPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzs/gOsv2c1uAVXi+rmfxpqK/N0f0aZ1XZ/0JrecBoU=;
 b=A/Zk2Z0ltY3B+nMauqUPBcDKkEk5MdmYCAbLgZmFhlr80m8MNfEeWIqf0zcbAdD2dMVxjNgLRmhM9HWqnm+NkCK8AyDQLm0JhLxh7YaB34WefX7NC/d3YsC/7YFJA63p++RoOEdCGHehyJlCUb/KB6qmWwBRHU8nksf8i6s0E7uUhLnf67zh/yfRrgJtyiJdBWcSb6D+Lu1GonFhhHI7gRDThcvqVi6dZyrNHYFzDhGX1e7rhJbYctDa6OHCpmufGT4KH2xpMyvbBHPnTgbdtpI8S3XnFAiuMeU2fY1wDbFiaREYhiMZPaC0NfSV9G5F2wFzOhE2jySCotoqfTXy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzs/gOsv2c1uAVXi+rmfxpqK/N0f0aZ1XZ/0JrecBoU=;
 b=lMHsMYDw5xjvFdfwQZ4FoztN7dAuRWfKRlbIZS1voeossssgHQBsnLNe4OETYedjESK8P1apQ2TA64b8JwC18iHv062bYZ4y/oK0mCTXsB3sU0W+ODtqslS1G6njkX2i+fWomRUGQChRp7lzokQPyA3Ks0aTLpKWSTVGTx3VSYs=
Received: from MWHPR1001MB2096.namprd10.prod.outlook.com
 (2603:10b6:301:2c::21) by MWHPR10MB1998.namprd10.prod.outlook.com
 (2603:10b6:300:10c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Wed, 9 Jun
 2021 09:26:04 +0000
Received: from MWHPR1001MB2096.namprd10.prod.outlook.com
 ([fe80::55a7:ca2f:b4a5:dedb]) by MWHPR1001MB2096.namprd10.prod.outlook.com
 ([fe80::55a7:ca2f:b4a5:dedb%7]) with mapi id 15.20.4173.037; Wed, 9 Jun 2021
 09:26:04 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>
Subject: RE: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Thread-Topic: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Thread-Index: AQHXXPQc/GlUWUBsN0yos674dzNO5asLWyGAgAAM10A=
Date:   Wed, 9 Jun 2021 09:26:03 +0000
Message-ID: <MWHPR1001MB2096CA7F29DCF86DE921903EC5369@MWHPR1001MB2096.namprd10.prod.outlook.com>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
 <20210609055534.855-4-anand.a.khoje@oracle.com> <YMB9gxlKbDvdynUE@unreal>
In-Reply-To: <YMB9gxlKbDvdynUE@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [171.50.202.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec3a011d-f35c-47ec-8e74-08d92b289a7d
x-ms-traffictypediagnostic: MWHPR10MB1998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB19982B39385851B76CA15E6AC5369@MWHPR10MB1998.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DH4JVKWQdlmoSWSATCoF77dIebR9tRwpyc4EZrPwATYNr93tec0ToBi3jccroh3HMLQu1QYEVdbZM/Q5AoOY+S//xwQu275l2S4itrcxVOwvNWAx3mwXhfLp3uEH9tVXdwIGGkecHSMu2x0o7wBwZK0anMu661hR8mBsHhyPvV3bTP2OaCKxHLrJZ/nmoIIm8C7O3TnrE0tNyR+JcOA0LEc/Ydb8ff2+b8v/1zSC3AuAMO4ymwBNCJoOBwalv3vQk+yVJfEpYQ67VcUD5Vk2MxaJGq2T+MeRSxRtUeS/D9U1OYKhUN+wL2xczTnf7wXiDK8xKU9vVmRKvuLdXy74QklcNrx+HVVfAT4XnuVkwBlXlfbEKVhtqMlGrqTSXrzCvkILcOY5NFgYGpnv3wM6G9e3+SIRZmcPsezRSKK7sfnHQnmlav9dThNYFLzAnL01T0B5gdr1FH8LYt0HeQgCi/b+HkSBtAuHF6UPt2Sz4ey1fLvbIet+evh8YjDty7NbJksnNQcnPp5tfbXJWlnXFKRh6X78bm40ElpEMZj4L5lKorg5gDycHVWn6sV7GH7CkHwCiZh5QkpURDfP2yJoVk+tuafD3IeCYvVX6LZf8So=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2096.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(71200400001)(54906003)(5660300002)(55016002)(8936002)(52536014)(107886003)(66946007)(6916009)(186003)(66446008)(9686003)(83380400001)(8676002)(478600001)(122000001)(64756008)(26005)(66556008)(2906002)(6506007)(316002)(33656002)(76116006)(86362001)(7696005)(53546011)(4326008)(38100700002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fxZhvaUYvmvkellXgX11XOmbEaTRupyY+eT29cuT2zxa9YmhF3cHqcTt4lrZ?=
 =?us-ascii?Q?BCmpB9KzxSpjN0r5javr7gsXCJLpRAllnRS6XjMg0n7WNxJp1wi7vvMF+RoA?=
 =?us-ascii?Q?wk63ZXdO13d0lTpW1p9C9iKMTKJDSUiYxnXiP5W7t932nUjVwSS9Hc+8mt1m?=
 =?us-ascii?Q?kWKKksPervlKJy/hxFCPh/XkkyF/y86DhoYXpZEkyOsdW0QaeCsDePBgkLIj?=
 =?us-ascii?Q?iQwO2HvTt3zUBPGjjHisIksqNVm3vesi/2Uu211jiyOOs/rB2B+nRgF+utA1?=
 =?us-ascii?Q?RXoIDL4kQ2CJni1dH6o2Y/Q9D0wepK1X5BCa/0DD169DjTrK73W2tf3CINi1?=
 =?us-ascii?Q?CrrZubdopFHpRWJeM9GrWvnwMMA8ZGzCvXWiAA8OjAmiwfBS9et0I+I28WON?=
 =?us-ascii?Q?5Bn5yvNVLBAa5n8VPw85iBhl5vnglmyr+xMZldAtKb2R7v8Sg/NXLiaP2s17?=
 =?us-ascii?Q?DJZ4WsM9LOHFt8GGmr/knKuRAx9lJAR9VnYrPqxdn1k3dKtoCZqchg9LG1MW?=
 =?us-ascii?Q?/RehQfd5bmutecAjV94oO7Ic4u/8cfO9KvR/qR8t22aBr8VILGObzhTxh/WW?=
 =?us-ascii?Q?vXEkoFX9MWR9h6jkYwJqHZaayd3jzChVpuJXbXtfaWcNLE8j+GK97Fp7HPB5?=
 =?us-ascii?Q?nYLsJbcN7P4H/+7htBwsshp3nexTw/0TtNvmxvnRyqFLhNKMvLU8osOFBNiR?=
 =?us-ascii?Q?y47D4Qd/Wq9QpUQC7Wnnrpu/vNMdx6FiVdo8Pcox7mVRHUYWqxy3nU41fWHd?=
 =?us-ascii?Q?3TvnnZMkm7uxeMxMzGv+DXxtx1cfOIGxcvfHTlDapWQFXiLegSIov76+tmP/?=
 =?us-ascii?Q?PnawkL8amaU2Swh2wA1YVF1Z6Mjj1vqeVC07xcke3U2FaDkdgMbvaBHF6E2r?=
 =?us-ascii?Q?Uu4qRo8yzdV2Xz66kWFamkvO23gbdkfAA3PZYdrBEGcOydTl7cwrFdZBVY+F?=
 =?us-ascii?Q?3cIIzm6n8gJMGMz9fWqSXgV9d8CzkDBXEGNHrpLe+PWCrUHjHA2YTCy83fsZ?=
 =?us-ascii?Q?x1fMqTFQ1tMwopCKbOcfR0OVG2mR8yfVkKEEn1CfIbhSTGnZh5aOJ3z4lzKK?=
 =?us-ascii?Q?xdA8cWGpgbfEPACyGhguu6Hw9ClLCGLTTXXo9EzWBGL4LZ8I/bu3RY6lH3Md?=
 =?us-ascii?Q?pXbAMlA8YOI+HCUPBQgCn6FAMw/YLgxB42ewjbkSpLLkRmSlj7bvDIc2zls/?=
 =?us-ascii?Q?Xgl6UDSknHvKHdAQtFUe75s5jNRIeJnfAvNd1Tc0TgjHNS6C7ViN5SM8Tn6E?=
 =?us-ascii?Q?64Hp9xXKuGhw4PetdXFOfLyD7BG9CT74RTWcNI9fl7xbRuYgHdF/3AbP9GrV?=
 =?us-ascii?Q?4YU0a+5zetzr5daGnhIuNc7V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2096.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3a011d-f35c-47ec-8e74-08d92b289a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 09:26:03.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEE0EMEPpdNW10nM4A6iDocntYdt9ccIWDxtCAnnZRgPoXohSsnByMRHqLg6btiIGtlCiy+mjC/HfG80+3hTEUZtdfMlSnV665UEU3NPiuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1998
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090042
X-Proofpoint-GUID: hm1-Fk4vP0SLmLV4Ke7ORoKoC2d-CKNJ
X-Proofpoint-ORIG-GUID: hm1-Fk4vP0SLmLV4Ke7ORoKoC2d-CKNJ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090042
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

The set_bit()/clear_bit() and enum ib_port_data_flags  has been added as a =
device that can be used for future enhancements.=20
Also, usage of set_bit()/clear_bit() ensures the operations on this bit is =
atomic.

Thanks,
Anand

-----Original Message-----
From: Leon Romanovsky <leon@kernel.org>=20
Sent: Wednesday, June 9, 2021 2:06 PM
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org; dledford@redh=
at.com; jgg@ziepe.ca; Haakon Bugge <haakon.bugge@oracle.com>
Subject: Re: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB =
devices.

On Wed, Jun 09, 2021 at 11:25:34AM +0530, Anand Khoje wrote:
> ib_query_port() calls device->ops.query_port() to get the port=20
> attributes. The method of querying is device driver specific.
> The same function calls device->ops.query_gid() to get the GID and=20
> extract the subnet_prefix (gid_prefix).
>=20
> The GID and subnet_prefix are stored in a cache. But they do not get=20
> read from the cache if the device is an Infiniband device. The=20
> following change takes advantage of the cached subnet_prefix.
> Testing with RDBMS has shown a significant improvement in performance=20
> with this change.
>=20
> The function ib_cache_is_initialised() is introduced because
> ib_query_port() gets called early in the stage when the cache is not=20
> built while reading port immutable property.
>=20
> In that case, the default GID still gets read from HCA for IB link-=20
> layer devices.
>=20
> Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
>=20
> ---
>=20
> v1 -> v2:
>     -	Split the v1 patch in 3 patches as per Leon's suggestion.
>=20
> v2 -> v3:
>     -	Added changes as per Mark Zhang's suggestion of clearing
>     	flags in git_table_cleanup_one().
>=20
> ---
>  drivers/infiniband/core/cache.c  | 7 ++++++- =20
> drivers/infiniband/core/device.c | 9 +++++++++
>  include/rdma/ib_cache.h          | 6 ++++++
>  include/rdma/ib_verbs.h          | 6 ++++++
>  4 files changed, 27 insertions(+), 1 deletion(-)

Why did you use clear_bit/test_bit API? I would expect it for the bitmap, b=
ut for such simple thing, the simple "u8 is_cached_init : 1;"
will do the same trick.

Thanks

>=20
> diff --git a/drivers/infiniband/core/cache.c=20
> b/drivers/infiniband/core/cache.c index e957f0c915a3..94a8653a72c5=20
> 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -917,9 +917,12 @@ static void gid_table_cleanup_one(struct=20
> ib_device *ib_dev)  {
>  	u32 p;
> =20
> -	rdma_for_each_port (ib_dev, p)
> +	rdma_for_each_port (ib_dev, p) {
> +		clear_bit(IB_PORT_CACHE_INITIALIZED,
> +			&ib_dev->port_data[p].flags);
>  		cleanup_gid_table_port(ib_dev, p,
>  				       ib_dev->port_data[p].cache.gid);
> +	}
>  }
> =20
>  static int gid_table_setup_one(struct ib_device *ib_dev) @@ -1623,6=20
> +1626,8 @@ int ib_cache_setup_one(struct ib_device *device)
>  		err =3D ib_cache_update(device, p, true);
>  		if (err)
>  			return err;
> +		set_bit(IB_PORT_CACHE_INITIALIZED,
> +			&device->port_data[p].flags);
>  	}
> =20
>  	return 0;
> diff --git a/drivers/infiniband/core/device.c=20
> b/drivers/infiniband/core/device.c
> index 595128b26c34..e8e7b0a61411 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2059,6 +2059,15 @@ static int __ib_query_port(struct ib_device *devic=
e,
>  	    IB_LINK_LAYER_INFINIBAND)
>  		return 0;
> =20
> +	if (!ib_cache_is_initialised(device, port_num))
> +		goto query_gid_from_device;
> +
> +	ib_get_cached_subnet_prefix(device, port_num,
> +				    &port_attr->subnet_prefix);
> +
> +	return 0;
> +
> +query_gid_from_device:
>  	err =3D device->ops.query_gid(device, port_num, 0, &gid);
>  	if (err)
>  		return err;
> diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h index=20
> 226ae3702d8a..1526fc6637eb 100644
> --- a/include/rdma/ib_cache.h
> +++ b/include/rdma/ib_cache.h
> @@ -114,4 +114,10 @@ ssize_t rdma_query_gid_table(struct ib_device *devic=
e,
>  			     struct ib_uverbs_gid_entry *entries,
>  			     size_t max_entries);
> =20
> +static inline bool ib_cache_is_initialised(struct ib_device *device,
> +					  u8 port_num)
> +{
> +	return test_bit(IB_PORT_CACHE_INITIALIZED,
> +			&device->port_data[port_num].flags);
> +}
>  #endif /* _IB_CACHE_H */
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index=20
> 41cbec516424..ad2a55e3a2ee 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2169,6 +2169,10 @@ struct ib_port_immutable {
>  	u32                           max_mad_size;
>  };
> =20
> +enum ib_port_data_flags {
> +	IB_PORT_CACHE_INITIALIZED =3D 1 << 0,
> +};
> +
>  struct ib_port_data {
>  	struct ib_device *ib_dev;
> =20
> @@ -2178,6 +2182,8 @@ struct ib_port_data {
> =20
>  	spinlock_t netdev_lock;
> =20
> +	unsigned long flags;
> +
>  	struct list_head pkey_list;
> =20
>  	struct ib_port_cache cache;
> --
> 2.27.0
>=20
