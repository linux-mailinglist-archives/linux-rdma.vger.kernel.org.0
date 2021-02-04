Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5763A30FE37
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 21:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbhBDU0L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 15:26:11 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36724 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbhBDU0F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 15:26:05 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KK2Ij136559;
        Thu, 4 Feb 2021 20:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=z8XNkIOJB3++sM2ChemHCEjB8h4QyKCc45ubyIZXMlI=;
 b=SDPprUl+6GoJGETxm8v5Ow9fL9U/vndE2p2lRaaiGbd7Q2KL1PWrbO/BKPPQoaJH4tFE
 GQkbizq72nzC34PttGepfEGN94Ixkni0cF2YYqztjnbXZqGnX4rZTj1lP65XlJm8Ju6f
 cZjR8dLWEtLq2WEVqXuSLKlSVXySw4Gdj+PiP52diz8qiRecauSDQWJziJV6D1EZO+72
 reucc8dqIYcGgek3kIL2nsVlvI/P2mk7whyTuwBTDd3QRagLEEYmMlpxw2LerzAbco9S
 fPp6zDzlH0Nvp5+0/5+d9jjIjN8co4RwZhjGGKNR1Cv+6jgwFbRiZpwf30H8yQHxQ1NW AA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyb781w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:25:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KF7iA155864;
        Thu, 4 Feb 2021 20:25:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 36dhc369rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3fCTkIox016spxStxZ1cT8ElB1mXXpdDv8TPx4sQS7FoPV9IFZ8hquV67FnNO4tzxhWdFeZB5LjQOn3Uumrx2ExDL74KaKfgcc0gR3F9SsfFvKfBaDt1aWANUve2DFqdWzYC9KzWLmMKvmuZjO/KbEJsi2SmeZC8fB+ZkpODpOzrv9Tnoe5RU5mLf83HTHgatKLcMAXOZ+gKhfZsGTJS0oGYMkQb48VcRy99Osj/7FLIN2XznKXZrtrMZYYIN1EOHNAW4rVj8UdCkiAfbm3iCb8OVHan73ZptwtYAhTpc25oiI0PnqtChnDNvLPSkM5VyB+PIhZl/HHq/leBcZ9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8XNkIOJB3++sM2ChemHCEjB8h4QyKCc45ubyIZXMlI=;
 b=Z4alHHLiZDlVR52z7G59T3gl/KsZa3v+p4wF0XCD2OKM3nvu3fS20sYsNUBlmsI+U/c/nd4BTw2FqD+/wNORDqdeDXBWmPAwK+TVGVkEpNa+MbIHI8wTc0dQzf4Xs+uyBToGSHwZFKtdS0VqIpdFtl7ffjGX93XbSqghunQKCnG9sGwnfMdbCm9nFtVC8saVOgTBmDfyBeJpoE/ex/Q+z9EHEQonWuc5dP3dPumJHMWLmOjerHxDyJjZmpG5lVUPgejVcyduTpxvQkZ2C0Ze0bJhAuBoqrlnX+zg91Jvy8FVudMCTpd1nPeJpuQWxjWxql9KGVeGfDGS81NIAFWXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8XNkIOJB3++sM2ChemHCEjB8h4QyKCc45ubyIZXMlI=;
 b=gYTsCWRXDwTOHJyhJpxBWYupOSM3RgthOV8i4QrrHHGaIBI1xOqq6SnkMg/Qli5geRVKqoOT69aSiYUSKtO0L/mjNZxPKZnVht/OcHx7eDxj/MPj81KbbKsdBceAycV9YsRsR7q49irMo0nVfn0hdOGQd3Ejex+0Shue93OQdXs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4114.namprd10.prod.outlook.com (2603:10b6:a03:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 4 Feb
 2021 20:25:09 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 20:25:09 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 0/4] mm/gup: page unpining improvements
Date:   Thu,  4 Feb 2021 20:24:56 +0000
Message-Id: <20210204202500.26474-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::19) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:139::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.21 via Frontend Transport; Thu, 4 Feb 2021 20:25:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cf37526-1ee7-42b6-9184-08d8c94af7e7
X-MS-TrafficTypeDiagnostic: BY5PR10MB4114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB41140B00FF4940A90372F87CBBB39@BY5PR10MB4114.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ulOR6FnaMqKvzZSoJy2j5tx6IrkMbm9huFMIXLDAtvCTEFGwjRON8aIeZng7CuCBpXMO5v6U+bGyjAOoVLZ925OdGNcMEBXSSQzRUaV0ohaNwwA4tntMN7+a8+dEVT2WGSzqz8tklArkiSl8/CpXtyUw17eLUCprZxlllEg/u6E3SRxWFQ3vR94EXdvu4SKQSsZwLatguHLBviTrV4Tih3RyaGhI1z9Hy1JWtgURLx9Iii4nCGNMUTJKG0pTCmOTAl/8qMpquqy2EvXC/NTCESbsaCqKObgYOVn55gBM2VAYpMValLb8DFBve7GrRw9gMRB5vUIbA5wVHvnmhCsc6a3rNLDe/e7ENZzUjqO1Cf2HWqNuobHIeO2I44j37zcqhPxK2REfbJFMNOWHAKBWwtyvLuDP4XZuaXsD61Xt/GASH8Lf33b/9n7QXcUocfhIMcUDrd7HjCmKjm5laV0hNvrAEZH/aM9EE6e5SqSyIrJwTulMuDkiY62Ds/8tTqZd7aiEVQJTCmryjo4ftsQZlpf/nFkTk4gUSRdnFMEI1FKpLjlARS9f8GJwVz2tAZmlh4BtOAycdGHpeG1nP9jTfqVpEIzkkDZq/TQns9ZdrY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(136003)(366004)(396003)(83380400001)(6916009)(66476007)(2906002)(316002)(478600001)(8936002)(66946007)(66556008)(107886003)(36756003)(1076003)(966005)(86362001)(2616005)(5660300002)(7696005)(52116002)(186003)(103116003)(6666004)(26005)(16526019)(4326008)(8676002)(54906003)(6486002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kSu6mODBTmy1/hMRKw3VxlLHT6Dqyp1ssaeHHMLYVcE79EeDGSUROzy17S3V?=
 =?us-ascii?Q?s6AXW4/GFaKEAgYegtCJss+C0+I/rzqRkeOiqr/iRyo5tGekAn0sxmpXtKkA?=
 =?us-ascii?Q?nw4sCRTe1fPXnJs1UFrKGx1RyD3OSkwfWK1MBxXwIlcPFkPbj/WJxzg4DM6o?=
 =?us-ascii?Q?0s8avXdEPKi76C0EXjulwSN5IXn8DC2jth9or/N6lqhmyCmAqREf2MyPf2te?=
 =?us-ascii?Q?ETpnP6dSK3UB94OOw+1po0lUK8MzFhQjhFb75TuApEjHmEvDXkDK8l1b35Be?=
 =?us-ascii?Q?cgvThqq4z0keePVLg5wsYOGZJv8zDBmm5NlvM/MJqd+CH8b1VqhWZk9qTJY5?=
 =?us-ascii?Q?AdPcOxLKxC+TqNeOfwNsoNLTukRhzwUplrsPv2VXXQ4WNlFVwirx0B0uEMXw?=
 =?us-ascii?Q?CV+A7xSRQEgNYVAs4hN0Seo7Wmo2LcTaxh5GgDuRIe/FUnjFd5GogOjqxtzn?=
 =?us-ascii?Q?I7AXa1Qg+LiFwgGIV9K7s09Gu2Tvp5F/2t6t53yadEOxFPnCqlD8VNHz5Zfo?=
 =?us-ascii?Q?N6kTOrMNBCZJmI3mymhIgvGupFSKTIBYfqXBcEoOLSnC8pBtWFzeGOl0FS83?=
 =?us-ascii?Q?0cwlv+BMo79SlAabaypGbJzvtrp4ZUzvYLxPalwcvdQ7l2dk7Lza+AQ2jws5?=
 =?us-ascii?Q?uK7PKqiKftz0OO3pp122V7s40RHmwzUAzNszWR0D7ahNg6l3RH4eFPaiLYI1?=
 =?us-ascii?Q?LWsppHfPtZ5bt9ilMDZ9xzG1MQtjmXjsg7qZWMxoNnj46ltTXBjT6ya/P46E?=
 =?us-ascii?Q?kWwKBZHjSnvyduc4fPGg7TaAxtuq8JIGArBxLQLIeWi7WHFtgbO+imSpmgDV?=
 =?us-ascii?Q?VWxlBvPVrgFTG6Fd/FkYA3nvUz/7Sd/rdQQG/7PYm7xE7KsvHDENpWyaO2J1?=
 =?us-ascii?Q?0vSk3dPdUFcel//N0MXc8kwmULCPIFjcgqSYqfurr6nnONUKcmAqJQPX2dE4?=
 =?us-ascii?Q?8DS+uzeHFyGsw8wLz3ZOU001iDBxu2FHBOGypKL9TqYNbvG/6iaP11lZze/5?=
 =?us-ascii?Q?CCUDYRUGTsmnfJUm5FhGp1fVOnb5zn9pm6wdyiCTIYa5eolJeIrzqCpQ0NsB?=
 =?us-ascii?Q?limkyWt0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf37526-1ee7-42b6-9184-08d8c94af7e7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 20:25:09.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAzbkEH/mBLpO9ohH7uJtBTv4j6Nq12Iv8yogVBPH/XIZQsrYB4a9YDi0IgW43TNtM94/b6OKPANMXXIJWievjXVaX/uW2xDVlYqkzepCL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040124
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040124
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey,

This series improves page unpinning, with an eye on improving MR
deregistration for big swaths of memory (which is bound by the page
unpining), particularly:

 1) Decrement the head page by @ntails and thus reducing a lot the number of
atomic operations per compound page. This is done by comparing individual
tail pages heads, and counting number of consecutive tails on which they 
match heads and based on that update head page refcount. Should have a
visible improvement in all page (un)pinners which use compound pages.

 2) Introducing a new API for unpinning page ranges (to avoid the trick in the
previous item and be based on math), and use that in RDMA ib_mem_release
(used for mr deregistration).

Performance improvements: unpin_user_pages() for hugetlbfs and THP improves ~3x
(through gup_test) and RDMA MR dereg improves ~4.5x with the new API.
See patches 2 and 4 for those.

These patches used to be in this RFC:

https://lore.kernel.org/linux-mm/20201208172901.17384-1-joao.m.martins@oracle.com/,
"[PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps"

But were moved separately at the suggestion of Jason, given it's applicable
to page unpinning in general. Thanks for all the comments in the RFC above.

These patches apply on top of linux-next tag next-20210202.

Suggestions, comments, welcomed as usual.

	Joao

Changelog since,

v1 -> v2:
 * Prefix macro arguments with __ to avoid collisions with other defines (John)
 * Remove count_tails() and have the logic for the two iterators split into
   range_next() and compound_next() (John)
 * Remove the @range boolean from the iterator helpers (John)
 * Add docs on unpin_user_page_range_dirty_lock() on patch 3 (John)
 * Use unsigned for @i on patch 4 (John)
 * Fix subject line of patch 4 (John)
 * Add John's Reviewed-by on the second patch
 * Fix incorrect use of @nmap and use @sg_nents instead (Jason)

RFC -> v1:
 * Introduce a head/ntails iterator and change unpin_*_pages() to use that,
   inspired by folio iterators (Jason)
 * Introduce an alternative unpin_user_page_range_dirty_lock() to unpin based
   on a consecutive page range without having to walk page arrays (Jason)
 * Use unsigned for number of tails (Jason)

Joao Martins (4):
  mm/gup: add compound page list iterator
  mm/gup: decrement head page once for group of subpages
  mm/gup: add a range variant of unpin_user_pages_dirty_lock()
  RDMA/umem: batch page unpin in __ib_umem_release()

 drivers/infiniband/core/umem.c |  12 ++--
 include/linux/mm.h             |   2 +
 mm/gup.c                       | 122 ++++++++++++++++++++++++++++-----
 3 files changed, 112 insertions(+), 24 deletions(-)

-- 
2.17.1

