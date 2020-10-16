Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E6C290D60
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 23:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgJPVoR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 17:44:17 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:60228 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728536AbgJPVoQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Oct 2020 17:44:16 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GLRx19012602;
        Fri, 16 Oct 2020 21:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=RBnjolYwp2oJry9A6sQPuveE5ZRI+B0SP8BRPX5Mes8=;
 b=FZITziKMJw8Q3zoWUrojsMaD0Eu+yTx4bbqQAUEIHP11MS/gYV1Y+Bmkq0z3X4JiJbxd
 KWUT5+HeIqFyObpb9yesBtCEn69sbfhZg13gmOoFCQvASlEQBnXhrfvoQzv83mUV19zD
 yqZypey9E4ylxIOZyuYPKj6rbnD2rnKHtGiF6m2+4iSqlKF5yOKdTvL6fE6AxkwckmXx
 4g3fTpRDVekCH/Izsg8eZmK2ufSMupGTN1ZrKqkkeuIItUbqSlcLfeNZtGoSK9h1nqbh
 +GNr7Uv8qjmS1RAxzYHwDcU7tTvBWmjHUjnf9X85Ja6bYA2RF4lIB2P0yWjzIkfBENSu Ig== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 345wffjy3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 21:44:14 +0000
Received: from G2W6309.americas.hpqcorp.net (g2w6309.austin.hp.com [16.197.64.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id C2B5F9A;
        Fri, 16 Oct 2020 21:44:13 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) by
 G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 16 Oct 2020 21:44:09 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W9119.americas.hpqcorp.net (16.210.20.214) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 16 Oct 2020 21:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKDkuNNA8AmwxLK1owavsjMZ6c9s541IjdTkBSw+ZJXqdBAVyLKFmNvVt8J2BMN+9iWqwYFG7ZPK5oB0ejtoudqChRwJhIMuUvb63h14PwlXAcL3liEOrN2bnWaGIts1dx4JNRZOuAP/HlkJfjdkpG3dJQj4n7+d77Q0TZno+Sgt94tkdxhlKTPJuO6qunJonmBRx/ANi8chWfSkX6izg7n/AaJTfCgIhhOm8jPPkroYccb02q3WUe+VBH38rWtScvYdVOBj9ILfcsK85Ef97JxIiHmx8DR/l3iVuprWro91TPOdYLj2KfXvnh/MZ0U1kOmzXaofCZz2IFL8S/Qz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBnjolYwp2oJry9A6sQPuveE5ZRI+B0SP8BRPX5Mes8=;
 b=LBQE85i/mi6Bq5pD1esNeB3pKwataX398N+npkoUC3/1ggeCqgjhPSLE7LZqbD0Ay6fJIHp3fzJDWY3XpyLa+Jw2ATdISMY/G9atj51kxW1j6JR0yKWlscb/y8iHx89kSJls8lSFN5ovEENhWIa0yAkBuX5FGWTW8iheAUeTfnJY1mVohw7yFIurgN7NqqyHtUxS1iEYf519mzYd0cVPoVUVwpKG4cSYzC22IPnQ0Ve0VInKN4H1pg9b8gJBmK0oGVi+/Q2393TvmIW8ldRPJEzOCPNSzJXwAc8EuDhEXzUk3mz3UhYnfjq+xx/y8O0VJ4q4R7/6cIRgLdqxUdl7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB1301.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7514::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 16 Oct
 2020 21:44:08 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7c1c:4b55:a7c1:cc55]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7c1c:4b55:a7c1:cc55%12]) with mapi id 15.20.3477.025; Fri, 16 Oct
 2020 21:44:08 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] provider/rxe: Support UD network_type patch
Thread-Topic: [PATCH for-next] provider/rxe: Support UD network_type patch
Thread-Index: AQHWpAL9lbU6AS2BjE+h+nCH9q1ko6mawmjw
Date:   Fri, 16 Oct 2020 21:44:08 +0000
Message-ID: <CS1PR8401MB0821AB26B4CEB89D264A0B05BC030@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <20201016212459.23140-1-rpearson@hpe.com>
In-Reply-To: <20201016212459.23140-1-rpearson@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:b0e0:c141:6008:9b80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97e91596-3882-4dcc-b329-08d8721c9c8f
x-ms-traffictypediagnostic: CS1PR8401MB1301:
x-microsoft-antispam-prvs: <CS1PR8401MB1301FE24DD327B663A74720DBC030@CS1PR8401MB1301.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BsY6WA9DjA5YXnzMelEKDldVLuVaQ1ilKfpqH8enbGHjmN1KD8FHwy1g7+hPzuxaglR2xU75Nt4tk2rj2eDMfWDp66Gm/jYOaxAoEmc1jY7T6jy4ySntKe0Zo5eH6RaqPfiraWH4zppC+G/zeC7ttqJmODtm5xBvYlQkILmHtiYdFdXpfNYTF5kFcxI2t4M8qkepHydrrCFuUXyNUtZh4jpA/vEWkAsuFyaT50r8YbRDEA3kqdMsemKLK80iBo3q5X6SifD+DcYsaoq6YsB1skfjlRNkz5rzX834S5YPl41Si6yoUlJ9+kDkgzTmss2BVEMBJnPmclsDIwq5bMD3xQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(376002)(39860400002)(52536014)(55016002)(5660300002)(76116006)(33656002)(64756008)(4744005)(8676002)(66446008)(66476007)(316002)(66946007)(9686003)(66556008)(7696005)(8936002)(2906002)(478600001)(6506007)(71200400001)(53546011)(186003)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zrzTEvzFFlR5WLfD6VF29poJPoyPLZ1xlalE3daSKXLSi0t6Thb0GQZ/zVYEe/hdIXXnAD4+YH7+VGf9R26ud2hG2o77F1AIefw0QWrlLxJrnpJhntTtOXfbCqwWG4Z2uDOC+KCec1tY1adDngN3JP+lCusNn0fWVmfpAnypzG90u4QvzwdTB6wmn3e9nhtPKiuH5Srh/4jMYl8wSWiDrNzck1DKlcdwnScZlbYyAl1ID/Bhmvh/KSBgMU5DNl4sUnjImZvdAs3ozLs4BMfUkDamzZOcM9fl99Xn4wobYxN6P2L+RL1NAlS0aQtVp8Sp8dMzRiCpHo+a0L2sML0A75dZdvqLB5mSydaZmyYh+yL0jWfiKR+HHV82F4t9ho4DljuN6Ygwcbs7MqcUVsSC5oYGHu4Jsb6unvCJtrhtxOZRHxTnCGRrrLsRb8kADT5eXpmZRu8iKRTkhuKG7cD9EnOfEcW5Y31boTCp2Yp/UQFtnC7Yzn05w7+cuXI30BqxPPKb+ePsDg+U8EDgmi4i/bsD3+svgqq5pCnOTaa4E8ztRttHjXRKRjos1x6Wkd2eSzP2ZOKTrXjLZeWgYEM6BBMfyUK8xusH5QrGwXUmYAQvTroHrOngIGgkZ9nQOeLUMHqCVc4CU0KpFuZmFJOLefP52rhEw5t0C7PqXhGoyyHFwRBHD9+Bk42XDkA4hCTk0yJNjaMgC8nEKhA+soV4aw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e91596-3882-4dcc-b329-08d8721c9c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 21:44:08.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsDoF19qch7Fzy/GEgmuN9thGNJ0wii3Wp51hWu7H+FkAToUOIu/iUwN/M+PAk/cDkKj5PC6Oxve9CIHSIa/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1301
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_11:2020-10-16,2020-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160154
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bob Pearson <rpearsonhpe@gmail.com>=20
Sent: Friday, October 16, 2020 4:25 PM
To: jgg@nvidia.com; zyjzyj2000@gmail.com; linux-rdma@vger.kernel.org
Cc: Pearson, Robert B <robert.pearson2@hpe.com>
Subject: [PATCH for-next] provider/rxe: Support UD network_type patch

The patch referenced below changed the type of the enum to be returned in s=
end WQEs to the kernel. This patch makes the corresponding change to the rx=
e provider. Without this change the driver is not functional.

Reference: e0d696d201dd ("RDMA/rxe: Move the definitions for rxe_av.network=
_type to uAPI")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---


Actually the last sentence is wrong. The existing version will also work.
