Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED90647FA64
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Dec 2021 06:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhL0Fsz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Dec 2021 00:48:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55060 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230061AbhL0Fsz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Dec 2021 00:48:55 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BQHTGSn026957;
        Mon, 27 Dec 2021 05:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PwuQ05nHcJyuaT1csK0arcPF7afzfAbsGxEZZeTB2O8=;
 b=QtzKqmr7yMeW9X3wN3FdeczqiWl2JKOLaj4BRZgw+diY3PnYIz5INN/VShVkts0CKE3V
 /yhibjUZUrojFg03S2caAcqFHmqEwY0uhhtHWezrG8In4sJ14Jstjq74+YPqGHfcEHsl
 OwDqCXffQfCPXJryktytDYJ3yAaoGpO+0QQsPoKSQUr9nxDmXfhimpACRTJ0JjQlcSBg
 SYJrDLRXdytK2qL5j2yUrvtcdwufDdG/fi+INaqsNdhVlWotisanTSw+5PeNPlVyYHVM
 uUbRpXuT+gFl1kGfGJSW2NOrsSEJe8R1tUS6Jy5RJUzMEtzJTpj5sU3EB5XnGNMN+YTp Ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d5t3426qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 05:48:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BR5fHL5068269;
        Mon, 27 Dec 2021 05:48:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 3d5rdugqud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 05:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njuMbo9dXtPabDtF57TxXms2tQ1y1mGA54Dh8yZWI3778eaV+MO0LvjHzytC8r67XYb0iMktXehVK5DeHIM1R2zVgjGgdo7BoYn9gPOo92gkFJWiGjrybNQhmWBGI3NGwraV8VLgFh/PP/UMvVq9djPU2KLgdJqCRRkpDgYAbaigem9x2n7hy3iv0ipkIcButq3QBMKgj+Td/+up6GzlBWyxD0pqlOSRORzkUbZYVhDRPwLG9QqD1BB15y+CAcxeWusJ7s4tB6D2sqc4S9CT/QLvFIY375BUos2p8T9okDWh8EBkVzwzWt18iRqlX/Jz2eA0stg+A0nyFiuMOqW+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwuQ05nHcJyuaT1csK0arcPF7afzfAbsGxEZZeTB2O8=;
 b=E7vLvaACnkgdV7mcYsBSprmzZmMV5boRfjd00lqnXKw8MH74BxaECJXqpj5zeR4tFF42WT4QL5Iy/9zcRokyInURGvHegsM/jkZABcyjl3EVN4XWo/nvfMqiVUT5dtgYyTsLDZ3mQdpfTqVCTwbFdIotusnpwKggblZevpkaK3AMPiGHPSGWTsLRalMEuErpdUyS6tobqZZrzr0oYi6CmP/MUvyoxjXyOpcwgMQd04BoxMgLN1P1XpAnyJdpT1E3D0aD/XcwhgHbmpfhsCXRQoc+tlcT43jgxAWe7IzhObjH5X6nwdQBEBhaXJsGoaeV/UJbngAStT+QWW7N94DC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwuQ05nHcJyuaT1csK0arcPF7afzfAbsGxEZZeTB2O8=;
 b=GNoXHeSE2JT3HdFT6YDIYscoQ+taK+R2rznmRV6iEU7cNqao+U4EIW1z38H/GIpHu8zGesooN1a+pxo5yn5MUEsUloBmSqdx3xLT9eiktPMa3i+NOeF50jc/yQ8+zZXObizcyE7iJaavhG/+43uTlKG7eCDrCBl6onuX3g/f4bQ=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MWHPR1001MB2173.namprd10.prod.outlook.com (2603:10b6:301:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Mon, 27 Dec
 2021 05:48:32 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee%9]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 05:48:32 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>
Subject: RE: [PATCH rdma-core 1/5] RDMA-CORE/erdma: Add userspace verbs
 related header files.
Thread-Topic: [PATCH rdma-core 1/5] RDMA-CORE/erdma: Add userspace verbs
 related header files.
Thread-Index: AQHX+JM+PXnWpzOkX0uhmWgn3/Vm56xF2KpA
Date:   Mon, 27 Dec 2021 05:48:32 +0000
Message-ID: <CO6PR10MB563579D00D681B370A36FBE2DD429@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <20211224065522.29734-1-chengyou@linux.alibaba.com>
 <20211224065522.29734-2-chengyou@linux.alibaba.com>
In-Reply-To: <20211224065522.29734-2-chengyou@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbf130b2-dbe4-4316-4451-08d9c8fc8433
x-ms-traffictypediagnostic: MWHPR1001MB2173:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB217383E30E54F3367B4D8F30DD429@MWHPR1001MB2173.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNxqvRgVPjIQVli8TL0EBePhAzvOTjz1stb/Cw7hYZJptLIARPOvrr/vQqvjdNq4Hi8Jnv+a6zHY/11GhGAc7AEEW8nxEcs/qBifF5zu3rYFuLvNcCo1D2LA5J2dNRQTF7zAggXMIwCfZqZ4nxXgqK5cUnw/kGK+vdYoaWjrfMgnft/u6jL1PKlEUI/dR/eXpIdbq3L0EmRVSGk/V80UAc8pSsWG3mMh/xk6SyvOkAOXHvUgDZC0HaFh1iDm/YzixM+bFEiTNQbq5W5Rim+A519NciHezbc6Xu5M1AcBT9857ADzU+Gt5x1BmZHD36n9ZPaj0nW2kSPUYa37ZY1uWGiS+/9j08IaRDxEKKgBUGCBxfzxSCThq4c7FvZYwVbBCtIKVnfeF6EkmLn5UA6HBi+nN9KZ/dX8FNeQUq5UEdnW6d/SRP8fWv4ZXwwrZYvBgA5vduUO88dEsHV+hZK+rnYzAARYQXDPnuZLuHngh0J1s15u8Zm7ZpLkiKnyPSoxrCJW60HP6jlPBx+Dvdu3UvHVA9H0I2Phe9yIqMQALCkDTxl5inu/5mBe632Fs2m/nanlXkKcXEjoZzeZyJpWPxii3MrZV4+SK1e7w11G2CbG3fV8uQ+GvkzCDU/bI8f0vR6u0xeTzRd3F5xx4UhKVXv2l7u+VSncJ6RSKdrGvoso73x86lOYh8fUXfp6uatXYWLpnz2mjmij4GVF6O1CcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(8936002)(38070700005)(316002)(55016003)(110136005)(2906002)(38100700002)(33656002)(122000001)(508600001)(6506007)(71200400001)(186003)(86362001)(66446008)(4326008)(7696005)(83380400001)(9686003)(5660300002)(30864003)(55236004)(26005)(66556008)(76116006)(64756008)(8676002)(66946007)(66476007)(52536014)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gBqi0Y0ONc/CtQvKiBQOYpP/vAUeMn2BuRTnmyid98FWTnnihahrnGMDOC7u?=
 =?us-ascii?Q?ElXyz+33DROIlsGaF+/Kx/nxQ7SMyHRAYfxAl9uqaAOR2AoQlroohy2GPboo?=
 =?us-ascii?Q?9ltjjJSXW37MV/3zKHHyEQeFKnPZX7viBsH1gBVWHqfUSYGfGzWTfFOEGDsG?=
 =?us-ascii?Q?i1yNAoswh6ZZ1w4UjbNPd9uKZjF3Io0vQfqTLt5wHr99N39a0JZc6vi0nh2h?=
 =?us-ascii?Q?xmrWipWQJjUM1qHJmyNMdfPTLDK+ER3EErFgQh/TLqt96LDAnO2D0v/MYp14?=
 =?us-ascii?Q?k+m+WYhhQGDLnHeUVi4zgxpYSwUShMSvxeRGs+b4eU6bhfdcpGnMwc325ICx?=
 =?us-ascii?Q?2f9YxjzZnis6VTxYPEziPWPTK2VbknFlrXmN5FoylYJ1111Su2sMsmuARrqH?=
 =?us-ascii?Q?6vuo6lYkND6remjhiGqL2yHL6E9W+8YPJ8/Wc7o9qipsIhWCnJEMcFN3e/ta?=
 =?us-ascii?Q?p4hbb5flqFpWu423XHpUBOjAsrbX+uQn0pmvb7K1axfQy17Okftp1U1KiGUI?=
 =?us-ascii?Q?AQ3aQO2bjJORgtTISvGlpQHaAGGsOA6wJs8bRWZiR4u8bWBNzICTf2CbezAj?=
 =?us-ascii?Q?Se4bTDDkfOIAZn2j04F1eB5FEsCnsRujOxSMuCjUMqwx6D7+sjn2fT3q+6HQ?=
 =?us-ascii?Q?fw85gVKKgNmXzbyZx9WLpbYci6glWQN/HINS4Haa9YqJgEGPw+2CVq+J41nf?=
 =?us-ascii?Q?DJEUAgBwWVGXWIEH92jU7Rx+RGQ9fm7EXwKQQxZcI3SS3RjnVbgy+YynYiII?=
 =?us-ascii?Q?bezyOo65rKESCBaHHdGR40v1XNZX8V8Kt0jIq03mdgq4lg/W9FxMPouAbFm8?=
 =?us-ascii?Q?5YrVEpvbNtbuY4jD3FXmPRrZTkvhFC7pqQ0qHcmgCNvH623ugGwalFcez2OM?=
 =?us-ascii?Q?dzlvft8kQFCNTff6CUCshfW+gNE38wFUC+oiqYScMd1TurUFusgaW/gIMAjE?=
 =?us-ascii?Q?TSFedGzxcSdXtLNpPnitW8zDv/3WoSBS0MlhnwlH1dTxNHAr0nHNL7Rh6UOS?=
 =?us-ascii?Q?xJ+x7TpBKd8E0MvN2kJJPmzRKlvc2L5Wm3Mmm0BkD5WN0bMNCK6vIyO64j5L?=
 =?us-ascii?Q?h1T/BdTkRsz0Dn0g4TgppiOr2SnZJuturq7SMNwQTpqDxo/ycCjONR6iP2Zc?=
 =?us-ascii?Q?IuXPhdltJzwx2hZrYipHfc12M8VI8y01Z2Lxcfli1n+Us7Po0PotXWms7mGf?=
 =?us-ascii?Q?teRXzNLO6jtjDE3HjsHmMdYjecVGpQx+LF+XT9QIjfgaVyy9vGMdTe3tJ4WW?=
 =?us-ascii?Q?39o7H/vAQVMwT8DXU8XQDARKKYvdmpwHGnMRzlnV7/IG07LNmC6dT8rQHu9g?=
 =?us-ascii?Q?LIM33Hh5FUjF0NKjqcADQd2P/cSvaNnjTH6C//dNMKWu9lCCVOR2f+NrBMaM?=
 =?us-ascii?Q?hEfcpw8VouQhgraMFwH2ZIsDsrv1KYk/VIbU63RQLb5PazrAPVWsbJS44IMr?=
 =?us-ascii?Q?JFUQvocqPcwCBN/izxIWZNytDeqhgNgLkZ8E3jROpOmIyT9zgmkmbBHNmzA6?=
 =?us-ascii?Q?Ktoz/gE0DU6j8YKwff5OVL4u7IUI49kdk2QSEjEdF3dd7MdiZVvitMEjIwUl?=
 =?us-ascii?Q?E6xSVhkSTP4bUk/EAtDdHjxpsAj43pqs2C7O15KdHtsaRBpcFMt5Dva5QD+i?=
 =?us-ascii?Q?4yoGWn455O61lIUNzNmAXYsq61WqVLTgIJVmqmaZB+FBDVVj3ewMd/m4Izam?=
 =?us-ascii?Q?Y/30PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf130b2-dbe4-4316-4451-08d9c8fc8433
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2021 05:48:32.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bItrjk+7uMsbmQ6xntLcwQD9G6stCVWKLPD9SXREQ+zwz9/SZ8TFDj5LaM6oEHmNXYTGTxxQ//w7KiaoMem0+fyIrwksBhK+sdaI0ewPApo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2173
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10209 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270030
X-Proofpoint-GUID: dn_AicLurMVTjrZkRFj_rTdj3a3vx_rw
X-Proofpoint-ORIG-GUID: dn_AicLurMVTjrZkRFj_rTdj3a3vx_rw
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Cheng Xu <chengyou@linux.alibaba.com>
> Sent: Friday, December 24, 2021 12:25 PM
> To: leon@kernel.org
> Cc: dledford@redhat.com; jgg@mellanox.com; linux-rdma@vger.kernel.org;
> KaiShen@linux.alibaba.com; chengyou@linux.alibaba.com
> Subject: [PATCH rdma-core 1/5] RDMA-CORE/erdma: Add userspace verbs
> related header files.
>=20
> Add the userspace verbs implementation related header files: 'erdma_hw.h'
> for hardware interface definitions, 'erdma_verbs.h' for verbs related
> definitions and 'erdma_db.h' for doorbell records related definitions.
>=20
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  providers/erdma/erdma_db.h    |  17 +++
>  providers/erdma/erdma_hw.h    | 206
> ++++++++++++++++++++++++++++++++++
>  providers/erdma/erdma_verbs.h | 134 ++++++++++++++++++++++
>  3 files changed, 357 insertions(+)
>  create mode 100644 providers/erdma/erdma_db.h  create mode 100644
> providers/erdma/erdma_hw.h  create mode 100644
> providers/erdma/erdma_verbs.h
>=20
> diff --git a/providers/erdma/erdma_db.h b/providers/erdma/erdma_db.h
> new file mode 100644 index 00000000..c302cb7a
> --- /dev/null
> +++ b/providers/erdma/erdma_db.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 or OpenIB.org BSD (MIT) See COPYING
> +file */
> +/*
> + * Authors: Cheng Xu <chengyou@linux.alibaba.com>
> + * Copyright (c) 2020-2021, Alibaba Group.
> + */
> +
> +#ifndef __ERDMA_DB_H__
> +#define __ERDMA_DB_H__
> +
> +#include <inttypes.h>
> +
> +#include "erdma.h"
> +
> +uint64_t *erdma_alloc_dbrecords(struct erdma_context *ctx); void
> +erdma_dealloc_dbrecords(struct erdma_context *ctx, uint64_t
> +*dbrecords);
> +
> +#endif
> diff --git a/providers/erdma/erdma_hw.h b/providers/erdma/erdma_hw.h
> new file mode 100644 index 00000000..f373f7f8
> --- /dev/null
> +++ b/providers/erdma/erdma_hw.h
> @@ -0,0 +1,206 @@
> +/* SPDX-License-Identifier: GPL-2.0 or OpenIB.org BSD (MIT) See COPYING
> +file */
> +/*
> + * Authors: Cheng Xu <chengyou@linux.alibaba.com>
> + * Copyright (c) 2020-2021, Alibaba Group.
> + */
> +
> +#ifndef __ERDMA_HW_H__
> +#define __ERDMA_HW_H__
> +
> +#include <stdint.h>
> +
> +#define ERDMA_SDB_PAGE     0
> +#define ERDMA_SDB_ENTRY    1
> +#define ERDMA_SDB_SHARED   2
> +
> +#define ERDMA_SQDB_SIZE 128
> +#define ERDMA_CQDB_SIZE 8
> +#define ERDMA_RQDB_SIZE 8
> +#define ERDMA_RQDB_SPACE_SIZE   32
> +
> +/* WQE related. */
> +#define EQE_SIZE 16
> +#define EQE_SHIFT 4
> +#define RQE_SIZE 32
> +#define RQE_SHIFT 5
> +#define CQE_SIZE 32
> +#define CQE_SHIFT 5
> +#define SQEBB_SIZE 32
> +#define SQEBB_SHIFT 5
> +#define SQEBB_MASK (~(SQEBB_SIZE - 1))
> +#define SQEBB_ALIGN(size) ((size + SQEBB_SIZE - 1) & SQEBB_MASK)
> +#define SQEBB_COUNT(size) (SQEBB_ALIGN(size) >> SQEBB_SHIFT)
> +
> +#define MAX_WQEBB_PER_SQE 4
> +
> +enum erdma_opcode {
> +	ERDMA_OP_WRITE           =3D 0,
> +	ERDMA_OP_READ            =3D 1,
> +	ERDMA_OP_SEND            =3D 2,
> +	ERDMA_OP_SEND_WITH_IMM   =3D 3,
> +
> +	ERDMA_OP_RECEIVE         =3D 4,
> +	ERDMA_OP_RECV_IMM        =3D 5,
> +	ERDMA_OP_RECV_INV        =3D 6,
> +
> +	ERDMA_OP_REQ_ERR         =3D 7,
> +	ERDNA_OP_READ_RESPONSE   =3D 8,
> +	ERDMA_OP_WRITE_WITH_IMM  =3D 9,
> +
> +	ERDMA_OP_RECV_ERR        =3D 10,
> +
> +	ERDMA_OP_INVALIDATE     =3D 11,
> +	ERDMA_OP_RSP_SEND_IMM   =3D 12,
> +	ERDMA_OP_SEND_WITH_INV  =3D 13,
> +
> +	ERDMA_OP_REG_MR         =3D 14,
> +	ERDMA_OP_LOCAL_INV      =3D 15,
> +	ERDMA_OP_READ_WITH_INV  =3D 16,
> +	ERDMA_NUM_OPCODES       =3D 17,
> +	ERDMA_OP_INVALID        =3D ERDMA_NUM_OPCODES + 1
> +};
> +
> +/*
> + * Inline data are kept within the work request itself occupying
> + * the space of sge[1] .. sge[n]. Therefore, inline data cannot be
> + * supported if ERDMA_MAX_SGE is below 2 elements.
> + */
> +#define ERDMA_MAX_INLINE	(sizeof(struct erdma_sge) *
> (ERDMA_MAX_SEND_SGE))
> +
> +enum erdma_wc_status {
> +	ERDMA_WC_SUCCESS =3D 0,
> +	ERDMA_WC_GENERAL_ERR =3D 1,
> +	ERDMA_WC_RECV_WQE_FORMAT_ERR =3D 2,
> +	ERDMA_WC_RECV_STAG_INVALID_ERR =3D 3,
> +	ERDMA_WC_RECV_ADDR_VIOLATION_ERR =3D 4,
> +	ERDMA_WC_RECV_RIGHT_VIOLATION_ERR =3D 5,
> +	ERDMA_WC_RECV_PDID_ERR =3D 6,
> +	ERDMA_WC_RECV_WARRPING_ERR =3D 7,
> +	ERDMA_WC_SEND_WQE_FORMAT_ERR =3D 8,
> +	ERDMA_WC_SEND_WQE_ORD_EXCEED =3D 9,
> +	ERDMA_WC_SEND_STAG_INVALID_ERR =3D 10,
> +	ERDMA_WC_SEND_ADDR_VIOLATION_ERR =3D 11,
> +	ERDMA_WC_SEND_RIGHT_VIOLATION_ERR =3D 12,
> +	ERDMA_WC_SEND_PDID_ERR =3D 13,
> +	ERDMA_WC_SEND_WARRPING_ERR =3D 14,
> +	ERDMA_WC_FLUSH_ERR =3D 15,
> +	ERDMA_WC_RETRY_EXC_ERR =3D 16,
> +	ERDMA_NUM_WC_STATUS
> +};
> +
> +enum erdma_vendor_err {
> +	ERDMA_WC_VENDOR_NO_ERR =3D 0,
> +	ERDMA_WC_VENDOR_INVALID_RQE =3D 1,
> +	ERDMA_WC_VENDOR_RQE_INVALID_STAG =3D 2,
> +	ERDMA_WC_VENDOR_RQE_ADDR_VIOLATION =3D 3,
> +	ERDMA_WC_VENDOR_RQE_ACCESS_RIGHT_ERR =3D 4,
> +	ERDMA_WC_VENDOR_RQE_INVALID_PD =3D 5,
> +	ERDMA_WC_VENDOR_RQE_WRAP_ERR =3D 6,
> +	ERDMA_WC_VENDOR_INVALID_SQE =3D 0x20,
> +	ERDMA_WC_VENDOR_ZERO_ORD =3D 0x21,
> +	ERDMA_WC_VENDOR_SQE_INVALID_STAG =3D 0x30,
> +	ERDMA_WC_VENDOR_SQE_ADDR_VIOLATION =3D 0x31,
> +	ERDMA_WC_VENDOR_SQE_ACCESS_ERR =3D 0x32,
> +	ERDMA_WC_VENDOR_SQE_INVALID_PD =3D 0x33,
> +	ERDMA_WC_VENDOR_SQE_WARP_ERR =3D 0x34
> +};
> +
> +
> +/* Doorbell related. */
> +#define ERDMA_CQDB_EQN_MASK              GENMASK_ULL(63, 56)
> +#define ERDMA_CQDB_CQN_MASK              GENMASK_ULL(55, 32)
> +#define ERDMA_CQDB_ARM_MASK              BIT_ULL(31)
> +#define ERDMA_CQDB_SOL_MASK              BIT_ULL(30)
> +#define ERDMA_CQDB_CMDSN_MASK            GENMASK_ULL(29, 28)
> +#define ERDMA_CQDB_CI_MASK               GENMASK_ULL(23, 0)
> +
> +#define ERDMA_CQE_QTYPE_SQ    0
> +#define ERDMA_CQE_QTYPE_RQ    1
> +#define ERDMA_CQE_QTYPE_CMDQ  2
> +
> +/* CQE hdr */
> +#define ERDMA_CQE_HDR_OWNER_MASK         BIT(31)
> +#define ERDMA_CQE_HDR_OPCODE_MASK        GENMASK(23, 16)
> +#define ERDMA_CQE_HDR_QTYPE_MASK         GENMASK(15, 8)
> +#define ERDMA_CQE_HDR_SYNDROME_MASK      GENMASK(7, 0)
> +
> +#define ERDMA_CQE_QTYPE_SQ    0
> +#define ERDMA_CQE_QTYPE_RQ    1
> +#define ERDMA_CQE_QTYPE_CMDQ  2
> +
> +
> +struct erdma_cqe {
> +	__be32 hdr;
> +	__be32 qe_idx;
> +	__be32 qpn;
> +	__le32 imm_data;
> +	__be32 size;
> +	__be32 rsvd[3];
> +};
> +
> +struct erdma_sge {
> +	__aligned_le64 laddr;
> +	__le32 length;
> +	__le32 lkey;
> +};
> +
> +/* Receive Queue Element */
> +struct erdma_rqe {
> +	__le16 qe_idx;
> +	__le16 rsvd;
> +	__le32 qpn;
> +	__le32 rsvd2;
> +	__le32 rsvd3;
> +	__le64 to;
> +	__le32 length;
> +	__le32 stag;
> +};
> +
> +/* SQE */
> +#define ERDMA_SQE_HDR_SGL_LEN_MASK       GENMASK_ULL(63, 56)
> +#define ERDMA_SQE_HDR_WQEBB_CNT_MASK     GENMASK_ULL(54, 52)
> +#define ERDMA_SQE_HDR_QPN_MASK           GENMASK_ULL(51, 32)
> +#define ERDMA_SQE_HDR_OPCODE_MASK        GENMASK_ULL(31, 27)
> +#define ERDMA_SQE_HDR_DWQE_MASK          BIT_ULL(26)
> +#define ERDMA_SQE_HDR_INLINE_MASK        BIT_ULL(25)
> +#define ERDMA_SQE_HDR_FENCE_MASK         BIT_ULL(24)
> +#define ERDMA_SQE_HDR_SE_MASK            BIT_ULL(23)
> +#define ERDMA_SQE_HDR_CE_MASK            BIT_ULL(22)
> +#define ERDMA_SQE_HDR_WQEBB_INDEX_MASK   GENMASK_ULL(15, 0)
> +
> +struct erdma_write_sqe {
> +	__le64 hdr;
> +	__be32 imm_data;
> +	__le32 length;
> +
> +	__le32 sink_stag;
> +	/* avoid sink_to not 8-byte aligned. */
> +	__le32 sink_to_low;
> +	__le32 sink_to_high;
> +
> +	__le32 rsvd;
> +
> +	struct erdma_sge sgl[0];
> +};
> +
> +struct erdma_send_sqe {
> +	__le64 hdr;
> +	__be32 imm_data;
> +	__le32 length;
> +	struct erdma_sge sgl[0];
> +};
> +
> +struct erdma_readreq_sqe {
> +	__le64 hdr;
> +	__le32 invalid_stag;
> +	__le32 length;
> +	__le32 sink_stag;
> +	/* avoid sink_to not 8-byte aligned. */
> +	__le32 sink_to_low;
> +	__le32 sink_to_high;
> +	__le32 rsvd0;
> +	struct erdma_sge sgl;
> +};
> +
> +
> +#endif
> diff --git a/providers/erdma/erdma_verbs.h
> b/providers/erdma/erdma_verbs.h new file mode 100644 index
> 00000000..944d29f5
> --- /dev/null
> +++ b/providers/erdma/erdma_verbs.h
> @@ -0,0 +1,134 @@
> +/* SPDX-License-Identifier: GPL-2.0 or OpenIB.org BSD (MIT) See COPYING
> +file */
> +/*
> + * Authors: Cheng Xu <chengyou@linux.alibaba.com>
> + * Copyright (c) 2020-2021, Alibaba Group.
> + */
> +
> +#ifndef __ERDMA_VERBS_H__
> +#define __ERDMA_VERBS_H__
> +
> +#include <pthread.h>
> +#include <inttypes.h>
> +#include <stddef.h>
> +
> +#include "erdma.h"
> +#include "erdma_hw.h"
> +
> +#define ERDMA_MAX_SEND_SGE 6
> +#define ERDMA_MAX_RECV_SGE 1
> +
> +struct erdma_queue {
> +	void *qbuf;
> +	void *db;
> +
> +	uint16_t rsvd0;
> +	uint16_t depth;
> +	uint32_t size;
> +
> +	uint16_t pi;
> +	uint16_t ci;
> +
> +	uint32_t rsvd1;
> +	uint64_t *wr_tbl;
> +
> +	void *db_record;
> +};
> +
> +struct erdma_qp {
> +	struct ibv_qp base_qp;
> +	struct erdma_device *erdma_dev;
> +
> +	uint32_t id;  /* qpn */
> +
> +	pthread_spinlock_t sq_lock;
> +	pthread_spinlock_t rq_lock;
> +
> +	int sq_sig_all;
> +
> +	struct erdma_queue sq;
> +	struct erdma_queue rq;
> +
> +	void *qbuf;
> +	uint64_t *db_records;
> +};
> +
> +struct erdma_cq {
> +	struct ibv_cq base_cq;
> +	struct erdma_device *erdma_dev;
> +	uint32_t id;
> +
> +	uint32_t event_stats;
> +
> +	uint32_t depth;
> +	uint32_t ci;
> +	uint32_t owner;
> +	struct erdma_cqe *queue;
> +
> +	void *db;
> +	uint16_t db_offset;
> +
> +	void *db_record;
> +	uint32_t cmdsn;
> +	int comp_vector;
> +
> +	pthread_spinlock_t lock;
> +};
> +
> +static inline struct erdma_qp *to_eqp(struct ibv_qp *base) {
> +	return container_of(base, struct erdma_qp, base_qp); }
> +
> +static inline struct erdma_cq *to_ecq(struct ibv_cq *base) {
> +	return container_of(base, struct erdma_cq, base_cq); }
> +
> +static inline void *get_sq_wqebb(struct erdma_qp *qp, uint16_t idx) {
> +	idx &=3D (qp->sq.depth - 1);
> +	return qp->sq.qbuf + (idx << SQEBB_SHIFT); }
> +
> +static inline void __kick_sq_db(struct erdma_qp *qp, uint16_t pi) {
> +	uint64_t db_data;
> +
> +	db_data =3D FIELD_PREP(ERDMA_SQE_HDR_QPN_MASK, qp->id) |
> +		FIELD_PREP(ERDMA_SQE_HDR_WQEBB_INDEX_MASK, pi);
> +
> +	*(__le64 *)qp->sq.db_record =3D htole64(db_data);
> +	udma_to_device_barrier();
> +	mmio_write64_le(qp->sq.db, htole64(db_data)); }
Standard function definition format
Func ()
{

}
Update all over the place.
> +
> +struct ibv_pd *erdma_alloc_pd(struct ibv_context *ctx); int
> +erdma_free_pd(struct ibv_pd *pd);
> +
> +int erdma_query_device(struct ibv_context *ctx,
> +		       const struct ibv_query_device_ex_input *input,
> +		       struct ibv_device_attr_ex *attr, size_t attr_size); int
> +erdma_query_port(struct ibv_context *ctx, uint8_t port, struct
> +ibv_port_attr *attr);
> +
> +struct ibv_mr *erdma_reg_mr(struct ibv_pd *pd, void *addr, size_t len,
> +			    uint64_t hca_va, int access);
> +int erdma_dereg_mr(struct verbs_mr *vmr);
> +
> +struct ibv_qp *erdma_create_qp(struct ibv_pd *pd, struct
> +ibv_qp_init_attr *attr); int erdma_modify_qp(struct ibv_qp *base_qp,
> +struct ibv_qp_attr *attr, int attr_mask); int erdma_query_qp(struct ibv_=
qp
> *qp, struct ibv_qp_attr *attr,
> +		   int attr_mask, struct ibv_qp_init_attr *init_attr); int
> +erdma_post_send(struct ibv_qp *base_qp, struct ibv_send_wr *wr, struct
> +ibv_send_wr **bad_wr); int erdma_post_recv(struct ibv_qp *base_qp,
> +struct ibv_recv_wr *wr, struct ibv_recv_wr **bad_wr); int
> +erdma_destroy_qp(struct ibv_qp *base_qp);
> +
> +void erdma_free_context(struct ibv_context *ibv_ctx);
> +
> +struct ibv_cq *erdma_create_cq(struct ibv_context *ctx, int num_cqe,
> +			       struct ibv_comp_channel *channel, int
> comp_vector); int
> +erdma_destroy_cq(struct ibv_cq *base_cq); int erdma_notify_cq(struct
> +ibv_cq *ibcq, int solicited); void erdma_cq_event(struct ibv_cq *ibcq);
> +int erdma_poll_cq(struct ibv_cq *ibcq, int num_entries, struct ibv_wc
> +*wc);
> +
> +#endif
> --
> 2.27.0

