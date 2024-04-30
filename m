Return-Path: <linux-rdma+bounces-2170-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED4E8B7A6D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 16:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D2A2871EA
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87C1527BF;
	Tue, 30 Apr 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="eYXFu9ji"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE851527A3;
	Tue, 30 Apr 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488208; cv=fail; b=sGv4WDwBPTNP30gZgMOiSSeZyxQBLDYSTO+rNMSWvECBEaYD+sufocYNKs8Av3uuQ0gy5Sogldd2Xjb7xhUe1Qmg1zpZHqAZxk5ugbQLbbKxz93UgfBt6aa1lrNqvkNdtst5qZ5pBJdIms7rTwQeOCFMJOtGeCPVFJpa3pkf+E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488208; c=relaxed/simple;
	bh=cWpobIAyvQqYmAGEf122/PA+a8bn+TAwtt98Ke0JUEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QSQlu8YmO7q9jcL8H+tI+Vary77t92Cp+G+bl3+PAcXGxGcgP0JTvmbcdBq2pYli1/FdnPWQUiar2kvAT5eocFfBpbpC43IZZ9CfTJFf14M7FfrxnGbxgCi0F29ZeCavbJiVd1z7JqkrwwD134PJHNPbNSRxvs0DBurTLZANTa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=eYXFu9ji; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UDT6BX008436;
	Tue, 30 Apr 2024 07:43:21 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xtxqf0vnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 07:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLNbzj8oye1ZWPjA1AJCm4NC0dZ5oSSSQMB+2NjDExFz4GPaKcE4vakxaowAvn/TxDJFRNUEXDxTIy+ZRC8gjvJHCFtGtRktn+Yg1vdWTaMcm4GdKzJtuHHUa230y0WCxdwXcWEzver6Ceqf1xK8DmSArT3wvzETOrg6eLiuvHLwRzDv2NfOOEM2Ld6b5HScV8Xi77VC44RDfe3UPb5IydPNJRHPOHzeOBAiHChKW9nkkYmyi2tq0GRtQXfUKMWWS17SYJZh3PfPZXq1tniXm9tZ/0CSjbYJqd+OouukkXaoCb1prJXMwMyX/fii/UX7IsVoVOdV5nfKiJP2aQ8Gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXw6nqls+cERSULNdDluUD6NbfaIV8XXzokBpPwGr0k=;
 b=SdEoFaG8bq7JnQnaK//tereiSCcE2tRqSVcE8fcICy94b8xuwKvH+ri+Uf8wIn1sCZOY0FbdKCZ882lioktJJPcQYbxktFY1SUEJ9csl34vfssvEP+g4d1yXoG8SNOT6usrk/Fhi2mMb6eH1qowqW+tpNfi0ODTV6VJKlztPkd/gM3mSVHiHepIiNXDMWA0Ah/DEblu40U5x4s24XTlVAKV202ixweGwF37wEILrqH9Ikq9gJMhReGIJNF4+0l7VRM9CmwF5cptDi1/pcI3zPmszArBuUOOaRlWDvJKZAtvwpaz+OhqLs1fyxTI+ogVYAYNegtrzJhoq4R5KynyCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXw6nqls+cERSULNdDluUD6NbfaIV8XXzokBpPwGr0k=;
 b=eYXFu9ji7Tzvw7t8Fp6sKisywF9M6Cl0D5kSSYeDmKfTukEPS4WT8ERsGE/cbHK8H96oqkepmXyTb1gTmdBbWBvBDPpqDtO1lCR4bYJZGFnhIpPMifqpg4OVo5732qAQlKMl9LXvFAMHQWCosrqJHv/JMb5Rj5Io2YFCXd/Q7ro=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by MN2PR18MB3653.namprd18.prod.outlook.com (2603:10b6:208:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 14:43:15 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e%7]) with mapi id 15.20.7544.023; Tue, 30 Apr 2024
 14:43:15 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@gmail.com>
CC: Chiara Meiohas <cmeiohas@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        linux-netdev <netdev@vger.kernel.org>,
        RDMA mailing list
	<linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH iproute2-next 1/2] rdma: update uapi header
Thread-Topic: [EXTERNAL] [PATCH iproute2-next 1/2] rdma: update uapi header
Thread-Index: AQHamufKZ0h06o0ddE2POm5Aay6MyLGA41Xw
Date: Tue, 30 Apr 2024 14:43:15 +0000
Message-ID: 
 <CO1PR18MB4666E319527D853C9F4179F5A11A2@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <cover.1714472040.git.leonro@nvidia.com>
 <b265f104d37354266a30238701d0f73b298a5209.1714472040.git.leonro@nvidia.com>
In-Reply-To: 
 <b265f104d37354266a30238701d0f73b298a5209.1714472040.git.leonro@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|MN2PR18MB3653:EE_
x-ms-office365-filtering-correlation-id: 5d1b69b8-2fa5-4489-fec5-08dc6923de69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?IHwvztbWHpfUGF+gGonaMvdwTpvd2xXPMsa7e9SiBBEBQ8rQOdjSjpXtHnTw?=
 =?us-ascii?Q?M3WfWOm3rdir8V/kKoLgHxOfO4SWqVh/B07fLrb2NLJZruANVCvPAMncIxVT?=
 =?us-ascii?Q?Dg3Sa/cKXo+VnGaXLnBM+YGoZ8us0MDv+EsMbWmxTJZjgxD/ADPyZaoZfV8d?=
 =?us-ascii?Q?/86XbKc/bpDyYSfPRaEOwP3M/pyuhadRavTOIcb7zHmDaiQsnbSMXhhoiLP0?=
 =?us-ascii?Q?UeekoWjBrc7lIcmNxp3Aj1tpuZNrZzEOfTZBQA7DxdI3UF9N8Ce0sc6+1LJB?=
 =?us-ascii?Q?Mn/BXXvmXp91tOphwKyubhRrObsrtydSJhmqqVfRi8q911n8wxAzJnRhhW6g?=
 =?us-ascii?Q?1vlBdPCzCWd4RoOdDqKacDLpwVer1a6JOsQVblY913NlG+Ml0EYZ8HoGpZsh?=
 =?us-ascii?Q?8cCrjCKhLfxMO+55GHCY8IktQqHdorQ3HwgGGf35UIfWUKpvd0nn2c8u3aBD?=
 =?us-ascii?Q?5qr85+v0FD17qF+TBUQl8JMyT37gG64hevWfZgAgYVKMFIFAcURyclRc+Pds?=
 =?us-ascii?Q?gtNbwA/ZFGtKg+GyLU7L/Vi16sCzrFqWk7Vf5KMcx8z98tXa2NM/aoJVhhe7?=
 =?us-ascii?Q?KPKJ9tk6N8VFXemtTGpBuu7Ai5mvLPKQBkdExkSXpMhA7JqpeAroLAW4Hnmq?=
 =?us-ascii?Q?gcwnl24tB/GRXF/D3OS5cCgQ84gM8XE1YBaPAyPohbuKDs1It7wgZQmlPeuW?=
 =?us-ascii?Q?rZMZLhxa13X4Ia5C2FxUOgaQeLdqMWhnTkRp4kMoGGD+LIkSuHOebFIh+ms8?=
 =?us-ascii?Q?TCDz/8VlHu6eTS9wN5QeTXaG1xHe+WY0kOiXP64TKOcbvcJ/O1rBKyovl+0h?=
 =?us-ascii?Q?g9jBHHl44R4DXFKQXFNNJw69Ykb4xF3Igp7Xl5kOMlDmm4BUmu9N00n+eTvn?=
 =?us-ascii?Q?C7ZOJ9HzzOK9QnxH9eJa+i5i9+Xmzvbu5y8ewEvaT4nNfJE1TokGmj+pIecn?=
 =?us-ascii?Q?A6EpKqmOlzJOwP+UaykacBWPy1OQcHZZhaJ70XE0rxHW2UjdR/grqaAD2Xvh?=
 =?us-ascii?Q?7BOQGhHBQV8oddvBpa/N/XKqJaM8Dvk2Yrw0vArQi2yrUeHYPChLkX2O5tGe?=
 =?us-ascii?Q?QCOlmhAB/apptlNKF8mM5S81Z8gB7fpBTE6LCZLySYfmULNztyK7D2v9IEtc?=
 =?us-ascii?Q?65iz69UmuNF0EPAc8vvymBZbKqX7mjF+Tk3pBWHfjdZBlwsbKp4LWf42hdqe?=
 =?us-ascii?Q?bz/IHcxzy1Xk0ukUZjN8KQVC0acWnxpPcNdMdGl+FMx9yLNIGHHI08Zx95Iy?=
 =?us-ascii?Q?ulkPA4se2o3EZWblBehh6Eu564LpoAfOaF/Hj4O8rNGkzuutwg3p/qQYKBvY?=
 =?us-ascii?Q?AUjgPowjyuTNL5++fNvytVJ/9Eny4w0elM7kZmTIA33A5w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?bY8/lN4CwZUGXlfISD7OQMZkNh9zd68tzYqCspmgZJF8s5s67ddPDXSTxvZM?=
 =?us-ascii?Q?U6q38Etp84Oc9inb/FSc4Wf7ONY36/xcTwlV8Z1BWTyMNMR0VP7O1quw7mXx?=
 =?us-ascii?Q?hJvG4xTr70hillJeKrcRFQoKFbbyGfz0qrhKoQlhoaA+P4MBOw8924KPbOgt?=
 =?us-ascii?Q?fQ9tuMiW2XXMSXo2SDyJe2Ha8WyElu4MyxYAA/ibVdVRyGUiwpSiwNxg61h4?=
 =?us-ascii?Q?1hhV+gk2OBDe/qp08XZkX1+Qq9u4uk+joVSI+spmL+p1Ij7S7mTo9l/COBU5?=
 =?us-ascii?Q?IOtI0zApoFIvhwA505++Hgb/qmRYLnZzXY3sO2bQOLR/2roYpEIfDCJqGBI9?=
 =?us-ascii?Q?0euFogqYPZ9++qBinBL9lvwHwOuxnNBAfiVSHhjkMUxnIPApUHr6yrozQF9D?=
 =?us-ascii?Q?Dp3+WBuZUnc2Y+bbu4eO5SyWy78UgLu84TA9nMjaFXdcYAwWqAOLjxUreEvn?=
 =?us-ascii?Q?Ir8Ny4EPtoiigblWN5mAr19u6SWCimCDf/Yz0DHz/ql0D3eZsmfP6JQNsrSl?=
 =?us-ascii?Q?za4HQ5ssMhEJ7XLplzEQbqu5ipvzODeFMk3FsSktLCHAEGoNSS0XNyiA2zPO?=
 =?us-ascii?Q?8EqPjCG8OodTf3EEBa6zBbxSb3pdjCbWq2H9aHHY+X2YhpRfGV528Lz/nsKB?=
 =?us-ascii?Q?4U9hQ/NkbFpSID6eTPgSln8dYMxbZ8KN9NmtbDQbNEjZyglkpm7j3PfGtQWo?=
 =?us-ascii?Q?SrWbfOs2qPlaQc/QguuTkghe7YtfSCqufe/m64UX+Q3WH/VYSWYKglv88uJe?=
 =?us-ascii?Q?usnjNfEpV6C0Tu5xsW0hPlTGEoMTF3GvwrzQ4Uv4a/YkaKTd3A28jmqeioKx?=
 =?us-ascii?Q?CYpGs571pQ+NAJO51zby9lpYcpHUiSwiEs/Ui67Ma3xckdDhonZziEaB4i8H?=
 =?us-ascii?Q?6qmPWprpfatFr5HDxuzirkduT892eAdbA+BhVEiEbZgZb33P0eErkXGb8xnE?=
 =?us-ascii?Q?7uDiu8QxA4ezF6lRb8pRKMp921KeWXTpBK97rSijM5iOgPJs+ysoVCnnMx+L?=
 =?us-ascii?Q?BQMKVHe189ynkH+dWDyJwoUxh+HQsDJVZasAmpfEsse7W7LKUquSXxiVQi/G?=
 =?us-ascii?Q?3jMikII0Ed/yl78lgMOYqjzdCr4ZuPLhfgctiMC2d7F5kTIYNiFxHtOC9bBw?=
 =?us-ascii?Q?erKxp+OHeSw3FHNyggKmlLPSA/4JxFmJcICyd32gyw2Gep1iLy7utU9H+YGZ?=
 =?us-ascii?Q?ComJGRLqcFW7aAZRUcvH9g9VM6SMm5LifnU52euAz5r5G0UDLt1Q0xDBMfZ/?=
 =?us-ascii?Q?oXIj29itGbqcB1wcPhY7GAPgN7hclfMRepCJa2dcfFEhr3/y/AMCMxqdrkdz?=
 =?us-ascii?Q?Bij6VeATyRMeGA/r5fRA3Wq6A29j6McGF0xiKMIURKOKO7DB8KZU8/h+VUtm?=
 =?us-ascii?Q?Uz9JeeCQ2077t8sPiCjrwP/pH29w997dvSTJXuOq6zUAJ5Ps/PGcV+ZQVbds?=
 =?us-ascii?Q?fE6WBC8jHoG5ehGX00+pD98+taPc9zmMs2xIevycyy89US8KVIPGzTomEHMh?=
 =?us-ascii?Q?GUhl1AGrXu+AdGpzV2i0/LDsOTRs77dOfVHW25GNPG4n7O5ZILNCGscqL/xV?=
 =?us-ascii?Q?NnbRjuU2MUO5Jp9jy/c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1b69b8-2fa5-4489-fec5-08dc6923de69
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 14:43:15.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVCCRGfw0ScOOTnDOVqaAnlLOcljapwXoatx1i7S4I7TwuXrwvg6dTjKbBWXnfdfMi42+5OxFK/ODbzNQ9w8Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3653
X-Proofpoint-GUID: r3FU2siam_MFkUtKso_jpVxXXVcxZo3A
X-Proofpoint-ORIG-GUID: r3FU2siam_MFkUtKso_jpVxXXVcxZo3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02



>-----Original Message-----
>From: Leon Romanovsky <leon@kernel.org>
>Sent: Tuesday, April 30, 2024 3:48 PM
>To: David Ahern <dsahern@gmail.com>
>Cc: Chiara Meiohas <cmeiohas@nvidia.com>; Jason Gunthorpe
><jgg@nvidia.com>; linux-netdev <netdev@vger.kernel.org>; RDMA mailing list
><linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] [PATCH iproute2-next 1/2] rdma: update uapi header
>
>From: Chiara Meiohas <cmeiohas@nvidia.com>
>
>Update rdma_netlink.h file up to kernel commit e18fa0bbcedf
>("RDMA/core: Add an option to display driver-specific QPs in the rdmatool"=
)
>
>Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

>---
> rdma/include/uapi/rdma/rdma_netlink.h | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/rdma/include/uapi/rdma/rdma_netlink.h
>b/rdma/include/uapi/rdma/rdma_netlink.h
>index e8861b5e..a6c8a52d 100644
>--- a/rdma/include/uapi/rdma/rdma_netlink.h
>+++ b/rdma/include/uapi/rdma/rdma_netlink.h
>@@ -558,6 +558,12 @@ enum rdma_nldev_attr {
>
> 	RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE, /* u8 */
>
>+	RDMA_NLDEV_ATTR_DRIVER_DETAILS,		/* u8 */
>+	/*
>+	 * QP subtype string, used for driver QPs
>+	 */
>+	RDMA_NLDEV_ATTR_RES_SUBTYPE,		/* string */
>+
> 	/*
> 	 * Always the end
> 	 */
>--
>2.44.0
>


