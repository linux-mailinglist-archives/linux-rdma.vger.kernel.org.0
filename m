Return-Path: <linux-rdma+bounces-16608-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBtTEEVIhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16608-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:47:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1348F907E
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DA4B30470F6
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E45244667;
	Fri,  6 Feb 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ud9eFQdB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2E246BCD
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342351; cv=fail; b=lVus3IazV7h3RDf4jzSpxz7KK484Fm3fRxYHNaEzLpe+FlR2MBNcAHLfp++kSkTVB3VwTdja64omEQb06AqwagKX6tnKArsx5Ji+49ggw4vtemyFx0tkYvH4MKjFQgzn3R4BAyCe/TFYiHbXiKZnj1BkSdsmMN9qIdZnB/k2iUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342351; c=relaxed/simple;
	bh=6FHapNNQCl5C0kQ0DaEkorHmi7JRVyKlOGbqzXIPvhA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m04bEWT9d/fFr82+RbHZkHPmQHiOqiXFZ307fhRGIDoNtHp/ukc4y6dV0fxde9KyNCm/f35POjuX6P88PIY05XJq2b2Jbg3FQz/LeCMqy/uw+/DGr1y1/+dgMljg9+xi78rnZulgZf72dE/5ECKVZU3RXpObi5l1x8D81y+aiuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ud9eFQdB; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2tcZ6h/CQFSE9oLYe27HaZXNpCjxo8zjW/wbY1CD/5boaqbVb/nUZ+rec58i5BOygPrxj0H2tHnFLJhXTQcVONoFat3OJjzaFl0KxM0MCIQllddbFv0I9y2aq0e6ThRAHV1w4sibxgR4pz2ZFYtxdxoHq8VpLSKCgqTn3uTx5GDBKkXnhpKYD4xZw6WD4IQyaXR1j9HDrV5Dj6sxM/bd8evbSKvkuFs3/jHomeQ2/8DaY7AJsDmh8+hm7dbDmcNTeKE3cpiTu1hGxZLtE0i5LKpk1VwBhG3KuDyAEMZF9qMfdQ2X9Kyjhq8iwgFgm+MeA5SPT1ftCmJLyPk2yfrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU81RtpMzdh8WbnxYlByocbn9XqDLR1Utv2TEy56wr4=;
 b=qmdiP8jzg2GcKXiKdKqG7j8Qz1yR9OCe38NE44Izd8DMmgOjs68UadcUjXFA+CFFlyii/qiRDiqOBis2Mhbv//p+v6TAIak2PcZVsPcuWTOCW2oas7lrwWyoMyTDBpTtS2gic7FltqhDGsspVDGiFO/KO1tTfFFbhP46rEDVAEgUXHYLKcjqKbtAYXD1vC/L3dKTn0qXBENfiAjf8QQXlYf8u9Xlid80pt+zLOjUZJo2TBMlGtE9p6mKKm/0f7g2jCHWx45lbCBEpbhKwH8IhBVFPFwWo/HD77hI2HLHZ3boQzBEI4nlSNTPpPM9FcMMu0cCI92QK/ERqGMSrEL9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU81RtpMzdh8WbnxYlByocbn9XqDLR1Utv2TEy56wr4=;
 b=ud9eFQdBB6U6pSVDWY1KkH10VdqeqGAyo4bbi4ztQuQmSjRvAq44V2yTcXnuOpMvuE6d1NwO17CxoXpFUSslIkjPQCeKosY7EU4RmsHefa4ICF3Jubxwlzc37EEt/mYtD9XJe2uOXJch469D25wtRJ9hRFlbnm3WdYrkn1fwMcUD8XigoWaULfUEPz6TDhTExaNiQu213jwg8NAk9cCc+BwqtMdRbl3moLI0uoYWIh+sYfHQQakQaCO1I2tEmYeZqcbX8ANcE6QCU5PMhXj1BKzVmoWwBHGf93M5dg77F1cFzfD54huRF39tzraCy7qsAOckP8jSxe+WijeHFpa3HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 6 Feb
 2026 01:45:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:45:45 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 00/10] Provide udata helpers and use them in bnxt_re
Date: Thu,  5 Feb 2026 21:45:34 -0400
Message-ID: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd409ef-fe71-4496-d3c7-08de652171c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ncj/mzNccy1i20BxjNyiquONxrdTMOKIL0s3Gkh4YRMYIaibzVQm68mFw8mN?=
 =?us-ascii?Q?nJJBBaSp7djsf69cfM6M/tyTf0l7U1/6zD+bztbUwH6kh7yPQV/MAgMcQiNf?=
 =?us-ascii?Q?FFbzVUDP6hxhHfzMliTDi1XCvdskex9KCjwUGVgYFXCm6hwqDNlobJdENpOr?=
 =?us-ascii?Q?hg3mAhEs/opGLYQtSBfl4LgMiQa/0A532lK1RFE41YQQDGH+/1+J35dOUvBh?=
 =?us-ascii?Q?lV/Cj79Lk4aFeT7u5A6ntGDjXyu4m3WIQPJJ7xOnUqmbqKtw4EEJzPrFu6eG?=
 =?us-ascii?Q?wDgjCHzS8oeG+i2beG9URyZtSbqLPJEQox3A5C/G66XDsSlaphcusdfl+imV?=
 =?us-ascii?Q?q4mnpRLaz6t+BKfoBoqNOnonP4B1QWKGDInCfcSNZ5PilA9hUxaGFVKXAwaD?=
 =?us-ascii?Q?BS/peeeKxwyBDJAbqvLnmUwPkmpoAIAzBaiGuSAnFrDtLgGSuw+CcRRZR/5G?=
 =?us-ascii?Q?ZzsT1PZL8qcOkye1Jto4PbqAc5z3u+Q93fHNjQhZsFIoKDMcq50laMUKqKyj?=
 =?us-ascii?Q?Ru85ypUYr6nnkoQ7Y/fF9iJdK5cIKJ/Md62VrEqiXpT2PpZar7wZDgwY+spU?=
 =?us-ascii?Q?KgVls/EkSIZIkYTeOJ5iNz4nZrKNE+7WZnprtvOSkQnJsO5SkX+r9J/E5MAM?=
 =?us-ascii?Q?21q+piKqa/Bkl+D3AFTmFm2vQ0MGdbE+jujS+c3pPSysFFhdgbmQ2Dk+8gJs?=
 =?us-ascii?Q?03p3tFR7NX0QLOcanvWj6HZJ0ffW5h+o9Bks1Rys6Grr+YSngkc6p93+7rru?=
 =?us-ascii?Q?xn4DahsdeFmj1wIOeVHw2irNXlXUv3RlOB738jYo1untnwUPfJGKpYe6tawJ?=
 =?us-ascii?Q?xEcYZfzMfJY6VoK2PHda0TtRnpZndFwwPd94RDxE8K2DyFdwPqf2FnV1yikX?=
 =?us-ascii?Q?Sx2eI7AWfjdENJDDVPn3mhTCAt8zzzUl3Amzfz0ipI55ZQIfOUSTENr0bZOB?=
 =?us-ascii?Q?YrDnP15/7XQYP0PE5wDXtWYNlZ5QADAHg8cYmN8wtKHvPUBR+U+NnICdDnAx?=
 =?us-ascii?Q?UGHvrEkyOYCAFis2hvfw8k9INLrDM9Kw4saRZt0rryr482pI2oeBZNb/I/Dd?=
 =?us-ascii?Q?M9UhSGk7bsbtipx9v+lHk5rI16QdrBOcfJgr0LNuMmy5FgoHzQRAvo9y03Af?=
 =?us-ascii?Q?aKpayTJkKbwz98q0jz3wQ5rFrcYM6sVbDunsRqnYjh5xZ2jEEKuYqnuagSMo?=
 =?us-ascii?Q?/IgUW9aunx9Dpl5xLyGFOaegr4OFYY8lJdFuCANEXQ9dN1OsNvtrhwUz8md3?=
 =?us-ascii?Q?TT1Pc7UH15eFG9s4cug4CjLVk3q7L8Q/sWaLhyCLpZKJ8+Ri5v/jqq05Qu1D?=
 =?us-ascii?Q?Arg+bcs9qPVsfagf73b+nzOdEZLZuUFRwJcN5hwn5XhkiS5cvIiNIQDynAc9?=
 =?us-ascii?Q?RzJxCXAFqjJzcDRMxGm3dEweUd2zbnU7lh3HsTx2MUH3w5c9JtopiZ66fsBB?=
 =?us-ascii?Q?QdQ0z3sB9lUKPurYFWFHhD39VbIng227Lm4tln1bU7P3B/zsMw8uYpUa9W8S?=
 =?us-ascii?Q?ziI7e1H9a6Dzyq2N1Zr9/4oiPoWn9zX2khWnu4lBZvZ754yJ8P+lsvMFfjba?=
 =?us-ascii?Q?if5Yt24t3wJRHcI82ltuWtaJQf9VQyCgMEWZoypj?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?sQeWlNzOv0+4oYEquDa7pXE7EhXuzUxvMKmd4cCc5VYSsFBDxwDFxJWa2hkt?=
 =?us-ascii?Q?Er6lyMpTp0hU4nmW5MFs6QKUQpS6oszAFTAdrUPiesFTCyhW1npOJkgbGxVZ?=
 =?us-ascii?Q?of02qB0Lv9hOFF2Wjv6/1noLzY8epl+OG6c6015ri/vxIVhAK3HyKoRXpa8J?=
 =?us-ascii?Q?P8+FYw7SDxLMzOUeKpzdM2wkyhuvBgOnKvFWZnG0QbIoQVUSiBg2oCgjDv5S?=
 =?us-ascii?Q?XJCx98HxaL8wAZOOjxLcyVmnbfu/14YLcoQC5NL3WeCAl2Iv7JPLVccFBjwu?=
 =?us-ascii?Q?yt8Ob2ZBEeim+cMV/qQmQoAAZ9nsaQiOLqYY1O9kQyF/832N7K1ZyG4Ocxhq?=
 =?us-ascii?Q?2niXObRZBvbKx+J3oGLhlxpcLyyWdM/4Vj/nEX1gQ/vvfi1lI6Br/tvzLl8j?=
 =?us-ascii?Q?v/HNmgGm16+PnzixOvQs8HqqJXehXQh3oYmS6rtzKtY/RUMLkjkP0FC4mIlS?=
 =?us-ascii?Q?vSXCe6lgm94Ws+rVT/88W/PhDufscMprdRWBesolh89uY34tXrvejpFWKBdt?=
 =?us-ascii?Q?89WhfzDSCYtiEDH3wzwS/axc+cEofx4M08HtXL81y7bkOFu0QkovIi0i+bwX?=
 =?us-ascii?Q?CQssconQ7iB5CZRQr9naS9uSfOlmBcxGfU94jjxK2WnZZI+pXdu4p8WemVlx?=
 =?us-ascii?Q?70CyFZ21XmaRRAhksC6tXdvvap3teNPfahO3BPn3CXEGT4XCk0gW6lsFSN/D?=
 =?us-ascii?Q?epO1O1wMPapEf1SCl59P5yKWIEHUC47v9q71BwtBZl87BraNPXKUtpIZPEVn?=
 =?us-ascii?Q?BrTb4KfvzIFtaJ6aK2LRzs3CXAfH2iMlnBbuSXToTJD2eTTYz/0vLMNCHhwI?=
 =?us-ascii?Q?Dt4ck7EjYeBqqPEuoifSlH4f59MDmeLfo7AjfG3rOM7bn//jPHqLEbNYkCVS?=
 =?us-ascii?Q?syUcvh//FVufNEI90MfBFPNtcGSO5U6czG7gX684W9jEwXbWyfNitzBmf7+T?=
 =?us-ascii?Q?nu2UkbfMuHskSebmYllmdN9kUlD+hdUOWJwtOgAbVhUIRKP2GUxl2wsGj8C1?=
 =?us-ascii?Q?J9Uk6KykHmYJ78MvkIGctQmpM0bNG9b7d7ub2Y6nMHcjHttdtYsSpVeg9fPi?=
 =?us-ascii?Q?aQQBJfaEN+Vm6Y04PQYGXrkZ7qSyMPFAOq5XDYUE9CddZNmEt0bF/CYhINPB?=
 =?us-ascii?Q?GwRNc11yfcXk+hslrYqOpP3vDVjXshJUwx3c5hUopfmkRUqPMQx3prNydsTH?=
 =?us-ascii?Q?UzlbK1nVlB1g5xAZRFkrmvziHq/Zl9udn2OvHRMU+9cQgvD9pS/Q64RBHcRI?=
 =?us-ascii?Q?Z3r5Ui4+aO7h/wgY1HjeNiqv+obT+ShGnyncfuW8JdEY+zPGwXrQVujWQvBt?=
 =?us-ascii?Q?Lr4aw47w3F/Tsrj82JmmQgGEeiCEQoi9heZHFDbpb0a1bbgFkn5LMNqKE/oG?=
 =?us-ascii?Q?Rw2OPJ8IK/rO9zhkJfuQYZ3xzO0vKDaV9E5Wgh4+UUmuQpskm3JcYs+HMGk9?=
 =?us-ascii?Q?T6NqY/Lv/5Dnb1gVHsZ2LGkLMmVWOs4U/s/GSQigsGXYFk+jo2omVEQNacEr?=
 =?us-ascii?Q?fEYEsuZS8zpE5bAzFAJ4SOq0uE2h8FYd0dac6h2zUdfQtZNuiVOlQN0nzK4y?=
 =?us-ascii?Q?9BOwMgXNiQOuziWCZ7dU1+E2X+Raq+zFCskal5X45UBFpwfHwEkUIqKTgNLk?=
 =?us-ascii?Q?UMLmUbR5n7Lk4Hw989T76G54eiNF711JmX6dooQ3KDZ73UEAys+gR+dGuzDq?=
 =?us-ascii?Q?WandLGhCDcQtZmPNwQ4nH5Cr2L+8d5c7c/fcI4MlUgZGRhfI53ErWUxDmpAP?=
 =?us-ascii?Q?+Q3g1rhirA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd409ef-fe71-4496-d3c7-08de652171c0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:45:45.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6ath/rW+aU5YLt2NxOOOfs5/b1IjjiKt2TdeOCcikKtEYbVXOSGed6e3q6v33cu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16608-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1348F907E
X-Rspamd-Action: no action

Add new helpers that entirely execute the expected common patterns for
driver data uAPI forward and backwards compatibility so that drivers don't
have to open code these.

The helpers were developed by looking at the entire tree and moving every
driver to use them, but this series only converts bnxt_re as it has a
pending series to extend the driver data uAPI and the lack of correct
compatibility handling will be problematic.

This handles both the request and response side of the udata using the
following general rules:

1) The userspace can provide a longer request so long as the trailing
   part the kernel doesn't understand is all zeros.

   This provides a degree of safety if the userspace wrongly tries to use
   a new feature the kernel does not understand with some non-zero value.

   It allows a simpler rdma-core implementation because the library can
   simply always use the latest structs for the request, even if they are
   bigger. It simply has to avoid using the new members if they are not
   supported/required.

2) The userspace can provide a shorter request, the kernel will 0 pad it
   out to fill the storage. The newer kernel should understand that older
   userspace will provide 0 to new fields. The kernel has three options
   to enable new request fields:
     - Input comp_mask that says the field is supported
     - Look for non-zero values
     - Check if the udata->inlen size covers the field

   This also corrects any bugs related to not filling in request
   structures as the new helper always fully writes to the struct.

 3) The userspace can provide a shorter or longer response struct.
    If shorter the kernel reply is truncated. The kernel should be
    designed to not write to new reply field unless the userspace has
    affirmatively requested them.

    If the user buffer is longer then the kernel will zero fill it.

    Userspace has three options to enable new response fields:
      - Output comp_mask that says the field is supported
      - Look for non-zero values
      - Infer the output must be valid because the request contents demand
        it and old kernels will fail the request

Since bnxt_re has never implemented these rules correctly and now does,
provide a UCTX flag to tell userspace about it. If
BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED is not set then userspace must
not use any request or response fields beyond the current kernel uAPI.

Using any new fields is only possible on kernels with the flag.

A series converting all drivers to these new helpers is on github, I will
send it later:

https://github.com/jgunthorpe/linux/commits/rdma_uapi/

Jason Gunthorpe (10):
  RDMA: Add ib_copy_validate_udata_in()
  RDMA: Add ib_copy_validate_udata_in_cm()
  RDMA: Add ib_respond_udata()
  RDMA: Add ib_is_udata_in_empty()
  RDMA: Provide documentation about the uABI compatibility rules
  RDMA/bnxt_re: Add compatibility checks to the uapi path
  RDMA/bnxt_re: Add compatibility checks to the uapi path for no data
  RDMA/bnxt_re: Add missing comp_mask validation
  RDMA/bnxt_re: Use ib_respond_udata()
  RDMA/bnxt_re: Add BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED

 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  84 +++++++---
 include/rdma/ib_verbs.h                  | 185 +++++++++++++++++++++++
 include/uapi/rdma/bnxt_re-abi.h          |   1 +
 3 files changed, 251 insertions(+), 19 deletions(-)


base-commit: aace79adb7196a02ff45a334839a4d31a0e262fb
-- 
2.43.0


