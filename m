Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90CED254A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbfJJI5Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 04:57:24 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53752 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389379AbfJJIqv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 04:46:51 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9A8jJJj024104;
        Thu, 10 Oct 2019 01:46:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=kb9tzya1wC6ftj2lCXZNi3M5V5WXKYqiC9fiOHCN5ZY=;
 b=VSaloraoGe3QcOKn2vtfuvxk47X9sord5JrRIgW6Sni2lYWgaLChF4BeryA3M8ajjwsQ
 7FQWtDwfAAkSisWV6SunmgrANMHoR7YAb9/1vYAfN5tMPcZdyTs4W5SwiLjG6v4VF0Kc
 DZP1z+ppE3EoaSWpGkaz3CDTcUV0GZgm5A+ll+erc1juxcoEi7rdPmTMVwZV9g5QPLPN
 4hC72cQDCtAGaz443LEoJX+6Z0WykzySm3h8e5X8V1AvfefPvfOwXaUIGkLOnQGgVSkU
 CBozTv8Rbroj9Fqvkppf0igc0Y7UzyazR5Momtn+gkqPRucIZsGdlILgOJdnYKH4vR2D 5g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbv5mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 01:46:44 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 01:46:42 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.52) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 01:46:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN/sSwujsAutZh2xJz3O4NLPzB4AxfnYLsY87XB/zHjGbROI9z/SDYlq84IgOQx8s/qU8YyO3tbLVi47iGijl1ms4Zc3iZUUUtgtzWSGUwn43ERiyqI7DPn4Et/gUCgXVaXZEXY9cu1N4tZdigo3hbFtE0sTFSvfxmrzGtEJhNASy6fOvpd/XMFOtkt6mx4og5E0Uf6zjCwnszPq/5X8mY0Sk/M+KKh//V61Hlv6OnnT7CzkNyocOi97yps5oDwWEbbvbFNllB2lksT6smr/jKGdFPmjodzOZExJAbRUIBl6iU7iI8QdXLCyINUPWa6+Eta8b2le7R1tUsWrvsbSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb9tzya1wC6ftj2lCXZNi3M5V5WXKYqiC9fiOHCN5ZY=;
 b=T2yS8TUG+kdHyHyerzbA0yvWXpAyhML1L+LwTBgh/lfZCnylU4nokQ4ktnG2IFJQM+Iicc9PEWxpMJjvpqsQMqNqohWeoDCu7X8GijLeI6NPkMyNartld8wSeUYn7LYy+CQGD9NhDuqecaIzNwC/vEjV2whmEjo/queReaNAH9mumYvv9YKEYENRR+ygt0jl6aZ4/NleNc4nogfAHjmOaVZijuh1iBupDhZC5gC3iFFw8+iL/9SUxZ0TiZlWzIF0ZE7IzIkDpmlpu3F4qpJMQMYONia5g8mzZugINnHFsh8KpSPPC10SHXFBsWyG9OTx+K3Zdk1i/fLfuYL6lQ4rbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb9tzya1wC6ftj2lCXZNi3M5V5WXKYqiC9fiOHCN5ZY=;
 b=eFZX8Wp7gOUbtSa7m5uF5LSYQwgicNW7vZ0ZLk60kl8M6lpOYd1EJbF/CJib0FQTjNYGl+NbsLefukoTrPDO6kY81ad05VYivf1ZMM9QNshJhnPX4tDSKvGvQQPr3b1PK7A0DMk7x5L2mDr2PvgI0jyZFBVs4L0qp48Veom1YU0=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3311.namprd18.prod.outlook.com (10.255.236.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 08:46:41 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 08:46:41 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Ariel Elior" <aelior@marvell.com>
Subject: RE: [EXT] [PATCH for-rc] RDMA/qedr: Fix reported firmware version
Thread-Topic: [EXT] [PATCH for-rc] RDMA/qedr: Fix reported firmware version
Thread-Index: AQHVfVNNYQHKPS8vTUWQHUMUdr/4yadTk74g
Date:   Thu, 10 Oct 2019 08:46:41 +0000
Message-ID: <MN2PR18MB31828906894A5723E5A18F87A1940@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191007210730.7173-1-kamalheib1@gmail.com>
In-Reply-To: <20191007210730.7173-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6f10d95-4d19-4a6c-adc6-08d74d5e5f04
x-ms-traffictypediagnostic: MN2PR18MB3311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3311111CD56D16F1AC4EDCBDA1940@MN2PR18MB3311.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(39840400004)(136003)(189003)(199004)(11346002)(66446008)(64756008)(66556008)(6246003)(66946007)(66476007)(486006)(14454004)(99286004)(7736002)(52536014)(316002)(476003)(55016002)(9686003)(229853002)(478600001)(66066001)(5660300002)(3846002)(76116006)(446003)(6436002)(6116002)(86362001)(76176011)(2501003)(8676002)(186003)(81156014)(25786009)(81166006)(305945005)(102836004)(6506007)(256004)(7696005)(14444005)(110136005)(54906003)(4326008)(107886003)(71190400001)(2906002)(8936002)(74316002)(26005)(71200400001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3311;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KiZAcgeLyo1H6l1c/BpcCrgwkNUaeOh/gqLTWq74Ok+jwxmUJvYvrPHN5mm2ro8V9sU22vU4Cs7yiJLbJW3xBndMOwJANmguP3xAr64wSUvEKH8p3rgFd7XdXzdbWv7VmpgbwSmaDgjTPIg0fiZskI842jpQf6mDOZfXFDPhbTvkeyCxblPltz0FyX+jJw09niw4ukfy93hsJMOGYSYq/HLWimImlooSNnVSbudO2gDqlWZEcvB+GcpiQLvN2csX3qeOyT4i8M6sWaPx6pJ4+YgqAAWX73qf+kz4zC4Fz016I3ZRwJQfiptxzZ10MFZcApMeXJuTsfj6uJ9LoMaHHCo52DTjem/n2527s1dv0XS+qNQxWJmnvHYAE/X1vcfvvor7xqMFDXhydRzeXkY2Kj5yaJt53cKiqfdPHs8wjjM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f10d95-4d19-4a6c-adc6-08d74d5e5f04
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 08:46:41.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnihPhAWQA64EbjKqckvu9yrUUBCTxggMaMCgiQSFj/i2jUTvHrejEzzecuiB1htd4MGKCzU5yYMqohXDIcNXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3311
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_04:2019-10-08,2019-10-10 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: Tuesday, October 8, 2019 12:08 AM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Remove spaces from the reported firmware version string.
> Actual value:
> $ cat /sys/class/infiniband/qedr0/fw_ver
> 8. 37. 7. 0
>=20
> Expected value:
> $ cat /sys/class/infiniband/qedr0/fw_ver
> 8.37.7.0
>=20
> Fixes: ec72fce401c6 ("qedr: Add support for RoCE HW init")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/main.c
> b/drivers/infiniband/hw/qedr/main.c
> index 5136b835e1ba..dc71b6e16a07 100644
> --- a/drivers/infiniband/hw/qedr/main.c
> +++ b/drivers/infiniband/hw/qedr/main.c
> @@ -76,7 +76,7 @@ static void qedr_get_dev_fw_str(struct ib_device
> *ibdev, char *str)
>  	struct qedr_dev *qedr =3D get_qedr_dev(ibdev);
>  	u32 fw_ver =3D (u32)qedr->attr.fw_ver;
>=20
> -	snprintf(str, IB_FW_VERSION_NAME_MAX, "%d. %d. %d. %d",
> +	snprintf(str, IB_FW_VERSION_NAME_MAX, "%d.%d.%d.%d",
>  		 (fw_ver >> 24) & 0xFF, (fw_ver >> 16) & 0xFF,
>  		 (fw_ver >> 8) & 0xFF, fw_ver & 0xFF);  }
> --
> 2.20.1

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


