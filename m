Return-Path: <linux-rdma+bounces-4583-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B0A960C73
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 15:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4312833B6
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26471C0DEC;
	Tue, 27 Aug 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1v26dIb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28201C0DC2
	for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766265; cv=fail; b=s3ZzKBn6KA4b6U/SSwyOofvIOyh/rgU6QGKlObW3+okpCh8etlxl5UlKES5gcjFfddBkW3JWstouO7NOZGq/jO215Yn3wRqiNYFR52YCck4yePxf+t8TSLDB5bkZPhd46RT6UP5QbLnR6uJKjB4oyYTg7OXP+AdHR3DR+fFK0zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766265; c=relaxed/simple;
	bh=9FKSAJP75EgvoaxMxe5Qol/DxIdAgHxAN3CGTKkW4bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M6s/HREbmPB95x81du1cvx/g9EPjLA2/N4PquX+zV5Hjgf+w79k0wKaCTuKVv1EgpxbmfgbOo7wVkV9p6C0DKarCkZ8spfw1shv1sKLaX/OeyMJPqEe4g7ebFaOcVbrbtoV34yWZF7YzjHkaKG5yLe0H6/aQNxNnGohPAK6l7is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1v26dIb; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqYbC22B/MaZIYYTritFKAoNMxzrsAhwIrF9dWIJuJhqQ2rJepnzJendR2MOaGl5dXTr+JToDQrWCs44HHPXCCAuhQ8CqjfZrg88tz+y2QbeNzLTJ2rX042BhPZzHnplgj2xV4UbO8NEObOTk68vvJToWdc7typ4n/6w54t/TC+eXfeUjs6jdJFMUdg0Czw0WEz9JQJsGceVe4pGCxzmctIh0Q/prxkYbn8UEL/DOVjhOBJtAVG3ZV2cC/KtIMkJkOkxYVkCKfnqDzvMaM0D1+KNJfprmo/nS6uS1uMa8lSc45iCB0W5M2iDnxR7NUXCFu0gIiOZDlpix9v16Uku/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vmz0sPXm2Zvs4JLQbCW3NNcJPx89A2cDbUgDnNQ6zYQ=;
 b=DXnnzfD3W+Kx3Oq7BRNQ24Pa/GRAdXf7NuTBem8gR989wMV8E6TZljZZ18O0LD01CNYduzy0bEWtmRET5Sx713FsDZQL5TXSaeQT/0lEyWnU5o4WSlfZEXWrfkLrFQgxh8ZZTs63CJAwdU9nk3XHBOfdyHzNhKAf7rIf+Lfb9iAwk9aN7S9+mpZWSS29sXqKjd+R9V7gP1xYkSczWeJBIKOKfxtf4II3MwRbAdi3SOXEx6WNiYozH9mzz2qoLYtsuUvj3lNVU44F+sUviA1NDCoEn3fKxetPtL9vdyhJ61l1zlSTgAzIAWPEqN8yotells2iYcNbWFcMAD/ENxZGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vmz0sPXm2Zvs4JLQbCW3NNcJPx89A2cDbUgDnNQ6zYQ=;
 b=X1v26dIby3KqOebiOV5Ium9IswS5LYVfQyP3Wd2h2xSJ3gJxY70DdqbHOyQArdRFCf7EhWLe4wtg/bCMBPUWjteKDrXKpIi/rg+4+zTavVrcpzDfwJZrlFPcsI4bbwHoDTqESV2bJM9MdsyxFmtWat2MNXa/PSyiFi1nbfMFR5B/roANB0QsVyERS7VtEFYchSQdGnBBAjOamVQdT5h7Igx/RCK3GPBRXfL/mnGG+FxhPR4Z204wpzSyoBfHMrorVxGvuHc6Q+y+EQBYQT7ZXQS/Bu8zNz92840jIXKGNw+RSa8+opig96vrhOpaCtop3V1fGXgS7R/wNdaCYu0qDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 13:44:20 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:44:20 +0000
Date: Tue, 27 Aug 2024 10:44:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next v3 0/5] RDMA/bnxt_re: Use variable size Work
 Queue entry for Gen P7 adapters
Message-ID: <20240827134420.GA246941@nvidia.com>
References: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BL1PR13CA0250.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::15) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1be74e-f035-465d-83d6-08dcc69e5a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E4BxRiMC9kTws0EamXbdcBURQoPdYSE9biM4TpJZ+UuwrxpCrUkBDvuyN/qA?=
 =?us-ascii?Q?HUHrcOBGibnCpD+00iGB+Jn4k32tFiR3SX4QmvHTBCfkCbbIBq9C5a4eL8dc?=
 =?us-ascii?Q?VMsgdjhwRF8tCWJWHEbT1m66DeiK7X5BTLSzrlkIsTU7rbTY108eDP9v0cGn?=
 =?us-ascii?Q?1rRJEW2YCMnMcYeC0kvzuYO+tnHrFPv0yBvKawZlSIxFYauoPJkM1LTXBf6f?=
 =?us-ascii?Q?wawkjgYb5HemOpIrMtn4mISN0YO2T90Q36ufNmTFI4uEK72qGKHM9787IvSi?=
 =?us-ascii?Q?8Q7cQITBJVTaXpda+/X/ibmztrXn98ysovtBiZeWQj9kW7ytBAsiBFEZnswK?=
 =?us-ascii?Q?mohaKDEvrHQ1HSJyJvbMOGJv7w7yEmGXG8jkHKAJJ/RPDl98SDCB4jqzvr6v?=
 =?us-ascii?Q?WdrGL7hjmmdeZYUZ7GQNYmyrBvEJtDx52jg+/1Vov8eQunbBJqJ9k7J5olnP?=
 =?us-ascii?Q?EAswqLNg2GbaUlwYduSGpqjtci9LrNPRnaoiiIMeueMDopOFaenzRkGF5h9c?=
 =?us-ascii?Q?5VYzH7gBs+ydfK/hCc0oz5YaLDU581XToJnhMFqvS7w5TgbPi+7HOhjn6vpX?=
 =?us-ascii?Q?4/9D5WMnf03VhS+qtgwdYYYlTavKvYx5j5x+NmkcN3uEMtt5PKtmarGUm5z0?=
 =?us-ascii?Q?Rd2e12LWXZHTmb4ouX9xRJKPqKhUd5UDXL9o58OuOMpg/oUgFPR7Ixz/1hHz?=
 =?us-ascii?Q?JxZvuHBBruQafQjq6z0pDXXMsobzn1bQwYBrFHKDKqgI52/C442S1nN4xnl9?=
 =?us-ascii?Q?mL+FxSnquqeti3MoWVsRFcQlXox9jBHNckryuyXe5oYDJ8TxYvvxq0bjDb3d?=
 =?us-ascii?Q?3mD034mlChZm0yGIjw2qrn8T6y1Is9bUOKLnZjw1CqQJY3heNMY216xybSMr?=
 =?us-ascii?Q?UyPAz91sJhcod5k39eiEBKoTnEWO+A4YWVJUgvx4zqtMqXmk2Ka3Hs9hgAHx?=
 =?us-ascii?Q?7EllKobDiay7rNBhV2q3OoTLP5AQIfw6l2us0dauY/HoXTZq53ui9Vlkc106?=
 =?us-ascii?Q?s9lp6AQ/ICHqmxsT+yhGjRQmcTL8u33wuq/lJ8Ftrgn3QAhLLcaSZcbOlKgf?=
 =?us-ascii?Q?c1MKM14jOrgvD7uOPnsi0Nc7I4D5YsRSJM1MvRvosBwM0yHF/2FSQkSD/nG4?=
 =?us-ascii?Q?bUXXwbOAjs6gLXVpjiXjasNfaj8+5l3Peb4ig0QjT4682kRVD2FZBZz/j0ae?=
 =?us-ascii?Q?ai3YDqoA36xMSew/xvfRG5Se5OkKIXEkHy916Kkrso3bI+K1I2Hdvn2/qU29?=
 =?us-ascii?Q?85FPLeEv8kaU79HuJsTs7sUm/v7qpbXfDP1WiT/E2QZ4ZAKARpM53RgEqSV7?=
 =?us-ascii?Q?G4ZxLNUT35Abx9Ewmqed9wAD79qNGN72fgxY3ZTPoYR49A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nXSR6WoacXQDbqJkhalH70r0++ia0XdUG4LnYLPGYeeJoeqT8QYrezf5u+pM?=
 =?us-ascii?Q?za2A4D2LfnQRQrM+OxKpCFGVdVuNQsx0FT1F/vQYI31fylKo3gHb7o4/Zv9R?=
 =?us-ascii?Q?owEqv7oZSSh9GVDt4CPRgMJquek9IYzds5iS9KHcVP976No8kcJVgL4MYloZ?=
 =?us-ascii?Q?DiyNS2VKI2+A0t6uVpc1POG6wyJLHP7fiAQGgFW1wpSbCgF1Ad9zEu7YN1l8?=
 =?us-ascii?Q?0KKFA9BDkQdscB04unDapXUi8btTQ49l1OyWm3l4C+ziiBkWWjrKk+MAz866?=
 =?us-ascii?Q?PXPpSnGXiidI5UPzFHvN78tNyJjUt4HPj+umoHG2w79K3SaUuFHMJQ1XEJEI?=
 =?us-ascii?Q?rRez9IRaYN85o2+uAe8Zl5ZYfi+xPu9YTPscrw0CkiqdDu9M0ZcniZsQ2A2o?=
 =?us-ascii?Q?C6DAHDW1Kd79J49wXgEW5EGGjC1zO9zVopOvBnXdAwXNtf9Z2UvR9p9qJpdZ?=
 =?us-ascii?Q?XrPs0E8D++BJ+S3OQ1CEMYqfTqr05Z/ujWy0OcRVwa+r9huXzm3fkkllQE/4?=
 =?us-ascii?Q?WsVIEZFbxAe83wG/SfccKIk3VI6Re0ALhiqQ9aTrIImhYFCUqdvSIXCHcblq?=
 =?us-ascii?Q?BvX7HlA2tqVA9vngTlC5Af8GLX8kZc18x4OkgehOrajT8I4AdbuZUxoOOdXw?=
 =?us-ascii?Q?Ucz4x6TctaxVWByHwiDOpzAzm5SYRfZWyaEqOPsAV5ZOL4/X2I6HmVVrhqL2?=
 =?us-ascii?Q?zg3ztFSA85+/ukSphxhZ5MlG72YUi8vsoar9bVU8v3FnANvZ2cdGea2vsG/b?=
 =?us-ascii?Q?Lye3dUbzAkPzeo5Zv0KFA3ToCzL3dikefpjcCRbeSGXzVxR5T0AJR/hpDQaN?=
 =?us-ascii?Q?ofxl1LAyvjlpnU8zvv36tcYu2GxckVKayNOxoqMKg5JYsEMhKkQ7v23OneLE?=
 =?us-ascii?Q?kaAiZeppz7zRCe/bcyRGLRPqqJoHRl5UdjS40R37L/SRO1g0pKbZnwHBqhq1?=
 =?us-ascii?Q?PtT94c2IrVZuuW2JS1KsOx4wank/Dd92pSGqFyRlCTdlL4LkrYFaEUXSKs4N?=
 =?us-ascii?Q?AyDGRg8zxo8xCoOV37Wimk/Y3ENs1mlx5hEEswX8Fs91C3Tmi/KZSQmHtKZF?=
 =?us-ascii?Q?+Ybi2pX3uUj8sitMUHwodCPpTozHvFa5prkAoYYUuitzfMYsJwsUGUlsrW9o?=
 =?us-ascii?Q?cI+OyG8ertzEWAezu6eI+yPILLa34RqBB6o2JbX98K9p4M3AvgSlGQWxURw5?=
 =?us-ascii?Q?w8HBgBygPn2927ptqrLFdgp52i5GdCB3tD+CL+o63r3JcoC+hAaPsQ2Lhqdo?=
 =?us-ascii?Q?o+9l2AMal1Iwl7P8puik7phZ98aR8tzii1ylBcfJFivSXxYAcCQcYHAhO9D0?=
 =?us-ascii?Q?qZ4eTI0xQCg1JVysxhVN8vJfobHAdy0+txyX3Ny8r+Z4UY2YT6bB9QTcgv0P?=
 =?us-ascii?Q?Ua5P58IT/oDMI5BUIVWzf/8azG2kSoCbPyuXLVS/pI6mO6kisQO5Det3P8Gq?=
 =?us-ascii?Q?OQqK+Qz+34erTIA2N4bb59KsklyRV2JejtGKuSHk3n8fH34NXkpPi4+4ZmYa?=
 =?us-ascii?Q?ArnW7h15UGxGodVaRUMrj324mR+rSWCReymrPoLefY/v82PobnfxltJh2zbX?=
 =?us-ascii?Q?ckMGC7scIMX4nIDc7r4OAPejwnOeRYrixQEtQqDL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1be74e-f035-465d-83d6-08dcc69e5a90
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:44:20.7701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quSwzAl5sa0RLhU6+Gahh6FG5SU12SjxBuPBIvPukwnQuAWoubP0p/KCYM1a34WT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186

On Sun, Aug 18, 2024 at 09:47:22PM -0700, Selvin Xavier wrote:

> Selvin Xavier (5):
>   RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters
>   RDMA/bnxt_re: Get the WQE index from slot index while completing the
>     WQEs
>   RDMA/bnxt_re: Fix the table size for PSN/MSN entries
>   RDMA/bnxt_re: Handle variable WQE support for user applications
>   RDMA/bnxt_re: Enable variable size WQEs for user space applications

Applied to for-next

Thanks,
Jason

