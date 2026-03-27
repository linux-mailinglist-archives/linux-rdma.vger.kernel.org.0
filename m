Return-Path: <linux-rdma+bounces-18738-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB3tBxuexmnrMQUAu9opvQ
	(envelope-from <linux-rdma+bounces-18738-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 16:11:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5C63467D6
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 16:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 225133038153
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8330F534;
	Fri, 27 Mar 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RAB3xRLZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255225A2B5;
	Fri, 27 Mar 2026 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624171; cv=fail; b=QAWNaqGNa2I+K5obqzvAVnSHGC6wnSJbyiRXSlHRrgu8NqemHvH2FcUpwfPrb9rrFvhfrEqXnQyGkMGu0+M/wHqryQ4gL6m8oT01nlUL87vpv3XD0QJWuT4AEOqh0c0KM/s3aomE+X1/lKiXExbZRpiNLNyA5YS/EmrgSC8KdKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624171; c=relaxed/simple;
	bh=lZU2pkU1w0pEJjx1pIINLCUurmOSuiFcWsLAN5tXigQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PTnXp2zTj2YJ4ma4BFo+HAwjkGr6bj1uBBYBPqAUe8a9LwJ8TwbA2uKqz4M3SWe0fzAMZ4S9WmrnB+yQk3CVs9tTgaUIUcBoaRM7UUc3feJNldQhkGEc7BOFz8jC1EjHFioGN+dXiqXVQnfhw+FmfuoqBKlJqxMAlrboR05217Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RAB3xRLZ; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yvx7hJmns8cS+2wJXxH+1OMyW4pzpLZyiW7nw4Qa1Iaref542Ekuarrnk5ISjUvMrsk7MPMX/m3uvrXRCEIcznvj4esGcAN7P4mNwZEVA56T5pMhOXwvBoxVcHJOKoDs06f1lHLvrBDwWafGM2rWQi6hnzaoZwY+b9SuTU5B1QDOnRdfd4Jxfa1/Vsi6CYo4wmE7aC9VYH8HHowFr2+fmpGjZ4HDfsQMg4IWV/UlkqblVwUdlJkCl9oTP6QnYqCbI+Kq1W17PnN7b3XpoTCtwyOzvPWguvDV3ftzmnoyBTT4rKqi/4D2UCW4vDVaxkvzgRxoD/UrCirhscMsoHY07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXmcGHvEeoG5a3s7DI8IPm2AdgV6skqeZ9bBiMY5Bu4=;
 b=G62xGwDGwGh+FIy+ag3lje67Enla25gr8azyJO40asIgjyLOwwz7CXE8bTr7fDZdrWw8vZIouUwxSDr3u9Ed88iKv4/7MF8r7HPkmGk0CeMV28VNWmxNHEjZaTtKXR1Kjv0iDE3cQ/7YxTzqLss4+2vWoZrFrMk6Jrw300c1Xk4JvfgPNvQ6Uj93OLLbFTRIg5fsHvahskAr4zH8Gr5YaVtDGm9AQoFVocls7uGNwwRXr2kZ4zOtnLPNrnyE0+yi1r4qTwrVdC4q01XS2Fuk+kKuWQEDR1fkYnHNeeVY0NSW+lOZ+2PUFCcaYXT5Airnlqz72128lXsramU9Tv712A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXmcGHvEeoG5a3s7DI8IPm2AdgV6skqeZ9bBiMY5Bu4=;
 b=RAB3xRLZCXSBKyjLkeYVE+e+8U3ZxPmH2VoMMh7NOlxIXmBS0VdZXz1gb+rMCqD1tGcc/z1BdWoYigERFSfZzNj4iCpbHpQAR+IPlEOgj1g/QQz6S2i4Q3tgLm5PJxxUfEvoYR5C12ee8CLkW+YCNe5fjnhHv1qnJ6h9tLuHolCFSgRDHE6aBlaSFK8QCHxopYDbGF9P1jVYPY2HMshDXqYef7ZbMsfbc62YkzVKGpfhDXjG8tVPtToQp4RFleYA7KRDqP6oN1cB8aEfkQuegYQW4cjeU+YR8dgV33vMQb933sTdg4k5Eo/Q7ZgOUHYBGDdFvDuk2MscuoE/nuPx6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 15:09:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 15:09:25 +0000
Date: Fri, 27 Mar 2026 12:09:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20260327150924.GA361486@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fFZqqHq349ZwvYMp"
Content-Disposition: inline
X-ClientProxiedBy: YT4PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: a0941267-8bee-47ec-3502-08de8c12d58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1fS4uqFXolm15KCx7Ex9rZandsnU9rSZM6VcRfU3dwB1sAEK735H8zEWMinwf7Lrv5JZdmf9q0jXVFtbsCqHEC+3K3Mrq0+k2z6c30PWpiGevXBRHagvep27RIOpdKad09HTbU1U/UE81QDHjLRUOitoxXhMnoYGwRg6hDyHMvCz9pL9scJV08+xDM+8NhJ6oDoZFjb5JWSvOn6r98QXxHntopx5NODH0ZmczjJgISLwodpkB6jKVXEwBuEnrzRLoL6DehCwOtK3hcjRYZJ8mGcTWfpmNEyUOsYv5YsxjLhM6Q4h1826vpej7NGWapa9J7X6pYEWTZeCL/WrfOgLtHEoL6++H0FzNcxq9rAoBB6SX/DI4ZrmEi1qAyPGn5JCv7DW1mpygPi2CJb4P3yadiI5Rpm9LYTse+IFmMR7oMwT+1lqaeqq0VBdStPwl8jvdhAGwMhQnzvSe6meEarEb1RG9KSO0ywIjhTxmxrmpkLWeGGEzomARmargiusMr2uteq9hEPT/Opn1yobket41iNsX23xD4685Cyye0n3gN1eTxTYEHSmZg84HbetJt9+GQxWfmDPFz8NeA6KCtlkzgHzEoPl01r5Cu4mB1uw5rBt7DMVN6wcsJq3R9t/bklPSTZdEqTyvWpWNTARSbMbi0FxK2t41y9opyKiH05ffd04/a9AtsW5SIYnNEsVVx1pksvQf5qft6ozHhysXFcM9Gd2NsJRK/VmYwGedta7zZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xa4ks9kvtwwL1NRzTsxhUIp0r0ZBrqPkxI2dOxBn88rrkjQ1LU/aGC1bhyg2?=
 =?us-ascii?Q?XkuZJWtqjFzuZch+v0hzS21r6oP7aheP96PnWAwjQxncpmlc6J1B2zptnobh?=
 =?us-ascii?Q?OHyn1faZaP2mtKkevdTpSgOBc+Z1ahMJ85z+4rPiAEv5tGkz0gnv+n7BqgYk?=
 =?us-ascii?Q?baOBFqmGebpngWWF0ge2Z0kx2VuwYN4WmEexEujf00310lqM7kuxkieLn2FM?=
 =?us-ascii?Q?145sdVjGP3Lk0kOuLxvBK0SjmcoYbyiGaLkGPwiFJ9pBbye9jSLqJDr9VYN9?=
 =?us-ascii?Q?Lw0o5zioXKUzkeUaysenanbTzmu9cVEiv8uBq66oYf8rOl2NY+tObjm42seO?=
 =?us-ascii?Q?/rbeHTXvOpaATpPYvFgFirlENpC7pLXaOHTgfpclj4uicL2oMotK+Ag0YBv6?=
 =?us-ascii?Q?nzEzT/bgED4QWuWlyj8INiCYg6NEKHaG5lHSiptVp27ZWXbURcPUWQpQMYpQ?=
 =?us-ascii?Q?yo+YfQT8kGxChLiDARKllinu52lgdVzFXmoFudM/H1fLxUoqNzmLkCu/gy1d?=
 =?us-ascii?Q?OhbcOD9D2KS2kxSyQQcstZ6qgHRG5St4aYZCOweimzlUwh/yJHgjxDM7lC5R?=
 =?us-ascii?Q?IaMyfWLpgvdAzc1BfTgFmMZhQ7jkp+1oICQn9mDidtAnAoxSEplKa21g5u1k?=
 =?us-ascii?Q?ZuCF7Yuv9b+QHyiEZnNhhqeCz+7Z7vokPBCGmLsLkv1f92E665FVRvyyLKPM?=
 =?us-ascii?Q?18fOlxv4lHEC4CKoIJQdO8gOxDt97Rb4tGR6LAEr7SqGUunFPu1Xu8BjK5gv?=
 =?us-ascii?Q?P6ssWwRdaoNvVwBTIDr3eYRHvFcVX3OGovM8cCB4oMRRNqxtgAdB4jb66m51?=
 =?us-ascii?Q?uDDq7+MnxbdUwgcbT9NSYr2yCUd5q5hfUyGPrGsj9rA2Qk2aB86KE/CGUdA8?=
 =?us-ascii?Q?TCFkLSbNt+ldNojdICm/njZPPfxdzmKAtSctPBmrJn8GTSS6frLt+JNGT+v7?=
 =?us-ascii?Q?NKsD5bySkyaw9ZX3IfZ+BCUQkG+XWEAbYVcxfssBiAfz2PGiulHVWZL3L4iF?=
 =?us-ascii?Q?DxvZ9zALhXXyFYgL30UXcKyZzD0S84QQ4vqH6E2AJBmn+yYqRRDmFvctljui?=
 =?us-ascii?Q?brlpCQ0oX+Xtn9sy/Qpe0tbjvOwCGuxcg2E7RkkNqIE9X7ZvHsYo6yJs7b6Z?=
 =?us-ascii?Q?znqOXn5hzzKOBW9kwchy+uzby0TxQjg+gmZ15kQD800d33+JVgP5fVOWLQ12?=
 =?us-ascii?Q?VIJ7KXpmu7jzQvzW7dEtoaPaQ/pD+tgrVtufiKCw2lgY1iflVVN+WrpTzjEi?=
 =?us-ascii?Q?yYlBWNGEVWgGqlD/QaqQ/vLrCqrxAcuOeZ6CTzz+bU/itZkNRurJiFr3N59m?=
 =?us-ascii?Q?hZ/uqxP8Z4ZiVe12O5jg5yF0c4ZCjCyckL0eT6eAbyBTBA993mZC4Vzy0aaW?=
 =?us-ascii?Q?435serR2kmfwpKPUK4vrFDSSlua/MK9p14Kv7Gxju7XfPazjdUnFCxBCsn4o?=
 =?us-ascii?Q?0ymBPdDkWLffSBSAmAJp/mc4NVcQbSr0coBx+jV0v/lhY8xe/710IQj6sypD?=
 =?us-ascii?Q?ZYmgsvb4rtvGWMF6fPlfNFnC1yjk3KEIZlwbJU0CJ4jL9DHm7iJ55N7d2P5e?=
 =?us-ascii?Q?bDgo64Mi+IkIM5NpjB27dNygmpfEPu0jD4QtwAx4BdFW51EC53CkZJ28VIjV?=
 =?us-ascii?Q?5YIX5khUY/ErTOBrb6Tk9nphoeCKWfZEFZJ/EBx+6cQwmYL7UFgTqUddaDyH?=
 =?us-ascii?Q?75W+02R+wO7NBf/eeDsbgVc/Ld5Tj+JJPsrZPmfpsOQklnN6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0941267-8bee-47ec-3502-08de8c12d58a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 15:09:25.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WY/KBSmy6oQ580nCf/bvMCMZaxMDspb5cJeUajNEyCZOzMHDdeE6k6Z8h/B+yhUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18738-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F5C63467D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--fFZqqHq349ZwvYMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A handful of rc fixes, with a bug chunk of irdma related items.

Thanks,
Jason

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to e37afcb56ae070477741fe2d6e61fc0c542cce2d:

  RDMA/irdma: Harden depth calculation functions (2026-03-18 06:20:53 -0400)

----------------------------------------------------------------
RDMA v7.0 second rc

- Quite a few irdma bug fixes, several user triggerable

- Fix a 0 SMAC header in ionic

- Tolerate FW errors for RAAS in bng_re

- Don't UAF in efa when printing error events

- Better handle pool exhaustion in the new bvec paths

----------------------------------------------------------------
Abhijit Gangurde (1):
      RDMA/ionic: Preserve and set Ethernet source MAC after ib_ud_header_init()

Anil Samal (1):
      RDMA/irdma: Fix deadlock during netdev reset with active connections

Chuck Lever (2):
      RDMA/rw: Fall back to direct SGE on MR pool exhaustion
      RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ path

Ethan Tidmore (1):
      RDMA/efa: Fix possible deadlock

Ivan Barrera (1):
      RDMA/irdma: Clean up unnecessary dereference of event->cm_node

Jacob Moroni (2):
      RDMA/irdma: Fix double free related to rereg_user_mr
      RDMA/irdma: Initialize free_qp completion before using it

Kamal Heib (1):
      RDMA/bng_re: Fix silent failure in HWRM version query

Shiraz Saleem (1):
      RDMA/irdma: Harden depth calculation functions

Tatyana Nikolova (4):
      RDMA/irdma: Update ibqp state to error if QP is already in error state
      RDMA/irdma: Remove a NOP wait_event() in irdma_modify_qp_roce()
      RDMA/irdma: Remove reset check from irdma_modify_qp_to_err()
      RDMA/irdma: Return EINVAL for invalid arp index error

Yonatan Nachum (1):
      RDMA/efa: Fix use of completion ctx after free

 drivers/infiniband/core/rw.c                    | 37 ++++++++---
 drivers/infiniband/hw/bng_re/bng_dev.c          | 14 ++--
 drivers/infiniband/hw/efa/efa_com.c             | 88 +++++++++++--------------
 drivers/infiniband/hw/ionic/ionic_controlpath.c |  4 +-
 drivers/infiniband/hw/irdma/cm.c                | 29 ++++----
 drivers/infiniband/hw/irdma/uk.c                | 39 ++++++-----
 drivers/infiniband/hw/irdma/utils.c             |  2 -
 drivers/infiniband/hw/irdma/verbs.c             | 10 +--
 8 files changed, 123 insertions(+), 100 deletions(-)

--fFZqqHq349ZwvYMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCacadogAKCRCFwuHvBreF
YdcdAP9oUni3kzQ8XSbK+eWHa9Fzp8YNrNAEPyyE514hcGOX5AD/d7TGYguDUuqX
lyoQUQo7My4ATyGvXIAEZ/94MI6bLAs=
=UfSm
-----END PGP SIGNATURE-----

--fFZqqHq349ZwvYMp--

