Return-Path: <linux-rdma+bounces-19273-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOzKK8aW3GnVTgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19273-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 09:09:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B213E814D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 09:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6EE1300A4CA
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 07:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1494392802;
	Mon, 13 Apr 2026 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="coondgwA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012015.outbound.protection.outlook.com [52.103.72.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8433815C7;
	Mon, 13 Apr 2026 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776064195; cv=fail; b=LioyTgstZKd6L80LwUAEJrNCeysiEYN40bUWS4fk6gudeHe1KmiOxpBsy/edZ34g4DJkJx1bX+vx5AODptSCeFPF6eiKQIheOuh2YTccbdiC8jzSGopU0x90O6gX8xnJuOb6wNhnFdwei+u8QwxAFaa8iKxdWQW/VynECn0VeSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776064195; c=relaxed/simple;
	bh=BJh4tN6yxBDxr23tW599IRCfiWnJDZr362siH3cTrio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JkBJ49rDSjcu+HgIPiqcXuGn+seajcnhjPfRp8iChpl6OpYkIdiGyMZJTrUkeijdMMuh6GwwJyyVMDkOKlNk4rkGEbgQZ1K1AR1PAHQJr08zi7JdxGPIZa9QbK4ZXHquJ9RtqMI1MZH+HN6gH5VB/bYTmbglli0bOZTQe7AZEUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=coondgwA; arc=fail smtp.client-ip=52.103.72.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDwxCH+WgQjUnsSOmYjInt+gMZkbD164v+0aQX7S5Sw4P6HPscb5xv7y0cXJ4fMrwHc44HDXCZ8VB/Of+k+IefTGt2J+bznIVaA3gQiJcd3ZTtzQxjPFSSWmPbZC7mx0xZbckuWlqVa7/+PQHMkYq09sK1yUI8iA922cSje9BuPSLfI7kirMHXRGAI9enmmLow5xQiM548//HbUn9ewsWwT/yF1oKTa3BPn2fult9K7EZssaSoeJqKx4Wi7NkMJUBQ1yibRZa9VVxiAURU/dLaCw2lsG2Q66iH724WfWL4yEo10a1l2Jd9ffvagzlZqypEhvuBU+C8RzEuNTDU16rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJh4tN6yxBDxr23tW599IRCfiWnJDZr362siH3cTrio=;
 b=y7ezajJKk07fZ1Sk/If8icldTs2KdLWD4lJ5R9EB129F6w6gtXUY8FyKpgLQXHfbPmU1aRMlqXyyJciYn3M3KaGJKVXV+DwVU8lCLppbjnV0d/Saf8jqy09NW4keuTIvx9vgWecY0V+D2/RgOAgpcHFhLtAq6RLFe+DqGy2wyXGW7uBrPVV5idXGhtd037XjN6+ikkqgeg7l1Nl+hG/NERcIFD7IDKFV/St5Mpc201Qk38MMR+4ZTHmVo+6V18ew0XPuogYyqtTryuOwqBw8hh8y5PNCIjxkK1tZ7a83A19DFF76kZzYTfE0+gdxiSTbliv2nYR/HqhycjpB1sFqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJh4tN6yxBDxr23tW599IRCfiWnJDZr362siH3cTrio=;
 b=coondgwAMUD+ZGsjRhmMn46t2qdtYmbGIBvRC8DS3B3a3BkpjaVwbxVpFqTuJZCn5t3jmoB+lXMGgpy5ZvZ+WAe9QqStQHmtsJuGJcFh79nL+KLFeNXWIKh5mfW0IvTi09UubNekcPYfHn/dR5nLXQ4HaFMPHu29NC+0wptHgO1q/ai/PCtQ7HnulbB9Vm3j/v0tVwK8GID5yvjj1ZTNaSlVei6kUubncUTu2J0lG1MybLY6ym9JpiMO7RSMFtcvw+nlduQ/M3pISzLOvE7W1d01rpETV47febFAqf8aJ9Ev6fhJZ56+m/XyQuHxI0gtXd+MJqCX3xp54mI5fmmXNw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYZPR01MB7727.ausprd01.prod.outlook.com (2603:10c6:10:16e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 07:09:49 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 07:09:49 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Chengchang Tang <tangchengchang@huawei.com>, Junxian Huang
	<huangjunxian6@hisilicon.com>, Jason Gunthorpe <jgg@ziepe.ca>, Xi Wang
	<wangxi11@huawei.com>, Weihang Li <liweihang@huawei.com>, Wei Xu
	<xuwei5@hisilicon.com>, Shengming Shu <shushengming1@huawei.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] RDMA/hns: fix out-of-bounds write in IRQ array during
 configuration
Thread-Topic: [PATCH] RDMA/hns: fix out-of-bounds write in IRQ array during
 configuration
Thread-Index: AQHcxNSX9JVyLHajPk29RbZEsbilbLXbbBuAgAEyPYA=
Date: Mon, 13 Apr 2026 07:09:49 +0000
Message-ID: <E9C401AC-6A1E-4E5D-A3D3-C0D2216567B9@outlook.com>
References:
 <SYBPR01MB7881512F49EA80F0146EEEA1AF5CA@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20260412125005.GB21470@unreal>
In-Reply-To: <20260412125005.GB21470@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SYZPR01MB7727:EE_
x-ms-office365-filtering-correlation-id: 63db2665-edb8-43a9-ed3c-08de992ba6da
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|22091999003|24121999003|51005399006|19110799012|461199028|8060799015|8062599012|15080799012|40105399003|3412199025|440099028|102099032|26121999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sIm5wCiNpxcNLGsPCO43mEoERF5W9gV6usit22l1snubzciVyM747LfzEnsZ?=
 =?us-ascii?Q?K7BOal6KFYyiXAf6FipmXwu/KgKiqOGnYh9BTaUcYVT1TNIvhQonIQh/Gifo?=
 =?us-ascii?Q?N6GSVD3qzC/N0pP2sc8GMuq/3EC/Z+v7izQGc5Bh1BL1xfjqJVpTfG/uSWH5?=
 =?us-ascii?Q?+d1DenepXUgHvdWmKfooJ+vtFTrGemXMggO4fZwyXIaABob/zneJEUXNtsUZ?=
 =?us-ascii?Q?XQPARBEENd7asUFArzVtqtvr3yUXSTCrDjqWApDdr3tlLQcR+gEeJrATUhVu?=
 =?us-ascii?Q?E9R6q33PD8DiG4NfnGU3jGPlyOU38lz6846TUmj0bXR/FzjJQ0CMcKqu5SBM?=
 =?us-ascii?Q?hBCg2jS+kx51jT/BDHCvjNyI88twW2h/maEVbiQYILTphvYvpkt9bI6NhK5/?=
 =?us-ascii?Q?/fHeoiTXveR/H2A3wxF1E9tsqEfUSE2I/49338jsbIHUATEVZqNjztEeyhIB?=
 =?us-ascii?Q?lMX51IEO8wbEU2bcvlKCeg0WxknfVY5TON1LzgGsCMsOAsxDVPUkPO+ZFFwS?=
 =?us-ascii?Q?hA5QLpYSFmNpv2JcskRcpMAPDRkOXvXBy83jfzkV114G6TFSmYL4HWhK3Xor?=
 =?us-ascii?Q?x9WHR7drO5YRw43O8qow/gxcus6T/sugi/bJxB1D9x7/z3OyCaTbTRgWNcR6?=
 =?us-ascii?Q?7stI3tQyefXdYvDKcyx6uN6f1v5ZwUNVbbjuUV98BggrZWwfFl8OgBxJ6Sjg?=
 =?us-ascii?Q?whvH7KSQCzslHVajcARod+PSDwyJCtEqHgrh81b5U2tfUJflBJqTrM3RrTRR?=
 =?us-ascii?Q?FglYq5Uf3IPYoG/1ktygPWK25h/VfjsqHt4m8rQa1Z3UlMa50rj0IOP41jrN?=
 =?us-ascii?Q?1XQuYzJJG9+v6gu2uHAp8MMakXSBeE6WC91+dPKhR8/i7T/xwn77ia353Z02?=
 =?us-ascii?Q?S1XPy/HC0ZKlk1ayLXg4934jzQ3znePRrK15Rwpo/X19GJPGB6eJUUHmkMXr?=
 =?us-ascii?Q?BQqIyBxsPLZdyF119Zl9VYhPsDi6Cp7+NetMTIkseTs8P7Z3e1BMM67Z8cjT?=
 =?us-ascii?Q?w7+w?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yhzq5scheEr6Msj/g00GPTGZmbl8tBPue/AmXsdrNhLmxF+SKRxvopl8J+2w?=
 =?us-ascii?Q?k0kD1LvcIEm0qew3nGScPsHBToPj+xKlZLocJ165+QAWhXlupMKKITKjZJV5?=
 =?us-ascii?Q?Ls2kb1JODU7psS53vbwrHti4W+wY8+3xInB2vUoVy8B8o7A9Dab4mQkJp21N?=
 =?us-ascii?Q?RCvVbawSIwKzNL7kZwp1FgP6QDMbi4Sc/NC8gJHIHoWQT9ZyJdJi2UPyX2FY?=
 =?us-ascii?Q?8A8JSjmA/7F8a+cjstc7HlKH3uKC6eqDVkAynfoFxRWPkKsiYTGeYO7CmCKI?=
 =?us-ascii?Q?jlowCmtJJkkCtSK0DZarufrVM1PYAnAhfQLubvVyKzqwgEbYjPXwj/yFfuLM?=
 =?us-ascii?Q?kyRi8mnwBKFZ2J5zSgU4loAzqsnREcYz4yMRx0U7Hix6v0ofZV3GLx20dtIM?=
 =?us-ascii?Q?5aWpuHQlbxG+3iwuu0r0DlbKiRCJ2i8xqVIDHiaYXtE/OXqCn9SZwwdF1mDq?=
 =?us-ascii?Q?yGBuoELsWzqsIqTzgQQw/JB7mGBJ8T4uUBcxHE7WVxfIPpLTrZtOP7Ccb8um?=
 =?us-ascii?Q?zY7qYl0QmQYM85MyB2LEOftZ8pstMYgrD/dMKqCzosxvnrYXwInU3gGDPVIw?=
 =?us-ascii?Q?Bj3GeBV5Uf5hLOUauVI1R0qsZjznUph9uKLC/qnthqzok5l6tl0k3JmDl70t?=
 =?us-ascii?Q?LqzEGgmgxXrWPhrBLcxYoePCJaE6gnn2Vbf8sDqpoBKkFp2+LJ5HMdKbejdj?=
 =?us-ascii?Q?gUyEiA/IQprRabMHB/i2dHs5XhGVQvpatK+Kv1u1WdHQt/LsRxuv6WIfD8iP?=
 =?us-ascii?Q?GywVYOmwOi2Q0VRfY2NozCcW/P2UoTGGVo941fAYvlmSDtaoL+r6CLvgfPp5?=
 =?us-ascii?Q?1ihJyNn+Rrub1DXz1O6jDkXd9Gd79XeM2lUBn60mbLe3NoxBK3WiGeodO9Ej?=
 =?us-ascii?Q?ApTA8MuxZ3+4c6y26D8Y4yBLEsfbrN03sVUv7aZLahilq9CizTdhaw68kWAE?=
 =?us-ascii?Q?eub825jDUVp5//HbupeSHWMpLEylTttro2y+CTI+uqSEpoAV/IWL3qMTEAj4?=
 =?us-ascii?Q?XGHg1JvuftTuEyOzRt60GM3TqS5xBG3a8wFCktLsWNwu3RWdTOIVpiZSIjy+?=
 =?us-ascii?Q?W/BkKOIS7juEflT59BbP/SxBx1Y8niEhQnwl2DNR+6YTAm/jQ1+IqMBE1rvb?=
 =?us-ascii?Q?2uo4n6TeoeKIbGa74nIe/D/Z9cH1AmCL/00xNCBAYa6RN19hh19EMzt9lovp?=
 =?us-ascii?Q?MNbg1mOoiZmaQVeQUj6yck+Pp5qRQ/HMeTH/Wku3qV+6jbYPjodcUMMS51rV?=
 =?us-ascii?Q?LhtCNCXCaq8ohXfB1AUzrFcsHOVJlqK62LYR7h/MPSB2K3s0xi9VdIb2kYet?=
 =?us-ascii?Q?S6rZ9MMz/usiZtUN/IA9WBchvVr8NTQv4QG+PdeFPCookVhYDH+5eq2RPUpv?=
 =?us-ascii?Q?/kd3SZFMrzvqk/kIoqso3u5CQYSO7VT7lSV0TUXG5cKKTISriQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B381F0426453EB4E8C7EE6D47E1092CF@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 63db2665-edb8-43a9-ed3c-08de992ba6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 07:09:49.4839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYZPR01MB7727
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19273-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[huawei.com,hisilicon.com,ziepe.ca,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:mid]
X-Rspamd-Queue-Id: 27B213E814D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 03:50:05PM +0300, Leon Romanovsky wrote:
> Is this an actual issue, or just another imagined problem?

This is a defensive hardening assumption rather than an
observed issue.

Thanks,
Junrui Luo

