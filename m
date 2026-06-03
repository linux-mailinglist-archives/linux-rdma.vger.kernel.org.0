Return-Path: <linux-rdma+bounces-21703-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7w3YHRhxIGoZ3gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21703-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:23:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B98C163A84F
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:23:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=RLzL35Hs;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21703-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21703-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E653035D5B
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09F83DD53C;
	Wed,  3 Jun 2026 18:16:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6ED37189C;
	Wed,  3 Jun 2026 18:16:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510603; cv=fail; b=Jqs+LF2QkPKYca5G16FGfGzZwbwdD/CouTsqVALqFkoYEHNSYgi5asLXuIiaQNPK2na3pTtm+JULfvxf+8fMWXTfjMyE5Pe5t/3W5aRr2RwvIehEcBBVaLb0tcSGKlU3erqv34s2UcH1Lwt1qEW+7ItSGM+lsg7yfjCMF4vovbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510603; c=relaxed/simple;
	bh=8KJVnSmIr+z7HF68VWa0kMkU2glvy0Nu1RpZ9DYuWsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g54sJw2j4oiGdxIrU4rflazlMYbinr6QStQkDvGyH4Oo8KQvoNtCKEpN6SYmOnfc6R8D687XpomfoaO5uWkYxhWV00HCnDyb+mc0BrhSNpxLcr2+qfhTHzF8MqtbhwetaeJ3jAVPDa47oo1QGkH0YWdFb5EVv37YMAlSthscqzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLzL35Hs; arc=fail smtp.client-ip=52.101.61.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4McbT0ywGGB7zSL0I0j5S8cnIRpC5P3Na1fk1w7xGCcIJHGhvEze3uN3CxxnVnPhbbVU9j+0PzgK5re22uvtIjVXV2Fexn7syTM+5Pu1gRNenmouA4DADPVFreQvFXgWKl6ppXD/DXSs96fVqugVLl4VHsO6c+/ZkznqDt4VDPs9R6jW3hIpC2OrqSbd3c+ZxsMweTCc2+3jbJwmXLeCIYSu1cQf3HryUaAzL/0mUVOfaFMxojp4S7Qhd1nkch1Qnt8X4IVacQVwp4g+9rI8wcUZdPPqCIL6dStJiRxuL4Xt27DAxY95gINg86FcnDUqURY2V6uxOjT6fIc+tyKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H27oOFg1C12CV1Ec/iRfh8wVKFAZWSmuhN5w7R3uLU0=;
 b=AKQpTfGVgWASILZZNkaCdHVs6Bb1/anoTl9MHk6yzeuva253biOaB1pQ447IFKDtueUhppYC/bvL3TTtVzwH1ni6TkoGupxTVDeryna9mluzZtj6RxJjcw/Wuk+jO2F2oe15bX3cG/5Dg9UQhR+8+ls5MbRuBEPlz0DgN1ZI14IgU893Fg7sLTcvZIcHSHoFXYV4ltkjrxFmgSJVj6IfNUpVy9A0VRatrm6/YhsEaWJK872P3nHNxjN8t3jc1JVmC7JvijUEMFuZ65rrrsw6OnS/u5FOwJEJoP3wrdAanzGYsRSdY8dem6vWqX9z+/9p/v0PtOyrOeNZegcr6ZbrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H27oOFg1C12CV1Ec/iRfh8wVKFAZWSmuhN5w7R3uLU0=;
 b=RLzL35Hsnq0Nh03LNpNgCBfmegmgEe8qBNd5H1bZZJNrNOXyqUZ3EWnA8JmgpRJNe9ZnN810xItnz725LpGiytepG8nKWiV7lmYXxiduvDDMgWM1Eu45S646v3Ad+06iaSJ5WGZwwtSkvlSBvtnIsR3nc9vBmj+RcJnctI3mA3J62sL7Wd/9YTqOkkLP2yUPJD1TgB+rhhljS38foE9ldOhYKHLpp8rUdwWs7ScVRa9Lx4w3t1FLd944vgymjFyPpCaH1G839v/64gYez3pmPcnJOJ2eGUebyaQ9jvFbfkgDxAzYIy56GB5+kfBUxbto/HQptCAC13aJVHxcrg/nbw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:16:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:16:37 +0000
Date: Wed, 3 Jun 2026 15:16:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] RDMA/irdma: Fix typo in SQ completions generation
Message-ID: <20260603181636.GB1568873@nvidia.com>
References: <ahjB87k54bYdFbft@grain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahjB87k54bYdFbft@grain>
X-ClientProxiedBy: BL0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:91::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 694b7243-81ae-4ced-153b-08dec19c40af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YjLZ23qsa0AOpnZIopZLOCu7zzVR3JHJdd+QCSBkwbM+MkVp0ijqkvyVaeZ3T+yuRIPvdisWTI+0nguUJuFhM9JFWPNsDLF/AYh1g10SN28wwMAnWIl0in6GnsD7h8b0nfLpikGlbtxVTte+FNpQNnvnRQY9Mkqt83glJRbeNE/BfQuRPE8S0B3WHv77wSd+LlPavLnW1lfxLOp9CiGRFloNUuffttDHFPy5pOWU7CxF/xq58aP0BUnzjGy4BdLiF2z55q+bYeUtKwkHo+EjklH98w63GPbDdvqo6V+GHmgTakVVxv0LZjK73Vd7OjWxHcBABfOjkqWIYOa9smrMDhGhIyA5pHPyIrtHUiebcue8jH0i/jbVyZsqyHj6mT4PPmrAJZSH8rzY7NTsGoSbC5GkNm97oRMzJbqAEQbmrdhuzctw5a41hNbsNo6qiDwE5ycOuGdwr5Me5HkuLhkr/mxijapaQPiuzadgfzcTf2aJRXNdHjJ5wR+jIAeE89t4/NOrBtNAGmNMomk3/2Gleyg26PVAP8oZm6ZLPxnQKDpPYZO/aLraXtygvLXZXB7E3z2ITQX6t7ONekGUFKmNlZ/UBDAtE47KDR039mvfxIKsLAWpUfiD8SiyUA61rFgNCPbsKG3xMyeC412qg1UFNIJIzqDpbbcM1TS2axjroWXifKZVrHt5urg0ax1wd3Z3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R7Z4Wz5Fe2jJthxWn6hKLTFYR9PsJ71e7FoxSZTNFQBrErfHtJAxIfMWadQZ?=
 =?us-ascii?Q?QFUztK51FIBFqVSMePYCB6YyJWHIFfLG00EKWneJVRM8ANP5hP0ka/5GJDen?=
 =?us-ascii?Q?fMRyfDMx3u+FpuWmv1dRFnI3CYOdr1HVoJca6o9xBSEvWecbo4awErBCSBZo?=
 =?us-ascii?Q?CQ2EDJ6ClqCCgAG/yNzraAVWgTlIPjgvy3cfmjdoXDHXqDiBfIozDvfzaE5I?=
 =?us-ascii?Q?13QWWSfFFdtuN+8BBJRE66CdYpmANo9uoQfUnpuepn9ehifgvAcle621au1T?=
 =?us-ascii?Q?dw4Cct0PjJuBWdqDe1MjXWJZuuEORnkkVd2Sm1XghxrQbw9h/pN/ZstUYm60?=
 =?us-ascii?Q?4FvsDCpUuvsCvSygksA3AuuFU0K4+o1MowFGh/aNQyKRU729V+olVGrBsIUP?=
 =?us-ascii?Q?4xxiiPByof4OH/mZbqKbPm9QUmc81bvaSfRlRMQH6Bp1TI1WRpbNr124yhFI?=
 =?us-ascii?Q?za2a6tLWUC3yDAJOLfWAE3lWYVJp8kBdoHAnnDSEkp2ENPMIbEn4GS0R5htO?=
 =?us-ascii?Q?xk7OBkfsgqYOpnumGT00C4CtsNZlEb2u6d9ygmty/Gkt84jIukH8iw3gbZML?=
 =?us-ascii?Q?GL2sDQGOSs+FrKMJZObkCF5SurT0Lgw/I109lrJ8BJTe10/xjaQhEfbAtjcl?=
 =?us-ascii?Q?mnNE8jAuvDmC5YC0jJWWplEkPOQOC/nILYgjJ4XOTQShMy65m76FfHFNjFAf?=
 =?us-ascii?Q?s7UTX7o6XlIfpgUIqGDYojUme+XSD9oQiaxalBPFgNsmpKoBcf83vwfaN703?=
 =?us-ascii?Q?STyf8U7wfDp0m/lQ5kFTpOkIQ2c/MFAfcJ02N3Hhoku1v7X90SjiRKheHuZV?=
 =?us-ascii?Q?TZZOWX0QPNBKE70OZ0xuw2DbP14pDLMhNFsTdaZPL3LSynijLhBBJKRP3obD?=
 =?us-ascii?Q?GgAtdnE/CabkupbbTIpP52zlOr0x6zmd9fwct4VN3gJWi3wc+alS1wPXkq1b?=
 =?us-ascii?Q?ims50ahpNj8Rn+XcINTy3jpgMBgYb7Tcn0hQca9a/k4s25/SqRc9jfDWgQ5S?=
 =?us-ascii?Q?cd/5yE1vTw8w0y0QcTAzVwq1xG7BclGrUidBbUgcTmIVnVx1WPGF/RwSDCMl?=
 =?us-ascii?Q?cnTk8h8BC6q/js5dT3Ho4onjbsnwi2Ii2oz9CgeJ/H4nJfPnduMAcimLIoAt?=
 =?us-ascii?Q?l/JX4Wg5jTgiLIzvaLJ6egWHhCiQ7hAgjVXJKMaL1EJoW8FgsCp+xby7Te2H?=
 =?us-ascii?Q?k87mjWk3WjmBo1gAhh1JpI6gnf5ffE9mCaCI4IWkasC+u6Y9LOS2hpzbMVEe?=
 =?us-ascii?Q?tcyKifBQAIITu3086asDCS5FDI4KsD6uhwpwHU//y1MWwG9Wwe6p73ceOoYl?=
 =?us-ascii?Q?i1buTRZoKk/rb7fc6lfQbGFsKLyGfLkxLRK/lKBgq6FR8BpmspMampshmGZ9?=
 =?us-ascii?Q?SDRyKgy4x2WYSshX5fRFkJVNsVbC5uHObnhaWvs0o9BSqQMk6BRo8pgIGQZt?=
 =?us-ascii?Q?rlFhSgnBEaF/zfsKYFOtJo+1cVq/3PVZWyONuLiD+UrsmrIc2neeUtt58rhc?=
 =?us-ascii?Q?jM5uBmak45a59fjqtTWmwO8khg9RDdiMD9wf45PvqzmURRPGCjomh9IHAVyY?=
 =?us-ascii?Q?MSScx+3SHMQIXbhYDxMYCMxYGd/9SUq6rYGExT0XyubLJlNrjqd+PYmco99m?=
 =?us-ascii?Q?gSlbMI0EDB4jfZZofdrTiETT5Vz5E6CwDdZf83FW2BySqbmWt/9YLAsccrDr?=
 =?us-ascii?Q?FU/o7txPXGf1qMgqCcPKXAPKmJK5EyPxEetEtMcmTvZlvDCi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694b7243-81ae-4ced-153b-08dec19c40af
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:16:37.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVMbzlLFaKIa0O/Wu4lKJn5YDfGFnrERgLa1TZSVFfGKC/ZjBWDJZ+oOPWPvOomO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21703-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gorcunov@gmail.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzysztof.czurylo@intel.com,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B98C163A84F

On Fri, May 29, 2026 at 01:30:11AM +0300, Cyrill Gorcunov wrote:
> When we generate completion for SQ the opcode while being properly read
> from ring buffer is ignored when written back to completion. Seems
> to be a simple typo.
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> Reviewed-by: Jacob Moroni <jmoroni@google.com>
> ---
> Hopefully I didn't miss something obvious here, found it while been
> fighting with unrelated issue.

Applied to for-next, thanks

Jason

