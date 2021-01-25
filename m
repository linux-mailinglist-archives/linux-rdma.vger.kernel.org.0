Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BAC303546
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 06:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbhAZFid (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 00:38:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42910 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbhAYSuj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jan 2021 13:50:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PIMOBb079238;
        Mon, 25 Jan 2021 18:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=idFKIq2kTEd4rqIbM7z+bSRFWOk1UbEawsP52Q0XkKU=;
 b=tbBrGW8+87FF/WFVEyp9eSSkm5O11hZawpDEatpO2YDMinGSvHuTjFPqP32Huk1HrUeo
 D+NiMXZDEnqBRqtshIsk9/RvTlssbD5sbY5H4wmb5g8YkX2wPpSzW9d3WBkmXy1HeqVh
 40xogf3LM2tyWSTv63TTyPDDCTPeNknol0FgrISsY0bPZtQ1Nwbs9zvgDpH+wBf6OHku
 NgZMmHFR/HOsNyMylcBICLrmvW9qrk8+gMLDC0ti/r3OrFNSKwuBvBcF7Ova8vxwYdas
 dIhz+SEP81HxD5QLim2CfVLmY/K6AvrEJ8Mb9fgdRsUYhy1n2ORxI8WOTjCU86qKLwsi 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 368brkeqbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 18:49:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PIGS7e014390;
        Mon, 25 Jan 2021 18:49:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 368wpwy5t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 18:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIdOFUF+/S0QVfMb8sNX3Zi0Qg63jxf1yFMRiD5fB6TjtvGEnJkKpsRm5AbJHHASUHxndrHcCy4N2HA9LFa7vGLR73qwbccc+wUx0OnZQ6CGLCYAt0Xm+WJ6fWju4yNdVSLxyMRjk2o5GArmJy4pgEjcVPAmBRAXQZ3LzWaGB6NUO18KmRPnSS2i7pBIshVxvZ6fJ2puRynvZZ5EEey8oNQDVU41PdsgZXV6MY0c0BlGYe0mzp+SDmYRfx47iI6H41DLb7WxKSKCzFLUYZjn8TYp8zdRZwplhE0ZUhcprx8I0rhjngKIn/h4YBPRU7H1ISawA3pjqF10PnamYQ7kNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idFKIq2kTEd4rqIbM7z+bSRFWOk1UbEawsP52Q0XkKU=;
 b=lOnUVT047JqyNOpqktBil0duOf+NLA38CNN2KVuYVrGxfnq0bWfd1nky4secUEJ4ZCkeL31FYPbDnoS0szF0R/cbuJDmqS1jX3/tjHqNE/xnJPOQGmGzH1BDbjcKkTAOsZZmgpprAgD6oa8rEYaQ67OkuoI/skMdKjynsKRNNeeoZmzLMHSAhDa6kFALvUcON4GbjnKcDRV3Ik56aUEZDNmDpVQ5EBMW15+68b5z1z+TV6IAUgwCVGMAFKB5T6FFAXGexlvZa28dChsEf6qafS0bU+QKlO3AfTWel38ZAmqv2qzGY4HaZ/flihWswUIOOcA9Z+jrXuhp2X4yELZlcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idFKIq2kTEd4rqIbM7z+bSRFWOk1UbEawsP52Q0XkKU=;
 b=YPp/gDLXyMJYutzHvHI+D/X3zpyol9dR3NKJ4TMz6OVSFIQROZE6fH74LgYGUcnQI+IDnkdPbrkOxC9PHEgXG6d8WYYcyHTh4pwHfEsin5A0N82brOnFIY8mJC9IS5upVzDzhAaR8EY0mAL+BCAwOo1hqKSSHKCevIkkPu+fuI8=
Received: from CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19)
 by MWHPR10MB1853.namprd10.prod.outlook.com (2603:10b6:300:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 18:49:47 +0000
Received: from CO1PR10MB4516.namprd10.prod.outlook.com
 ([fe80::6400:2fe1:1c12:94e6]) by CO1PR10MB4516.namprd10.prod.outlook.com
 ([fe80::6400:2fe1:1c12:94e6%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 18:49:47 +0000
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "valentinef@mellanox.com" <valentinef@mellanox.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] IB/ipoib: improve latency in ipoib/cm connection
 formation
Thread-Topic: [PATCH] IB/ipoib: improve latency in ipoib/cm connection
 formation
Thread-Index: AQHW8B2Esatxe3B/6E2gVSbKRz6qHqoyYseAgAZSb+A=
Date:   Mon, 25 Jan 2021 18:49:46 +0000
Message-ID: <CO1PR10MB45162B7BD3F61C91C0867213CFBD9@CO1PR10MB4516.namprd10.prod.outlook.com>
References: <1611251403-12810-1-git-send-email-manjunath.b.patil@oracle.com>
 <20210121181615.GA1224360@nvidia.com>
In-Reply-To: <20210121181615.GA1224360@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [73.241.150.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ab07bb5-922d-4f1b-c65e-08d8c161fcd0
x-ms-traffictypediagnostic: MWHPR10MB1853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB185381352EB5718882CEE28ACFBD9@MWHPR10MB1853.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 83sRhId5Vj3tfY6xUltVs12428D0FJgbj5ANA2bncWUtdv2JoNrwY+vsPst6VIiWNJcspuS8qfVPj/5TbDqw4V/IG/Wumclu3lrc3xVIOTDrFLZXS08KdA247ptyIeXCgfSaa4S1FedjgNwvdTvRMJJG7STNGXwo3PwoQnX2gA5PAQM5YyUKezo45dZzHFTYO0Ac/zW7pw6mHOsxlTU5S7e20cQ8b/SX/ogNwvR0no1QNSGttLEjwXafTreuC8pz2J/nqM7PoRvcDReQ110loOy1Afv2zSasabXes9XchNJKkLFSx+FEgWpUFzQyQ0Ne5D1lfM0l3B6fYdJerRwgsULBUDghhDLpDAyUG1ds04ho01WtevieSighNcodhhVnQBQAhJE5lM0pBoWRVFldmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4516.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(376002)(39860400002)(26005)(33656002)(52536014)(186003)(6506007)(5660300002)(71200400001)(8676002)(8936002)(7696005)(55016002)(316002)(478600001)(4326008)(76116006)(6916009)(9686003)(66946007)(2906002)(64756008)(66476007)(66446008)(66556008)(86362001)(83380400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8In83Yqwv/Yr2ojvnvM2LeB3Yx7rVcBgeGtPO0x2g1lS9IMrrgYL/v0A23RK?=
 =?us-ascii?Q?kDYMOZeKTp7SJ3pPzEqKKcGifHnoUA8ScxB/+YL9OQn4iIFFq0oaQFwOZQds?=
 =?us-ascii?Q?DYStIizsbcAWCBOmTOVMKSShfXiZ9uKD+0/qqiHByILmToVhCN/fA9LENC0T?=
 =?us-ascii?Q?nIZXX+qrYpjseTsLsDqfSB+miNJbpqeGpUFkIfPAHRq3oz8SU6Txxcpdg1M7?=
 =?us-ascii?Q?sOQCZcFIbRQSOqLRFE4aiVPLILFymvW85ioroXnaVnWW5vnn2mk0kCnS4JyY?=
 =?us-ascii?Q?kTbCuUf+u9x/rGMGONENpiJ9uxHTg/8wc096rLya3AEtE8Ib7FQUwdPjHcup?=
 =?us-ascii?Q?H2jY/2ClXeQTf01w4gwwGuUdInTvL5x5g/sjZFzgz+GhIoIgr09ZYRAUrTuk?=
 =?us-ascii?Q?yTiM3cMZPTn1qF/zyCZiGB1KbxTmQEE80ZByaEf4xP1baNMqPHrSB+aZTUAQ?=
 =?us-ascii?Q?v/YO0TGVTHBwLF17p5nEilzaZ0eR/ynTd6+6AP131kfxk99VBA/+4QiIR5PV?=
 =?us-ascii?Q?5O1cclcxaEeI6OLsvfT0HRm6dmr4f1A0c0A5j2rs5OEzOggrL01yZV+mAyvY?=
 =?us-ascii?Q?MS0e7XnC8m9rgERxtFZVaKi3dGH9VlhmBHGvWut6bpvzfBbAbP742fD2jJt2?=
 =?us-ascii?Q?R9DJWIOboAQQE5v8J8zYQTwOz9OjwE3bQDxdxi3zVAYF5/9fQGQvWWUnehx8?=
 =?us-ascii?Q?5w5CfSLG0NoHYhD/tbXxJ0xe8PajPyXvBiLbjSUYc7azijCt3pYQvKD/9ggT?=
 =?us-ascii?Q?BRMEEQ7V/lc3jwwiCniDeFeelKoxTjIqSaFehLqqexA6xE7HNqdOqdrJQItg?=
 =?us-ascii?Q?sRVLG0/NBISqfXmuVghVW8ZuMYtnHGjlBKpkN/Pfu/dTYT1q/uUcGpexz9w7?=
 =?us-ascii?Q?9DZJK87ry5yh0kTXCOVwhskvvVfAyZcFo837dPrXRmvcdiyPlUv0qZgUJoFN?=
 =?us-ascii?Q?gbRYWg1Pj4gUUainZX5T1W2cUakqI7EVoFW5XQ2+40s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4516.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab07bb5-922d-4f1b-c65e-08d8c161fcd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 18:49:46.8662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6y4Ot3lfuMmKpROghBtSOLyEatnJoqHsGPVmXFIs3hpyPn9+KsvFd2FFZg6pnECflYqzIVTpSS7wQdstRj4utP4yPxXRFkulmkJNuc/5i4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1853
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250099
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250099
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> On Thu, Jan 21, 2021 at 09:50:03AM -0800, Manjunath Patil wrote:
> > ipoib connected mode presently queries the device[HCA] to get P_Key
> > table entry during connection formation. This will increase the time
> > taken to form the connection, especially when limited P_Keys are in use=
.
> > This gets worse when multiple connection attempts are done in parallel.
> > Improve this by using the cached version of ib_find_pkey().
> >
> > This improved the latency from 500ms to 3ms on an internal setup.
> >
> > Suggested-by: Haakon Bugge <haakon.bugge@oracle.com>
> > Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> >  drivers/infiniband/ulp/ipoib/ipoib_cm.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > index 8f0b598..013a1d8 100644
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/moduleparam.h>
> >  #include <linux/sched/signal.h>
> >  #include <linux/sched/mm.h>
> > +#include <rdma/ib_cache.h>
> >
> >  #include "ipoib.h"
> >
> > @@ -1122,7 +1123,8 @@ static int ipoib_cm_modify_tx_init(struct
> net_device *dev,
> >  	struct ipoib_dev_priv *priv =3D ipoib_priv(dev);
> >  	struct ib_qp_attr qp_attr;
> >  	int qp_attr_mask, ret;
> > -	ret =3D ib_find_pkey(priv->ca, priv->port, priv->pkey,
> &qp_attr.pkey_index);
> > +	ret =3D ib_find_cached_pkey(priv->ca, priv->port, priv->pkey,
> > +						&qp_attr.pkey_index);
>=20
> ipoib interfaces are locked to a single pkey, you should be able to get t=
he
> pkey index that was determined at link up time and use it here instead of
> searching anything
>=20
> Jason

Thank you Jason for your input. I will explore and get back to you.

-Manjunath
