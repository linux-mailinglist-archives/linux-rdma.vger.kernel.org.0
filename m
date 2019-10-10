Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB1D2C74
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 16:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfJJO07 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 10:26:59 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:55150 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbfJJO07 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 10:26:59 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AEOKOd008102;
        Thu, 10 Oct 2019 07:26:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=WdyZ8twsvf1GAt1dzMmRdybasXB64fWFwOn+6XWjGvg=;
 b=xqjrpIDUA0eaf3WycI28oeyW5HY5BmxSS7mhxKbe2PM80Y7T8S8od1GduRYn6/jh9HE7
 8evWKMnmds5FiNegBDYFHZoVsew+z/Xtp6uPtqSN9hZf7EpFEUqXV9XiCHafs4n2jkgJ
 mo9qyKURqhG9FkZan8ty9HaG+R39R475hxsd4zgbwfqmaE3sfqCj9I1JrPTHCcUkPHN9
 gpKFRmK7ugnnt2Vi3MxsqEvAnYVmMPeKsGniRCSZQnSZT1xk6nKEcWx0TWDpZNQiny53
 UlhNToORa7Iarar8+9uuAv/Xgc+YqAGGn/HXZbQCXIvXMgqEyll/1Sa0EJ7hd1DJQU+c Bw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vj66h01xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 07:26:41 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 07:26:40 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 07:26:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsfdTdlTYa0hnu054rUgQlXzoH9CGAV03sIpXU+kNwNL1O9b57DobtX/xAe2nWA7nlZY9FHRFJBF4NY0VH82deQVmd3zecAKsLS2HjfB1eGypqrzRn3y+i09moo8GdS8TpiYlA6C33YRg7q4Pd//7xoeYkYZcvfwRB+EB7AdWk9LyKxXNd0Kj5f411P5/MJj83Of1lhZTvSHj/mUhhD5APOwaRgr3F10/cEj+4oK3YAJzaTt/zoMxgDII3/DMappQc5oowYbcHqjry/aKmLupkb5c0IPUCY7WAvd120YtKSQAt3ILR/ZcInQXTRkF8sYQ6nI8+ItOP6wVepco4GgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdyZ8twsvf1GAt1dzMmRdybasXB64fWFwOn+6XWjGvg=;
 b=ky5WOyTeSqXd8Ew/dn8u+zpCxWPhMlSDwKZwxDqeLI6TVjNKndV3g8jwP3yP0d+FYyXO+1zVGFPWFetZ76qBfhWdQuZYDv4+6qD5s2G1pb6sKOXIC9WurF7qhv4HOgFoLvhGDmcbsPn3WLkv6CJCHbIRa7vMzQBJB0wc+dWAWFn9OJ/G5awv/4VYoZ+MUh59z3tc7EKXAMywbFWHHbjQgYVKKYKngl9QjGDKZ53SLHI4XJsRcOQ/pzNQCvmQ8vdrRUQwvmnxvCCakTvNxXmTcS9CpQ5f3M3CDhZJvZAE8W5t6JwIWFLU98r7Z7xdFRApRy1QzOoAfNxaMGc4WXBcaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdyZ8twsvf1GAt1dzMmRdybasXB64fWFwOn+6XWjGvg=;
 b=uiGxB+pvtFHWqsochK+GR3wppK6aytA5Mj3oj0amJM55/hbfxbR8dnRUtxlR0l95GfCAzmLsEnzBAnZzrY8W92+ZSPh+9O6bAn/vJr7lJLsaYbx1Vo3NG619CZ8B2JlLsxKfZooPop73PTQIQSSZXlotFIYeWa9n2IlSImoYrDc=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2686.namprd18.prod.outlook.com (20.179.81.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 10 Oct 2019 14:26:37 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 14:26:37 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>
Subject: RE: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
Thread-Topic: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
Thread-Index: AQHVd2LBspxQVNpDy0K/WJNXeeTMaqdT/PIA
Date:   Thu, 10 Oct 2019 14:26:37 +0000
Message-ID: <MN2PR18MB318268F5426A2FFD5AB6F014A1940@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190930074252.20133-1-bharat@chelsio.com>
In-Reply-To: <20190930074252.20133-1-bharat@chelsio.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.178.84.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 226f93e3-eb51-49b3-d6ff-08d74d8ddc02
x-ms-traffictypediagnostic: MN2PR18MB2686:
x-microsoft-antispam-prvs: <MN2PR18MB26862C2F19EE0B95C2FE527FA1940@MN2PR18MB2686.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(71200400001)(305945005)(446003)(7736002)(25786009)(71190400001)(6436002)(86362001)(14454004)(74316002)(6246003)(11346002)(55016002)(5660300002)(478600001)(229853002)(9686003)(7696005)(81166006)(81156014)(64756008)(66446008)(66556008)(66476007)(76176011)(476003)(52536014)(2906002)(76116006)(2501003)(256004)(2201001)(3846002)(186003)(66066001)(6506007)(316002)(102836004)(54906003)(33656002)(66946007)(110136005)(8936002)(486006)(6116002)(99286004)(26005)(4326008)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2686;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vitnlEx0d7rXF7E+qNdOtqRdQNuTzM/bAaxuO/rBLkipahvUqk9lg0S+QFEQRS8Nf4TlytSKZKbvjTYXof6fGC+AOU/n8nobmYYBUkS0BnOyphSciz+sF0nCFPNAGpkwFpkb9hhb5th/jJJGPm4lq+XGSo+bTW9X1KUhUAtcV7ay9qQT+LQ4BPzIxuaaXBWX8eigmN/zosnVslbhJtjrFqEgQ1fVpE2STXvMaw3v78e0ucQhJFxo2Uyr+WZsCrlGoj9cWrtfrr9PP8aMF/iBh0eR4CaZuJ0maIPRBPhrlL1HRN8rsz7MWnf7kSHQrOpTfAlCWyTVpbzBvVG+bURCnQrJ3fNw9EjBYzo6LZrpO+ev4YmzRJBcRZ1J8R1h9ftNtRWPclzTfs4wYFFxxqGruGlDNMSUQL4RsC1NH/nnV4g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 226f93e3-eb51-49b3-d6ff-08d74d8ddc02
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 14:26:37.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93J1RsMLsLWr/rbt2JEgjHM4JqjYSSKqRnrRtA+wri27/sqGlpMvxvEcUE6Bal8mUx1ravnfqkKzmHnuwMb4EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2686
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_05:2019-10-10,2019-10-10 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Potnuri Bharat Teja
>=20
> remove iw_cxgb3 module from kernel as the corresponding HW Chelsio T3
> has
> reached EOL.
>=20
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  include/uapi/rdma/rdma_user_ioctl_cmds.h      |    1 -
>=20
> diff --git a/include/uapi/rdma/rdma_user_ioctl_cmds.h
> b/include/uapi/rdma/rdma_user_ioctl_cmds.h
> index b8bb285f6b2a..b2680051047a 100644
> --- a/include/uapi/rdma/rdma_user_ioctl_cmds.h
> +++ b/include/uapi/rdma/rdma_user_ioctl_cmds.h
> @@ -88,7 +88,6 @@ enum rdma_driver_id {
>  	RDMA_DRIVER_UNKNOWN,
>  	RDMA_DRIVER_MLX5,
>  	RDMA_DRIVER_MLX4,
> -	RDMA_DRIVER_CXGB3,
>  	RDMA_DRIVER_CXGB4,
>  	RDMA_DRIVER_MTHCA,
>  	RDMA_DRIVER_BNXT_RE,

This can't simply be removed, it breaks the drivers defined after this abi =
with rdma-core which uses a different driver_id
Removing this from rdma-core as well isn't sufficient due to backward / for=
ward computability
Perhaps modify this with RDMA_DRIVER_RESERVED ?=20

Thanks,
Michal


> --
> 2.18.0.232.gb7bd9486b055

