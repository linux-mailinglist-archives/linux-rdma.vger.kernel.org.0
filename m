Return-Path: <linux-rdma+bounces-2025-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7828AF2D7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C051F24DD7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48B13C9DD;
	Tue, 23 Apr 2024 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="arlkkWR6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4C13C9B9
	for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887645; cv=fail; b=TKNpnbHEF9XK+q8Pka9kCpkxDOJI6GnOhjPQ/4VQ1A6UpDbYLA3cOi2SoJJ4yQf5clkxxx6dEwu8t8vYs6djeTdhU1W1Zy8ugHb7TmjCYD5ydarMvKGSIKA58BCutYzCg1+lRlJ2l+VdiRMY9lh9AgDmw8x1EdXOW58E0TrBG9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887645; c=relaxed/simple;
	bh=ROQ9sYgMncVkbFYfcgbmzM6oJKe3odgUwM9pcXXdn4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQMLSllcs5ssPRkSmxLoElfmvBF2zuzKGbeqcOVaq7xTIKwpekKJWnXC1ZDCJ53UNDYA8hUeccGYp6LqED3aFIORPhBuphk0GuKILB3Sdn67fzDsqiwIsJd4v9Mot2/Q7j3b2V3Poht5PIrpFzt9g6snHyLaL7Qcj1jkzJaq9Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=arlkkWR6; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6QYZncNe3QYvxNKtc3B6ySG1rbvS8oMFyTtKc9mASv/CoPNFmzHJpv15cNAUyCdur8/ZzeftnpMSIY6zIOyMpSHul7RUldZ2LBAaeVYFEuYaPqDCmzemEsbxYCoeSeO1BwcDfxmxVvaYGspRJrPlDblX8bDI+xxNcnUaOk8NGm80x4S5Ou2iW3OjNkG84R0GGqWwYEkr9nfZ1X23UVkWgaXRywG8+nFXLy2MdG6x+PHJcmCj/B1QowRQ3qbku8G5NE6KY9kgwXXz3BVJB2P+/otbXQYmBL+uGvqL3VzScdtnc7wrZIIV4Avtry6JQlp2WlnDK95MIvofnqx56GNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROQ9sYgMncVkbFYfcgbmzM6oJKe3odgUwM9pcXXdn4M=;
 b=AGAaY+Icv9jNeH4KDqmSwsRjGpiWq+kKHQotiKvJP20Y3dox8bTYI2AMvkL1/55WRZyuKIb0eFrRpsO7YECu8ohIeh/WRXjiGpZRuhXXPZbdnrev2r85n0Tdq8hTuvmtw0MZeSQL0H6dyIWFGXZP+lY7WS7DGGowdf8HcK0DiBkX6zwuh2stYvjsIuf1OoR+c2QDOSdYYABxPdTI/Gj2fKnuf4PZ+tEVi5qaeA1a4IOs9JhrjGhsaCemFfNYHGzq8DpLidjSQP0HtaPjq+cIpNNpmIXHGRaCZaZA/jtlP+GrPo85T1MPso21YGKKG5ihUmxqnIsPcQD/L8yVGHmMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROQ9sYgMncVkbFYfcgbmzM6oJKe3odgUwM9pcXXdn4M=;
 b=arlkkWR6C6MlsNDLnouB04fwswdHi++Gfh06BDwPCxgvSetTL/9dQmaknRgaOOQ0Uzbh3izA7AW3PqhiUYj7HzL1xQsdsEsVHs5LQAngVSLce8n6Fb3ANhsswCRbn5qkD2dF2RDAgy8k5UFf1M/XnegzI/q58l+u2R1XW21v4hLijj00wDHDZ8MqXRF/s25K13N+ZVTuZjeotyt+6ilQld+nzR7G4jdlTZgFdz2WRkhnwN834UbpHSTzoeWYUZVH2sGcFGnn5c21LDTkY4VsWrg7D+awjG+7YcNc5I0oWwcwJbWwDiuJiOZCZY7qlfd4jBhF9LxIdXmCuJV8M+GEsw==
Received: from SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Tue, 23 Apr 2024 15:54:00 +0000
Received: from SN7PR12MB6840.namprd12.prod.outlook.com
 ([fe80::c07d:14d:c611:903f]) by SN7PR12MB6840.namprd12.prod.outlook.com
 ([fe80::c07d:14d:c611:903f%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:54:00 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Etienne AUJAMES <eaujames@ddn.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>, Mark
 Zhang <markzhang@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"Gael.DELBARY@cea.fr" <Gael.DELBARY@cea.fr>, "guillaume.courrier@cea.fr"
	<guillaume.courrier@cea.fr>, Serguei Smirnov <ssmirnov@whamcloud.com>, Cyril
 Bordage <cbordage@whamcloud.com>
Subject: RE: [PATCH rdma-next v2] IB/cma: Define option to set max CM retries
Thread-Topic: [PATCH rdma-next v2] IB/cma: Define option to set max CM retries
Thread-Index: AQHakMdxmu3dWro380uRtgACP0TgWrF2CCyAgAAClrA=
Date: Tue, 23 Apr 2024 15:54:00 +0000
Message-ID:
 <SN7PR12MB6840C6A4973B3E1885DAB971BD112@SN7PR12MB6840.namprd12.prod.outlook.com>
References: <Zh_IGG3chXtjK3Nu@eaujamesDDN>
 <700c19e8-ae4f-42f0-a604-9e33a9a94dd3@linux.dev>
In-Reply-To: <700c19e8-ae4f-42f0-a604-9e33a9a94dd3@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6840:EE_|DM4PR12MB5820:EE_
x-ms-office365-filtering-correlation-id: 91ad73ba-a635-4823-ca6b-08dc63ad976d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1VWREVjdFNSRzZ2dy82WnRlaGhiSnoxOTR3c0twMXpEcEgvUVo4dm9zM3Nq?=
 =?utf-8?B?cGNrd2xvcHNvU2NJeXdVMHREeGtZRlRlbG5zM2VVOWRUcUxXN0Fmc0NLZUV0?=
 =?utf-8?B?bHBjUnYzcC9wbWtpbmZQTkhNNWYwZ3ZQTDJ4UjAzdFNadGtRcVdiemtNKzE1?=
 =?utf-8?B?TGg1bHh1c2lDR3lmWm9HSU14ZGxzcUVMaTBIMEF6VHBRMERrWSttL2YxVDlt?=
 =?utf-8?B?T2hLcEFEU2U3SnNheDduM2RvVjNZaFR2RmY5L0JKdGNYMWl4THlsUVN5aGNx?=
 =?utf-8?B?M3FkVnJCSG9wNFFVdzNVbVJlTmxxMmV4dnpnd0lLNzNWaWNYMG1JVlFCcFVX?=
 =?utf-8?B?SFN3VE5BaFdnaE1lcXdVQzJrOVBYdC83dkVLNy8vemFOZ0RML3pPM2Rteklp?=
 =?utf-8?B?Y1JpK3NwODVkYmhEWFB4azByMkF4MlRlcjRPNnFjTXdBZjNJZlFJTjNsYTJs?=
 =?utf-8?B?d2ZITVluRWVOKzlTUHViMTZVQ3ZqY1VWeWFWcWRtK2EzZVd2WFZxdGpTWWpX?=
 =?utf-8?B?MkszZTVjU2orVThRSmRDWGRPWHJWZUdZQnUvUTZ5V1BsM2x1dHlGQzJaYkRq?=
 =?utf-8?B?SUtLOXdpbnp4TlEzNlZ3Mjh4UHd3bUt1d2dkUkkzZ21zam8wUCtnZ0h3d0E0?=
 =?utf-8?B?bnVyem9vTVFQd0hGN2NPaWF1UlVSSGlpZDFOV0M0LytoK3lwVDRlK3JINGx3?=
 =?utf-8?B?V2xVVDN6Tk9UUGZxL3pMbnluNTRpTmdJUDQrVHEreVR5MG5zT2NGVTZYWWR0?=
 =?utf-8?B?UDVmeXlmUitlM3owcUJiU3JxcXU1YjNOSUwwdnBkZGZWSlZwZlp6Z1VTWVZo?=
 =?utf-8?B?SW1hK3JRMVZCQ1IxRjdJN2JSd1FvUzk1UmVkL1RWbDRlZU5kTmtnNm9xNVdQ?=
 =?utf-8?B?UWFFdnM3ZkZ3anRNK016TEhyYnI3TXdRNEM4NGlxSkJjZDlMall3WHZkNWsr?=
 =?utf-8?B?NE5BMU9uRENrMFllRURQTzdGbG5UYlljU1haWEFDNHp5SW50VEJaL2JJSllG?=
 =?utf-8?B?SVhnNUxUUVM1aDA1RjVQK29Danl0UlB4eC81SFBWbUFranpWV1dFMDJjaytP?=
 =?utf-8?B?aHdES1VTUGsrYTJFWkZXeGswV2Zlc3FOdUhUUWpIcG9tSndRbkMxRGt3RDBx?=
 =?utf-8?B?NGl5RXl6NXB5T2ZpKzFnS0x5ZHlFMHNXQ25sMXY5akp3NFNhVElMTGI2TVBz?=
 =?utf-8?B?Nzh6S2VYcWdtMkJ2Q0pBbXFMK0phTThUQXU3c0Y0bjJTZWZXWFp3OGQrc0g0?=
 =?utf-8?B?Ty9IdFlUTCtZU0JoaGlHVms2dUVXbGN6RHVPTXZtZ0Q2RDUvQXorUDVxemQx?=
 =?utf-8?B?L1V1MDFSL0I3eWF2RThObHFOUGRWdFZ0ZTUwOTkrT0NDZ01sY1BTREszWTBI?=
 =?utf-8?B?U0lSR3pPV2xBd3o5ZkZhQ3JYNTBJS1BzMklKdXBKUTRvQWh1N2NkOE9xcmRV?=
 =?utf-8?B?ZXJwL1o2K1ZGNzdQVVhuSCtZK2VueHFyK0ZTajJaZ2RCL3J6MG5IaFJWeCtt?=
 =?utf-8?B?eDNpYWVnVGxUZ1hkUGVHVFZvd3ErNGt2dGdkZ3ZkNFlrcFRGczJWQ2NGR1F4?=
 =?utf-8?B?djZJYzAvMlFCTHBvMmlldmpJL2FvSE1MRjlLQTYycFlISWRmKzNoSy90amRl?=
 =?utf-8?B?cityRTdCWGVPRndzRDNrS1NpQ09VM0lrUFNMYUJFb2xCYVNrc3NSSGF4dG9B?=
 =?utf-8?B?YlZqdUc5WWNIcVNZL3ltS0wvbUpKTXFoM0ZCMVpJdTRiZHNZbSt5WTBPb1Jy?=
 =?utf-8?B?NUFiRVkvQUpEdUkwL3dteWpncUxtYVBOWTg1Zzc4M003cWp2cjNOQWVJeE1j?=
 =?utf-8?B?UWViWHFXK0N4VHMzVHRidz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6840.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1BkL29oU09OYWhVbmFsb1VFUTRKY3NSSEwyZi81UGJ2U3Q3Zi9mampaRlN6?=
 =?utf-8?B?NitHZWlZWEgvU25kWTZtTXNDaFBSM0ZtWUhMT0pPYWJpVjltaFc5TzRDQzhQ?=
 =?utf-8?B?Uk5BdnUxRHRjek12dmNiYjJyS0FIUWVoZ1lQbU4vdU5SdDlEdDhYcXdUNXhv?=
 =?utf-8?B?dWtQbllBWmhzY2NBTzRoSUpSRXhoRUkxMnRWUG5QNmpxVEF5SjVSVyszazZT?=
 =?utf-8?B?ZSsyS21ZckQ2SjJOSUpGdUxWMVlMWGs0Rm1vZktUSjZqcTZmem43SWRHckZW?=
 =?utf-8?B?OEFZbmpCeVhPb3cxdzdnc1l4UyszajYraGpoYVVKYXpjVStWRjg0NFNJM0Nt?=
 =?utf-8?B?MGlQM01YbURLNnJ3WmJVYjhDbUtXNDQxa1ppeitGakhibVZ5cy9xSlJHcHVY?=
 =?utf-8?B?Zmo0aGFGUFBGalNpRW1pZ0pOU3V1cVNyKzlSZE8rNExxWS9PdXIzTVZiQ1o1?=
 =?utf-8?B?dDZmc2RId2ZacUJYT1lTUk9YMEtnMFVRYW1aL0gwNmJnS1NwdnJJTlZaNWFp?=
 =?utf-8?B?YmE4dzFCMXVJSFFWNUd6ZFRSQ0w2eFlLUzVudjRlamVuSGU2TiswKzVjbTZi?=
 =?utf-8?B?a2psODZVMU9nSnJmNWowZ2g0M3pCdTZsUVgxWGN1UWk4NUpKVHkwRVpteVdL?=
 =?utf-8?B?ZXc2ZXdyVTYzbGZuL2pGbEVwbU5ueGJ0VDlWVWIyRlUwR2tyQytDMzUrOFg3?=
 =?utf-8?B?S09oMEFpRWRrRVE4QWtqMnk2YVg4Y0VXbU9uaWlDMU9JdzZjbGMvNy9QZVBv?=
 =?utf-8?B?ZW51SEFTMi9vTC9nZ0VBOFZnSmpBQUhFbFdLNWlOdXRzMTFDa0RTdlJpK0pV?=
 =?utf-8?B?Vzd2VnZLeUNYK2V6RCttdlZwOE5oVFgxVmU1cHNlRGZWNTZ4THBqT0xiZWRB?=
 =?utf-8?B?UTVVVnFsQ3BsSXBlSE5rUVJsb3RBbDNaRDBoNE5xaER1L29uTHBKUUlDZk5V?=
 =?utf-8?B?b2Y5NVB4ZnZ5WVZSeHBvSjZnRmQ4N3Q0UU5CbnF6NW5JTCtiN3FiTFZ1RXpM?=
 =?utf-8?B?QU9MKzdSSHQwL3dXSllybTdOWFh1MDlBQitjOVlTbm56S1k4bUhYUmcvNytu?=
 =?utf-8?B?azkyeXFkV3N1U2tMa1RRK05pUXVHSFFCWDBTNkJGR0lOMFdSTnJYWERIMGh1?=
 =?utf-8?B?T1Rka3dKZFl6UmNQb01EWkZNS2JuRVlzWTNzL3ZkWERralRFNjJxbHhob1Fr?=
 =?utf-8?B?U1M2NHp5U1A4WnZBc0V4WmIwTmNJazl2VUc0aHpuWEo1TUFYbDRsZGFGODl1?=
 =?utf-8?B?ajIvaE1VUmhrVlJtQjYzWkROeGlxcWFENTZSenV2Y3JFZEtUbEZrL0F1TndU?=
 =?utf-8?B?TTBHMFRteEQ0WFhZMitKRnoxSmRUZ2xrN0NSYTVrcFFoOTZPdUgvTGx1Skc2?=
 =?utf-8?B?azhJTG9rTlBQYU5Odlp1TGNBQ3NYeWFmdTQycHRyYWpEd1VsUWY5T09oa2ZJ?=
 =?utf-8?B?M3MyOVZqeGRRRVVIMDdOaHF0K0FHNjg0cUlCc1ljSjVYSE9scXg1OHhxNVZS?=
 =?utf-8?B?L2tVeUo2TFFBWkxyVmNMUGRJajFMUmRjM2VyR2RmYTFvUlZSdWZscSs4NVI5?=
 =?utf-8?B?U0x1UldmbWlIWVJ3enRBaDBuQnEwZTkwN2xSTjh4elplclhYVVIxWGRONlND?=
 =?utf-8?B?eUd0eGhYaE5MaHRqejE2OW5yc2lRczZBVkl5dHNhMWRGVGRNYklOMHVSWG1I?=
 =?utf-8?B?WXAvYnIzazZES2hlZVBzVTNZRGRLNi9oZEs5ZERoa1VTY05wczNJNEtOelRh?=
 =?utf-8?B?MUpSUng2QWtSWThRWUJ3VWJzTGlSNXM0Y21HbG9ORVdFNWRRdzFEK29yc21D?=
 =?utf-8?B?UDFDWjB2ZVlnanNLUW42M2c3ZU40bTVacEQwS21ubWlnMUhvM1dMc0ZkQUpE?=
 =?utf-8?B?ZndKd2Y2M1NGY2ZQM3NhMHRVMGxvZjJFbERtdE1EN1NSYTlMWU1VQ2ZocHlI?=
 =?utf-8?B?K2YyNVNiVktoUjlkd2FRaGd5dGtXNWVBSnRuUEJ2ZUNBYThKbGxBemlNZHpZ?=
 =?utf-8?B?dEgreTUxTE03QVI0cldBcG42Z0ZtdEZYWGl2QmQ1dVpsMC9pdjdGdUNiRHBT?=
 =?utf-8?B?UlRYbHR3UnkwbDRrNVBOQVZmU2c1aHNaajVWT0wrOFFUSDV3S0NaR3dUbncy?=
 =?utf-8?Q?ykic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ad73ba-a635-4823-ca6b-08dc63ad976d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 15:54:00.0790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7h06ZdvhLDPL080wk0KXeXuPbEdmtK9T4CGRvSsGk6oU9PdnYcO85qyUnU9yh/uGpKkX1jeT/2Se/Nsf6/3jsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0KPiA+IGIvZHJp
dmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMgaW5kZXggMWUyY2Q3Yzg3MTZlLi5iNmE3M2M3MzA3
ZWENCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jDQo+ID4gQEAgLTEwMDIsNiAr
MTAwMiw3IEBAIF9fcmRtYV9jcmVhdGVfaWQoc3RydWN0IG5ldCAqbmV0LA0KPiByZG1hX2NtX2V2
ZW50X2hhbmRsZXIgZXZlbnRfaGFuZGxlciwNCj4gPiAgICAgICBpZF9wcml2LT50b3Nfc2V0ID0g
ZmFsc2U7DQo+ID4gICAgICAgaWRfcHJpdi0+dGltZW91dF9zZXQgPSBmYWxzZTsNCj4gPiAgICAg
ICBpZF9wcml2LT5taW5fcm5yX3RpbWVyX3NldCA9IGZhbHNlOw0KPiA+ICsgICAgIGlkX3ByaXYt
Pm1heF9jbV9yZXRyaWVzID0gZmFsc2U7DQo+IA0KPiBtYXhfY21fcmV0cmllcyBpcyB1OCB0eXBl
LiBOb3Qgc3VyZSBpZiBpdCBpcyBnb29kIHRvIHNldCBpdCBhcyBmYWxzZS4NCg0KSXQgY291bGQg
YmUgaW5pdGlhbGl6ZWQgdG8gQ01BX01BWF9DTV9SRVRSSUVTLCB3aGljaCB3b3VsZCBhbGxvdyBy
ZW1vdmluZyBtYXhfY21fcmV0cmllc19zZXQuDQoNCi0gU2Vhbg0K

