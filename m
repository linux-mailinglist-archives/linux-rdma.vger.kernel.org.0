Return-Path: <linux-rdma+bounces-2036-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B513F8AFCAA
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 01:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EEEB23551
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 23:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A57A3E47F;
	Tue, 23 Apr 2024 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MRUn+qZu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2120.outbound.protection.outlook.com [40.107.93.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC052D047;
	Tue, 23 Apr 2024 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915304; cv=fail; b=RE0RLh+mzQH0Egqe3Ob6ZOJut7UDsJ41YTJPecfW6d5fSzBgNNfV9Dyl4ZnzpBa77/NtXn6FvqOdNCNO+Vf+I45y9P99q0mmFZq7iVrCd8qNozCsMuxUM8lHp6io88pAKk6XB6INOpSlu8QORdbbP4IP+96VdpWNTKFhV7V1PYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915304; c=relaxed/simple;
	bh=u3Me9rcyPgTI+CYFTtmKfqzBBTWRmATlU+BnHEXp01U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=efAxxJeEPkD8Pv6R4C+90Isen+z3998lWXY7Dvc8Vk3At3B92zcdBcuYWxgYiQtK6DLgNmenkDnpskTlvivH/JfVYgc7V5QLs4335GvwQ7ICgzT1JeMcDnS0EUnmgjSFYWs6+gXDe9gRjdWKpENRWxwSi4uEx7Mk45IdGHuPebg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MRUn+qZu; arc=fail smtp.client-ip=40.107.93.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msVCUufCvHLB3b3hLIeuVUscUelzwzmBCy4M/fFuBzPijNmyx/eZ7XAIpIOLs4gZSH0fMLLYThkvDwaW1gOnEvjjURYSCEqb2wqdMA5eVKW5J4LY2lTSsrh4GIBhrCVDY5hm1/9c6lad8o4PnBgUUJ1h9Uh3kW72SUeGGxGEiJPrfLEELLqf/SjtzIl6+rrolUwpLdtUt7dSw2JS3pUU7GFQ4qkDXfVP4YBq9PO8x4u+HTtn2Wl2SwS810sGtv9VJau1SfRmnPC0zzBIbVsUu8pjo55PC6YJYqy5KSxJXicuu3q1QzeGo0N6NxkUwp3HFkj5aKySzRdA5KQKPvT9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3Me9rcyPgTI+CYFTtmKfqzBBTWRmATlU+BnHEXp01U=;
 b=bLin7hCvhVoCQBl15MtESWOIUYpwHc721ZbLax0UTbdFibX3aWT/eyUmHLZqncy2gvkoc3i5lOvFfbMJLerktGtojRAFWWuuqbM4j+oTyaiCS7Vj7nLA1Detbd6oVgBxrU0Ux4FHK85n5x7m1Topq/iCpd5nRIazVdVnlSKRNhC7l+xAhN0PIxlgDvRkHf1gEtWxVz2U5EWAzIqynXJHVOA4G65uTXT6c8XtCfggZDWq+7fT49vT6pmAkQA/RRZgRINBZWMCeHcrK97ilUpGEFjaUJmzhjks4nMPuhrDykGcQyKL3sqYTgT4Siur6/BuMu/aj+RmlKMTZ0c22l/GDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3Me9rcyPgTI+CYFTtmKfqzBBTWRmATlU+BnHEXp01U=;
 b=MRUn+qZuODUk+wGRi4YvFG2N2KI2jb8srECkib9qh1ErCXtaLdjdZxw78gStochGy+F79EhiUnq5gsBiCkY3fNSFjnWitpjOWUHRY8vEirGSvH2AZAFdLcuvBGW3nJtUtfYetAN9lciaBEgfU1EpKJsp/+ix9uNzcz5mL1pXmf4=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by PH7PR21MB4058.namprd21.prod.outlook.com (2603:10b6:510:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.8; Tue, 23 Apr
 2024 23:34:58 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.006; Tue, 23 Apr 2024
 23:34:58 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 3/6] RDMA/mana_ib: replace duplicate cqe with
 buf_size
Thread-Topic: [PATCH rdma-next 3/6] RDMA/mana_ib: replace duplicate cqe with
 buf_size
Thread-Index: AQHakbDH+/djAuODE0K1bSKvuMHIubF2ibqg
Date: Tue, 23 Apr 2024 23:34:58 +0000
Message-ID:
 <SJ1PR21MB3457AB602DEA2B369E219121CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-4-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1713459125-14914-4-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8c56225b-5065-4ac3-a480-0af7c1935eb5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:32:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|PH7PR21MB4058:EE_
x-ms-office365-filtering-correlation-id: 6d147d53-cb4f-467d-0360-08dc63edfd0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cHR3PGGIvImvfxsrh3YsCHk0pvZF+hTW0iqj8sRJkPHQXym8spvOhIQr1NEz?=
 =?us-ascii?Q?L3rTfVhPjp6Wac2ryhQUkLun3IZpKyUdhHg7AcqAJi65eR0jU52kpPesfEbf?=
 =?us-ascii?Q?R1fPU+kCdS0SLaaO4VSpvsiMTMIGaMJZGe7J0y0yMO6VntyKp+fVE8abht9i?=
 =?us-ascii?Q?oZoOkUMlpdtMpFsXVy2vIc/41Thp9V3njcPL3ODCg1mQsG8ygze6OTIJ2KQu?=
 =?us-ascii?Q?JphNmQn3870FxFp9v8wjn7ENnuHP0hyp9j5O9bLZIrRBzgbpB4L79ty9V6sl?=
 =?us-ascii?Q?l8Tu+XD2jQdWUcrzFcG1vaLFdvsnZ57u3PVcH4T/pBrwrlOYatRKHnjbnBnr?=
 =?us-ascii?Q?42eebw0m+4XyQq6jgPkbxjQcq/tKnMx2/ngnqUGz3jpnrVAXOHq49NL1M9wl?=
 =?us-ascii?Q?+g4vbHj1XmPovNd6grqnXKlpAjqyqneCgO3mPCUsEsRvMbHOhmPIoq1GdfTt?=
 =?us-ascii?Q?N3lF9Jj1oAoAZbZCwxVr1gE9F6jFyfZ04tUWY+eNogz1wGHEwH/vpPw4esIj?=
 =?us-ascii?Q?OKPeT7Hidj9Ua3ZWlucwuGslAQ1g+9/L3u888F1O0Ebh29XdNJmC4MWfdrxh?=
 =?us-ascii?Q?Dz21dYEcs82gN6nERhg0TfMxQ5cNPNsneZ8lfi8ppfpV9SFVEsfRv5N56D8j?=
 =?us-ascii?Q?cTjGCHXICYS3zP8f4AbAqNyvq8ExXrERYP8BU09IdFwH8LFz2ewTen9HRtGZ?=
 =?us-ascii?Q?MvhBRvzYFt5kQb4zKEsdbknMbgT9Yc75DmqAnhgYQTlGl57+ntwVmocAKOvZ?=
 =?us-ascii?Q?60yVXFVoL3d6ZlMhGf2Avs5vfPM3IQTa1JeYrY470bz9Mf0x89fu8qFYQxnS?=
 =?us-ascii?Q?W9K4rRuc3kiU5GARx4tgDKdbgOav5coSn/S8UTO8eF3HO8gZIaNGdoAY7KRZ?=
 =?us-ascii?Q?F4Nb0sp6IJGEzun9iU6eWtqBpUMAnghrHLIgiYDYcxpOBJyqN53syWI734oy?=
 =?us-ascii?Q?+wv2d64TTt79iIbftHMSEXdyeLiTD76+/8jgleRjq3MI3jtTOVcVhE1utKQj?=
 =?us-ascii?Q?ylr8Iicbp5A0CK4HUcXgcbCZhzSVajoFtUv7aoaTaENM5Xvj368yriHr7RDZ?=
 =?us-ascii?Q?binIOGblHAJR1pa6N4PE/dY9NPKo4VgkabD2wYeG1G8fGrWZe0Nj9QQnQkSj?=
 =?us-ascii?Q?Haf0iMh6sQ4+ekLxued8Br0Qljtlqojo/lLlWpCVTplnIVSJ4e9NoWotCa6g?=
 =?us-ascii?Q?KEb/QyY81lDIK5RP0QNe8suoLntWlBwQO2ggq88DJfhHhnMZ2ih8SYvrBp73?=
 =?us-ascii?Q?/W6tZd/baDpn8sUWOlrxfaJDphc6bwD8Tce8JDb8Oukn64XYHhIr1ZpPH/oH?=
 =?us-ascii?Q?L8Kn0Ex+qLNIKHqElT3qPQ6Pgq7h0T+6BRyfBp3Kw+/6VA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6HZYwUuSKDNtC0gH1qeeHfl0fkEO/FVZdg8OdCZBiH4/QaIU46uVzHtLlXF6?=
 =?us-ascii?Q?h3jVKnmjCp9xw9+9HxCq9ZuSQahA5WSRy54X0FJluoEBQ1kz6VSLpjLe+zjU?=
 =?us-ascii?Q?NRT9WqvAQoDHGc6lQeBYZ7aJApbJ7LdxzJJO7Eu4MRKlgYajavqgbNAmgifg?=
 =?us-ascii?Q?QTWUZHpdjuVNdh/hhWd6U4KBWLcb+WaHD6Ke00fguFyxPQuLA0n7lTas1VQx?=
 =?us-ascii?Q?uqVvkrvVzE8LmScTT79IEJEswtRG8S5ZhkN8qBKN7oknA2vNrnApCgzxozkf?=
 =?us-ascii?Q?cY752IqFFXmvIQZTaSnYsAUtKRMavca8OTpR3l7VZm374zVvKjNGi1zLhWAP?=
 =?us-ascii?Q?gD8YgfVMklxmMm680dtO5qjbtg9+D2pCmAyiCBDVvaeRDDuAzHNirldWx/YR?=
 =?us-ascii?Q?K4Vi+JYir/29II0jnZuL7tCYEjJXsWHuXSNjKh5O8kIk3PGQC+kXzNoppIGz?=
 =?us-ascii?Q?KjJO1mSIPu7uyjkhM5Wfg6BYcyMz1YjXV4yI32YRPt2kh3nE3CC+BGgQB1oD?=
 =?us-ascii?Q?MK54fvvALB2c7Gmsz8l6xRx5duAGPQb7YzsHphBBQoaTayr6kTnrfFmcbvq3?=
 =?us-ascii?Q?csaIwy0w94tKOYPyJmrrSV+JamTXiMHxMI+/QiW1FyEYFGP39CP8UI0V2ygk?=
 =?us-ascii?Q?hoWf/ZiKjFpmwd2izmEVS+/vgwGZkJi9XNNSaInT3KziMtBn+z3VIcvAb7aT?=
 =?us-ascii?Q?EktbHJ/LGx56LKhGZ/C4Q5QK0qNPABlXjkvsd/3tkqYkzpnaRnXmi6E3L9Zn?=
 =?us-ascii?Q?MC2RRxOB8u7QjP8nCdpzJldEsskv67Bw80dU6Yq/zGBdpU6B+9TCCn5l1yPz?=
 =?us-ascii?Q?hGGtmGqblBWEaCaKpgMgL9XEMvpp5KHD3MguxJuyR+icv7DvyYwwSYvkZPZ8?=
 =?us-ascii?Q?DPbLMJkwBPlGDH5+sK8wUZVtpyXP+8ZBBXh0gAgg2BWIR/SjXIy70DW47Kpw?=
 =?us-ascii?Q?vmFoo3lBYmtEXxrhP7L6n5DL2nzymS5n6YMpBcOTGaKI2mdV7R+NjbvNw2cv?=
 =?us-ascii?Q?B13lswRrAXPH0noqXPiLB3ldnSRlHy6ygPalTENDxIyufNtoYve/w1NcYSfK?=
 =?us-ascii?Q?gaLeKUrePgJXy70wxi9yqqskITAsyt+2XJxhSqvnZsKcqAHjmtDs3T8mMHps?=
 =?us-ascii?Q?iDqe/4FxeafkjbFdK3/8cN5boN5uDQJ7N0o1GgCBwil8KbclAXR3ib06Agv9?=
 =?us-ascii?Q?c6W2aEchfPRwBSkswte2UdeI/zn66A55GfxFF3IoxCvF1ndiHabKoQhPztvA?=
 =?us-ascii?Q?GGPbmI6ydrDtHNuCWtYX+y4Ju2xDKTIbgX6zpqGncROgTbMdXSZV3l0Cvfmi?=
 =?us-ascii?Q?Coqb/yP3ICaqqoFhD3RmzwukGKurvx/cpP93Ay/gMJw1bCigvGZcvdMYsASb?=
 =?us-ascii?Q?4AS0kpRXj7lmhrsRhYHeUZlKoTg0+yvlXyJDzOXLvTikeWFfajftglveSCYO?=
 =?us-ascii?Q?iUjmHoe8Ag5RN2u4aoyDza7gZS9V80tJ6LwjVa3hy0PhAbA1jQQkxn6j3ZNB?=
 =?us-ascii?Q?GsZ2Z8iIJbA2Cw+9BAObgH+SRB7Sn9G0ZcCPjndtQcHPc/VU9byFIZfAH/g4?=
 =?us-ascii?Q?KuK0o4zez8KJBucj5DVID1Wv9zZNmz9rWOesnJ1kAPfcr7tMpRhFSCibVE3u?=
 =?us-ascii?Q?EgDgXVPZhscVZ1CCeKxfp/eaQNVHti4eGCMQf7MwWX6/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d147d53-cb4f-467d-0360-08dc63edfd0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 23:34:58.3272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MH1lRq4Jy25DzjLPIK51Nn1Iph2ihbrz1LMfII1LuFhJswCns4xUPVKSajTs6IwCCj2A0VscixEvtXgAQmFIpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB4058

> Subject: [PATCH rdma-next 3/6] RDMA/mana_ib: replace duplicate cqe with
> buf_size

I don't understand this commit message on "duplicate" cqe. I couldn't find =
a duplicate of it in the existing code.

