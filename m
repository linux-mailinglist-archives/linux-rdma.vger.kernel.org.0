Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266A347FA87
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Dec 2021 07:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhL0GaO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Dec 2021 01:30:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24428 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235318AbhL0GaN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Dec 2021 01:30:13 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BR6GKLt027134;
        Mon, 27 Dec 2021 06:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PQ/81KuKNc5kaVE0T5G6b7EMZIeaCeeptX8eMjogLSU=;
 b=W65Uaa7wGSin1DWErXQSg0M8AwpwP5V+KVew4Q/4QBCsJ3KwcoXZNFbq5BIRla5k5kXh
 /ThUiZBpPzmVFCnc2/qJscjEJfzphouI825ZKB/JgmEnnoQPHLI3TK2ibnOfXsPVgtTA
 /VxSqP0JbWZu4F4aUOnKJofGcallViRWx+jplEZWxIfbcrDT5zxFGzUIr2k1nqgkMbQT
 jljBAFHSHvIpgKIg6dvViERcUTrV2FnY8CocatTWj/KjWVj5wV3aT50Fnpx9U6comNhp
 VUY08QPYKjKlyf3UPWfcuMOnGaYEyxcawflU2SwhhFl2XR/nWF6C/SItYIrM1OzXYK5U 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d5t34296u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 06:30:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BR6QkdG082063;
        Mon, 27 Dec 2021 06:30:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3020.oracle.com with ESMTP id 3d5vrke590-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 06:29:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li/0iHfsV0PkIh9yYzwtOfxqWwy8WpK4KYjE1jyJL0d/aU9x9wqGyyTDKZ0aDWaXoUsT2sMh6BCrxTZk9GOoDcUItOSwe7gOPBEs0Dfc1hE6GvNCXdorvwk5zEk2WExSrRMvSLRNtncaP0WmAdQxtrat0nhpVCHhw8rDgEXaJPokTf4RF9Y2d5a2gQj54bV70tkPLqiuzHCYfOCR8yC9a5/x/eQ00h1kQm8DE8MAFMCaBszSDmq53iEoHl5woZgvUM5yR15YoM3Z2k04dAT2VmKnS9XQICDtpDp1Y0NVtgfSdqyTS7xhSKDLVm/lfL4hjR2aDN2sJAC85hSJX8Ob4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ/81KuKNc5kaVE0T5G6b7EMZIeaCeeptX8eMjogLSU=;
 b=PWfPIJXrUDqbFC1/1QUdh7JwyJFBFT+vcwKCqRBt5IRcyrbskLvGZs87fYG6ZFOxrlb0pTAtDMqfsyq+frkOcsNZDBTuavDRi0EpynRusGCb6EMFcrFBdX9v6BlUH0CAnO+H6o3fSxrIuWB5Aq7Cl+BeoBua/wSZRKMAz+0+f9JmKu/Gs94cd7OU+AWFI4dMb6eqikpk+5tW3rZmJPpbvvrPKCPBt18zkdX/Bz34lOUegXP37/p/TXL7cbqR14xFJml61PdAcyyGWew+yzapyIt0jQnYZOsV1kefd0C59ZlMj0ZJ2NA52oT5LuPyfATCVLFteAdrv8fgcY/Gzd33RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ/81KuKNc5kaVE0T5G6b7EMZIeaCeeptX8eMjogLSU=;
 b=K/XbF4uREMwGamr6v6hysxiWetFNeiH8CgWObRrCq9JzZDOXlwy67H8v/6H6C9a6Bc0c4PptR69o/NeisD11Myqd2TaCVTqr3cge/9vN7MV95FSGgWOomqiHvXFBkDYQwLL76JNvsFJevxBXVaBbZ9fSMKrrqsHq6LhWlffw6Sg=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MWHPR10MB1694.namprd10.prod.outlook.com (2603:10b6:301:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Mon, 27 Dec
 2021 06:29:56 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee%9]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 06:29:56 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>
Subject: RE: [PATCH rdma-core 2/5] RDMA-CORE/erdma: Add userspace verbs
 implementation
Thread-Topic: [PATCH rdma-core 2/5] RDMA-CORE/erdma: Add userspace verbs
 implementation
Thread-Index: AQHX+JM/1KpJ5/yNK0q8nMehgQ91GKxF4HyA
Date:   Mon, 27 Dec 2021 06:29:56 +0000
Message-ID: <CO6PR10MB5635B8902D89993CF61EA989DD429@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <20211224065522.29734-1-chengyou@linux.alibaba.com>
 <20211224065522.29734-3-chengyou@linux.alibaba.com>
In-Reply-To: <20211224065522.29734-3-chengyou@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e22e990e-51e9-4f52-0d56-08d9c9024d0e
x-ms-traffictypediagnostic: MWHPR10MB1694:EE_
x-microsoft-antispam-prvs: <MWHPR10MB16944DBF90643ECA44F64A90DD429@MWHPR10MB1694.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixKZinYF/0ITvEL23s7zD+/3JbOFGde0eW7kPi+tVZmHW7vtGpIXtGWqFv93bRSIG2k/7Qr5mbWATuTAaOA9RJBLk2zpecm1PdJuWgpQuSEh25YCqwHBeXfGLcy4KzzXM7MqYwh6SomUFJjWoEf8GglMQgX9Zj6b3dO36iuilifx8QdtfJ4kZt6emiD/LFos0IH3ErjOF0AEhfTc/EbaMdu7ooJX9gdF+GcHfPlELD22JciFokAjpBCy/5woiOb4B4TZGkEyCk/5lKr31RreBxFSoEg8gU7pSgYDE47YKueVN1QGhEa3JlLeeLal8K65mZuR3ytZS89m4uyMj68MaNFPqk5W2ChJ3lKxyYAegzGvdyHUhzYvBN3Mo/LE0xHYPxYyooEGQPj/AsRFvoHyK8X3/tKXUifdD1zE/cdSa54lcmzSIbp8KX+NPUEBOfWfG2A+fOBkWbfRDc9YWyX/8F8o8spv/yGivi+T57ZK4lpye6lN1TbJ5rfcaoII3nT/5p23aHdVU307C8hOExxIhyYSeZqNcwhV/T97tClY0ClKIdPAFg1q59OJ6LanbmyRLUFpNs5MekL5ueZuueNkiW6HukWPhHkUoPmMjD4iIeYLB5MjBYD0qzxBguFW0zfatgiSUupPH6XJ3Sg99QH7i/0Uw+Z1aNgruePvIHOpyyFyJQFpk8G2/apX5h6hSBy21iQ0cwOmUJMePTEuClGMBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(5660300002)(38070700005)(53546011)(66476007)(8676002)(55236004)(7696005)(86362001)(6506007)(38100700002)(122000001)(33656002)(8936002)(26005)(186003)(64756008)(66446008)(52536014)(316002)(83380400001)(66556008)(66946007)(2906002)(55016003)(9686003)(4326008)(30864003)(54906003)(71200400001)(110136005)(76116006)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rh8jLB6PZBhYoa9gEgxAl5zVnOeCIqEMXEDxDmt4N95HNbrkLpfcfZJ3TOqG?=
 =?us-ascii?Q?oQoxZmA8SdBIVw4WV3FEyP0yRvvDePsNdQhmzxdcQQf1jthn0MAlk/MXIkur?=
 =?us-ascii?Q?IAzUrX952wCJncpTXwepa8pkEPSrvnvT2qzJPbpKEgtCEyAbuEdC97ttYjyf?=
 =?us-ascii?Q?DSwANP/MaxBvLPrf/n0ZIExTMFWqHYqPAemY/iw8zD0P5kD50Kf31QWsMLlm?=
 =?us-ascii?Q?Laoktz/EQJqFgVDEjd1a6IPTkwNEnzs6nzImFrRmyFOPypqQQDJ0S5wkns8t?=
 =?us-ascii?Q?U9asCQwfcgvFVyU5Se3by/AvyT2LRXo+CHuNCe9A7UuLhYtsHP5BvDcQqv/J?=
 =?us-ascii?Q?apLQuTnBu9oegaoLYS4p3yEGwPaK7gV5T+tFsYmxKHQ06KiDXlSOVhFMIRTw?=
 =?us-ascii?Q?Ru9vPPk2npzQh6xZaw5n28iW6kgrf4O6DAabzz06DBrrCbYldO0Xa6d0WU05?=
 =?us-ascii?Q?/WL3L/diSU0ovWM3o3NdQly70GzABH/NzFKW+qAy7BvkKhWD5MD97iWDzd2E?=
 =?us-ascii?Q?W7nYLAQplouD52FZnO83PNsbi1D0mdejMlJ+p+WFpY3BIxZ+d6cbG4FMBYjN?=
 =?us-ascii?Q?OtZ4xz5NLwyL1IQgHH2c22DEuYJRxNqHdkppeLAXhjt1wKRaBSheL1+MmRUb?=
 =?us-ascii?Q?/MiUkUCfF9rr/xI00SlsPJOZ1vKzWUztX9cYH8jlH70kLwTbSTnrm1AfnbVe?=
 =?us-ascii?Q?E1mRjsS5zxpZqmxuf2Y9hKzUPOuO4yLy898iCjW09NU/ehvBcXsyIpcXLn/2?=
 =?us-ascii?Q?qKCPBfi3Q3HKZ+dsAIinKM9hCvOH0GSJowow9KXfSuxGh8lPfw7Fc9Zqw7qe?=
 =?us-ascii?Q?cN1aJZdTP5UdFxxoKowcpEVt9V6gQiBpOeC5UkGSGRsGKtNoYo7D0e0DPgoe?=
 =?us-ascii?Q?dmbWXCRxRBlD6PbUbLDM6FaEU/vyKCde/+mCkW9CO3ekN8/w8N3/F3XT/YMF?=
 =?us-ascii?Q?TcTs0kVPiP87FitZrJJw2hs3mMPOg1mu3qjnQySMIyrBo4pClcwu6BIL0Ik+?=
 =?us-ascii?Q?Lf4umiR4P7xd2blI6c8NCNY95VCc8q1VCA6f6fVnbirRbB/llIYKEE7gw+XR?=
 =?us-ascii?Q?eQqVCN8YrZ2Y88EtuPf4zmg66zUTIpR6S9B3axm/AygjUz7wc0PMNz3Anh26?=
 =?us-ascii?Q?uffxF1TBgRqMZNL1sdq/MaFlf8WLVhsY5FS0c54mpn08GNtKvQCgiK2E8LKo?=
 =?us-ascii?Q?QkhMQApG+ijaZfRd3y0eMl7EBxa/VSsrqxMFvn3Jq0y9t87VsdJ8p3IVrgGh?=
 =?us-ascii?Q?tRfgFh7gqsW/PpM+kXkQc0mVrdTQCSaJdYrGqrP2XBzWOrHZjnnKj4tdOD9J?=
 =?us-ascii?Q?zuj2GlwehNJumeNsHsRSdS9sO0XjnaWKZaUn4gvkzo8wbBIY/rdlgdQaGqZX?=
 =?us-ascii?Q?fndpKkUuXrPwm5AdO0RyjNL4WZxajggOiR1LAUkOVHylTJ4SnQdvq05F5VGf?=
 =?us-ascii?Q?qEdFNWTExDOWYm77htfSr4Cf7ebVcNW5khuKwSoVYcJTvUjrWmNPFPdPjT6u?=
 =?us-ascii?Q?jOS89HSm5CMArxJ8o9yBXrSzupRSPZ3CpZmfZPlzUeSu66X2ncYB6LzuLNGk?=
 =?us-ascii?Q?NMiebLHw5k+2mIS+zz+dRI3EADeXYvw7xA25W2osp9KFa8/IWiwauvkBpHGn?=
 =?us-ascii?Q?pmsJwPpoYBOcXCABAAzXOj5D0QKOKj91ExKEw3pmDQ2gYs9O7slzRC3n1nvT?=
 =?us-ascii?Q?Vh/UoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22e990e-51e9-4f52-0d56-08d9c9024d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2021 06:29:56.8524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPlHfIzgjVaDdJ8PlKOpcGGi4HB2d59Q07wcnMn87iFNBzWH/ZMrK3kzw6R0QUNTG7Vzp18nZjQPqioIA8SQBLx0FTqkcQH+yCOg0/QIHaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1694
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10209 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112270033
X-Proofpoint-GUID: L618EcXAgEoNaLvNiXCuZuPh7DXDKtNh
X-Proofpoint-ORIG-GUID: L618EcXAgEoNaLvNiXCuZuPh7DXDKtNh
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Cheng Xu <chengyou@linux.alibaba.com>
> Sent: Friday, December 24, 2021 12:25 PM
> To: leon@kernel.org
> Cc: dledford@redhat.com; jgg@mellanox.com; linux-rdma@vger.kernel.org;
> KaiShen@linux.alibaba.com; chengyou@linux.alibaba.com
> Subject: [PATCH rdma-core 2/5] RDMA-CORE/erdma: Add userspace verbs
> implementation
>=20
> Imlementation of the erdma's 'struct verbs_context_ops' interface.
> Due to doorbells may be drop by hardware in some situations, such as
> hardware hot-upgrade, driver will keep the latest doorbell value of each =
QP
> and CQ. We introduce the doorbell records to store the latest doorbell
> values, and its allocation mechanism comes from dbre.c of mlx5.
>=20
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  providers/erdma/erdma_db.c    | 110 ++++
>  providers/erdma/erdma_verbs.c | 934
> ++++++++++++++++++++++++++++++++++
>  2 files changed, 1044 insertions(+)
>  create mode 100644 providers/erdma/erdma_db.c  create mode 100644
> providers/erdma/erdma_verbs.c
>=20
> diff --git a/providers/erdma/erdma_db.c b/providers/erdma/erdma_db.c
> new file mode 100644 index 00000000..83db76d1
> --- /dev/null
> +++ b/providers/erdma/erdma_db.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0 or OpenIB.org BSD (MIT) See COPYING
> +file
> +
> +// Authors: Cheng Xu <chengyou@linux.alibaba.com> // Copyright (c)
> +2020-2021, Alibaba Group.
> +
> +// Copyright (c) 2012 Mellanox Technologies, Inc.  All rights reserved.
> +
> +#include <inttypes.h>
> +#include <stdlib.h>
> +#include <util/util.h>
> +
> +#include "erdma.h"
> +#include "erdma_db.h"
> +
> +#define ERDMA_DBRECORDS_SIZE 16
> +
> +struct erdma_dbrecord_page {
> +	struct erdma_dbrecord_page *prev, *next;
> +	void *page_buf;
> +	int cnt;
> +	int used;
> +	unsigned long free[0];
> +};
> +
> +uint64_t *erdma_alloc_dbrecords(struct erdma_context *ctx) {
> +	struct erdma_dbrecord_page *page =3D NULL;
> +	uint64_t *db_records =3D NULL;
> +	int dbrecords_per_page, nlongs =3D 0, bits_perlong =3D (8 *
> sizeof(unsigned long));
> +	int i, j, rv;
> +
> +	pthread_mutex_lock(&ctx->dbrecord_pages_mutex);
> +
> +	for (page =3D ctx->dbrecord_pages; page; page =3D page->next)
> +		if (page->used < page->cnt)
> +			goto found;
> +
> +	dbrecords_per_page =3D ctx->page_size / ERDMA_DBRECORDS_SIZE;
> +	nlongs =3D align(dbrecords_per_page, bits_perlong) / bits_perlong;
> +	page =3D malloc(sizeof(*page) + nlongs * sizeof(unsigned long));
> +	if (!page)
> +		goto out;
> +
> +	rv =3D posix_memalign(&page->page_buf, ctx->page_size, ctx-
> >page_size);
> +	if (rv) {
> +		free(page);
> +		goto out;
> +	}
> +
> +	page->cnt =3D dbrecords_per_page;
> +	page->used =3D 0;
> +	for (i =3D 0; i < nlongs; i++)
> +		page->free[i] =3D ~0UL;
> +
> +	page->prev =3D NULL;
> +	page->next =3D ctx->dbrecord_pages;
> +	ctx->dbrecord_pages =3D page;
> +	if (page->next)
> +		page->next->prev =3D page;
> +
> +found:
> +	++page->used;
> +
> +	for (i =3D 0; !page->free[i]; ++i)
> +		;/* nothing */
Why?
> +
> +	j =3D ffsl(page->free[i]) - 1;
> +	page->free[i] &=3D ~(1UL << j);
> +
> +	db_records =3D page->page_buf + (i * bits_perlong + j) *
> +ERDMA_DBRECORDS_SIZE;
> +
> +out:
> +	pthread_mutex_unlock(&ctx->dbrecord_pages_mutex);
> +
> +	return db_records;
> +}
> +
> +void erdma_dealloc_dbrecords(struct erdma_context *ctx, uint64_t
> +*dbrecords) {
> +	struct erdma_dbrecord_page *page;
> +	int page_mask =3D ~(ctx->page_size - 1);
> +	int idx;
> +
> +	pthread_mutex_lock(&ctx->dbrecord_pages_mutex);
> +	for (page =3D ctx->dbrecord_pages; page; page =3D page->next)
> +		if (((uintptr_t)dbrecords & page_mask) =3D=3D (uintptr_t)page-
> >page_buf)
> +			break;
> +
> +	if (!page)
> +		goto out;
> +
> +	idx =3D ((void *)dbrecords - page->page_buf) /
> ERDMA_DBRECORDS_SIZE;
> +	page->free[idx / (8 * sizeof(unsigned long))] |=3D
> +		1UL << (idx % (8 * sizeof(unsigned long)));
> +
> +	if (!--page->used) {
> +		if (page->prev)
> +			page->prev->next =3D page->next;
> +		else
> +			ctx->dbrecord_pages =3D page->next;
> +		if (page->next)
> +			page->next->prev =3D page->prev;
> +
> +		free(page->page_buf);
> +		free(page);
> +	}
> +
> +out:
> +	pthread_mutex_unlock(&ctx->dbrecord_pages_mutex);
> +}
> diff --git a/providers/erdma/erdma_verbs.c
> b/providers/erdma/erdma_verbs.c new file mode 100644 index
> 00000000..3c1c9769
> --- /dev/null
> +++ b/providers/erdma/erdma_verbs.c
> @@ -0,0 +1,934 @@
> +// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
> +
> +// Authors: Cheng Xu <chengyou@linux.alibaba.com> // Copyright (c)
> +2020-2021, Alibaba Group.
> +// Authors: Bernard Metzler <bmt@zurich.ibm.com> // Copyright (c)
> +2008-2019, IBM Corporation
> +
> +#include <ccan/minmax.h>
> +#include <endian.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <util/mmio.h>
> +#include <util/udma_barrier.h>
> +#include <util/util.h>
> +
> +#include "erdma.h"
> +#include "erdma_abi.h"
> +#include "erdma_db.h"
> +#include "erdma_hw.h"
> +#include "erdma_verbs.h"
> +
> +int erdma_query_device(struct ibv_context *ctx,
> +		       const struct ibv_query_device_ex_input *input,
> +		       struct ibv_device_attr_ex *attr, size_t attr_size) {
> +	struct ib_uverbs_ex_query_device_resp resp;
> +	size_t resp_size =3D sizeof(resp);
> +	uint64_t raw_fw_ver;
> +	unsigned int major, minor, sub_minor;
> +	int rv;
> +
> +	rv =3D ibv_cmd_query_device_any(ctx, input, attr, attr_size, &resp,
> &resp_size);
> +	if (rv)
> +		return rv;
> +
> +	raw_fw_ver =3D resp.base.fw_ver;
> +	major =3D (raw_fw_ver >> 32) & 0xffff;
> +	minor =3D (raw_fw_ver >> 16) & 0xffff;
> +	sub_minor =3D raw_fw_ver & 0xffff;
> +
> +	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
> +		"%d.%d.%d", major, minor, sub_minor);
> +
> +	return 0;
> +}
> +
> +int erdma_query_port(struct ibv_context *ctx, uint8_t port, struct
> +ibv_port_attr *attr) {
> +	struct ibv_query_port cmd;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +
> +	return ibv_cmd_query_port(ctx, port, attr, &cmd, sizeof(cmd)); }
> +
> +int erdma_query_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
> +		   int attr_mask, struct ibv_qp_init_attr *init_attr) {
> +	struct ibv_query_qp cmd;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +
> +	return ibv_cmd_query_qp(qp, attr, attr_mask, init_attr, &cmd,
> +sizeof(cmd)); }
> +
> +struct ibv_pd *erdma_alloc_pd(struct ibv_context *ctx) {
> +	struct ibv_alloc_pd cmd;
> +	struct ib_uverbs_alloc_pd_resp resp;
> +	struct ibv_pd *pd;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +
> +	pd =3D calloc(1, sizeof(*pd));
> +	if (!pd)
> +		return NULL;
> +
> +	if (ibv_cmd_alloc_pd(ctx, pd, &cmd, sizeof(cmd), &resp,
> sizeof(resp))) {
> +		free(pd);
> +		return NULL;
> +	}
> +
> +	return pd;
> +}
> +
> +int erdma_free_pd(struct ibv_pd *pd)
> +{
> +	int rv;
> +
> +	rv =3D ibv_cmd_dealloc_pd(pd);
> +	if (rv)
> +		return rv;
> +
> +	free(pd);
> +	return 0;
> +}
> +
> +struct ibv_mr *erdma_reg_mr(struct ibv_pd *pd, void *addr, size_t len,
> +			    uint64_t hca_va, int access)
> +{
> +	struct ibv_reg_mr cmd;
> +	struct ib_uverbs_reg_mr_resp resp;
> +	struct verbs_mr *vmr;
> +	int ret;
> +
> +	vmr =3D calloc(1, sizeof(*vmr));
> +	if (!vmr)
> +		return NULL;
> +
> +	ret =3D ibv_cmd_reg_mr(pd, addr, len, hca_va, access, vmr, &cmd,
> sizeof(cmd),
> +		&resp, sizeof(resp));
> +	if (ret) {
> +		free(vmr);
> +		return NULL;
> +	}
> +
> +	return &vmr->ibv_mr;
> +}
> +
> +int erdma_dereg_mr(struct verbs_mr *vmr) {
> +	int ret;
> +
> +	ret =3D ibv_cmd_dereg_mr(vmr);
> +	if (ret)
> +		return ret;
> +
> +	free(vmr);
> +	return 0;
> +}
> +
> +int erdma_notify_cq(struct ibv_cq *ibcq, int solicited) {
> +	struct erdma_cq *cq =3D to_ecq(ibcq);
> +	uint64_t db_data;
> +	int ret;
> +
> +	ret =3D pthread_spin_lock(&cq->lock);
> +	if (ret)
> +		return ret;
> +
> +	db_data =3D FIELD_PREP(ERDMA_CQDB_EQN_MASK, cq-
> >comp_vector + 1) |
> +		FIELD_PREP(ERDMA_CQDB_CQN_MASK, cq->id) |
> +		FIELD_PREP(ERDMA_CQDB_ARM_MASK, 1) |
> +		FIELD_PREP(ERDMA_CQDB_SOL_MASK, solicited) |
> +		FIELD_PREP(ERDMA_CQDB_CMDSN_MASK, cq->cmdsn) |
> +		FIELD_PREP(ERDMA_CQDB_CI_MASK, cq->ci);
> +
> +	*(__le64 *)cq->db_record =3D htole64(db_data);
> +	udma_to_device_barrier();
> +	mmio_write64_le(cq->db, htole64(db_data));
> +
> +	pthread_spin_unlock(&cq->lock);
> +
> +	return ret;
> +}
> +
> +struct ibv_cq *erdma_create_cq(struct ibv_context *ctx, int num_cqe,
> +			       struct ibv_comp_channel *channel, int
> comp_vector) {
> +	struct erdma_context *ectx;
> +	struct erdma_cmd_create_cq cmd =3D {};
> +	struct erdma_cmd_create_cq_resp resp =3D {};
> +	struct erdma_cq *cq;
> +	uint64_t *db_records =3D NULL;
> +	int cq_size;
> +	int rv;
> +
> +	ectx =3D to_ectx(ctx);
> +
> +	cq =3D calloc(1, sizeof(*cq));
> +	if (!cq)
> +		return NULL;
> +
> +	if (num_cqe < 64)
> +		num_cqe =3D 64;
> +
> +	num_cqe =3D roundup_pow_of_two(num_cqe);
> +	cq_size =3D num_cqe * sizeof(struct erdma_cqe);
> +	cq_size =3D ERDMA_SIZE_TO_NPAGE(cq_size) <<
> ERDMA_PAGE_SHIFT;
> +
> +	rv =3D posix_memalign((void **)&cq->queue, ERDMA_PAGE_SIZE,
> cq_size);
> +	if (rv) {
> +		errno =3D rv;
> +		free(cq);
> +		return NULL;
> +	}
> +
> +	db_records =3D erdma_alloc_dbrecords(ectx);
> +	if (!db_records) {
> +		errno =3D ENOMEM;
> +		goto error_alloc;
> +	}
> +
> +	cmd.db_record_va =3D (__u64)db_records;
> +	cmd.qbuf_va =3D (uint64_t)cq->queue;
> +	cmd.qbuf_len =3D cq_size;
> +
> +	rv =3D ibv_cmd_create_cq(ctx, num_cqe, channel, comp_vector, &cq-
> >base_cq,
> +		&cmd.ibv_cmd, sizeof(cmd), &resp.ibv_resp, sizeof(resp));
> +	if (rv) {
> +		free(cq);
> +		errno =3D EIO;
> +		goto error_alloc;
> +	}
> +
> +	pthread_spin_init(&cq->lock, PTHREAD_PROCESS_PRIVATE);
> +
> +	*db_records =3D 0;
> +	cq->db_record =3D db_records;
> +
> +	cq->id =3D resp.cq_id;
> +	cq->depth =3D resp.num_cqe;
> +	cq->owner =3D 1;
> +
> +	cq->db =3D ectx->cdb;
> +	cq->db_offset =3D (cq->id & (ERDMA_PAGE_SIZE / ERDMA_CQDB_SIZE
> - 1)) * ERDMA_CQDB_SIZE;
> +	cq->db +=3D cq->db_offset;
> +
> +	cq->comp_vector =3D comp_vector;
> +
> +	return &cq->base_cq;
> +
> +error_alloc:
> +	if (db_records)
> +		erdma_dealloc_dbrecords(ectx, db_records);
> +
> +	if (cq->queue)
> +		free(cq->queue);
> +
> +	free(cq);
> +
> +	return NULL;
> +}
> +
> +int erdma_destroy_cq(struct ibv_cq *base_cq) {
> +	struct erdma_cq *cq =3D to_ecq(base_cq);
> +	struct erdma_context *ctx =3D to_ectx(base_cq->context);
> +	int rv;
> +
> +	pthread_spin_lock(&cq->lock);
> +	rv =3D ibv_cmd_destroy_cq(base_cq);
> +	if (rv) {
> +		pthread_spin_unlock(&cq->lock);
> +		errno =3D EIO;
> +		return rv;
> +	}
> +	pthread_spin_destroy(&cq->lock);
> +
> +	if (cq->db_record)
> +		erdma_dealloc_dbrecords(ctx, cq->db_record);
> +
> +	if (cq->queue)
> +		free(cq->queue);
> +
> +	free(cq);
> +
> +	return 0;
> +}
> +
> +static void __erdma_alloc_dbs(struct erdma_qp *qp, struct erdma_context
> +*ctx) {
> +	uint32_t qpn =3D qp->id;
> +
> +	if (ctx->sdb_type =3D=3D ERDMA_SDB_PAGE) {
> +		/* qpn[4:0] as the index in this db page. */
> +		qp->sq.db =3D ctx->sdb + (qpn & 31) * ERDMA_SQDB_SIZE;
> +	} else if (ctx->sdb_type =3D=3D ERDMA_SDB_ENTRY) {
> +		/* for type 'ERDMA_SDB_ENTRY', each uctx has 2 dwqe,
> totally takes 256Bytes. */
> +		qp->sq.db =3D ctx->sdb + ctx->sdb_offset * 256;
Generally we use macros to define hard-coded integers. E.g 256 should use a=
 macro.
> +	} else {
> +		/* qpn[4:0] as the index in this db page. */
> +		qp->sq.db =3D ctx->sdb + (qpn & 31) * ERDMA_SQDB_SIZE;
> +	}
> +
> +	/* qpn[6:0] as the index in this rq db page. */
> +	qp->rq.db =3D ctx->rdb + (qpn & 127) * ERDMA_RQDB_SPACE_SIZE; }
> +
> +struct ibv_qp *erdma_create_qp(struct ibv_pd *pd, struct
> +ibv_qp_init_attr *attr) {
> +	struct erdma_cmd_create_qp cmd =3D {};
> +	struct erdma_cmd_create_qp_resp resp =3D {};
> +	struct erdma_qp *qp;
> +	struct ibv_context *base_ctx =3D pd->context;
> +	struct erdma_context *ctx =3D to_ectx(base_ctx);
> +	uint64_t *db_records  =3D NULL;
> +	int rv, tbl_idx, tbl_off;
> +	int sq_size =3D 0, rq_size =3D 0, total_bufsize =3D 0;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	memset(&resp, 0, sizeof(resp));
No need of memset due to declaration step.
> +
> +	qp =3D calloc(1, sizeof(*qp));
> +	if (!qp)
> +		return NULL;
> +
> +	sq_size =3D roundup_pow_of_two(attr->cap.max_send_wr *
> MAX_WQEBB_PER_SQE) << SQEBB_SHIFT;
> +	sq_size =3D align(sq_size, ctx->page_size);
> +	rq_size =3D align(roundup_pow_of_two(attr->cap.max_recv_wr) <<
> RQE_SHIFT, ctx->page_size);
> +	total_bufsize =3D sq_size + rq_size;
> +	rv =3D posix_memalign(&qp->qbuf, ctx->page_size, total_bufsize);
> +	if (rv || !qp->qbuf) {
> +		errno =3D ENOMEM;
> +		goto error_alloc;
> +	}
> +
> +	db_records =3D erdma_alloc_dbrecords(ctx);
> +	if (!db_records) {
> +		errno =3D ENOMEM;
> +		goto error_alloc;
> +	}
> +
> +	cmd.db_record_va =3D (__u64)db_records;
> +	cmd.qbuf_va =3D (__u64)qp->qbuf;
> +	cmd.qbuf_len =3D (__u32)total_bufsize;
> +
> +	rv =3D ibv_cmd_create_qp(pd, &qp->base_qp, attr, &cmd.ibv_cmd,
> +		sizeof(cmd), &resp.ibv_resp, sizeof(resp));
> +	if (rv) {
> +		errno =3D EIO;
> +		goto error_alloc;
> +	}
> +
> +	qp->id =3D resp.qp_id;
> +
> +	pthread_mutex_lock(&ctx->qp_table_mutex);
> +	tbl_idx =3D qp->id >> ERDMA_QP_TABLE_SHIFT;
> +	tbl_off =3D qp->id & ERDMA_QP_TABLE_MASK;
> +
> +	if (ctx->qp_table[tbl_idx].refcnt =3D=3D 0) {
> +		ctx->qp_table[tbl_idx].table =3D calloc(ERDMA_PAGE_SIZE,
> sizeof(struct erdma_qp *));
> +		if (!ctx->qp_table[tbl_idx].table) {
> +			errno =3D ENOMEM;
> +			goto fail;
> +		}
> +	}
> +
> +	/* exist qp */
> +	if (ctx->qp_table[tbl_idx].table[tbl_off]) {
> +		errno =3D EBUSY;
> +		goto fail;
> +	}
> +
> +	ctx->qp_table[tbl_idx].table[tbl_off] =3D qp;
> +	ctx->qp_table[tbl_idx].refcnt++;
> +	pthread_mutex_unlock(&ctx->qp_table_mutex);
> +
> +	qp->sq.qbuf =3D qp->qbuf;
> +	qp->rq.qbuf =3D qp->qbuf + resp.rq_offset;
> +	qp->sq.depth =3D resp.num_sqe;
> +	qp->rq.depth =3D resp.num_rqe;
> +	qp->sq_sig_all =3D attr->sq_sig_all;
> +	qp->sq.size =3D resp.num_sqe * SQEBB_SIZE;
> +	qp->rq.size =3D resp.num_rqe * sizeof(struct erdma_rqe);
> +
> +	/* doorbell allocation. */
> +	__erdma_alloc_dbs(qp, ctx);
> +
> +	pthread_spin_init(&qp->sq_lock, PTHREAD_PROCESS_PRIVATE);
> +	pthread_spin_init(&qp->rq_lock, PTHREAD_PROCESS_PRIVATE);
> +
> +	*db_records =3D 0;
> +	*(db_records + 1) =3D 0;
> +	qp->db_records =3D db_records;
> +	qp->sq.db_record =3D db_records;
> +	qp->rq.db_record =3D db_records + 1;
> +
> +	qp->rq.wr_tbl =3D calloc(qp->rq.depth, sizeof(uint64_t));
> +	if (!qp->rq.wr_tbl)
> +		goto fail;
> +
> +	qp->sq.wr_tbl =3D calloc(qp->sq.depth, sizeof(uint64_t));
> +	if (!qp->sq.wr_tbl)
> +		goto fail;
> +
> +
> +	return &qp->base_qp;
> +fail:
> +	if (qp->sq.wr_tbl)
> +		free(qp->sq.wr_tbl);
> +
> +	if (qp->rq.wr_tbl)
> +		free(qp->rq.wr_tbl);
> +
> +	ibv_cmd_destroy_qp(&qp->base_qp);
> +
> +error_alloc:
> +	if (db_records)
> +		erdma_dealloc_dbrecords(ctx, db_records);
> +
> +	if (qp->qbuf)
> +		free(qp->qbuf);
> +
> +	free(qp);
> +
> +	return NULL;
> +}
> +
> +int erdma_modify_qp(struct ibv_qp *base_qp, struct ibv_qp_attr *attr,
> +int attr_mask) {
> +	struct ibv_modify_qp cmd;
> +	struct erdma_qp *qp =3D to_eqp(base_qp);
> +	int rv;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +
> +	pthread_spin_lock(&qp->sq_lock);
> +	pthread_spin_lock(&qp->rq_lock);
> +
> +	rv =3D ibv_cmd_modify_qp(base_qp, attr, attr_mask, &cmd,
> sizeof(cmd));
> +
> +	pthread_spin_unlock(&qp->rq_lock);
> +	pthread_spin_unlock(&qp->sq_lock);
> +
> +	return rv;
> +}
> +
> +int erdma_destroy_qp(struct ibv_qp *base_qp) {
> +	struct erdma_qp *qp =3D to_eqp(base_qp);
> +	struct ibv_context *base_ctx =3D base_qp->pd->context;
> +	struct erdma_context *ctx =3D to_ectx(base_ctx);
> +	int rv, tbl_idx, tbl_off;
> +
> +	pthread_spin_lock(&qp->sq_lock);
> +	pthread_spin_lock(&qp->rq_lock);
Why to hold these?
> +
> +	pthread_mutex_lock(&ctx->qp_table_mutex);
> +	tbl_idx =3D qp->id >> ERDMA_QP_TABLE_SHIFT;
> +	tbl_off =3D qp->id & ERDMA_QP_TABLE_MASK;
> +
> +	ctx->qp_table[tbl_idx].table[tbl_off] =3D NULL;
> +	ctx->qp_table[tbl_idx].refcnt--;
> +
> +	if (ctx->qp_table[tbl_idx].refcnt =3D=3D 0) {
> +		free(ctx->qp_table[tbl_idx].table);
> +		ctx->qp_table[tbl_idx].table =3D NULL;
> +	}
> +
> +	pthread_mutex_unlock(&ctx->qp_table_mutex);
> +
> +	rv =3D ibv_cmd_destroy_qp(base_qp);
> +	if (rv) {
> +		pthread_spin_unlock(&qp->rq_lock);
> +		pthread_spin_unlock(&qp->sq_lock);
> +		return rv;
> +	}
> +	pthread_spin_destroy(&qp->rq_lock);
> +	pthread_spin_destroy(&qp->sq_lock);
> +
> +	if (qp->db_records)
> +		erdma_dealloc_dbrecords(ctx, qp->db_records);
> +
> +	if (qp->qbuf)
> +		free(qp->qbuf);
> +
> +	free(qp);
> +
> +	return 0;
> +}
> +
> +static int erdma_push_one_sqe(struct erdma_qp *qp, struct ibv_send_wr
> +*wr, uint16_t *sq_pi) {
> +	uint16_t tmp_pi =3D *sq_pi;
> +	void *sqe;
> +	uint64_t sqe_hdr;
> +	struct erdma_write_sqe *write_sqe;
> +	struct erdma_send_sqe *send_sqe;
> +	struct erdma_readreq_sqe *read_sqe;
> +	uint32_t wqe_size =3D 0;
> +	__le32 *length_field =3D NULL;
> +	struct erdma_sge *sgl_base =3D NULL;
> +	uint32_t i, bytes =3D 0;
> +	uint32_t sgl_off, sgl_idx, wqebb_cnt, opcode;
> +
> +	sqe =3D get_sq_wqebb(qp, tmp_pi);
> +	/* Clear the first 8Byte of the wqe hdr. */
> +	*(uint64_t *)sqe =3D 0;
> +
> +	qp->sq.wr_tbl[tmp_pi & (qp->sq.depth - 1)] =3D wr->wr_id;
> +
> +	sqe_hdr =3D FIELD_PREP(ERDMA_SQE_HDR_QPN_MASK, qp->id) |
> +		FIELD_PREP(ERDMA_SQE_HDR_CE_MASK, wr->send_flags &
> IBV_SEND_SIGNALED ? 1 : 0) |
> +		FIELD_PREP(ERDMA_SQE_HDR_CE_MASK, qp->sq_sig_all) |
> +		FIELD_PREP(ERDMA_SQE_HDR_SE_MASK, wr->send_flags &
> IBV_SEND_SOLICITED ? 1 : 0) |
> +		FIELD_PREP(ERDMA_SQE_HDR_FENCE_MASK, wr-
> >send_flags & IBV_SEND_FENCE ? 1 : 0) |
> +		FIELD_PREP(ERDMA_SQE_HDR_INLINE_MASK, wr-
> >send_flags &
> +IBV_SEND_INLINE ? 1 : 0);
> +
> +	switch (wr->opcode) {
> +	case IBV_WR_RDMA_WRITE:
> +	case IBV_WR_RDMA_WRITE_WITH_IMM:
> +		opcode =3D wr->opcode =3D=3D IBV_WR_RDMA_WRITE ?
> +			ERDMA_OP_WRITE :
> ERDMA_OP_WRITE_WITH_IMM;
> +		sqe_hdr |=3D FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK,
> opcode);
> +		write_sqe =3D (struct erdma_write_sqe *)sqe;
> +		write_sqe->imm_data =3D wr->imm_data;
> +		write_sqe->sink_stag =3D htole32(wr->wr.rdma.rkey);
> +		write_sqe->sink_to_low =3D htole32(wr-
> >wr.rdma.remote_addr & 0xFFFFFFFF);
> +		write_sqe->sink_to_high =3D htole32((wr-
> >wr.rdma.remote_addr >> 32) &
> +0xFFFFFFFF);
> +
> +		length_field =3D &write_sqe->length;
> +		sgl_base =3D get_sq_wqebb(qp, tmp_pi + 1);
> +		/* sgl is in next wqebb. */
> +		sgl_off =3D 0;
> +		sgl_idx =3D tmp_pi + 1;
> +		wqe_size =3D sizeof(struct erdma_write_sqe);
> +
> +		break;
> +	case IBV_WR_SEND:
> +	case IBV_WR_SEND_WITH_IMM:
> +		opcode =3D wr->opcode =3D=3D IBV_WR_SEND ? ERDMA_OP_SEND
> : ERDMA_OP_SEND_WITH_IMM;
> +		sqe_hdr |=3D FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK,
> opcode);
> +		send_sqe =3D (struct erdma_send_sqe *)sqe;
> +		send_sqe->imm_data =3D wr->imm_data;
> +
> +		length_field =3D &send_sqe->length;
> +		sgl_base =3D (void *)send_sqe;
> +		/* sgl is in the half of current wqebb */
> +		sgl_off =3D 16;
> +		sgl_idx =3D tmp_pi;
> +		wqe_size =3D sizeof(struct erdma_send_sqe);
> +
> +		break;
> +	case IBV_WR_RDMA_READ:
> +		sqe_hdr |=3D FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK,
> ERDMA_OP_READ);
> +
> +		read_sqe =3D (struct erdma_readreq_sqe *)sqe;
> +
> +		read_sqe->sink_to_low =3D htole32(wr->sg_list->addr &
> 0xFFFFFFFF);
> +		read_sqe->sink_to_high =3D htole32((wr->sg_list->addr >> 32)
> & 0xFFFFFFFF);
> +		read_sqe->sink_stag =3D htole32(wr->sg_list->lkey);
> +		read_sqe->length =3D htole32(wr->sg_list->length);
> +
> +		struct erdma_sge *sgl =3D (struct erdma_sge
> *)get_sq_wqebb(qp, tmp_pi +
> +1);
> +
> +		sgl->laddr =3D htole64(wr->wr.rdma.remote_addr);
> +		sgl->length =3D htole32(wr->sg_list->length);
> +		sgl->lkey =3D htole32(wr->wr.rdma.rkey);
> +
> +		wqe_size =3D sizeof(struct erdma_readreq_sqe);
> +
> +		goto out;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (wr->send_flags & IBV_SEND_INLINE) {
> +		char *data =3D (char *)sgl_base;
> +		uint32_t remain_size;
> +		uint32_t copy_size;
> +		uint32_t data_off;
> +
> +		i =3D 0;
> +		bytes =3D 0;
> +
> +		/* Allow more than ERDMA_MAX_SGE, since content copied
> here */
> +		while (i < wr->num_sge) {
> +			bytes +=3D wr->sg_list[i].length;
> +			if (bytes > (int)ERDMA_MAX_INLINE)
> +				return -EINVAL;
> +
> +			remain_size =3D wr->sg_list[i].length;
> +			data_off =3D 0;
> +
> +			while (1) {
> +				copy_size =3D min(remain_size, SQEBB_SIZE -
> sgl_off);
> +				memcpy(data + sgl_off,
> +					(void *)(uintptr_t)wr->sg_list[i].addr
> + data_off,
> +					copy_size);
> +				remain_size -=3D copy_size;
> +
> +				/* Update sgl_offset. */
> +				sgl_idx +=3D ((sgl_off + copy_size) >>
> SQEBB_SHIFT);
> +				sgl_off =3D (sgl_off + copy_size) & (SQEBB_SIZE
> - 1);
> +				data_off +=3D copy_size;
> +				data =3D get_sq_wqebb(qp, sgl_idx);
> +
> +				if (!remain_size)
> +					break;
> +			};
> +
> +			i++;
> +		}
> +
> +		*length_field =3D htole32(bytes);
> +		wqe_size +=3D bytes;
> +		sqe_hdr |=3D FIELD_PREP(ERDMA_SQE_HDR_SGL_LEN_MASK,
> bytes);
> +	} else {
> +		char *sgl =3D (char *)sgl_base;
> +
> +		if (wr->num_sge > ERDMA_MAX_SEND_SGE)
> +			return -EINVAL;
> +
> +		i =3D 0;
> +		bytes =3D 0;
> +
> +		while (i < wr->num_sge) {
> +			bytes +=3D wr->sg_list[i].length;
> +			memcpy(sgl + sgl_off, &wr->sg_list[i], sizeof(struct
> ibv_sge));
> +
> +			if (sgl_off =3D=3D 0)
> +				*(uint32_t *)(sgl + 28) =3D qp->id;
> +
> +			sgl_idx +=3D (sgl_off =3D=3D sizeof(struct ibv_sge) ? 1 : 0);
> +			sgl =3D get_sq_wqebb(qp, sgl_idx);
> +			sgl_off =3D sizeof(struct ibv_sge) - sgl_off;
> +
> +			i++;
> +		}
> +
> +		*length_field =3D htole32(bytes);
> +		sqe_hdr |=3D FIELD_PREP(ERDMA_SQE_HDR_SGL_LEN_MASK,
> wr->num_sge);
> +		wqe_size +=3D wr->num_sge * sizeof(struct ibv_sge);
> +	}
> +
> +out:
> +	wqebb_cnt =3D SQEBB_COUNT(wqe_size);
> +	assert(wqebb_cnt <=3D MAX_WQEBB_PER_SQE);
> +	sqe_hdr |=3D FIELD_PREP(ERDMA_SQE_HDR_WQEBB_CNT_MASK,
> wqebb_cnt - 1);
> +	sqe_hdr |=3D FIELD_PREP(ERDMA_SQE_HDR_WQEBB_INDEX_MASK,
> tmp_pi +
> +wqebb_cnt);
> +
> +	*(__le64 *)sqe =3D htole64(sqe_hdr);
> +	*sq_pi =3D tmp_pi + wqebb_cnt;
> +
> +	return 0;
> +}
> +
> +int erdma_post_send(struct ibv_qp *base_qp, struct ibv_send_wr *wr,
> +struct ibv_send_wr **bad_wr) {
> +	struct erdma_qp *qp =3D to_eqp(base_qp);
> +	uint16_t sq_pi;
> +	int new_sqe =3D 0, rv =3D 0;
> +
> +	*bad_wr =3D NULL;
> +
> +	if (base_qp->state =3D=3D IBV_QPS_ERR) {
Post_send is allowed in Error state. Thus the check is redundant.
> +		*bad_wr =3D wr;
> +		return -EIO;
> +	}
> +
> +	pthread_spin_lock(&qp->sq_lock);
> +
> +	sq_pi =3D qp->sq.pi;
> +
> +	while (wr) {
> +		if ((uint16_t)(sq_pi - qp->sq.ci) >=3D qp->sq.depth) {
> +			rv =3D -ENOMEM;
> +			*bad_wr =3D wr;
> +			break;
> +		}
> +
> +		rv =3D erdma_push_one_sqe(qp, wr, &sq_pi);
> +		if (rv) {
> +			*bad_wr =3D wr;
> +			break;
> +		}
> +
> +		new_sqe++;
> +		wr =3D wr->next;
> +	}
> +
> +	if (new_sqe) {
> +		qp->sq.pi =3D sq_pi;
> +		__kick_sq_db(qp, sq_pi); /* normal doorbell. */
> +	}
> +
> +	pthread_spin_unlock(&qp->sq_lock);
> +
> +	return rv;
> +}
> +
> +static int push_recv_wqe(struct erdma_qp *qp, struct ibv_recv_wr *wr) {
> +	uint16_t rq_pi =3D qp->rq.pi;
> +	uint16_t idx =3D rq_pi & (qp->rq.depth - 1);
> +	struct erdma_rqe *rqe =3D (struct erdma_rqe *)qp->rq.qbuf + idx;
> +
> +	if ((uint16_t)(rq_pi - qp->rq.ci) =3D=3D qp->rq.depth)
> +		return -ENOMEM;
> +
> +	rqe->qe_idx =3D htole16(rq_pi + 1);
> +	rqe->qpn =3D htole32(qp->id);
> +	qp->rq.wr_tbl[idx] =3D wr->wr_id;
> +
> +	if (wr->num_sge =3D=3D 0) {
> +		rqe->length =3D 0;
> +	} else if (wr->num_sge =3D=3D 1) {
> +		rqe->stag =3D htole32(wr->sg_list[0].lkey);
> +		rqe->to =3D htole64(wr->sg_list[0].addr);
> +		rqe->length =3D htole32(wr->sg_list[0].length);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	*(__le64 *)qp->rq.db_record =3D *(__le64 *)rqe;
> +	udma_to_device_barrier();
> +	mmio_write64_le(qp->rq.db, *(__le64 *)rqe);
> +
> +	qp->rq.pi =3D rq_pi + 1;
> +
> +	return 0;
> +}
> +
> +int erdma_post_recv(struct ibv_qp *base_qp, struct ibv_recv_wr *wr,
> +struct ibv_recv_wr **bad_wr) {
> +	struct erdma_qp *qp =3D to_eqp(base_qp);
> +	int ret =3D 0;
> +
> +	if (base_qp->state =3D=3D IBV_QPS_ERR) {
> +		*bad_wr =3D wr;
> +		return -EIO;
> +	}
> +
> +	pthread_spin_lock(&qp->rq_lock);
> +
> +	while (wr) {
> +		ret =3D push_recv_wqe(qp, wr);
> +		if (ret) {
> +			*bad_wr =3D wr;
> +			break;
> +		}
> +
> +		wr =3D wr->next;
> +	}
> +
> +	pthread_spin_unlock(&qp->rq_lock);
> +
> +	return ret;
> +}
> +
> +
> +void erdma_cq_event(struct ibv_cq *ibcq) {
> +	struct erdma_cq *cq =3D to_ecq(ibcq);
> +
> +	cq->cmdsn++;
> +}
> +
> +static const struct {
> +	enum erdma_opcode erdma;
> +	enum ibv_wc_opcode base;
> +} map_cqe_opcode[ERDMA_NUM_OPCODES] =3D {
> +	{ ERDMA_OP_WRITE, IBV_WC_RDMA_WRITE },
> +	{ ERDMA_OP_READ, IBV_WC_RDMA_READ },
> +	{ ERDMA_OP_SEND, IBV_WC_SEND },
> +	{ ERDMA_OP_SEND_WITH_IMM, IBV_WC_SEND },
> +	{ ERDMA_OP_RECEIVE, IBV_WC_RECV },
> +	{ ERDMA_OP_RECV_IMM, IBV_WC_RECV_RDMA_WITH_IMM },
> +	{ ERDMA_OP_RECV_INV, IBV_WC_LOCAL_INV},  /* can not appear
> */
> +	{ ERDMA_OP_REQ_ERR, IBV_WC_RECV },  /* can not appear */
> +	{ ERDNA_OP_READ_RESPONSE, IBV_WC_RECV }, /* can not appear
> */
> +	{ ERDMA_OP_WRITE_WITH_IMM, IBV_WC_RDMA_WRITE },
> +	{ ERDMA_OP_RECV_ERR, IBV_WC_RECV_RDMA_WITH_IMM }, /*
> can not appear */
> +	{ ERDMA_OP_INVALIDATE, IBV_WC_LOCAL_INV },
> +	{ ERDMA_OP_RSP_SEND_IMM, IBV_WC_RECV },
> +	{ ERDMA_OP_SEND_WITH_INV, IBV_WC_SEND },
> +	{ ERDMA_OP_REG_MR, IBV_WC_RECV }, /* can not appear */
> +	{ ERDMA_OP_LOCAL_INV, IBV_WC_LOCAL_INV },
> +	{ ERDMA_OP_READ_WITH_INV, IBV_WC_RDMA_READ }, };
> +
> +static const struct {
> +	enum erdma_wc_status erdma;
> +	enum ibv_wc_status base;
> +	enum erdma_vendor_err vendor;
> +} map_cqe_status[ERDMA_NUM_WC_STATUS] =3D {
> +	{ ERDMA_WC_SUCCESS, IBV_WC_SUCCESS,
> ERDMA_WC_VENDOR_NO_ERR },
> +	{ ERDMA_WC_GENERAL_ERR, IBV_WC_GENERAL_ERR,
> ERDMA_WC_VENDOR_NO_ERR },
> +	{ ERDMA_WC_RECV_WQE_FORMAT_ERR, IBV_WC_GENERAL_ERR,
> ERDMA_WC_VENDOR_INVALID_RQE },
> +	{ ERDMA_WC_RECV_STAG_INVALID_ERR,
> +		IBV_WC_REM_ACCESS_ERR,
> ERDMA_WC_VENDOR_RQE_INVALID_STAG },
> +	{ ERDMA_WC_RECV_ADDR_VIOLATION_ERR,
> +		IBV_WC_REM_ACCESS_ERR,
> ERDMA_WC_VENDOR_RQE_ADDR_VIOLATION },
> +	{ ERDMA_WC_RECV_RIGHT_VIOLATION_ERR,
> +		IBV_WC_REM_ACCESS_ERR,
> ERDMA_WC_VENDOR_RQE_ACCESS_RIGHT_ERR },
> +	{ ERDMA_WC_RECV_PDID_ERR, IBV_WC_REM_ACCESS_ERR,
> ERDMA_WC_VENDOR_RQE_INVALID_PD },
> +	{ ERDMA_WC_RECV_WARRPING_ERR, IBV_WC_REM_ACCESS_ERR,
> ERDMA_WC_VENDOR_RQE_WRAP_ERR },
> +	{ ERDMA_WC_SEND_WQE_FORMAT_ERR,
> IBV_WC_LOC_QP_OP_ERR, ERDMA_WC_VENDOR_INVALID_SQE },
> +	{ ERDMA_WC_SEND_WQE_ORD_EXCEED, IBV_WC_GENERAL_ERR,
> ERDMA_WC_VENDOR_ZERO_ORD },
> +	{ ERDMA_WC_SEND_STAG_INVALID_ERR,
> +		IBV_WC_LOC_ACCESS_ERR,
> ERDMA_WC_VENDOR_SQE_INVALID_STAG },
> +	{ ERDMA_WC_SEND_ADDR_VIOLATION_ERR,
> +		IBV_WC_LOC_ACCESS_ERR,
> ERDMA_WC_VENDOR_SQE_ADDR_VIOLATION },
> +	{ ERDMA_WC_SEND_RIGHT_VIOLATION_ERR,
> +		IBV_WC_LOC_ACCESS_ERR,
> ERDMA_WC_VENDOR_SQE_ACCESS_ERR },
> +	{ ERDMA_WC_SEND_PDID_ERR, IBV_WC_LOC_ACCESS_ERR,
> ERDMA_WC_VENDOR_SQE_INVALID_PD },
> +	{ ERDMA_WC_SEND_WARRPING_ERR, IBV_WC_LOC_ACCESS_ERR,
> ERDMA_WC_VENDOR_SQE_WARP_ERR },
> +	{ ERDMA_WC_FLUSH_ERR, IBV_WC_WR_FLUSH_ERR,
> ERDMA_WC_VENDOR_NO_ERR },
> +	{ ERDMA_WC_RETRY_EXC_ERR, IBV_WC_RETRY_EXC_ERR,
> ERDMA_WC_VENDOR_NO_ERR
> +}, };
> +
> +#define ERDMA_POLLCQ_NO_QP      (-1)
> +#define ERDMA_POLLCQ_DUP_COMP   (-2)
> +#define ERDMA_POLLCQ_WRONG_IDX  (-3)
> +
> +static int __erdma_poll_one_cqe(struct erdma_context *ctx, struct
> erdma_cq *cq,
> +				struct erdma_cqe *cqe, uint32_t cqe_hdr,
> struct ibv_wc *wc) {
> +	struct erdma_qp *qp;
> +	uint64_t *qeidx2wrid =3D NULL;
> +	uint32_t qpn =3D be32toh(cqe->qpn);
> +	uint16_t depth =3D 0;
> +	uint64_t *sqe_hdr;
> +	uint16_t wqe_idx =3D be32toh(cqe->qe_idx);
> +	uint16_t old_ci, new_ci;
> +	uint32_t opcode =3D FIELD_GET(ERDMA_CQE_HDR_OPCODE_MASK,
> cqe_hdr);
> +	uint32_t syndrome =3D
> FIELD_GET(ERDMA_CQE_HDR_SYNDROME_MASK, cqe_hdr);
> +
> +	int tbl_idx =3D qpn >> ERDMA_QP_TABLE_SHIFT;
> +	int tbl_off =3D qpn & ERDMA_QP_TABLE_MASK;
> +
> +	if (!ctx->qp_table[tbl_idx].table || !ctx-
> >qp_table[tbl_idx].table[tbl_off])
> +		return ERDMA_POLLCQ_NO_QP;
> +
> +	qp =3D ctx->qp_table[tbl_idx].table[tbl_off];
> +
> +	if (FIELD_GET(ERDMA_CQE_HDR_QTYPE_MASK, cqe_hdr) =3D=3D
> ERDMA_CQE_QTYPE_SQ) {
> +		qeidx2wrid =3D qp->sq.wr_tbl;
> +		depth =3D qp->sq.depth;
> +		sqe_hdr =3D (uint64_t *)get_sq_wqebb(qp, wqe_idx);
> +		old_ci =3D qp->sq.ci;
> +		new_ci =3D wqe_idx +
> FIELD_GET(ERDMA_SQE_HDR_WQEBB_CNT_MASK, *sqe_hdr)
> ++ 1;
> +
> +		if ((uint16_t)(new_ci - old_ci) > depth)
> +			return ERDMA_POLLCQ_WRONG_IDX;
> +		else if (new_ci =3D=3D old_ci)
> +			return ERDMA_POLLCQ_DUP_COMP;
> +
> +		qp->sq.ci =3D new_ci;
> +	} else {
> +		qeidx2wrid =3D qp->rq.wr_tbl;
> +		depth =3D qp->rq.depth;
> +		qp->rq.ci++;
> +	}
> +
> +	wc->wr_id =3D qeidx2wrid[wqe_idx & (depth - 1)];
> +	wc->byte_len =3D be32toh(cqe->size);
> +	wc->wc_flags =3D 0;
> +
> +	if (opcode =3D=3D ERDMA_OP_RECV_IMM) {
> +		wc->opcode =3D IBV_WC_RECV_RDMA_WITH_IMM;
> +		wc->imm_data =3D htobe32(le32toh(cqe->imm_data));
> +		wc->wc_flags |=3D IBV_WC_WITH_IMM;
> +	} else if (opcode =3D=3D ERDMA_OP_RSP_SEND_IMM) {
> +		wc->opcode =3D IBV_WC_RECV;
> +		wc->imm_data =3D htobe32(le32toh(cqe->imm_data));
> +		wc->wc_flags |=3D IBV_WC_WITH_IMM;
> +	} else {
> +		wc->opcode =3D map_cqe_opcode[opcode].base;
> +	}
> +
> +	if (syndrome >=3D ERDMA_NUM_WC_STATUS)
> +		syndrome =3D ERDMA_WC_GENERAL_ERR;
> +
> +	wc->status =3D map_cqe_status[syndrome].base;
> +	wc->vendor_err =3D map_cqe_status[syndrome].vendor;
> +	wc->qp_num =3D qpn;
> +
> +	return 0;
> +}
> +
> +int erdma_poll_cq(struct ibv_cq *ibcq, int num_entries, struct ibv_wc
> +*wc) {
> +	struct erdma_cq *cq =3D to_ecq(ibcq);
> +	struct erdma_context *ctx =3D to_ectx(ibcq->context);
> +	int new =3D 0;
> +	struct erdma_cqe *cqe;
> +	int owner;
> +	uint32_t ci;
> +	uint32_t depth_mask =3D cq->depth - 1;
> +	uint32_t hdr;
> +	int i, ret;
> +
> +	pthread_spin_lock(&cq->lock);
> +
> +	owner =3D cq->owner;
> +	ci =3D cq->ci;
> +
> +	for (i =3D 0; i < num_entries; i++) {
> +		cqe =3D &cq->queue[ci & depth_mask];
> +		hdr =3D be32toh(cqe->hdr);
> +
> +		if (FIELD_GET(ERDMA_CQE_HDR_OWNER_MASK, hdr) !=3D
> owner)
> +			break;
> +
> +		udma_from_device_barrier();
> +
> +		ret =3D __erdma_poll_one_cqe(ctx, cq, cqe, hdr, wc);
> +
> +		ci++;
> +		if ((ci & depth_mask) =3D=3D 0)
> +			owner =3D !owner;
> +
> +		if (ret)
> +			continue;
> +
> +		wc++;
> +		new++;
> +	}
> +
> +	cq->owner =3D owner;
> +	cq->ci =3D ci;
> +
> +	pthread_spin_unlock(&cq->lock);
> +
> +	return new;
> +}
> +
> +void erdma_free_context(struct ibv_context *ibv_ctx) {
> +	struct erdma_context *ctx =3D to_ectx(ibv_ctx);
> +	int i;
> +
> +	munmap(ctx->sdb, ERDMA_PAGE_SIZE);
> +	munmap(ctx->rdb, ERDMA_PAGE_SIZE);
> +	munmap(ctx->cdb, ERDMA_PAGE_SIZE);
> +
> +	pthread_mutex_lock(&ctx->qp_table_mutex);
> +	for (i =3D 0; i < ERDMA_QP_TABLE_SIZE; ++i) {
> +		if (ctx->qp_table[i].refcnt)
> +			free(ctx->qp_table[i].table);
> +	}
> +
> +	pthread_mutex_unlock(&ctx->qp_table_mutex);
> +	pthread_mutex_destroy(&ctx->qp_table_mutex);
> +
> +	verbs_uninit_context(&ctx->ibv_ctx);
> +	free(ctx);
> +}
> --
> 2.27.0

