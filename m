Return-Path: <linux-rdma+bounces-21681-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h95bE+cjIGqSwwAAu9opvQ
	(envelope-from <linux-rdma+bounces-21681-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 14:53:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EF2637B8B
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 14:53:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=prevas.dk header.s=selector1 header.b="Ymlz/BTy";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21681-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21681-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=prevas.dk;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2D01307CD80
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06F271456;
	Wed,  3 Jun 2026 12:49:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2953D669C;
	Wed,  3 Jun 2026 12:49:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490969; cv=fail; b=Z2R4Uf5ZmVbtq9KonOFRKOSNb9GV2C2UubF2kHJnk0bCXwarKfVVo6XR8HdcfpPQnNjfrs8tLlUdBo1N/8vvk4Bv8/crg+2WyO9vrfWpt0FMDpCQvGyNJnj0iZq60ENmxXFjCOmnEd2xQ5BP7FhWjTSjxYsmyB4mKxR9g37bEcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490969; c=relaxed/simple;
	bh=lJAhqtEnAGYI/M0inpQ/yNbH3yxhkaMNkXTq1i1fzh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=heqcxgngjWn0J+lifunsTtWZLNMILvLKzV4GTv14E130gLXyXKifEN6x8KgG4zv/M1zWk6/ydMIEmW3Pt3PjOL1YRDVT8HFomABUCu8jlPmNEjf5l/rnKF1Zt3SQQkeGswK/CJnyk2Akxsbnju7kI3PNA9mYlWmC0g1msRoIzsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=Ymlz/BTy; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeuRyLKCIy8ZVY2u6CZoBcnaFg5Fs+K7MASsIzQH2JgnS+9FyFSjHwfy5e/2xrKCEpYYI3+dgmFc62TEwZlAzPiqBbVMz/EmvkoEXvSQVP5p6xrbH5o6lU0W6V58KyLGAwF+h602fVKRKFVR1rI8q5wRPqj+8ABf80wZoBNTPwS1f5AwRbuwvkk/3FBjJcGBvSZcR4/8/mTFgsfEFaoIvoZhDWDza1f6GSqBu1ajWFExF5/WNwaO/VhtBtr73t8K/ln7H2Al5mBK+aCdFoRWZkpKt2urviwFY3EgIl+hO3SOfQs130GgPRfolHTyoFVPzt5ueLZbkvbjmsdMEKTpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAZbrhAsQ3EzdG55w24NXdb7XkL1n92bID843FSTc/s=;
 b=ZlfWTEUTlmDBkgJ+McYdKU3SfYjOsmX3hDuesN/oVc/MlhAzeKswAKX25Yw0YCCwksPR8l0SKAIGMQBxxV5tWGhkZ+lf5wYSm183P+cgW1tyIWqnACV8zWrUBTWfEzc7cWyoCsVRZ2E4F3TcOwQjlxjecIE1W4Wtnnnzo0Kd8aCU7lu6qmlg8KCKSo8jnPdkv9/BFNIoEshWFdJN9EPADPpCmMTHNCEjZwz+j/KeptrLa2guY9Hozz9wbfTlnMisLUVpj2qO/gainwz83X8zmG6SX4wWeNkaOTpIE0q9/u2LePPDtuqdPEUernK4K2G+B75MMY5ThFYqzZOGpwVuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAZbrhAsQ3EzdG55w24NXdb7XkL1n92bID843FSTc/s=;
 b=Ymlz/BTya/JOkXY5MI3ZxEFoRaDqUhus6JnN2OCJmGL/xqb3FFSErwIkwpTmrAhjDkuYYLANKdBTzcIBB4tfFvcQ+wtj4pvd2am6W2xCv5DXQa/D6XBuFi9UXUiYyYDu0yuMCXntMxlWA+AAy0+4qT7NgvdUWFlDTLlYFcNvS4w=
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB8PR10MB3323.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 12:49:20 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 12:49:20 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,  "Arnd Bergmann"
 <arnd@kernel.org>,  "Steven Rostedt" <rostedt@goodmis.org>,  "Masami
 Hiramatsu" <mhiramat@kernel.org>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  "Petr Mladek" <pmladek@suse.com>,  "Nathan
 Chancellor" <nathan@kernel.org>,  "Dennis Dalessandro"
 <dennis.dalessandro@cornelisnetworks.com>,  "Jason Gunthorpe"
 <jgg@ziepe.ca>,  "Leon Romanovsky" <leon@kernel.org>,  "Arend van Spriel"
 <arend.vanspriel@broadcom.com>,  "Miri Korenblit"
 <miriam.rachel.korenblit@intel.com>,  "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>,  "Sergey Senozhatsky"
 <senozhatsky@chromium.org>,  "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>,  "Bill Wendling" <morbo@google.com>,
  "Justin Stitt" <justinstitt@google.com>,  "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>,  <linux-rdma@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-wireless@vger.kernel.org>,
  <brcm80211@lists.linux.dev>,  <brcm80211-dev-list.pdl@broadcom.com>,
  <linux-trace-kernel@vger.kernel.org>,  <llvm@lists.linux.dev>
Subject: Re: [PATCH 1/2] tracing: work around -Wmissing-format-attribute
 warning
In-Reply-To: <aafe201a-64a6-438f-89a3-d1cd10a357a7@app.fastmail.com> (Arnd
	Bergmann's message of "Wed, 03 Jun 2026 10:41:18 +0200")
References: <20260602150904.2258624-1-arnd@kernel.org>
	<ah8n-Nk305S5hRwN@ashevche-desk.local>
	<WPQQfPHOiGJbSxrXRdFDy9jURhS7JMpNu9sD54Vfe5wB-JOjyGY6xPQyACz3MSGg0xGp79eOYCyZ2Hi2CsPeUg==@protonmail.internalid>
	<35c1ba62-e74d-4abc-aa73-ccd35968ff89@app.fastmail.com>
	<875x40hz7k.fsf@prevas.dk>
	<cODLVx6ZlerCiOgdpsG7OSsC2YRA6pXmq2jBdTjRB2UQoTIY4hI-yhV1lrumRNBH1hTT2aJRS-MgtlbhNWUTEw==@protonmail.internalid>
	<aafe201a-64a6-438f-89a3-d1cd10a357a7@app.fastmail.com>
Date: Wed, 03 Jun 2026 14:49:18 +0200
Message-ID: <87zf1bhjqp.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023989.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::366) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB8PR10MB3323:EE_
X-MS-Office365-Filtering-Correlation-Id: d40e37ea-4692-4789-33ba-08dec16e87f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|3023799007|22082099003|18002099003|4143699003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2hwtOGHiqQ9Taob/DXxXNKGwwENxmTsM6wwqwbqEZG7LeSX25e6MhSAsLsFqnUVQ9K30Uc1s59/d6rWvnkQUVqnbMi9EYnDeqDZy5Lj5hYOzJpD5pamsxxtDvuVk66aNRefsSTsTv6mH2NhB8cW6M6VW5YJ3r6VSlEx/+g/FZQdXxvIM+2YF338klUJE3ir0Nm9mVUmkeSfilv2NSzpz/gwXbUpRy1TCEQ4ouBafQscDHLYStOntcbpTyuBmcieK8ED10MDXXzDUSfkbCiSpOFz2FDUZlb18zzWdDruhkqhtWOTcDQvFVA3oV4euKzSk/lQbRU63tArdd8NIJQA+YhhyODmN5KFOqgyvYR9jSF2Ebkhc5zMNhIaJOgrmv9USDJWvyAxVcgpeAT7G8ZG7g6yy9ojY2tGRZ7byBhX/fFujeEWTjF+cUD0EOCZ5IgoaZr7I5Tq7aQhpTSMPHa+P4Gh0JkVyUok0x3YlbmdZyTuprJQM2IpdncTaVcmrV6B6od1NzFeBp8D0SzqhL2ayfF4f27Z56Uno4QHQsKQ6Toof8jgJiUXAiOB7etTVFw3KYZVC0vrXj3Qc2frEFRRVV7j2nUhxJ44Zyrg+NwXJOu/rFDduMqLxdW/3X2Bw7r+eI7DmR/CjIl+5BoGe+wIy4AXeaIdP+8zXKrKbarYj9vmeO5KWZKKsubHLMj8wSDJh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RA6C5FdOO+tjjw1+zzXfb44vBIBqVDEJAxSb/395wY6BnhDsyD6ksskatHfg?=
 =?us-ascii?Q?GId+y5SZPxFhwc7MZfvT+NK74rnyQy1veq622AzTQfQNDHLqdbVAF/zVGPEg?=
 =?us-ascii?Q?WrGt9c6r3uqPWe78fiqJAfdigAifInGGN6c1q0dqjgb4vb/HySknfBIBfUqj?=
 =?us-ascii?Q?+qaTxjHXmfftFkWA/Q3mLMTzNJuDz+O3Lep3GtfYJk8pk9POzcWjaXJF/Kec?=
 =?us-ascii?Q?FD9o07r0pMMGxfTEILR2lFgjvvp6mz7Cj2gCfdQ8MoTOTkdoG3/tX07QB/LL?=
 =?us-ascii?Q?M93rcPOg5D5VKMCwAKFlAyrjCxMrTAq/QXKkkoUBVlQUmYYwhekZqyMcf2OO?=
 =?us-ascii?Q?/FQE9lCv+dA/3S6sygYo6jjoSUAPe6ccm3UDrdNt5TUOXSTvenVsL40MYYMn?=
 =?us-ascii?Q?3Gn+N1acjMq9GhNiG7gk6jTdLE1XfKko6HZHo5f92SPexURlxQl/e6vw32RJ?=
 =?us-ascii?Q?jA+X5RzYDs+R6ch/eeDAcAPXf/V2Coe7lDgbgU1LpH+r47POMpfKXuDdSQ8E?=
 =?us-ascii?Q?yCnYAykqHzZdwOezTrnf/pTsjX8lxL8LTsCn19NRh9keqlF4D4jWGBZy/ueW?=
 =?us-ascii?Q?cXlM0PhqaBIGwdKyxDdNijCd6Xgkg7DrQuiRDxeRIrvLcDeJ09C6YcbAXvHp?=
 =?us-ascii?Q?W+AejfSBgWF/LANluxwzjynVWa0REc+hYENB3kIoolpQQb9UvmOyEQ1pOjCM?=
 =?us-ascii?Q?bczUB65qHrBbpgGWX3cp5ctx67eCi0bPhI4keemmMkwMeo9LOAwiVMvumi/x?=
 =?us-ascii?Q?UMhYBXruUziWsqg4AQya2evpc/tSRUq52fsSb+dIOCePU3z5VUloMnFCQOD8?=
 =?us-ascii?Q?pYjoLYqv7EfvY/AsOeQo6UkV4FoA/YjRY/kKQP+h27rjmhAd1oghwJAsCC6j?=
 =?us-ascii?Q?2CutafZ423eSezaPVfeFn6glZzKzaJDSwMfm2DBY2xylirAWsYrpy9qqqOCc?=
 =?us-ascii?Q?ekwxRsXHqYFnhWzdGDB4XoRahJV6LOz25aqgu5rPQP6NqWU5cbc+nt5trMCv?=
 =?us-ascii?Q?FGUXAZczAoof6mHqM1YPKJ3mr2upc+224pUxN13wws6mpRwynYGtrzOzZRgJ?=
 =?us-ascii?Q?MNZrV+V18V43zRM48DuunXZGJnbjDOh/KeNlNGSoRSBvQPIAazydGJeVQXP3?=
 =?us-ascii?Q?1cmGv2Jhm+owaLCGJPCZ69APcLX06F1H/7pNh2qcH+qNPIELiqnO+UH7du2s?=
 =?us-ascii?Q?HVNVMICkCDaIAQS761TG+M0eQvn/dIaSPxP7myTiw1VkRKvBez0h6Wrh+jpl?=
 =?us-ascii?Q?VyGffdFNVUHID7FQybOUbLGExvSCMfDTcpoL7i/7xPhUnNAzY629uamtS3Ce?=
 =?us-ascii?Q?H3O28hS/xE46GvNJEoQVNN2OabbFi1+CUkWWWqY3GHh51V2B8JJchVEhPK4+?=
 =?us-ascii?Q?IFXqE9pSsZHT85n2KjN5YYa7Tkz6TfF8M7uq+QWWTgMEpWbErNSkNzU5q76E?=
 =?us-ascii?Q?nm2fQyoAEDnnf0Z2IvGkNTZC4N1YtL6kKVDNhoQ1lz9lQPzz5zQARzeNUqGb?=
 =?us-ascii?Q?9phIBIOGQ0ZAbWx/0jn8WgFR4F9p0+1l69JQBN6uv0BqvNi6VucJUadpHazZ?=
 =?us-ascii?Q?bSoND7C7Xd9R8hIV3O3yAZ2xoVi9HmcxBpTHeHIxLnbihRfSxtWckJAbW/7E?=
 =?us-ascii?Q?MOaKtw7dNZvlgG881nYYxljJb+K+v8nZ4NPf433JKatbIrUFEACZSaI1+rDA?=
 =?us-ascii?Q?cLCUwV12b35Rs1lQhlwpOmnz00Slx8DdZCNQrLxuQN9OAIyr7+WgBcE7Zlnq?=
 =?us-ascii?Q?lVkUJy9+grTqK+LCdtIXb65p7YIty2c=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d40e37ea-4692-4789-33ba-08dec16e87f1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 12:49:20.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9039GmgpCOjqjI8gtuFf2XcyEjf8STTB+ETy37Dipne9vsw8xuFEYKdBIVrgmjaO5FtykKy3c/f8S74/jNVIL5Xt1up9ypticMkI3qmgNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3323
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[prevas.dk,reject];
	R_DKIM_ALLOW(-0.20)[prevas.dk:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-21681-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ravi@prevas.dk,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,goodmis.org,linux-foundation.org,suse.com,cornelisnetworks.com,ziepe.ca,broadcom.com,intel.com,efficios.com,chromium.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS(0.00)[m:arnd@arndb.de,m:andriy.shevchenko@linux.intel.com,m:arnd@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:akpm@linux-foundation.org,m:pmladek@suse.com,m:nathan@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:mathieu.desnoyers@efficios.com,m:senozhatsky@chromium.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:vbabka@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-trace-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ravi@prevas.dk,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[prevas.dk:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arndb.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,prevas.dk:mid,prevas.dk:from_mime,prevas.dk:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1EF2637B8B

On Wed, Jun 03 2026, "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Wed, Jun 3, 2026, at 09:15, Rasmus Villemoes wrote:
>> On Tue, Jun 02 2026, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>> On Tue, Jun 2, 2026, at 20:59, Andy Shevchenko wrote:
>>>> On Tue, Jun 02, 2026 at 05:07:05PM +0200, Arnd Bergmann wrote:
>>
>> May I suggest a different approach, that avoids having that extra
>> function emitted (which presumably compiles to a single jump
>> instruction, but still, with retpoline and CFI and all that it all adds
>> up): Keep the declaration of __vsnprintf() in the header without the
>> __print() attribute, but then do
>>
>> int __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
>>    __alias(vsnprintf);
>>
>> in vsprintf.c. Aside from reusing the same entry point, I could well
>> imagine a compiler some day complaining about seeing the printf
>> attribute applied in a local extra declaration but not having it in the
>> header file.
>>
>> Presumably it will need its own EXPORT_SYMBOL if any of the intended
>> users are modular, and it certainly still needs a comment.
>
> I had tried that earlier but given up because the attributes have to
> match exactly.
>
> This definition works with all currently supported versions of gcc,
> but may have to change when the there is a new version that adds
> even more attributes:
>
> int
> __printf(3, 0)
> __attribute__((nothrow))
> __attribute__((nonnull(1)))
> __vsnprintf(char *__restrict buf, size_t size,
>             const char * __restrict fmt_str, va_list args)
>                __alias(vsnprintf);
>

Ah, I see. The documentation for the alias attribute does say that the
types have to match, but I didn't know that the nothrow and nonnull
attributes were considered part of the type identity. Oddly enough, if
one does

  typeof(vsnprintf) __vsnprintf __alias(vsnprintf);

that still fails, but only complains about nothrow, not nonnull.

I don't remember what minimum gcc we currently require, but gcc 9
introduced another attribute that is apperently meant for cases like
this: 'copy'. This seems to build:

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 9f359b31c8d1..c1402d375429 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2988,6 +2988,9 @@ int vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
 }
 EXPORT_SYMBOL(vsnprintf);
 
+int __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
+       __alias(vsnprintf) __attribute__((__copy__(vsnprintf)));
+
 /**
  * vscnprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into

That at least should handle any future "gcc knows this-or-that about the
vsnprintf function". But I don't know if clang supports that copy
mechanism or if the minimum supported gcc is too old.

Rasmus

