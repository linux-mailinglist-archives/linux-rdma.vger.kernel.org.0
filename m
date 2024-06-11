Return-Path: <linux-rdma+bounces-3065-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9A90438C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 20:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05020B26756
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 18:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A814AD3F;
	Tue, 11 Jun 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="HEJve3rE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06774BE8;
	Tue, 11 Jun 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130484; cv=fail; b=eeZIWkohAwQDkjihF2oJle41DTZqcLCt5JTtz4e4EnNAzn5CDsR2ysQC7O8ro3nHfUTzH9xfKbRfN+muzEow3C+S/hk0ma84XBrCjMcoKQa5yKjx4GJWtZh12uyc2Stq8wYe8ku7X/NmukC/Bp6P+4nJtusWiT/A/2R4XI2xDg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130484; c=relaxed/simple;
	bh=1qyHICxpg0eWsR78ZtFM5nNtkrN2NQeSGHqo8ejVsY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qOcisc30SX7V5C96xd4IZ1S815dF5tAZ8CVBeVWacvrQYMJc9d6JTB7go7kDI7z3IYdlXlgSI860I2yut5bJwex9lOFMhg4xPWew1//TbKhtkaJgnmZFutQmTKDoeTzNXTJMu13y3mbDi/S66x84shlM5QDP08Qt09ZVWvEqp/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=HEJve3rE; arc=fail smtp.client-ip=40.107.94.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTy3VFsaMVs9IA4dnVMq1VHuRujiPjQGjQHgVIKcyPw6b+uabjIKMIh/5UenG0q8ja2R1cxV+fB2mDpdJmZgdK6ydF8n+Z/3R1tbORElAJZ5V82bek+V+szUPC3Ws7Cf9ywcQZnfmEiiKW+geTB36408WQTisJNBVI/Fx0CQlUaBQp49HIr5rBvUshzd9l8QsVfDDKslTU7igN6dO0gPwGGHiaRQnWJJWmn49lmBVotLSmbpPqa54pbCl/mRjIxOmcHuyGOwAADX73tdVCEn1fhApHIyXSyz2UEE8zkVTJ8yCbdwl7iozna+zqHfeHH5a/eOCD7jryVITvf5wA0skQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltSVTnfSQLBLzvKgi3YJev86956nJV0gsu1ICDHeH08=;
 b=meZlq2UEv68OI0eWIgMUPr0STfLcz96Ewe2fcCcBYlLJSpBJno6nn1EBqNULjsGduoRrLcQ+Ot/ufMMaeMrIzpWhhOcpw+tMHCkayZVvP7PJnUr9B+xzaFhhMBEll7y45qHUsdhP8jrUI7VaYyCmjxgVnuwljSMj4oqVREG3M24gEusP2WtPqHI/8FRiGfeLI6sxywMr5d6GgfR3yGNZnPL25dttmfJl9uea8b0gCxo/dohLfVgGLENEXVW4wwiMW3QpJH2Wz9FGYZ+xFHML/D7n64pVsIA7xTLoKR8khp5W7ZfnG3i6b67n3CIr699alL8j8/75GtKX0KpouLzJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltSVTnfSQLBLzvKgi3YJev86956nJV0gsu1ICDHeH08=;
 b=HEJve3rENKbMbnHsMLEdUMGIApejn1xirNlUhkBn+o6RVl75vidmlG+8T7qwcXSq6H8VIRpetsF9ZJrNsdITs/prFiKGzOKX3pmHIFSeYqQjKDhH+Gx9YXsJaf+5JNO3Hx49MX4oRMCG4zPGsb5VZmEsQbIolzXKTd1N3HstWMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by BL1PR19MB6105.namprd19.prod.outlook.com (2603:10b6:208:39c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:28:00 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:28:00 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>
Subject: [PATCH v2 2/4] mm/gup: handle ZONE_DEVICE pages in folio_fast_pin_allowed()
Date: Tue, 11 Jun 2024 12:27:30 -0600
Message-ID: <20240611182732.360317-3-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611182732.360317-1-martin.oliveira@eideticom.com>
References: <20240611182732.360317-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:303:83::28) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|BL1PR19MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 78715319-eaaf-458b-c874-08dc8a44392e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RRYhFr32mRS4mCB0QCqgCeM9RORNURaFDYxjvYtxb7oTFhmfUWd7kHUnMNd1?=
 =?us-ascii?Q?1IeOqOaVnxd1dxxD7HHDv1tc/1LwAtt/8gNN2HDJC8PPNvVUdz3osKdREzSu?=
 =?us-ascii?Q?EaYUsGvrfCDtjWJmspT/NCJBd98KrCsxOK7NKSWmlFTKwoYbtc7JMpIv3Kr3?=
 =?us-ascii?Q?ozzPZ7AWtDwY7QiQcRGEf/SfnCYu9Snjo9Sl8lOrDgPV/Hx1jdCXBLMvojKR?=
 =?us-ascii?Q?NyazXBCdz5s5eWbHXFCRy3hiwwkBbTvUFkhSMtjIk1o7kHKCFadNzBeRjQ6q?=
 =?us-ascii?Q?wZP3CWi7FkFanlexYot1WgYmB2vBFk27sYvGJtvd3lJGAk0GGX4+Bq2E52Si?=
 =?us-ascii?Q?cjsb8iwG7WY7zMMsU7Sj0aQpC9QKMmS/d0l14MzFZW4bkBaj0jt6RRnhlVwM?=
 =?us-ascii?Q?v6b3Y42Q1vqogZLtYBcmwIK2a2tA5sCN3EmGPID/hIIO+3+8qLViRHrtEnLb?=
 =?us-ascii?Q?U3zB2DtvhIyjGLf6HmrqZCfFizMVT7W2FOo9tNDDMxT9XAUB5X5SafFDVRdf?=
 =?us-ascii?Q?1BHN1yAvsZbJLSAwmNMC3dqjUdCKp130TKA1lhOHBO7gOQjUkI8dG/sohEaZ?=
 =?us-ascii?Q?2JRrxgjj1seWYkOXw0n+iHl7U2OGekAN1P53D/sziMfY+a41Xt2XXYobRaZs?=
 =?us-ascii?Q?VeqtP5Xb2LWwVzJntO7wTaqNbRLb1bl/mo9zj12fzAEgEGsOy6uDmyamN8Zg?=
 =?us-ascii?Q?SSFVyXkAmo/ltLbqv53owhDzYLKnHvSu2JimsjVa7OqpyK7pKvfb3WmVTUF+?=
 =?us-ascii?Q?85CfKmLj3u8Dq4jdigbZJh6DB5LIin/hLxMeBAxLGKCk6byKgkwV/2MEBx0t?=
 =?us-ascii?Q?wTTqvXjpW105XqThtDT1jbM1ovKChB4Cgiwj6MqTOtHVPnXC/49HDmQV63Qp?=
 =?us-ascii?Q?KvTEsN3cQ3XME+Pfe/Yu0it+mJJH0JYecEVdCZHv89vXXbT+P9Wy9JbDlWDn?=
 =?us-ascii?Q?ZtQATYffRy/RAzYlqj/7KpkrhaDPpS8Adl/WVONHo0RfgvAoDQdRTec8nosp?=
 =?us-ascii?Q?GiOo5I7rp5WFHlxEVlSd5s+sdv6kAk9KfuCU6nLFUIxNFSAfOnet1fFe7vh4?=
 =?us-ascii?Q?DYIsCtm/z2/qMQs0MKshG9Q+w9HrLpRRNNrqYEVJtZGSovF5UbW2HBGvaTCB?=
 =?us-ascii?Q?ys7LczK42lbiqPhQBIBco+Y+6C0wa60hbRFiXnuMpmJzRR6+4nrw01Tc4PAL?=
 =?us-ascii?Q?Il6C/evMR1gNgbfP9gv38mQAH1rvo3aMRxYRf1cZNoAX/AaWem74/WfdNtAn?=
 =?us-ascii?Q?pPi0tKnEJa7Oc65HeYQI5rvyF6wffJ07vtenUWu0dbqjnl0ZAFDwy0M1qeFK?=
 =?us-ascii?Q?N9jC2g1TvMBsGa/U2Gb06elXdZvTImFsqldRpRRzXBYdUlGhazYlUNrrqK75?=
 =?us-ascii?Q?a/Sihls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?snBOHwcygg3ghtGStEnwZeut5s/ucWDTffUeYOj0/XiePGJcChY+GeAguWri?=
 =?us-ascii?Q?PHjMft0sYKlz0fngc2dvxIlKny8GXIS7shkH37g5jynub55pM3o9byVgYui/?=
 =?us-ascii?Q?kEqn1egQi4x0TJRJh8hV73MZa9Qs/kt/jlq2PBuIQrgVJ+gTGg9jdQffXGU4?=
 =?us-ascii?Q?qoN54mmFAwNIuIXtNFUhqd1wxmjgTui2lNbesL+h0TzT4/lmRd6Np0Z5hzhJ?=
 =?us-ascii?Q?14aqyx4VWR8QUqfe98dNA3MUrmerr/+5mBve/0Q3i3P658tiDlDA3/29+fGr?=
 =?us-ascii?Q?obSlxMdygWbinmj6kX85AB3JnM2xh40vnji3Rco8vNVCjpyrv+EMGuZBB81n?=
 =?us-ascii?Q?nlLgf+HeUpunT9xcCha0pmKcz1ZjSPvgNCjkNGlT1qzhrvgfSr3n4+ieR7RM?=
 =?us-ascii?Q?W7IaiRh0QBbnusVWXjR9MIdGSF5NMTLVYt39hNvoqoBdwhPhiWzo9a61YXzQ?=
 =?us-ascii?Q?5eWZmbLVLnPQnYWrJQ9lpk2EWEnCaPPcF5Oepo2NeKzffdYkkL7dMQmPo5Ce?=
 =?us-ascii?Q?Jsc0+gOl6zI8uVXAB472ILvbTrgAH0XRQrewhPK8MT+MLXOjIQ5voKjM0s4Z?=
 =?us-ascii?Q?9rGd9EUwLiq5bDzZ/jNSuyZgyV88OBTDVXHYWSGVy9Q3mh8dB/cklzcLdGIL?=
 =?us-ascii?Q?5zcju4lqOGeRcVPzNEOGHM11eORFqk+UZTXDYE5pvJ8Jc8BvERb8mC4rPc3x?=
 =?us-ascii?Q?DKNX2Qor995DT5Z49tTsVSAZC59o9NLvUhNVmc4iB6rsdO2a1Fw3oHaNEJtH?=
 =?us-ascii?Q?uo9zg6j8QWq1rdvzEOYBxMoVZZ3+kGkUxjkOKWx59b6diWbYai4ZTGMi8EEg?=
 =?us-ascii?Q?zEaRTmsaQB25xuZY3iYY3fz5NfLYLnWpIGt7UBHnSoY+SF3AHj6M0qxiWa0M?=
 =?us-ascii?Q?s0FPSoW0Im4XrTSIsd4DEKKpEYiBz0xqhgPhjaD7Xj/4zXCAOKNKnwXYSxr5?=
 =?us-ascii?Q?p7AnTHcWxoGveMM/UxBYAPpNggzltZ9fPy3ZqR0C3cxBAJ1HPCB7UyHGbtTs?=
 =?us-ascii?Q?2vw6u74UdnlUlews/zBn0sgUGmyzfWsNN/gp8tw94K+k30HRh4oBpF//PvqT?=
 =?us-ascii?Q?n3G+cGvqqPWpLss10kPX0o5n5B3gJsJroflb/wY5D5Qt5AtRy1uC/68ky0Rh?=
 =?us-ascii?Q?LIXLNTgyZslG16S8+NMWFGSYfocQXROg55aeW7COoIAsXUbqE4j2IUxvloB6?=
 =?us-ascii?Q?1fPJeLHw/p56f8dqEL60VJtkXWTsI3hGa3OjKm6aJ/6T9UeGJWG/US2NbqrC?=
 =?us-ascii?Q?mMjq1H+F8DMRnMnLJltL6dLwfaBzKTSxdCr/b+u9jWCUFUY3Zuy8N1TNz0Vm?=
 =?us-ascii?Q?NVA5CQf0y0czx7tn1LpakoCDymTDD5OQVly98pWv5qJE5XqUq4a625WTCEhx?=
 =?us-ascii?Q?pIjzDJk/rCkwBbFl+btVpEv3XYfior1mqa0RZROMKHyNUAqh+oVhfyRQp9dW?=
 =?us-ascii?Q?L85b5gDkK/Jwenc8cqQ+Gfm/kSs7wmD9EXtDNqgIWBN/kYliRsvJAK24+4hb?=
 =?us-ascii?Q?pF6k3GQcHSzBGBsGVcnuLwEO5Oq4YnY5sGjAStYMqTNsyWCB+yBlkSSgEGQy?=
 =?us-ascii?Q?GM1FaJv/A/Dh7SFIi3T8lZ9SYauFQT3LFv/ITGrsqqG6H8kj2K6I1j+1lpOG?=
 =?us-ascii?Q?zripXR9+tIRr03db0QQHSIM=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78715319-eaaf-458b-c874-08dc8a44392e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:28:00.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28F4sPdzuvBC2Gu7EfwX1vd1OefLwuatUANqLPCkgcNSXLk/1YNGYZcFKH3LbMYIFwF0Skd7GwqtwXn8w/S5WdIvm6Hl160g+3/tnL8/PuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB6105

folio_fast_pin_allowed() does not support ZONE_DEVICE pages because
currently it is impossible for that type of page to be used with
FOLL_LONGTERM. When this changes in a subsequent patch, this path will
attempt to read the mapping of a ZONE_DEVICE page which is not valid.

Instead, allow ZONE_DEVICE pages explicitly seeing they shouldn't pose
any problem with the fast path.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index ca0f5cedce9b2..00d0a77112f4f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2847,6 +2847,10 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 	if (folio_test_hugetlb(folio))
 		return true;
 
+	/* It makes no sense to access the mapping of ZONE_DEVICE pages */
+	if (folio_is_zone_device(folio))
+		return true;
+
 	/*
 	 * GUP-fast disables IRQs. When IRQS are disabled, RCU grace periods
 	 * cannot proceed, which means no actions performed under RCU can
-- 
2.43.0


