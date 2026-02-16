Return-Path: <linux-rdma+bounces-16927-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OMULh00k2lx2gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16927-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:13:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF81453F1
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6B3730C7E07
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2E33191B4;
	Mon, 16 Feb 2026 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CNVjTygX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857E318EE0;
	Mon, 16 Feb 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254185; cv=fail; b=keEOKcC4aiVNcIWt0oZI1x/nPj+xwypHg7HdFcxQIEIcteJvR5ZXEPGhJa9ZIDAtjp1IFkE3bjk6qpFXRFYBbN5yI605jAfoAHP0W6VN4r+fHP9N1Hs0pfAnfuKSSspXAps3VQIRxA8zhe3r1fkg8zyWdOFjsSGKYqseGxG5J7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254185; c=relaxed/simple;
	bh=d0nqxTIbeNellvFTlQ4lf4+jfnzhjmldBG2vQS9mSEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HNNzIticH6Vl3VffNVD65rL74y7orL/ngt8t+V4xT5MU8sA6WeSqXHzyE8nwUZ3/kPuU+tBhWIK2xJtyzndqnUYipbypXCzGuxkgppF2eFBUg8LDIyj7zDdytQYZQnCwrRR9sfeJlPvv5B/X2qFJA7s/INMgwdqSR8GLPMZ288A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CNVjTygX; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqqVPjbQa+iPzpbq86JG4oIwnwAhFudfJdWpByRbTdEkuD+0bDfuA+zunV0iPyVGjPuj6D0OV0rsdUfMrXcMdIOVM7ynGr70eC5RyXrlF/greZMlnvQOLg7rlWysWCXFVHFMzGGNA7MxN/S+hKpHA3V/D9CGEuWsHbS4HsC0bzzNh281A18e3RvVAxxieWvJmJDiNG14CRaYfb869Ty6gARpZnRjVN5cqYtNNJLquGy1/tDzip3f8tbVH0jpL9z1V/BIf7WEt25JU7wv/OabkwsVeo/mfd9dMSF1mrUeD2Mf8o4nmvQgSQTw5x6PAvFTQv6hDWwqlnLitbof7IWWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp3hJnSS8uAatvZ1nNyDiLHNCxGxq4rFU8TYT/FDDQE=;
 b=BG0SfzI1QbEs7WNdFMZiqiiAWVB2JgJSxEc9ivLhvnbN05aDhKF0YtBVl3pzTRVpLY9BWRQTHEthmSBh2Z4T8AywUzLp8/Yb9WuUWsa4KE6eLmSa0H2xuBQ+kuJ1aWbmG+/yMbG9r0/kUwcxWuZPJK3JAcnM9rVGUCJzeybCCOZ1e0g7yDXmK5Y14ILF+V2SdRm3UlmsiVByDVd+BwA4dthka888YH1fy++GxnRBzGY9eLyqRQgssWtSM57RrodXzEq0mlXixS+p8FQ7CpLisEQSk9mBNM5a+tfVJ20b8lmtZH6bbqA8nxvNDmXDabkQPP/6u+GKlNzD6/kjWWI7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp3hJnSS8uAatvZ1nNyDiLHNCxGxq4rFU8TYT/FDDQE=;
 b=CNVjTygX2e/zkdjAek47lf5TSUNr5gHI896cZG1GJums8EQyaHJxq0YWPEaLLbLuyRSBgMZemv9qO2U5oZXk4YbpPfFRcKkoLfKqnFEvVe3CzkH2fYlXXG/W2LnhnO4LL4fFe3CeywFxRrhkN89pLmzwHYAtUbalbstu+6Q9m/VdsRDfldN+0B+npK5za66RGItEpTgiK4qhR/g7OoA5JoI+PvB/9rqGfiMvios/1HdLRHkDR/M8aopc2jbHP1s3i8fUlH88fI1Z0l8q0coWNqgoQB6A3QV/7qroLTWYbQdub9T/sptcbxqC23lLKZ0CxvC6UkQeLBPfqrGrBhsLPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:02:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 15:02:54 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Gal Pressman <gal.pressman@linux.dev>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Michael Margolin <mrgolin@amazon.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Gal Pressman <galpress@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	patches@lists.linux.dev,
	Roland Dreier <rolandd@cisco.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	stable@vger.kernel.org,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rc 1/4] RDMA/efa: Fix typo in efa_alloc_mr()
Date: Mon, 16 Feb 2026 11:02:47 -0400
Message-ID: <1-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
In-Reply-To: <0-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0384.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6e746a-d82e-4d35-f2fd-08de6d6c7576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?voS5P2QVaOA/0d6g/Xpomq2eTcuMiKtIsjVLu6fqJesSoBrm+HyMHuqe7sZ/?=
 =?us-ascii?Q?Sdtw4mWyR7s6rMrSsyLRACzbeTl/b49sMYL+2ptE+RdHvSEbVMIwZ/ZYxJjR?=
 =?us-ascii?Q?mXgBB1BncZW024zuouWfGPWzbkX0BLEpa/8/Y6lZjh2BZntAMKrMJ5nRGh+c?=
 =?us-ascii?Q?wV8tB8cRSNt8PzXPRPb6NHPSKAMdaa5z6bu7bGa3dAKcrifCyeR5VP1BBvn7?=
 =?us-ascii?Q?jACbhz17J9pg2VMeV32TCVREG7FksG+pvcJT7XUro7Ze5O5T9ONMqGQIm0Ze?=
 =?us-ascii?Q?mXt/44eH1AWlPlEbNBgBuEgFwkFSRsJECnSlrLHYvzFKvkbWLRfZ/YNGmeER?=
 =?us-ascii?Q?PDXl/3X/bGiLqlbS360tXBSotP52kgaqqU3R/TafceTKYrhJrNoZ/DyTiXDl?=
 =?us-ascii?Q?wh+LGsW82wOvKiDqlhAATz0KoY8OchzN7DJoThHmALxPPWLTr2eSWHP0QPNi?=
 =?us-ascii?Q?W8ru/xrYmcIvZBYJPQRizrSzZy6oywpuZI2il8a1qjYr0/hk+X4K+G3Ro+wQ?=
 =?us-ascii?Q?hOmh3m2jXmBihMy5kMoyWd54HGEdoRKVeo7S13TLJnDSCvfi+BmVNe2lQjbT?=
 =?us-ascii?Q?a1CWT/JDdQ9ijrxvySzR7D4Sw9/h3+1weWXXpB/R9LRz8dfCvy6dG+O3rigu?=
 =?us-ascii?Q?9q7rBtGx6uG6g9KrVD5ONOTjmZb7UKdpF0rFk5sW8pxMTll2mw+e3iQm5DBC?=
 =?us-ascii?Q?Sg+LMooEKIwzEj1xW97+iLuG1dENOIsqPUUjtHnLT/91ebUvV4otkGA3vlps?=
 =?us-ascii?Q?HF7rLg8Mu9+LdKEVIE6uiUdeo9LhbwV7z4sMD0zFr67Q6liXSgbsQjec4X3V?=
 =?us-ascii?Q?vh0u/kPyyxXQwUpZ92NgFOh6Y9K7pxFIwhtaIXbEhM7YOCnqC8rPfl+0ZeLg?=
 =?us-ascii?Q?24pToEom0lvpWnv9bYSvUnL3TS7kHYyeyQqFA5cZA4DoGPJeZtOpXf5igIwc?=
 =?us-ascii?Q?KT0DPNGwcl1BcLmoPB/MQ6PxGLTPfyXf7Yl/XtZI7+Mnq/E6Siox56htPX62?=
 =?us-ascii?Q?ySsc3HMGh3qCxKHNL8xw4FiAu+t3Ucrcnb0D5qD8GVNGV8iqYbRRxwOoGYx2?=
 =?us-ascii?Q?G2o9PAc2qemMze7npWXCWXsTYlOKd+LOOR+e3YV1AuBPaPc3+5fEJv/aRd3H?=
 =?us-ascii?Q?VPpxx5TWDJTnynmspyVbxSvl59ziXUgU9w8Y+KzW36nqn3Svo5YkFiJT+tfV?=
 =?us-ascii?Q?+fibdp9s70FRyuh5LGxCovPnLvp/NX+C/+VuSV8Tny+2nQikBhOckrPP9C4F?=
 =?us-ascii?Q?i2d/tDuwHt9viSpUSYGkrMqzoyzgb9p9kfwY348RZhi3bLg1kNBg06q5oFyU?=
 =?us-ascii?Q?lJuGLR3vYUZTrbsEjpz0iUu5i72vD+D+IJhE8wxrveYVfbWaM7y+1FWbugxf?=
 =?us-ascii?Q?eMwhxlHgu9R5doeTetiUQxNlTBiwYEZoSfKlVOMUtsYnAI1NsoeVsBNiWpvU?=
 =?us-ascii?Q?skXfwkDvPWi+m9qyhpBf3t91C6U4sTvZYl2Kw7Zz6zJ/yQSK1Vfnqejo8Zek?=
 =?us-ascii?Q?K2+2jhdEhcCwxkPjvIxvxEZIk9jvHTotq+S1rtgOIZvO9LS9OM9dkgBX2b/Q?=
 =?us-ascii?Q?Kld6lPibcud7K+6UY/w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khv9PbEMBztBfEhTrFQ7U8JI9z5qefXWe5gULINKE8qw34k8S6J8h9hOZnhR?=
 =?us-ascii?Q?YuHKAz+DyyU5f5g+2OKAkH/I1eccRyTwNr+MmmFSqJNX1TduTyPzByaIGab0?=
 =?us-ascii?Q?HM8KKscUWCzQrwSSiD7KVBKFnBdTVVUOM0yZIlYvvJAYOf3pz5YYiGBHp+H5?=
 =?us-ascii?Q?SOcjPzB7R7Kp4RroThYGs1s7Si+YIj4UfLcTjX5vXE1EVE4OD+KL62cXtn5q?=
 =?us-ascii?Q?bRAtdX7m7CwnO1BKCMyyfwD5tR4jyD5R9l30krmPuz2XvPw5FbbZReRljsxs?=
 =?us-ascii?Q?9uipu6A+jaALkTanM9d4Aff34YaCai7ttnbS/kTLezThjBH0jkMyrs+3RSlZ?=
 =?us-ascii?Q?27Sw/9aE71flXoJepll8GTMr+vb8gGKi2yv8zjy8tL8N4t8n9tqp8A68IyMU?=
 =?us-ascii?Q?cUSEnu0Tqkqom3r4ljnZa/nQ2YmifzIPtjjHLAUMLnRVZJYyPaLJlZrTZ12S?=
 =?us-ascii?Q?sH+uKNq34Bd/8ZcTQX0mkKT/3YVAbxrzJknxQJnTfdmzCpSC4ChRA4fT6BPk?=
 =?us-ascii?Q?iAFY5CawXKwCmaFa66AqzLijX6VUpeGzkGn01ossrRUe68mNW09sB71efbiu?=
 =?us-ascii?Q?UFON5LUTJrID7GwSe9hm/1yJ6AP329FV3Tjidn8qGP+xNbTliSo70pJfntMQ?=
 =?us-ascii?Q?X9woLv21rJRFG1o2iUOme6iPYx1svSA3dJ0NZ6YR6Og/IhFD4doHNA2r7FZV?=
 =?us-ascii?Q?SugWFl09UuX/XPVd+JxlgT9YdehMYDJJ7lkUWAOf8g/9MtduyTP1vxMjhJIr?=
 =?us-ascii?Q?CqVwBYzx/G+TkI5jw03lDBWY9Neim/g0QCQbaPk3Xa41Y4nQb3J4rtWCCHlK?=
 =?us-ascii?Q?tkYv/LlwL+ptRcxO5wmrO7M3ysbI8LuWbBL/Vg+mgKfKhOgYz2pvHm71B+SX?=
 =?us-ascii?Q?qSDPVEp93PXwFFhwbi/MTW27t6fa8/a/bCbQAQsqIqnNHGxhOntWqjHelxCW?=
 =?us-ascii?Q?8bp9yR4lUbFnKa8WkLzEI42hK+aiizx0/ENit48SwQH1PXY3IoCImNiVQzvr?=
 =?us-ascii?Q?27ll7CWJXFkKov2jaRX4LnJPNwQmMfxN8RrvaqQmFRrPoDOei6Bc/X96P9mm?=
 =?us-ascii?Q?WUXBDfCVrqCbKdf84LsDIulIZxL/jMz/9Q/tyHRZeDE1VoxzT73IglXWMmor?=
 =?us-ascii?Q?bsghd0ldx42fDRz34f5ydHddwtWtXbz2yCHI1326/hH+2URG44lyMhtSsQ20?=
 =?us-ascii?Q?apY2d9xncLBdC+1wlqpd15+gM0y7HGO9VOQvA5iYIQi1MKqoeP+BwqXUt+7n?=
 =?us-ascii?Q?Rk23coSeA4QULp1ywMOya8hb1dVnNjiyPe+c+ow3gt2wQFxKIoQwKFxzcq7S?=
 =?us-ascii?Q?b8W7hVjpfXrwG5t935s24gUgdY4KgbBPeRJEGZ54UQE3UGylhVQ+ol3G9USl?=
 =?us-ascii?Q?/pDt17/xlqjnejzgznTzZ8EggofaOszYn1gxNz/FvB05jacuPhoPYLAyOXwQ?=
 =?us-ascii?Q?rXOTIdLi8N1qzdQ7Fy47gPHkK+ilYm7KSZTXWFLLbI8/pM4RujZ8r+mwru2U?=
 =?us-ascii?Q?V6OWftKfYCEEFCYOVrC39FFeATMSRe+XZRmLhl2lyATpPu3lXnpYjvVhQIGA?=
 =?us-ascii?Q?2YWD+oQY6iq0+yh1F/DO7OeF1KNlA3fOs6hTVVv/wZQ19IzW/1fxn5S4QLxZ?=
 =?us-ascii?Q?I8nFjHNPR7JuePlqnKFFIdrUgc4CIXDGe2kRPMghoV2lRzQRVIvGh3q9WcNT?=
 =?us-ascii?Q?kS23dx2I9yweV7RpoF2TzW1nuQ210Mt4u0WvNze8l1nqdickZkhcGdubodki?=
 =?us-ascii?Q?hzFGRtXUIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6e746a-d82e-4d35-f2fd-08de6d6c7576
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:02:53.0297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdA/+Ioj97ktQMtE1Ixwgux8XGmNXuTSeHZ6UzgbIF6a32Smil35ZMRQnL60wnkG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16927-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 40AF81453F1
X-Rspamd-Action: no action

The pattern is to check the entire driver request space, not just
sizeof something unrelated.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 22d3e25c3b9d11..c066cd84aa6407 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1667,7 +1667,7 @@ static struct efa_mr *efa_alloc_mr(struct ib_pd *ibpd, int access_flags,
 	struct efa_mr *mr;
 
 	if (udata && udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, sizeof(udata->inlen))) {
+	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
 		ibdev_dbg(&dev->ibdev,
 			  "Incompatible ABI params, udata not cleared\n");
 		return ERR_PTR(-EINVAL);
-- 
2.43.0


