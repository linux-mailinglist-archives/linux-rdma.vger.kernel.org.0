Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D1743DF13
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 12:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJ1Kmh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 06:42:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26420 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229877AbhJ1Kmg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 06:42:36 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S9KF1a027369;
        Thu, 28 Oct 2021 10:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kIWdkeGQX9w5rl9XjKTNMAp2A9rIS9VlGBGAJp5R6m8=;
 b=ZBLQYAQrh/qSz4YexN2qCOGaMzyzcnh7cz7kIagXms727p6jTBKv1dws3lSv1aJdd8ab
 jqMY5hgK39utUUYwbr7HTbGQKqPn1gIkzXtPGyr74T01puv5i6ZMd+Oix9CZ+pF1MDGV
 eQAqHiezkmQBLXe0DYoEiHiXQBBjZyPg2JYgJQU8Wpr4u4tEgi9s3wkrHFe0u300g0qL
 yum9MUlkDfqhavetIdrniKun5CCkPpKRvU67Mn8+vYI7sJkSagC1sd6XyO6UMXKzwH2Z
 u8tG9J2tWr6/6wUbaAJVt30n2NjLntKEDXwldDzo9zKccw46Df0oLvbNQ29Ow8qNps7e rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byja29pyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 10:40:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19SAa4eE147264;
        Thu, 28 Oct 2021 10:40:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 3bx4h3va5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 10:40:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBhehWxQGVXKnTKcyybkeKoP5NrwG6lgGLlmDq7EQ5RibVmqX0wuIcLfVQ3tQodDJR5UDG7NscQf9KugWXqJqsqgxcB18mHFQqrfHLRMaljm6RsgfRYpEt/VpvLY1DC9cKlykNCvPuyiMY+51wpCBrY5y71wYs9JCGTdZuA7HntIDT8DWtTBC87O8YcSDqeAioCmNlpRjpYuTTC3ghM9fSy1zJqDVerippr7H6PNojpbDWz14RckOC1etuRZVsktC/bBfh2JYrvzpUHN7ClmEBm0RklycX8ENCdIhZqxXs6I6FdFb5lafkRiOM6eGnZKl99VpbMFPZ26WXeb2YCHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIWdkeGQX9w5rl9XjKTNMAp2A9rIS9VlGBGAJp5R6m8=;
 b=EgnJ/fsKEdtJcr1VIygSVErxeLBxfUp7lx6w54a37HKNl3EmcdjVcUq8vfa0oML3ZSbk/bn+dAS4SjESP2E58D8TpZns2B3fgVaXakLDL0qc8ictls5buXVW8PtdsgZjbOVPSpy2GrGq6yr/QfjcFOyHRgDpKDKxaahsdpqmpBLkJCPi0P53snQ/uhgGcMrj5073mIDwukZHEvo2yTP6ITMETajN8/KejdexaAa7J5RTEbugV2NyYBnLrtvdy9ALCl9gK/zGM20wYLFhID+6bmm4KELKIdv9afHcBvRwiWf2fLm98GDJJ2AKYC+xm7O4VZkZebWVJ4EyMFqw7uLEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIWdkeGQX9w5rl9XjKTNMAp2A9rIS9VlGBGAJp5R6m8=;
 b=stpUFDsw2HVH0McjXdZm/5OgT1mqAaWNogKvaB8LPkKhXWEL4R8hpy3Yh1Ur0Hzg3A7UU9nCv7N9wgWIrA2PdoH3K+T+8g1pne1f6LRn/58dEldJqqUAf1cIthpubSTBP5WprO3z1bSVEDLHjW5nsbv9zI6k3oWtyq+Ixvr7iEw=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MW4PR10MB5809.namprd10.prod.outlook.com (2603:10b6:303:185::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 10:40:01 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::7d4a:284a:f0b8:1511]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::7d4a:284a:f0b8:1511%8]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 10:40:01 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Aharon Landau <aharonl@nvidia.com>
Subject: RE: [PATCH for-next] RDMA/bnxt_re: Fix kernel panic when trying to
 access bnxt_re_stat_descs
Thread-Topic: [PATCH for-next] RDMA/bnxt_re: Fix kernel panic when trying to
 access bnxt_re_stat_descs
Thread-Index: AQHXy3T0qL5gZLRo40Cn049iHOlWFavoORzw
Date:   Thu, 28 Oct 2021 10:40:01 +0000
Message-ID: <CO6PR10MB5635B836F79DB6C0FA2531A0DD869@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <20211027205448.127821-1-kamalheib1@gmail.com>
In-Reply-To: <20211027205448.127821-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e24688b-8074-49d5-6412-08d999ff4bd2
x-ms-traffictypediagnostic: MW4PR10MB5809:
x-microsoft-antispam-prvs: <MW4PR10MB5809092EAC69B5F28A3FBA70DD869@MW4PR10MB5809.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2hR/sbVFyaEh0S0ZrLKNmyKvejNRl7cJhdUfEXppFVcc2U5tv4GmkTRAVOfmv31h2ZQbUYorwhsYz/obPptAM1CjpPSJj2Nt3cE0Pcu8L5QUzLzvOjM6/t9FR5/y5E9l89s1DbPeCCb79TDSRuLS0pQqVEE+575ihA5p6i7PqqYY/9zpMXte7Bao+gwzXJsDlOqjgLkvlAwMLvV0y4bNNBWfklL7h8FyMVRFpnvX7OWAnbaJwo2tsFyEwedr3zcwgGVDZ4/42ffHBurYc/J6I6Ate6YnPHRPInCGMMonxeBh0rddH9QHdwEAy5fHWnYQj91Y4eJ8BYpJazV+v3Miloqc7+C4QkTpXH5O74YUZNi4YxXxCJ4R01/ujdxnBGmTDSEr59GtNbp2qFhB15B3LpxXfwEfaem9U+NIKch0tKNZSNa5WwFCScSjUFV8v4nJWks+AIwg6OTawSDNfmRvPTuXF5NxPIzsd+dEI9v8Dxi1pHJhfBZuflQh1XWE19ii+hGF66GN9gVphzIkByt4IROKVkQlUdgJ3qFBys38QE6n5bWhojkPivEDWO2aymowRHeFZZ7uVEt+sCntsE4Sam/zH1rBZWoEXN9KE7o8LuNjeHnXU5CFQvueEHUxeEYzy7/ws0Yd/rszE9ay4xSi2jlat1fds5KveMnYdpwgBtEzv9uXF1OYYl16BmhiNZudjpy6miLa19PaBYqLcDNAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(53546011)(110136005)(52536014)(186003)(7696005)(38070700005)(4326008)(45080400002)(6506007)(2906002)(86362001)(8936002)(5660300002)(9686003)(66946007)(54906003)(316002)(64756008)(66556008)(66476007)(55016002)(71200400001)(83380400001)(76116006)(8676002)(38100700002)(66446008)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?usCGl2bwG68IB3rrzUT+V+NYDqI7DmTj/xJOQBhQccTIDtVcC945USuvFFr7?=
 =?us-ascii?Q?Pr0QA+exbmU7CzgrcyHWaPBSiNNtJioqWUj0T5GSdU09antQeDf+D7ZERVu1?=
 =?us-ascii?Q?00vrej7fQoFKjH57u76iVhgt5Bwt/bSVAgBSJbXoqFgNkdcZDkauuqIeFuEP?=
 =?us-ascii?Q?MucVnMgX8lobpG1Xv/6IxhncvJO8FanP+Rwpv/VBFYC1zfBlYYwSIt8G1m2/?=
 =?us-ascii?Q?9Yxhjqv2kS2OYT2lEmm+OIZI65usVDU+AcwGykRRV/WSoMW0Zgu0XVNjbjro?=
 =?us-ascii?Q?/gPEBSV7WkoJCFXxRlsbA1jPv/Y+EkQ0H1NT757yrLLsp17b0RR3sMGt905G?=
 =?us-ascii?Q?JCjGj+rs3/6XWbeWVKFU03ELuD82JZqRtO/hbcy0JPBNe6mqTjWRv8KdZ/3a?=
 =?us-ascii?Q?chFIUq243be31luHplWmeFcUw2q26DZuHjnn9DakPY5vvjYoFVgF0s13bSot?=
 =?us-ascii?Q?3EYsi5rEj7tYbhBGYVnjWk+DRA5h97Xu+wGdBfDDkHm6vaCNB8+066moUVsj?=
 =?us-ascii?Q?XT8fyI9OLXPagQ2QzEzuKiCQDVdggFj479z6gRj67F+rHvQCfVXkxbik+qGZ?=
 =?us-ascii?Q?gQxfEEEYaYsbjEvi8ZtMP81i8GOiRZnnxkjgdIOR8YjOQfgnONWxXDkOvOg5?=
 =?us-ascii?Q?dp55xjO1Yuk8zOWRwH9Fk5I6DzXVzHGv6v0pWMJc1kjvfAFJcJ8a8KcdGwqU?=
 =?us-ascii?Q?9yVy+T1OzsGbvIO3rmEoJW8xrCBip/T8Kl9BH5WUA7CWpiqGxgZaHyOWqGiD?=
 =?us-ascii?Q?UJQQ2qIU4rk8EIULN2u36q3Qnjm44j+7zs3n/pg4DyGrBEuL/qWBusqLUDNH?=
 =?us-ascii?Q?WcmyV3qw4Y0/WyNkEMplnGdH3QQmO79KJR653FJQMqVtgMO30/RnysujqdDo?=
 =?us-ascii?Q?fugSSAjRACbTG6XvjACcr7v7OG8czTv3/El0u6Qa2kZnqjTj0KM7I04y9z6f?=
 =?us-ascii?Q?+8oEBYlPekuYN1536D04wamzFU7ZvoxIv7oRflqe6AokTMbhtsSCgg7p5P6h?=
 =?us-ascii?Q?CGPd8rRMFwkBoAQKjsYtKzPQdB+z6LP6FU8X3HArYZ/2S9ZlPVusXG064O6F?=
 =?us-ascii?Q?P0XcE4bF5ae8JkwSwJOM6O5jorHlMrB57nMZ4C+QjaHfVRk/jUDa5AzyfdSO?=
 =?us-ascii?Q?Bn9vFrEKs8hTWnigMe5dFHHsWMjDCTTbNdc+fg51mkqTqX3NsjQYbLj4w70A?=
 =?us-ascii?Q?NdGvdE5hDljW+IQ9po839jkM9Z/PtvZvW1SRH4sklL6Edn/16Mq8u5jvHsfP?=
 =?us-ascii?Q?iF0Arn48HUkRgPYjfyV93e4SUlF/uRZoHz0bSnrT2gE1WCI23gs73q5L5nmV?=
 =?us-ascii?Q?lAt9sa2DyZqOgrEfl/gJNGgLYhKiKwWAIFDK/V/DyBe6F4cPeHMq7Fi19W/i?=
 =?us-ascii?Q?W3ChdUV563eUTYpd9CTIsC0qYw2WxA614LrvW8OCqQFO8mCvGY2hiQBgBhB3?=
 =?us-ascii?Q?IPTzG1/r5b7jca1Ntam6l268fGetgTwFQIUrw32F7mprpuprWPJAPlcWCgYQ?=
 =?us-ascii?Q?9zboJwg/7v0rUTayrS0o/rduQfA9WxUU2YNfRThcCY45yf2pOkS1mY/yxeSB?=
 =?us-ascii?Q?s2Un7VuAncs5dnYPMiDF6NAWKGJbw70udpe0RouLP+tuy3Buo7PC0tSYry8i?=
 =?us-ascii?Q?ZCrUl0HTChkj6R4uxYIHz//UDGL+w3isKMCZT2xduvs3t/zhSrp0FjyPZLZe?=
 =?us-ascii?Q?7ZhHiaf1VwZr5HY6ZFAAnXn3HpI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e24688b-8074-49d5-6412-08d999ff4bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 10:40:01.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqySjusfcZMRBJqXAJiB819TbEDqON1105r/ahL94qGJs8a+FKc4EXuNY/W/6Ef6fIaimCwAUrGhUlfnrF04Ik2BkvodU0oVrV5VGWeHsvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5809
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110280058
X-Proofpoint-GUID: nda5AyvrS08KiDkj8zxvLlreFUOLu52P
X-Proofpoint-ORIG-GUID: nda5AyvrS08KiDkj8zxvLlreFUOLu52P
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: 28 October 2021 02:25
> To: linux-rdma@vger.kernel.org
> Cc: Selvin Xavier <selvin.xavier@broadcom.com>; Doug Ledford
> <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky
> <leon@kernel.org>; Aharon Landau <aharonl@nvidia.com>; Kamal Heib
> <kamalheib1@gmail.com>
> Subject: [PATCH for-next] RDMA/bnxt_re: Fix kernel panic when trying to a=
ccess
> bnxt_re_stat_descs
>=20
> For some reason when introducing 13f30b0fa0a9 commit the "active_pds" and
> "active_ahs" descriptors got dropped, which lead to the following panic w=
hen
> trying to access the first entry in the descriptors. Avoid this by return=
 the
> dropped hunks.
>=20
>  bnxt_re: Broadcom NetXtreme-C/E RoCE Driver
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 2 PID: 594 Comm: kworker/u32:1 Not tainted 5.15.0-rc6+ #2  Hardware
> name: Dell Inc. PowerEdge R430/0CN7X8, BIOS 2.12.1 12/07/2020
>  Workqueue: bnxt_re bnxt_re_task [bnxt_re]
>  RIP: 0010:strlen+0x0/0x20
>  Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 =
88 04 11
> 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89=
 f8 48
> 83 c0 01 80 31
>  RSP: 0018:ffffb25fc47dfbb0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000008100
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 0000000000000000 R08: 00000000fffffff4 R09: 0000000000000000
>  R10: ffff8a05c71fc028 R11: 0000000000000000 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff8a05c3dee800
>  FS:  0000000000000000(0000) GS:ffff8a092fc40000(0000)
> knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000048d3da001 CR4: 00000000001706e0
> Call Trace:
>   kernfs_name_hash+0x12/0x80
>   kernfs_find_ns+0x35/0xd0
>   kernfs_remove_by_name_ns+0x32/0x90
>   remove_files+0x2b/0x60
>   create_files+0x1d3/0x1f0
>   internal_create_group+0x17b/0x1f0
>   internal_create_groups.part.0+0x3d/0xa0
>   setup_port+0x180/0x3b0 [ib_core]
>   ? __cond_resched+0x16/0x40
>   ? kmem_cache_alloc_trace+0x278/0x3d0
>   ib_setup_port_attrs+0x99/0x240 [ib_core]
>   ib_register_device+0xcc/0x160 [ib_core]
>   bnxt_re_task+0xba/0x170 [bnxt_re]
>   process_one_work+0x1eb/0x390
>   worker_thread+0x53/0x3d0
>   ? process_one_work+0x390/0x390
>   kthread+0x10f/0x130
>   ? set_kthread_struct+0x40/0x40
>   ret_from_fork+0x22/0x30
>  Modules linked in: bnxt_re kvm ib_uverbs dell_wmi_descriptor rfkill vide=
o
> iTCO_wdt iTCO_vendor_support irqbypass dcdbas ib_core ipmi_ssif rapl
> intel_cstate intel_uncore pcspke
>  CR2: 0000000000000000
>  ---[ end trace b4637e4c4e3001af ]---
>  RIP: 0010:strlen+0x0/0x20
>  Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 =
88 04 11
> 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89=
 f8 48
> 83 c0 01 80 31
>  RSP: 0018:ffffb25fc47dfbb0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000008100
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 0000000000000000 R08: 00000000fffffff4 R09: 0000000000000000
>  R10: ffff8a05c71fc028 R11: 0000000000000000 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff8a05c3dee800
>  FS:  0000000000000000(0000) GS:ffff8a092fc40000(0000)
> knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000048d3da001 CR4: 00000000001706e0
> Kernel panic - not syncing: Fatal exception  Kernel Offset: 0x400000 from
> 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffff=
ff)
>  ---[ end Kernel panic - not syncing: Fatal exception ]---
>=20
> Fixes: 13f30b0fa0a9 ("RDMA/counter: Add a descriptor in struct
> rdma_hw_stats")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c
> b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> index 78ca6dfd182b..825d512799d9 100644
> --- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
> +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> @@ -58,6 +58,8 @@
>  #include "hw_counters.h"
>=20
>  static const struct rdma_stat_desc bnxt_re_stat_descs[] =3D {
> +	[BNXT_RE_ACTIVE_PD].name		=3D  "active_pds",
> +	[BNXT_RE_ACTIVE_AH].name		=3D  "active_ahs",
>  	[BNXT_RE_ACTIVE_QP].name		=3D  "active_qps",
>  	[BNXT_RE_ACTIVE_SRQ].name		=3D  "active_srqs",
>  	[BNXT_RE_ACTIVE_CQ].name		=3D  "active_cqs",
> --
Looks good to me.
Reviewed-By: Devesh Sharma <devesh.s.sharma@oracle.com>
> 2.31.1

