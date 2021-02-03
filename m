Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06DD30E58F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 23:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhBCWEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 17:04:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34674 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhBCWCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 17:02:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113LxEHh193465;
        Wed, 3 Feb 2021 22:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=b4/HS4k1rLH8LdFQNtv3Oi4c1sNsyD+tJO3L4GRJ5Gs=;
 b=U9T6RioPBT9L2Pailx3mUjV4YOWovamMTRbLeXNdE7yIzmhqwGeXi8HWEp5Bqzq7bG8c
 N/7eOs8a77mVTYLAVHV0MYIBewd/XSPDAZ1gTaERLPdL/VC8mFVsNsv/lCy9LMKuhVol
 fvG++AKUKcwDNxvfPl+BsJHsj08kL/lY3ZSouPQZOKm9Wan/a50VqXzmASgBwFU/YkQu
 Jc8ttBOfdeO95MnFXYo2+bMS9gDBTqEBKg5WGmgnoU6AQzJ9XOig34IoFokerTJhQwrd
 ApeajURijb4rgzgtNv7leOEZQkDSD7HNWw92kzO7AR6R98YxKBsmPljq4hqySSIugCOG Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydm2e0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:01:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113M0Ko2067642;
        Wed, 3 Feb 2021 22:01:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 36dh7u743b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI75p2S1wxqx0gM00NfJ3IykGkE+moh9Az08Mu4oadAnR9nmSM5H1+OZYvfrugU2mRErSQ8T1E5TZouYkRG6kv4e0tHmanZzM2fKmMhlGBVQDdyv7Cfcrr8zVjfSMs2XUOaAvsEy1oKUUJEoQCyzYuO/Z1lyYuo05sBmz+aoLNps4h8HJmFptkgpZNwxpmeH7dmr3yqVbiquVVQI1twMh6yKJX2WmXAZ86WHHnWwqbqbH8J0Hfjr7mYTmtFbYvZ6RZEfsn2Y1J1e8BYO4/jgSv5h5yZ2Dhhv1R+Cvx2su7UyU1kUt6n9r9h/kSEXIah0Vp3oKPUrC+xwaKMfWmrS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4/HS4k1rLH8LdFQNtv3Oi4c1sNsyD+tJO3L4GRJ5Gs=;
 b=ds58BpQHTJMevY66cSGk/u3jWzJnxQObxwlnuo09DS6kz25rsAsEzBFzS/prrnn+fKYfBIYujKaBazaRFDJ9SyAS0LdktBvQwR9cATOXTZOrK6E9RH6WcMZxRqh3AX5sw/PpKHezvK34/scASpqwmPpboegFAOR1+xm1N260x7t2iqBfO5bbTfnrfL48QcdEMEu5EDcji7tQiks/lub21enqdm9fRfT39SmBWJq8gcOJS3/hmukgkvqcFs5bLRb19CpS0YvtHGzOyUhW8SBs3SMuLUeas6y/8x8fPa4Qqb/akS3V7OBJPKKxDo4ZElQCvamUFkr9VpuYUhE0+W7Veg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4/HS4k1rLH8LdFQNtv3Oi4c1sNsyD+tJO3L4GRJ5Gs=;
 b=BUJnH8DYKKBBARYcy7K+kjNA5Ehh0SE+JEY3vcQjzSI8amkC1ySQ7xVYG8A/E5QnVMEXxXnQr8UvNELI94OFR9+4JfGnp3oK4v3viTMyVxVYnbOXpPe7Jnb7uNq4W5RDFXPgMhiIaP5dXcP2dNE960e+0Mkpia29cQhju2LgjsM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 22:00:57 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 22:00:57 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 0/4] mm/gup: page unpining improvements
Date:   Wed,  3 Feb 2021 22:00:21 +0000
Message-Id: <20210203220025.8568-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::19) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 22:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a928e48-0e23-4dab-f194-08d8c88f2f69
X-MS-TrafficTypeDiagnostic: BYAPR10MB3077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3077B5EB7B2A49813A85CDB4BBB49@BYAPR10MB3077.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAf5467yFWxzXnbeHILNrpPa5gGNlmxWoD8hdS0ogSRtUyBT+YzRsjwkYFJXqCY9CtU39KnrIksDZhnNmxyfuSzMIX4f/P5dezy86+cppuoofPVGi3OQdgM04M+e3Tlc9XVmPWRx2sub/q82nK0SgHrf7zn7v5yuozEJBczmWgrpDiIpHi1Zn8LxF61ec8G6NkEyi5EX1QFJHE5XT7ULto2e/s3epQlYKZzqQ52r8/jJU3e5NfCuQRnVJ2wK2N1KsEs5a83DsuvXy4913zJCqntNTGGYBKWxP1AQXYCl92QUYCphyVSs3SCjb+WK9KlKzmzqWrelNo3HJKvu0L/xPL9P1vtKWcXnhSOrMM00ywGAiqXYbwb8f0yFdIE87V+Nj5TkPRveHK/6BrcOJ1qc3xMvHTw9tXDI+Rzj8LUF8MMFZmjiI6B7t1gOxH5kiXQUGSpAmQWuDPRH0zQ8g2MtK0ixkq6SudcevzZKHgaph4Hq2uZUmACOVIA6JY4rpqDahc1Oq9DbWxiks4Q9ToLH0wAwaFcxAZL4s1e05v6Ujqs1Tn5hYrY8O/THtONDR3oTD5VbePMk9h8LUdlH3Ox3JwQNY9nbF9wxaoHeV7yJHwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(396003)(136003)(966005)(6486002)(83380400001)(86362001)(52116002)(5660300002)(1076003)(478600001)(8676002)(107886003)(4326008)(26005)(36756003)(2906002)(103116003)(16526019)(66946007)(316002)(54906003)(186003)(66476007)(8936002)(66556008)(6916009)(7696005)(956004)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5GMgPp4gj+pgqG8yzddot1XAdyHjfYocO0FOGpooB742koR4vhTjFyqdQ2wX?=
 =?us-ascii?Q?HP2AmfV6Z3JL35+Gc4YQy00aKYeCnoyE2WgNBql9RDrF202IBS8V4Wm5ry8p?=
 =?us-ascii?Q?keTOMgjss9JklqbDY3oXdryqHZAvB55YsOSoKdM1wCoJ50hIRDhRGNf+c6Ii?=
 =?us-ascii?Q?AVy/m5dVnQ5+WkX4o0vDvqmfM2BX24wgzngPCOFsNTNKgKSAuAp4boc+dX6t?=
 =?us-ascii?Q?y5altpWbNDZ7x/JwWbFxRucwh2RQ3ZVeJmcloSpHpS31JQM1cKZ+0jkFD5u7?=
 =?us-ascii?Q?EuY3iqTluiR0YAf/4EPl84To19+jXEKpK+yrXS7Zd8m5PYn77duNgOuzX2EA?=
 =?us-ascii?Q?ksTjHTh1j4aTAV8QQURgb1x5AGqQA2Eq05KX/6iB77WeaM4k09Vj2I+Yjpcy?=
 =?us-ascii?Q?fM/O8ktqhK6mF4WDKbG4U2vwVZOzXGpyHFuQC5MOUuhh2Kd/3zE/YecTxdRH?=
 =?us-ascii?Q?nqkeDgLRo+TrEE/RdXWgKd4Mbo6/nR9uz7xQCIYGQfmOIxzVMkANJEcrpeU1?=
 =?us-ascii?Q?KHpMQBzVp4Ydos6Evjbv8eTMKJUbH6f78mZ3MMs80BtAu9Key6iwX12dJrYw?=
 =?us-ascii?Q?hN5Z3Oigeqncsk2TLXx7PlQjmxOhTnfZTpzE5H2iaPXmoszYt+r4rYIFYhxs?=
 =?us-ascii?Q?FXOLwlRZsjtjCnlKWcaajRrXZkObKOC5kiTW9gKLw/BxrYbGsnzqXXiWUZjX?=
 =?us-ascii?Q?7JwtucXNpONMnpnNqCtjTSOS2igWxqe3fiaInxPO6g1Xm9uIPuKC9y5lORU6?=
 =?us-ascii?Q?BPaHA3tu/FMlae8ZeM5H6A3Y2dqPGh9xDP3MbI0RrCeBBSDPFwS2CHfrWAYS?=
 =?us-ascii?Q?L5JiI3l2QOC2G7IquIwWnODL4d4SriVQsgq6xOWUjs2k4u4nGYt04adnLVAG?=
 =?us-ascii?Q?ULUOGe+6gCWMKE/5k0JnvaMRrb+0twURcDfX/DikX8YeSZGeW++cKhffvGma?=
 =?us-ascii?Q?elOoEVT7g0/dcUIbQcsyjwA1DZpOoUJ+IAmS8IB2PXvgN4qWNdzRYh6JUgw3?=
 =?us-ascii?Q?0U0YhknJsm3H/h3d0RbKj2bMpMMickCnx+8yaNydiFiwvSGQ7TTb7W9Y2eaM?=
 =?us-ascii?Q?tYoTusfz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a928e48-0e23-4dab-f194-08d8c88f2f69
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 22:00:57.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4ufb49CR512Q2XkQp7dnI7MF88mtDoNx3nkn9wXymJgAx4uYj6Tg1QIAYrUtjy9lPFESmEAc9O+n5lP0LqGtass4KlVQmdPCyQHCYccEO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3077
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030133
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

Changelog since the RFC above:

* Introduce a head/ntails iterator and change unpin_*_pages() to use that,
 inspired by folio iterators (Jason)
 Introduce an alternative unpin_user_page_range_dirty_lock() to unpin based
on a consecutive page range without having to walk page arrays (Jason)
* Use unsigned for number of tails (Jason)

Joao Martins (4):
  mm/gup: add compound page list iterator
  mm/gup: decrement head page once for group of subpages
  mm/gup: add a range variant of unpin_user_pages_dirty_lock()
  RDMA/umem: batch page unpin in __ib_mem_release()

 drivers/infiniband/core/umem.c | 12 ++---
 include/linux/mm.h             |  2 +
 mm/gup.c                       | 90 +++++++++++++++++++++++++++-------
 3 files changed, 80 insertions(+), 24 deletions(-)

-- 
2.17.1

