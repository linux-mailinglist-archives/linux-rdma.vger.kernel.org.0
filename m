Return-Path: <linux-rdma+bounces-17470-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCQMNAxDqGmRrwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17470-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 15:34:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C502019A5
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 15:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57E5430BD890
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF77F3C198C;
	Wed,  4 Mar 2026 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fgujm+th"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A13B8D7A
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633514; cv=fail; b=ecEfayGm8YMktziCCB3oS+mjGBodUCtmGIc1PLbFBsl2CcyidK5qPB6iVqX2G4w0JMsPvY0IVEv9y+uQ7YTwRd5AgOkCaTggNnHZ6pcUyDBTU2wkCMuu1CNG/dtiCsMuU0wsALmnS/qoWAH0KwwLbbFYXTK9fSyYwBW3MZ4kYZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633514; c=relaxed/simple;
	bh=Tee3nXGB272nget/aW1unTTtsvVo/1YP7NF38+F88xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ew3QVoBF/QHeksGXD/szpDWnJLJP4GojM1VNfCPTFFSfIfQpARsqzW49LMGTjineMpt+GQIIQ9bEX2xZqbS//jZ33RJ9p1/gb9Fci9qK/F4HKyKSfdRgAXPZlp4mI6afmi3KRryUpb4VA3U0pdGAfpsbqXoxRE/vwU7WfCdN2xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fgujm+th; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWE6iHNzZ7yOmi4rKuONT4Mwo2NF4oaKhVLwW9koZiTO6149L+NiFKKF/dgJMQWEZbDLoOIfuYgFYvTmYAFf6EUswcyHJPepByDc1JeMCXmchc9RtUaBZXC3ehJMYIFBdCuZUn8QkJvDtw9pLt+v+toxDlO7GPf6j+eK1JPQ7AAuDnO78NSk+inosD82YLIu14wX0HHLl0sLRX6Ci3eGcenGuVpvo9U0v8HkY7ILyHk2vzIqc5XNgnJayBQ1hUhWeOpIs2xIFSH4LdCBhHX8ZNWOn1wdMQg8dWK27LFcMGKr73GAE+sAMaweoszER1s9QIEiN0J+u5ebXxdyv//Jvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLYuz19PJXegOIW9PlR4CLoxAgl30VNMeDEXeG28yLE=;
 b=eHf9ZFtXkJnDMGSszKXVVb22CW0q1Hewon4oW+mjLrrqztaIoFAcyYzmgkODZSiv8SZnu/XPOsM/fa/k9aL5lT9Y/CZfJLx29HYf6zvWHZm/z5dQ0BxtDV5J8tJK489+F+WDBTSmLV1PouVrYoBOhcwYpNtxvF1U/bMn/RmRbFyiAX4Xb1Y1w6g7CCVwNjPcYA9t96rh7itVq0ooCJvP2Ws2yxHz/rqocQ/GJwZ5b9r0uxqteswItHQvD+UQ7AFInffgXVhJvT8c7/QDuExeYIVIzkp/2mSorgbyPYa1+kQKru8cIgY5liWf2Ft7/5MGgylbAbQ+Wn0NbZeQFbNpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLYuz19PJXegOIW9PlR4CLoxAgl30VNMeDEXeG28yLE=;
 b=Fgujm+th6/D/E8JHvxccmFO+3XIUxKxgaaOuSGtxr25rCQP/iV6m6Eku9VhB/ebj2BN4vw30ZSIA6PDDZHieSoUihaHAuzQYFiqeQf2CFt+dFdtF8Eqw8T9I85nNOTc2yxHaoG41+UGervnJiq4ECIjRuJ53ehX4dGSdltIWFaAyFutoZkRkGOlVU2u4/nyQhbVdtSEwz5/U6CzQ0uF3KWdD36P2mPJmyxN1mJo8NjGlYw3QaWntJ+EzNp/6VrIg8IoOSuAO5MDMdxq52blNzRItIHYd1iKv2Pg+e5xQ+NrGh5D1CgdKc8YtzjJ4bazrSsx50QiyNZ+27H54Zmeirg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DSWPR12MB999151.namprd12.prod.outlook.com (2603:10b6:8:36b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 14:11:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 14:11:50 +0000
Date: Wed, 4 Mar 2026 10:11:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>, patches@lists.linux.dev
Subject: Re: [PATCH v3 13/13] RDMA: Add IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA
Message-ID: <20260304141149.GO972761@nvidia.com>
References: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
 <13-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
 <CAHHeUGW5aOHbhETW624fM_MSkXAqUgw=T+6skPaA=R3py+9EQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGW5aOHbhETW624fM_MSkXAqUgw=T+6skPaA=R3py+9EQQ@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DSWPR12MB999151:EE_
X-MS-Office365-Filtering-Correlation-Id: d71ea946-347a-4147-5ff6-08de79f7fadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	aaY9i0H/kQFJCgzXNt2Ubu8lGfzK5XjHNbr11SvUyBZHyba9KOrF0zRzgXhYdQGjgwxSYREh5+xSFI5XdnLVy//P+nIKrM7CLGr7Y7tZF++asHAm2GaqGr6DCP3wJ2vBaJXTFk1wU5F25hOgdL/u/gAxaT6z3gn5eKn8/Ih0PFbHJOoJaGp9jMeBO4T4bXmQ+BOlDohtFPsynb4J80L7qBUOtsJ/bvrV56+/OO1fs2yo7a5rFTPwsvb2HFpLPwywMqUMeVT4+KtNPs9bGo6WHgaRZoAzCoT9eVjsU/fNIF5KDCwd1zby72xRo+m341t4SL8La+ayNN03MvlgcwtFL8MZIUNIB4IcBG+/gHKvnLLlSBB5rh5S03ew0M/tvxgkOym8yOtY8a12hDSzjgad8SYBnCBZmCVzDk/+tjyODrmf2ZVuEvY3SjLRN06KPg7EF55+y9qjKu+Ptz5QpnA1+sMwbfiBKnLfWd44mzBpobJNU5YfQkNURuCzpmmprHprsSrK1VP/mFoPVE3VjcF/ycIfrotZspeyd+RYmzq/WDxh4nj1Qah/ythHPlwnA7esLo5BhimwbsQim6L4EJPLNHS/d63564FUjK7atAezOMreAhzFSMXUGkp+pKDokpHL99vpT7bSaC1BN4H2lPmbkxj2R0jVxidVOyyFzJwkf213slckoR1JlKNFZ1hk78l8YOKt31ML2XqxhGb1nskXDVF249AuEkq4DMPbli2Iftw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGl6SGVyZEZYRWxvZ0tTYmk3dGo0Z1hmUklmb1gzenBtekdJVDdzdDJ0amd1?=
 =?utf-8?B?N0x5c2tvWktQSjgyZnVrc3luV2kxOVo5ajJsL2xGYUlEaUxvN3FEeENrczFu?=
 =?utf-8?B?Q0tHc0xNRzIyVVQ1WXpRN2o4OVQzTzA0UElOUUIzRklweEVzQmtUaHZubVgy?=
 =?utf-8?B?a1hqQVRLRnNMVGNtRGFJZ2EvY1B6aHBLK3R3dFNTcVFaWjdGaUNoREZveFFa?=
 =?utf-8?B?U1VtYlF0c3VBWStVVWJCbFBmK3pna1JWUzE3cytoNWVWWmQvVjUyVzFFZEhP?=
 =?utf-8?B?WWNnbGwxbEZ2N3F4d1Q4VWNDVjV0YXlyS3h5TllqUjJLV1JkZXVybDZFRDdi?=
 =?utf-8?B?N1dlMFE3eVRWaFJHR3JyT25rdzBHUjNQTDQzMkZRL1N6b1hRWXFUSXF4cUx2?=
 =?utf-8?B?TTBwQ2tqaHN5YittS3dxRE1wWSsrK1hveG8zVThub1pzT2Q0REZETk5vZ04v?=
 =?utf-8?B?UEc1VVN0MFpWY1RWNktZalFxd0tDSnVQVkl4VUF4aFI3aFdBWVFXQ0R1ZFQv?=
 =?utf-8?B?SlVpL1dWekhNaTA0ZFN0UHN1eStnZWZlM21jZ2hWVGp2THVUUFBLaEltUCtu?=
 =?utf-8?B?emVFOUp2dFFuQ0dsY09SS09FTHUyMGVRdGNpWnF5Mnk5YXBXL0l4YVU0RHgz?=
 =?utf-8?B?U09NNEFTT3JQTkpUNlJPbFZYa2lkRlp5cXJaejkyUzBKZXdkc1IzZXV5Z21L?=
 =?utf-8?B?RUgwWWlxM1V3MkoxUGZrbDF1enZjblkyTTZWWUR3TGZIeENxSjhtU24rdzRM?=
 =?utf-8?B?OXVKeVlhOUNqbU9RclJneXRxTU5nYTZmdTAxdksraXVIU1hMUmN3cFg1cUVw?=
 =?utf-8?B?OXRqelZxMEpjdDY3WlVZTWM0Q0Q2VzUvcXU1Mk8yYmNGSGNvcHowalI0ZGpB?=
 =?utf-8?B?VUtYL3NFbUtoTVVEOTB2TTllMGpuTWpMUWVpY1Y1WXovcUlhQUl6RzR6Qi9P?=
 =?utf-8?B?NUtLaUNZM3R5VGNoZG9MTnFKdjg0Zi92cGN2WFFsZkVTN0Q0ZmR2TS94Qkk4?=
 =?utf-8?B?a3NZN0NWRDZsdWxDYmhUakdDNlF4b0trSHluVmZrdVNLVkJoVWNxNlhOWW1a?=
 =?utf-8?B?RWhPOVp4VkhhcTNYZHZwTTNnRWtzUURXUi9TbWR4YUV6N3hlKzFKNHFScUFS?=
 =?utf-8?B?SE5EY1A4QThkb0RlWWlqUjU1V1JvTUFxVXRXeDVLZm8zWldkSG04eXgzZkE4?=
 =?utf-8?B?ZlR2UXFVT1FubG1yWXpqQlJwcTJLdEtmbHgvYVJNVFFScXltVW1waGQ1WDUr?=
 =?utf-8?B?cG5nYVcxb0VFclV4d0krVXlKZ1diUkx1anJkQWJaSDlFanhQYnAvelNoaFYy?=
 =?utf-8?B?ajZpTHF3MFo0anFKbVVvbk5BcDhjOURzY3BYYnU4OWM5NzFrQ0lXY2lXYktN?=
 =?utf-8?B?UWpzRmZCRkVZV2I2djVTL1pLb1RLbEZjN1NVZ0t4dzIzM1NVY2x0TEVEaEVz?=
 =?utf-8?B?VnlqMGRRK2d6YVlqU016Zkd6WFBzZ1FadmtYRWNoWXBjRkNEREkwa0k1ODda?=
 =?utf-8?B?NEpxUk01WGFhOG9kejc3WGlDMnJ5UTBXcVdxMHJybUpaNDFFNjZOL01ER1la?=
 =?utf-8?B?b3EyNmM3aWF5NmY2WjdidjVVQjdLTVpXWk0yZWgyMHYrcDNBcFNTNGl5TGlD?=
 =?utf-8?B?cDRUWDhMMXRqUjFqU0JQNURndEswbEVSL2NIUUlhaGJMRnRRZHdKc0ZqdmEv?=
 =?utf-8?B?c0w0YlhBQXZRTHRodkx2SmxUb25kUUFnSFhwSFJFM09QbDJQTURoU29vYTh5?=
 =?utf-8?B?NFpyWndkUDkzTkVFL3RYaXhadGZTaUFCaXA3N3dwNkNKNndseE50aEVmcXN1?=
 =?utf-8?B?T0duKzRLYW15T1FFQmZ5YXJuNHVTNXprZkRMQi9qcklVU2h2SW1mUzcwa0ZH?=
 =?utf-8?B?c01XV3B4Z0krZXk2dFo4SEhiYmF2Z01ydWZzWDE4bkhRZEpZV0pYcmpYVHF2?=
 =?utf-8?B?U0ZUc2E5VGdKRVloblQvaTFaRUVMNnFud29SVEFIYnpzcFRHVlU4dFZ4cUcx?=
 =?utf-8?B?dnFzZUxxdE9TeFhvYitJSlZrSks2VXJvLy9WS1VkL1ZYc2tJUElZMFM3aFJz?=
 =?utf-8?B?QnRIUTgvdGNIeXN3UVZvNENDRTRPMGFuaEI0SGt0dW1JY2R2OHNCaHgySFVu?=
 =?utf-8?B?OXlaRTFjekkzUi9uc01VdjJ6eksrZlQ0UEZ0bEs0Y29sejJWNnNobjd5c2s3?=
 =?utf-8?B?eVJvbm90MTdCTk44UkNobUI1NkV0U0ExYTBZalZKc2lPWTEzcVZVU2dNQ2lt?=
 =?utf-8?B?RU0rdWFidFZUOTRGcTZXamhvWS9FU09RcEdiTzJnWEZJeEdPVVRzZGwyUFJk?=
 =?utf-8?B?S2l0d2ZianIwTnNSeUZjMnRRUkcza3N6NlZMQllzclc0blRSQVhKQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71ea946-347a-4147-5ff6-08de79f7fadd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 14:11:50.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lzbFhiLv7uMn8Ar2XtNx/aaga2reiKIUcJKpDlaheSndA7LAjqL9Xy3+ZSBT/ot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999151
X-Rspamd-Queue-Id: 51C502019A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17470-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 12:05:11PM +0530, Sriharsha Basavapatna wrote:
> On Wed, Mar 4, 2026 at 1:20 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > This flag can be set by drivers once they have finished auditing and
> > implementing the full udata support on every udata operation.
> >
> > My intention going forward is that driver authors proposing new udata uAPI
> > for their drivers must first do the work and set this flag.
> >
> > If this flag is not set the userspace should not try to use udata based
> > uAPI newer than this commit, though on a case by case basis it may be OK
> > based on what checks historical kernels performed on the specific call.
> >
> > Since bnxt_re is audited now, it is the first driver to set the flag.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/infiniband/core/device.c                  | 1 +
> >  drivers/infiniband/core/uverbs_std_types_device.c | 8 ++++++++
> >  drivers/infiniband/hw/bnxt_re/main.c              | 1 +
> >  include/rdma/ib_verbs.h                           | 6 ++++++
> >  include/uapi/rdma/ib_user_ioctl_verbs.h           | 1 +
> >  5 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index 558b73940d6681..5b4fb47cbaeee6 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2706,6 +2706,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >
> >         dev_ops->uverbs_no_driver_id_binding |=
> >                 ops->uverbs_no_driver_id_binding;
> > +       dev_ops->uverbs_robust_udata |= dev_ops->uverbs_robust_udata;
> this should be: dev_ops->uverbs_robust_udata |= ops->uverbs_robust_udata;

Oops, are you OK otherwise?

Thanks,
Jason

