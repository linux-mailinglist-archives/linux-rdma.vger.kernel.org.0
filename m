Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83399DCFB3
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443384AbfJRUBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 16:01:55 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:41470 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440349AbfJRUBz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 16:01:55 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9IK1mVH007746;
        Fri, 18 Oct 2019 13:01:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=5zW9ong7KzloasgtFlldnlMR1BlWfLLGfyldJr5KEpE=;
 b=Zv7bpoocsZ4V1/2hHFhBkXr8wIWau+BpgfHFulsTyozRvaNfKelZqQWg5S/bmy5tB37c
 +VU9dv/MPeLfbNRxddWMslDgupgBAsg9YZleYBKek6beeHm1AdN5GjDibzYQMpjgj2zr
 zkWs96jrxmKYKuFtJqemp0SCc7ZjaDMQgbnGM2v53HBF+bmH4cW6NUtfeVP3gzFxp0B/
 xSLCkBh9UptMqdNFBuNifcKV74XqIjGDnP3742ZmhLXv0thz9+p+aaqGmBaKl0fyxbW9
 bd/FFF4CYd51WZmLKpiKyojAcNYVYcf6meaG/wkzIMg0KtKmcQY5KCCjyoacEilLpO6w Xg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vpurkd808-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 13:01:48 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 18 Oct
 2019 13:01:47 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 18 Oct 2019 13:01:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW/L0WbwWHH6Nia6FaK40obPi8tBbc3lotoUJnNRgDNE8OnQvslhpOBlEzS1DCfVf48jqPC/0noiooJtz6wp/bKkW1unX/DBO/paoYqF/P+Mh++11ynIBig5PtooQj8NkOzBHDVVkXoApylpldGIx/eg6MCOBDTOG07HmxJI5WGR/ipO/vUTZC9cJ4LgnIW3R0UXb1D09tbMXFeZqPFUTdNDBqDpHUvevX+gdZ6VsCxg12tbp9YNY7evrQUm4UA8Q+HBSVeFPRDEZWC9KRg6aBUvaNBDMU1zNpGKThIeHk5NERzUDwNJ/uoCdmSsvsCGH/TAa856trdQcu9lpzf2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zW9ong7KzloasgtFlldnlMR1BlWfLLGfyldJr5KEpE=;
 b=ctF+XwlE1wiqhtLMsoeGFOgNYAOEOwuiA4fx8cZiHFneOal67ZJXvlyuhYjrQxIssZvtrmdcp5M7lLcypwqOHP2GnLolfnHJKj4nh6oiah0Xw7V9ZnDOmYr3Jxde5A5iYORHZ8FYWFt7tuhMGyQ27mEEsPf6/qBuAvcGXwzyIeLhMlMj1VrslLni37nv+n6zEvzObL7kfodFue/ZZ6ku2APxg2OwaVT4CSStkCFRdY23DvLPkflIKVm1pEVn3P7UrCfnqrIgsB5r2jfb+rsNGWWkcY2RQ9i4QVbr08vYVEdR7Ubg7OfpGTKDd8yYEArr0nK/NvxsRp0sdbuLVJMgfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zW9ong7KzloasgtFlldnlMR1BlWfLLGfyldJr5KEpE=;
 b=dd96nLFOaRU3A1kjFbumGiCMfNYXz78ujlmU8ZgrlNGhmzsuqJLZVFYpfFEMxKAhITsdyjjmWDCS7hdDJY0NIy0xhWKZG/oyjqXjGwNfbjRFzmQuhZOa35ubTBfeAVT1+uYBdbmcAQ08xzsRTWXtHG9teN+9YaYMLjiVtu5AudA=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3135.namprd18.prod.outlook.com (10.255.239.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 20:01:44 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 20:01:44 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Lijun Ou" <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: RE: [PATCH for-next v3 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Thread-Topic: [PATCH for-next v3 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Thread-Index: AQHVhZg8E9wCMwh1pE+cytmNIdoZPKdg0mEg
Date:   Fri, 18 Oct 2019 20:01:44 +0000
Message-ID: <MN2PR18MB3182CB366CE76046B1739B16A16C0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191018094115.13167-1-kamalheib1@gmail.com>
 <20191018094115.13167-2-kamalheib1@gmail.com>
In-Reply-To: <20191018094115.13167-2-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.178.84.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae1b1753-7e52-4ca0-febd-08d754060025
x-ms-traffictypediagnostic: MN2PR18MB3135:
x-microsoft-antispam-prvs: <MN2PR18MB31353C096B0FA4BC17A3ECD9A16C0@MN2PR18MB3135.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(189003)(199004)(2501003)(52536014)(71190400001)(76176011)(316002)(14454004)(110136005)(54906003)(71200400001)(486006)(7696005)(99286004)(26005)(478600001)(102836004)(6246003)(186003)(11346002)(86362001)(446003)(66946007)(5660300002)(4326008)(476003)(76116006)(66476007)(64756008)(66446008)(66556008)(6506007)(81166006)(6116002)(25786009)(81156014)(229853002)(8936002)(55016002)(9686003)(7736002)(33656002)(66066001)(8676002)(3846002)(74316002)(305945005)(256004)(14444005)(6436002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3135;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q1+UeP1Nuyh1+eSAypDgll/a9+7ZQ1A3w8unWreerm/7j8jC6mbQ1dFP4nIuko2B8IEiX8CpUHmzDDf9I+Caa7N/UrvOU9rf4brYm3pWwZkYXmk0wtiXn6yja1HXx7PURzJ7NC2H1DUv5zV0mSdG+BdF5+g1xcbVIWjpyeNHOKIEDbSa+FxwqY9bluCXxsNjshEriL0pVYeSiNi/VDPjX9LfjtXwLnofcg9ifUaMtm8PJvg2Hg5LbU48vXPXSu/GqrCPHpnl5K4+/CBUQUblwfPoSg3dhqenwlpmzLl8pKxfBYu8l+dPEa/6atSi/mFHkXEKTuRepyNUmzCGsMJdb3ZJW2yPpEv74PVT26SaHUGUG1Ci46oMscz8Ld5NVv4WYsJtOPbN6GSD4frPXU2x0tmrzu4nowfFZgoEVleouBM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1b1753-7e52-4ca0-febd-08d754060025
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 20:01:44.4092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QYQ+BUGIzpXaYMURqOgqURJufI1L5bMQoGaOb3QpHHOuxMA1xtA3U2+u0Falsmv4+cf6JYnvVVKKHzoiUSmtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3135
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_05:2019-10-18,2019-10-18 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Kamal Heib
>=20
> Improving return code from ib_modify_port() by doing the following:
> 1- Use "-EOPNOTSUPP" instead "-ENOSYS" which is the proper return code.
> 2- Avoid confusion by return "-EOPNOTSUPP" when modify_port() isn't
>    supplied by the provider and the protocol is IB, otherwise return
>    success to avoid failure of the ib_modify_port() in CM layer.
>=20
> Fixes: 61e0962d5221 ("IB: Avoid ib_modify_port() failure for RoCE devices=
")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/core/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/device.c
> b/drivers/infiniband/core/device.c
> index a667636f74bf..626ac18dd3a7 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2397,7 +2397,7 @@ int ib_modify_port(struct ib_device *device,
>  					     port_modify_mask,
>  					     port_modify);
>  	else
> -		rc =3D rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
> +		rc =3D rdma_protocol_ib(device, port_num) ? -EOPNOTSUPP :
> 0;
>  	return rc;
>  }
>  EXPORT_SYMBOL(ib_modify_port);
> --
> 2.20.1

Thanks,=A0

Reviewed-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


