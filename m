Return-Path: <linux-rdma+bounces-2035-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1698AFC9A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 01:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AD1282860
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 23:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA23D0D5;
	Tue, 23 Apr 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AhTZ3Quv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11023015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87518B04;
	Tue, 23 Apr 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915031; cv=fail; b=mkMk3cu34isozUzD6CKkX63KHyDryrrdB9ID1brtI8ydQoxaKpZBFY2695xs3UJwtmsSVUF9Gdi2+nWn119xW6+DQ47z5L7ia2GDrg+prVMKJ8QKthCuotyPdZDP58pMZQvgfDl2xL1kXv39uRdzT2QMP0Uj81k8apDopmUBPYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915031; c=relaxed/simple;
	bh=HAeW85+E4v+ArA6kPdgDypWxwHD7DYABxNw3V9S8J94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jVnuMKsAQC2MWsyNMtKCrHcwORnZ1tmFUfR4AwmiMm4KT6foId5wCs9MjYQDOQgdS7c/MiZTLmpum8rybjoDa4QCuog/UTiMwR7crm5DQnDwt9KvnyVsvPMig54LZZoNkHmmsy5qp7OVeMYgag5yMmBsGPLCrMH00LxId1nFVmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=AhTZ3Quv; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz0FFPmVa3mG+0BvDKzIzw4BFqcVcZS33NFykn6ow6NOLnX1Qe0+cBicIRUW7Xri7DDLmyc2SnLoDOMOh8YwOhQzBa1xp+FdZ0H301pdmU3msJA6QA+/v59mMbQ87ezTbAmViIrN9RBa77FikaAgqJjWDtp8VcQ1BvpWZQ17E273igK0b7A9iP992tkT/yadrH2wrBroQXdEcfEQCbBP7MEwjhLgxrRZJhqZkNYYtyzmQvdHz38qMfiZaXcgABhBs9NRsaGVYWFBnag2jUWh8ojmhthRzHy7OG0OlAUsb4G6P1kIXmk8HtP8s26Odl0H2rRJQD6wWrnm9N34IbVPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAeW85+E4v+ArA6kPdgDypWxwHD7DYABxNw3V9S8J94=;
 b=QGn8RTYi+18nJJ50LJJtVwS2HDq+H7ceTt160PxMeBYV4LPBLSS+VnBppaz58hwDl0sFcU1FwDyPuSFu4CSB3E6eiRDiIcSOIlyoqulV7/PBwZqnZaVpwSwGLZdGF5RjkMOQ0ByzoXZo+rsX3S/wubHxTy/NJ8ZBvY4JU4uQtYbd4krGWyBK3nOV9KCsMyqGiXwTeOcBohnrbZ41mHC6PrWnvjzJ1AjYhLXG4dJWp3IWiv6HFe5jaUgII2xj5+wC7xihocRRHrnGoG08nKrFNi74W8EBqGYk8Bsf9rUQTCpTEHAKR1OkmzarhMWyPBlYLM3xQNKPLuvJsu22UGKPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAeW85+E4v+ArA6kPdgDypWxwHD7DYABxNw3V9S8J94=;
 b=AhTZ3QuvYeW3/+/1dm9bEX4g6OvVaBfirz7fGycCR9oX0YAWZhsNKLahHk3JqAO9V4SZndDCDuGS7dGxqyEd6EKGdWdGXmwZ0SUYP1j7tLt8oype0ztuZp9YFi3lHpeEDqC6+1Og7jZh2J11lAaHSXd6D9cML5Q/WTKBr7yWC64=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by MN0PR21MB3508.namprd21.prod.outlook.com (2603:10b6:208:3ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.16; Tue, 23 Apr
 2024 23:30:26 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.006; Tue, 23 Apr 2024
 23:30:26 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 2/6] RDMA/mana_ib: create and destroy RNIC cqs
Thread-Topic: [PATCH rdma-next 2/6] RDMA/mana_ib: create and destroy RNIC cqs
Thread-Index: AQHakbDEHu0H5OcaWUic8knKaYmP2bF2iPnA
Date: Tue, 23 Apr 2024 23:30:26 +0000
Message-ID:
 <SJ1PR21MB3457197F43F8A02FB0925C33CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-3-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1713459125-14914-3-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2af49b6e-0bad-4739-9fb7-2a513a428331;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:30:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|MN0PR21MB3508:EE_
x-ms-office365-filtering-correlation-id: c40245f4-a97b-46c9-f0fb-08dc63ed5af1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Njh4Gkx/NbLH2LWhH91vxXqIxQ+Jke3f7a4pTnY2sFBgvSJdy/drwOkzaqt7?=
 =?us-ascii?Q?nrK96O8+B/VkdJTMMPSKZGcaZWnfbQokL+6on/Fp3ciS9+g4/j8HWHEGKmRA?=
 =?us-ascii?Q?ehzvM61rWaPLpBMujkYBYqRPnsQS69baf49AyAxvoWAcQLxONNvbf0j7RMtH?=
 =?us-ascii?Q?hj8BfXTnUkcp2TZgv7kG9S/dW+dN6HBovXOSyFa9ILKZYDGAXPJ0aZ7wJydN?=
 =?us-ascii?Q?yOgsJcJjbVe6e2+rKCk/uykTC8Cn1CZtbjSAnkDsrwDkRbxG7+0PcSALU5Fs?=
 =?us-ascii?Q?NHyX5pWoXM4FfQaKKdkAezyi0KZ4F0FzH7O/TrpPfNepRDSUJOcw1MrepZjm?=
 =?us-ascii?Q?nZtdkVpYZdgQfC3xid8ukhZ5dnSuBRqwRZZtKuQU5WfdcSQ0rJzn2txVEOZj?=
 =?us-ascii?Q?CenAGqb+7o8fMiMwUO9zCjsJ+IPunjEqdA8xyl3YemY9YT+VxD1wNBIrbPrR?=
 =?us-ascii?Q?MkNWBIZ4EdlTHvOncikunPXCkTsw+As4UC6CW0sNxSxsS/Y9DbflO4McXDAu?=
 =?us-ascii?Q?qJ+cfC+Wge2ky+PqAwkRXeu0KPa7fXQKIKevWnTTQHc/VBCfY7eSGeiEhBvz?=
 =?us-ascii?Q?I8GWMOOMwNDKz2wJKylyR4tcBWV2jyqx72Ep59sU4kmpm+reQZGGxctKbVgL?=
 =?us-ascii?Q?tnw+9XbTb6QXi2trLWXCMmtUIGz6TD3bzXFsjO7qD6Op/59fPAiEetsvZm3y?=
 =?us-ascii?Q?0/JNTxsodbcVGwR6eLmiquh3tiO/7ZFqe7fjWyq+pbmEdm/CukXF0VnMbUKv?=
 =?us-ascii?Q?8OZdM4Xm9GrCC/t1/la/ybMF+HxABaPjntt7FkMWaZfvMPYqEzS7kWmhvM4L?=
 =?us-ascii?Q?fo/ycTM4gwhEaNgc1JrBc8umQXQlHNfuU0VltpEhxml2Z+8GBQvVmAOmpGWz?=
 =?us-ascii?Q?r7SRNQgZAuiSFcFpVqp5brZjA+dbYj+bnEwb1eQBb13SwBeo7J/KlB11Y0OM?=
 =?us-ascii?Q?NNqDaTg2RWm+wpq5xFwkg7CaLJQ868xSEdNE4FSluZukzEIyg03+tvmDw+xv?=
 =?us-ascii?Q?PBQvVScROLyMPDxgjnByO98fyOXfyXJl4TbN1C1siC86P1McnrBf7dXfSMLW?=
 =?us-ascii?Q?j5CIfEMmq/vtBXRXzPAKwdes5TuVwYFXcN2XxqeI81nYqUMBS2I1F6xVl0w8?=
 =?us-ascii?Q?qSY2dfErnHt7K8Hd9U6X4uuXZnJI1Jq2qSxFVKcbLFVt6Kkt461XY8H5GjdE?=
 =?us-ascii?Q?dOo7bpn5kX7iHR/IKsoJt/7Cz0OxbwBVxDU1wj44o/qr/Phr77z22xIDn7dN?=
 =?us-ascii?Q?srmT3PQ9Rkv5yyS9snN/Cq+D4NR1qbqUF+Y6iYzLqh+Z6gUOEDHimYcGISEV?=
 =?us-ascii?Q?grWkBynNJEEEYmmVbZhhaOdCT0uOaNQzQR1ytng7dhve9Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tBxf0ZBtyi94XUXA3HSSKwWf6jueXimOLpmx7B0hl6UnQJwczgVW6WGOJu6E?=
 =?us-ascii?Q?cPuC8YpEQEmB1Em/ia+2R6KyBSrrZoEwrQgiXIfzEtDyh7SodFRO5l6J5XvP?=
 =?us-ascii?Q?ROvedhNxgNOMDi4RdJRPg4/o6AMYf9gZqpV6OkwoaPQtJRHh4z+8kLzqBaHM?=
 =?us-ascii?Q?iA3dgTuO7hHkwcb/HDN6HEhW3EBYc/zRZ8ZIkgQJRkqk2qjrOfVxlw0gVxj1?=
 =?us-ascii?Q?3Cx0wV0MNT01YKFmG/qx8XypCMfbxt9+CWXtHjBZBq0dGUPoTYFGq32LvYd4?=
 =?us-ascii?Q?kW5AKubkYzco5AblmkXE7aZZ7jJ53mxtUWO+SxOvKNUl8YlDErLfSJRw3Ihd?=
 =?us-ascii?Q?YSvAZEv7PKMzrmPR/OqRbmIks3b6yREVzkqdxtqfGMecfw8CvGtoKvCmgi/B?=
 =?us-ascii?Q?ADWr0Y4abl9eGx5caIZiVyBnhdAsCOI0KjJkYS9b73/IfG1j9dQ5GqCoSXun?=
 =?us-ascii?Q?HH2B3ujG5/fqdqy4vSQJqt0NdVso7/X/fb64+8Aa3X+h6j8S9Jqdm9A/Suq5?=
 =?us-ascii?Q?RPizD3ip2bDp1qjxYZQa9JqicIZagl8GkSvKEM8w0lxPs27/iuOQMMe+v/24?=
 =?us-ascii?Q?CCPhtSB1+4PgombLscj503KM1aFh5cD3R57bU5K//yi95014qYP+OsUb1hwh?=
 =?us-ascii?Q?f+hnKi45Q7MKB8PsPDZO9Ockdl29gnnQ7sJ4tDq08/zw7wfaYxiYhUVCcfTO?=
 =?us-ascii?Q?odjbQsgKt12AiAwqBXR+uGdW+OvTNibtjZ7TAXZ5ClhB8s+47tqkCXpwO1Wk?=
 =?us-ascii?Q?VD4Ewt0TEm0iikACmkgLwFBuZICv14S7MeTP289PwUPDufEkrzoCXapO8ynZ?=
 =?us-ascii?Q?qi4r6FIjR92e91Py2j20eYS/jyuUy7F9QQZJibF4M9HDwBJGr8Vz0SppGcO/?=
 =?us-ascii?Q?9jwK/qVGdnsuWTgNKeaFuuxQaYi7ihOEy/OgraIiUDJcWwuVO+egSwYXSIRs?=
 =?us-ascii?Q?I+3plKyJHkuKKP00A0AfQ9ZXaXbaemVoMzgxvZ8GCa8W6m9zOw0vh7ht8hgF?=
 =?us-ascii?Q?gTIVI7utaSVnnSZ2smFLSaRbqZ49fUYj2I6PUDjUwbZgA4cBekrpdjxOM2Tj?=
 =?us-ascii?Q?8PIDJ/sBAmOtCeZOSuNGgDELpKFv/cmq5m7Axhgsv9+JOuoMAgtYHDEvKIuZ?=
 =?us-ascii?Q?L7yvcpipnv9s3U/3VpcntCA59VLh4KmFU3aMQTTd5t3zCx6rb8GE2X8T2DEL?=
 =?us-ascii?Q?19CY07w5DEoxVgFBteFl5sBNTuPNRRSTusKcaA22B0C0mJMW3VredDiG7r8d?=
 =?us-ascii?Q?iWyWIo9rRToFiF5AIn6asyuzPbkH51O1e1tFYlMmVD02w3RbOk1qMzPZnC1f?=
 =?us-ascii?Q?buGAkDvjcBb9faFkMEL9u0KwZG/mp/bVMTIuhOglousM064tSvXoOrxy3ZMG?=
 =?us-ascii?Q?Pufg7vDDEcGTlAFsXWvIkCJrC8ac6uvqr5FZ4D2x7E39dNqzv2DaeI+HldCd?=
 =?us-ascii?Q?eIWxAoJEsAnhWxuxDx64/bthg+biP+bGwF/DdKMKvPsO2coimHEhCjN71+VV?=
 =?us-ascii?Q?HSyNMsVHJtn+6pNNS2rPifXtk03XOPtkbWHKLQ+Ac7ODtyG5y9tgON+hpQNA?=
 =?us-ascii?Q?iZF0TLpTF4j+4NWl53fKjcu36gfLWNk+SBFvOcr781WVIxuHv+YX9VKp1T9d?=
 =?us-ascii?Q?7CoadMtFrwhouD8097c6ei4WJP4mXESSEg4ZDc0BLe5v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40245f4-a97b-46c9-f0fb-08dc63ed5af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 23:30:26.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zgc7TM7BAVZe28ybTT5spAtTPs2hkUaCMRRxe716JYy2zl/WNhRwENASSq1WebtzWMJhERvDHzkPD20g3gIzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3508

> Subject: [PATCH rdma-next 2/6] RDMA/mana_ib: create and destroy RNIC cqs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement RNIC requests for creation and destruction of RNIC CQs.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


