Return-Path: <linux-rdma+bounces-16923-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iATsIgQ0k2lx2gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16923-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:13:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A361453D2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EABF5309295E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4E6318BBF;
	Mon, 16 Feb 2026 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cBxrc4ba"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB89218AC4;
	Mon, 16 Feb 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254179; cv=fail; b=isoqKpM9PEKDA4b7hurXgrVl7qFnZkEZ3Y4QT2x9xAntTC9rYdkVCnUEiY7U77YhxkKnblLtlMiE7nY6GS6K6K0J7FbwoRazXpmIPDG+maqlNSE9RnTLJfn3Krl9t72CF97Pw/vR+Phh3Od0GvMnjeSaHrIMQhOcCtpv8zK+lhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254179; c=relaxed/simple;
	bh=w4U27lti8X6klYSQMIYUQ7EwkAmYYIjomPTH90VuC6w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rQpBzlF1y0S9IprNW0obH6nmjKGQN1fUft7OaGfwb7dn6XOy61jveWZ4e70E40Xiv8SbEgWHzn5fijmbQHAwWgHZ/GpDbpQ/D2YyQUtLRfGIMx5eVRbkNEhnPYkqD3tU/hqgBac/BAIFN4859GawkIVvIwUIfJEyb4WKlMVvyE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cBxrc4ba; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfxBAYdontUbftLFNsw+yYYjzGxkJbq2BLX18nqmOf3LpbutDaDYYNpo9XyImw29uCQKTkW0oY9tHsKryWGwRguNTB1nOVPJiAmxcRYhpMBFcFY3dBxiHFQC/9TGJsqJWDj/Mh/OgtkIKK0G4ttsYVbdVfszdXbRMdq1EmW9o2+xGCduQs/+PhB0HdwcW36rE6qaV00xuPS2qJhnN8760ERV+FzF4A2Igxjrp1Ox2nP40D5rmuyTdtnuBxemQWAavBzQBvTAu9YkDZ9JcEaFLFc8HOmdJx0bc8w3bGtoYFKkQpgtYVV9TbmjUQxOU/zXvCFcA/h28NfZkGAq68ylew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5bcZPZf9ZvDEMJ2ZHvdibWVHbdDXinanKSinwIO/Dg=;
 b=hAFDwZLnyS06tRrsS3Kx+SB1piZxqdU3fRnNqoC0QTirYp5Hi9sb4JG2FZJieMBdnC+z2UACU5sQOeH0YlvgK/gWW3ELWAdaApk3zTstvdI2LeNz+o4lOgPCKWCrKUhq71N/owcuLXp3tw39yBxfEYdsHweDWvITkaFIymr5moWnmZYQtKfifp1ANvMOLmHFpGGXW5ALbxvm+EhbudD6AFrksvlTx37xgZJceDd3cYADd1zvhcz5/Fy2smoerVLdBz5dI7jZ5puWnd3DroZq96tO2aSoN0GS8LhVpZ3BU/TN03ZGjplCSC9T+6Z0Lenfk0/2FkbuRd6kwPv3RmhAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5bcZPZf9ZvDEMJ2ZHvdibWVHbdDXinanKSinwIO/Dg=;
 b=cBxrc4banFM7fz23TevNf04BWsfFgBeMYNEkM+NKsESiqaIRGEKawsRICh34kBsefHNufn+3k/3Sh+P0g1GsK9khgaEaj59hY3t1vvCKRyjeabEsY/QUARTWuDyoXPMbryPZUyDT0uAjTylMKEkA94yziJowlueOM5JL2LfyblXiWJ+1paW+Bxcjx4eybeQe90C7EIG8Maa+yyWhAnJT79EW5qwM6ubglIN1SJ52AZd52GDDp4IbkM8/vX5j3Oq5xwvDyKcILa5APOTvASU7ejnFlfY3WCY6OlxnnFTSz2u4WqHKkd3gfNdXJI4e7RF3EwGAqrgzAL4L7vIstmnpww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:02:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 15:02:52 +0000
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
Subject: [PATCH rc 0/4] Fix several serious mistakes on the udata path in drivers
Date: Mon, 16 Feb 2026 11:02:46 -0400
Message-ID: <0-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0102.namprd02.prod.outlook.com
 (2603:10b6:208:51::43) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d043b2a-b9a8-4dee-84fd-08de6d6c74c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pj05m/RqZ744Mc3wsFsltxvWO4QU8zTQt6Cjk0wkDm7eljwlQKP2TCldx5pB?=
 =?us-ascii?Q?NuRJhCSf1jSjnqDNZQ+EQFCr0zGk4R+zc+IZn+v1FiAVPeJKhEOYl8cL03Xa?=
 =?us-ascii?Q?5/u/PLz4Scw4lELJIdVspuxtH6kYJaqM3GsjlitjK9qkMmJXUcOT9g2U+Jk8?=
 =?us-ascii?Q?LjbcIUTwqplmJkx+lNsd1+TvYq6bXuTPODbctKY/wStXXxUMjjwm0uj2h6+e?=
 =?us-ascii?Q?rixFSwgLHSY5aYuUCDCHTYUeNptORLPICNDJWlhG8M9XqkD66tEk255cPEeM?=
 =?us-ascii?Q?ppeNzGn1Pnkg/Ev5J7kj1W1zDm+ZtRUSK7irMsZYIpCuGurtV1pxyORnZnyu?=
 =?us-ascii?Q?HVJgsA62rHolgmhiuePVoPKAOR5kul9nkEsOfMdkw+WVZH3a/rY4xJi2XFFd?=
 =?us-ascii?Q?S0kT8gNfMgrc8fAXft+CRHQ51hJRmsbYoUNn8AD6M3ns3oyYpFmDV51JVHwq?=
 =?us-ascii?Q?4uNFezBcxgJeBXf3JcYF7BkOxdHmlfHhvXNOd1L185G9wtiG7vePl0CqOYiK?=
 =?us-ascii?Q?1HE5IY21TT3h47AOVcBmVnb0OAXqx64CRL0Wfrp9UNequ4dzGMj14a+ky1xf?=
 =?us-ascii?Q?JJvaphdzAJuv3AuEyVjSVx1t8KavoqIGVAtsg07/Vsr8f1m+0sR7TvLoXKLI?=
 =?us-ascii?Q?qVYJVrxKetorORJkKUDR9p6dlH0pyk83it1+drmAgM39Iy2IYa0SIund6CnN?=
 =?us-ascii?Q?9OrrzMWzuux+JJWmd1p9D0pDm6wl3tEMzstbLC21atk0NtvQ7iSdopGbudlZ?=
 =?us-ascii?Q?8/nHjPpr0MOqjfdcfEZrvs+2TE3wdHoc+bi0MMg44sBwo3e245Xjnlj7PeUH?=
 =?us-ascii?Q?aSw28s8XiBhZo+Vm+MBkfporEa3xyAa5wf6To3OaP5fj2TKlV0l7nSf9tTix?=
 =?us-ascii?Q?iVWE35t89EQHrOCnoGh9TxZbUjH/Up0dkISU7khwKH/XvCdPzhF8N05ZK7kz?=
 =?us-ascii?Q?gt/aUpTRyAMZShVtR04xrTlg0rabQgm+KaeO9mbs53slJgSSGmti7cyn2Ms7?=
 =?us-ascii?Q?zizQHJJlDc4LEO2QpanJr8vGHQRhfEG9KxWOA4/UPWX9E41/SjsoMm7u71dh?=
 =?us-ascii?Q?aXkPzKvQY59R3nZ68WbTaMHkbCQyUpHQIVFqPulEcWGTwhD+Gbk3Cj8D5R6C?=
 =?us-ascii?Q?hs7qXaaM+taaXdZEcGcCLIQph0Z9pNQLNph0vY2i9Jjw+917a+SBARTb9zy7?=
 =?us-ascii?Q?6v6gNg2l2zvSh0dGNh5ehfI4v79uOlih7PtEpgP89hFP72EjMs3lpMzO4So3?=
 =?us-ascii?Q?E5dkeC6bidPg1yCOVWaFRVLTif8t3W8VVxfoTufSUN25vKxsXhu2BHjpdQZv?=
 =?us-ascii?Q?iwoNr0mNx4wIlwca6b3R1G5gzzL8joQw7C1Lv16WUGUOqu0oRmzQK7JxSgfu?=
 =?us-ascii?Q?ZGGF8GjOoQSuIPHaMLN0WlsUzMYRWKfeIXkPrKVmJmUstiMjQgt2YYo8NT5i?=
 =?us-ascii?Q?bV7IgJuLpLdlt/b1Trt7Yctb5udksPblHMmZmnJ+WBKVgbHaPaOOfVTKh75n?=
 =?us-ascii?Q?GmIziHzitlJpNjNrucGbJjhST8ATfa2aSpS3KClaSTFr8yV/cnQdLSzgYVcW?=
 =?us-ascii?Q?fJJNsoj76cT1AR9yecA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F60H5ebJbHacl/oVGT8MZAcTEfjRORdkWB5dRraq0uS7g/Tr+tSC4mhhLeLT?=
 =?us-ascii?Q?rGN9shbao3SJM9YwPpPftoFEUnSQICHt6I7XhNC9WNTEmlyJtWcOHZlskWD5?=
 =?us-ascii?Q?iubB1uy42sD42P7N2ZPOSPkDbU2/SXBonIKua4Ub67YHad0n+xgB6z9dFX8W?=
 =?us-ascii?Q?RECa8gmCReLFSw8o9+X9t+mBSgY5Sx71t6WLd72zxJHRZie4yZFIP9XHyQyK?=
 =?us-ascii?Q?j92Curo41sCJxyrhBEkb07spj55p5Rte+XfWBjMTKu/4byac0WuuVWlwHS4A?=
 =?us-ascii?Q?s8k+EW77PufaCcH1oKTOi7BqOkwVH0U66vdiYZYyPnD7LWj9YvNlF5RDJmO1?=
 =?us-ascii?Q?IhbpJab5P2je3vTaxiRYBq3EeLL4Bha1Vc+rOx160rHK/qoIr9W2bYcpFn6V?=
 =?us-ascii?Q?xrsc+2h8x/LzEk+/XmX+Ax9QKNmf0N93gEBTtGFaSQv+spROUmzM82enThs5?=
 =?us-ascii?Q?K9diO7U2TUJVg6IQNTNCrBdnd257KK5XKZDk6Qjj7LOaQpI82R3AYSf3Wjt6?=
 =?us-ascii?Q?5oj+sAC6ySR+pGBKR0QArspzwUABNx0CQ+V1OyOAf/RQC96JiixZdZ4lBLJI?=
 =?us-ascii?Q?oEL0XYaZRCp2UnQoVYXJLhzIVPjA6WIMBiisWlzAg72QmzPlFpVjFpR7Q7Ib?=
 =?us-ascii?Q?UEPBEuVnS1rfPVl92YgTL1oigH9cM2lzKlPOIKIwaacP+v89rgEJsK8toNav?=
 =?us-ascii?Q?3GLxOu6hUJcmciMovU6LpoJqy1kjwr+Xp8qbtaP7OSA6uxEKuj7upVnvvVzu?=
 =?us-ascii?Q?B2a67LBVxexZ0fH1XO4ZIx5mkxcVYlNwXiU4xAjJbEFdAUO5F4bw6hYrfi86?=
 =?us-ascii?Q?MByJ29GD6d57ZeZkLD7ha+0HOrVF0gsqkTotgtgfF21tj2xh2Jz8ipj/Wof6?=
 =?us-ascii?Q?SwaaEWVyYZnP7HUPb5JsycPUfEQXrVhdxTmjil0F82/IynEz35W/z1mXQENQ?=
 =?us-ascii?Q?sR+SIdis8lYg6bFyOK/UReGR/EG9E7kVcK8RG/NWTljwIRFPrNIe8yWvDS8V?=
 =?us-ascii?Q?zs6bEfcasm8bLsuiEjVoNLEDAL0vU6bp5h6aNXP5bjcWUsg7A5XbprKRQ1Sr?=
 =?us-ascii?Q?tmj+asmfU3VUvBkJiwjyy/theiHjZzvhm7JF1wQ8AdP21XmGnPMpsAvrv7n/?=
 =?us-ascii?Q?gpSYRv/NFn0+toeQ2W8rAnxpvYPsk17Lh/yHS6DK3nfj5AXiZ9pZ1w1NYfHX?=
 =?us-ascii?Q?GaNvR2J45BEzbJw8ussKvitaRkeMzOtv42JXwXgORYn2+6U51sMxJp5uYPhs?=
 =?us-ascii?Q?NbLqSc2IQraHIguojZB8xdQpfQgOzHGna07zLHSPVKqBMsHPbDYiXgzPV7fx?=
 =?us-ascii?Q?cxp+LfhTHydepa/Cvt1EwZl8TtSf09oVTDPaXZ2aSR+gR/R2HbdBQ/kBE3g8?=
 =?us-ascii?Q?rUU3aNrvWnJuXvcEeWCDXz9yaBr+oYwLb+jNT+ZthtfSeLm/Khtuwc1lbYtI?=
 =?us-ascii?Q?iYwP0a76ddmV2syKiYQgQ7kCoa/RkT6HyPoSDsmqlxHUnsUhMoF7hWH20uzv?=
 =?us-ascii?Q?g7gEq4Oy2J9E/6DGwhGBP8W1OQfV6qegrWund/CoqiZGKjo6fvqg4VDHucNC?=
 =?us-ascii?Q?nnK9mR60rCn/fmwYWT9J4r6AuPhkvc36KCdBPa1EGahDw8xBzZr5K3k3nDst?=
 =?us-ascii?Q?siB2QquaSPFcVK+8Rcmy9Rry0xHS6QgONTmlK/0+uoD7p9oiFTad1mi0zanm?=
 =?us-ascii?Q?HzQjGK4LdqmPk/F5tCHkto1lqqNj21agHOflny6pgV1aQfp8LBQ+/HPiKhz2?=
 =?us-ascii?Q?KREvkIuvNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d043b2a-b9a8-4dee-84fd-08de6d6c74c1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:02:51.8634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3iBLEPJccOBgUyhUDM6hlVXTNXzuLtVUtpoRip0qlxgELcIyrLIG2vbl+uCj+yl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16923-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 06A361453D2
X-Rspamd-Action: no action

While converting drivers to use
ib_copy_validate_udata_in()/ib_respond_udata()/etc these issues were
found, mostly by AI scanners.

Jason Gunthorpe (4):
  RDMA/efa: Fix typo in efa_alloc_mr()
  IB/mthca: Add missed mthca_unmap_user_db() for mthca_create_srq()
  RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()
  RDMA/ionic: Fix kernel stack leak in ionic_create_cq()

 drivers/infiniband/hw/efa/efa_verbs.c           | 2 +-
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 2 +-
 drivers/infiniband/hw/irdma/verbs.c             | 2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c    | 2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)


base-commit: d6c58f4eb3d00a695f5a610ea780cad322ec714e
-- 
2.43.0


