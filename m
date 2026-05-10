Return-Path: <linux-rdma+bounces-20322-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIsAD8T2AGoFPAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20322-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 23:21:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DEB5066F7
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 23:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 294CB30039B1
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 21:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6E23358D6;
	Sun, 10 May 2026 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="s9PQtCyr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012011.outbound.protection.outlook.com [52.103.23.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA2274B3B;
	Sun, 10 May 2026 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448062; cv=fail; b=RIKAFuMK0emniddYDqpg1w0i/pyb612tfBiIgHTzXim29kgihmUO805S0vqtD9guumcc0Kc+b8vYdjw7N3JUu/vsZN+vGnte0t8OFxyW/ZMuLs98FUWUICGpqP8FMfjpLDFW/RTW/UEgyYqEFg9qDC9zVgRB9C4x5ZekZTSrndc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448062; c=relaxed/simple;
	bh=p3sDbq6vVIxjINOhSNdachTCGaXtBdxr8UaXEVRkoRE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B64A3wzJMGR9Gds9M2uJffQ0dNJ0ocBiYLDEcXsBsgjLKPuCSrFXGAzOwly6eoC/f47QggShDMNEWF3Q2C3ulRKPXoWmVvYFAZvY5L7TcHRu7DypRss9Ans6JXjwCqNqqyOAWToP7Oz7/LEkPiLQc9Z9t3hJD/wgNZlR8Cp3unk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=s9PQtCyr; arc=fail smtp.client-ip=52.103.23.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHVaxX2XoB0hSkYO09Pgqrs51yBbW3AlCBGie5yCog10HTPjOjJyXn6r0EgNkhY+4eWUUxnR15hz5GFkLrBN8P8zR9PjymRNEMsGn5RipRfUPziluf702LYoDPT5IjWN2lrC1954Dc+hNUeL2v4eq1QYqS2Y7hB4muGkKV7z4RYka9qh+EGi1vyPlNKcRkSE0eY+VNaD/m8e59sGRzGIQ70X0a7LgdX+MAH/+jklpso73ZrrpYR1CfTHwlmQWU1I2TERdlu1Pn/wu/jBvNmABp4t4M6JAo1jlRPLQjBbjXghonZ6+vGov9hrckGnGHKcLk7Lw3irra15fUQHGcxjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jACOPatPHjAUIMNYoPFR/E6yUAa+R1O/lfygA8JJn8=;
 b=dHoQ02ubyOt6/gVnSB2buj8/KB3UboKnAw28Dm6alL7wQC77OFOgc6jXq1tSgKcd5Qwqs2W0MbaE3v3+w1GwO6/kYpKEKFolPWArbxFQ28J6GqNrpnj5NSy+EHir6EHsiGGF/meWvOR3rV23ruYp4v01wYPTLQEurziH6KizLAz7Y8ZqNaM57a0dsu3ZtUmtduLBH2NyfMmjwI5HCpk7WJqwYNh3roE9xOED/Sc45YeojmSBQfwaVH12pk8OEA7TYBOZaub34UAkNAfMp/i/CjKtUfIQ2aei6guIt3CERNP9lc7RP1VfG1NuAADnWiBUJNkSXI1jOszhqlNECJ5UvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jACOPatPHjAUIMNYoPFR/E6yUAa+R1O/lfygA8JJn8=;
 b=s9PQtCyrhdd0diVRtCcWzRd9XI9oRIeBlYNctfbAiycCZwyqpmZiPH4ORN9mutBiAmfsO9GW48ICPd57LcZYOTATm8Nmzx9rn2Mlq2ly2g1zpCsxxTSLjc9ym5vQnxqu+WzgJ+8tixkIfAYNACI8s0iRgYCTTFUwSzY9F61L2d+ETGPwImPL5eAPi1dDlswQXAfMClgr5kmLTrlos35GlUjcLNZnOnlCX3a50jR0R1XTH8cxknSg7WdwB21tpJjf1rPOV2ab+YiZxeOMPkAa4J4l9GLSpLJqMBCgbTVMPdsjh+DyBARvEotJKfquBvQ/bZW6CErLu15EZv+eY7Ww3Q==
Received: from CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5)
 by PH0PR11MB4871.namprd11.prod.outlook.com (2603:10b6:510:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Sun, 10 May
 2026 21:20:59 +0000
Received: from CY8PR11MB7084.namprd11.prod.outlook.com
 ([fe80::d056:e384:cb2:38ce]) by CY8PR11MB7084.namprd11.prod.outlook.com
 ([fe80::d056:e384:cb2:38ce%4]) with mapi id 15.20.9891.019; Sun, 10 May 2026
 21:20:58 +0000
From: Spencer ?? <spencer.phillips@live.com>
To: Allison Henderson <achender@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net/rds: fix zerocopy page ownership on partial copy
 failure
Thread-Topic: [PATCH net] net/rds: fix zerocopy page ownership on partial copy
 failure
Thread-Index: AQHc4MHBGgAOr70AEUyEULgfuWhnXw==
Date: Sun, 10 May 2026 21:20:58 +0000
Message-ID:
 <CY8PR11MB70846C6CD3C93572660CCC40EA3B2@CY8PR11MB7084.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7084:EE_|PH0PR11MB4871:EE_
x-ms-office365-filtering-correlation-id: 2c3e2f20-b929-4930-c319-08deaeda0780
x-microsoft-antispam:
 BCL:0;ARA:14566002|20031999006|8062599012|31061999003|8060799015|24021099003|41001999006|19110799012|37011999003|15080799012|15030799006|12121999013|39105399006|5062599005|40105399003|440099028|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9PaW50GKC2PJGSW7Qdq/EK6mu2+RhqDEXc8ae3H7dayDPHeZc2d50vxjzE?=
 =?iso-8859-1?Q?KuDM8UVCsWx2PojSZcMi9hj49fdHarfuvukzhGO5lllSBgWht7/V8NZYfy?=
 =?iso-8859-1?Q?JwmzVfykM1x3Py288qRl5yBsxJyJfrb18bqzO2xDZPUFNexDkafpCfR0r+?=
 =?iso-8859-1?Q?2bIS1iAJfRYpb2fxxJlq6vwoSiLszqbURxccQI5x69GrCPNAGOIw17qAbw?=
 =?iso-8859-1?Q?b8LpKZ8Y8S9BnJ5fHePBdogMtLg0I1uSHp127F4SiNNCPDWBophUI+NH0J?=
 =?iso-8859-1?Q?IuhXxsYxa/RYQ+RQS2fmtqdxMlmDrxZIP3LlBUgy54wpW7iC8HzCmTFW74?=
 =?iso-8859-1?Q?5pHJ+UDdSASiYGaYI6lPNe1cXMzYgbUKpAILLYtayYLJNYto9GxEh0eSFU?=
 =?iso-8859-1?Q?kRBeVEdglZQPBNyaWEKh1LCKzDNZsQ+PN4aeDM8RXCy0ZLoBT9fkCrZpmQ?=
 =?iso-8859-1?Q?6puG6BstRQwGkMbJbCuC389wqiw5ZQ5TPcedQ1/x4YF+0nXTjgEoBkz7/G?=
 =?iso-8859-1?Q?N+jOuA3KAtqxKGo3vHpZdp8QhyZ2Ja4LUyPGv/oy1mcAAGrX5eWl2gxU9l?=
 =?iso-8859-1?Q?cZPRiOxvG2U1ik09jWfM0CzLFsfa4daVPGaQUYUI1sQylhX75dTMqhmO8L?=
 =?iso-8859-1?Q?Me/CA6BSsd0wO6ewTXruPRc0cXyqRWw6UOudPj5VlsWKDSRd5JzbOPyA1b?=
 =?iso-8859-1?Q?dnxZ7LVQ4cpIBZ3hbl3ddRSGqTWF+NXqr7Z7Tjpx/dkisADQjo9JV3xzyu?=
 =?iso-8859-1?Q?g47ejSU1RAohVxOPfDp/wyeE5+2x7+6nuMn2aEhcOPCtLrYYlg6qwl2TzN?=
 =?iso-8859-1?Q?miVJyCxPVUGb5XXUkKWrbdnj2YuT8dX6YJAXmk1kPyE1yLcS0xufYfoqoc?=
 =?iso-8859-1?Q?qjpj55gcwrOvRc0AZntMDiJqPP8LuJYW+vYuYR8W6zYcfwwhirB/jzTPez?=
 =?iso-8859-1?Q?eZjceQ+XB2VRRg0c9DaDcysijaKHaJLfl1buDmA4x4Hr2wBTDr2//VNQss?=
 =?iso-8859-1?Q?ihaJPmb3E0lmJkV6Wd8BfHoVKdXYwD/JJRPQUcWI+zevNQ8QwD2kZmbHgM?=
 =?iso-8859-1?Q?OwfvExkLJQ7YQH96pSd2xDy1C+pjbwPwXXH56iy/wnM6/Lcpo6ZdLLCXnY?=
 =?iso-8859-1?Q?ulbm/Ho3S0pKsf4CLz1kSw1r0Cd16yhp+Hz5wEVNrYn4fs84QtiI9R8Clw?=
 =?iso-8859-1?Q?lEMxIo0QDMvvdQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?D/oLUbPbiveZhxDh30EOPhAT/AWEQfSxeaApFV0tbHu4IR6rsE8r0Dmcrc?=
 =?iso-8859-1?Q?ISSSJnZyKm51yA84QzS9d+vuQixHHLwhq1punh/xhqg1tx1y2tUVEJ820S?=
 =?iso-8859-1?Q?eA9PTn3f3nUIhsA47VmR2OWxexmGVBnftspr+C45K1NjxjsrBMzbfWqff/?=
 =?iso-8859-1?Q?nE5D00OX3zTNHimIG5nknGOZhn3JskDjLyJpmH1Cs1sCC5/hgyVIXzmebO?=
 =?iso-8859-1?Q?m/I4a3FXaCqFI4PI4VRlyprIFtwHxgubAqUP3n2sP/C88Ja4nHr69ER0FU?=
 =?iso-8859-1?Q?ogHlnfnTnzNXTJnAGBL6tdeXJA192PM4uhN8YF4EM3wJMpoF+rBeTNE0IW?=
 =?iso-8859-1?Q?Xa0SophVtzmeCmYl+MZsTcu9II5GsBT6abjQ6UZsbu/BqvdX8W/jpkquFK?=
 =?iso-8859-1?Q?T5zZbi//r72IcqLnt69UDzIdQEseVWHFei9t2BjUNePSQQEI47gzyYs8FY?=
 =?iso-8859-1?Q?gKF8iROBQPShIal2+FF44p6EFVwhFUrPhlNA1InxHoFuobhBCCLLSL/1wi?=
 =?iso-8859-1?Q?QEhTstsXVUX4U6Mw/1tCw3qbicS/wl0uq+m80P1SF2T79wzUn8uP0cZPLe?=
 =?iso-8859-1?Q?ajVhvSHzItrnXwvPzPLpWlxpwZ3IXFnVY96Myz4jB5nA0pcisYTwZo3XYp?=
 =?iso-8859-1?Q?uz2hYOmYCfgaLjMNU77GQsLlORXtZUAkkdiqo6Q3lgZ9aOj8MR6xuR10NR?=
 =?iso-8859-1?Q?UJ7GQgpD6a8NsUPsiG3hs3mNMtO2yjSHJH8y3SMHAUtBpOWmSUUDOzP0fr?=
 =?iso-8859-1?Q?RJNxdmt4wySp39OiPpqayLRR89aHV1Do8wSevh1HN9FB/0BE5cyIUJPchI?=
 =?iso-8859-1?Q?Ee1VOvHcwtbONiI+Ssqc5RLEQkEeiMvgmZEQ8kHl732prl667PsvEv+79V?=
 =?iso-8859-1?Q?P8s0/ECgiFpsT8EUmolDD56DH65i+jbyGzusZv1T+FTcPy2TBgctPc04BV?=
 =?iso-8859-1?Q?zwJaQQHjpV0we2czM8DzrF7X69JHB3wu9Mp9S3voTwPtIGAg3P4XovOTsC?=
 =?iso-8859-1?Q?NeG5M0/WRtqUSbPFPXhZY8DBtp+7yx96lEBxd1GV3xeBu1HN/WBcB/I6Lo?=
 =?iso-8859-1?Q?Xh097D3kRgJxfV38v8l+OTsJ5qUOSVqgzVerU7ClLsat6lCY+hQI/J9gzR?=
 =?iso-8859-1?Q?838/RM/5gboYsmRjAKgnOsjHtHKBC3SV26nW8xKTuJCGCpzqzfSgSObyuy?=
 =?iso-8859-1?Q?s554xHYly2n1ZAndwNbfeqCC2fpGimDqFrHSNsiVf3WrDOCoQuyqYM0fgx?=
 =?iso-8859-1?Q?tEGAp7XHvmfkTabjIhQgRHLLrAAWcoT4sAwz+D7po76z8SK6WJHy09QNo/?=
 =?iso-8859-1?Q?2QavYKCg46KF+AlVtjSiSpzvhYgPqPQ3vBc3O55gdELm8hje6cHs1fYV12?=
 =?iso-8859-1?Q?8iQY63IYUXPpPM3KyRmJb5izjECdFDFsBqoOHCsOoR6C+OXy22GRCvB2of?=
 =?iso-8859-1?Q?WWRVGMal49Q63YNO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-a6b68.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7084.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3e2f20-b929-4930-c319-08deaeda0780
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2026 21:20:58.5099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4871
X-Rspamd-Queue-Id: D4DEB5066F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20322-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[live.com];
	DKIM_TRACE(0.00)[live.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spencer.phillips@live.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[live.com:email,live.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

RDS zerocopy sends pin user pages into the message data SG list and uses a=
=0A=
zerocopy notifier to carry pin accounting and completion state.=0A=
=0A=
If iov_iter_get_pages2() fails after some SG entries have already been=0A=
populated, the copy helper currently tears down the notifier and returns an=
=0A=
error while leaving the partial SG count live.=0A=
=0A=
The common message purge path no longer has a notifier to distinguish=0A=
zerocopy user pages from copied-send pages in that state, so it can release=
=0A=
a still-mapped user page with __free_page().=0A=
=0A=
Make data page ownership explicit with an op_zcopy bit. Once zerocopy pin=
=0A=
accounting succeeds, leave the notifier, ownership bit, and populated SG=0A=
count attached to the message and let rds_message_purge() perform the=0A=
single cleanup path.=0A=
=0A=
The notifier still controls zerocopy completion and pin accounting. The new=
=0A=
op_zcopy bit controls whether counted data SG entries are released with=0A=
put_page() or __free_page().=0A=
=0A=
This preserves normal copied-send cleanup and queued zerocopy completion=0A=
behavior. It fixes the partial-build failure path without adding a second=
=0A=
manual unwind path.=0A=
=0A=
Tested with an AF_RDS/RDS_TCP MSG_ZEROCOPY partial-fault reproducer on a=0A=
KASAN kernel. Before the fix the run triggered bad page/accounting reports;=
=0A=
after the fix sendmsg returns -EFAULT and no bad page or KASAN report occur=
s.=0A=
=0A=
Fixes: 0cebaccef3ac ("rds: zerocopy Tx support.")=0A=
Cc: stable@vger.kernel.org=0A=
Assisted-By: Codex:GPT-5.5-xhigh=0A=
Signed-off-by: Spencer Phillips <spencer.phillips@live.com>=0A=
---=0A=
 net/rds/message.c | 33 ++++++++++-----------------------=0A=
 net/rds/rds.h     |  1 +=0A=
 2 files changed, 11 insertions(+), 23 deletions(-)=0A=
=0A=
diff --git a/net/rds/message.c b/net/rds/message.c=0A=
index 25fedcb3cd00..a381a895339c 100644=0A=
--- a/net/rds/message.c=0A=
+++ b/net/rds/message.c=0A=
@@ -141,7 +141,7 @@ static void rds_message_purge(struct rds_message *rm)=
=0A=
 	spin_lock_irqsave(&rm->m_rs_lock, flags);=0A=
 	znotifier =3D rm->data.op_mmp_znotifier;=0A=
 	rm->data.op_mmp_znotifier =3D NULL;=0A=
-	zcopy =3D !!znotifier;=0A=
+	zcopy =3D rm->data.op_zcopy || !!znotifier;=0A=
=0A=
 	if (rm->m_rs) {=0A=
 		struct rds_sock *rs =3D rm->m_rs;=0A=
@@ -170,6 +170,7 @@ static void rds_message_purge(struct rds_message *rm)=
=0A=
 			put_page(sg_page(&rm->data.op_sg[i]));=0A=
 	}=0A=
 	rm->data.op_nents =3D 0;=0A=
+	rm->data.op_zcopy =3D 0;=0A=
=0A=
 	if (rm->rdma.op_active)=0A=
 		rds_rdma_free_op(&rm->rdma);=0A=
@@ -414,7 +415,6 @@ struct rds_message *rds_message_map_pages(unsigned long=
 *page_addrs, unsigned in=0A=
 static int rds_message_zcopy_from_user(struct rds_message *rm, struct iov_=
iter *from)=0A=
 {=0A=
 	struct scatterlist *sg;=0A=
-	int ret =3D 0;=0A=
 	int length =3D iov_iter_count(from);=0A=
 	struct rds_msg_zcopy_info *info;=0A=
=0A=
@@ -429,12 +429,12 @@ static int rds_message_zcopy_from_user(struct rds_mes=
sage *rm, struct iov_iter *=0A=
 	if (!info)=0A=
 		return -ENOMEM;=0A=
 	INIT_LIST_HEAD(&info->rs_zcookie_next);=0A=
-	rm->data.op_mmp_znotifier =3D &info->znotif;=0A=
-	if (mm_account_pinned_pages(&rm->data.op_mmp_znotifier->z_mmp,=0A=
-				    length)) {=0A=
-		ret =3D -ENOMEM;=0A=
-		goto err;=0A=
+	if (mm_account_pinned_pages(&info->znotif.z_mmp, length)) {=0A=
+		kfree(info);=0A=
+		return -ENOMEM;=0A=
 	}=0A=
+	rm->data.op_mmp_znotifier =3D &info->znotif;=0A=
+	rm->data.op_zcopy =3D 1;=0A=
 	while (iov_iter_count(from)) {=0A=
 		struct page *pages;=0A=
 		size_t start;=0A=
@@ -442,28 +442,15 @@ static int rds_message_zcopy_from_user(struct rds_mes=
sage *rm, struct iov_iter *=0A=
=0A=
 		copied =3D iov_iter_get_pages2(from, &pages, PAGE_SIZE,=0A=
 					    1, &start);=0A=
-		if (copied < 0) {=0A=
-			struct mmpin *mmp;=0A=
-			int i;=0A=
-=0A=
-			for (i =3D 0; i < rm->data.op_nents; i++)=0A=
-				put_page(sg_page(&rm->data.op_sg[i]));=0A=
-			mmp =3D &rm->data.op_mmp_znotifier->z_mmp;=0A=
-			mm_unaccount_pinned_pages(mmp);=0A=
-			ret =3D -EFAULT;=0A=
-			goto err;=0A=
-		}=0A=
+		if (copied < 0)=0A=
+			return -EFAULT;=0A=
 		length -=3D copied;=0A=
 		sg_set_page(sg, pages, copied, start);=0A=
 		rm->data.op_nents++;=0A=
 		sg++;=0A=
 	}=0A=
 	WARN_ON_ONCE(length !=3D 0);=0A=
-	return ret;=0A=
-err:=0A=
-	kfree(info);=0A=
-	rm->data.op_mmp_znotifier =3D NULL;=0A=
-	return ret;=0A=
+	return 0;=0A=
 }=0A=
=0A=
 int rds_message_copy_from_user(struct rds_message *rm, struct iov_iter *fr=
om,=0A=
diff --git a/net/rds/rds.h b/net/rds/rds.h=0A=
index 6e0790e4b570..b27848ec5c5a 100644=0A=
--- a/net/rds/rds.h=0A=
+++ b/net/rds/rds.h=0A=
@@ -496,6 +496,7 @@ struct rds_message {=0A=
 		} rdma;=0A=
 		struct rm_data_op {=0A=
 			unsigned int		op_active:1;=0A=
+			unsigned int		op_zcopy:1;=0A=
 			unsigned int		op_nents;=0A=
 			unsigned int		op_count;=0A=
 			unsigned int		op_dmasg;=0A=
--=0A=
2.54.0=

