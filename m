Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C873C30FE38
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 21:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbhBDU0M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 15:26:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36726 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbhBDU0E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 15:26:04 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KJeDM136245;
        Thu, 4 Feb 2021 20:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=d6jKva1VP2IX+9zJZLtv9om75cG79glVzUbC2f9Pw2s=;
 b=Ds6dr7NRZ7owDzKZghCOeWdigoqjUmYO1LZpvW9WYgiAW/KlFO9emJS2AJSEE5k437/2
 KaJdi9tWto9Sft/nTNto//CYLTKGKmb/5Pmi/lqboonZtovGI0wyxpQhwTtoN9aOJLeD
 T0Gbv7L7/mfZcFljgrSo2DdmTrwESEdFgW9/1+uOnYVHOZA4ZorPhkFnLJwOoBivGN9W
 a2+bL4H6wBJ+H0QkLsUptyN9rVF3cTEOJ1mUjFmUuTJxADQGlVKThfYiIlGfdACKAuxu
 5dU2ZclKDhFPLoJ1aVx6oFFbRbHmHWitKFf+OtW7IN3GQrvLRLZ3K0XlSDU23XsSG+sz Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36cvyb7821-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:25:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KFcf9115927;
        Thu, 4 Feb 2021 20:25:14 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        by aserp3030.oracle.com with ESMTP id 36dh1sy19m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:25:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz8km7VeM5W1MAuuvxRyRVB+cdArqueK6YyEmsYR67XyJDh5zEMZTkKpI+/AioVkvc+lLbMT3+hubWkE+Qqb7q3cpjK8Rb9E9nMkL213hjCriBnvQIbIWQJq4y5fKV3E0CR0P78nO75nVybyaEW/H0h16iuB74S7DinPTxE22l8swZJXSo348kqxKK6xizrc6vNcGrH8KCImNeVGCKKVGgotjJOa/98M3dtXT86r4YEFzCYsu7XhGghBv5tVFM3ojHdHxF9WBCxwffv6FlWVLAvGb7gNikjWRDDujST0UNhCNoTBjtfBsQmry2O8+IvZPFFVkttApTgUeKHe4YhGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6jKva1VP2IX+9zJZLtv9om75cG79glVzUbC2f9Pw2s=;
 b=Ooeg7+uL+wqOcyoACF+byA1y6pyL8ALLhBjvrxZMi276ctjB1hdCABWGATKm6FwJ/U56Ws/gIri7qcDbYBo8xrvAa7c96OjLn8aCCDa6SfY6fyj1pm7fiigTl5/uscPJc+SGRopIZlXw+pqQ0ibfVekd5Xy/5b1tBQ1Ol8wAYsGadDCcpqFIoZvSkGbl/FirmGE8zH9aRKNdy8DO3oXToJtUP5/h3N3qJ46V0peYAkADLKQU5SUDfZs9Tw5CykXFkwH5ETNY9PCY/vF3padS+ZBeCeWyQgrHkVhB3YOYm7lXDvyrpW1mUH8k6brfhQMEgkworFEAznLim/KcyVtGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6jKva1VP2IX+9zJZLtv9om75cG79glVzUbC2f9Pw2s=;
 b=uZP3Aq3KM4xD91DjYg+WF4NKdXTAYQQSwfyMLSMID7nP30UrqbLlaCq5thTms4Z6a5AHfTdMXrG3szXvVw6149spbFVVZS09HzsewnmMin8ZKVOc1ZTyLWkN6dFhXcal0hs2QiFpeyWqOJEMI0TT91s1gfyRcmpMGklCyDMzzj4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 20:25:12 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 20:25:12 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 1/4] mm/gup: add compound page list iterator
Date:   Thu,  4 Feb 2021 20:24:57 +0000
Message-Id: <20210204202500.26474-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210204202500.26474-1-joao.m.martins@oracle.com>
References: <20210204202500.26474-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::19) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:139::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.21 via Frontend Transport; Thu, 4 Feb 2021 20:25:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c6e678b-b311-4a76-c3db-08d8c94af96a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB459093612C8DA5C78E94E16ABBB39@SJ0PR10MB4590.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHwwmslulylkuH0xyOD+Q7kW6CN3nXb7o+dUVL9gkm6PjgTK5Z6snOkfHwkZnhLgbY4hMpjY0/uhMsfdziFiodDTddfBa6+rVReYtHO4p4a0LgMzo70ZBOE7G0gE48bcguXN3zr0N0ZRoQVoGqLhs8BgylJ46saQSk9hJxhnZb30w9w/HocNt55v5visb7VoE5zF1kHbOcIaqc9guH13Xb+wSoxbFMQEiZUIUX4kfL2oeiFLojcf/tlBYVRjGB8LkTlCrGL2EmravUnVRdzoS1UzWRuhn+v7Sghy8SHqqFuahoirLpHRphkJ/TEsIt636R1G+sTgZxbyT2dV9UWgz7TpRdc/9cvPKJMtOgkZ01zCJsr1Vxi0/1d6NVZhvcnY+ecCMakxy9qOcxzfG2BAkJ6hCgdtjc+cCR9n5H/4JP5Iz0SP+HLGzS+s29DIHJSQUBqwKoavw1LaeFQiBPtqTcAnJdZHtT4A4+sWMwn+Q2Bh7kFke8JiVhm+et+5zDxbyazt7exh9p8Hu2VUryQ4XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(376002)(136003)(52116002)(7696005)(26005)(2906002)(16526019)(66476007)(186003)(66556008)(478600001)(103116003)(316002)(6486002)(66946007)(956004)(54906003)(86362001)(5660300002)(1076003)(8936002)(83380400001)(107886003)(36756003)(4326008)(6666004)(2616005)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?m1wE8tAvtU6PpGTl1WR2rmV+5m3MVIgdNEqtFiP776Ars11EkhOwb9J1Fapd?=
 =?us-ascii?Q?3hKET2wylNJFxr6VyjxFpX4ZwS/ahCmNadHOd8P773Cvq9lFnpHxqJRyzOM1?=
 =?us-ascii?Q?UbYqmkv4d7INO8fuS9C+7bHDfAkl+jzIxoakAftBQ485erpdV8TZCndEYMRH?=
 =?us-ascii?Q?VW/lAt85fmcG8Kp6T6BoEnkhu+EBeXOHY9Xez1QMCwJerY8tmfza9/58ESrZ?=
 =?us-ascii?Q?IeP5vLI+EBFfuIoGMdFuMCS5tT1W/Zh38yq+ZBjtgGCTPDxgkDfPRtFlVxH2?=
 =?us-ascii?Q?PH51nVC4Q0qF3IeMoNlhScTdmVTapPv6vutUlqFuYFlRtdzrzzm/ENHN7yJ0?=
 =?us-ascii?Q?hf9syy/yGBT3G0TLGqe74g3HT2EVI+o8GaRs9cuNtbShPFHgtS72OFkmU74P?=
 =?us-ascii?Q?5ov6Y8E1pKWItOhxQDnDhsQ2SFBHX++7x6Ue8runmjCvsv6rmWR9f9EYXohw?=
 =?us-ascii?Q?5Tb8hyHvyqTuv4pU4w8VpUoIDfjppOKrK2kmuX8ySCon562NMpEbYJjJsjSY?=
 =?us-ascii?Q?hx2k3cXALQ0iff1HXaSOQvwcF7bRI9T+NUBnDE3mf6Owf+vpGLbFwTfK+LFQ?=
 =?us-ascii?Q?JMCmfa46x2JBOKhp1woPGez3I9FRv44h0m9IA92EnqXXMRxCAyiuAlGRu9xb?=
 =?us-ascii?Q?tRq4mhm5cqsh5cetiAouDIbuwzfiQdqAo+T9T4SAV7FXz2Y7aq1MZv0VHThh?=
 =?us-ascii?Q?PUCu6SJy7UpYqwFqhzE3p/pSnRXsMiL1FhzDOjdshIxE+IR7Ecemlxwdv6sV?=
 =?us-ascii?Q?Q+G1KZbPHfWa3C+ly9bhV8AZlSpNivZB3Ue/G9lHVrbURykc7iDOLC7uzkQV?=
 =?us-ascii?Q?0cNYvVPt6tEPybH2I0/vNPVqxjnpkx/v41uiv89GuJisRrkAD/Atornpy/lm?=
 =?us-ascii?Q?e3BGrCH1DMK20NvS19LJ8cPdQcD6TDPMzPxRpJDpcP1ZraiyFBkiw2KPkpb4?=
 =?us-ascii?Q?GDNSLpO/7miH8JaupNtNJL5I238bHX5TuLqn7hnswIVCoJ7vV2rUd8JQoODC?=
 =?us-ascii?Q?+zy6zWTL8O3AgkDBO1CrYhDJTA1IOGj6vLvXk/0yZxyVQ9nOFV1Pzi5x8+zI?=
 =?us-ascii?Q?LvTxe1CM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6e678b-b311-4a76-c3db-08d8c94af96a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 20:25:12.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IH/VBeloAIpy0vPpf0z39JewxA/HX0KC+hVcu9NSM3mQ26zDaS+OuRrSDF03J17QRAumLrMp6hrqAXdZtlIbZ08aPCd001SCgpQU+XYAnek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
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

Add an helper that iterates over head pages in a list of pages. It
essentially counts the tails until the next page to process has a
different head that the current. This is going to be used by
unpin_user_pages() family of functions, to batch the head page refcount
updates once for all passed consecutive tail pages.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/gup.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index d68bcb482b11..d1549c61c2f6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -215,6 +215,35 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
+static inline void compound_next(unsigned long i, unsigned long npages,
+				 struct page **list, struct page **head,
+				 unsigned int *ntails)
+{
+	struct page *page;
+	unsigned int nr;
+
+	if (i >= npages)
+		return;
+
+	list += i;
+	npages -= i;
+	page = compound_head(*list);
+
+	for (nr = 1; nr < npages; nr++) {
+		if (compound_head(list[nr]) != page)
+			break;
+	}
+
+	*head = page;
+	*ntails = nr;
+}
+
+#define for_each_compound_head(__i, __list, __npages, __head, __ntails) \
+	for (__i = 0, \
+	     compound_next(__i, __npages, __list, &(__head), &(__ntails)); \
+	     __i < __npages; __i += __ntails, \
+	     compound_next(__i, __npages, __list, &(__head), &(__ntails)))
+
 /**
  * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
  * @pages:  array of pages to be maybe marked dirty, and definitely released.
-- 
2.17.1

